Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-116955-1525857329-2-13581632576661408863
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
    1525857328; b=kOf0MN03M5W/NGHrzCHrVyCBmlaXqeM8M5mjc13FdlCmSsVvk3
    7NKOPS3AKEbAGBTA7mtklZtqWDtUud4wcimNp24FR1CYV73UB4ZvpkkmzFQxN34Y
    72ekrl8Gx5NdWyS/9vUfxSpuo5EB5435YtXyctmwPvKKrbJgg7sZcUvC9XJShiGY
    8apjxCGaREFN0+zF87RqicALFJSrQSV2Wxzbcz7cCUtxdolx7kXDiuRwJUZh0ZAd
    wIEUBS6ts8y4+GpavRrdY3+uT5C4/71FCsGvPia2sBpwaeEO67jY8LzdXD/w7HYu
    056eNPX5ujk6UfHXci4wR2vXySwabWUIMKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525857328; bh=qdhqL6oU5gWbxAkSmwsUsgPTfvgr0q
    UyefDvcxnYKvk=; b=jqyydl41IhfD9OCcqCvlYiS/c689qkixPxeAZgLsAY177B
    5UPuW6/sG0pDz1m23bpsJRc7kXTetEEpV8BbjZvxd/3DRuczmZIjz8paSfvYmdN0
    SXKyJ6urrvO7v1pKbk2zOdkm8ue5FsezyM8rhdBZutfLX/DXAlqXstIPdGXtkVsq
    g88IQzByCikbpP2N72UgPK08XJNoXkK3mKSVwIusDAixyc/qOEp+Vkm9UQvrlcgb
    IO5taQ45X93Vo8k35GuT7u0gam7sC1hmqmokRfWTQOc+SyOzWaOjBq5RU35sRGFp
    7RXW/7z+LEGm1PENaz3+mWwEgPDat72yfJgsvJpg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=Rb1yhgFN x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=bc9IBQwM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=Rb1yhgFN x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=bc9IBQwM;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdxbvDJ8EUrSawGNQ6yzRVn7P6SyzoqQosdvtEWGTxAteok1XpYdQktvTtex/C2g8GvddDAQldwxSaVhGNcat4G4w3XjTJ6C6Y8X8ean2Aggm8KL+jw
    VpKbSGetHHyuM7LidUcgwMVIvah50dZq9hhq6C1jwVFUvVnoW1OwpPgXcroz6GXsFfATEIoZ1L/ZONkdoIDJUI2pwo57yMVWIzd5vG6OT87w03EQMNixqxmS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=0-aX22kvu7S2m3PKIPkA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934275AbeEIJPY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 05:15:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40789 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934318AbeEIJPW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 05:15:22 -0400
X-Google-Smtp-Source: AB8JxZrYtUQeqgpVXl8sec1lYRI+gwuNdTPYEluAGBB5GGUPiDzq0IZtCTyTd8aFLxN7lxWmc/Jv8A==
Date: Wed, 9 May 2018 14:45:19 +0530
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
Message-ID: <20180509091519.czq5zu5l7xfhqph4@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
 <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
 <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09-05-18, 10:56, Rafael J. Wysocki wrote:
> I'm kind of concerned about updating the limits via sysfs in which
> case the cached next frequency may be out of range, so it's better to
> invalidate it right away then.

That should not be a problem as __cpufreq_driver_target() will anyway
clamp the target frequency to be within limits, whatever the cached
value of next_freq is.

And we aren't invalidating the cached next freq immediately currently
as well, as we are waiting until the next time the util update handler
is called to set sg_policy->next_freq to UINT_MAX.

> > What else do you have in mind to solve this problem ?
> 
> Something like the below?
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -305,7 +305,8 @@ static void sugov_update_single(struct u
>       * Do not reduce the frequency if the CPU has not been idle
>       * recently, as the reduction is likely to be premature then.
>       */
> -    if (busy && next_f < sg_policy->next_freq) {
> +    if (busy && next_f < sg_policy->next_freq &&
> +        sg_policy->next_freq != UINT_MAX) {
>          next_f = sg_policy->next_freq;
> 
>          /* Reset cached freq as next_freq has changed */

This will fix the problem we have identified currently, but adding a
special meaning to next_freq == UINT_MAX invites more hidden corner
cases like the one we just found. IMHO, using next_freq only for the
*real* frequency values makes its usage more transparent and readable.
And we already have the need_freq_update flag which we can use for
this special purpose, as is done in my patch.

-- 
viresh
