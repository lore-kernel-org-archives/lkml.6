Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2308197-1518597509-2-1020259301115621090
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
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
    t=1518597509; b=Gou4MTRTRoFn/AeZzHWxtPxA0WaH+SMihUCUyHnMJEO32tn
    e0ytfvVMoUI5s/j37VlF7ZNFm+2dxDzJjz0uBzEPlseefKZVSIikJhv4HZX5vXBk
    f6O37lyV2+9fxa/HokYwrUcONQJtdIiXLSUdgOGXWDLpFU/mWMPmwAUuHTj9O80L
    yG1PRTT/GY9YGedYpZnNXEKO+aR01moMaAnkw6X6+EFzu2q04koWmF1PWOiy+yka
    xh106T2GLlN8r23f1SLjZ9Cqf+iAvz2x0h8v3M8EbF3vdIK4uedHucZXguv4zOFK
    6M9RSA09YlccdzY1EoSm5tnhmrA4YMwVysXtUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518597509; bh=D9JGssGdOjALKstATSRTVYMZYQYfbnh39811Hd
    7j6pM=; b=SdZCOa1TwUeUFJxHCQ9l2wJXNloPqprN8jtoH0lgTaXDbH7UKre7Hf
    eoLUBCLx1YxJeEUL4STgRwGDo731DnpouIINGSFpJ7MkFLFUx4/1oexLZD8TecDy
    8UNiATEMTLCxNoFEyinT3iXF69NSZCA1wyoa0OV8of1hGm9CTDN1vKQy8iW2FyAh
    WWV+szycgfAVKVKb/uHuKdKFQiRTszgsp5dDQVGB9SkxeUlXpoys7vhckGHNjpty
    Q45rp9CijpWlItg+SFJA+X33lQzZ88m39rrXZfrQHVH9lsQVySR0fKCLHqlI+wRl
    PO+CK+JDd1auOEmig/Byvzx3SNbPzoBg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KcE2Pu+g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YRBAEn+7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KcE2Pu+g x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YRBAEn+7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754604AbeBNIiO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 03:38:14 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:39206 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbeBNIiK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Feb 2018 03:38:10 -0500
X-Google-Smtp-Source: AH8x226G2Be9X0vzXwuQvCJKl+KTgL2m831vL/hkjaaLCrE1fqAd1emdVaH0yLxThZpK2kdj2OPCHF5Kcn8cRjrjbhE=
MIME-Version: 1.0
In-Reply-To: <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
References: <20171030124358.GF23278@quack2.suse.cz> <76a4d544-833a-5f42-a898-115640b6783b@alibaba-inc.com>
 <20171031101238.GD8989@quack2.suse.cz> <20171109135444.znaksm4fucmpuylf@dhcp22.suse.cz>
 <10924085-6275-125f-d56b-547d734b6f4e@alibaba-inc.com> <20171114093909.dbhlm26qnrrb2ww4@dhcp22.suse.cz>
 <afa2dc80-16a3-d3d1-5090-9430eaafc841@alibaba-inc.com> <20171115093131.GA17359@quack2.suse.cz>
 <CALvZod6HJO73GUfLemuAXJfr4vZ8xMOmVQpFO3vJRog-s2T-OQ@mail.gmail.com>
 <CAOQ4uxg-mTgQfTv-qO6EVwfttyOy+oFyAHyFDKTQsDOkQPyyfA@mail.gmail.com>
 <20180124103454.ibuqt3njaqbjnrfr@quack2.suse.cz> <CAOQ4uxhDpBBUrr0JWRBaNQTTaUeJ4=gnM0iij2KivaGgp1ggtg@mail.gmail.com>
 <CALvZod4PyqfaqgEswegF5uOjNwVwbY1C4ptJB0Ouvgchv2aVFg@mail.gmail.com>
 <CAOQ4uxhyZNghjQU5atNv5xtgdHzA75UayphCyQDzxjM8GDTv3Q@mail.gmail.com>
 <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com>
 <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com> <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Feb 2018 10:38:09 +0200
Message-ID: <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com>
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
To: Shakeel Butt <shakeelb@google.com>
Cc: Jan Kara <jack@suse.cz>, Yang Shi <yang.s@alibaba-inc.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 3:59 AM, Shakeel Butt <shakeelb@google.com> wrote:
> On Tue, Feb 13, 2018 at 2:20 PM, Shakeel Butt <shakeelb@google.com> wrote:
[...]
>>>>> Something like FAN_GROUP_QUEUE  (better name is welcome)
>>>>> which is mutually exclusive (?) with FAN_UNLIMITED_QUEUE.
>>>>>
>>
>> How about FAN_CHARGE_MEMCG?
>>

I am not crazy about this name.
Imagine a user that writes a file system listener that is going to run
inside a container.
The user doesn't need to know about the container or what is memcg
and what is memcg charging.
IMO, we need to hide those implementation details from the user and
yet encourage user to opt-in for memcg charging... or do we?

>
> Also should there be a similar flag for inotify_init1() as well?
>

This question changed my perspective on the fanotify_init() flag.
Unlike with fanotify, for inotify, is it the sysadmin that determines
the size of the queue of future listeners by setting
/proc/sys/fs/inotify/max_queued_events

IMO, there is little justification for a program to opt-out of memcg
charging if the sysadmin opts-in for memcg charging.
Anyone disagrees with that claim?

So how about /proc/sys/fs/inotify/charge_memcg
which defaults to CONFIG_INOTIFY_CHARGE_MEMCG
which defaults to N.

Then sysadmin can opt-in/out of new behavior and distro can
opt-in for new behavior by default and programs don't need to
be recompiled.

I think that should be enough to address the concern of changing
existing behavior.

The same logic could also apply to fanotify, excpet we may want to
use sysfs instead of procfs.
The question is: do we need a separate knob for charging memcg
for inotify and fanotify or same knob can control both?

I can't think of a reason why we really need 2 knobs, but maybe
its just nicer to have the inotify knob next to the existing
max_queued_events knob.

Thanks,
Amir.
