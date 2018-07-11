Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25972C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B670820C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JzEUHgNv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8LAQKBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B670820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbeGKUqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:46:02 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:37044 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeGKUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:46:02 -0400
Received: by mail-yw0-f196.google.com with SMTP id w76-v6so9665640ywg.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 13:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=D7ME7LO5E4s3YJ4FFp74Tx+/SAi4RbuIMCZD6XUQqWc=;
        b=JzEUHgNvOW2smCby/JtyoRdIHzS0WcGOp2HdooFuVRQq5LRhfx7erRjOfsSGzCmwwU
         tZuAo2pACGi9tqc8MjuPGFlLDjSdPVAI1RCZkYozOcEWyOEJ6Zz9GeKZUQw4Cc1wblEu
         yX/mszY2rXUlJxqzIGS/f/HVlqwKff8v7AR6a9tWArgHu3UUrRWb/2FoTfsRu45TQ41E
         hrob/UeWIHKQ9G4v97hfvxYG/7WCbx1HzIR78e8i9HlDWaeTRJq28idqgQOi6VQZmx1K
         ozLHLU3uoFN3jp26WKPDMqBoDyWx0pylFs5kB/ggdiRDghv0VmR0YLM7dPtE5t+d20lH
         hv9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=D7ME7LO5E4s3YJ4FFp74Tx+/SAi4RbuIMCZD6XUQqWc=;
        b=k8LAQKBzGqY7qkSE/HhZx3nhElJCMLMJFBXOcUT4T6q0GYQEM9Pfj3be9wjOvmx0xS
         zxCOUnmKDpLMwgE15CBmEoM7KgQPlKt5hXAbYclwbWiSgtvlEVbXuVvb5c1+r+z+Pxp1
         al/oz5qOg/pd+VpwmQw2zLKJCXH9zp8pkPwt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=D7ME7LO5E4s3YJ4FFp74Tx+/SAi4RbuIMCZD6XUQqWc=;
        b=GZySMl8YulZmDKOT7jCYzbu5KrHzzyyv/PA4hFYhDpe6++N3YLBtjVZOuDzrF/AucO
         c4JtQ5uhHxU7JHjXQEMnWd16tm50gh6dDyEQiYFediPy6kiLNFbB97Q2Uo3QeMgN6061
         FgMj0uThHEHQtL4HPt/BwqGZD0FtMGliwjJpgtJtASh7cfGjw86C49zeFB2avI60brd9
         jf2w5VXdBSm0ufI99cPk2kQDEhOVlklwwhdp3v7NWZjI5ryWo/WC8CWhm01PhWN0gb9P
         p2A94IvEDWs1HwsWZ7yYTx7/UrNVPA90Bp78BgUNfvyb35olqmmZV2mri2f0VKsuet6p
         fpug==
X-Gm-Message-State: AOUpUlEY2RRKWj/lezYKiXvgCT4v/YmG3MTzqcc6Ye/9y4/DBElUmkJM
        RK45LfNnSP8RlfEi4mXI18lX2vii3DGYL9GG41xa6A==
X-Google-Smtp-Source: AAOMgpcys6oTzXjnFbCPNu2Y+kexUDOmX4O7Ik5pOV+7rHIrPChn1oWspXapiub+d9mvvy1YecttCMq3mzdAA5BgZS0=
X-Received: by 2002:a81:8742:: with SMTP id x63-v6mr80904ywf.129.1531341596755;
 Wed, 11 Jul 2018 13:39:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 13:39:56
 -0700 (PDT)
In-Reply-To: <20180711091848.GA2889@kroah.com>
References: <20180627035642.8561-1-nicolas.pitre@linaro.org>
 <20180627035642.8561-2-nicolas.pitre@linaro.org> <CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com>
 <20180711091848.GA2889@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 11 Jul 2018 13:39:56 -0700
X-Google-Sender-Auth: ozn6XTOEqCYMCcYk_76GUSQ_YXE
Message-ID: <CAGXu5j+3M6go8HZRC0=ZW8v6_qkFKuLE_cQGta7tnG6t+SBnxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] vt: preserve unicode values corresponding to
 screen characters
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nicolas Pitre <nicolas.pitre@linaro.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-console@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 2:18 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Jul 10, 2018 at 05:52:01PM -0700, Kees Cook wrote:
>> On Tue, Jun 26, 2018 at 8:56 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> > The vt code translates UTF-8 strings into glyph index values and stores
>> > those glyph values directly in the screen buffer. Because there can only
>> > be at most 512 glyphs, it is impossible to represent most unicode
>> > characters, in which case a default glyph (often '?') is displayed
>> > instead. The original unicode value is then lost.
>> >
>> > This patch implements the basic screen buffer handling to preserve unicode
>> > values alongside corresponding display glyphs.  It is not activated by
>> > default, meaning that people not relying on that functionality won't get
>> > the implied overhead.
>> >
>> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> > Tested-by: Dave Mielke <Dave@mielke.cc>
>> > Acked-by: Adam Borowski <kilobyte@angband.pl>
>> > ---
>> >  drivers/tty/vt/vt.c            | 220 +++++++++++++++++++++++++++++++--
>> >  include/linux/console_struct.h |   2 +
>> >  2 files changed, 211 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
>> > index 1eb1a376a0..7b636638b3 100644
>> > --- a/drivers/tty/vt/vt.c
>> > +++ b/drivers/tty/vt/vt.c
>> > [...]
>> > +static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
>> > +                            enum con_scroll dir, unsigned int nr)
>> > +{
>> > +       struct uni_screen *uniscr = get_vc_uniscr(vc);
>> > +
>> > +       if (uniscr) {
>> > +               unsigned int s, d, rescue, clear;
>> > +               char32_t *save[nr];
>>
>> Can you adjust this to avoid the VLA here? I've almost gotten all VLAs
>> removed from the kernel[1], and this is introducing a new one. :)
>
> This is already in my tree, sorry :(

Yup, that's fine. (It's how I noticed it: linux-next VLA build tests.)
I'm just hoping it can get solved before the merge window opens. :)

There are still a bunch of VLAs I'm chipping away at, but this was a
newly added one, so I was hoping Nicolas (when he's back from
vacation) will have ideas on how to best avoid it.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
