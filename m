Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86832C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477192133F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 15:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xxcoqm+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeLaPbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 10:31:09 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42259 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbeLaPbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 10:31:08 -0500
Received: by mail-io1-f67.google.com with SMTP id x6so21474126ioa.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 07:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kVnKWzB4rH2Um2MjwTxd3+2m/uFjL8ZTVKpabjjWI8E=;
        b=xxcoqm+u0GUodmJZ7jk4vMklF0aE3iZ0aWME/PkDgHXiUsjC04OfbAwwMCun4rpoe4
         frZSzQUFT+r8p+d6OVBfcsddbECchnJAIOvq9JDRopcic4D12XGVilvA3RTytb/scEcP
         ncev7ztQYMDVDE1IIrXJ59fEhra47Se8YiyOmEpC7TeHn/4zgOpWEHAr4Kb13bImAU+T
         FPVcpEskPBxiDk/1WcHnX9oRgRVvBVJaL9a/LexEUwg8c+jsrGR/JJt2FTohp0L2+6ro
         h47+mZyxYyQVgfD+PcQRKZSyTesihFl6/l4bXGke8Y/TXV/2zAcSQI9XF5rxwDtpdBNl
         v2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kVnKWzB4rH2Um2MjwTxd3+2m/uFjL8ZTVKpabjjWI8E=;
        b=hUDfr/SEBtSEoKN2WL5Rk02jyibINm5i+jz78+DdFomBH9bagtxvMn9vPC3v4sjlk5
         aZYgXC33UcMMlosQRKYK6XNREZkx5/PEAcZPpFMTpmIHZJB/Mn1zE86yNWVX4QfMyWDn
         ff1r2mvlltmZn97gTakqkgHlumfY9/5yHrD3RMirYgkVij4aUCZwGO9p3MmSaYW4cBn3
         Na5347FwL4U+ZJQCKEqND6+jSfjhLp+iiybMVj5807CNwZsapcW12Lc3Ig5YOLYNGmAI
         b14ONw2mqOoGHqsumvuBx3jLzBjyI43V9axo+fslNLgb4LjQDw7OK1hIcexGAuX3OeIU
         lqOw==
X-Gm-Message-State: AJcUukdlRnqbwV7WdWji/OTSKCGynoLDIO293jK8clJeMHzEMn+STRnz
        upQxGVlfXGmIUed9AuYZ0WVHuw==
X-Google-Smtp-Source: ALg8bN53jFDOIx7VNq4t5+xeqdYEqPUAB4Gddqse5XMGIXde2mZ014EU43mzo5J8Vstver6tVRvu3g==
X-Received: by 2002:a6b:2c92:: with SMTP id s140mr25510635ios.218.1546270267529;
        Mon, 31 Dec 2018 07:31:07 -0800 (PST)
Received: from ?IPv6:2601:281:200:3b79:409e:6679:ac44:c135? ([2601:281:200:3b79:409e:6679:ac44:c135])
        by smtp.gmail.com with ESMTPSA id t129sm18129619ita.4.2018.12.31.07.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 07:31:06 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] PM / Sleep: Check the file capability when writing wake lock interface
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20181231123310.GA3038@kroah.com>
Date:   Mon, 31 Dec 2018 08:31:05 -0700
Cc:     Jann Horn <jannh@google.com>, joeyli <jlee@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <09310D00-114A-4A51-8E98-0B11F9D9541E@amacapital.net>
References: <20181230132856.24095-1-jlee@suse.com> <20181230132856.24095-3-jlee@suse.com> <20181230144835.GB18985@kroah.com> <20181231093851.GN3506@linux-l9pv.suse> <20181231104055.GB27420@kroah.com> <CAG48ez3-YEVsyuk1H6hjGy9Ogm-z46bmdnqy0JbW9YL297FsTw@mail.gmail.com> <20181231123310.GA3038@kroah.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 31, 2018, at 5:33 AM, Greg Kroah-Hartman <gregkh@linuxfoundation.or=
g> wrote:
>=20
>> On Mon, Dec 31, 2018 at 01:02:35PM +0100, Jann Horn wrote:
>> On Mon, Dec 31, 2018 at 11:41 AM Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>>=20
>>>> On Mon, Dec 31, 2018 at 05:38:51PM +0800, joeyli wrote:
>>>> Hi Greg,
>>>>=20
>>>>> On Sun, Dec 30, 2018 at 03:48:35PM +0100, Greg Kroah-Hartman wrote:
>>>>>> On Sun, Dec 30, 2018 at 09:28:56PM +0800, Lee, Chun-Yi wrote:
>>>>>> The wake lock/unlock sysfs interfaces check that the writer must has
>>>>>> CAP_BLOCK_SUSPEND capability. But the checking logic can be bypassed
>>>>>> by opening sysfs file within an unprivileged process and then writing=

