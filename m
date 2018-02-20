Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3650906-1519154789-2-12134105715597369976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519154788; b=p598Z5OCoQiD5a/lLzkZescYvSTUkxN9EaaNHCMbxp3UViu
    k4zMgN7wvV9zkL8k3MdvCARDbkTQqnSIjEt89lGvCM0AQE6XRNhjd6w/7Lga793k
    I+rlLBn2G/W0+SNHf6WNOsOLD3Rqzo+8FFGkzqq6xLi2TShxxm/cW1F+tm2HnqY4
    ryXFPxBlfQIRs2nCfATjl6sKUXWxOR1nKU+aywJ0rgvY606jUTCZbcPfETIqtYXt
    KM0MiuCsqG19skdP4hmdm9uveAiQbhpxFpi5XhLkc82o1nqaNuqRlulB2cI7Ggoe
    8pq1IOkDaDM1o1WJtgKgBGOES1ABqdi7m15I4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519154788; bh=zgMVRSBGtSUOnZk96/U+GsSECo++cljYb2GnKa
    fdCLo=; b=Af7+KRH4DLDuLDIcr9rpsDYan76JHnQgPR0W6i/Qc48O0oEGwiBkqM
    WGILwxQOLRX0eXaG1vbVxg1ezeuZzJDN8UGtOzd+JEqI/zd/ppjOXb64BVIhr7f+
    CAhqsOBJUVz9oGb4OiYJ/j4gLKFuHvpNj6jNgWBViEnlOiSvJDNeQ1UOrNeq0Imj
    GvZiDi6ZZQuBbcsHCHVbIRjQ42pNGQNcw0RDP+h4jAJeTpq4LA/b1qjmtjuKAM36
    Ti2K0MR86rP8ii/n7DkJGhzgnZLRjUC2ylBDsA2M5Ai5/eagQ67yiocdiZ113BHP
    nzhenlTRwy68nOtoMZwm9wDTyzLDGlQw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=vUKJ7ERu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g4DP0jWz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=vUKJ7ERu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g4DP0jWz;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeBTT01 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 14:26:27 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:38756 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeBTT01 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Feb 2018 14:26:27 -0500
X-Google-Smtp-Source: AH8x225VTAtcjrn7OzF9DssTqVIx3bAFNSuvhjf0FU00T23t93VSUofKM3hwTleJIh6jzIwp2fKPGuB/DHZYpWCazbE=
MIME-Version: 1.0
In-Reply-To: <20180220124354.6awua447q55lfduf@quack2.suse.cz>
References: <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com>
 <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
 <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
 <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com>
 <20180219135027.fd6doess7satenxk@quack2.suse.cz> <CAOQ4uxjkfTTJ7nxrtj8ZsKcsWfBz=J0RPv3N=u3JaskRgG9aWw@mail.gmail.com>
 <20180220124354.6awua447q55lfduf@quack2.suse.cz>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 20 Feb 2018 11:20:15 -0800
Message-ID: <CALvZod6c-hUJ0b0Hr4wE9dy32Wz0Y=2UuwEMLNG3hYQ9srYEAA@mail.gmail.com>
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 4:43 AM, Jan Kara <jack@suse.cz> wrote:
> On Mon 19-02-18 21:07:28, Amir Goldstein wrote:
>> On Mon, Feb 19, 2018 at 3:50 PM, Jan Kara <jack@suse.cz> wrote:
>> [...]
>> > For fanotify without FAN_UNLIMITED_QUEUE the situation is similar as for
>> > inotify - IMO low practical impact, apps should generally handle queue
>> > overflow so I don't see a need for any opt in (more accurate memcg charging
>> > takes precedense over possibly broken apps).
>> >
>> > For fanotify with FAN_UNLIMITED_QUEUE the situation is somewhat different -
>> > firstly there is a practical impact (memory consumption is not limited by
>> > anything else) and secondly there are higher chances of the application
>> > breaking (no queue overflow expected) and also that this breakage won't be
>> > completely harmless (e.g., the application participates in securing the
>> > system). I've been thinking about this "conflict of interests" for some
>> > time and currently I think that the best handling of this is that by
>> > default events for FAN_UNLIMITED_QUEUE groups will get allocated with
>> > GFP_NOFAIL - such groups can be created only by global CAP_SYS_ADMIN anyway
>> > so it is reasonably safe against misuse (and since the allocations are
>> > small it is in fact equivalent to current status quo, just more explicit).
>> > That way application won't see unexpected queue overflow. The process
>> > generating event may be looping in the allocator but that is the case
>> > currently as well. Also the memcg with the consumer of events will have
>> > higher chances of triggering oom-kill if events consume too much memory but
>> > I don't see how this is not a good thing by default - and if such reaction
>> > is not desirable, there's memcg's oom_control to tune the OOM behavior
>> > which has capabilities far beyond of what we could invent for fanotify...
>> >
>> > What do you think Amir?
>> >
>>
>> If I followed all your reasoning correctly, you propose to change behavior to
>> always account events to group memcg and never fail event allocation,
>> without any change of API and without opting-in for new behavior?
>> I think it makes sense. I can't point at any expected breakage,
>> so overall, this would be a good change.
>>
>> I just feel sorry about passing an opportunity to improve functionality.
>> The fact that fanotify does not have a way for defining the events queue
>> size is a deficiency IMO, one which I had to work around in the past.
>> I find that assigning group to memgc and configure memcg to desired
>> memory limit and getting Q_OVERFLOW on failure to allocate event
>> is going to be a proper way of addressing this deficiency.
>
> So if you don't pass FAN_Q_UNLIMITED, you will get queue with a fixed size
> and will get Q_OVERFLOW if that is exceeded. So is your concern that you'd
> like some other fixed limit? Larger one or smaller one and for what
> reason?
>
>> But if you don't think we should bind these 2 things together,
>> I'll let Shakeel decide if he want to pursue the Q_OVERFLOW change
>> or not.
>
> So if there is still some uncovered use case for finer tuning of event
> queue length than setting or not setting FAN_Q_UNLIMITED (+ possibly
> putting the task to memcg to limit memory usage), we can talk about how to
> address that but at this point I don't see a strong reason to bind this to
> whether / how events are accounted to memcg...
>
> And we still need to make sure we properly do ENOMEM -> Q_OVERFLOW
> translation and use GFP_NOFAIL for FAN_Q_UNLIMITED groups before merging
> Shakeel's memcg accounting patches. But Shakeel does not have to be the one
> implementing that (although if you want to, you are welcome Shakeel :) -
> otherwise I hope I'll get to it reasonably soon).
>

Thanks Jan & Amir for the help and explanation. I think, Jan, you can
implement the "ENOMEM -> Q_OVERFLOW" and GFP_NOFAIL changes better
than me. I will send out my patches with minor changes based on
feedback but I will let Andrew know to keep my patches in mm tree and
not send for upstream merge. Once Jan has added his patches, I will
Andrew know to go forward with my patches.

thanks,
Shakeel
