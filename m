Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F3DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA66223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 14:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="C2bOlOVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA66223CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbeKPA5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 19:57:22 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34988 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388427AbeKPA5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 19:57:21 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so9813073pff.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 06:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1DclgN3wt5vRygj51dNgJeFwRzTE9dLOjJDwJ1ReKwY=;
        b=C2bOlOVlWCnT6U7cn/VqwJsgI/A3HVF9fP35igF8FO/lt2TT/ew0v8MO2cKf7odsH2
         6itdAIcRkFvi6Bdjb49V/y3Zkt874PGpfHt0+5xJxv9NxyzFqO4FMfJ/2PzMTlGDXJjM
         fJsJmwwLwYd7UMWcDuddw1OQ5Vb/8oJcw+d7inohY3/6UuzH4bSYMXu+csT2N6No5KPi
         qmi7+47Ann3UiEf+G9pQq8lmEfU82UBWSMjLi/Q0QcxmJ69QCkbpIbp8o3cPW3NJOY+r
         S390RUyEFil/Ex4rKIJMcOt6hoVxW0r9ptwLKNRtPfLA0gAYT6Osx1ksD4eH9UJR57ZC
         GnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1DclgN3wt5vRygj51dNgJeFwRzTE9dLOjJDwJ1ReKwY=;
        b=WpGuGcyCTGy+rwyRzHC4uNz6Uudz3eF+10WNhxiq91keLxFcOoOJjuzQnevZ3+Z9hn
         pGdzIUYE2TkR8IeUFcFnCl2DtNZS3RHzxjqr3nSFdFMTHhhMn7I6WQj5o7f+FMkuIPOa
         4hvjFiiDFmcdIpizY8XK8G+V3oDQePGrBTVA2j7qgN4LBchBBYI1F5pXQ22jg8to6aQh
         TkbCX67KOJjA1n1Q4Dcioh/LhXGVAIEz0c6WBY9kIcxQPv+7xeK5JQDx4ImSJeHGQMrg
         Ptb6fY5k3E7sajjB0XGVUXBWcLtyagj2bZvtsXgmI/83UTOWdSAk8b7DkWK9dic1gSjV
         ZN2g==
X-Gm-Message-State: AGRZ1gKETcm0zmM7ckUndVEXOHCh76lz/ks2Zap8+HIaDD0l+1x8XChV
        jwXaMej8CmQJWR0zwFokpyttRw==
X-Google-Smtp-Source: AJdET5fMKQuypU5asxhv08b3jVVg7Po4ZnHaKkIRCY0hU3kNCRlbcSR1VXr1nbGM8+400143zj8sRA==
X-Received: by 2002:a62:c42:: with SMTP id u63-v6mr6803054pfi.43.1542293353179;
        Thu, 15 Nov 2018 06:49:13 -0800 (PST)
Received: from ?IPv6:2600:1012:b05e:48bd:476:3daf:66b8:2ef? ([2600:1012:b05e:48bd:476:3daf:66b8:2ef])
        by smtp.gmail.com with ESMTPSA id f64sm41386136pfh.0.2018.11.15.06.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 06:49:12 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <CANq1E4Qr+k5hWbxKBQQTO0dSP0QFk4V+hJ9Fmmqz6=cOmfD1KA@mail.gmail.com>
Date:   Thu, 15 Nov 2018 06:49:10 -0800
Cc:     ebiggers@kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com,
        stable <stable@vger.kernel.org>, jannh@google.com,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <58434835-159E-45BC-BD66-EDDAC654A224@amacapital.net>
References: <CAG48ez3bPkh+DMPwiebM+r4ozX2CiVY=9=WMBP_xm1qVaSN4sQ@mail.gmail.com> <20181114215509.163600-1-ebiggers@kernel.org> <CANq1E4Qr+k5hWbxKBQQTO0dSP0QFk4V+hJ9Fmmqz6=cOmfD1KA@mail.gmail.com>
To:     David Herrmann <dh.herrmann@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 15, 2018, at 4:09 AM, David Herrmann <dh.herrmann@gmail.com> wrote:=

>=20
> Hi
>=20
>> On Wed, Nov 14, 2018 at 10:55 PM Eric Biggers <ebiggers@kernel.org> wrote=
:
>> From: Eric Biggers <ebiggers@google.com>
>>=20
>> When a UHID_CREATE command is written to the uhid char device, a
>> copy_from_user() is done from a user pointer embedded in the command.
>> When the address limit is KERNEL_DS, e.g. as is the case during
>> sys_sendfile(), this can read from kernel memory.  Alternatively,
>> information can be leaked from a setuid binary that is tricked to write
>> to the file descriptor.  Therefore, forbid UHID_CREATE in these cases.
>>=20
>> No other commands in uhid_char_write() are affected by this bug and
>> UHID_CREATE is marked as "obsolete", so apply the restriction to
>> UHID_CREATE only rather than to uhid_char_write() entirely.
>>=20
>> Thanks to Dmitry Vyukov for adding uhid definitions to syzkaller and to
>> Jann Horn for commit 9da3f2b740544 ("x86/fault: BUG() when uaccess
>> helpers fault on kernel addresses"), allowing this bug to be found.
>>=20
>> Reported-by: syzbot+72473edc9bf4eb1c6556@syzkaller.appspotmail.com
>> Fixes: d365c6cfd337 ("HID: uhid: add UHID_CREATE and UHID_DESTROY events"=
)
>> Cc: <stable@vger.kernel.org> # v3.6+
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>> ---
>> drivers/hid/uhid.c | 12 ++++++++++++
>> 1 file changed, 12 insertions(+)
>>=20
>> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
>> index 3c55073136064..051639c09f728 100644
>> --- a/drivers/hid/uhid.c
>> +++ b/drivers/hid/uhid.c
>> @@ -12,6 +12,7 @@
>>=20
>> #include <linux/atomic.h>
>> #include <linux/compat.h>
>> +#include <linux/cred.h>
>> #include <linux/device.h>
>> #include <linux/fs.h>
>> #include <linux/hid.h>
>> @@ -722,6 +723,17 @@ static ssize_t uhid_char_write(struct file *file, co=
nst char __user *buffer,
>>=20
>>        switch (uhid->input_buf.type) {
>>        case UHID_CREATE:
>> +               /*
>> +                * 'struct uhid_create_req' contains a __user pointer whi=
ch is
>> +                * copied from, so it's unsafe to allow this with elevate=
d
>> +                * privileges (e.g. from a setuid binary) or via kernel_w=
rite().
>> +                */
>> +               if (file->f_cred !=3D current_cred() || uaccess_kernel())=
 {
>=20
> I think `uaccess_kernel()` would be enough. UHID does not check any
> credentials. If you believe this should be there nevertheless, feel
> free to keep it.

The free check is needed.  Without it, consider what sudo >uhid_fd does.  It=
 doesn=E2=80=99t use sudo=E2=80=99s credentials, but it does read its addres=
s space.

Can this patch get a comment added?


> Either way:
>=20
> Acked-by: David Herrmann <dh.herrmann@gmail.com>
>=20
> Thanks
> David
