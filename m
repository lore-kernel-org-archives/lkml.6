Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42978C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9C20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bjf+OLdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E9C20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbeGXJlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:41:35 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45095 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbeGXJlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:41:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id q11-v6so6051510oic.12;
        Tue, 24 Jul 2018 01:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2edkZhsucbfqfgAohD4K3v1bdSv0jAGAWmCrRVzDkMA=;
        b=Bjf+OLdj88qX7FzroAHt35UekaJzPpVCsZxB0eykw41wJy9D71Y1pwmqI596gNnb60
         DAg6xtBGWWrpn23IfguWc+0mIdv4sTGCDgjE5LLKMKQ4Z96tDmgnx5gpkTTJtwGC4cIF
         scFczkpN39JDKb5JK+JKJ7fe5U/e8XSdiU93LZviT2dlxbJHfBn456CGXU6JJICMxHp4
         F1wMwxdiBU4RGOJ4a5dJrwj8FDRohmByocHWAmfMzqCm0cK1akBBYZkAa7X2X3GNikSX
         0r1F5G0Ca/UNNVjMsPTXdNDVBh0nbhwR8q+zXaP/CEXzw2kqEqjBBMP63zZbvvlSqWTG
         KsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2edkZhsucbfqfgAohD4K3v1bdSv0jAGAWmCrRVzDkMA=;
        b=bE61VKsXWmp603gyTSbyf+mocZcQVAd1qYOlcCNMXXLjjROJ0TWFemjH7eAqG/FbtF
         BzVEbA+4uNPIqEByEehNOSSagEV78h55YAejvLJ+OCoINM2jix1CW8kmtJEybonwPn/S
         B/8LUfxcyFchWCanbznt/m8i2FqXHyIOEjRNsUQt587DF3QkiCgT7b1ZsrXltESfbVVX
         rcCc0l0bBEdrP1k+AQDzbiKBEWcHtGLM/b6p/yEaFEsEX9Z47RBJjC7j+QWldtR4gpUt
         uvHAySHOzZXqsmXQSAktzshOn6fi8HnQ47a6bA9IO7SDQhFDBaZFSH1fSJr27xD3bsgw
         FwAA==
X-Gm-Message-State: AOUpUlFqDI3jCWUe9hRHUM7TLBbpB0rjqTCvLqnzr30oqrI2rMJpvx3e
        Cq+oHXEoyLah78YDBjUH6MyTKAfZKSjs7Jh8DYU=
X-Google-Smtp-Source: AAOMgpfxm8uV+s3HGonUQTA5a1AnBWopqYuPV6HywiGPSwbV4LPYVrHR3Q4WR2VpxmN7Y11sdRPAb8QesC+QcMlJwtE=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr2041919oia.154.1532421373573;
 Tue, 24 Jul 2018 01:36:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:36:13
 -0700 (PDT)
In-Reply-To: <0306d1b7-85d2-5e50-2b7c-466f0e978afa@redhat.com>
References: <1532368179-15263-1-git-send-email-longman@redhat.com>
 <1532368179-15263-3-git-send-email-longman@redhat.com> <20180723191627.GJ2494@hirez.programming.kicks-ass.net>
 <0306d1b7-85d2-5e50-2b7c-466f0e978afa@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 10:36:13 +0200
X-Google-Sender-Auth: mbTHtGazxkD0b23FGAVaNOv3ZrQ
Message-ID: <CAJZ5v0jJzXsKUH+SH5_Qs8C-A2=AdOL_RgOonuv62rx1FBjaYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Fix a circular lock dependency problem
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 9:27 PM, Waiman Long <longman@redhat.com> wrote:
> On 07/23/2018 03:16 PM, Peter Zijlstra wrote:
>> On Mon, Jul 23, 2018 at 01:49:39PM -0400, Waiman Long wrote:
>>>  drivers/cpufreq/cpufreq.c | 16 +++++++++++++++-
>>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index b0dfd32..9cf02d7 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -922,8 +922,22 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
>>>      struct cpufreq_policy *policy = to_policy(kobj);
>>>      struct freq_attr *fattr = to_attr(attr);
>>>      ssize_t ret = -EINVAL;
>>> +    int retries = 3;
>>>
>>> -    cpus_read_lock();
>>> +    /*
>>> +     * cpus_read_trylock() is used here to work around a circular lock
>>> +     * dependency problem with respect to the cpufreq_register_driver().
>>> +     * With a simple retry loop, the chance of not able to get the
>>> +     * read lock is extremely small.
>>> +     */
>>> +    while (!cpus_read_trylock()) {
>>> +            if (retries-- <= 0)
>>> +                    return -EBUSY;
>>> +            /*
>>> +             * Sleep for about 50ms and retry again.
>>> +             */
>>> +            msleep(50);
>>> +    }
>> That's atrocious.
>>
>>
> I had thought about just returning an error if the trylock fails as CPU
> hotplug rarely happened. I can revert to that simple case if others have
> no objection.

Yes, you can return -EBUSY or -EAGAIN right away from here if the
cpus_read_trylock() is not successful.  There is not much reason for
the sysfs operation to continue in that case.
