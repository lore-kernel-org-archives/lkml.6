Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CAFC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D0A20C0E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uCjxIit1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D0A20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbeHGQQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:16:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35030 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389001AbeHGQQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:16:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so7170451plq.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 07:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QhUTb9FyYomCpmOxxMXrMWPiY/vK/QDBVv1rjI1y/PM=;
        b=uCjxIit1oWHsP/9DoWQ/mtOeiI67wnyUQiUQS+JQPVbQu0qgR/RxnsS+2LhkvuPxbd
         SpxCeO0EiP0CepAUzYIS8PHKYce9+cTRsFwYzwXO2AKHBISqKrCnj8PKJX0gEEH5rfwi
         oVQvoTV9O/9c9AeCbwFF+dWbTbo6SvkbHWyNLXr0uQ2ouzQqH5hoqOLI1/pmPkosIDuO
         43eJkNA7v2/2uAH0h7rYrcmuGsYuM6Nk5wVV9dy+fURN88DSEQAHeNzPkVdCFUOg7Bd4
         HGye4LUBx0rUiJMp3yRdfioTAK+ZtYXz4Py3Y/4ZW2mG4fMpkiCQhXjyCTTuskweePQk
         S4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QhUTb9FyYomCpmOxxMXrMWPiY/vK/QDBVv1rjI1y/PM=;
        b=GsQfT9+wpXBuSgD5YCTeKd3iHiaz2zABajrxWhOMwyFBtBFJtVs9IwnIH0ddR6RYG+
         bhc+YWjiurkgRPX+S6YrFrUyv0VZ+LBXHHMxbeGD4KbOg4Iaku/EKGuRDktDGocvg6xU
         aMtB7MLwM1UQe60jhGjXMz+GZAqb+VcHIPgm2qjNvJuCSihuqC2Y3ZKB2+wzCxgJcEV7
         hV/hvgCGt8Ha8+CI4og1Li+9UVjM9E9JNxKLDbKBR8cVq7IUdNHO4UfC3Jpx0P9f7xLM
         grS/2SslIswRe5CIa3nba3iA6URvy/31AzOissfccKtp0dsxbbjvAwOmnJdTSJCe5xbp
         jT6w==
X-Gm-Message-State: AOUpUlHIln7pqvDflqMsTy8WVZL/8Dp6jJktoKYWxbIYR8ScZkT3GfGL
        uvTrCBm4mclX1JpG0WdmzoamwQ==
X-Google-Smtp-Source: AAOMgpcuVdZvGepgqBbtBlqxQ1YP5lLATX48EvwXOQ3hZe8lGXZeyIoU/TGBaxQ1PytUU1FBIviAHw==
X-Received: by 2002:a17:902:740a:: with SMTP id g10-v6mr18185527pll.204.1533650535557;
        Tue, 07 Aug 2018 07:02:15 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:3c66:fcb8:2dc9:235d? ([2601:646:c200:7429:3c66:fcb8:2dc9:235d])
        by smtp.gmail.com with ESMTPSA id v7-v6sm7218790pgh.57.2018.08.07.07.02.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 07:02:12 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/2] x86: WARN() when uaccess helpers fault on kernel addresses
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <CACT4Y+YJzeTEOASJ8xu5uW_VFYqtoeBpywEC+x0nmFiac_=hJw@mail.gmail.com>
Date:   Tue, 7 Aug 2018 07:02:10 -0700
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel-hardening@lists.openwall.com,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <80A71AAC-89B0-448A-8FF6-FFF1B68270A2@amacapital.net>
References: <20180807012257.20157-1-jannh@google.com> <CACT4Y+YJzeTEOASJ8xu5uW_VFYqtoeBpywEC+x0nmFiac_=hJw@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 7, 2018, at 4:04 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>=20
>> On Tue, Aug 7, 2018 at 3:22 AM, Jann Horn <jannh@google.com> wrote:
>> There have been multiple kernel vulnerabilities that permitted userspace t=
o
>> pass completely unchecked pointers through to userspace accessors:
>>=20
>> - the waitid() bug - commit 96ca579a1ecc ("waitid(): Add missing
>>   access_ok() checks")
>> - the sg/bsg read/write APIs
>> - the infiniband read/write APIs
>>=20
>> These don't happen all that often, but when they do happen, it is hard to=

>> test for them properly; and it is probably also hard to discover them wit=
h
>> fuzzing. Even when an unmapped kernel address is supplied to such buggy
>> code, it just returns -EFAULT instead of doing a proper BUG() or at least=

>> WARN().
>>=20
>> This patch attempts to make such misbehaving code a bit more visible by
>> WARN()ing in the pagefault handler code when a userspace accessor causes
>> #PF on a kernel address and the current context isn't whitelisted.
>=20
> This is not triggerable unless there is a kernel bug, right? I mean
> this won't be a DoS vector? And any case is something to report to
> kernel developers?

Yes. I expect it to help fuzzers, since it will make a uaccess at a bad addr=
ess much more likely to oops.

My old series found one bug when the automated fuzzers fuzzed it. That bug i=
s fixed now.=
