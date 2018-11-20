Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F5CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D51F420870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDhyjCUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D51F420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeKTMkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:40:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45633 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbeKTMkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:40:13 -0500
Received: by mail-io1-f65.google.com with SMTP id w7so231334iom.12;
        Mon, 19 Nov 2018 18:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0o6x8LHZlmsB8IsUWSeWQr8y1noQmGzj1ql3R/6AFBI=;
        b=fDhyjCUwwBBve4lguGvph3JF2dK9tSXCvyhzfcqrtLxuLsyXm7tVpBVxzdkbgwWMLc
         VRcOEKg7T3ndFQjYTTxBXjxP8Vq6RSq4u/TCezb0bns2DIZ4JbminMLjMX+KKo7cO9Sk
         On7nbQ71AodZyQypmarVbXuQlpwpGbfa19ApaUDnQ4PXknhdOfAgT+exC8W7xrmrzPRF
         lgIW8Lfq17atyeOwndqJxJNM9chKWp3BZHAlUEqtksILQjzRip+QDBjI9uHMHaj2LFbR
         7ASKtcgMiffqW+VS53EbYO1hfLp1NzRbWe7TUxYlc+17O+fGuZywSPK/TSc+/VPPm+D4
         rv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0o6x8LHZlmsB8IsUWSeWQr8y1noQmGzj1ql3R/6AFBI=;
        b=IPVhQ7YzD4HBwe+TlnLWKirOImof2lCnfk6SR1pChWGmuSXjmjW/ysb3okfej/OUjg
         YMaBhRv1gMIfcYv1FJRXnUe5b2/9o6CA3AlyB7KNKwZBzdDTi6i2mcwXtQrFI4oJ2p79
         3Hk9Ld/L3y7YdxuPbHwMsVOBXBCUo0inXSiJz9tyyKxBXCyObXvilCwju9rxYKfXF4TD
         6jJBfGGLXyOPO/Eaet8MrPIMwiVsJfqgUY9Eo0FOLfNg46xGwnGR+c+YNx7Xb4ks5RSK
         ujaCNQ/ApYAszfkHTqHvqg9avSioL9tKLI6g93uFqh9NMCZ+O8tVeTjsgcuz/z5XMLCf
         wfJA==
X-Gm-Message-State: AA+aEWYFZMU2cEbcD4lixvQdxrKkqjIjy4cc2LwHDII8doF6M/QyYxof
        0oLlneclJLuzuuHjpEHC8loZQXxxFzN9dHGnC7M=
X-Google-Smtp-Source: AFSGD/XPgpvMAg7G2JPzf434huuDMlLJlcUd7plDLsDkqK6Bw1nGtInMDjuc5qpMQ0fEa78Oy7Zd6WfQEhZNK09cDNQ=
X-Received: by 2002:a6b:b2d2:: with SMTP id b201mr91332iof.303.1542680011758;
 Mon, 19 Nov 2018 18:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20181103065732.12134-1-jprvita@endlessm.com> <20181105091917.GD4439@amd>
 <CA+A7VXXUB2CZUyPtaMya7in7ntO_unbqVnaZyfCBT_BXtAxeQQ@mail.gmail.com>
 <CAD8Lp46Go79C_xOkzM-hq4umET1M62Ofqw48swn1JNocifET3Q@mail.gmail.com>
 <c883a2be-e772-2e18-f074-d2ad5f27f42b@redhat.com> <20181111122243.GB28794@amd>
In-Reply-To: <20181111122243.GB28794@amd>
From:   =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date:   Mon, 19 Nov 2018 18:12:55 -0800
Message-ID: <CA+A7VXWwfh-jdiq60kwY65k29BXP6PNOc9=X7b6SYF9=T65UUA@mail.gmail.com>
Subject: Re: [PATCH] ACPI / battery: Fix reporting "Not charging" when
 capacity is 100%
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Daniel Drake <drake@endlessm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, linux@endlessm.com,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 4:22 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Sun 2018-11-11 12:57:12, Hans de Goede wrote:
> > Hi,
> >
> > On 11/7/18 5:53 AM, Daniel Drake wrote:
> > >On Mon, Nov 5, 2018 at 1:19 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >>Plus, I don't think "100% charge" is right test for "battery full". A=
t
> > >>least on thinkpads, there's configuration option, and it is common
> > >>_not_ to charge batterry above 95% or so (to increase its lifetime).
> > >
> > >Hans also touched on this area in his response:
> > >
> > >>As for this kernel-side fix I do not believe that fixing thus in
> > >>the kernel is the right thing to do. We try to stay away from
> > >>heuristics using full_charge_capacity in the kernel since that
> > >>is not really reliable / deterministic.
> > >
> > >I'm not fully convinced by this argument though.
> > >
> > >The ACPI spec is not very clear on what conditions you should apply to
> > >decide when the battery is full. Instead, ACPI seems to provide a
> > >pretty decent amount of data, and the decision about whether to
> > >interpret that as "battery full" is left for consumers.
> >
> > Right, but in this case the "discharging" status bit is explicitly
> > set, to me it feels wrong to report "full", when the firmware
> > is reporting "discharging" IMHO, at best we are "not charging"
> > (on AC, below the threshold where a new charge cycle starts) and
> > that is what we are currently reporting.
> >
> > Anu heurstics to decide that "not charging" is close enough to full
> > to report it as full to the user belongs in userspace IMHO.
> >
> > Anyways this ultimately is Rafael's call. If Rafael is ok with this
> > patch then I would like to see Pavel's comment addressed and otherwise
> > it is fine with me.
> >

If we can get to an agreement on this I'll send a v2 without division.

> > Note that we will still often get the case where a laptop is charged,
> > reports full, is unplugged for 5 minutes and then replugged and then
> > reports a capacity of 97% combined with "not charging", so we will
> > still need to fix userspace to handle this.
>

Yes, I agree that should be addressed in userspace, as it is pretty
much a policy decision.

> For the record, I don't think I'm okay with this.
>
> There's nothing special about 100% charge.
>

I don't agree there is nothing special about 100% charge. There is a
separate state to represent battery full for a reason, which is the
user wanting to know when their battery is 100% charged and not being
discharged.

> This changes userland ABI and I don't think it has good enough reasons
to do that.
>

This only changes which state will be reported when the battery is
100% charged and not discharging, it does not introduce / remove any
values. I don't think that is considered ABI change, and on other
hardware like the Dell Latitude 5480,
/sys/class/power_supply/<supply_name>/status already reports "Full"
under these conditions. I still believe it is a bug that makes the ABI
inconsistent across different hardware.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
