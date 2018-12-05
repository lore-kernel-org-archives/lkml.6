Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C65C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4259A20851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4259A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeLEHAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:00:02 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:53012 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeLEHAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:00:01 -0500
Subject: Re: [PATCH v2] x86/build: fix compiler support check for
 CONFIG_RETPOLINE
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Meelis Roos <mroos@linux.ee>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
References: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <50d52efb-622e-e5fc-558e-d1a08de902e9@linux.ee>
Date:   Wed, 5 Dec 2018 08:59:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1543991239-18476-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.12.18 08:27 Masahiro Yamada kirjutas:
> The easiest fix is to move this check to the "archprepare" like commit
> 829fe4aa9ac1 ("x86: Allow generating user-space headers without a
> compiler") did.
> 
> Link: https://lkml.org/lkml/2018/12/4/206
> Fixes: 4cd24de3a098 ("x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support")
> Reported-by: Meelis Roos <mroos@linux.ee>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>    - Revive ifdef CONFIG_RETPOLINE surrounding the KBUILD_CFLAGS addition
>    - Rephase the commit log a bit, hoping the cause of the issue will be clearer

Works for me - first it did

scripts/kconfig/conf  --syncconfig Kconfig

and then started compiling. The #define is gone from include/linux.

Thank you!

-- 
Meelis Roos <mroos@linux.ee>
