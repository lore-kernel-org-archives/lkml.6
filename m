Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CBBC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50BE205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="iGi5iocZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50BE205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030611AbeFSTuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:50:19 -0400
Received: from services.gouders.net ([141.101.32.176]:50440 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030442AbeFSTuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:50:18 -0400
Received: from localhost (ipservice-047-071-023-039.pools.arcor-ip.net [47.71.23.39])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id w5JJhb2T030283
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 21:43:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1529437417; bh=LprEAYONUVtEOa2BgbILQaS0xaBRi9zS3JIFci94RbA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date;
        b=iGi5iocZ5pqgo3o7P5xm2Cuv6JR1GXYfdi0O4SwXKG1nooBdcaHlo+3S/jjgU5QGP
         BbaU3ReK7V/pJf0sErpDy5B6NHuwUWQ1X/ABoX0y3ZbLPJdmqBAJ/P2UyUwQaX0g41
         7Y851kgMNwvpyzT7mrAe4VoKmkEnf4LdzsXy5jtg=
From:   Dirk Gouders <dirk@gouders.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC v7 1/1] mconf: global i-search in menu prompts
In-Reply-To: <7a371124-007b-f758-44f0-c70c64ff5974@infradead.org> (Randy
        Dunlap's message of "Tue, 19 Jun 2018 12:34:21 -0700")
References: <20180617121534.4809-1-dirk@gouders.net>
        <20180617121534.4809-2-dirk@gouders.net>
        <6e23227d-f3ed-2197-7458-b060b8c90b64@infradead.org>
        <ghk1qusjf8.fsf@lena.gouders.net>
        <7a371124-007b-f758-44f0-c70c64ff5974@infradead.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Date:   Tue, 19 Jun 2018 21:43:34 +0200
Message-ID: <ghfu1isgt5.fsf@lena.gouders.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> On 06/19/2018 11:47 AM, Dirk Gouders wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> 
>>> Hi Dirk,
>>>
>>> On 06/17/2018 05:15 AM, Dirk Gouders wrote:
>>>>
>>>> At any time, at most one i-search is active and the navigation path to
>>>> the current menu is displayed in the subtitle, the second line in the
>>>> menu window.
>>>
>>> Nice.
>>>
>>> And the highlight of the current menu item is also nice when TAB is used to
>>> switch to the buttons.  As well as toggling the help text based on context.
>>>
>>>
>>>> Navigation example:
>>>>
>>>> To navigate to options concerning NFS file systems, simply type 'n',
>>>> 'f' and 's'.
>>>>
>>>> Hint: use the 'z' key with focus on buttons to search for invisible
>>>>       prompts.
>>>
>>> I think what this says is that the 'z' key is a toggle for the display of
>>> some (invisible) prompts.  Is that correct?
>>>
>>>
>>>
>>> I reliably (consistently) get a segfault.  I have hit it several times.
>>> Here is one way to get it:
>>>
>>> $ make menuconfig
>>> and then enter:
>>> /debug\
>> 
>> Hello Randy,
>> 
>> thank you for testing and your comments!
>> 
>> Concerning the segfault, I already have a version 8 prepared but wanted
>> to do more testing before disturbing people, again.
>> 
>> The initialization and operation of the serialized menu was ugly and
>> wrong.  I did not notice segfaults so far, but I can imagine the
>> segfaults you noticed are caused by this, because the code you tested
>> did not operate only on propper initialized array elements.
>> 
>> Before sending out version 8, I would like to include your other
>> suggestions as well, so could you please try the attached patch if that
>> also produces the segfaults?
>
> Yes, this one is working for me without faults.

Thank you very much.

I will prepare a v8 with your comments on the diff also respected.

Dirk
