Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EDE2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EDE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbeHaTCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:02:45 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33602 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeHaTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:02:44 -0400
Received: by mail-qt0-f171.google.com with SMTP id r37-v6so14850875qtc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Kn/nV4TiAUEfZmLEBc5B4IjfnoDt9xtPo51sxWMs/c=;
        b=el3K/nrCcmkQ2dNSj0RZlOzOkRkWqLxOPqtlO+xjb1eeAqAvBiIiQsvaLZkJwmmKwU
         F3eHRi7lo6PP8pMUvMxXtyP+IvZG6MCWxDio6VmSWso3ur9gwicuZgr5a4lNAgJ6iVTI
         oR7H403mLSiLi69knVhZ97pDGkLgNZ5M9N3QzHYvrBLGc1B6x15i+ynC7+QlIAvYMjqF
         kzKjaGvqlylMgKzXovISHFNcbTlSl/iUpu2U5WR1vEr1d47yc3H4SqjRk93hVfmcJ7vn
         DRzr0iLApdN56m0dPHe+jrprfZ5T9HVN9ofXV6uTKw3KlVYFy5XuqgsCyDJSY6Vzo1tp
         sHdw==
X-Gm-Message-State: APzg51DyyG+kniPk1kKNnRJ7QJCPd3C/dILEboBg5WTHieNxkeUXVihJ
        Mmcp8jjCjgqnB0/sq6ySL839+QVSjv9V3YlveWgeSQ==
X-Google-Smtp-Source: ANB0VdYBSiH6fqRqA37YxCTypGeYTQBTinn0qqXhRjNhRsFFhzSCWCxN7IXZsiJqV4y4iXzzrE7Bu+RHiJ9FDchYUsM=
X-Received: by 2002:a0c:fc49:: with SMTP id w9-v6mr15817445qvp.166.1535727292429;
 Fri, 31 Aug 2018 07:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20170629121009.30234-1-benjamin.tissoires@redhat.com>
 <CAHp75Vdn1-m0gDSHtZXX2A=Q07xG9j1eBiV8iM4e11Qk=oJfZg@mail.gmail.com>
 <20170630155706.GL26073@mail.corp.redhat.com> <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
In-Reply-To: <CAHp75VdLU57x2YuDH+SkB1jR3rSpqcVNszhq5fDUVZZt+sqxyQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 31 Aug 2018 16:54:41 +0200
Message-ID: <CAO-hwJ+U+e8a70LskxaSLV_hjWejpqjBWC788mEOOcUg=oxBCw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: surface3_power: MSHW0011 rev-eng implementation
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>, stephenjust@gmail.com,
        Sebastian Reichel <sre@kernel.org>, rafael.j.wysocki@intel.com,
        lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com,
        mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I am resurrecting this thread now that ACPICA seemed to finally have
fixed the bug that prevent the driver to work.
The patch I submitted was reverted shortly after, which lead me to
ignore this review until ACPICA was fixed. It took a lot of effort
from Hans to have a fix accepted, so now we can hope to upstream this
driver.

On Fri, Jun 30, 2017 at 6:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jun 30, 2017 at 6:57 PM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> > On Jun 29 2017 or thereabouts, Andy Shevchenko wrote:
> >> On Thu, Jun 29, 2017 at 3:10 PM, Benjamin Tissoires
> >> <benjamin.tissoires@redhat.com> wrote:
>
> >> What devices (laptops, tablets) have it?
> >> Surface 3. What else?
> >
> > So far, Surface 3 only. It's a Microsoft PNPId, so I guess they control
> > which device has it. Maybe the model after the Surface 3 (reduced
> > platform) will have such chip, but for now, it's unknown.
>
> Please, extend introduction in commit message to state above.

OK. On this note, I have been mentioned that the Surface Pro 2017 uses
a similar mechanism as in it's also using an operation region handler,
but this time over UART, not I2C :)

>
> >> > I couldn't manage to get the IRQ correctly triggered, so I am using a
> >> > good old polling thread to check for changes.
> >>
> >> It might be
>
> It seems I didn't finished the sentence here.
>
> I though it might be actually ACPI event, GPE or direct IRQ (when GPIO
> chip should not disable it, though if it's the case it likely a BIOS
> bug for this hardware).

