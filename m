Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-116955-1525855404-2-17736370932712660221
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525855403; b=Kj9rDGSCAosCNHnmuen56S+IPiiknFZjfanjQDTh0lXilTM2Ss
    X1q4hEdnifZe5R0AMZS3l8zpftjPh34HJEERDjcyNhfSSW9Gjv2pZWMfxkmtW5Sj
    +oYGZTo8JD9+DpQfoBPiQIO0M3wiN31PumZ4gBIRfeE2gZx9O28NvAsIhntw1y+U
    a5BQOTnLtmMxmYvK/uLPcVWGTyn6J+nqYFTIvLo2GsZnubN2yYC2uxKsTWWS77Dq
    FWyAU9MQ3j786iz/HsPQnmJjqB7GH4d9OUX7erVFWxF/2h9R9euLQm2m7gr+NnYq
    hDNLvWmaCLcB8eZHguLMjPADStTljAwqraRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525855403; bh=E4a3p1X31MfLLrSZ2x4omopjhbW05T
    FQB6HMqjK/pCs=; b=k5yzq6rdXqAGDzNZNiTBUpdf5WbgFp4WxPaOnhYYTkbWQf
    qDhlnlTgJPGifzs6MgH80W9AH488mT40hqPsw41TNbJHfu7v5XqUWg9NVm4OmKmg
    Awy+jHTKJ5+5bCfsor8huqLCCnIQFHJSiq7aEqdq3FPqOUA7HvAljfdz07BDrTyO
    PQX7Ilop05RaaxQFBzwVqrI8HVwhJjgFSuBJCkMxC+Gy+asYt7UiU/9ZXevjuaJ5
    Cb/HpW/tKDUIhxx6Ho5rJ31L1/QZi+Z8JpqI/My60wsEPAabQCyy+CsRcpwg50dK
    pFLuOejHc+9j0zryLEpmq8MsH9Es9KcnBodIHVhg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=InY10SqE x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=C5pXiGll;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=InY10SqE x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=C5pXiGll;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMxfkat3i0vCJdQYJ8RKlbYlqhn4qUmIzSMDF+XiXKCz4XSN56R42A3P+KhFGmlScmabbOiWeiG/hk3sCXuupX874OazPTvacLAINDdXeyjZV3Ms5OOE
    O14IY7spf4Xe0Y1rBlI0xEJjJ8acxiRmuzYWkOi6wt8+JeWFi15kYS8zT2D9BO0nIQzc5bfsX5pT9sZzyntwUGkshw1pIunmgjJcLBE5EQlqu7e6L9b0mhVP
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=yVi94ut6jKrYOMiKq2UA:9 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeEIInU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 04:43:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44097 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934344AbeEIIlb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 04:41:31 -0400
X-Google-Smtp-Source: AB8JxZo6AUZN/NFdJTXBzp5hNWwQXd5mlwUmgegj3wrNPWpeuH5soDX8DSN7Urc5kDk+RDVrFd4rUg==
Date: Wed, 9 May 2018 14:11:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
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
Subject: Re: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
Message-ID: <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08-05-18, 22:54, Rafael J. Wysocki wrote:
> On Tue, May 8, 2018 at 8:42 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > The schedutil driver sets sg_policy->next_freq to UINT_MAX on certain
> > occasions:
> > - In sugov_start(), when the schedutil governor is started for a group
> >   of CPUs.
> > - And whenever we need to force a freq update before rate-limit
> >   duration, which happens when:
> >   - there is an update in cpufreq policy limits.
> >   - Or when the utilization of DL scheduling class increases.
> >
> > In return, get_next_freq() doesn't return a cached next_freq value but
> > instead recalculates the next frequency. This has some side effects
> > though and may significantly delay a required increase in frequency.
> >
> > In sugov_update_single() we try to avoid decreasing frequency if the CPU
> > has not been idle recently. Consider this scenario, the available range
> > of frequencies for a CPU are from 800 MHz to 2.5 GHz and current
> > frequency is 800 MHz. From one of the call paths
> > sg_policy->need_freq_update is set to true and hence
> > sg_policy->next_freq is set to UINT_MAX. Now if the CPU had been busy,
> > next_f will always be less than UINT_MAX, whatever the value of next_f
> > is. And so even when we wanted to increase the frequency, we will
> > overwrite next_f with UINT_MAX and will not change the frequency
> > eventually. This will continue until the time CPU stays busy. This isn't
> > cross checked with any specific test cases, but rather based on general
> > code review.
> >
> > Fix that by not resetting the sg_policy->need_freq_update flag from
> > sugov_should_update_freq() but get_next_freq() and we wouldn't need to
> > overwrite sg_policy->next_freq anymore.
> >
> > Cc: 4.12+ <stable@vger.kernel.org> # 4.12+
> > Fixes: b7eaf1aab9f8 ("cpufreq: schedutil: Avoid reducing frequency of busy CPUs prematurely")
> 
> The rest of the chantelog is totally disconnected from this commit.

I added the "Fixes" tag because this is exactly the commit after which
this problem started, isn't it?

> So the problem is that sugov_update_single() doesn't check the special
> UNIT_MAX value before assigning sg_policy->next_freq to next_f.  Fair
> enough.
> 
> I don't see why the patch is the right fix for that, however.

I thought not overwriting next_freq makes things much simpler and easy
to review. What else do you have in mind to solve this problem ?

-- 
viresh
