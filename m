Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14205C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25BB26646
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Jo2D6ZnU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25BB26646
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965183AbeF0OPt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:15:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39330 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbeF0OPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:15:46 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so7657283itp.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 07:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Fda9fGvfyCPa9rSrrA5BMQzltWleBHcm5jvnX39Puvo=;
        b=Jo2D6ZnUinqXfR6PbpVkWr70CWL16gaoI3WIFF/EhwukyAKXqBgdGO0fURyejqONOd
         9hKOjy8yFwBvup/fB86yxwkeyzNkktgGqyzfBpK3R3JRwd0tEBNlWcwPZg8NH0A5UHAJ
         4T2Kq6JfGYa6gbKoPRpmuigtleOOFUCHlDYWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Fda9fGvfyCPa9rSrrA5BMQzltWleBHcm5jvnX39Puvo=;
        b=tTuw8u55s7LlFhAFtFF9c0Cs0nN2UDMgHY8aNZPzpnHAdgo139cAzFSROuSIHNGPp8
         8ZqStEEPIsJ9MMa8csngqaVPVZ+ZrBs3v0uo34jRx3dNACn29MiGnOh7L8jcxhh5APkM
         i+9KcKg1TsLghRNaExaafyncC5LqCa2kb7ii09axb1tG0X6MAkXHRdlvTZpXY8lMM7+l
         2iI3FNbvyeBxCInfOH0CsTlxzhifG/6hCsX0UGV/jlKCPzQFo/cnC8GfUL1nBr3WVtNu
         JNQoFOySYtfqNurl0SYlsKqyo4fWw1+2smAMVgIT7GgA8JiHN0RfgdsDi2Fw229bul+A
         QGnw==
X-Gm-Message-State: APt69E0yjrkgljVFCo8cuj4YeXK1+2OBzIQSlPGnvCWw+CEQShEfZOgB
        hrG671TdCrRk8lWAlSO2/gA8Bv+PR84Q1Tln0xZsHg==
X-Google-Smtp-Source: AAOMgpf4Em3lW1e5kL2QJFWd1oZ6tP0JowZ3WZuOvYus2tZfaCEg426rTUt8RgH0xlXFUSXgQWnSZhtob5fGIHX788A=
X-Received: by 2002:a24:52:: with SMTP id 79-v6mr5150184ita.58.1530108945867;
 Wed, 27 Jun 2018 07:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e48b:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 07:15:45
 -0700 (PDT)
X-Originating-IP: [212.51.149.109]
In-Reply-To: <84977ce7-bfee-523a-852f-defc0243b520@redhat.com>
References: <20180626183612.321-1-hdegoede@redhat.com> <CGME20180627091530epcas1p4bcb4d5421da77cd2e262e839dd50e5dc@epcas1p4.samsung.com>
 <20180627091520.GI13978@phenom.ffwll.local> <66532157.tkLS2buF0U@amdc3058> <84977ce7-bfee-523a-852f-defc0243b520@redhat.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 27 Jun 2018 16:15:45 +0200
X-Google-Sender-Auth: j-XS6qni04AU2oTDTC9JDofyBLQ
Message-ID: <CAKMK7uFZ4MmUMbPn_V84brvVnv0sqdW30FGaYmqn2CSAyTYwiw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] console/fbcon: Add support for deferred console takeover
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 1:13 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 27-06-18 11:47, Bartlomiej Zolnierkiewicz wrote:
>>
>> On Wednesday, June 27, 2018 11:15:20 AM Daniel Vetter wrote:
>>>
>>> On Tue, Jun 26, 2018 at 08:36:09PM +0200, Hans de Goede wrote:
>>>>
>>>> Hi All,
>>>>
>>>> Here is v4 of my patch-set, to delay fbcon taking over the console (and
>>>> binding to fbdev devices) until there actually is some text output to
>>>> the
>>>> console. This is intended for use with the "quiet" cmdline option, in
>>>> combination with a bootloader which leaves the vendor's logo /
>>>> EFI bootgraphics put up by the firmware intact on the EFI framebuffer.
>>>>
>>>> The end goal here is a boot where the firmware shows its boot graphics
>>>> and these stay in place for a couple of seconds until the GUI loads and
>>>> the GUI then smoothly takes over the framebuffer without any
>>>> distruptions.
>>>>
>>>> This patch-set spans 2 subsystems.
>>>>
>>>> Petr, the printk subsys change is really trivial (1 line addition) can
>>>> we
>>>> get your Acked-by for merging all 3 patches through the fbdev tree?
>>>>
>>>> Changelog:
>>>>
>>>> Changes in v4:
>>>> -Keep the comments about which fbcon functions need locks in place
>>>>
>>>> Changes in v3:
>>>> -Export is_console_locke() for use in modules (as fbcon may be built as
>>>> a .ko)
>>>> -Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to
>>>> assert
>>>>   proper locking (requested by Daniel)
>>>> -Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by
>>>> Daniel)
>>>> -Document the fbcon=nodefer commandline option (req. by Emil)
>>>>
>>>> Changes in v2:
>>>> -Check the whole string when checking for erases in putcs, instead of
>>>> just
>>>>   the first char
>>>> -Make dummycon_blank return 1, so that a redraw gets triggered and any
>>>> text
>>>>   rendered while blanked gets output so that it can trigger a deferred
>>>>   takeover if one is pending
>>>
>>>
>>> Wrt merging I think it'd be best if we stuff this into drm-misc-next -
>>> that will increase testing by gpu drivers a lot, instead of a suprise
>>> when
>>> the fbdev pull lands in upstream.
>>>
>>> Bart, is that ok with you?
>>
>>
>> Not really, since there are efifb changes in the queue which depend
>> on this series I would really prefer to merge all patches through
>> fbdev tree.
>>
>> Also fbdev tree is pulled into -next kernels so testing coverage
>> should be okay (I assume that everybody are testing -next kernels in
>> addition to their own branches :-)..

Ime this is a rather unrealistic assumption ...

> If you are talking about the "efifb: Copy the ACPI BGRT boot graphics to the
> framebuffer" series, I could push those to drm-misc-next too (once acked).
>
> I think most GPU driver developers are running drm-tip and not
> -next, so putting things in drm-misc-next would give the changes somewhat
> more test-exposure on a wider range of GPUs I believe. Where as -next
> testing will likely be more server use-case oriented.
>
> Alternatively you could merge things in the fbdev tree, do an
> unmutable branch and then that could be merged into drm-misc-next by
> the drm-misc-next maintainers.
>
> Note either way is fine with me. This is up to you and Daniel.

Yeah pull request for a topic branch works too.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
