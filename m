Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-116955-1525858345-2-4089116891179161989
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
    1525858344; b=GAwKmfWsrHffYv0nfhIv6rF00JDvZGzJq9iLb9DENJJ1aht2Z4
    8NYephzkIxF7Fk4gSa0Ddwhd1K7aXiTlQE0Oj3jGBNj80hMV130T8hz3DyEAooJG
    6YYF1/PINTcOzd3yTQXPVD+CXrnL5AyVd9m/t6qOuYf2rHft424Aj5LKKPZ7cFr/
    VnQUHJkpDdpFIFdCPrhlPeNXpX8gzRxokw0TCuHhTeMfombGZnSMEvTmnMFA/VY9
    R76k8WnZz+1FyjxF0zH5msBBMsIElBE3eykxKj1ppCCXBgoMBDO8abPvCHSi194v
    dZHgg6MYzSWzztw0fL2i2mV+m1Afug0aILnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525858344; bh=BJxL+qF+UIjwzR6gGz4JXBnzyVIPhUDsNJCK7g13ES
    Y=; b=dHjCSQbD5JrvLeRzDpmJW+I/7/6TgSwkX9B8e32NrTf6825hbEjh1o5A+O
    Ik2Y+ryrHKfVUyFB7mLCAcRyXMvSRDLiMsUacwlK0vHrp+Sx0n6ENxIByKyxzn5d
    khiOMOzDvAVg0V+oPeyGb3IScl/EeQh96+CN94NmhfObdGMsjk+Sbl9IBp4iKIN9
    04thRSGyXVafYE5KgjMJvA6q6J+JmO8hD/uYCnt7qnW7jY8DD6uBqukkBfmZCCpd
    fSTylrrP1PE3vi4/QJ/kIFxNfxb6jXXYsd1uh4AaSuXegeybkaYQbSvVcuyKaSWn
    44hyKQo35gn6B0c3OvV4Lxd62dcg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=jkD8XBrK x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Ev8anKj0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=jkD8XBrK x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Ev8anKj0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO/lRtcDNZgK9QGumWRRZlPrvh35tZpONuUTvNzDedbUFSu23AM7tRsSIn9MbXZiTPVu6K+oo9hIgSbl+63N/xH7BIO3jSTagvp705OmAS2ySJgigBnl
    bFxCCx+5h+U6RfOTs57fRc20wuMgY7zHVL2ezX3Xe6nJ+EdF/ke3t0SPp4Y1ArsIb9V/SjfP5l4TINlg5pZNuf+QvK5ettjq3cRengLR+9K5uUPsb/jyZXXr
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=wkyhtgluJKQWSluCk9AA:9 a=QEXdDO2ut3YA:10
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933997AbeEIJcX (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 05:32:23 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41634 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933783AbeEIJcV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 May 2018 05:32:21 -0400
X-Google-Smtp-Source: AB8JxZoAcrkINm/C1Vz/Ie3xcR1rIXn0bWgHoSQJahS+3DsKbHLyALNCl2bhrBkZVhokzu3ikynyBfnSOeZ2p7vZ23M=
MIME-Version: 1.0
In-Reply-To: <20180509093023.7ex7lglfxo22stgn@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
 <20180509084128.s3nu57njyep4tw2w@vireshk-i7> <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
 <20180509091519.czq5zu5l7xfhqph4@vireshk-i7> <CAJZ5v0jekW=8-VbeVR5GZ6iTxj_oHiFAq7OWqzkAWktL2pU=CA@mail.gmail.com>
 <20180509093023.7ex7lglfxo22stgn@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 May 2018 11:32:20 +0200
X-Google-Sender-Auth: CpoxTgE03Z_Nf8OPQDWrzYJ3DO4
Message-ID: <CAJZ5v0jUgL48a4L6KnjUcCTMK8X2xtFB=tcDwmpXsX4FfrmGnQ@mail.gmail.com>
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

On Wed, May 9, 2018 at 11:30 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-05-18, 11:23, Rafael J. Wysocki wrote:
>> On Wed, May 9, 2018 at 11:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > On 09-05-18, 10:56, Rafael J. Wysocki wrote:
>> >> I'm kind of concerned about updating the limits via sysfs in which
>> >> case the cached next frequency may be out of range, so it's better to
>> >> invalidate it right away then.
>> >
>> > That should not be a problem as __cpufreq_driver_target() will anyway
>> > clamp the target frequency to be within limits, whatever the cached
>> > value of next_freq is.
>>
>> The fast switch case doesn't use it, though.
>
> cpufreq_driver_fast_switch() does the same clamping :)
>
>> > And we aren't invalidating the cached next freq immediately currently
>> > as well, as we are waiting until the next time the util update handler
>> > is called to set sg_policy->next_freq to UINT_MAX.
>> >
>> >> > What else do you have in mind to solve this problem ?
>> >>
>> >> Something like the below?
>> >>
>> >> ---
>> >>  kernel/sched/cpufreq_schedutil.c |    3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >>
>> >> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
>> >> ===================================================================
>> >> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
>> >> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
>> >> @@ -305,7 +305,8 @@ static void sugov_update_single(struct u
>> >>       * Do not reduce the frequency if the CPU has not been idle
>> >>       * recently, as the reduction is likely to be premature then.
>> >>       */
>> >> -    if (busy && next_f < sg_policy->next_freq) {
>> >> +    if (busy && next_f < sg_policy->next_freq &&
>> >> +        sg_policy->next_freq != UINT_MAX) {
>> >>          next_f = sg_policy->next_freq;
>> >>
>> >>          /* Reset cached freq as next_freq has changed */
>> >
>> > This will fix the problem we have identified currently, but adding a
>> > special meaning to next_freq == UINT_MAX invites more hidden corner
>> > cases like the one we just found. IMHO, using next_freq only for the
>> > *real* frequency values makes its usage more transparent and readable.
>> > And we already have the need_freq_update flag which we can use for
>> > this special purpose, as is done in my patch.
>>
>> So I prefer to do the above as a -stable fix and make the UNIT_MAX
>> change on top of that.
>
> Okay, that's fine with me. Will send the next version now :)
>
> Just to make sure, you are fine with the "Fixes" tag now (since you
> objected to that earlier) ?

OK, so to be clear, I'm going to queue up the simple patch I posted
with a FIxes: tag.  I'll resend it with a changelog shortly.

Then please send a UINT_MAX change on top of that and it won't be an
urgent fix any more.
