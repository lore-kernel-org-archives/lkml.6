Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-116955-1525858229-2-7424315339449328726
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
    1525858229; b=EyKSvBRawKUaDq80YGx9YnGS2w74wf4mAjy8ul2afmCe3NSRwY
    2ej9R5kPTQ/5EZym11xJWi98ZSGXHBLL2rpPfRtV8BttwSF7A/qmZSe7eo/Ry6v7
    1paSTux9uBaLSYREAKq/05BTjlvXIL3jA1RydC7FaCLFjl6o3aU4t+RKA7yoOrUd
    z/AiwXwAQueBgaSLQC//a6c+sM9fjhXkLAgj53L2StoOxOS2Tf1ebzOjOyfPoiEE
    TUAvOpcqpUE16EQ6oU3ywhYhj5DdXAZnETp3MIT2opwvROr0CzT7CyQdhrObMYxe
    qbtGychHc5r1HD/n41LZVMah9qEAptxyGrag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525858229; bh=r6NPjlfjByQTGygodhHAdTqqstUzLC
    Zs/WVrYpwNf7o=; b=E0lvd38i6tWvabkk81i5VgzzK/18JxmaWRLyksioJMLfd2
    Zulia6Wir+veX9ZUTktc3cRh6WG/hEXFsa5DaD6pMzQKv8Pt1pkiWOl898+BEfve
    fE2IHt9ewMsi9kmfpA47qxd4QkJSvq1zCQMrRcS6zadRPdL8pHVxizuy3WHO5tH6
    OFrzqeQpufWxbCnMTEMeUTtDXAGO1G7JS+HJZUq1R0JwdRuqS8ZHRyX9KGeVTTqa
    XFg8+zwJ/WlcOJyZ4HUSfhFpruZfVRhiJa4ggBEIxIqRvK6Skz+ANXOfs3xeG6q/
    c5Vlvc+c6cqbYCGHwtUPYUuhAZdS2x1mPWerfDcA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=kEzdNrUT x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=ZvKurkrs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=kEzdNrUT x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=ZvKurkrs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD+unibXsFMEvXnSdSjEYp5X9iWmJmwEiwsTBq0nZUfm2qZu6IaGkuy8e1+Hqhk++BzZMxHXN4GsFiHmzWrMRiXY8i6glfLOluiGnhYF09nWINr4CkEp
    fKr+pC2Hr5J8hYLULBmGFKe90l+x/O/YipnPp4SmywJRsYi58bt1jmf7jcbXbJgugLKMwp9/ltd4Jb88yzvfH8bAd2CiHRr9nVEsGs0kF53zNpjge3jUkcgT
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=qGAywPI5PTEc3dZ1OjIA:9 a=CjuIK1q_8ugA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755614AbeEIJa1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 05:30:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45344 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeEIJa0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 05:30:26 -0400
X-Google-Smtp-Source: AB8JxZpWKs/13JbeIC7vI7tizUYNXQ6gRgj6YRAKTEpQyex1NgH645bMcKlVXcxdaIwS6RPV+NBwMg==
Date: Wed, 9 May 2018 15:00:23 +0530
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
Message-ID: <20180509093023.7ex7lglfxo22stgn@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
 <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
 <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
 <20180509091519.czq5zu5l7xfhqph4@vireshk-i7>
 <CAJZ5v0jekW=8-VbeVR5GZ6iTxj_oHiFAq7OWqzkAWktL2pU=CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jekW=8-VbeVR5GZ6iTxj_oHiFAq7OWqzkAWktL2pU=CA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 09-05-18, 11:23, Rafael J. Wysocki wrote:
> On Wed, May 9, 2018 at 11:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 09-05-18, 10:56, Rafael J. Wysocki wrote:
> >> I'm kind of concerned about updating the limits via sysfs in which
> >> case the cached next frequency may be out of range, so it's better to
> >> invalidate it right away then.
> >
> > That should not be a problem as __cpufreq_driver_target() will anyway
> > clamp the target frequency to be within limits, whatever the cached
> > value of next_freq is.
> 
> The fast switch case doesn't use it, though.

cpufreq_driver_fast_switch() does the same clamping :)

> > And we aren't invalidating the cached next freq immediately currently
> > as well, as we are waiting until the next time the util update handler
> > is called to set sg_policy->next_freq to UINT_MAX.
> >
> >> > What else do you have in mind to solve this problem ?
> >>
> >> Something like the below?
> >>
> >> ---
> >>  kernel/sched/cpufreq_schedutil.c |    3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> >> ===================================================================
> >> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> >> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> >> @@ -305,7 +305,8 @@ static void sugov_update_single(struct u
> >>       * Do not reduce the frequency if the CPU has not been idle
> >>       * recently, as the reduction is likely to be premature then.
> >>       */
> >> -    if (busy && next_f < sg_policy->next_freq) {
> >> +    if (busy && next_f < sg_policy->next_freq &&
> >> +        sg_policy->next_freq != UINT_MAX) {
> >>          next_f = sg_policy->next_freq;
> >>
> >>          /* Reset cached freq as next_freq has changed */
> >
> > This will fix the problem we have identified currently, but adding a
> > special meaning to next_freq == UINT_MAX invites more hidden corner
> > cases like the one we just found. IMHO, using next_freq only for the
> > *real* frequency values makes its usage more transparent and readable.
> > And we already have the need_freq_update flag which we can use for
> > this special purpose, as is done in my patch.
> 
> So I prefer to do the above as a -stable fix and make the UNIT_MAX
> change on top of that.

Okay, that's fine with me. Will send the next version now :)

Just to make sure, you are fine with the "Fixes" tag now (since you
objected to that earlier) ?

-- 
viresh
