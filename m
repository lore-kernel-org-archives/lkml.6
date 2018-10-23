Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5ADC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5962C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSzP/nKF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5962C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJXFGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:06:36 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:36661 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725761AbeJXFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:06:35 -0400
Received: by mail-lj1-f182.google.com with SMTP id s15-v6so2685295lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MI3HnYSW9R01g1QkagjdCVkYoGAaef8P3ar3yvh8UHg=;
        b=uSzP/nKFwUAWlOeluh9iuqC+oV66IcQHupa8rDwjCMLEkFmYfkii357eFal/W4Uv6Z
         7O31qbM2OQp+QEJphb8jOsmP+h16doJjRy7vRGgEZ49tyr5uW9hjHrugZr+pkTh97fe/
         0uDQUHrtsfkhgH7UZ1HBAN/PWtt1+THOlZzObm00xhhOGli7vNaGY9QyDJldjtWDY0Tk
         D+LYFaot8M8HMVLv2kmwxV0MYpzFRsaPtLgS3ts9sERgV/d7O+ZSgWy9tts1Lw8LP51w
         5DtY2GAy8ZUyKog5SUoEiSEiNc9WWf5twgF3jDbe3jrtdC0QkK+paY1a2D6U+WG6lGAM
         ZN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MI3HnYSW9R01g1QkagjdCVkYoGAaef8P3ar3yvh8UHg=;
        b=lh3SG4m2laDtcv03joMob24Rdsz+pYjkcwXG1gJ4fg34zwecoophadJgWuqrOLmPSE
         o/RT0hb3btoS6rXydNZntscOadYzufFOhIMjz1VoJXxY39gpyuFneZcg7Mm9ZGsXKP5L
         PC32xuj/k9+XGFveR6kJTqrXLYJUH8TMOIxi5HkurpIJ0VMhxTl0yaGdruhiYBJpuzOu
         Z4RvtW4GA/QRcBFtSI0b/hkmZfzo5CCB615GHX+FwEQvkvgTb46+H39NQkpwiu97tsys
         i1mR7m08x/VVEXujHxDKgsRjPdLw36glmPX+Pq4aEF6hJj9fN15UdkT5Fm9Ze6/5tu7K
         cDIQ==
X-Gm-Message-State: ABuFfoiYQyd5wONbxeQ7xiGQhusNf3TlNPG+K/qPSNaq4B7WymJeDGqS
        jtB0CvyFvbAifz0kIZpycAq3Yu5O
X-Google-Smtp-Source: ACcGV60QKEkiJRI0pr7D2UBxORj/14MFwbkNNcFVEEDG3vn/JMPmkZATu+S9Ht1YL6pDD4Fl6DhxMg==
X-Received: by 2002:a2e:8514:: with SMTP id j20-v6mr35718841lji.111.1540327291424;
        Tue, 23 Oct 2018 13:41:31 -0700 (PDT)
Received: from [192.168.1.18] (dks61.neoplus.adsl.tpnet.pl. [83.24.22.61])
        by smtp.gmail.com with ESMTPSA id 30-v6sm332179ljw.48.2018.10.23.13.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 13:41:30 -0700 (PDT)
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CAPDyKFrxJNM9TShLJhYm6L+Pp7F77u8FQ3Lk2WmatAma772btA@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <9ebaa11f-5406-c96e-52d7-4fba8770eb05@gmail.com>
Date:   Tue, 23 Oct 2018 22:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrxJNM9TShLJhYm6L+Pp7F77u8FQ3Lk2WmatAma772btA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/2018 02:13 PM, Ulf Hansson wrote:
> On 23 October 2018 at 10:41, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> So I've obviously started pulling stuff for the merge window, and one
>> of the things I noticed with Greg doing it for the last few weeks was
>> that he has this habit (or automation) to send Ack emails when he
>> pulls.
>>
>> In fact, I reacted to them not being there when he sent himself his
>> fake pull messages. Because he didn't then send himself an ack for
>> having pulled it ;(
>>
>> And I actually went into this saying "I'll try to do the same".
>>
>> But after having actually started doing the pulls, I notice how it
>> doesn't work well with my traditional workflow, and so I haven't been
>> doing it after all.
>>
>> In particular, the issue is that after each pull, I do a build test
>> before the pull is really "final", and while that build test is
>> ongoing (which takes anything from a few minutes to over an hour when
>> I'm on the road and using my laptop), I go on and look at the *next*
>> pull (or one of the other pending ones).
>>
>> So by the time the build test has finished, the original pull request
>> is already long gone - archived and done - and I have moved on.
>>
>> End result: answering the pull request is somewhat inconvenient to my
>> flow, which is why I haven't done it.
>>
>> In contrast, this email is written "after the fact", just scripting
>> "who did I pull for and then push out" by just looking at the git
>> tree. Which sucks, because it means that I don't actually answer the
>> original email at all, and thus lose any cc's for other people or
>> mailing lists.  That would literally be done better by simple
>> automation.
>>
>> So I've got a few options:
>>
>>  - just don't do it
>>
>>  - acking the pull request before it's validated and finalized.
>>
>>  - starting the reply when doing the pull, leaving the email open in a
>> separate window, going on to the next pull request, and then when
>> build tests are done and I'll start the next one, finish off the old
>> pending email.
>>
>> and obviously that first option is the easiest one. I'm not sure what
>> Greg did, and during the later rc's it probably doesn't matter,
>> because there likely simply aren't any overlapping operations.
>>
>> Because yes, the second option likely works fine in most cases, but my
>> pull might not actually be final *if* something goes bad (where  bad
>> might be just "oops, my tests showed a semantic conflict, I'll need to
>> fix up my merge" to "I'm going to have to look more closely at that
>> warning" to "uhhuh, I'm going to just undo the pull entirely because
>> it ended up being broken").
>>
>> The third option would work reliably, and not have the "oh, my pull is
>> only tentatively done" issue. It just adds an annoying back-and-forth
>> switch to my workflow.
>>
>> So I'm mainly pinging people I've already pulled to see how much
>> people actually _care_. Yes, the ack is nice, but do people care
>> enough that I should try to make that workflow change? Traditionally,
>> you can see that I've pulled from just seeing the end result when it
>> actually hits the public tree (which is yet another step removed from
>> the steps above - I do build tests between every pull, but I generally
>> tend to push out the end result in batches, usually a couple of times
>> a day).
>>
>> Comments?
> 
> Welcome back!
> 
> I have no strong opinions, in regards to the acks.
> 
> Your current approach, with no ack at all, just means that I have to
> do "git remote update" a few times, which I probably would have done
> anyways. So, to me, feel free to pick whatever option that makes the
> life easiest for you.

Same for me, I do the update anyway to see if and how my pull request
has been merged.

-- 
Best regards,
Jacek Anaszewski
