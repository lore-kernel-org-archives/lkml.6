Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9117C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4121920867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 23:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSi5R4RJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4121920867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbeIZF67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 01:58:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36949 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeIZF67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 01:58:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id f199-v6so328681wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QEATrSXjzhGOpZ1nk5WZkmNJpBwLLQipW7LLfDrFcLA=;
        b=jSi5R4RJbBU8Y+BU1OExPBGL0UyA3tp8lAMMc3U410F0YGRJWbs/FxBxV0iZ4Wib/q
         lpZ8T93aY+mW82yBuhmjINKe4/hq8Spig2TAj92heWgbWd63D4kf7Tzjj9omtjLm2Pe7
         TQ/i2tYDBgqw+SvKuS8v330zofMBWFusI1X/TIh2IVa871i5G2c159WDv3F41LozRHcP
         7gd6ZY4d7wsK2DQlvrv/Zx0gqxybBh0as5aJmMSE6dIA4kr/d5Ic9Es4gwIkSPn5Qiwf
         cCwyApVW9pCNtCVmxaQJ2H1qMQLTLTOBJQHT9sGaD2wc1fhnLeI1uN98tONrQyuxfyNv
         euKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QEATrSXjzhGOpZ1nk5WZkmNJpBwLLQipW7LLfDrFcLA=;
        b=K0Wejf7N7CrABB0wwziCOd/LT2EWYhlzQ2E1BvUKcLlHt2AeFliGx/BWfcbGlA9hXE
         nBMslPhnrDtPcbXVQWwZGHYmWD5gowaSPgzB32FN/JQ/qUJiu41o1kjNBEXTMGVnu/8y
         BQ/nAFKAAlSAsQHCIox6GJR/SmH7mY3fahNORguEZZoIqhJq1w/uyvIgB3uVzNbbEcN5
         fYDIWwbMlDe4tjkcXFIs4m3rxSUhSh/hkj9Gje6PBvQ7XCouf++GwhczQdI9o+tIlycx
         bs56ssevT0vvdtwK++jSaERyZ6iTpdxmWJzJbGklxEThahnshxsn8BSpWEOkPrpho4nj
         XmPQ==
X-Gm-Message-State: ABuFfoggseG4ALMGCBgsshFVFwa/CJzkwzJEgG/9JpvciIF0Pez+4+X4
        TqKLEnyMR0LZ70u3akRlGlI=
X-Google-Smtp-Source: ACcGV62lG2WBiRm2Soays/lKFNIiOOnZ4XZyjjDNklYMTScpCE+AIpTCKKqhM8aXh237qHQEqjnD4Q==
X-Received: by 2002:a1c:5459:: with SMTP id p25-v6mr2282446wmi.129.1537919337999;
        Tue, 25 Sep 2018 16:48:57 -0700 (PDT)
Received: from a.local ([185.244.214.199])
        by smtp.gmail.com with ESMTPSA id a1-v6sm3600294wrt.9.2018.09.25.16.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 16:48:57 -0700 (PDT)
To:     tytso@mit.edu
Cc:     corbet@lwn.net, dreamingforward@gmail.com, ec429@cantab.net,
        fche@redhat.com, linux-kernel@vger.kernel.org, olof@lixom.net,
        riel@surriel.com
References: <20180921231545.GC2966@thunk.org>
Subject: Re: Code of Conduct: Let's revamp it.
From:   Michael Woods <michaeljpwoods@gmail.com>
Message-ID: <5339544c-085c-c168-4b80-037791fda42b@gmail.com>
Date:   Wed, 26 Sep 2018 00:48:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921231545.GC2966@thunk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/18 00:15, Theodore Y. Ts'o wrote:

 > People can decide who they want to respond to, but I'm going to gently
 > suggest that before people think about responding to a particular
 > e-mail, that they do a quick check using "git log 
--author=xyzzy@example.com"
 > then decide how much someone appears to be a member of the community
 > before deciding how and whether their thoughts are relevant.

 > There are a lot of strong feelings on this issue, and allowing people
 > who aren't members of the Linux kernel development community, to
 > escalate the rhetoric --- either in the pro- or anti- CoC direction,
 > and whether on mailing lists, github comment threads, Twitter, or
 > Reddit --- is not helpful.

Your contributions to the Linux Kernel, your years of dedication, are 
all irrelevant, simply because they have not prepared you and the other 
contributors for an SJW attack.

The majority of us software developers are going to be below average at 
social interaction, this is not meant to be disheartening, it is 
reality, one that puts us at a significant disadvantage when up against 
SJW's.

They will apply social pressure to subvert your organisation and unless 
you are willing to learn what an appropriate response is, you will be 
defeated over time. Defeat means the current truly inclusive meritocracy 
will be handed over to political activists with no intention to 
contribute or maintain the kernel, they will milk it for all it is worth 
and then move on.

Luckily, one of the trade off's against lower social skills is above 
average intelligence. You all have the ability to learn the patterns of 
attack and appropriate response. Even if you do not believe this is an 
attack, but instead trust the CoC should be taken at face value, it 
should behove you to at least read up on recent events, the history of 
CoC's, their intended purpose and the fruits of their application.

The information is out there [1][2][3][4], I implore you to study it 
before throwing away one of the greatest achievements of our time.

Ted, as a now notorious "rape apologist" [5], you already have first 
hand experience of their social attacks, reality, truth & perspective 
are all irrelevant in the land of SJW's. Backing down or giving them 
what they want will be seen as a weakness to be exploited further. Stop 
pandering to them because it is more uncomfortable to stand your ground, 
learn how to attack back or you will have no position from which to pander.

Regards,
Michael

[1] https://twitter.com/Grummz/status/1041818086024798208?s=19
[2] 
https://www.amazon.com/product-reviews/9527065194/ref=cm_cr_dp_d_cmps_btm?ie=UTF8&reviewerType=all_reviews
[3] https://voxday.blogspot.com/search?q=code+of+conduct
[4] http://paul-m-jones.com/archives/6926
[5] http://archive.is/6nhps

