Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFC4C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205582081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRH32Gto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205582081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeKFF7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:59:19 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36797 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeKFF7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:59:19 -0500
Received: by mail-yw1-f66.google.com with SMTP id h21-v6so4235191ywa.3;
        Mon, 05 Nov 2018 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ku5Q5Ji8q11IDpnx74nPJ/BUIL3r1T9n45MgKUC7TVw=;
        b=lRH32GtoD62NVj/I/eAR8qSmXoXOnwDfpGTi939VY9zVuPGjoxalaWYxE3Aho5Abjv
         Nvoatw752RopFeORu9a/+smR6kaYwiSracChgpKKCQQajHsaPfq4cjTDSlWs8vuAzu3K
         5F4QbMPEdujwF+0LaX693y+4UbccoJ75t29tGo911jAx5hGX48pj/tZmsp7v7gBdeJ7b
         5Qnb2x6oTFUg0J5Ax8cN4LwXsfliI2ZTnR9i4tbfP7jPH8XDEFwD2II6hKTc8JegHTcS
         1MJYC7JqtFBQgb8i2kCV/5Lta7OzdLGi3JUZS0Xt1wswXsHLq/HwhySQIQkJRGcguMaj
         /n/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ku5Q5Ji8q11IDpnx74nPJ/BUIL3r1T9n45MgKUC7TVw=;
        b=hWWdlyDOfjhP5sUSaDhgUW4pTGcyoqv/dJZHO1c4aidaQ39k7ZHwZ5HkHFMW6LcxHi
         2C3r6Bezulle76w/5Cgdiaonw1nlCqb/bFbpA447gd4Ds3hczj9kdSGswDod/Ngqc0ij
         96/otLYy9AVxJE9vvMTZ8T2cakkBF7ccgg67e7CGcM/V/gydu7Plf217c6Hg41uJV+Qp
         BsR9onCYpUbU7eH8s5Y16FNxNqefHvI3AaTgqPTTSfDAmCmt1ERmlR9GrvxZpPsxl03x
         jS5PZayhF9w6bb1M5MSE2hNm/2EZkpo5xEsF2JWW00yS1QLZOBxpxwqAFtjOUsIGezze
         2k9w==
X-Gm-Message-State: AGRZ1gLZT0fOUliU3vZJkbBVWiuU0U3GeRbkHyjBCwc3n6Ok+H1TLjzA
        I+UBll0JgO6Pm47k7h4Sksc=
X-Google-Smtp-Source: AJdET5crOG9opN7soEvFPw7DqJ8YDMofXUnZJlkdtnHj1tdfJINho54gh4K3BFCRBRYVBCzIFdAXnA==
X-Received: by 2002:a0d:df95:: with SMTP id i143-v6mr22058459ywe.349.1541450270301;
        Mon, 05 Nov 2018 12:37:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id y132-v6sm2470986ywd.67.2018.11.05.12.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 12:37:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM IPROC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: NSP: Move aliases to bcm-nsp.dtsi
Date:   Mon,  5 Nov 2018 12:37:42 -0800
Message-Id: <20181105203742.7181-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029165524.26162-1-f.fainelli@gmail.com>
References: <20181029165524.26162-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2018 09:55:23 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> All boards replicate the aliases node, move the aliases node to
> bcm-nsp.dtsi and add all the serial and ethernet ports such that a boot
> program like u-boot can populate MAC addresses accordingly.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
