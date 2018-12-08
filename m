Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD8C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31E020892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 00:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XsC+M7Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31E020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbeLHAr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 19:47:26 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42721 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHAr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 19:47:26 -0500
Received: by mail-lj1-f174.google.com with SMTP id l15-v6so5011808lja.9;
        Fri, 07 Dec 2018 16:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=odJpeUasU4qKiz1x78lp3PTSc6ilusXyj5bvBT2Wcdk=;
        b=XsC+M7OdXSZ2Bhivq2XTwl4kbScgk/Nv1mbju4TJ/yjgIc/ePHV9WuSz+guNA9jJwi
         W/7KOEfm8K7S14nE30ATTloH727iUNhyh4M+TJQZ/gxTyGh9pHyecQtmFr9z1rV/9t/v
         TdInJRk6DM7WY0bP1iHok03ELJXaeopcnyDsJlnrAvFddMaZUm3U52OAGctoe35WeIlb
         eNaEBdMgVL8Q2QKcGw58pqxiB/8dnFHgzsWqXwdiC8nrpZBcBTexzdeO7sWHiWvyS/g7
         +ZH5RwHNgU+mBUhZBahsPW/yeFftImj1QNBGh8p3PuVKuPcbW0BNP9S7PIWZVORDT768
         r53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=odJpeUasU4qKiz1x78lp3PTSc6ilusXyj5bvBT2Wcdk=;
        b=Bc3HL3aTuhLX3g/3y4OzZUL7D1OFdvqZaCCvYApB2YaZdRo4dwOvggrj0dxjb6fC8b
         pdpCcjvdIkEfBjMAsjxu6qzY1pCZSUGuEI9+mXeQjTuYZaRsqNnh4qw/AJjCKKGXA5Rp
         By9aFFUkuMnvOOpLcbmbHmyUDsZh5QEkdAEIK6SX3cv6hJodIieQWsHIbj9xYtfvSRtB
         M6gVNdqelXbvAk/paNHjaN1k95YAWfC5dtdyuZt3OAc33jvRcgraNnJN56GIG1CHs/vW
         1fjY2yPeJLWsexlZEr5bgCimB1jvFaCrKlgroysKeW5Qmpo4958s2YqihnhhM2gEeoFI
         Fx6w==
X-Gm-Message-State: AA+aEWaRiH/M+JkTB9QvwN4tXM0W/+HzDC01MByJ/auDSjPngTbkfcFD
        5LY23P0Y+9BW9pGLxffvcDldkuH+JF6PDeg+ooQ=
X-Google-Smtp-Source: AFSGD/XyZqEMrjuNv6fvn3BYDV0s5Ma0gTVa0MuUZ2lgjL/zAGnKQzeBQDmV9cwqA0yTJp27UIHKNebQLHPjorOfG5g=
X-Received: by 2002:a2e:55d3:: with SMTP id g80-v6mr2801673lje.78.1544230043895;
 Fri, 07 Dec 2018 16:47:23 -0800 (PST)
MIME-Version: 1.0
References: <674a80a7-e956-ef2d-3095-41473851a402@molgen.mpg.de>
In-Reply-To: <674a80a7-e956-ef2d-3095-41473851a402@molgen.mpg.de>
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Sat, 8 Dec 2018 00:47:12 +0000
Message-ID: <CANVEwpZjEeXB7wq5Jzj=Z9A6SYpuQrK4WUetDLEX3e5OCfDLLA@mail.gmail.com>
Subject: Re: Recommended driver for current AMD processors
To:     pmenzel@molgen.mpg.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zarniwhoop@ntlworld.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, 7 Dec 2018 at 15:32, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Linux folks,
>
>
> What driver is recommended for current AMD Ryzen based processors
> like *AMD Ryzen 5 PRO 1500 Quad-Core Processor* or *AMD EPYC 7601
> 32-Core Processor*?
>
> Only from the acpi-cpufreq Kconfig description, I assume, that that
> driver should be used.
>
> > config X86_ACPI_CPUFREQ
> >         tristate "ACPI Processor P-States driver"
> >         depends on ACPI_PROCESSOR
> >         help
> >           This driver adds a CPUFreq driver which utilizes the ACPI
> >           Processor Performance States.
> >           This driver also supports Intel Enhanced Speedstep and newer
> >           AMD CPUs.
> >
> >           To compile this driver as a module, choose M here: the
> >           module will be called acpi-cpufreq.
> >
> >           For details, take a look at <file:Documentation/cpu-freq/>.
> >
> >           If in doubt, say N.
>
> Would a =E2=80=9Cnative=E2=80=9D driver like Intel=E2=80=99s P state driv=
er also give better
> results? Do you know if AMD is working on something like that?
>
>
>
> Kind regards,
>
> Paul
>

As a mere user, I bought a ryzen 3 1300X earlier this year, and was
annoyed about how the frequencies changed when a single-threaded
compile moved to a different core (unlike e.g. a haswell where
frequencies barely vary).

I have a meter which can report the current power consumption
for the system (computer, monitor, network switch, kvm switch), and
using that to keep an eye on the range of reported wattages when idle,
compiling with -j1 and compiling with -j4, I eventually formed the
impression that the ondemand governor was marginally better than
the performance governor, and that omitting cpufreq did not appear to
increase the poer consumption.

But that is just one set of observations.  I agree that using less
power and getting faster compiles would be nice, so if something is
available I'll be keen to try it.

=C4=B8en
