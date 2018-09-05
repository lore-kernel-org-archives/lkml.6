Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38338C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3r6rpPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D689A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIETDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:03:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46487 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbeIETDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:03:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so3519130pga.13;
        Wed, 05 Sep 2018 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yTAKoxoji26D9fszyeYjoShlIWLclZEovlk5MWgeuXk=;
        b=e3r6rpPiwVRjNuVP4O5WtLSjm6IGc9JmeeQN+x37JGACy2yx/Mh80eVFCmicO0IAB/
         3V1YAJY1xfY0GTxPhyOOn4xt+tBKWZpXC45cqVuAbtt/kuu8odQSrpmm5cTxweGHmq+g
         8fikZwCl/FNcUQ4bSbAdIyXhfEd18XPvjqlsmpNHV7pSJCTlnlBFC2jFmO8G6FUCceva
         f142YyHvtDRzam05cbixez6vYoQd6+DfEpldPXfXqqZ6DL49HxXycjI+apgF89w3SU8W
         iVOUr3xYcNcTB4XEyDHC2mY7im28JBnw0hvLSqsrhE/vBKhCN2iUr6Qy0h2rsAVceocZ
         fmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yTAKoxoji26D9fszyeYjoShlIWLclZEovlk5MWgeuXk=;
        b=jhoaLUkT/RoGryUWs7zOhmm9DGDcFdw3VXyE2MpasX3M2sasKzqc6CblsQZdlo1zqX
         JizCJ/0d9WdzicUISwWgse/iU3drXmHjxr26CUgBHArb4/14IkcG0XKigGxVbXKL9w/J
         6HKTEjtN4lyG7xKthl8Y/4+UxorXf46zQSzpWM8QabOpT1kf0kZk7Hng/e+5tMPgpls/
         nPJyYeCFd04lFreQipRAaN+U8AxqK2MWMlV1zob64H6RhmaFVyTbDTmUV8tbBecODdg4
         DOBlPl4k5WTlgay8DINZtvvRGRRSkZAXHEXJmuZMXGEz9TlW6si7oB7KOjRfnehSEdSp
         z3GA==
X-Gm-Message-State: APzg51DB5KXy/J7hNzJ9f7JIvD2iM7JkOMjO2/w399wf8fIp34snu7CI
        LPwZ2r+fKMWjU3J0Y289YIs=
X-Google-Smtp-Source: ANB0VdZEDdFCdcuocpmrjLXsWVbxGRt5YisVLXbKFuMAE+QOdaORj2bEk4FHbQewJNzWyOGy360GWQ==
X-Received: by 2002:a63:4e5f:: with SMTP id o31-v6mr36741595pgl.256.1536157993266;
        Wed, 05 Sep 2018 07:33:13 -0700 (PDT)
Received: from [192.168.11.4] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id g5-v6sm5195956pgn.73.2018.09.05.07.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:33:12 -0700 (PDT)
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
To:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr
References: <20180904081144.GA4137@andrea>
 <Pine.LNX.4.44L0.1809041503470.17060-100000@netrider.rowland.org>
 <20180905072151.GA3185@andrea>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <50f0a7a7-0521-f833-34c3-132ce57dd777@gmail.com>
Date:   Wed, 5 Sep 2018 23:33:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905072151.GA3185@andrea>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/05 09:21:51 +0200, Andrea Parri wrote:
> On Tue, Sep 04, 2018 at 03:09:49PM -0400, Alan Stern wrote:
>> On Tue, 4 Sep 2018, Andrea Parri wrote:
>>> Heh, your confusion might be the reflection of mine... ;-)  That was
>>> indeed a long and not conclusive discussion (meaning there're pending
>>> issues); and I cannot claim to find "arguments" such as:
>>>
>>>   "More than one kernel developer has expressed the opinion that
>>>    the LKMM should enforce ordering of writes by locking."
>>>
>>> particularly helpful (I do tend to be convinced by arguments rather
>>> than by opinions).  In fact, you can take the following as my only
>>> current "constructive argument" against the patch [1,2]:
>>>
>>>   THE COMMIT MESSAGE IS RIDICULOUS; PLEASE EXPAND ON IT, AND DO
>>>   SO BY LEVERAGING BOTH PROS AND CONS OF THE APPLIED CHANGES
>>
>> Do you have any concrete suggestions (i.e., some actual text) for 
>> improvements to the patch description?  Earlier in your message you 
>> mentioned that Will's comment:
>>
>> 	LKMM offers stronger guarantees that can portably be relied upon
>> 	in the codebase.
>>
>> would make a good addition.  Suitably edited, it could be added to the
>> description.  I can think of a few other things myself, but I'd like to 
>> hear your thoughts.  Anything else?
> 
> Yes: I do sometimes have the impression that your "rules" for trimming
> text in emails/replies are too aggressive...

Andrea, by saying "Yes:", do you mean you have something else to be added?
I don't think you do, but want to make sure.

I'm a bit surprised to see all you wanted was the amendment of the
commit log...

  Akira

> 
>   Andrea
> 
> 
>>
>> Alan
>>

