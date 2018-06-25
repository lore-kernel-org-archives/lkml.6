Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A65BC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA3C256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9xlBCgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBA3C256E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755134AbeFYQTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 12:19:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752988AbeFYQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 12:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3neHh90zitVJZIoBUTMvE86AKqERBnhi3I1BwWG/k4M=; b=i9xlBCghUfnG90IdoM4Mv3Ysx
        v3QuPOEkPYKtQAKv/yOwrHjDxnCNSoQx+8qcIv00qHSeIcoObC0vFNS9HAh7zklu4UDJ0JfiIgCuw
        8OAuSmXkZJ2ikEXsyp9fnr8o6hqd+tZpk1ntfrULHOqFFwIhbG1hcI3QD6ufWDbAPCQ+7YR49namY
        W+mNFE413L8bYNj3FcYgB7BwSYbUSeMIuU2jN+zfJ+7dViXsy7VoI74ylH73ZXtV8Gqo1dtGAL8Kv
        zRCU3VfrSmapDh2+gad36bLonofhizzCHgh1hVq2knVVMbagiz8N7oXS50wbbz3gfTnoJSTW/kFum
        l5BTuLl9A==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXUDD-0002ej-An; Mon, 25 Jun 2018 16:19:31 +0000
Subject: Re: linux-next: Tree for Jun 25 (efi_64.c)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180625154317.7a55dd19@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c75cfdf9-fc2c-52c3-81a4-8584923b85a7@infradead.org>
Date:   Mon, 25 Jun 2018 09:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625154317.7a55dd19@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/2018 10:43 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180622:
> 

on x86_64: (randconfig)

  CC      arch/x86/platform/efi/efi_64.o
In file included from ../include/linux/kernel.h:10:0,
                 from ../arch/x86/platform/efi/efi_64.c:21:
../arch/x86/platform/efi/efi_64.c: In function 'efi_sync_low_kernel_mappings':
../include/linux/compiler.h:319:20: error: call to '__compiletime_assert_277' declared with attribute error: BUILD_BUG_ON failed: p4d_index(EFI_VA_END) != p4d_index(MODULES_END)
    prefix ## suffix();    \
                    ^
../include/linux/compiler.h:327:2: note: in expansion of macro '__compiletime_assert'
  __compiletime_assert(condition, msg, prefix, suffix)
  ^
../include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
  ^
../include/linux/build_bug.h:45:37: note: in expansion of macro 'compiletime_assert'
 #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                     ^
../include/linux/build_bug.h:69:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
  ^
../arch/x86/platform/efi/efi_64.c:277:2: note: in expansion of macro 'BUILD_BUG_ON'
  BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
  ^
../scripts/Makefile.build:317: recipe for target 'arch/x86/platform/efi/efi_64.o' failed
make[4]: *** [arch/x86/platform/efi/efi_64.o] Error 1



-- 
~Randy
