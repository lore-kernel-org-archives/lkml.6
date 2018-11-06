Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8161C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB03B2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 16:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB03B2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389162AbeKGBc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 20:32:57 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:60989 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389070AbeKGBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 20:32:57 -0500
Received: from [192.168.178.52] ([109.104.45.188]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MgkXH-1g8HvB2CLX-00O2Zr; Tue, 06 Nov 2018 17:06:34 +0100
Received: from [192.168.178.52] ([109.104.45.188]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MgkXH-1g8HvB2CLX-00O2Zr; Tue, 06 Nov 2018 17:06:34 +0100
Subject: Re: [PATCH RFC 09/18] staging: vchiq_core: do not initialize
 semaphores twice
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        dave.stevenson@raspberrypi.org
References: <20181026134813.7775-1-nsaenzjulienne@suse.de>
 <20181026134813.7775-10-nsaenzjulienne@suse.de>
 <1781917429.4071.1540759539282@email.ionos.de>
 <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <9366d835-a291-2770-4409-b88ea1a155e2@i2se.com>
Date:   Tue, 6 Nov 2018 17:06:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ddef268b97543abc9de05842b92e1fc5f0134de8.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Provags-ID: V03:K1:PwMs5Xh9aWgFlBpWdvhuW4dNGbSqGG+tlR4vpZu1C4Xvi/tWdYm
 gzBnuunzMFVAxh/LJPyZXWxsJO40Qe5sQskwQ9ngPaSJOjAlBfCusNc3Sh4Xwnz5/iTOyzT
 RQjxxAkHufX9/3zxYvIgrim9y8Pf45dVxU5tx+gAY6B+lfRdlF3X/GqM4+qEjxMeK2pxlrR
 rUJ1cpQ1rGidA4UWnHXyg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r2GWi1VkVdc=:qlFU028SsX2MGivt5VA1ns
 Vi4u03s81oneN4kqwMxi3VGLDIXRIXG2i4vJVKj00ZdtIAorGPSvkJjtvXScGAIlDMj+g+GLA
 0hk0MC74M9IQ4f3UG0Gy4Dhyerum9MXNAmIAzDzwrxUitKuAKQ0Co+hUOyaboXnPuF4XT8Ajz
 qKbRp7ICb/FUyZJ9+FVHVFp16y1j2Il8OiiAkvRhmEYOHCo1jIxQthpg3xxeFlTcyClqXHUVu
 fkLGmu/jUQzBNXieUn4v/LzXk3FlIGj5Vwl6lgEFMtikRNrkUH9atft3tawFIn3k27CCh54Yk
 3yarD1wyqaM2uXFYE5koCi9oXClmiHC4c6YaiR0TQYX/ah8N9/nCvnLbxeeQGvXKmnwfaAASP
 xzofOvyMPsSSYhxnL/A+2b0TLacfk0ZwkpDsKN24Ok1R/XjcrnSUOAQpdC7OXWDtlsl0A8FkC
 dwlXyZ9dZvrASWiSFwOKh0b2CdDsbwpOYdC9p+ENWhwHYV6ndqHBViKuBSPPSUKT2xyHUXqsH
 EG6apo5ASyLp/nuy0fWVydykrv5b0x1DHo1W3S5irkbz5KkGOdam1qEVz76Detp32DyoodeWx
 ETL55NR0pr7jR9WaUY0AU7HiMDkkit/cnd6CNRErS27akE+2of6iVFth8rAAGW74HjZW2V1g+
 R11e39B04Zb50f3HwOdWonGMfxd3qn4/5FIumn5FPJ7pc72doLVm7ACee5NpRsrV+w4zXhdTa
 XSD0q2hFZ70bQ2uG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.11.18 um 16:41 schrieb Nicolas Saenz Julienne:
> Hi Stefan,
> thanks for spending the time reviewing the code. I took note of the
> rest of comments.
>
> On Sun, 2018-10-28 at 21:45 +0100, Stefan Wahren wrote:
>> Hi Nicolas,
>>
>>> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 26. Oktober
>>> 2018 um 15:48 geschrieben:
>>>
>>>
>>> vchiq_init_state() initialises a series of semaphores to then call
>>> remote_event_create() on the same semaphores, which initializes
>>> them
>>> again.
>> i would prefer to have all init stuff at one place in
>> vchiq_init_state() and drop this ugliness from remote_event_create()
>> instead. Is this possible?
> As I'm sure you're aware of, REMOTE_EVENT_T is shared between the CPU
> and VC4, which can't be expanded. And since storing a pointer is out of
> question because of arm64, I can only think of storing an index to an
> array of completions in the shared structure instead of the pointer
> magic implemented right now. It would be a little more explicit. Then
> we could completely decouple both initializations. I'm not sure if it's
> similar to what you had in mind. 

I don't think so, this was my intention:

 static inline void
 remote_event_create(VCHIQ_STATE_T *state, REMOTE_EVENT_T *event)
 {
    event->armed = 0;
    /* Don't clear the 'fired' flag because it may already have been set
    ** by the other side. */
-    sema_init((struct semaphore *)((char *)state + event->event), 0);
 }


>
> On a semi-related topic, I'm curious to know why these shared
> structures aren't set with the "__packed" preprocessor macro. Any
> ideas? As fas as I've been told, in general, the compiler may reorder
> or add unexpected padding to any structure. Which would be very bad in
> this case.

This would be better, but i assume the firmware side uses the same
source code. So using __packed only on ARM side could also break :-(

>
> Regards,
> Nicolas
