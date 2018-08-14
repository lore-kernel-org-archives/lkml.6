Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8131FC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F802172B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsYr5nvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F802172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbeHNTX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:23:29 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:39419 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbeHNTX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:23:29 -0400
Received: by mail-qk0-f194.google.com with SMTP id b5-v6so13812438qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Pqmj3ClLJHm0NWuPcuK5T5mzzNcGqtnI3cr79Wbf/BE=;
        b=JsYr5nvjfZGsIkd4j3LjWGsU0CZexJlXnv+bhDZIWUoOZrcD0Jz3tRhkjZQG2+RCfy
         P1wGl7Xt4rD9FeR34KfEDqtvmauOUarEzdONy+ZMuel2gwAXO9nsdSfZVCOkFEZ3JQ/w
         yQtv3XqObH/MYh44UKcN7yZCFv4S/J5OWnh+9k5PKKZrvsQ5Ip5Ay2gjWyKKYLFGieQY
         4hTUpfSXFwPzFrOwVxDbKLaORsXcYQpFnXo1KS0mTNAM+MI6MRxIpcqErar9Ml6jd+ON
         nqXd5OtScVYYps5iocIFzZLd9IqpVH7UFE/WMd3gvYerTvBcS5S5icmDwAxvOZ9JscTO
         NARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Pqmj3ClLJHm0NWuPcuK5T5mzzNcGqtnI3cr79Wbf/BE=;
        b=a9+Be8yMQhSZGi6gEFQX5rZ/E0bAgah7RDzq9GPwVcNcOXh7hsbRaw1iA8ibO3/l5j
         9PEFNa06YHm2K90Q5pm/KVN2vqMiRjVDBwaDpQZWGVt7WMi9tEHZYHtDWstMcrAbT3DF
         KUbXsqdZCgwJ0WLvwTKQBlhOhbNvWD7XZNe0lJ8mR5jZ/ZzoKi7Uzt69bChGSsbJe5zh
         oUhJyvhsDHCTo9klplyJk3SmYwTDPxxL3Kl2GG0ozVOttSUSRxFjHWtj53Qhhf2rr6l1
         YcpvVTzW120ivoGOvm8Yne0Ya4kTavK2/ApPcgn/TBXP/FrO5GmrScZMSCsSYBuQ53RE
         bjhg==
X-Gm-Message-State: AOUpUlHlOn3RzoXQPP/kCaKf8unuOqdNXfVRP4oBLuPJU8Ib/jMf0vkY
        YYgk5+Ui343R/+a9ZhO27lDJgu3jdVjvhRzYkI0=
X-Google-Smtp-Source: AA+uWPwQPHjJpNg+Nt3nD0HCqFo3QCVn25BfaNtwuVjkAYuDcR2sYfxf/WjddMfk/u5g3ccOZpuW2+x+A1FkTwV+M9M=
X-Received: by 2002:a37:2916:: with SMTP id p22-v6mr20182515qkh.327.1534264535796;
 Tue, 14 Aug 2018 09:35:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:c3cc:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 09:35:35
 -0700 (PDT)
In-Reply-To: <58d21bac-5a31-85df-4b9f-05815b64f465@linux.ibm.com>
References: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
 <20180809041856.1547-4-ravi.bangoria@linux.ibm.com> <CAPhsuW49+qA7kT7yE4tgbnAuox-iOzssg-jc2abG8XDo6XeX8A@mail.gmail.com>
 <95a1221e-aecc-42be-5239-a2c2429be176@linux.ibm.com> <20180813115019.GB28360@redhat.com>
 <fa85d19f-b22c-e09c-b8d2-f68f0c79de15@linux.ibm.com> <20180813131723.GC28360@redhat.com>
 <CAPhsuW4KT=6vR_0ogTy_+Fwcz7cZ0Rac8sYohLngQmEBCd0HLw@mail.gmail.com> <58d21bac-5a31-85df-4b9f-05815b64f465@linux.ibm.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 14 Aug 2018 09:35:35 -0700
Message-ID: <CAPhsuW5YoX=5HVYWFNaBHOeM+opfA6waqMMCwLQy2YS_+2k6ng@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] Uprobes: Support SDT markers having reference
 count (semaphore)
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        ananth@linux.vnet.ibm.com,
        Alexis Berlemont <alexis.berlemont@gmail.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linux@armlinux.org.uk, ralf@linux-mips.org, paul.burton@mips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 13, 2018 at 9:37 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> Hi Song,
>
> On 08/13/2018 10:42 PM, Song Liu wrote:
>> On Mon, Aug 13, 2018 at 6:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>> On 08/13, Ravi Bangoria wrote:
>>>>
>>>>> But damn, process creation (exec) is trivial. We could add a new uprobe_exec()
>>>>> hook and avoid delayed_uprobe_install() in uprobe_mmap().
>>>>
>>>> I'm sorry. I didn't get this.
>>>
>>> Sorry for confusion...
>>>
>>> I meant, if only exec*( could race with _register(), we could add another uprobe
>>> hook which updates all (delayed) counters before return to user-mode.
>>>
>>>>> Afaics, the really problematic case is dlopen() which can race with _register()
>>>>> too, right?
>>>>
>>>> dlopen() should internally use mmap() right? So what is the problem here? Can
>>>> you please elaborate.
>>>
>>> What I tried to say is that we can't avoid uprobe_mmap()->delayed_uprobe_install()
>>> because dlopen() can race with _register() too, just like exec.
>>>
>>> Oleg.
>>>
>>
>> How about we do delayed_uprobe_install() per file? Say we keep a list
>> of delayed_uprobe
>> in load_elf_binary(). Then we can install delayed_uprobe after loading
>> all sections of the
>> file.
>
> I'm not sure if I totally understood the idea. But how this approach can
> solve dlopen() race with _register()?
>
> Rather, making delayed_uprobe_list an mm field seems simple and effective
> idea to me. The only overhead will be list_empty(mm->delayed_list) check.
>
> Please let me know if I misunderstood you.
>
> Thanks,
> Ravi

I misunderstood the problem here. I guess mm->delayed_list is the
easiest solution of the race condition.

Thanks,
Song
