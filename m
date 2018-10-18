Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17874C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA21B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA21B2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJRRif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:38:35 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59761 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJRRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:38:35 -0400
Received: from [192.168.178.69] ([109.104.36.60]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Ma1kC-1g9ifi32ZA-00Vvll; Thu, 18 Oct 2018 11:37:58 +0200
Received: from [192.168.178.69] ([109.104.36.60]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Ma1kC-1g9ifi32ZA-00Vvll; Thu, 18 Oct 2018 11:37:58 +0200
Subject: Re: [PATCH 0/7] staging: vc04_services: Some dead code removal
To:     Dave Stevenson <dave.stevenson@raspberrypi.org>,
        pbrobinson@gmail.com
Cc:     devel@driverdev.osuosl.org, tuomas.tynkkynen@iki.fi,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
 <1715113043.52878.1538821118324@email.1und1.de>
 <20181017101831.b5kvh5jw3sqqhbat@mwanda> <87bm7stwhv.fsf@anholt.net>
 <CALeDE9ORBiWh0aLqv17DGZaWW5BM4Var5C-hO5P-u2OYyqU7HQ@mail.gmail.com>
 <CAAoAYcPyB-Xjh+BfSsUgbmRGP+M3LmHcjxshnDDqB8=JvMrjCg@mail.gmail.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <f358db9f-1b7f-d0c6-ace5-64b908f08b63@i2se.com>
Date:   Thu, 18 Oct 2018 11:37:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAAoAYcPyB-Xjh+BfSsUgbmRGP+M3LmHcjxshnDDqB8=JvMrjCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:5iB4fV5HVqy/deqeopHCkKMAm6QsjX9VBRu5brWjMgJYl8wkbtk
 jCU0hM/mULm27xTk1IBbsL7DNBiIvjo56xJe5E91TPbC9+ErYerNAssSTW+immVgSOOFnm/
 M7h3dN821+6AWJu792ukmvHFVWv7KQmcL0sSBV/kuh0+bODOd2P2sqiEaKRwvokt9yqbiiL
 7gu2zJElitrTZI8LA+tMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:H6nT9fC9EU4=:XDCLvAvpEJKwVWmk19CorM
 a8gII1tJeuYYoiCilKEhpfBbDQInYOQALGtOJ34mnhBTRoMbX5D76m23H8LC7C5JuzpjohG+9
 w51xWPeNCrVEi/88lHSXs1aYBlTd/ro/7YA2b20iH7gQRuRC8GGnLE6HLzgUQvBd24ccHUJuj
 c+5W2N7jh0VUzZLUT71y+WiSR6iyznocgkQXXSvf3ZtN4pL7LRvqDes8+TGHpGlkhO/3CWOph
 XWDNwD77KpFooM1jy7RjvA45Vedr9YM23EAQQee3lWJtdjFPK0w8pntRC5hbjnzeEDuHs6u1P
 h8G2sGgEAFfW4HlUBY46uxf0Fm4WSMvhsL+CXah+Op9k+uBkkzWT9vi1eLGI6faSivFwVMC1o
 ES1WnRH/d5bZWr6ehZ2JCfTdHIfWVPFeiZwQPHGmfiof8/o4b24ThrUccBIuj+q64QsW4+yKl
 RnCJODCjrmdt0l1Jz3TcVuqNPAaiLxp7UwAyOba661wU5TZ20iU2uDgECLOki9uhPl578HZw/
 Xb8Aa3Bac5tUOhpDdaNXNrvobVdf/9TJ6Mg1DkR/vprNBQRAa6rizH1ljiCyAJ33icAv5ueIr
 5kbf9uUzfBC7WnRp2u3MOWX/4TOR4bCivP1h54469AT24HniZyM1caA8pO+2UkYhYG7F5ppCz
 GGsKTTHgsUz/lac0/0B9HPfh/6OpKcYB5S3bFwOwKIL3kcj9QCneHFi6tncp+4/tT7rNcyxam
 5+qfOGw97MkmGSOe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.10.2018 um 11:22 schrieb Dave Stevenson:
> On Wed, 17 Oct 2018 at 17:51, Peter Robinson <pbrobinson@gmail.com> wrote:
>>>>>> Drop various pieces of dead code from here and there to get rid of
>>>>>> the remaining users of VCHI_CONNECTION_T. After that we get to drop
>>>>>> entire header files worth of unused code.
>>>>>>
>>>>>> I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
>>>>>> snd-bcm2835 can still play analog audio just fine.
>>>>>>
>>>>> thanks and i'm fine with your patch series:
>>>>>
>>>>> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
>>>>>
>>>>> Unfortunately this would break compilation of the downstream vchi
>>>>> drivers like vcsm [1]. Personally i don't want to maintain another
>>>>> one, because i cannot see the gain of the resulting effort.
>>>>>
>>>>> [1] - https://github.com/raspberrypi/linux/tree/rpi-4.14.y/drivers/char/broadcom/vc_sm
>>>>
>>>> I feel like everyone else already knows the answer but why don't we just
>>>> merge that code into staging?
>>> Dave's been working on a new VCSM service where the firmware can call
>>> back into Linux to allocate (instead of just having a permanent carveout
>>> of system memory that the firmware allocates from), and lets us make
>>> dma-bufs out of those buffers.  That driver makes a no-copies v4l2 media
>>> decode driver possible, which would then let Kodi and similar projects
>>> switch from downstream kernels with closed graphics to upstream kernels
>>> with open graphics.
>>>
>>> Given that the new VCSM service is a rewrite, it's not clear to me that
>>> importing the old VCSM driver is a win.  But maybe we should go raid
>>> https://github.com/6by9/linux/tree/rpi-4.14.y-codecs-push-pt2a and grab
>>> the new drivers.  Upstreaming the VCHI audio driver to staging has
>>> clearly been a win for it, so maybe other eyes on the new v4l2 codec
>>> could help Dave along in stabilizing it.
>> I think that makes sense as long as the firmware side changes are in
>> place so it can actually be used.
> The firmware has supported the necessary for dmabuf import since Sept 2017.
>
> The new vcsm driver currently only supports importing from other
> kernel modules as I cut it back to the bare minimum to ease
> upstreaming. To be a complete replacement of the existing then it
> needs to support userspace alloc/free/import/mmap. I did have most of
> that working, but will add it in stages.
> The codec code is working for decode but something is off for setting
> formats on encode.
> Both drivers are loading through DT at the moment as I couldn't get
> Eric's platform driver stuff working. IIRC A combination of modules
> not getting loaded and getting the appropriate coherent DMA mask set
> (being under soc in DT gives the correct mappings, but being a
> platform driver didn't).

I'm working on these issues and i will post a proper solution soon.

In case you need a hack in order to test your stuff, i can prepare a
branch for you.

>
> I'm fire-fighting a networking issue at the moment, but hope to be
> back on codecs next week.
> Could you hold off raiding my trees until say Fri 26th Oct so I can
> ensure they are fully up to date? If I get a chance then I'll start
> the work of porting into staging before then.

The merge window will open soon, so i don't see the need to hurry.

Thanks
Stefan

>
>   Dave
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
