Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D0C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749582473C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W4eMNGFm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749582473C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeGCQLl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:11:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37274 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932209AbeGCQLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:11:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yEFcD3NYJhaVy2m0PM8YZOc6VtOAq4No2BYAspfXs5E=; b=W4eMNGFmIXGyay2EaUcv3i5aM
        LwKjEgK+MJGejOVsTpiFZ7XotGN1PUcgRNIRl/mKvBHZMZcBC3dM0RsY2baocfGTDaU7zOxNQhBcE
        rJAcZdCzUvNUBj3nxX/ZWOPQ1h5cyLcDuKxFI07VrQ7kJN6fsTRgQWWcng5XDINM1zNdXqjhie0AM
        ApDMlj8NIKgE29ugT2HkpmuHtecyA79l+ASoZs65PPkJLMZ00dUfCY8SLZabfxf9AHSDDZiZTvrkg
        S09ro4BLJN8fIDpR1TwI59kLJ68n2KWLBSfUHB7+9LiBCxKaSCb2F8kmjoJfdQiXBPMuo0GJ9FSSy
        JkiBj0lqg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1faNty-0007xn-Qg; Tue, 03 Jul 2018 16:11:38 +0000
Subject: Re: [PATCH 1/5] kconfig: include common Kconfig files from top-level
 Kconfig
To:     Christoph Hellwig <hch@lst.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702144711.22111-1-hch@lst.de>
 <20180702144711.22111-2-hch@lst.de>
 <5c090e3f-ced0-62c5-c511-f4c66804ed32@infradead.org>
 <4dfba139-43a2-5949-3221-39cae3191ae7@infradead.org>
 <20180703133616.GB15589@lst.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e230cffa-b3ea-d5c2-3d2c-5f822c9c2e7d@infradead.org>
Date:   Tue, 3 Jul 2018 09:11:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703133616.GB15589@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/18 06:36, Christoph Hellwig wrote:
> On Mon, Jul 02, 2018 at 01:08:16PM -0700, Randy Dunlap wrote:
>>> I would prefer to have init/Kconfig before arch/$(SRCARCH)/Kconfig.
>>
>> Ugh, that won't get this set correctly on x86_64:
>> CONFIG_PGTABLE_LEVELS=2
> 
> Did you try it?  As far as I can tell modern kconfig isn't really
> order sensitive any more.
> --

Yes, it was wrong. :(

Once the symbol has a default value, it won't be assigned a different
default value (at least that's how it looks; I haven't read the kconfig
source code).

-- 
~Randy
