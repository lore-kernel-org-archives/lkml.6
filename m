Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3446C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA7721B6A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392485AbeLVRBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:01:46 -0500
Received: from ozlabs.org ([203.11.71.1]:44539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeLVRBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:01:04 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 43MLSY55RGz9sNj; Sat, 22 Dec 2018 20:54:37 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 05a4ab823983d9136a460b7b5e0d49ee709a6f86
X-Patchwork-Hint: ignore
In-Reply-To: <a9c14a1ca37b82dbe015d259cd60d8aea9e7847a.1544336305.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v3] powerpc/uaccess: fix warning/error with access_ok()
Message-Id: <43MLSY55RGz9sNj@ozlabs.org>
Date:   Sat, 22 Dec 2018 20:54:37 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 06:50:09 UTC, Christophe Leroy wrote:
> With the following piece of code, the following compilation warning
> is encountered:
> 
> 	if (_IOC_DIR(ioc) != _IOC_NONE) {
> 		int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;
> 
> 		if (!access_ok(verify, ioarg, _IOC_SIZE(ioc))) {
> 
> drivers/platform/test/dev.c: In function 'my_ioctl':
> drivers/platform/test/dev.c:219:7: warning: unused variable 'verify' [-Wunused-variable]
>    int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;
> 
> This patch fixes it by referencing 'type' in the macro allthough
> doing nothing with it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/05a4ab823983d9136a460b7b5e0d49

cheers