>>>>>> the file within a privileged process. The tricking way has been expos=
ed
>>>>>> by Andy Lutomirski in CVE-2013-1959.
>>>>>=20
>>>>> Don't you mean "open by privileged and then written by unprivileged?"
>>>>> Or if not, exactly how is this a problem?  You check the capabilities
>>>>> when you do the write and if that is not allowed then, well
>>>>>=20
>>>>=20
>>>> Sorry for I didn't provide clear explanation.
>>>>=20
>>>> The privileged means CAP_BLOCK_SUSPEND but not file permission. The fil=
e permission
>>>> has already relaxed for non-root user. Then the expected behavior is th=
at non-root
>>>> process must has CAP_BLOCK_SUSPEND capability for writing wake_lock sys=
fs.
>>>>=20
>>>> But, the CAP_BLOCK_SUSPEND restrict can be bypassed:
>>>>=20
>>>> int main(int argc, char* argv[])
>>>> {
>>>>        int fd, ret =3D 0;
>>>>=20
>>>>        fd =3D open("/sys/power/wake_lock", O_RDWR);
>>>>        if (fd < 0)
>>>>                err(1, "open wake_lock");
>>>>=20
>>>>        if (dup2(fd, 1) !=3D 1) // overwrite the stdout with wake_lock
>>>>                err(1, "dup2");
>>>>        sleep(1);
>>>>        execl("./string", "string");  //string has capability
>>>>=20
>>>>        return ret;
>>>> }
>>>>=20
>>>> This program is an unpriviledged process (has no CAP_BLOCK_SUSPEND), it=
 opened
>>>> wake_lock sysfs and overwrited stdout. Then it executes the "string" pr=
ogram
>>>> that has CAP_BLOCK_SUSPEND.
>>>=20
>>> That's the problem right there, do not give CAP_BLOCK_SUSPEND rights to
>>> "string".  If any user can run that program, there's nothing the kernel
>>> can do about this, right?  Just don't allow that program on the system :=
)
>>>=20
>>>> The string program writes to stdout, which means that it writes to
>>>> wake_lock. So an unpriviledged opener can trick an priviledged writer
>>>> for writing sysfs.
>>>=20
>>> That sounds like a userspace program that was somehow given incorrect
>>> rights by the admin, and a user is taking advantage of it.  That's not
>>> the kernel's fault.
>>=20
>> Isn't it? Pretty much any setuid program will write to stdout or
>> stderr; even the glibc linker code does so if you set LD_DEBUG.
>> (Normally the output isn't entirely attacker-controlled, but it is in
>> the case of stuff like "procmail", which I think Debian still ships as
>> setuid root.) setuid programs should always be able to safely call
>> read() and write() on caller-provided file descriptors. Also, you're
>> supposed to be able to receive file descriptors over unix domain
>> sockets and then write to them without trusting the sender. Basically,
>> the ->read and ->write VFS handlers should never look at the caller's
>> credentials, only the opener's (with the exception of LSMs, which tend
>> to do weird things to the system's security model).
>=20
> So a root program gets the file handle to the sysfs file and then passes
> it off to a setuid program and the kernel should somehow protect from
> this?

Yes, the kernel should.  If the kernel wants to check caps, it should do it r=
ight.

Calling capable() from a .write handler is wrong, even in sysfs.

>=20
> I think that any sysfs file that is relying on the capable() check
> should just set their permissions properly first, and then it should be
> ok.
>=20

Probably true.=20


> thanks,
>=20
> greg k-h
