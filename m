Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7BFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CCF20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="zBRJQn/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbfBFNZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:25:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44200 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbfBFNZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:25:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id v16so5675805wrn.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SJqg9ZjXs16IAHgixuKgAZSKOEAxnW9ONoaD3los+Lw=;
        b=zBRJQn/RwXUIQje8xSLMFxDZvuDX6hQVYcwtiSXtcYiYn4kvBe6Ms89xmqpQZoEcKd
         1DItpKWxflXeOiacgKDvz0rVRUQEJpP7WPaUV274YmaHbru4Wqda+OoRjmV8Hrm6cTNv
         AZ5ZeB4tpNljc4NgNymr4DllXccyG7FvKd4uoSvSYKnReps/vcPFAM/A2YLlairqCjyZ
         eKvj4KQKudOwJTCDnMiq8yV9QKIi79n0e61xJcqxbY02Wf9m+I1cxjr2q/B6sUfRa1X7
         6hqeEMP8iGMAgdsNXGzxFjFwXFQg/t7g9vy6lHXvWRgvzKkYNRn9Fy7AMYooK5F/NJU1
         hfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SJqg9ZjXs16IAHgixuKgAZSKOEAxnW9ONoaD3los+Lw=;
        b=DFK294ed9K9zFo0v+DZ2ZrliF+TtAItMW5NXS4MoCZql+6lNLPQLmAk4eBYX133wJ/
         eMUeit8UODd1CKxl2FdXmj5FnGeiEI2iAOXgrnmtg6QjrAuFo/P41TJIJaS2THr/c7lH
         qfyOblLgI9YavJTuvx5YRIeCWXIxDDxjMt0C6nOnKytrNCc6R7SodZCC2mhWeMTR3+zL
         gq81WFSPAgcbEKxZ5oblJvQuFoKb0luA4MbAxaOUl0Tkw4nBxO895AR9WNT3h/8WQvdL
         pl85g7scnOOWfAyBivet0SJnwHlYytf4wesJFTkaZolS18qo8dAFSNOIqB95ITI4MVTO
         Y30g==
X-Gm-Message-State: AHQUAuYONuYfZWgBK+329wBXhxcSW8Qp4xJshIiFc6Nif4OLzQst9yaA
        q0BLZMI+l+RftiNK9TQtGXOmBw==
X-Google-Smtp-Source: AHgI3Ib+Mk18vFA3GqrTtzPNNm+qAahnE9G5VdA2tD/KPoXbBocVvqWbdVSB/0g3Y8Qe5KhlOQeKAw==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr7841286wrh.250.1549459530387;
        Wed, 06 Feb 2019 05:25:30 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id w18sm9787908wmi.12.2019.02.06.05.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:25:30 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:16:19 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 06/12] mscc: ocelot: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206131619.GG2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-7-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:20AM CET, f.fainelli@gmail.com wrote:
>Ocelot only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID as a valid
>switchdev attribute getter, convert it to use ndo_get_port_parent_id()
>and get rid of the switchdev_ops::switchdev_port_attr_get altogether.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
