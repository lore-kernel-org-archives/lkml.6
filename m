Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A04C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321DC20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rE6xufwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321DC20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeJaMQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:16:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeJaMQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wZxgxAq84zk1Yp1Rdxg4z4/ysXHbxhSuhRr1rrVOP04=; b=rE6xufwhcCC+afFX0Z73rkyjGw
        JyhiuPtFn4vtnMzA3zr+jgOqwKBeBiuZZsGLopkvoWEpKceV9ciedS2AW2KbJPjcZlF9wsoHaJXlc
        JINwRnytuR0V1TGZtnxGaACIfiAf8G0Cbqqk8+1qA2QdHmmHlVjV2Y660yGBl0rA6a5jkHNYwMP8I
        5ylC0+ErCH+NvX5x0vFTN17ieKvvskJ6X+rqZlp8moas2ZhfA/qDcW1c0o51W6UZnEFLOtJFZZ0JY
        TL8zpYI1EqUULCyAkqTe2Z0bH2FjnY6p5c7wjwRYh1egjFY1IDILryjhl7mFMKgNQmicJcmRm3Ffk
        hDKT1HBA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHh3F-0000yM-JH; Wed, 31 Oct 2018 03:20:13 +0000
Subject: Re: mmotm 2018-10-30-16-08 uploaded (arch/x86/kernel/vsmp_64.c)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Ravikiran Thirumalai <kiran@scalemp.com>,
        Shai Fultheim <shai@scalemp.com>, X86 ML <x86@kernel.org>
References: <20181030230905.xHZmM%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9e14d183-55a4-8299-7a18-0404e50bf004@infradead.org>
Date:   Tue, 30 Oct 2018 20:20:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181030230905.xHZmM%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/18 4:09 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-10-30-16-08 has been uploaded to
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


Build error on x86_64 from origin.patch (i.e., not mmotm)
when CONFIG_PCI is not enabled:
Oh:  CONFIG_X86_VSMP is also not enabled, but
arch/x86/kernel/Makefile always tries to build vsmp_64.o.


ld: arch/x86/kernel/vsmp_64.o: in function `vsmp_cap_cpus':
vsmp_64.c:(.init.text+0x1e): undefined reference to `read_pci_config'


-- 
~Randy
