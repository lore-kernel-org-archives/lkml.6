Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-799430-1519067265-2-6325366871790691056
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
    t=1519067264; b=CuIuGtnAfR/XLC0Edi+s9uWaqG+OtiZvX2fHiAeM9xdBP6N
    IUXnNPtamZKrW2nOk/EoNAZAetm8JrL0wrWiaii2DxnKESz4QkOUCWSxjSe5Zlqt
    UXC+0pV6+2Rm5RrAVmX0A+a4R4Dia7ScpjZ4ywv/hK5UHBc7ApeS9Su+Bi8HUGgk
    Kec9FegJA9G+pk7f6hGyyYWaSjz6vGtvo6tOLkYhkFfYQrthA1coQAD9IIBLOYAE
    QzVQkAm1/QWr5c9ZNndyeBwf3V1g9RtZPD7QVfIiZnPitDBtXg7wmYzjMAc66hjW
    9fMLL+sc4HNcFyj/R83KZhL0Eaie9dFZzhP2RyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519067264; bh=n3FoBgCQj7FRf6SlNP1aATchYEvt3p7wQaurFB
    ZGnWc=; b=oABq1fgkhSk1bx2akDjPn71j+5WWcdze24zs0zXG4YdYYtLmeLBr2c
    fXKxl9Bl4Ec63aUGa5dAVeUATey9d9+nDtoz5KF0lNigzS6uaUflGR8jhVDRaPd1
    ruGRsbC8G2d09mnMQigF4ANqxzOCC3eFQKIK37zTv0FyQ9C5hk9ln1r479TT+BCH
    6SGz7zLpOR5TPrRBIRS3h7xgk/rq0Wy7jGW3sYS9XSOfsvx+TG/fPzxYVcpuKwE2
    i77b41BcYbjHYxjATQAXjuoha3tl4+cGgR9+EhAUo/5S7DLvTwdJsQVou7IR663H
    O2xl/rqTd48abC7rkrNaiFOfj3sN2sxw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ns46GV4M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FQAQnwHD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ns46GV4M x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FQAQnwHD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753473AbeBSTHc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 14:07:32 -0500
Received: from mail-yb0-f177.google.com ([209.85.213.177]:41266 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753371AbeBSTHa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Feb 2018 14:07:30 -0500
X-Google-Smtp-Source: AH8x226jxq69Usgcgsu2GDK+KpuSwDj4a0N60Jwbl2a90ooB/3FtgLKCqnGl77ZnheECVIS1X3GZZaDTzenKyFCsI4E=
MIME-Version: 1.0
In-Reply-To: <20180219135027.fd6doess7satenxk@quack2.suse.cz>
References: <CALvZod4PyqfaqgEswegF5uOjNwVwbY1C4ptJB0Ouvgchv2aVFg@mail.gmail.com>
 <CAOQ4uxhyZNghjQU5atNv5xtgdHzA75UayphCyQDzxjM8GDTv3Q@mail.gmail.com>
 <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com>
 <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
 <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
 <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com> <20180219135027.fd6doess7satenxk@quack2.suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 19 Feb 2018 21:07:28 +0200
Message-ID: <CAOQ4uxjkfTTJ7nxrtj8ZsKcsWfBz=J0RPv3N=u3JaskRgG9aWw@mail.gmail.com>
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
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

On Mon, Feb 19, 2018 at 3:50 PM, Jan Kara <jack@suse.cz> wrote:
[...]
> For fanotify without FAN_UNLIMITED_QUEUE the situation is similar as for
> inotify - IMO low practical impact, apps should generally handle queue
> overflow so I don't see a need for any opt in (more accurate memcg charging
> takes precedense over possibly broken apps).
>
> For fanotify with FAN_UNLIMITED_QUEUE the situation is somewhat different -
> firstly there is a practical impact (memory consumption is not limited by
> anything else) and secondly there are higher chances of the application
> breaking (no queue overflow expected) and also that this breakage won't be
> completely harmless (e.g., the application participates in securing the
> system). I've been thinking about this "conflict of interests" for some
> time and currently I think that the best handling of this is that by
> default events for FAN_UNLIMITED_QUEUE groups will get allocated with
> GFP_NOFAIL - such groups can be created only by global CAP_SYS_ADMIN anyway
> so it is reasonably safe against misuse (and since the allocations are
> small it is in fact equivalent to current status quo, just more explicit).
> That way application won't see unexpected queue overflow. The process
> generating event may be looping in the allocator but that is the case
> currently as well. Also the memcg with the consumer of events will have
> higher chances of triggering oom-kill if events consume too much memory but
> I don't see how this is not a good thing by default - and if such reaction
> is not desirable, there's memcg's oom_control to tune the OOM behavior
> which has capabilities far beyond of what we could invent for fanotify...
>
> What do you think Amir?
>

If I followed all your reasoning correctly, you propose to change behavior to
always account events to group memcg and never fail event allocation,
without any change of API and without opting-in for new behavior?
I think it makes sense. I can't point at any expected breakage,
so overall, this would be a good change.

I just feel sorry about passing an opportunity to improve functionality.
The fact that fanotify does not have a way for defining the events queue
size is a deficiency IMO, one which I had to work around in the past.
I find that assigning group to memgc and configure memcg to desired
memory limit and getting Q_OVERFLOW on failure to allocate event
is going to be a proper way of addressing this deficiency.

But if you don't think we should bind these 2 things together,
I'll let Shakeel decide if he want to pursue the Q_OVERFLOW change
or not.

Thanks,
Amir.
