Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49972ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F232720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XZlvmesn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F232720661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbeGTRRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:17:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbeGTRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7TkS7vJ5aDo9SRQNB8CE+XoDUmFdaAedTozThE0sc0g=; b=XZlvmesnOBomu4AHNrzclz4fQ
        XFVoVHknimR7WK2lvnsSiJzevsbaoSqDovu8MEfvqo7md8Jr2NWx5YIlZVxcE/XxEUa/WajHWndQJ
        /c7leFXwJqWwYFH85DwxhZbuY8r1jREHEk5qgehSZ+uTT/E0C6golqVsUJRDFrWVFAcoyaLUz1e0x
        /+uuOCmP4RclsNtm2Aac7Hw5nnD8T9MHvrsTpzTml7wKTzIz99EMqx3eDITmwK9X/HMBk4WOvX4ui
        67HOMtKEkxGLnG7sT2O2h4Udo+8owg5ZBbh5pGO4LVD0uBWc4aBX/ddZw5BoQrSdUGPWE/ey5Vai6
        I0Yi0zDoA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgYGN-00053B-OE; Fri, 20 Jul 2018 16:28:15 +0000
Subject: Re: linux-next: Tree for Jul 20 (drivers/memory/jz4780_nemc)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
References: <20180720183212.6bc3477a@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bb6cccb4-5e5c-b5dc-170d-f878af1374f1@infradead.org>
Date:   Fri, 20 Jul 2018 09:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720183212.6bc3477a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 01:32 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180719:
> 

on i386 or x86_64:

when CONFIG_OF is not enabled, COMPILE_TEST is set:

../drivers/memory/jz4780-nemc.c: In function 'jz4780_nemc_num_banks':
../drivers/memory/jz4780-nemc.c:72:3: error: implicit declaration of function 'of_read_number' [-Werror=implicit-function-declaration]
   bank = of_read_number(prop, 1);
   ^

<linux/of.h> does not have a stub for of_read_number() when CONFIG_OF is not set
(it has no way to return an error).


-- 
~Randy
