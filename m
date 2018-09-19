Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C4C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7784D2151C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0IDB/X1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7784D2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732333AbeIST6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:58:06 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45949 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbeIST6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:58:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id j8-v6so2740707pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9l2m33GHJ5VL76KVIdzRs2ubLXkpFciCdrNe9m6S5N0=;
        b=0IDB/X1uTEmw5rBgRbzEvWGMZ2TWomVOcTMvtHnvXOpuakLAtU/NFoAHyGJYwlkh/G
         38/7/kNLWdaML73zF/CQIAa+2K3wIvwHgcj4a1foaaHzdoDXviEVc/s0yBynPZ1OO3Pv
         zQ5SvlPCYBtzeWzgijm2fDpIaf/kcMbX1QlhcHxvNdgR5E7xgtVw0If9BVXZ7jEJq02J
         O92uUkyKTPjNs7hI8TC3Y+gCrijraaoGN4CrtNLE5Nq36Vcv8FlpahjDyjpWG62KF5kC
         H28RVWZEyJufUkJyyD8XgeaC+Gg8P+3m7WXYt9wWIjutEj58e5Ka1vbX6VK5QPqljBEB
         q7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9l2m33GHJ5VL76KVIdzRs2ubLXkpFciCdrNe9m6S5N0=;
        b=Nn99IsqMn/4avBJ9I6ZthLoq3/4YnacuORQeYvz1Sxk/Jma2PDqjTbnKB29ceGuCsR
         HQrwOmYODX+68oNSoE0i99gk7s9T71VaCJvATDxhrToHMK9cHw7WfNL9JOXXbgoorD9D
         8jIOHfAkN1uOQdtRGadT+TzSLMQXZFCnVWUoNUDRiS6130gW7egQj2eogeHrmnsB/BbR
         6PV5yM1mlN79yOZrJwbJhLKqSAf3N1juNOdZ16abhVZP8sBAcXv5bLSIApkFer5KZ+xG
         2RjXBDzJ8hf5lcl20S6bK1HItkVxau4qw7QpNZC0OsCK3cXw1NNbhyhy+OXwWDfTGRZz
         K9fQ==
X-Gm-Message-State: APzg51Da+SUrAW+ShdQ0AZ6W0K2RaTedjCgznY/Xg/2MCLJnukz09JUP
        GFufYCawmWL9EccWWYx01+EvFQ==
X-Google-Smtp-Source: ANB0VdbHCim3GnXFuo01zrkFo5vZzAg00ijBnMi2jzc2T/j7bI1LnIeF9Hq4/yFUV11jNaHGIHb4ng==
X-Received: by 2002:a17:902:ac97:: with SMTP id h23-v6mr30411020plr.174.1537366798005;
        Wed, 19 Sep 2018 07:19:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:d17d:ebe7:1269:8d07? ([2601:646:c200:7429:d17d:ebe7:1269:8d07])
        by smtp.gmail.com with ESMTPSA id e26-v6sm27271177pfi.70.2018.09.19.07.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:19:56 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180919095536.GM4672@cisco>
Date:   Wed, 19 Sep 2018 07:19:56 -0700
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws> <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com> <20180919095536.GM4672@cisco>
To:     Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 19, 2018, at 2:55 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>=20
>> On Wed, Sep 12, 2018 at 04:52:38PM -0700, Andy Lutomirski wrote:
>>> On Thu, Sep 6, 2018 at 8:28 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>>> The idea here is that the userspace handler should be able to pass an fd=

>>> back to the trapped task, for example so it can be returned from socket(=
).
>>>=20
>>> I've proposed one API here, but I'm open to other options. In particular=
,
>>> this only lets you return an fd from a syscall, which may not be enough i=
n
>>> all cases. For example, if an fd is written to an output parameter inste=
ad
>>> of returned, the current API can't handle this. Another case is that
>>> netlink takes as input fds sometimes (IFLA_NET_NS_FD, e.g.). If netlink
>>> ever decides to install an fd and output it, we wouldn't be able to hand=
le
>>> this either.
>>=20
>> An alternative could be to have an API (an ioctl on the listener,
>> perhaps) that just copies an fd into the tracee.  There would be the
>> obvious set of options: do we replace an existing fd or allocate a new
>> one, and is it CLOEXEC.  Then the tracer could add an fd and then
>> return it just like it's a regular number.
>>=20
>> I feel like this would be more flexible and conceptually simpler, but
>> maybe a little slower for the common cases.  What do you think?
>=20
> I'm just implementing this now, and there's one question: when do we
> actually do the fd install? Should we do it when the user calls
> SECCOMP_NOTIF_PUT_FD, or when the actual response is sent? It feels
> like we should do it when the response is sent, instead of doing it
> right when SECCOMP_NOTIF_PUT_FD is called, since if there's a
> subsequent signal and the tracer decides to discard the response,
> we'll have to implement some delete mechanism to delete the fd, but it
> would have already been visible to the process, etc. So I'll go
> forward with this unless there are strong objections, but I thought
> I'd point it out just to avoid another round trip.
>=20
>=20

Can you do that non-racily?  That is, you need to commit to an fd *number* r=
ight away, but what if another thread uses the number before you actually in=
stall the fd?

Do we really allow non-=E2=80=9Ckill=E2=80=9D signals to interrupt the whole=
 process?  It might be the case that we don=E2=80=99t really need to clean u=
p from signals if there=E2=80=99s a guarantee that the thread dies.=
