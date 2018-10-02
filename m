Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB29C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604F22083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B7/bJ6k2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604F22083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeJBXKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:10:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbeJBXKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ceAmLXOyDo2H74Tqnkmq40zUJE3zYCjKAa7qtJ6i0YM=; b=B7/bJ6k2ZMJ3c20QtTjYXoSzB
        Mywdbc8kYl4+D7cNDFd+Bs1o1gAShN46ZkHmRkghnjamYV2RSwbfN7/sVGj3gQ5yl+yIqefIYaIDc
        BUA3JNVJT+BsGcsSdOLEJsDI579Fk5AXc3RBN4tfh4OMfLj7zCofla08l+IsJhgnWaYvUISXEfSTv
        VHHK/xlCjGnyoTt8xuDTV4r+ORrT7S8hRZ2H1g5KUHp3Vss1jyct2TDQK3XAhN4/N8wS0uoMMrwiQ
        4S/85rLfOzQAl20NTN9srwLPNmnj3X9n2ehdo4KdbfxSxfVrPqp5sfcgFxr68i1MwfH8+GY4GWMbD
        xC1UQWqIg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7NVA-0005WH-Fs; Tue, 02 Oct 2018 16:26:24 +0000
Subject: Re: linux-next: Tree for Oct 2 (dell: dcdbas)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
References: <20181002191818.1c2eec51@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b019c375-1157-778f-99b2-1d09aa4b4e6a@infradead.org>
Date:   Tue, 2 Oct 2018 09:26:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181002191818.1c2eec51@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/18 2:18 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180928:
> 

on i386 or x86_64:

  CC      drivers/platform/x86/dcdbas.o
../drivers/platform/x86/dcdbas.c: In function 'dcdbas_check_wsmt':
../drivers/platform/x86/dcdbas.c:572:2: error: implicit declaration of function 'memremap' [-Werror=implicit-function-declaration]
  eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
  ^
../drivers/platform/x86/dcdbas.c:572:61: error: 'MEMREMAP_WB' undeclared (first use in this function)
  eps_buffer = memremap(eps->smm_comm_buff_addr, remap_size, MEMREMAP_WB);
                                                             ^
../drivers/platform/x86/dcdbas.c:572:61: note: each undeclared identifier is reported only once for each function it appears in
../drivers/platform/x86/dcdbas.c: In function 'dcdbas_exit':
../drivers/platform/x86/dcdbas.c:748:3: error: implicit declaration of function 'memunmap' [-Werror=implicit-function-declaration]
   memunmap(eps_buffer);
   ^


Reported-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
