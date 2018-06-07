Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8OfDLv6aGFuqbgAAmS7hNA
	; Thu, 07 Jun 2018 02:39:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9AC83608B8; Thu,  7 Jun 2018 02:39:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AVOvLXul"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2F706074D;
	Thu,  7 Jun 2018 02:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2F706074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeFGCjz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 22:39:55 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39181 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeFGCjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 22:39:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id w12-v6so3960477pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 19:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zZAM5N6Uen4wEhOqOZmRvhC9z87YmqkIRjJXGx/iV+w=;
        b=AVOvLXulivfCAw/MKdp/lHROkOojUMQYD/RQi9DIQU0I8u/+zbFYUaQl1goSjLUgiH
         fh9l0ZcT3C9MMu/rEhXP5p4MhMqwNKWj/BAZMmAJ96iXIwi9dFAC/fhy0V2tvbB6FHbI
         joEarEVoJykFccx26PhPzRlMmBRAbaW0uB1lu/I/VwdHNklodMjkQ+djaHRR0g4LcVUa
         U/+eqbvXynWoSrJBlqiB1hwHinTLUTIoDp0eBpVYnzjZSaxTGMz3zNvW8LwbTF+5UJm+
         Arxoh5LYCrP2NDMWq+nXSA1YUrcM2E+upl73fRwhUm7Kco2ga2Np/2UrIw/zBZBF5UMg
         M4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zZAM5N6Uen4wEhOqOZmRvhC9z87YmqkIRjJXGx/iV+w=;
        b=mx/rpXi+ModMPY906QdxM8gz21f05U6mfKU2UNHJO2o6sV2ejed4GRfiTEhFKY4OYs
         0uaSN73tjWW8Loyb5Der7hPc3ySHZgiGVoQHJVRXivOKQsrAC4Jl796ttoHVJocx88mi
         2UkA1w9mGUgoQxq1eiriEyC/G3mkszxVBhmYdLS6peybzKud2WRqdpYS6/9p6hNGcGC1
         dxOU0HI1y5V2dYwVCq8DpVv8I5NUfMy+CLvFRzwT3eODycywPb38gbtPdhTak1u1Z+OL
         uECd4SIlrlQXlRUGh7St4xEh/ea7p2jOoevPYHIL++GECYBszgrQU0zd3FbRrJ7uG4+j
         lYxQ==
X-Gm-Message-State: APt69E0TxpoC/+9lyN5OZBwlvh7nJhyD2tkc4qXIofrZCfRESpEoZeEm
        uPi1kFbo3bVTPJzmQbqaGJdcP6bHbo8=
X-Google-Smtp-Source: ADUXVKJqzFJ0ObaBc33KMHKP2IQe/vXA9mbULKYB3/PtdqzBKbSxaPRCAJyaPTlYAAav/C7Y3zY1tg==
X-Received: by 2002:a62:211a:: with SMTP id h26-v6mr13861pfh.133.1528339193742;
        Wed, 06 Jun 2018 19:39:53 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:a6c5:8884:fdfb:ef72:27? ([2600:1010:b065:a6c5:8884:fdfb:ef72:27])
        by smtp.gmail.com with ESMTPSA id i88-v6sm4571164pfi.153.2018.06.06.19.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 19:39:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when vdso disabled on X86?
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15E302)
In-Reply-To: <5B1892F5.9000206@huawei.com>
Date: Wed, 6 Jun 2018 19:39:50 -0700
Cc: Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>, yaomin2@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A95BD803-E0E2-4E49-B3EF-D056F1D69883@amacapital.net>
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com> <5B17A6B6.70300@huawei.com> <CALCETrXiaqyAKzcT17P35Gf6fNBchPYF_JsQ+3ezNeETs_UTbA@mail.gmail.com> <5B1892F5.9000206@huawei.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 6, 2018, at 7:05 PM, Leizhen (ThunderTown) <thunder.leizhen@huawei.=
com> wrote:
>=20
>=20
>=20
>> On 2018/6/7 1:01, Andy Lutomirski wrote:
>> On Wed, Jun 6, 2018 at 2:18 AM Leizhen (ThunderTown)
>> <thunder.leizhen@huawei.com> wrote:
>>>=20
>>> I found that glibc has already dealt with this case. So this issue must h=
ave been met before, should it be maintained by libc/user?
>>>=20
>>>        if (GLRO(dl_sysinfo_dso) =3D=3D NULL)
>>>        {
>>>                kact.sa_flags |=3D SA_RESTORER;
>>>=20
>>>                kact.sa_restorer =3D ((act->sa_flags & SA_SIGINFO)
>>>                        ? &restore_rt : &restore);
>>>        }
>>>=20
>>>=20
>>>> On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
>>>>=20
>>>>=20
>>>>> On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
>>>>> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable vdso, t=
he rt_sigaction01 test case from ltp_2015 failed.
>>>>> The test case source code please refer to the attachment, and the outp=
ut as blow:
>>>>>=20
>>>>> -----------------
>>>>> ./rt_sigaction01
>>>>> rt_sigaction01    0  TINFO  :  signal: 34
>>>>> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result =3D=
 0
>>>>> rt_sigaction01    0  TINFO  :  sa.sa_flags =3D SA_RESETHAND|SA_SIGINFO=

>>>>> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal numbe=
r 34
>>>>>=20
>>>>> Segmentation fault
>>>>> ------------------
>>>>>=20
>>>>>=20
>>>>> Is this the desired result? In function ia32_setup_rt_frame, I found b=
elow code:
>>>>>=20
>>>>>     if (ksig->ka.sa.sa_flags & SA_RESTORER)
>>>>>             restorer =3D ksig->ka.sa.sa_restorer;
>>>>>     else
>>>>>             restorer =3D current->mm->context.vdso +
>>>>>                     vdso_image_32.sym___kernel_rt_sigreturn;
>>>>>     put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
>>>>>=20
>>>>> Because the vdso is disabled, so current->mm->context.vdso is NULL, wh=
ich cause the result of frame->pretcode invalid.
>>>>>=20
>>>>> I'm not sure whether this is a kernel bug or just an error of test cas=
e itself. Can anyone help me?
>>>>>=20
>>>>=20
>>>=20
>>>=20
>>=20
>> I can't tell from your email what you're testing, what behavior you
>> expect, and what you saw.  A program that sets up a signal handler
>> without supplying a restorer will not work if the vDSO is off, and
>> this is by design.
> OK, so that the user should take care whether the vDSO is disabled by itse=
lf or not, and use different strategies to process it appropriately, like gl=
ibc.
>=20
>>=20
>> (FWIW, there is a very longstanding libc bug that causes this case to
>> get severely screwed up if the user's SS is not the expected value,
>> and that bug was just fixed very recently.  But I doubt this is what
>> you're seeing.)
>>=20
>> I suppose we could improve the kernel to at least push NULL instead of
>> some random address a bit above 0, but it'll still crash.
> Should we add a warning? Which may help the user to aware this error in ti=
me.
>=20

It=E2=80=99s entirely valid to have a non working restorer if you never plan=
 to return from a signal handler. And anyone who writes their own libc shoul=
d be able to figure this out on their own, I think.

>>=20
>> .
>>=20
>=20
> --=20
> Thanks!
> BestRegards
>=20