If you don't mind, I'd rather have the polling version that seems to
be working first. I haven't touched the logs I had from Windows since
last year, so I am a little bit rusty on debugging this.
FWIW, /proc/interrupts doesn't change a bit when I unplug/replug the
power cable.

My guess is that the Windows driver initializes the chip in a
different way and this enables the cable detection.

>
> >> > +       help
> >> > +         Select this option to enable support for ACPI operation
> >> > +         region of the Surface 3 battery platform driver.
> >>
> >> > +/*
> >> > + * Supports for the power IC on the Surface 3 tablet.
> >>
> >> Shouldn't it go to drivers/acpi/pmic folder ?
> >
> > Already answered later in the thread, so yes, I'll move it there.
>
> Actually Hans did a good point, so, feel free to use drivers/platform/x86.

Roger that!

>
> >> And did you check if it have actual chip IP vendor name and model?
> >> Most likely it's a TI (based?) solution.
> >
> > As mentioned, I have strictly no idea. I can not crack open the Surface
> > 3 without breaking the warranty (I already had to return it once because
> > the disk crashed).
>
> We have one indeed cracked (screen is broken for good :-) ), so, I
> would check what I can find there.
>
> > And I do not find anything brand-related under Windows either:
> > - it's called "Surface Platform Power Driver"
> > - and the driver is provided by Microsoft
>
> Fair enough.
>
> >> > +static int mshw0011_bix(struct mshw0011_data *cdata, struct bix *bix)
> >> > +{
> >>
> >> > +       memcpy(bix->serial, buf + 7, 3);
> >> > +       memcpy(bix->serial + 3, buf, 6);
> >> > +       bix->serial[9] = '\0';
> >>
> >> snprintf()?
> >
> > probably :)
>
> I would do this until we have an evidence that it contains non-printable symbols
> (or, in case you want to fix ahead, make the buffer 4 times bigger and use %*pE)

I can't really make the buffer 4 time bigger. The buffer is then used
by the DSDT table to report the _BIX status, so the length of 10 is
mandatory.
It doesn't seem to hurt, and worse case, we will just strip the
serial, not a big deal IMO.

>
> >> > +       memcpy(bix->OEM, buf, 3);
> >> > +       bix->OEM[4] = '\0';
> >>
> >> snprintf() ?
>
> Ditto.
>
> >> > +       snprintf(prefix, ARRAY_SIZE(prefix), "%s: ", bat0->name);
> >>
> >> > +       prefix[127] = '\0';
> >>
> >> Why?
> >
> > Just me being paranoid in case the code doesn't follow the spec... Yeah, I'll
> > remove it.
>
> snprintf() despite n in the name takes care of terminating NUL.
>
> >> > +static int mshw0011_probe(struct i2c_client *client,
> >> > +                         const struct i2c_device_id *id)
> >> > +{
> >>
> >> > +       data->notify_version = version == MSHW0011_EV_2_5;
> >>
> >> 0x1ff as version sounds hmm suspicious.
> >
> > So after a little bit of digging, it appears those values were taken
> > from the DSDT:
> > https://bugzilla.kernel.org/attachment.cgi?id=187171 line 11694.
> >
> > It appears 0x3F is EV 2.1 and before, and 0x1FF is EV 2.5 and above.
> > The returned value is not a version of the chip, just a flag to know
> > which path we are taking in the DSM.
> >
> > The name is probably not the best.
>
> 63 and 511 looks too suspicious to be a version. Rather block size, a
> mask or alike.

I replaced the 'version' by 'mask' in v3. It doesn't hurt to do so.

>
> >> > +static const struct i2c_device_id mshw0011_id[] = {
> >> > +       { }
> >> > +};
> >> > +MODULE_DEVICE_TABLE(i2c, mshw0011_id);
> >>
> >> ->probe_new(), please.
> >
> > Correct
> >
> >>
> >> If I2C framework is _still_ broken we need to fix that part.
> >
> > I haven't check, so let's see for v3.
>
> Cc: Wolfram for v3 and ask him directly. Last time I checked it looks
> like I2C core doesn't care about ACPI when ->probe_new() is used.

Looks like things are working fine now. So I can just submit the
driver without bothering the I2C core team :)

Cheers,
Benjamin
