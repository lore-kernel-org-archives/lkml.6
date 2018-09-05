Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E01CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318CA20861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 15:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLHsU84G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318CA20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIETe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:34:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34111 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeIETe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:34:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so3594352pgv.1;
        Wed, 05 Sep 2018 08:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NNezV9/GbEZNs2xCp7rXbfIi2+UpBIfYtPrIc2g03Ek=;
        b=pLHsU84G8YW7qRBuCQLzzhUhUsCHDZrj1SUp7QEvtYn97x9wNw06aPoXd83R8/1e0y
         l1AZocfldutLaj46T2DcUsZ5uWR7H6BBdvUw3OmmcRXJOlmuJkregEn7UAo+cqzF2LRL
         QkcTKYdrO0WQA5uD0TYH/IbaOiwCLeL4FMbcg9GjZVcMOtfMrRyibehyODST10FZqZCl
         4ItLSNdtKZQMDCBNLQrTgFPhLUovcfmpraq+2OwEwmnD3kVAHFX1PrK3276ineiQZ5Ju
         /Ri16PuhjGK614lFEyQ/66icg9qFn0FTVnNDLCNGYxajDNGDarlKvb3VlzWzI0dqSBTb
         ooEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNezV9/GbEZNs2xCp7rXbfIi2+UpBIfYtPrIc2g03Ek=;
        b=c+ntBYY/ub5mvih0d8Ep1hft75OxA1tosm8VOvt0wTS+h2uLA0c/MSeaAZsUDotuMB
         VtOBxHnXc6+RkcybLLjUZmBAkkY0Vazrqc10JfEFo2IvFnEjEzI2JzMDGjXnpD/v6vIj
         Y4wrZNvIOUmZaw5gNdjRGq1dkJLyXvyexGyzFJSwFeVRIgEVc0ismS7tNe0gjr1uYM5M
         FrueEqIYumqJSpOcbmjudGwsWEYQE28k9fplX1bxtZoSSLKaqlhotx5ebz7lwPzU3Bbt
         fuXjcYDUc62Y81tEFhStCAU5hod/L/siSPK+NfYMEG/DlU6vZN0NaYw1iUr6ld8M7twm
         8xow==
X-Gm-Message-State: APzg51CvJqp5V8HnyHcvTTigWw8myMTFOrOGSe4tM9ZviXfwRJy27RPF
        JP5oZu9hU+RE5XlbxlgpTY8=
X-Google-Smtp-Source: ANB0VdZ0qQhdUCl+WeYmZdGCx5JxzxWY4IXYUHOARRul+e6AygKe9HmvT2+r2StxloOI9K1EFygX7A==
X-Received: by 2002:a62:760a:: with SMTP id r10-v6mr41119834pfc.207.1536159859583;
        Wed, 05 Sep 2018 08:04:19 -0700 (PDT)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id u9-v6sm5547642pfi.104.2018.09.05.08.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 08:04:18 -0700 (PDT)
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
 <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
 <20180905150042.GA8820@andrea>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <e8dbdd89-ff65-31ea-8d04-7e84b64a98b0@gmail.com>
Date:   Thu, 6 Sep 2018 00:04:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905150042.GA8820@andrea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/06 0:00, Andrea Parri wrote:
> On Wed, Sep 05, 2018 at 11:33:08PM +0900, Akira Yokosawa wrote:
>> On 2018/09/05 09:21:51 +0200, Andrea Parri wrote:
>>> On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
>>>> On Tue, 4 Sep 2018, Andrea Parri wrote:
>>>>> Heh, your confusion might be the reflection of mine... ;-)  That was
>>>>> indeed a long and not conclusive discussion (meaning there're pending
>>>>> issues); and I cannot claim to find "arguments" such as:
>>>>>
>>>>>   "More than one kernel developer has expressed the opinion that
>>>>>    the LKMM should enforce ordering of writes by locking."
>>>>>
>>>>> particularly helpful (I do tend to be convinced by arguments rather
>>>>> than by opinions).  In fact, you can take the following as my only
>>>>> current "constructive argument" against the patch [1,2]:
>>>>>
>>>>>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
>>>>>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
>>>>
>>>> Do you have any concrete suggestions (i.e., some actual text) for 
>>>> improvements to the patch description?  Earlier in your message you 
>>>> mentioned that Will's comment:
>>>>
>>>> 	LKMM offers stronger guarantees that can portably be relied upon
>>>> 	in the codebase.
>>>>
>>>> would make a good addition.  Suitably edited, it could be added to the
>>>> description.  I can think of a few other things myself, but I'd like to 
>>>> hear your thoughts.  Anything else?
>>>
>>> Yes: I do sometimes have the impression that your "rules" for trimming
>>> text in emails/replies are too aggressive...
>>
>> Andrea, by saying "Yes:", do you mean you have something else to be added?
> 
> Indeed (examples in the trimmed text).

So, you mean just amending commit log does not work for you?

> 
> 
>> I don't think you do, but want to make sure.
>>
>> I'm a bit surprised to see all you wanted was the amendment of the
>> commit log...
> 
> Well, I said that it was my only current constructive argument...

This thread is getting quite hard for me to follow...

   Akira

> 
>   Andrea
> 
> 
>>
>>   Akira
>>
>>>
>>>   Andrea
>>>
>>>
>>>>
>>>> Alan
>>>>
>>

