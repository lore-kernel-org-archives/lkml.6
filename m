Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E5C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFFA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Av3PfxS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFFA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932903AbeFTUCL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:02:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34428 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbeFTUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mSGje/N9AlyD8es74rG94CIwGZIarqpF9Tr9Gv2j2mM=; b=Av3PfxS6h5/0lA7bt06gBh3SP
        ShVjDAbzexqt3E/DA5PnFHnKUUoGaKv2LQkK/AlshsLaE5q9hguy3V/mOSMSBg4GbxOCYxrSP/I7H
        W3dNq6gszqyN0kaFq6blB4G0rIYSx9H7r290a0NxJ9Rm5TzgfRDG9IuRIjzHT+kBpUrckJNbWBHWj
        urs2JDFDSqqEp3sTUDdwGgAM+hgR0ELnKqj5rw6owhPUsPCVNtKFlz73ZGHzRAnSzlEnO7kk8bqrj
        BxV6G5yIyHcJPWtUKZmqu1YAcYvjp6r5sX0djrEOvB08Lc88+HKvMk3Pz3qvBjcY9zLuHkPdDqPgQ
        D3XqLGm9w==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVjIs-0002Nh-Ai; Wed, 20 Jun 2018 20:02:06 +0000
Subject: Re: [RFC v8 1/1] mconf: global i-search in menu prompts
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20180620084217.8597-1-dirk@gouders.net>
 <20180620084217.8597-2-dirk@gouders.net>
 <f02cc7c6-d92e-24f3-b0ad-df9e6bf7630a@infradead.org>
 <ghpo0l2spo.fsf@lena.gouders.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <126839db-5cc1-7dad-5a1f-21899dc6236e@infradead.org>
Date:   Wed, 20 Jun 2018 13:02:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ghpo0l2spo.fsf@lena.gouders.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 11:55 AM, Dirk Gouders wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Hi,
>>
>> On 06/20/2018 01:42 AM, Dirk Gouders wrote:
>>>
>>> Operation
>>> ---------
>>> The TAB key is reserved to toggle the focus between menu and bottons.
>>> Focus is on the buttons if one of the buttens (the active one) is
>>> hightlighted, otherwise it is on the menu.
>>>
>>> When the focus is on the buttons, mconf operates as before with the
>>> exception of the TAB key.
>>>
>>> When the focus is on the menu, mconf operates in i-search mode and the
>>> following input has special meaning:
>>>
>>> * <\> (backslash) can be used to search for other occurences of an
>>>   already entered string.  On empty search strings, nothing happens.
>>>
>>> * Any other printable character than backslash and '\n' is appended to
>>>   the current search string and a match is searched for.  If a match
>>>   is found, it is immediately navigated to.
>>
>> About that paragraph above:  I tried to search for "fs-cache", as in:
>>
>> config FSCACHE_DEBUG
>> 	bool "Debug FS-Cache"
>>
>> but i-search does not allow me to enter a '-' character.  Seems odd to me.
> 
> Hi Randy,
> 
> thanks for all your testing.
> 
> '-' and '+' previously had the same meaning as <KEY_UP>, <KEY_DOWN>,
> respectively.  If you are on the top menu item and press '-' there is
> nothing to scroll up so it appears as if the pressed key wasn't
> processed.
> 
> I-search should add those characters to the pattern but I broke that two
> or three versions before when I fixed another issue.
> 
> I will add this to my list of test cases so this won't happen again.
> 
> Dirk
> 
> 
>> Still doing other testing...

I haven't hit any other issues.

thanks,
-- 
~Randy
