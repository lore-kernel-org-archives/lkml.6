Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E805C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D430E2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sNzkE7x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D430E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731456AbeKHDa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:30:27 -0500
Received: from twosheds.infradead.org ([90.155.92.209]:35630 "EHLO
        twosheds.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbeKHDa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=twosheds.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5c6nkgpCvsjPHI2lAEAZ29rfXiAahTvEwXyfklBliLc=; b=sNzkE7x6arDD2o3Yd/GvrAbdW
        xQCAJjfl74S2rKBenF9xWg3ORhC/wTLdd5iCAnaBcsx/0LYz6MSDr2F+YWdDWeXbeJdUdiriniBve
        vM9EY6hBldDZ+DA27N0pEX4AKyl/lIW05gnvCmFu/WTndMXD/4luVvJqrNf+jCRPhPcySW3lta8Bi
        4yw5O0G2Uw+7f99ZWUfWRJpRmOMnRmUC7dzweKvp27lQO+QrwLRp1A6ekigVNPgZIk9C3DL8dLYj1
        YWYVUoTSPioCQ87RVEA4xBsK6z1G+HvYi3bv+fIdv3CSIkKApZFvCpX/Xd5RrBTwmfgPagh52PBy6
        kuoUFGQuA==;
Received: from localhost ([127.0.0.1] helo=twosheds.infradead.org)
        by twosheds.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gKS6P-00AboG-A8; Wed, 07 Nov 2018 17:58:53 +0000
Received: from 213.205.242.122
        (SquirrelMail authenticated user dwmw2)
        by twosheds.infradead.org with HTTP;
        Wed, 7 Nov 2018 17:58:53 -0000
Message-ID: <df9cdf1753ec7e6e20c12aa096b98453.squirrel@twosheds.infradead.org>
In-Reply-To: <20181107173303.slnb3i2d6ufaonp7@zorba>
References: <20181106214928.40020-1-nkela@cisco.com>
    <921b0f78cf67d7307a0555e1fd6f2c2976310adc.camel@infradead.org>
    <1e4c066d1896e2a0b8b146253d34d05cc4f9ab36.camel@infinera.com>
    <8b08e8b992093453bb2b9caff8cff08c.squirrel@twosheds.infradead.org>
    <20181107173303.slnb3i2d6ufaonp7@zorba>
Date:   Wed, 7 Nov 2018 17:58:53 -0000
Subject: Re: [PATCH] jffs2: implement mount option to configure endianness
From:   "David Woodhouse" <dwmw2@infradead.org>
To:     "Daniel Walker" <danielwa@cisco.com>
Cc:     "David Woodhouse" <dwmw2@infradead.org>,
        "Joakim Tjernlund" <joakim.tjernlund@infinera.com>,
        "nkela@cisco.com" <nkela@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "xe-linux-external@cisco.com" <xe-linux-external@cisco.com>
User-Agent: SquirrelMail/1.4.22-21.fc27
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by twosheds.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Wed, Nov 07, 2018 at 04:12:14PM -0000, David Woodhouse wrote:
>>
>> > Yes, this may slow things down. I am not sure I agree with the impl.
>> > either.
>> > Could one not make cpu_to_je_X/jeX_to_cpu a function ptr which is set
>> to
>> > a func. with the correct endian?
>>
>> On x86 retpoline would make that quite slow.
>
> Is x86 the largest consumer of jffs2 ?

Certainly not. I'm not sure which architectures do have Spectre V2
mitigations which make indirect branches expensive now... perhaps there is
no intersection with the cases where we really care about JFFS2 being
CPU-bound?


-- 
dwmw2

