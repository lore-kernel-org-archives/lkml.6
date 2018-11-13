Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59181C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1282D223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXKOXg7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1282D223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbeKMN3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:29:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34191 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeKMN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:29:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so4754543pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 19:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lGwGAJ2zkRj+PT7O6XfLqQLP0WrxbhskPyanPzWIQYQ=;
        b=VXKOXg7C5VfI/V2gLP7Z4Jszf6zmmtNMYhuVoBK+dXlW/YS4kZC2hFCGIYqxRwTfxu
         f05+PaunDSdFRLJx7ekJClO1FQ4sqms4cAh1WSXLDCA5XqiMqzfscJ9gfddcC1s9OAl2
         l6BByXopteCL5Nn+DrEOY2shMKhXYUlLZTtoJLsmIjXrIzyBrZezVKHmVQXbokEXANYV
         xhixatS9CPupljRPPTtSikWGMBd6C9fdF3xATOdiGYcfN9dQGm8dpgWLpILsrm1mk3DV
         +wCyIyzztVdz2GYfnSi/RRNgGQMJrioO+0gy5JoR8D4sA1OtuGkx2UP2TDGNTHvhNUw4
         7m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lGwGAJ2zkRj+PT7O6XfLqQLP0WrxbhskPyanPzWIQYQ=;
        b=J4FX0raF8yQ3L1nprt7ldJMr/aSGJ1dxWMXdJGQfho7HvFiVEU4nTxCxYeZJonwOFC
         snG8Cah6kpYhTal+pTSlw5xHP80xIRzZLGXWX+d5HgRvaAaCnMTLiUlgBty8ncuTfaO+
         mKKvyq07LrxnP4m4vignu1IlzPn8sENdm0hbS1RCuJagVSMSKhBvt9ZYpoRP5wnwiv2A
         C3QVlgfStSZYtmzfbs4TKMHAFOAclNjM/zZ0lW9vjPGCbsIHf9Tny0xr8/eN8quy4kyD
         SGFR89fuqmXIjKlslw/8jcRRGVnHBy475UQ/BTQP3Oh5fbDgAy/g1wji0DBVX83gxQiS
         DhtA==
X-Gm-Message-State: AGRZ1gIuoVBtml/CeVaP1hdgyc0YYo38/HyNPyu6RiUn8tCpL+VdKrQq
        uoUJ55Obv+4fDApiZhOZm0I=
X-Google-Smtp-Source: AJdET5e9xpIfRP382KS7k2qJt75qkWkQXlK4Hy6RckZLYzMq+8nn3EKcZivrKP36rgUMr2t/hPaYMg==
X-Received: by 2002:a63:6782:: with SMTP id b124mr3237963pgc.151.1542079977899;
        Mon, 12 Nov 2018 19:32:57 -0800 (PST)
Received: from [172.17.196.190] ([123.51.210.126])
        by smtp.gmail.com with ESMTPSA id p87-v6sm21697124pfk.186.2018.11.12.19.32.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 19:32:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] driver-staging: vsoc.c: Add sysfs support for
 examining the permissions of regions.
From:   wahahab <wahahab11@gmail.com>
In-Reply-To: <20181112124049.GA2408@kroah.com>
Date:   Tue, 13 Nov 2018 11:32:51 +0800
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        ghartman@google.com, astrachan@google.com,
        linux-kernel@vger.kernel.org,
        =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Martijn Coenen <maco@android.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C815584A-8542-4491-A7C4-CF0274C00792@gmail.com>
References: <20181107023043.GA18052@ubuntu>
 <20181109171558.GA8323@unbuntlaptop>
 <6ADC007E-85BB-4CA1-89FB-9254937E8C63@gmail.com>
 <20181112124049.GA2408@kroah.com>
To:     Greg Kroah-Hartman <greg@kroah.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 12 Nov 2018, at 8:40 PM, Greg Kroah-Hartman <greg@kroah.com> wrote:
>=20
> On Mon, Nov 12, 2018 at 04:49:30PM +0800, wahahab wrote:
>>=20
>>> On 10 Nov 2018, at 1:15 AM, Dan Carpenter <dan.carpenter@oracle.com =
<mailto:dan.carpenter@oracle.com>> wrote:
>>>=20
>>> On Wed, Nov 07, 2018 at 10:30:43AM +0800, Jerry Lin wrote:
>>>> Add a attribute called permissions under vsoc device node for =
examining
>>>> current granted permissions in vsoc_device.
>>>>=20
>>>> This file will display permissions in following format:
>>>> begin_offset  end_offset  owner_offset  owned_value
>>>>          %x          %x            %x           %x
>>>>=20
>>>=20
>>> (I'm not totally an expert on sysfs rules).
>>>=20
>>> Sysfs are supposed to be one value per file, so instead of doing =
this
>>> you would create a directory with four files like
>>> vsoc_device/begin_offset vsoc_device/end_offset etc.  And each would
>>> just hae a %x output.
>>=20
>> Thanks for your advice. I have started with this approach.
>>=20
>> But when I trying to create this kind of sysfs hierarchy. I =
encountered the difficulties of file organizing.
>>=20
>> My current thought is to create a folder under the device node called =
permissions and user can examine
>> permission though file path like =
vsoc_device/permissions/permission1/begin_offset. But there comes a
>> problem that it seems hard to determine the correct index of =
permission to make folder name unique.
>>=20
>> The solution I come up with is to use memory address of permission =
node to be the index of permission.
>> So the path will be something like =
vsoc_device/permissions/0x4d23f/begin_offset.
>> Is this OK for sysfs?
>=20
> Ick, that is messy.  What exactly are you trying to export and why use
> sysfs?  Is this just debugging information?  Who is going to use this
> data?

I felt that exporting these information in sysfs will add lots of =
complexities in this driver.
And I=E2=80=99m not sure these informations are for user space or just =
for debugging.

It seems there is a conflict of TODO messages between TODO file and the
comment in vsoc.c.

Should I use debugfs first for this patch?

Thanks

Jerry Lin

>=20
> If it is just for debugging, use debugfs, that is what it is there =
for.
> If you use sysfs, you then have to support your new api for a very =
long
> time, as you can not break userspace reliance on it.
>=20
> thanks,
>=20
> greg k-h

