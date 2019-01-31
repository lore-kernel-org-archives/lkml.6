Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7158C282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D6B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rfHv6RQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfAaDQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:16:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49314 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfAaDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nHPm6rH3LqbxtjgSUvaO/i6RnfWUI9hywgUWwRqFhSY=; b=rfHv6RQrhWo8hi0J9nKYyuJpC
        5l4/D/NIJ+WiQL9IndDA/+n6JKBQ/VliavleGBXL7SA0zgDg5mtj7cxJP7len5eTU+ahr6Y7I3Zkb
        5jkh3/vuMezY855R7cmnkgG2M3GE7etLPsSBayxNyk1lVhqER9XBnNqmf8D93wyVzswAHNu9MwB2k
        iMiFh+Uoumow4zkfzXw6E9t4goo6+zkuorlpIhFhm8gNOsPcOvG1SGTxvxR9Alh2FMPw6/3hcjkq9
        4rCoTl9/+AeOEKXiTKJEGNgkA1XyTMLqbGEtrTfR8iH14BNE5QyHxbNm6JTY1RrOr5sIOHHPD6yCS
        VntBOgaNQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gp2pa-0000dB-Te; Thu, 31 Jan 2019 03:15:58 +0000
Subject: Re: mmotm 2019-01-30-15-02 uploaded (i386 build summary)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20190130230305.d7osZ%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c19c92ac-2490-4342-4cc1-276b5bf5ea8f@infradead.org>
Date:   Wed, 30 Jan 2019 19:15:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190130230305.d7osZ%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 3:03 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-01-30-15-02 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 

argghh.  I guess nobody builds on i386 any more.

Summary from 8 i386 builds:
(ignoring "missing braces" in drm)

../kernel/dma/swiotlb.c:211:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘size_t’ [-Wformat=]
../kernel/dma/swiotlb.c:217:9: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘size_t’ [-Wformat=]

ld: drivers/mtd/nand/raw/meson_nand.o: in function `meson_nfc_setup_data_interface':
meson_nand.c:(.text+0x1f9): undefined reference to `__udivdi3'

../arch/x86/platform/olpc/olpc_dt.c:146:10: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 3 has type ‘size_t’ [-Wformat=]

../mm/memcontrol.c:5629:52: error: ‘THP_FAULT_ALLOC’ undeclared (first use in this function)
../mm/memcontrol.c:5631:17: error: ‘THP_COLLAPSE_ALLOC’ undeclared (first use in this function)
../mm/memcontrol.c:5629:52: error: ‘THP_FAULT_ALLOC’ undeclared (first use in this function)
../mm/memcontrol.c:5631:17: error: ‘THP_COLLAPSE_ALLOC’ undeclared (first use in this function)


-- 
~Randy
