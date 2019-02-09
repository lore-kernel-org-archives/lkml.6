Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119A2080D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="zk3dmgVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfBIR5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:57:44 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53990 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfBIR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:57:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so9369156wmb.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Feb 2019 09:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBmQQ1O7J8LbKAZCDl2r69Kd7ZgpGnUXBZK2kTWYOxE=;
        b=zk3dmgVrbP/bOEEKkJTpkmn+zwOgJbKdlzrWMLK1A7CU8zXiMMNoii5541+Y9yGkJK
         Jlx+B8OlDiqqJV1AVwIhlN1F7FkI7ZWlYNgph0LtFZVxM3mEx1k9OrMhOUud6bmC9eAg
         OATkRQzEU7Fe1YIf0CGaS7eFsjfYFTEECI4o6RDrwbrUL4qIqcO+45pVQyvMoPyfxVmg
         bajhQdM3gkQW8Ucyrr0Wj+NyCIqPnh5vLOKByW6vyzyRBZfP3WDubfvJr6UGUWTAVLbI
         nm3mXRn8k84Eqo8CPASqQHUXJC7tyxoyKAbWlOYHpRlb/ay7meqhEJfmkenWFADIZQdy
         xIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBmQQ1O7J8LbKAZCDl2r69Kd7ZgpGnUXBZK2kTWYOxE=;
        b=STjnrpQLKCWOshCYxVptN0r6+ggBvlIVpf4TluOLZnhPgHfgS1Z6NDwmMILJugVaDz
         2tcT3aMtly4fOOqsJazCVGjB/x/3zF2nziONUicdV8Y1kVr/iTMjqDb+5jy5rZ+CBdr0
         oPp5yzZJmynp/kM1tcCXWrJCLO37mSm5OZd5YLGvRMgqiaH0ttAteWRyzDN02fYEMWS1
         n88MJOl+xU0T2yMm6g5B0P0bu4xK8WMy5ZL8ze56aXaIgjGwMfkN/jjUBfuZFq9JkNIz
         y196rN3Qao2qdkLmqjKlFcy4yOxCoVX5QGa5ni65G6TsvGTln6Ft53NT40JxcG08ilC4
         HKGA==
X-Gm-Message-State: AHQUAubMVSyLFAI+RcqmV6BcTGlkPT74zjBB422HbQ9VPZh52lTB7kPX
        XcNqHZbChaIkqSigPMfF0d94bg==
X-Google-Smtp-Source: AHgI3IaTNX/kVAlSJGteyBeLiEdQpdbOGeIrgDQPjJl2npWR2ysqs0SamQ3DvheLlAseLl8WhbCphQ==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr3388010wme.119.1549735062113;
        Sat, 09 Feb 2019 09:57:42 -0800 (PST)
Received: from localhost (ip-94-113-219-55.net.upcbroadband.cz. [94.113.219.55])
        by smtp.gmail.com with ESMTPSA id h17sm386984wmb.29.2019.02.09.09.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:57:41 -0800 (PST)
Date:   Sat, 9 Feb 2019 18:48:30 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 04/16] net: dsa: Add setter for
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Message-ID: <20190209174830.GK2353@nanopsycho>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
 <20190209003248.31088-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209003248.31088-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Feb 09, 2019 at 01:32:36AM CET, f.fainelli@gmail.com wrote:
>In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
>add support for a function that processes the
>SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute and returns not supported
>for any flag set, since DSA does not currently support toggling those
>bridge port attributes (yet).
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
