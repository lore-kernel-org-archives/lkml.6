Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC5FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115CC20C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7O01kLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115CC20C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390001AbeGKRHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:07:45 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35720 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKRHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:07:45 -0400
Received: by mail-pf0-f169.google.com with SMTP id q7-v6so17708116pff.2;
        Wed, 11 Jul 2018 10:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=38CRE1CTP3NqrPzqPPVnkNeKIc+5NJNTkJvnrJedePE=;
        b=N7O01kLVE+UzJq+O9UR4xAjZXftrr4R2nJVMkFYWYR6y6aVUfMaHTwT8SwIONv2fc8
         WieX7fs/umPa6t6t8sly6n/AHw/3VMsuEm/EJSQagbEUCmBeSYWvRp07Rggs8Bdib3e2
         oIMcbdUOmKiS107UWPviE369ZqSNX1+43q4stI7SGWFKZQKxjv+GDIrkpTANSLJyp7lO
         fmVlT02JoP8UGH56pMrKO/VCTV/81gk12+/IiQfco/gbLmlQuSJsB+2yI3GPvAG05l30
         UNEs4D6Tc6Q+5VO9JFvzd2gQnAh+NUqZSHMKFjSQdPAHXCwHUM4iQcy83HFLEGPc86s/
         heEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=38CRE1CTP3NqrPzqPPVnkNeKIc+5NJNTkJvnrJedePE=;
        b=GYQWss0v6kzhs8w+g538QO/WoQ7BI2WQ9mHic6TPTYNYTg3Dc3hO/Slw3k+lOYl6Z5
         HXWbSB73RKHYkDvLRqNtUM0wM8xJ9SBIGiVafulJyASOmx5Rx0C3/2THxxW0cVNkWfYa
         VdSH3AloUsdncVKDz35kn6Ai5pLO494IehkKmOcAt2+NFM/uU+Yie15b6xw2cRwAPlX0
         emXif0YGJiI2bo6EfWWmKh9ZYyIU+gwphokVa5QeORk0ZNNYV7F4rs3gqf32TCrurUQJ
         VSa2eA0Bz5bS8FqeQFU2AtgP7Xcsd1pkcjE6T+pgwcr+hLTlcapQGfSB5RlL9Z8L01jL
         H1MQ==
X-Gm-Message-State: APt69E0sxWUsH4dm23FldtItDtSaIdxesyDox1Z9PlcLXfpN3l4vsJrw
        vtdIhssWGm8Oihev9sK5w7r6nG+39/7woqr3CT753A==
X-Google-Smtp-Source: AAOMgpfNQ9YuG+4VFUbAaO/f1H/cqAaRaK+fVVogaXUPzWLPE9sDc4MjPkQ/WVIIily1jIWxq/l1MTD+vdVMT4GqsmM=
X-Received: by 2002:a65:62ce:: with SMTP id m14-v6mr27335719pgv.407.1531328550930;
 Wed, 11 Jul 2018 10:02:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:1789:0:0:0:0 with HTTP; Wed, 11 Jul 2018 10:02:30
 -0700 (PDT)
In-Reply-To: <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
References: <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
 <CGME20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73@epcms1p2>
 <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com> <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
From:   noman pouigt <variksla@gmail.com>
Date:   Wed, 11 Jul 2018 10:02:30 -0700
Message-ID: <CAES_P+-=iictJKgHFGN2Mypp_+GMyTOVmZVQw=bSfHbyZMY4QA@mail.gmail.com>
Subject: Re: Re: devfreq relation with pm qos
To:     myungjoo.ham@samsung.com
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 10:58 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
>> + dev freq maintainters.
>>
>> On Mon, Jul 9, 2018 at 3:37 AM, noman pouigt <variksla@gmail.com> wrote:
>> > folks,
>> >
>> > I am trying to figure out the relationship between PM QOS
>> > with devfreq framework. I see this thread[1] where MyungJoo
>> > talks about QOS and devfreq but that control is through
>> > sysfs but I don't see any relation of pm qos (kernel/power/qos.c)
>> > with devfreq directly as devfreq is not calling any of the QOS
>> > api's. Is this intended?
>> >
>> > Isn't QOS value update using pm_qos_update_request has a
>> > direct relation with devfreq drivers i.e. setting the value to
>> > high or low selects the corresponding voltage and frequency
>> > setting in devfreq framework? I went through the devfreq
>> > drivers and couldn't find that relationship. Is this by design or
>> > I am missing something very obvious?
>> >
>> > [1] https://lwn.net/Articles/484161/
>
> Hello,
>
> Unfortunately, the suggested concept in the referred article was not ever
> accepted in the mainline.

MyungJo, I am trying to understand the relationship of PM QOS with
devfreq drivers. I don't see any relation of PM QOS api's with devfreq driv=
ers
directly as there are no QOS apis used in the devfreq framework.

The only explanation I have is that PM QOS has direct relationship
with CPUFREQ driver and as CPUFREQ driver works with CPU
frequency and that CPU frequency directly affects DEVFREQ drivers
as devfreq driver maps CPU frequency to device frequency and
that is why PM QOS doesn=E2=80=99t have direct relation with PM QOS.

Is my understanding right?

>
> Cheers,
> MyungJo
