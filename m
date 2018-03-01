Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3692783-1519932189-2-6606140612438333645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519932188; b=Eki1RxQDkRoWCRYAYqvmWHjUPZyy4rruR9mD5HVTXO8QLGN
    gfj+KrU+E+/wpMGDfm2WtfbyKrdItgQsSzzDVo6OlPwDM7g2ypgCO5rPrbfbJt8z
    GcxlgeZWl+DCGkY0ldpwNgOGXK8H+ABW/zebWY332EsDHeBZuwjiXwelBRiZW2k1
    GyiRBqpNy/qqwhHZKmrFOuVVakqVDZ+2Q2ZslXcM2FMkBKHNhmBTn1+1bbV2zk1r
    qkrMbQ02oU0HLfQaxGFondKMRKpnhCjciicNVOF18DshE7cusAB5ybI6K6pkXyHo
    6tE8ft/ubhDiqENo5XfVmOaw9xWVcRWyJ0ukTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519932188; bh=wH+zVAaZlGJ6F5dt5oyg0EBJcBAeUNR+luuskK
    c9/RU=; b=ftACTyT4cvpwQlVUgQ128lYs9izrXV1Qn110XFA/Ttxii7A7DukOLj
    8L2z6Hd7pZTaCmXDDpbNjM7cxJVA0Ni+06nYdlomwSE6MBv6YbV/IOD+IJWjS6Rt
    Jrrzo0LSJq2+xGmOVStxAB3J2meyiuaHVo0xCCMofbgIlwna7xlvcZUyAC9NeKOe
    s4+/q18fBnV3IA/pDLwX1E6wgD7AJhWAcZrbMr3/ez7X19O/yENyH70amqLB6gRv
    Ud21rOwmpFfO/QCu3O13wgMeX/QiQ8HfAEnN2yBy1z3iDVb5t72HLqHom1xsVHAj
    08YWmboNs0zc2lqwg8HbPpVPSsg4wgdw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=dt3m7pl7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DTJp21Gp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=dt3m7pl7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DTJp21Gp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161221AbeCATXH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 14:23:07 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40334 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161215AbeCATXF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Mar 2018 14:23:05 -0500
X-Google-Smtp-Source: AG47ELvZG3ETTW12VHepikzSxlZr6DzIUhLqu0o0DqLJhJOeEbWR+XO2s2xEnwdEDosavEAbS5Zb7fcJo1+BF2j6l04=
MIME-Version: 1.0
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
In-Reply-To: <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 01 Mar 2018 19:22:52 +0000
Message-ID: <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: adurbin@chromium.org, Brian Norris <briannorris@chromium.org>,
        corbet@lwn.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, cdall@linaro.org,
        paulmck@linux.vnet.ibm.com, marc.zyngier@arm.com,
        frederic@kernel.org, dwmw@amazon.co.uk, tom.saeger@oracle.com,
        zohar@linux.vnet.ibm.com, alexander.levin@verizon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Thu, Mar 1, 2018 at 8:43 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:

> Please, hold on with new versions.
> I'm not satisfied (yet?) by the approach.

Copying over your comment on v1:

> It needs to be discussed.

Sure.

> First of all, if you are going to do this you need to add a parse of
> human readable formats (IIRC kernel has helpers), i.e. "48M", "38.4M"
> and so on.

> Next, I was under impression that purpose of earlycon (in difference
> to earlyprintk) is to re-use existing drivers as fully as possible.

> So, what exactly happens in your case? Are your driver lacks of
> properly set clock? Or earlycon does simple not utilizing this
> information?

"earlycon simply does not utilize the information".

earlycon parses iotype, mapbase and baud (from options).  However, it is
hard-coded to assume that the clock used to generate the UART bitclock is
always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
with a rate read from the .fixed_clk_rate param of the corresponding
apd_device_desc.

This patch attempts to add a way to inform earlycon about this clock.  As
noted above, the information is actually already in the kernel and used by
8250_dw - I would happy be to hear recommendations for wiring this data
into earlycon that doesn't require adding another command line arg.

I see that support was also added recently to earlycon to let it use ACPI
SPCR to choose a console and configure its parameters... but AFAICT, this
path also doesn't allow specifying the uart clock.

-Dan
