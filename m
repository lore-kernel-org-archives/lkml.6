Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34868C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF81C217C7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vbFOZx0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF81C217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbeHMRv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:51:58 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbeHMRv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UuHoBkgKCwo83CTC9xlgwNqIXCvmoQ7Nl3/hp4qpgj8=; b=vbFOZx0FBrn0REKG6ovQIepRCQ
        6r50OqMQ5yYpp0qpoMKCJ6guOjter0m/Xgoz6M+iaFJqropov82i/0wolkXFHlul4lPnKg95KRpXz
        +10HudiPkmful+r+56H9DdJ3qu9TTXw/pwQLZ3PC/Xk6XgAQR3abIGaWRLcZ9r26PZFMFNTJSVInz
        COx8uZ9BG8WP7E6iBr5bC4YXDIbnbX4Y8Xyr412z8LkaA+Ozd6HAZDisKb70+8Od23Y7WCDlJPvqk
        iw8CY4XzcTkL03Oyp5q/T7PSHRel0PtPLnk6z1n+M4UF1VtTQFovPN8nfgCVvvchWr4vRhTA7jkbH
        9glcCq/g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpET7-0004ni-Sj; Mon, 13 Aug 2018 15:09:18 +0000
Subject: Re: [PATCH v2] docs: provide more details about security bug
 reporting
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20180812132325.GA1608@1wt.eu>
 <82b1e47a-07ea-7104-65e2-1964ec325af0@infradead.org>
 <20180813073801.GA14633@1wt.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9a9d9d12-983a-c795-e22b-e0478e9dc557@infradead.org>
Date:   Mon, 13 Aug 2018 08:09:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813073801.GA14633@1wt.eu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2018 12:38 AM, Willy Tarreau wrote:
> Hi Randy,
> 
> On Sun, Aug 12, 2018 at 09:14:29AM -0700, Randy Dunlap wrote:
>> I have a few corrections/comments below.
> 
> Thanks a lot, I've addressed them in the attached version. Linus,
> please take this one instead.
> 
> (...)
>> +Analysing a report takes a lot of time, and while sometimes it's
>> +better to conclude to a wrong alert because there is nothing to fix,
>>
>>        "to conclude to a wrong alert" needs some fixing, but I don't know what...
> 
> I changed this one to :
> 
>      "to conclude the report was a false alarm"


LGTM.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy
