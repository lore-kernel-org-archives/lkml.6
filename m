Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2F6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A648223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uqQ1w3Aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A648223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388442AbeKPA6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:58:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35078 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbeKPA6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:58:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so9814174pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x/pndFBxU4DtnoABSN9G0iiUytHbGdRcrz+kXuU6xeA=;
        b=uqQ1w3Aq8uU5Tl/8l/K4t4kPiwxrvU2V2ruFp2JihcZWN9SaUWs1/1i4n2bZyDpgEi
         sPERDuT7ieIMNGEZsZs6prTxEZncvbPRh4GoWFmMOlK8TsozMzjGnnOLJBNpLKSsCkDl
         KdXeq1Y6RV0Q1OVeAwwErS4T17wpr+SDB9G0n4ALrYf5dLgwlzOIJEiILLDZANSeSVIG
         wWBLjTLUxfgDe6AFCLKj0dWJdTA/FYqLNV5g9Tysy4/CuidFV8iPG6tLfuVvsY04BDI/
         bJJHPxGMATsIvnQ9qE0TBE93/HUCvcFEc8vot/igCiReYP47mmeqDNZFtEFTJVtCrYb4
         oQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=x/pndFBxU4DtnoABSN9G0iiUytHbGdRcrz+kXuU6xeA=;
        b=AkKLEKQl7NRiD3AviLn74rl7iKM9MOKtYW0+uiT21mPA+uKPFmOQzCff3jJLKfd8H/
         SimvzIpA+dx4oZanuycRHmuPeIWfzPRmZud1I0dAZqU4q8pi+0NngzsFMjw8GlP3Cugu
         fyXjxdyhdymCsJ0ydnVGORoq0yU1MhqEDtfgGGOXOz6h2Ek+qHrWXmchDFXxrzUZeuIt
         TLqwMlKuAgZciPImCaVFd90cP4C1tsbm7iY1N7nNR4NeurAxvxgPUYvNZHFqD2a4xFMB
         HOwQnAbF4uwodyWFae9Lk+vIxBY+tuU1tMPKQmRObSZ9QScELJsVDtr1DGWCnnAYhtJd
         ugyw==
X-Gm-Message-State: AGRZ1gIoXvslY62iUJho2EK1+HLC8B4mXcMBh4q1dNqKy7b/UqA/JH7B
        6881wOJOQOowrVI0qTe8mhCeLQ==
X-Google-Smtp-Source: AJdET5dotI2PQalX8Qi9MmTUZgU/fQtBEVaI91eviBCaNSKuGJEjt+5GcmJONJxr2H8Ahn3zZse7BQ==
X-Received: by 2002:aa7:8552:: with SMTP id y18mr6868084pfn.83.1542293407860;
        Thu, 15 Nov 2018 06:50:07 -0800 (PST)
Received: from [100.83.78.174] (74.sub-174-211-6.myvzw.com. [174.211.6.74])
        by smtp.gmail.com with ESMTPSA id o12-v6sm36253245pfh.20.2018.11.15.06.50.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 06:50:07 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CANq1E4ThFYS8=QqnyUVMAafy3BHb8CiDqm9LmT22XZzm9wJSeg@mail.gmail.com>
Date:   Thu, 15 Nov 2018 06:50:05 -0800
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dtor@google.com>, ebiggers@kernel.org,
        jannh@google.com, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3AEDFEA-7810-4200-BBB9-055285062266@amacapital.net>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <CAG48ez02ZYZOKRXuZ9yYUijZnaaw=G7-KYu1rB7C99+B45VqjQ@mail.gmail.com> <CAE_wzQ_GqjwkhUjoPs3h-s7KSVe8KoH-uu-4mf672JN0X89d6g@mail.gmail.com> <20181114230046.GC87768@gmail.com> <CAE_wzQ_OS-BnRrXjKFhNBeRFRYsQkX2tNO3DEUQRFR7g7A7-2g@mail.gmail.com> <CAO-hwJJ3jkQFyf7oByERd98nqEUTjJRu_1tZpFK9sWvgT921iQ@mail.gmail.com> <CANq1E4ThFYS8=QqnyUVMAafy3BHb8CiDqm9LmT22XZzm9wJSeg@mail.gmail.com>
To:     David Herrmann <dh.herrmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 15, 2018, at 4:06 AM, David Herrmann <dh.herrmann@gmail.com> wrote:=

>=20
> Hey
>=20
> On Thu, Nov 15, 2018 at 9:14 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>>=20
>> On Thu, Nov 15, 2018 at 12:20 AM Dmitry Torokhov <dtor@google.com> wrote:=

>>>> I think it's best not to make
>>>> assumptions about how the interface will be used and to be consistent w=
ith how
>>>> other ->write() methods in the kernel handle the misfeature where a __u=
ser
>>>> pointer in the write() or read() payload is dereferenced.
>>>=20
>>> I can see that you might want to check credentials, etc, if interface
>>> can be accessed by unprivileged process, however is it a big no no for
>>> uhid/userio/uinput devices.
>>=20
>> Yep, any sane distribution would restrict the permissions of
>> uhid/userio/uinput to only be accessed by root. If that ever changes,
>> there is already an issue with the system and it was compromised
>> either by a terribly dizzy sysadmin.
>=20
> UHID is safe to be used by a non-root user. This does not imply that
> you should open up access to the world, but you are free to have a
> dedicated group or user with access to uhid. I agree that in most
> common desktop-scenarios you should not grant world-access to it,
> though.
>=20
>>>=20
>>>> Temporarily switching
>>>> to USER_DS would only avoid one of the two problems.
>>>=20
>>> So because of the above there is only one problem. If your system
>>> opened access to uhid to random processes you have much bigger
>>> problems than exposing some data from a suid binary. You can spam "rm
>>> -rf .; rm -rf /" though uhid if there is interactive session
>>> somewhere.
>>>=20
>>>>=20
>>>> Do you think the proposed restrictions would actually break anything?
>>>=20
>>> It would break if someone uses UHID_CREATE with sendpage. I do not
>>> know if anyone does. If we were certain there are no users we'd simply
>>> removed UHID_CREATE altogether.
>>=20
>> AFAICT, there are 2 users of uhid:
>> - bluez for BLE devices (using HID over GATT)
>> - hid-replay for debugging.
>=20
> There are several more (eg., android bt-broadcom), and UHID_CREATE is
> actively used. Dropping support for it will break these use-cases.
>=20
>=20

Is the support story for these programs such that we could add a big scary w=
arning and remove UHID_CREATE in a couple months?=
