Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D88C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4145B21901
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="NPtRoXUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfBLOCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:02:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36984 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbfBLOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:02:54 -0500
Received: by mail-wr1-f66.google.com with SMTP id c8so2817921wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCalz13so0yT9FLlCRV3yI401Qfqpo2SioVUk5Ytw+U=;
        b=NPtRoXUq4DLG2mTF5knAg5RoX+MMQUFH8mhBJahJNfCCfegveDPj8yW/tHkv/AqYqy
         b9ifMPeYVP4PXYmUfw4Q4uxxr2QjQ3JazFs62rFPGbU5gms7J90etQ+9INUJP/th9AFH
         lGaMsD+XUbqSylQl89lvCIZKUa4dZwZSKEgfM72Jy5CE91ITMMaKj1lf4sMPidzEsH09
         VOEocgkjoUiIfvH5SLkyEUxt4fGMOcL2+QMhyTjoa8NeZt4v7ETzmEaWrs8alAZ1v1ZY
         pt144EE2eOzy+4nXhq6AePfTqE+7qvSoPPF/FyUa04Vml8xYVOzMP6Ns92sUmILOt8eQ
         nyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCalz13so0yT9FLlCRV3yI401Qfqpo2SioVUk5Ytw+U=;
        b=G+DNtmAkn0ky0K6PMNMe1EIVSsu6T89DRTxjAukaNSrvxqH9OZ7tMnYjTMCvFChlLL
         fOSScBMhXUZx8qZLTC05pqPTQu3SpttOC6O0URi5fx5RFrOrOjIw1DuNY+LB6qLe9Mru
         TiQ+2c47reGb6IZbbcFaffj0tAGbU4r6cqH0LbHcm2GXzNKpwWuSV/g5cmW4m1VIo5Ib
         G5ylh3+Nb3kLWd6Y7kwyKUwr044KMHYINr7MttyVEEXnQxbc6xgeJkJRB+HtQ2//z1Ys
         uHKTprvwwbmqfXBUkKiepp9x4w4ZjUpbO4Kx19hIV6uQ4Lo/25/IZAirc9YR6EwL1WFL
         eSJw==
X-Gm-Message-State: AHQUAuarBwFWULOhi5hUkxhGxWI6HeVMYeiLacbIHHoIf/ETIfxOeBZs
        /B2opTeG242PK4vUrE7+vWM/iQ==
X-Google-Smtp-Source: AHgI3IZDn52LHL/5mVjOvk2xJLxnLENExA4jYF99KViHYy1wJhLSZqwXjQ5oAqhUphZCTDywik6dKg==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr2941271wrg.230.1549980172425;
        Tue, 12 Feb 2019 06:02:52 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id v1sm27309249wrw.90.2019.02.12.06.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:02:51 -0800 (PST)
Date:   Tue, 12 Feb 2019 14:53:27 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ido Schimmel <idosch@mellanox.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>
Subject: Re: [PATCH net-next v4 0/9] net: Remove switchdev_ops
Message-ID: <20190212135327.GG2881@nanopsycho>
References: <20190211191001.8623-1-f.fainelli@gmail.com>
 <20190212131443.GA13819@splinter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212131443.GA13819@splinter>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 12, 2019 at 02:14:47PM CET, idosch@mellanox.com wrote:
>On Mon, Feb 11, 2019 at 11:09:52AM -0800, Florian Fainelli wrote:
>> Hi all,
>> 
>> This patch series finishes by the removal of switchdev_ops. To get there
>> we convert the existing switchdev_port_attr_{set,get} switchdev_ops to
>> use a blocking notifier, thus making it consistent with how the objects
>> are pushed to the switchdev enabled devices.
>> 
>> Please review and let me know what you think!
>> 
>> David, I would like to get Ido's feedback on this to make sure I did not
>> miss something, thank you!
>
>Hi Florian,
>
>Why do you still keep switchdev_port_attr_get()? I believe we can remove
>it and simplify things.
>
>After your recent patchset to remove 'PORT_BRIDGE_FLAGS', the only
>remaining user of get() is 'PORT_BRIDGE_FLAGS_SUPPORT'. It can be
>converted to a blocking set() with 'PORT_PRE_BRIDGE_FLAGS' (or a similar
>name).

Let's do that in a follow-up.


>
>I would like to make sure we're in sync with regards to future changes.
>After this patchset to get rid of switchdev_ops we can continue to
>completely removing switchdev (I believe Jiri approves). The

Yes.


>prepare-commit model is not really needed and the two switchdev
>notification chains can be split into bridge and vxlan specific chains.
>
>Notifications sent in an atomic context can be handled by drivers
>directly in this context. Similar to how FDB/route/neighbour are
>handled. It will really simplify things. No need for the defer flag
>anymore and tricks like 'PORT_BRIDGE_FLAGS_SUPPORT' and
>'PORT_PRE_BRIDGE_FLAGS'. In the atomic context the driver can veto the
>requested bridge flags, but program the device from a blocking context
>(using a workqueue).

Sounds good to me.
