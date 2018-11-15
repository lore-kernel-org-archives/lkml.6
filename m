Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7172DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D48C22360
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="upgnfF5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D48C22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeKOKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 05:45:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43590 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeKOKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 05:45:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id g7-v6so8757277pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7tyQljsrTZbCJzJ2P/VuLW6YOnQ4+ymJ1Iq+gyU7DFE=;
        b=upgnfF5kGxF66jIEziBof5uYC+SStkAE2FlwGj6uZtBYwS9651usP1UFCNMXelyGhQ
         XAl7PfAD1lRhfHoWpOxDiZ3eqpfH5Bxx4oKkogr/dQ9ZPuyUGWSNCXUcZlhCa5u/E89t
         PT2+VEUEQulJco6ofN6gxvuNoUa74OSuSH3AqNhjn58UWkPOE4n9mNC0tC6zdZ8wRAe9
         gsrMBRGi8+ScKKo9Ye1vvNf3qTmTqbZDPOs27uLtO/Ls+tQ7J7LuPQCI/AiQy/iC2cCm
         n3Tx2oW2pe/xXm4OxZMQvarCr5wzXSdyuf7SOF1mX+MjN4TPOYygsa6vi4yYLxwe80y2
         bXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7tyQljsrTZbCJzJ2P/VuLW6YOnQ4+ymJ1Iq+gyU7DFE=;
        b=rxr+72Nz3hKOb0P46CFW1AbxZmpCGb2SoD743OqSqmgGnbUKu0nTUYGb2XuCeILqeo
         Yy2LOmnSLEjGwuKkRuJgVnUvvB1ylWzgqjGMLl6hKkwVdyNWeNYTlwOjUPsJWxO5muw/
         /fMnlsDsd7ASAwSlfJSujv+VIKNpbkqt/mHPmUnc/4Pu17x2oo2ZRwx0avD3PXX04yDa
         +mq+ysyCJ5SY9ndCPDREqXjlk8NU3aVT2Ea66ymoHq0FP/Ps9RjlAgJXvpZytsaM9MfW
         IFlvAVYSWqAklkURjeX6kPUBM7EbrOzb4kpTMorijMIdigXoOIHvbaa1yajTZwS5GIv4
         NJaw==
X-Gm-Message-State: AGRZ1gLEbaHBiHfU7EQLSl4RPF5nM6N+RuifN2xIPtBA2WZOivWWpapz
        u4xEgeJnggY4LyJQOMqc7NdAsw==
X-Google-Smtp-Source: AJdET5e3g5xAQCTGCFPVRvYq0j2Q9SK4fwiYmX9vCjkyEgcii6Mq3O5yTUxwdTBn838XbcE1Hl/+0g==
X-Received: by 2002:a63:f615:: with SMTP id m21mr1828253pgh.428.1542242384587;
        Wed, 14 Nov 2018 16:39:44 -0800 (PST)
Received: from ?IPv6:2600:1012:b00f:2d6f:bc21:1d37:c350:a8ba? ([2600:1012:b00f:2d6f:bc21:1d37:c350:a8ba])
        by smtp.gmail.com with ESMTPSA id r81-v6sm55138466pfa.110.2018.11.14.16.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 16:39:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CAE_wzQ91=FQ1HYYvbOi5R5VSXjJibLwYWsAPFtvUemPa9+Turg@mail.gmail.com>
Date:   Wed, 14 Nov 2018 16:39:41 -0800
Cc:     jannh@google.com, ebiggers@kernel.org, dh.herrmann@googlemail.com,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable@vger.kernel.org, luto@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D1DFB962-DAC7-4CD6-A627-4A69062EDDE5@amacapital.net>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com> <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com> <CAG48ez1GH5=d2LcSVA=+AoW6zB=BELr1QL34f3jrA8ip_6WMtQ@mail.gmail.com> <CAE_wzQ91=FQ1HYYvbOi5R5VSXjJibLwYWsAPFtvUemPa9+Turg@mail.gmail.com>
To:     Dmitry Torokhov <dtor@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 14, 2018, at 2:46 PM, Dmitry Torokhov <dtor@google.com> wrote:
>=20
>> On Wed, Nov 14, 2018 at 2:38 PM Jann Horn <jannh@google.com> wrote:
>>=20
>>> On Wed, Nov 14, 2018 at 11:29 PM Dmitry Torokhov <dtor@google.com> wrote=
:
>>>> On Wed, Nov 14, 2018 at 2:05 PM Jann Horn <jannh@google.com> wrote:
>>>>> On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wr=
ote:
>>>>> When a UHID_CREATE command is written to the uhid char device, a
>>>>> copy_from_user() is done from a user pointer embedded in the command.
>>>>> When the address limit is KERNEL_DS, e.g. as is the case during
>>>>> sys_sendfile(), this can read from kernel memory.  Alternatively,
>>>>> information can be leaked from a setuid binary that is tricked to writ=
e
>>>>> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.=

>>>>>=20
>>>>> No other commands in uhid_char_write() are affected by this bug and
>>>>> UHID_CREATE is marked as "obsolete", so apply the restriction to
>>>>> UHID_CREATE only rather than to uhid_char_write() entirely.
>> [...]
>>>>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> [...]
>>>>> @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file,=
 const char __user *buffer,
>>>>>=20
>>>>>        switch (uhid->input_buf.type) {
>>>>>        case UHID_CREATE:
>>>>> +               /*
>>>>> +                * 'struct uhid_create_req' contains a __user pointer w=
hich is
>>>>> +                * copied from, so it's unsafe to allow this with elev=
ated
>>>>> +                * privileges (e.g. from a setuid binary) or via kerne=
l_write().
>>>>> +                */
>>>=20
>>> uhid is a privileged interface so we would go from root to less
>>> privileged (if at all). If non-privileged process can open uhid it can
>>> construct virtual keyboard and inject whatever keystrokes it wants.
>>>=20
>>> Also, instead of disallowing access, can we ensure that we switch back
>>> to USER_DS before trying to load data from the user pointer?
>>=20
>> Does that even make sense? You are using some deprecated legacy
>> interface; you interact with it by splicing a request from something
>> like a file or a pipe into the uhid device; but the request you're
>> splicing through contains a pointer into userspace memory? Do you know
>> of anyone who is actually doing that? If not, anyone who does want to
>> do this for some reason in the future can just go use UHID_CREATE2
>> instead.
>=20
> I do not know if anyone is still using UHID_CREATE with sendpage and
> neither do you really. It is all about not breaking userspace without
> good reason and here ensuring that we switch to USER_DS and then back
> to whatever it was does not seem too hard.

It=E2=80=99s about not breaking userspace *except as needed for security fix=
es*. User pointers in a write() payload is a big no-no.

Also, that f_cred hack is only barely enough. This isn=E2=80=99t just about a=
ttacking suid things =E2=80=94 this bug allows poking at the address space o=
f an unsuspecting process. So, if a privileged program opens a uhid fd and i=
s then tricked into writing untrusted data to the same fd (which is supposed=
 to be safe), then we have a problem. Fortunately, identically privileged pr=
ograms usually still don=E2=80=99t share a cred pointer unless they came fro=
m the right place.

The real right fix is to remove UHID_CREATE outright. This is terminally bro=
ken.
