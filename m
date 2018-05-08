Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3380544-1525812877-2-6055880431481930028
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
    1525812877; b=YNWHtfx/zL5SDMHqceLnWMUoF4naPUG9tV+FYy0WobNrL8WGUj
    X6fsG0MYzwgU5+sgPqjQHNp0pS4oJCIZUkzX1vIQj/nrnmNKjWApowzWQGH2TV8X
    VgyY4YIOosYp3/RRv3wf9zdewfyHkKr3WXX/k1qzXLNcQg4f7edRBL4oyh3Jz0r0
    xb1pslMwz3q5v110k4SNVF0hhg2fXLadkRvY+RLcDuYgrm9JivEBebKT0nsRFHVf
    Svnp7cYvg7Gu2V8+HGQ/zWlNOt6pw3yiI0M/twLQ2lU078e3I+UgBCkWHhqxtywP
    JPyCaEf2qkhCuXdViSbFRmxJrqoHOTiadGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525812877; bh=rhFYIfW5Rtjauh7W+dKpZN3VzqIeCmk6bEg/TmcJgw
    0=; b=MNZrk2XgkCg7osp5yjmjo202TAX3eKIn5UZ2E9bRnWnPQSpoLSltq5c311
    wIDe3RmICRSzKrUxgeAfJInY8L+DC/tgFfaw6+yNtngGH5duY8RIuOMKSS7xrJYK
    +5vkK2wZpJd1F96y+i8yXF0MseOr/LnyXXPVqSzOJrHZVmql5QsYaO/43RSfuAix
    PeFtZo6s1RmrMbKYE+iY3L7XW0lOzCZvRVAxzZuVDMSRI4ic6oW6a+EIuvyRUqkj
    JyWCYhVWe8e8GQJDRt/kf3bagTwbhfG2dSlHmmGllcZUo/bkVWOOJZaCnNJl7l4/
    0MitrXD7iY+H9wvMdrOo7mnXakKw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=JtC7wWoz x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=TGZc8RC0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=JtC7wWoz x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=TGZc8RC0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnPwBtZvq+TUalCB43olsmxn3CBlXGz9oJFMqNLEv+skVip4BmeJxBUCo5HNChW9VxEgwmQ8cdOZOErAdQfzUfii2KSqyYUqifIkzwQEbqbW/YViPuf
    R/SDWInqBQpmlTpdh9Fm3SkexpakKlu9IZuoldHyefHqlG3SBWIQtJkkeZYjCMOWuKZhzub29VtiBaH8HmgbTXizluFWj92SGjyhgvlOPQDWb86Aq3Wn7h/+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=Ri5R46onNRsf3SE2KIEA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932433AbeEHUye (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 16:54:34 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:40497 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932418AbeEHUyd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 16:54:33 -0400
X-Google-Smtp-Source: AB8JxZqn3r0qyVrcsswo6yD02cSlI8N1q9RW/mxATKzhwAaX1pxWV2jm+rLMx1sbUcpfqKHgrT5PdqI8QcT922wclCs=
MIME-Version: 1.0
In-Reply-To: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 May 2018 22:54:32 +0200
X-Google-Sender-Auth: jMnB-cC4UPhKOrODRdjq1ZTrBOk
Message-ID: <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
Subject: Re: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>,
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

On Tue, May 8, 2018 at 8:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
> occasions:
> - In sugov_start(), when the schedutil governor is started for a group
>   of CPUs.
> - And whenever we need to force a freq update before rate-limit
>   duration, which happens when:
>   - there is an update in cpufreq policy limits.
>   - Or when the utilization of DL scheduling class increases.
>
> In return, get_next_freq() doesn't return a cached next_freq value but
> instead recalculates the next frequency. This has some side effects
> though and may significantly delay a required increase in frequency.
>
> In sugov_update_single() we try to avoid decreasing frequency if the CPU
> has not been idle recently. Consider this scenario, the available range
> of frequencies for a CPU are from 800 MHz to 2.5 GHz and current
> frequency is 800 MHz. From one of the call paths
> sg_policy->need_freq_update is set to true and hence
> sg_policy->next_freq is set to UINT_MAX. Now if the CPU had been busy,
> next_f will always be less than UINT_MAX, whatever the value of next_f
> is. And so even when we wanted to increase the frequency, we will
> overwrite next_f with UINT_MAX and will not change the frequency
> eventually. This will continue until the time CPU stays busy. This isn't
> cross checked with any specific test cases, but rather based on general
> code review.
>
> Fix that by not resetting the sg_policy->need_freq_update flag from
> sugov_should_update_freq() but get_next_freq() and we wouldn't need to
> overwrite sg_policy->next_freq anymore.
>
> Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
> Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")

The rest of the chantelog is totally disconnected from this commit.

So the problem is that sugov_update_single() doesn't check the special
UNIT_MAX value before assigning sg_policy->next_freq to next_f.  Fair
enough.

I don't see why the patch is the right fix for that, however.

Thanks,
Rafael
