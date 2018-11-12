Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C459AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7456A22504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH6gP+bi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7456A22504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbeKMGgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:36:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44012 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKMGgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:36:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id g7-v6so4854088pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jEJbFZgi7RApaRnLOfsGClFWnYSe6+aMVgHJBQl+8B0=;
        b=gH6gP+biTVnYeH2TRpw/c9nfOD7/keP5teM3lL93JbWSuR3yJWrZljXcc76lRcV+fR
         UGn24EGQ6nwktZojsK1MA0oWnIKtF07wylNGOpVHz4dsa2h/FzCvif3R0GiAUrxIfSCa
         GbBFbke7AeTpv5+vojGztMC/TPlConDgO69g7dGg5FPa4j7AAQ7kxLwqYuHa34Os4ilF
         ihwtWvWQnMq5At0Z1Rshbe+90n+Fr+eetLly55BbEwPIN8IV66iMwOKfWtWeOi9HC2St
         b1ZjuhEvOqyjTukuVGGzsN3PkJt0RgLEGIL0ifDQgHnNBaTNK7xPUNcQ6X9ln50tykJa
         rjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jEJbFZgi7RApaRnLOfsGClFWnYSe6+aMVgHJBQl+8B0=;
        b=bJM0jz11729Ncnn8W+ltM3TZl3pxRwuqgbc4OAiT6zQHBETvJXQge6SOckeLMznl2e
         ztYlVpo4hQL4UHM1u1IZ3FWVOtVSraCSTLVWK9JfZjBiAoaKZxJBUzzIwCtEkJxLwOGB
         oiXIq2D5YFSPcS53/LdWStCxwQ84wQdz5+XDs1KP10VTGN7Mal1qYQgqYMibsOny/pdw
         7SP4cEXzuh+gzU8uUe4WKdRgBf/q9F5k5J7LHBnndTT5GQF4bB53L4vHlB993LhHDR9O
         F0A0sy4HBFbAhe0E84hrrAoImzuY6l2Hk92OLaI85m+tXwdJt1hW1qh/xO4fcG9lw4UW
         GZNg==
X-Gm-Message-State: AGRZ1gIcmqrxW4SCPDwhmSYEuEXm8f14cCGW9XpQzTZFWQtj2b1BKTNN
        HBSC4tCayJkm+g02oj4eqvc=
X-Google-Smtp-Source: AJdET5eTtzxHzhbvEokHlVvYrsGgBLn0cQRbFM+jk10MGNzd0ZeLg+AOpYILdmC34Z/uR90w6KPbQA==
X-Received: by 2002:a63:eb0e:: with SMTP id t14mr2138291pgh.445.1542055276696;
        Mon, 12 Nov 2018 12:41:16 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v2sm2288904pgs.0.2018.11.12.12.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:41:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: BCM63XX: Enable reset controller support
Date:   Mon, 12 Nov 2018 12:41:14 -0800
Message-Id: <20181112204114.4928-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181105230920.26270-1-f.fainelli@gmail.com>
References: <20181105230920.26270-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  5 Nov 2018 15:09:19 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Allow BCM63xx to compile support for reset controllers since we will
> require a specific reset controller to release resets for on-chip
> peripherals.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
