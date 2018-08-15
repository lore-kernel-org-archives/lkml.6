Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D337C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD47821654
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNSe0Qxs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD47821654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeHOMqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:46:22 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:43488 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeHOMqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:46:22 -0400
Received: by mail-qt0-f195.google.com with SMTP id f18-v6so539341qtp.10;
        Wed, 15 Aug 2018 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Je7JnHul4Q2zCr85gGCKADqEfW/GrYKh2pjlI/tt5Vg=;
        b=BNSe0QxsQ5kjRKufd4J6vrX00/XfAl3ZHTrPXW2gKAxv/t6HvuqMeCD98Yy4ozgL79
         hFVWYn/peYEC/3vs7kJIMGIHwffIxsGQZRNOhsz2puNE6uOey+LAcdFqeml3ZAmbPyQ3
         8wdJ7YPIf1Ie73yAmLJrCp+6NMsIPJlnQtfw1dewvx1q2qjCrsczzITUtt0fAvNmdY2V
         40mCTCH/cWPVUorb6vflNj4uU1ySyLWJ/440l02Qk2SOTe7v/EPUnQZnrS8WaDastGAe
         PxkrGwGQM9iQglJtqBjkMFjGynD7HwkBZStSpJYDL+M1idK4TgeOAMQhdMiZEcuOECKX
         w91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Je7JnHul4Q2zCr85gGCKADqEfW/GrYKh2pjlI/tt5Vg=;
        b=J6szXgm1Gg4f1uVx2iMgoH9U2TeXIwJ7WrajXQ3Wp1ftGtZ6Rf5X5ow/rY7nEZe+R3
         QAMnuJ2rRAZ6vgH3dCRjVB0iNVo/+VuO9oHmPchmXwb1IdOoaNcjbuaeiYFpMrgt8wg3
         ytSJynXsBvrSL0VkdzuH7/mb85Iw0DzxTaZANsWSQD1dv4MKVefOoNR6jx5uj5ndIUHo
         6d9A2qam+md6F1ZbyKoduxkODYfPsoricooAmVsjthp29nsArZhd4YL1tSacdaxNp2IU
         T7YqMxhlRYzc1Ok8pVyUgO1HD2EXnih4qkQeGhSa8uq56jp12TPPih0zraCQA7Gxtosr
         b70A==
X-Gm-Message-State: AOUpUlF+clkso3j8x/Ebha6HWe1HDgbSiVUl3lhps7zcXQva6u3qa7fx
        GXj0mYAvUvS6COwjEnQJrDSJdt5IYR2V42kf6Nc=
X-Google-Smtp-Source: AA+uWPxE+bcqtdMt7SdG8bRVVO7KwCkn0vQ2+3wtf4Iy/9OAeSzb/KkawcdrufnhxqxTtOl9NgeFR8htMI68aIwuWgA=
X-Received: by 2002:ac8:1bb8:: with SMTP id z53-v6mr25810261qtj.278.1534326892070;
 Wed, 15 Aug 2018 02:54:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9c4a:0:0:0:0:0 with HTTP; Wed, 15 Aug 2018 02:54:51
 -0700 (PDT)
In-Reply-To: <20180809004410.GF13767@linux-l9pv.suse>
References: <20180806203832.GA11751@embeddedor.com> <20180809004410.GF13767@linux-l9pv.suse>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Aug 2018 12:54:51 +0300
Message-ID: <CAHp75VeWpXGaMTEmcqCHojEMBUR_k1oHMXZ3+Vc-ydPkH1gW=Q@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: acer-wmi: refactor function has_cap
To:     joeyli <jlee@suse.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 3:44 AM, joeyli <jlee@suse.com> wrote:
> Hi Gustavo,
>
> Sorry for my delay!
>
> On Mon, Aug 06, 2018 at 03:38:32PM -0500, Gustavo A. R. Silva wrote:
>> Refactor function has_cap in order to avoid returning integer
>> values, when instead it should return booleans.
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Thanks for your patch and also thank Andy and Joe's help.
>
> Please feel free to add:
>
> Reviewed-by: "Lee, Chun-Yi" <jlee@suse.com>
>

Pushed to my review and testing queue, thanks!

> Joey Lee
>
>> ---
>> Changes in v2:
>>       Remove parentheses and unnecessary code. Thank you all for
>>       the feedback!
>>
>>  drivers/platform/x86/acer-wmi.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
>> index 8952173..3294bb2 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -672,10 +672,7 @@ static void __init find_quirks(void)
>>
>>  static bool has_cap(u32 cap)
>>  {
>> -     if ((interface->capability & cap) != 0)
>> -             return 1;
>> -
>> -     return 0;
>> +     return interface->capability & cap;
>>  }
>>
>>  /*
>> --
>> 2.7.4
>>



-- 
With Best Regards,
Andy Shevchenko
