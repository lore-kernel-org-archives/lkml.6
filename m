Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87996C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F0C2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="F6om6Y0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfBKM3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:29:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36492 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfBKM3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:29:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so2068567wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mlhh2fX40wBrG0mRXheZvsJtp0gFuVDs6ewg4B7vl/U=;
        b=F6om6Y0nbW3kdjAE+NUBiPnCfFJILLtb6cFJhITu5BQXWfCJcXD6WmQ9nd5n9N3NXO
         yKUt5Tt4MZptNZVs0YzoFWJ4GvQWGVuNrx8Wl6b9M9TemGoVImlE2zt9zyVEAZgkxyR0
         Zar1XBpk4g8RhoQe67JdMUBppvzxS3z0xnKzVLcVgF+RlAA1hH1R5DmGsBiMsOivjfdz
         j7kCsq6iRcRKy3TC2mjgPByIxjJy40fPUM9Dp2je/WxEJ5H48qgbnDx9POd82/3D85Hr
         IPMykeMgNjhFkg/G9RI4fm57UviTwVB99MHEfyk+igkPcgoq+TPX7xMh97+9sqr5PQbs
         RwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mlhh2fX40wBrG0mRXheZvsJtp0gFuVDs6ewg4B7vl/U=;
        b=U35tHUvMlnb6yYwPyHHs7Xu276mWXGr9lbKJo71oevodw93YdtyuaadOHiHL+FS1NJ
         vJQDkWrHopoOv8R3Fs+Wya64vSCzYcVQMpZT9bSxHv3XW/q+zNOUcqkluaodhmrj7haP
         biLTvjABv8/5IZnfUWkwXrL0dQ10gkIj5dc36ST/UGVwjyZp/Fv4JJyEQhKZMm4+IARs
         m1ekmHMwVTIRaBj79wtalEA7oD9tMk3wp7KtwXdk4/SPxoJP6o7SnwnzQnOldEXEXOXp
         XzoulENMaiJv2/wyV/BZbQC3ueZzulo0E0zKeF/rJoPPqC5wA6IjD10Py+/JvuaNtDCK
         ShOA==
X-Gm-Message-State: AHQUAubn7+1tzJayAaISbcKYrovllFFr7WO5wRZT7ZD6NiDPujiN/QI2
        auCxhIGrH5lKid7laq67ELkPGg==
X-Google-Smtp-Source: AHgI3IZblvL3BXn9aUoh6Q3vPf4pc037G08nqkTRcoUKuSW3bqmjPc2wmxdnAOPPJtKBq0ok0Jcrig==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr5208378wma.114.1549888139264;
        Mon, 11 Feb 2019 04:28:59 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id y1sm13317544wru.4.2019.02.11.04.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:28:58 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:19:36 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 1/9] Documentation: networking: switchdev:
 Update port parent ID section
Message-ID: <20190211121936.GD2251@nanopsycho>
References: <20190210234007.16173-1-f.fainelli@gmail.com>
 <20190210234007.16173-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210234007.16173-2-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 11, 2019 at 12:39:59AM CET, f.fainelli@gmail.com wrote:
>Update the section about switchdev drivers having to implement a
>switchdev_port_attr_get() function to return
>SWITCHDEV_ATTR_ID_PORT_PARENT_ID since that is no longer valid after
>commit bccb30254a4a ("net: Get rid of
>SWITCHDEV_ATTR_ID_PORT_PARENT_ID").
>
>Fixes: bccb30254a4a ("net: Get rid of SWITCHDEV_ATTR_ID_PORT_PARENT_ID")
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
