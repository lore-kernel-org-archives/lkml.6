Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351AEC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62A025114
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EfvEKspY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EGnJVhjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62A025114
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbeGBPwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:52:54 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41012 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeGBPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:52:51 -0400
Received: by mail-yw0-f195.google.com with SMTP id j5-v6so6824227ywe.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p8COMMhbij/eFfiFCUlu35weFOIXBdcNru3DvjzmAg8=;
        b=EfvEKspY5jg1dqwr3KXa/aVAX0Xokw66bHfFgFoWgIR3zBddhV/p0CbpBhL83FVRIT
         SBXxCshGSUlC37nZDJEFDtgyUKdi525vt7nWqgm6eN2bNQsGUYJXjqvZM6hshSqqI98B
         z5+/++Yf2QmJBCTk7juWMto7LZQxDcnhkO4Q8XXTKzymFkZ40Exy6e7cKpx6w0epM1pE
         Yg8sx4RbDe7x0Il0/hb3KCsLUuL994SSu0iBW/gB+3I3q/hsvH6ZNDeeBG/9dAB3WNjj
         fAeUBnA/+DMP2PYPUtJA2TqdWdyimwb/uC1C75bPlcFFQuYCao2aqx2txfko2NjMPet/
         UvDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=p8COMMhbij/eFfiFCUlu35weFOIXBdcNru3DvjzmAg8=;
        b=EGnJVhjv7C2OZPX4gAfmOOp8pxHZyR2Og7pHFYsEwDiiBZSSrZ72vu5VlXOK6Ud6lq
         WQ1VnB/Z05Cm6OkVv0txI6T/ldAI96cczR2D2QISe5CjpyvWeDkzxOHBD56SaYF4KcWf
         auR+xfwXT3nOVUp4pvwCUqTSMLWDXFHjDVtR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=p8COMMhbij/eFfiFCUlu35weFOIXBdcNru3DvjzmAg8=;
        b=m95dTItF66x0wV4mMtkIOIjYppxKZPMM25wErEjqK5QEANzhnN2TxvrJ82m24Xbx0R
         Q72T1LHwRKGoXhDHOZrjxRNlgZMGkhCBTXn17Gs1N4EGx8K35/xu9323uzaaeXYFN3hE
         I1ZAr82KTHTH25hCz7amRVh3y8IhLinY2oxaV6asBJemDgiZOQuaIapq3o4FrUE7hanI
         kvRDVqcxIEqiGP1FYSJVJ4TkM5jI/dInFNqIHRZ+CoCN+1BuBex1wtW6kEaaQFtfEl0S
         LtvFy0iVuorL4Ro6qhZpqfQ7z18AtrZp3zAYNREQphhaippPrv/lajyAjjNjy1p5VUnd
         MycA==
X-Gm-Message-State: APt69E0bcgSPQfohe5pG0HXJRJa+4z2cgT8QriaIZqX44s4ptcya02ql
        gdgevKAYXj1uSnxSQzSdJB+egQo9hEGqD06MclGN3hQ5
X-Google-Smtp-Source: AAOMgpdalqPM7cTSRZ+c+Nog3zVA4xtXp83KZiK9UwYwoXJLrKlCZ7iTWSZyxiAk+6rNWiH1iPYLOuDz4nKx99JBlLE=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr12412526ywn.88.1530546770745;
 Mon, 02 Jul 2018 08:52:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 08:52:49 -0700 (PDT)
In-Reply-To: <87fu12mnf7.fsf@concordia.ellerman.id.au>
References: <20180629185339.GA37582@beast> <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com>
 <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com> <87fu12mnf7.fsf@concordia.ellerman.id.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 08:52:49 -0700
X-Google-Sender-Auth: dHj0xhfTm0BUQMQFW6pTMpboTu8
Message-ID: <CAGXu5jLn0G0Qm=DUOuZ3chtOiRTZLVDnepXo5Nu-SwrHz_eyuQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Anatolij Gustschin <agust@denx.de>,
        Paul Mackerras <paulus@samba.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 1, 2018 at 6:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Kees Cook <keescook@chromium.org> writes:
>
>> On Fri, Jun 29, 2018 at 2:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Fri, Jun 29, 2018 at 8:53 PM, Kees Cook <keescook@chromium.org> wrote:
>>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>>> switches to using a stack size large enough for the saved routine and
>>>> adds a sanity check.
>>>>
>>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>>>
>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>
>>> This seems particularly nice, not only avoids it the dynamic stack
>>> allocation, it
>>> also makes sure the new 0x500 handler doesn't overflow into the 0x600
>>> exception handler.
>>>
>>> It would help to explain how you arrived at that '256 byte' number in
>>> the changelog though.
>>
>> Honestly, I just counted instructions, multiplied by 8 and rounded up
>> to the next nearest power of 2, and the result felt right for giving
>> some level of flexibility for code growth before tripping the WARN. :P
>>
>> I'm happy to adjust, of course. :)
>
> What if we write it:
>
>        char saved_0x500[0x600 - 0x500];
>
> Hopefully the compiler is smart enough not to generate a VLA for that :)

Sure, that's fine. I'll send an updated patch.

-Kees

-- 
Kees Cook
Pixel Security
