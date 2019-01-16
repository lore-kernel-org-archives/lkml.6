Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80419C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FDD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2a1dmZk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394448AbfAPRAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:00:43 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40502 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394422AbfAPRAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sEiY84oQo75NAVbx0FOF/0pQFxVcQoP+noa5MYW2qFM=; b=2a1dmZk6FF8x3DQ+q/IjI6U2kn
        ICfrQHt6Dx0/SyDX7XnylYnvk+YB0hJ7kJuOWspogQRj06LGL/paajBdKETb7ImRaCZY4Kh99NaAi
        Pc26+DWfGFjQHoIhM0FeYPAic9gJ7CBMsBji/zXPEAgNnfgMRelBIrLIaOnk7kGODIU/j6WiEej6w
        UYqR6sFBzZHVCzgPg++1mdfIRxqZGisS99udvqTbdZ/pOZFlz5ziktWkEDnKgATFUd5SfZNnXBkG5
        3sPrPNMGcNyiQMwHNeHA0sKKgezw3bVSv/+hcZDBuhuz70i2JdkjueIv04UdmZYJGGK4NjjGKTY6q
        jCgax6oQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gjoYR-0002Xe-GG; Wed, 16 Jan 2019 17:00:39 +0000
Subject: Re: linux-next: Tree for Jan 16 (PCI config warning?)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>
References: <20190116173838.042db659@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bc18898a-8619-fc46-7c42-3d51969ee7f7@infradead.org>
Date:   Wed, 16 Jan 2019 09:00:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190116173838.042db659@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 10:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190115:
> 

on x86_64:

when CONFIG_PCI is not enabled (via randconfig):

WARNING: unmet direct dependencies detected for PCI_LOCKLESS_CONFIG
  Depends on [n]: PCI [=n]
  Selected by [y]:
  - X86 [=y]


-- 
~Randy
