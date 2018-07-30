Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A78213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21F720894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="mi8WsVs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21F720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731165AbeG3O6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:58:50 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:55487 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeG3O6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:58:49 -0400
Received: by mail-wm0-f49.google.com with SMTP id f21-v6so13124233wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1SV+Sz3QoYaLGozHdt6aVhmCB16MJUnrQtBNl7CnBVI=;
        b=mi8WsVs3dFfGmwToyoEHqW5BxQp9HcahSlI/tHld8LP5HKzPGTRYwq9XmG05h7H0rE
         ex6qER76yraqvkiQqN+N+37NVz0rrqvZLJFUKTP2ziJOdoig4S4KwSzFyqnOV3i8LBZL
         iS6drsFlQ9ILYiGAaLz/p/Y0iMJ4OAAhYP1JLTIMBr3xNmlSwdNH+7kxlCif13by0bRY
         7tjCJfQLJuRtR1HChW//vbFfQHxxCSFsrLTNFgFHY2CLL1kmZLr02oNW3i2mpz7rxZJy
         1NxUT6F5iF05riqINOns6c0XFsFNWH9Jx2YjeWkkHDh+tgCvhnq7mQKQE/0/2r7NneLg
         1FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1SV+Sz3QoYaLGozHdt6aVhmCB16MJUnrQtBNl7CnBVI=;
        b=M39HQwXGuTKz6bNd9W2I5rU7qs78p49+ryqTk8H633V1B+ppwVUHCzOCSIa0goQo7p
         iTHccFNyi/gK3+bbU3gY+kDpbn9mEdjz4SErtdTPMHoB5+qevjgB6f4iy9SJP4NU+774
         wb6e10QX2q6j8OMqu3xMrLKM6y79rLMFPm4nnaZZrUfp8D1L3wIr6fNZo6Oj2qQkgbC2
         17Pg0gV2ZJlICFS8GWIAmCty3Q7J+voBUwwWWTs62TvnX3VWfjsoLW4He+JuQcGYq0//
         Lw/k2geWfXRLT9GqSXetaKtjf+Tr/QvS1vAccH9Z4dlyHLXMjqgg9jcFwv9t3MC83jqE
         M55Q==
X-Gm-Message-State: AOUpUlGvYkU9qEdNebFpjrySCNMuZfBfJKpmRDNsHYrIQFM82IhNA+NG
        tinpI8pmRrCGAOQCI9dXRV8FHw==
X-Google-Smtp-Source: AAOMgpd51VEwBZYPIDQwYkP33fiJx2rrAbTUnYnl1zeHfh3p9nnRCkBYAS2MK02H1A4I9BYi6iUrXA==
X-Received: by 2002:a1c:5b09:: with SMTP id p9-v6mr16424838wmb.0.1532957028832;
        Mon, 30 Jul 2018 06:23:48 -0700 (PDT)
Received: from localhost (static-cl188134168102.unet.cz. [188.134.168.102])
        by smtp.gmail.com with ESMTPSA id t135-v6sm11050863wme.0.2018.07.30.06.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 06:23:48 -0700 (PDT)
Date:   Mon, 30 Jul 2018 15:21:07 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        Jakub Kicinski <kubakici@wp.pl>,
        "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [RFC PATCH net-next v2 09/17] ethtool: implement GET_DRVINFO
 message
Message-ID: <20180730132107.GB10626@nanopsycho>
References: <cover.1532953989.git.mkubecek@suse.cz>
 <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dcd60f25efe368ada4e0c035dc1d7612ab59132.1532953989.git.mkubecek@suse.cz>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 30, 2018 at 02:53:27PM CEST, mkubecek@suse.cz wrote:

[...]

>+/* GET_DRVINFO / SET_DRVINFO */
>+
>+enum {
>+	ETHA_DRVINFO_UNSPEC,
>+	ETHA_DRVINFO_DEV,			/* nest - ETHA_DEV_* */
>+	ETHA_DRVINFO_DRIVER,			/* string */
>+	ETHA_DRVINFO_VERSION,			/* string */
>+	ETHA_DRVINFO_FWVERSION,			/* string */
>+	ETHA_DRVINFO_BUSINFO,			/* string */
>+	ETHA_DRVINFO_EROM_VER,			/* string */
>+	ETHA_DRVINFO_N_PRIV_FLAGS,		/* u32 */
>+	ETHA_DRVINFO_N_STATS,			/* u32 */
>+	ETHA_DRVINFO_TESTINFO_LEN,		/* u32 */
>+	ETHA_DRVINFO_EEDUMP_LEN,		/* u32 */
>+	ETHA_DRVINFO_REGDUMP_LEN,		/* u32 */

This is a nice example of why 1:1 ioctl->netlink conversion would be
a big mistake.

I understand that for ioclt, getting lengths of various things is
important. Userspace can prepare buffer for next ioctl which would
actually do dump transfer. However in netlink, this is totally pointless
as the dump goes into userspace in multiple netlink messages.

We need to figure out the netlink uapi from scratch.

[...]
