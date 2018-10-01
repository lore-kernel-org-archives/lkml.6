Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18081C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CEC2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksXbaE2W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CEC2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbeJBA4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:56:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41940 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeJBA4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:56:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so9814087pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NsF1JNdImeN+OxPPCtci4L4IfShqkMEo9aGKjzgEQZM=;
        b=ksXbaE2WDevbsugQqRmzjGgu/x1dq9NVqSDVJAEdQ8d06XTOzKRGVNh981sjwJbRUT
         129uoCcfZkyeBTN4p4BbH3+ZdGtDwopAqDsRLBmKFFOS2l+p6BeyNW5yYTf8W6H5iqjA
         U47LGF9BHuxo867FJT9eMUdDBNGDk1N+DIYPpMKdnd7D4Sne9GibYQyau34Mqh+5l9ZJ
         kCbvRCHz9Yrfn0k4MIDJsn78fY4Fgd/XCg8TMofRLoxDEMfGBIKKeNQYJZwjeszBssEU
         jsJvIFUYCiRsgUVqHHpyDLJkYS4HyHLGzQRHnNb7v2Yps0VO4AfGfk5RFVpnTi2WWimr
         HQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NsF1JNdImeN+OxPPCtci4L4IfShqkMEo9aGKjzgEQZM=;
        b=htQp1IRethCHGdIFbgwes6pAmvYucdgIOMEIex+bNw03FfsYf1vxX0KyRlxVkaqw0E
         Q0pdm6o9YTKAwy4DWksL+h7S+d2k0J77ziv1pXCo7Co9sxg4+Krz+WQ5EEY664Mki5M+
         a1XGzMeLdDg8XzgPeGt+eaJmwNfaKCQgaovdchwgY5MEvIRpRt9IEotfEaicTSoueaYC
         iiM6GQd5JfnBy/LB318ujhnAq/ppfqMtiq86PYVCkc9kKa/k52T6Pa3TfolaOZqYlMCj
         PnsBhVyDgb/d2k7eDyYtTaIuopV9LTIN8ej2b0jo0hAXC3jHbsSTw4wmsb3fQjadg7Kc
         c5Hg==
X-Gm-Message-State: ABuFfojf+YFM8TIwvYAB3osB+SVvLH8cxCwAhkQldobOzyRHjwARCaSl
        3AHiqmY72MNcv75sSRkOp50=
X-Google-Smtp-Source: ACcGV61fJ5z/kxMjAjItRDneCznJZiTwVkB35FTWofDehzhIPzEv29vOIOWkaUPXH6pK3YS/j/36Gw==
X-Received: by 2002:a17:902:4503:: with SMTP id m3-v6mr12835163pld.168.1538417853957;
        Mon, 01 Oct 2018 11:17:33 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id h5-v6sm11496431pfo.135.2018.10.01.11.17.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:17:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Rob Herring <robh@kernel.org>, Doug Berger <opendmb@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] soc: bcm: brcmstb: Fix re-entry point with a THUMB2_KERNEL
Date:   Mon,  1 Oct 2018 11:17:16 -0700
Message-Id: <20181001181716.31870-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927192711.26455-4-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com> <20180927192711.26455-4-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 12:27:11 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> When the kernel is built with CONFIG_THUMB2_KERNEL we would set the
> kernel's resume entry point to be a function that is already built as
> Thumb-2 code while the boot agent doing the resume is in ARM mode, so
> this does not work. There is a header label defined: cpu_resume_arm
> which we can use to do the switching for us.
> 
> Fixes: 0b741b8234c8 ("soc: bcm: brcmstb: Add support for S2/S3/S5 suspend states (ARM)")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
