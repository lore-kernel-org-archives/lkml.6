Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A43CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28ED21A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="08drc+ZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28ED21A5D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbeHGFJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:09:26 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39422 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbeHGFJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:09:26 -0400
Received: by mail-pl0-f65.google.com with SMTP id w14-v6so875536plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xcU5s0zq+S+C3/XfTqo+2bFGESzmJcXjwcqmTC9OVrQ=;
        b=08drc+ZUhscLcGVoML4lmXmdKovMFFe89XIit64evh9mZqVtwDqp23xJincWq5S0Ld
         BbGBSMNPNjk+x4YqRL38Bs7GHPTSS+F6MMjRng1YeDzwMlbV6pij2mxyXiZIKLkwUp++
         xo3AnfvFeouPcv8MR6WCaa6Soy3FD5qT0tEj7lMbYsx4JWkBeNA9GNoRtJhWZJmhzc3Q
         RvwCSmqeqGj+oh9aNTJgudL03gXLJNCjmyzvNCP5UXH+fVZYmWJsOvhiA28yLEEV2GNN
         sp08HySK9Vir6mh928fcSkaAne2wSaiuXLblDunDHh+iM0rcR7Y4FQ29CofXKkZMhW3v
         yALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xcU5s0zq+S+C3/XfTqo+2bFGESzmJcXjwcqmTC9OVrQ=;
        b=CnSHGx0gdXCKJXZOzKI0Hon6t7k2Bq21R5ME046r4KuaH7gy/u4ENJXBM+AF8Mc0CG
         cR+RKOUuxILY7psIm9rEm0lNZ3AMN1Dj8vRYgP21ByPACE3dXP518RY5LgkisxGxhpfx
         szVghq81Gb51WdoVkfms0u0zkxX7p3m1jscSQR/U14x6Uo+qyndd1AFHuh3Hha4m7Sz/
         pk6CRW+Wuo3vPBqiHzXct2AZ+ROJaqWGXmTJyES0iNmq5h0dzmhCmtHB6Iza9oanYWwT
         SbUAeM6KT80yD7dxsWNYL5lrqJpqesyg+VWJJ1rzPUApTOZg/OPaf02MHIo+OEZHWv76
         EGYw==
X-Gm-Message-State: AOUpUlEgQhdUJ9Xks54bXF6/fm06kx+/GvwHSLYhgzZ99UYwrdj74NV7
        32iaghY4YVLMXMITvRQGegRbPg==
X-Google-Smtp-Source: AAOMgpebmWZ8dH/qqdQ+tsKLD8hzqlF0bkvbmVp28FsE2xXPRBt3sLIbV8uyo69ByAT9DJXVli6izg==
X-Received: by 2002:a17:902:123:: with SMTP id 32-v6mr15953127plb.181.1533610638071;
        Mon, 06 Aug 2018 19:57:18 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:2488:278f:2a98:5e65? ([2601:646:c200:7429:2488:278f:2a98:5e65])
        by smtp.gmail.com with ESMTPSA id e126-v6sm201759pfg.31.2018.08.06.19.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 19:57:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 0/4] seccomp trap to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <20180807024442.GA12274@cisco.lan>
Date:   Mon, 6 Aug 2018 19:57:16 -0700
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        "Tobin C . Harding" <me@tobin.cc>
Content-Transfer-Encoding: quoted-printable
Message-Id: <62CE9671-DECD-415B-8F57-9FCCE7922990@amacapital.net>
References: <20180621220416.5412-1-tycho@tycho.ws> <20180807024442.GA12274@cisco.lan>
To:     Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 6, 2018, at 7:44 PM, Tycho Andersen <tycho@tycho.ws> wrote:
>=20
> Hi all,
>=20
> Dinesh Subhraveti has claimed that some part of this series might be
> patented. While he has not furnished me with anything to confirm this
> claim, I'll put this series on hold.

That... is utterly ridiculous. Does LF have a mechanism to figure out wtf an=
d deal with it by, for example, filing for ex parte review.

Every microkernel ever should strongly resemble prior art.

>=20
> Tycho
>=20
>> On Thu, Jun 21, 2018 at 04:04:12PM -0600, Tycho Andersen wrote:
>> Hi all,
>>=20
>> Here's v4 of the seccomp trap to userspace series. v3 is here:
>> https://lkml.org/lkml/2018/5/31/527
>>=20
>> I believe we've addressed the two burning questions I had about v3: 1.
>> it seems ok not to use netlink, since there's not a great way to re-use
>> the API without a lot of unnecessary code and 2. only having return
>> capability for fds seems fine with people. Or at least I haven't heard
>> any strong objections.
>>=20
>> I've re-worked a bunch of things in this version based on feedback from
>> the last series. See patch notes for details. At this point I'm not
>> aware of anything that needs to be addressed, but of course that is
>> subject to change :)
>>=20
>> Tycho
>>=20
>> Tycho Andersen (4):
>>  seccomp: add a return code to trap to userspace
>>  seccomp: make get_nth_filter available outside of CHECKPOINT_RESTORE
>>  seccomp: add a way to get a listener fd from ptrace
>>  seccomp: add support for passing fds via USER_NOTIF
>>=20
>> .../userspace-api/seccomp_filter.rst          |  79 +++
>> arch/Kconfig                                  |   7 +
>> include/linux/seccomp.h                       |  18 +-
>> include/uapi/linux/ptrace.h                   |   2 +
>> include/uapi/linux/seccomp.h                  |  23 +-
>> kernel/ptrace.c                               |   4 +
>> kernel/seccomp.c                              | 491 ++++++++++++++-
>> tools/testing/selftests/seccomp/seccomp_bpf.c | 560 +++++++++++++++++-
>> 8 files changed, 1172 insertions(+), 12 deletions(-)
>>=20
>> --=20
>> 2.17.1
>>=20
