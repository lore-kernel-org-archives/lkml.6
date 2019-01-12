Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDBBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A6F20881
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 10:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfALKl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 05:41:27 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56205 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfALKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 05:41:26 -0500
Received: from oxbsltgw60.schlund.de ([212.227.220.198]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDQRy-1gb9SS2V78-00AYP6; Sat, 12 Jan 2019 11:41:10 +0100
Date:   Sat, 12 Jan 2019 11:41:09 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Message-ID: <2056332188.370448.1547289669205@email.ionos.de>
In-Reply-To: <20190109235544.2992426-4-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
 <20190109235544.2992426-4-jeremy.linton@arm.com>
Subject: Re: [PATCH v3 3/7] arm64: kpti: move check for non-vulnerable CPUs
 to a function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:NkEVyuRhBB3+Giz5nx3RkR/JlGYzKYoBEsS86FgMRln2tnLFED9
 ryTHdaWRzzjpLkawm96TGiKfPb+AQPYj6wN9HLmuT7QjBHnAOBkELdEfIZabbb/lr4ZEysH
 ne7dqRne1/XIIotwjSawTQng41mD07ZJylw8gYwrYMXf2n1JbpEcwboB91eA5SYjm8E0OYe
 9vqGFaKviCNvvO6Fy06IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixru4GyGl/A=:Ks82qJrtapA+IE17xD8+Kr
 A9aF0bJMYKMl5es+pQJD1jVhAEVvT7RvUUcmr1pDNq9ELhzjHoqYNttDm4pQVs72UyeSq6cuX
 My7gj23KxHXcYw6yZVTVSqoGRdb4mIMbkkRP3QZl9EaO15ojNeLan/PjDIKaHl8bjCcs/GJvO
 PicVVR51UgI+1mxBHekUA0r6N6B7t0AmCX/FJEJTkR5V0e1bR8J8Ot2eFcomfCgRl98Vq+sn5
 q78gHWouNn5OtpSEjzzicyux1ZBtz7+U2ML5kqceomU1QyIu4BhFHue+LeoKl2OOCLahq7OBt
 Srxy7Q917PSLOM9861fj6srqGoMv4wUKXmAj8xUkt8fJKHQN9JIppxC1IvjKuK0U36n8xNALj
 UVmtHxBoy+kZDtjE7PxFT2KwB9L1JqnKKepAYVfBuz8ayihAqrLB0rkucyoR5ZK0CfTe4b8a/
 /9Fz82ODDIVuoyCFL+E292/eLZ82riBAO6lp1AtZ5hPAbkWNe/A9wdZ2M8VplEMfyhvyWmwse
 lW5wHVdipP8D6NjB2EujPUYt8QhTtoldbGc8csgFtcIr3koijYs3z/F44Wyx/ep/nwHDeQrXh
 +bgc5oFRbE55R6brSLspFsy9eSQAtuD525tLp8c7tZfRrl3tH0XtMY1QzmBHZ1+nDLmvaP2hk
 C7WMYobMZ3O8MB14S79hsThXW/1avWdTxPCqMlq6aZtdBmOA93M1QtRpa15bBvD5rdmCXEAd0
 Rh1Iujm/83k50cfMhVgl9gHmWgT0PJGksFqC83KZokY9aRbyxYU5MeHSDds=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

> Jeremy Linton <jeremy.linton@arm.com> hat am 10. Januar 2019 um 00:55 geschrieben:
> 
> 
> From: Mian Yousaf Kaukab <ykaukab@suse.de>
> 
> Add is_meltdown_safe() which is a whitelist of known safe cores.
> 
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
> [Moved location of function]
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

i only want to inform you that this patch doesn't cleanly apply against linux-next on Friday.

Best regards
Stefan
