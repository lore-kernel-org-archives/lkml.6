Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-135512-1525856259-2-5438575013266177760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525856258; b=XfB1eijMXJRrjJix0EbDzHvf4ZH4PBVti2kjRwotsnJ33j8kEU
    6ixko4F53+NJFHmv8PG+PPx4wmO4r58lArOSQAmdoahQuqTox9wNJcooU38T9WCM
    70SXa4AUCmRdNwmPusPdMyKIcGLYzD5EfgDmyOiYnGjDNXadIo4r9S4nZ5zfO9AR
    GCHO8z1vnfUMVaLkGDd8TuNn8QskG63IyO3qmJeEL2eZJzC+hSuEdP7kbQV2A70W
    8RxWLtr+yxC+MD0e4Z1V6PNKds0OQ+NGzqcOd4TmvQ9qIiB+/QQh2kT+UwIslmyl
    f2Ili282DD6xtmetlFUyKHRw0NBhJTLlV6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525856258; bh=Qpz8TzaRqVXe6hcgZRFtUE7OA0rsR8mIKzNNMVMbiL
    c=; b=nzppj6FJ9YDOlaI/dZxAGvcxoWemF9Tsktd6jNOjwh/3MNJGgWyxF/TWvS
    SzQ1laikD3Qf5Q/YKIWvcSujrOOoPx9o3mPF6403H46f90oXM6W+rnIHKhq0TdYA
    LlfQjwUTFdx0gmPajtOgdXimW1qCOU3sTJM7yuqIT7epAqXqqZWaTBlPh0vyFr7L
    1ToJ8XbhMBCqs2xZhlK320MJGqBsHyzEx8UGagApoYNrvfFcyZo+UVnoRRiI0Jn+
    X1T0geML7lZlMiBLNoC9BLIwcb35Xxw/gZPLwiv+mchS84FjXlpnWBlCsBryxGQt
    gY2Mq78ClxIa4cigix4DtjmSZ3Rw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=jzUxfPbH x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Vt1Vj1V6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=jzUxfPbH x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Vt1Vj1V6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3sg/el58LVbugKSf7oiaM6CikPMYB46y6zR5G2fZkO0k22Efy2O96Iwb7xFoHE9oiVkJblv92XuB7R2iMfGqkOTA8z1CZfIM+05nsbVxfwRAk6l8VB
    2mDaH7QCOqZBR7zXaNSqBjqRsouHE7UakBEb+v9DuVJDHfGBFn8AyihcFZgcDZulOLYlrqcuFUzJsEIYsK7zxkUOt6s3v88A9mQ0fr7dO0C0Qb/zSMOfEDWB
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=_cjZMXhcRvmONK7UQ0IA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeEII4W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 04:56:22 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38955 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbeEII4N (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 04:56:13 -0400
X-Google-Smtp-Source: AB8JxZougbbAUo/VGOQZc99D/K2r7O6FIYuRFde4rt3P2wuf8bXYP8GZXyy0YQOs1bDpG0/pk+yKjpb2nqgitf/eqJ0=
MIME-Version: 1.0
In-Reply-To: <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com> <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 May 2018 10:56:11 +0200
X-Google-Sender-Auth: 48xCDnMXOnadqWQxv_Bhs4LIamw
Message-ID: <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
Subject: Re: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        "4 . 12+" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 10:41 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-05-18, 22:54, Rafael J. Wysocki wrote:
>> On Tue, May 8, 2018 at 8:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
>> > occasions:
>> > - In sugov_start(), when the schedutil governor is started for a group
>> >   of CPUs.
>> > - And whenever we need to force a freq update before rate-limit
>> >   duration, which happens when:
>> >   - there is an update in cpufreq policy limits.
>> >   - Or when the utilization of DL scheduling class increases.
>> >
>> > In return, get_next_freq() doesn't return a cached next_freq value but
>> > instead recalculates the next frequency. This has some side effects
>> > though and may significantly delay a required increase in frequency.
>> >
>> > In sugov_update_single() we try to avoid decreasing frequency if the CPU
>> > has not been idle recently. Consider this scenario, the available range
>> > of frequencies for a CPU are from 800 MHz to 2.5 GHz and current
>> > frequency is 800 MHz. From one of the call paths
>> > sg_policy->need_freq_update is set to true and hence
>> > sg_policy->next_freq is set to UINT_MAX. Now if the CPU had been busy,
>> > next_f will always be less than UINT_MAX, whatever the value of next_f
>> > is. And so even when we wanted to increase the frequency, we will
>> > overwrite next_f with UINT_MAX and will not change the frequency
>> > eventually. This will continue until the time CPU stays busy. This isn't
>> > cross checked with any specific test cases, but rather based on general
>> > code review.
>> >
>> > Fix that by not resetting the sg_policy->need_freq_update flag from
>> > sugov_should_update_freq() but get_next_freq() and we wouldn't need to
>> > overwrite sg_policy->next_freq anymore.
>> >
>> > Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
>> > Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
>>
>> The rest of the chantelog is totally disconnected from this commit.
>
> I added the "Fixes" tag because this is exactly the commit after which
> this problem started, isn't it?
>
>> So the problem is that sugov_update_single() doesn't check the special
>> UNIT_MAX value before assigning sg_policy->next_freq to next_f.  Fair
>> enough.
>>
>> I don't see why the patch is the right fix for that, however.
>
> I thought not overwriting next_freq makes things much simpler and easy
> to review.

I'm kind of concerned about updating the limits via sysfs in which
case the cached next frequency may be out of range, so it's better to
invalidate it right away then.

> What else do you have in mind to solve this problem ?

Something like the below?

---
 kernel/sched/cpufreq_schedutil.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-pm/kernel/sched/cpufreq_schedutil.c
===================================================================
--- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
+++ linux-pm/kernel/sched/cpufreq_schedutil.c
@@ -305,7 +305,8 @@ static void sugov_update_single(struct u
      * Do not reduce the frequency if the CPU has not been idle
      * recently, as the reduction is likely to be premature then.
      */
-    if (busy && next_f < sg_policy->next_freq) {
+    if (busy && next_f < sg_policy->next_freq &&
+        sg_policy->next_freq != UINT_MAX) {
         next_f = sg_policy->next_freq;

         /* Reset cached freq as next_freq has changed */
