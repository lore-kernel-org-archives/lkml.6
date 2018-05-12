Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526150076; cv=none;
        d=google.com; s=arc-20160816;
        b=mkWowBA4LeAAY7Jmi3hooJpv4rmu7yJ58KQaO43+Qq+meI7lonVl/DsMcoaEazRKH/
         sl1zNL3BwtjxUARymLpS/YG6CFeZ7j1LD2YdZCozJov+evBK9h5T0wYOHqZMtI9od2Ej
         NIdt36zhZz3+Dd5DSXpvrM9hFQFjU8t7wrVfw96guB2Wwvad1kiON5gEn6NfPg+I8wV0
         0DbG2NGSp1raVof3Xws2VDzkjy1syoMNGwaeqk0QfOOBBTbVE4k1fYshCMdAcln+DPx9
         Np6oDv0NNq25rq1WQme2BjV+8VhAfFO6Ys7j9J3d0G91KT/DMx1/RFA3ebP3vqSWyPWJ
         9GQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=74MvzDT/F1gMzxNLbwmYCSjo5SOx1YWc7QbBbILA1k8=;
        b=YslVUeoetkGGu31knvkZGLtLMT7REdjbTmPngVDgwDnbATd/i5EFIeSvwUFIyOEYXH
         4BEO9qhEkt61oFq7c4XrQKJJOfDgEsplIs7vSkGuUFXkNv/DZnUZ1AlbBR2J1Fuqx+M6
         wHX8Vu4TopwNpNFDuCkGM92AQBBd08qIF9xKykMW0rgR6Agd4bBHYQ90YgasnQhZ3nj2
         ewf5wWdt2s79UYxrpC72tx8Yls+yufm4VJkWxVBif64qIP+0Lf664WHnH6l4pb6cM6uv
         qlL+X4FBGXr8WhRVy3qtb6b7Ivl2JEC/AqlizMZt+7uAoG5pFYSs4P90SwugLLvi3EWg
         yeBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tBBTt4B+;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=tBBTt4B+;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AB8JxZqV3SuREg6NlZs3V8onYPYrPcgXD0E1xA/xm5EjGGmGqz+NEhFESGA6vU1Rh7Sb1B/y+XTy3w==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, "w@1wt.eu" <w@1wt.eu>,
 "ksummit-discuss@lists.linuxfoundation.org"
 <ksummit-discuss@lists.linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAKMK7uHjA27K8y-kwYFyhLy3cSkJJw8Oe1gP=3hZXdfxcWAcNQ@mail.gmail.com>
 <20180502194632.GB18390@sasha-vm> <20180503020550.GP2714@sirena.org.uk>
 <20180503031000.GC29205@thunk.org>
 <0276fcda-0385-8f22-dbdb-e063f7ed8bbe@roeck-us.net>
 <20180503224217.GR2714@sirena.org.uk> <20180503230905.GA98604@atomide.com>
 <CAPDyKFrCKkRHwOh-7yfFbvMp+Ykhs7oXrDwhTShSPvUBvpn2ZQ@mail.gmail.com>
 <20180509084440.GW13402@sirena.org.uk>
 <CAKMK7uEWYmhA3owSeYM9tNA0tpMm5=4Yqda2j=VfMWi7i8ya8w@mail.gmail.com>
 <20180509090346.GY13402@sirena.org.uk>
 <20180509204727.7ff38021@canb.auug.org.au>
 <20180512143809.7c6a06ab@canb.auug.org.au>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6cd1dc7b-f9fe-602d-2b8f-d078d110da32@roeck-us.net>
Date: Sat, 12 May 2018 11:34:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180512143809.7c6a06ab@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1600003109861123526?=
X-GMAIL-MSGID: =?utf-8?q?1600284342277682149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/11/2018 09:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 9 May 2018 20:47:27 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> On Wed, 9 May 2018 18:03:46 +0900 Mark Brown <broonie@kernel.org> wrote:
>>>
>>> On Wed, May 09, 2018 at 10:47:57AM +0200, Daniel Vetter wrote:
>>>> On Wed, May 9, 2018 at 10:44 AM, Mark Brown <broonie@kernel.org> wrote:
>>>    
>>>>> I think this is an excellent idea, copying in Stephen for his input.
>>>>> I'm currently on holiday but unless someone convinces me it's a terrible
>>>>> idea I'm willing to at least give it a go on a trial basis once I'm back
>>>>> home.
>>>    
>>>> Since Stephen merges all -fixes branches first, before merging all the
>>>> -next branches, he already generates that as part of linux-next. All
>>>> he'd need to do is push that intermediate state out to some
>>>> linux-fixes branch for consumption by test bots.
>>
>> Good idea ... I will see what I can do.
> 
> See my announcement of a pending-fixes branch in linux-next (on LKML
> and others)

Excellent.

Build/test results match mainline.

For v4.17-rc4-241-ga1b6c55:

Build results:
	total: 132 pass: 130 fail: 2
Failed builds:
	m68k:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 138 pass: 138 fail: 0

Guenter
