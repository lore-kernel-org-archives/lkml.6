Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46B9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B04214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 07:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EICV2By+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B04214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailbox.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeJJOmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 10:42:05 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:30714 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbeJJOmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 10:42:04 -0400
Received: from smtp1.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 044FC4943B;
        Wed, 10 Oct 2018 09:21:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:in-reply-to
        :mime-version:date:date:message-id:from:from:references:subject
        :subject:received; s=mail20150812; t=1539156071; bh=Zg5S6REyTCdx
        LzdCifCPnEIk7hKlMh7Y8MXRZfGuWbk=; b=EICV2By+cQzhb3I8Bp+BZyVX/T72
        0aIIZmxuLxlH5Ho5xcmRD9iql7ijdndwpEyY8UyFKVcbACiGru5yHttkf0iiP3AS
        FOmz9yJRxt9y6rRGsmAeAWTYnE+c3uqDHYKx0gbo3/XGeYz+y2NUiRb/lEyXXvkX
        8k1aOOyeP2o4INI7SXTh+PmhrGbbEOo+IU2QrATiHLj/yRAu+ecyiQ0yl58XIGfc
        zdqnj+2DTpNZzFVDsXsTLnfIulBLpMrLjPdWPALji6CeaFO9/pCcOdhNJ38lSL6h
        7NANt5ambKaS8b6fdOhZvNyVT0K/j2uO7te8W5RBj8mwkAvGN27P30w/4Q==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 7UIIGxLzQMCS; Wed, 10 Oct 2018 09:21:11 +0200 (CEST)
Subject: Re: [Ksummit-discuss] [PATCH 1/2] code-of-conduct: Fix the ambiguity
 about collecting email addresses
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1538861738.4088.5.camel@HansenPartnership.com>
 <1718828.OxLgMoHbrt@siriux> <20181009185622.GA20960@localhost>
 <1877914.JXSoZ9jg4d@avalon> <1539114254.4876.7.camel@HansenPartnership.com>
From:   Rainer Fiebig <jrf@mailbox.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jrf@mailbox.org; keydata=
 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
 6/dT7HxuwnVIkER8kg==
Message-ID: <c0e807a6-52b4-d655-9b13-805af5cdc85e@mailbox.org>
Date:   Wed, 10 Oct 2018 09:22:30 +0200
MIME-Version: 1.0
In-Reply-To: <1539114254.4876.7.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley schrieb:
> On Tue, 2018-10-09 at 22:38 +0300, Laurent Pinchart wrote:
>> Hi Josh,
>>
>> On Tuesday, 9 October 2018 21:56:23 EEST Josh Triplett wrote:
>>> On Tue, Oct 09, 2018 at 08:29:24PM +0200, Rainer Fiebig wrote:
>>>> Am Montag, 8. Oktober 2018, 08:20:44 schrieb Josh Triplett:
>>>>> On Sat, Oct 06, 2018 at 02:36:39PM -0700, James Bottomley
>>>>> wrote:
>>>>>> The current code of conduct has an ambiguity in the it
>>>>>> considers publishing private information such as email
>>>>>> addresses unacceptable behaviour. Since the Linux kernel
>>>>>> collects and publishes email addresses as part of the patch
>>>>>> process, add an exception clause for email addresses
>>>>>> ordinarily collected by the project to correct this
>>>>>> ambiguity.
>>>>>
>>>>> Upstream has now adopted a FAQ, which addresses this and many
>>>>> other questions. See https://www.contributor-covenant.org/faq .
>>>>>
>>>>> Might I suggest adding that link to the bottom of the document,
>>>>> instead? (And then, optionally, submitting entries for that
>>>>> FAQ.)
>>>>
>>>> The Code of Conflict has 28 lines, including the heading.
>>>> The Code of Conduct has 81 lines, including the heading. And it
>>>> needs a FAQ. Hm.
>>>
>>> Yes, it turns out to be a more complicated problem than it was
>>> previously oversimplified to. People don't automatically share a
>>> common understanding.
>>
>> I see an elephant in the room in the fact that we have carefully
>> avoided  discussing whether people share a common goal here :-/
> 
> We don't need to share a common goal; we just need to find the
It wouldn't hurt to have one and mention it either.

> document useful on its merits.  That's why we're a mostly GPLv2
> project without signing up to most of the FSF philosophy.  However,
> that's also why we would keep our own interpretations, understandings
> and clarifications in house, as it were.
> 
> James
> 
Sure.


So long!

Rainer Fiebig
