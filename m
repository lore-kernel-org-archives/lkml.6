Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id i4KRAf+7HVt2QQAAmS7hNA
	; Mon, 11 Jun 2018 00:02:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DD86A60791; Mon, 11 Jun 2018 00:02:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QTe9zRkF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 539C9606DD;
	Mon, 11 Jun 2018 00:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 539C9606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753753AbeFKACC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 20:02:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753543AbeFKACB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 20:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MECGkKJZzYlG7jN8XJaKLpiX0XNvdAcN/ORM6wjho9g=; b=QTe9zRkFPjq+NK60Pmmt4UgmE
        EGKT0+7A1OPaTZrUiHJB/CPnjFCh97VWGJe0hH/jok0x0BhB2pc6F+8JV3C9gqyFrbG/dqa8t/Ryu
        AjfbVWKVB/7fy1wP9u46LUDTJbWiuHRaHb3WweZU49+peG5b9Lv0NoF2OMBa1y1I89HSTy592ZicN
        F4zvMGGge+RBHJZM6k85pDxDkhIS3PJIOlW1rjCBnYBceSV358qx2B+ZwLtqoD7i8/Y0XfVWmUqXC
        gMZfSBqm2zruzGYZfLUEDQiMT9zSspbCHmMLvoWErkLEn+hiqj6fC8pPo90A9rB25MGqOHxD8g+/W
        pLzB74R9Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSAHV-00034f-95; Mon, 11 Jun 2018 00:01:57 +0000
Subject: Re: [mmotm:master 192/212] include/uapi/asm-generic/int-ll64.h:20:1:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before 'typedef'
To: kbuild test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: kbuild-all@01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <201806081045.eZrs5GGH%fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <533c0099-d2be-8fea-fe2f-1453ea049c33@infradead.org>
Date: Sun, 10 Jun 2018 17:01:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201806081045.eZrs5GGH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 07:06 PM, kbuild test robot wrote:
> tree:   git://git.cmpxchg.org/linux-mmotm.git master
> head:   7393732bae530daa27567988b91d16ecfeef6c62
> commit: b1a8bfbadbcb79644ccdd5f9cd370caa63cb1fa7 [192/212] linux-next-git-rejects
> config: i386-randconfig-s0-201822-CONFIG_DEBUG_INFO_REDUCED (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout b1a8bfbadbcb79644ccdd5f9cd370caa63cb1fa7
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/asm-generic/int-ll64.h:11:0,
>                     from include/uapi/asm-generic/types.h:7,
>                     from arch/x86/include/uapi/asm/types.h:5,
>                     from include/uapi/linux/types.h:5,
>                     from include/linux/types.h:6,
>                     from net/ipv4/ipconfig.c:36:
>>> include/uapi/asm-generic/int-ll64.h:20:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'typedef'
>     typedef __signed__ char __s8;
>     ^~~~~~~

The problem here was that net/ipv4/ipconfig.c begins like this:

q// SPDX-License-Identifier: GPL-2.0

Did anyone fix that?


-- 
~Randy
