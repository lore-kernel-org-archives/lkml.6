Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B091C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5742087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0HBQh0hM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5742087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbeH1Xuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:50:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35612 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1Xuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:50:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9-v6so1193982plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tvb/DCvUeEbadK2R470HWzjykOMJBHLUW9W1lNObMAI=;
        b=0HBQh0hMCBxH3wU9DHE9sAGuNdB2Gpbzv+F2c48aoP0FaKsMEZfU8WxnsR2oaBCzHw
         7gVPq8yw+el5Khq0/TXRX7LVJ9RA+WeDviVV8yTp0nVodQDUvtCXbUvb4y29DcN10/Bu
         JHWiU5Dg+7yRv53o25UAUPix5To69LP0JbC9WhtQz6crP4UVirUHQ5JwcQj0BJ3PPgj/
         JPQdLIakw4+fswYSbCOWc8O7MCR7u9wljuZIt3H0PcKzYTqc4D+7RaM9/HQ0vzDKw7ck
         fP784onYk7DkJxyHFrwm18bAwD8b6dtSU2+pvPGt6J+5ugdS14wLSMFSV87PW0dP97ma
         bIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tvb/DCvUeEbadK2R470HWzjykOMJBHLUW9W1lNObMAI=;
        b=H/7wDTofUsT6z+m4GsRJOG/zS6ahX+1xgcSPSwohs7kpSarxoYQbqrCwInA2HPxgHO
         WTYwFj2d/8aBec43k/fpeCBAU6Xb1c/WUZ1/epdHI+gbhKiJiV1GsWTV95DOFaU//LkK
         3ppEjpoh6mTyy/JqaK9Kj1GqLumXcBq/zkHl0DHwmYxeMD6x5+WxeRBq59ef84+FKHrj
         rj/q4hUMyuHUQWAVeAveDlT84/WiJaKXpc4ln1flLX4eDpKEclP1p/v/NNB8aQ7ye/xK
         xIVKZhHztMVE9qL1txEpL9Xv+S5C01seFpg/Iwe7OicMEOv/fbmQMoT3MikD/xcxX93N
         C7hw==
X-Gm-Message-State: APzg51D7pMkTc6+ocXur93doAfDbCkLA7NhSRwdr3roWqB0RRpDyX7ZI
        C6jB5Yf1qW1J4TWNw/Kmel40AlCCQtQ=
X-Google-Smtp-Source: ANB0Vda0CHMQsi9aocBVcFmEeVyu6QZyBeAy/D0P0Tkq6UZKJv3yX0jhj0wF6eUyH+hf2o2Wu/IR9A==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17-v6mr2943180plo.9.1535486259989;
        Tue, 28 Aug 2018 12:57:39 -0700 (PDT)
Received: from ?IPv6:2600:1010:b006:491e:652e:b846:6d92:563c? ([2600:1010:b006:491e:652e:b846:6d92:563c])
        by smtp.gmail.com with ESMTPSA id c88-v6sm3112661pfe.132.2018.08.28.12.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 12:57:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/entry/64: wipe KASAN stack shadow in rewind_stack_do_exit()
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <daba9c5b-b5c6-beaa-ca96-81cf6af760b9@virtuozzo.com>
Date:   Tue, 28 Aug 2018 12:57:36 -0700
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA9DE24E-D1DC-4000-A9E5-0905C6433F04@amacapital.net>
References: <20180824235826.62741-1-jannh@google.com> <0897d173-6a30-09df-f16a-76322384fe0d@virtuozzo.com> <CAG48ez1zYqx8-1We3JkDBmYREksUMoUe7VBeAOv2JH98gVWcKw@mail.gmail.com> <daba9c5b-b5c6-beaa-ca96-81cf6af760b9@virtuozzo.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 28, 2018, at 4:33 AM, Andrey Ryabinin <aryabinin@virtuozzo.com> wro=
te:
>=20
>=20
>=20
> On 08/28/2018 01:38 PM, Jann Horn wrote:
>=20
>>>=20
>>>=20
>>> Why this has to be done in the rewind_stack_do_exit()?
>>> Are there any problems with calling the kasan_unpoison_task_stack(curren=
t) from oops_end(), before the rewind_stack_do_exit()?
>>=20
>> Ooh, good point! I didn't see that KASAN instrumentation is disabled
>> for dumpstack.c.=20
>=20
> It doesn't really matter. This would work with instrumented oops_end() as w=
ell.
> kasan_unpoison_task_stack() will unpoison everything including oops_end's s=
tack.
> It would be also ok if kasan_unpoison_task_stack() instrumented, or callin=
g any number of instrumented functions
> in between kasan_unpoison_task_stack() and rewind_stack_do_exit(). As long=
 as we return from these functions before
> the rewind_stack_do_exit(), the stack will be unpoisoned on return.

I think that, if all this is in C, we need rewind_stack_do_exit()=E2=80=99s c=
aller to be uninstrumented. Which it is.
