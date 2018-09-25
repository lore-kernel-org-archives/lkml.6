Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA512C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7069120C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MHBGeXiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7069120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeIZB6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:58:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeIZB6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y3cXsm6ge4DgnlLVcFBKCV7lMeEUCxj/e8Nk5TcjgQU=; b=MHBGeXiqeWxQ6zxekv0sLQtB4
        /gnR7HidWx9YcEjcn6DpojJWBBgyoSFeXsB8rAuMFFYC2bp6y/ivfdMHcl0wv9/k99F/xel2R5jAC
        7QvgfgXOcImD5vl6OmR2mCtKAZ+TUgMCKdSTjxsgSCu7CyDT9lju8QHdcdEhkS1oOBq6ju9kfQWGE
        CHXmD8rI9RhSluvC8zsQB/31cs0upx5/oe3PsBIbawgMnB8A2mLXnz7Wrhn9GlGpgs0vLA4YY+afu
        5VZoL2m4oj3l+FtX0b+DJLVIzgjVy8H0M/qNLSFhA+bqsjl5gqcfYu9uim4SiIw4GEbo7L2ZS5Csn
        WJR2FcX/Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g4tKi-0004ap-9t; Tue, 25 Sep 2018 19:49:40 +0000
Subject: Re: [PATCH] staging: dgnc: Fix Kconfig help header and text
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sehro rautenkranz <sehro@sehro.org>
Cc:     Lidza Louina <lidza.louina@gmail.com>,
        Mark Hounschell <markh@compro.net>,
        driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <a62c2d41-5ae6-26a1-3c0e-01893a8ca8a0@infradead.org>
 <20180925162225.19227-1-sehro@sehro.org> <20180925184623.GA16455@kroah.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <59f16a7e-4221-73e0-cf6e-3461717be318@infradead.org>
Date:   Tue, 25 Sep 2018 12:49:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925184623.GA16455@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 11:46 AM, Greg Kroah-Hartman wrote:
> On Tue, Sep 25, 2018 at 10:22:24AM -0600, sehro rautenkranz wrote:
>> Replace Kconfig help header and text to match other modules. Issue found
>> my checkpatch.
>>
>> Spacing adjusted to match Documentation/process/coding-style.rst. Issue
>> reported by rdunlap@infradead.org. (try 2)
> 
> The "try 2" needs go to below the --- line.
> 
> Also, you need to properly version your patches so that I have a clue
> as to which is the "latest" one.
> 
>> Signed-off-by: sehro rautenkranz <sehro@sehro.org>
> 
> You forgot Randy's Reported-by.
> 
> Also, properly Capitalize your name.
> 
> v3?

and the help text is still not indented correctly:
use one tab + 2 spaces for help text.

-- 
~Randy
