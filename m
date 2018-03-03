Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-727864-1520104347-2-2191245321462054582
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
    t=1520104346; b=KK3KijKslwKzbi9Cnwcwa8g6g0MA2p1+JqmEQl/v67olCp7
    +T03dfi49fea3CPw49pyCmbVzlLO/gyoYfq+8/Jqspvb95D0J3XZlfLBdn+Lh6uv
    qVdrGHkxKIiAgcwlh4hMtIgbs79gY8om7uByQdy54QEut+BjIlYYWaIPkyAVnX45
    ptW0C9ZcuNX/wey+lipGpCxVOl2RJuJ3W8hvL47k+k00K8TdcNd4gGt00zz6InmS
    p/FIFOz8RehVDhhvQbu1GEMSWB1RvSqCsI0zMUf+njmi3q/jF8ETpjV1WO9D2Sg+
    FBadyLLJJw0R1wMLdVl6tcI7+v6FbvH7rhEZGHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520104346; bh=zD2on6S51D7sa0dU5i1w70CnBjqvtn/Lgu4k7l
    b8WhA=; b=u7r+Yocpa4RhoRsHf1rzDguxYF9xs8QhiDI38ApB2pR0SBZtVVpXp5
    PYMKtxItjWtB95VqH25/Uh1jKVC6rRii/CFQGjZYzvgxmKFKvTciw0uUSuHj6JGp
    0ykY5T0DNEE54SxdTgeXbQ+pmfNNsUTKUHoDXhTkJhlJpTlROb8agOJVpdzQSep0
    aT/+5N070dXjEG69d6ckwVj81RGbm15lVkQdTY8ylWc7n/nsRl2UyK3tMyppWSuw
    7iheGACHf3PeZnRlm5Pkl9Pi7gPFTZRqfAbx+dm01j8TS4DAqMjfHrMtVbetGb46
    3H0hw97N+QMg2qnz73CCr17Q0AVg6CdA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=XShZJ/ts x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=T2t3z+Bd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tKlsHee1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=XShZJ/ts x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=T2t3z+Bd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tKlsHee1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeCCTMZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 14:12:25 -0500
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38119 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbeCCTMX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 3 Mar 2018 14:12:23 -0500
X-Google-Smtp-Source: AG47ELs4Q6F0zL+d/3JVK4ivpg5S0Pl7XWWM56J5CU6im4nOEm4lUwUUp37W0v9E8T/QLxoFHzLKebPKRIbfLmkrNPw=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcnuc48xb167hu5nz3iv9uSp2jRw+M-w=yBihex6RTXYQ@mail.gmail.com>
References: <20180301184335.248378-1-djkurtz@chromium.org> <CAHp75VfHuNHnjMqsvLZPSNeP57YX1CDZgf=EH-JNSh5bAVdUBA@mail.gmail.com>
 <CAGS+omCfVUPb0yq3XOEqO_zQ0_uppkKaGhqtB0OqXmQDK9xH1Q@mail.gmail.com>
 <CAHp75VfL82ujwBa1h0B8nEgBtFcBJPmS9ir7H5YWByDgxFGskA@mail.gmail.com>
 <CAE2855vbQyMwu8pmH-Sq1kA+=h5TJPWddTWPQoVdEqOn6sAyBw@mail.gmail.com> <CAHp75Vcnuc48xb167hu5nz3iv9uSp2jRw+M-w=yBihex6RTXYQ@mail.gmail.com>
From: Aaron Durbin <adurbin@chromium.org>
Date: Sat, 3 Mar 2018 12:12:21 -0700
X-Google-Sender-Auth: _r9b5AfMxxhb9TKp7BHG7gw0QJU
Message-ID: <CAE2855vimGkRscxZ4tOQ90NGECWe8x2Xg=OV0hgh=Ktf41SU=g@mail.gmail.com>
Subject: Re: [PATCH v2] earlycon: Allow specifying a uartclk in options
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Aaron Durbin <adurbin@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Tom Saeger <tom.saeger@oracle.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 3, 2018 at 8:38 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Mar 1, 2018 at 11:24 PM, Aaron Durbin <adurbin@chromium.org> wrote:
>> On Thu, Mar 1, 2018 at 1:02 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Mar 1, 2018 at 9:22 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>>> On Thu, Mar 1, 2018 at 11:47 AM Andy Shevchenko <andy.shevchenko@gmail.com>
>>>> wrote:
>>>
>>>> "earlycon simply does not utilize the information".
>>>>
>>>> earlycon parses iotype, mapbase and baud (from options).  However, it is
>>>> hard-coded to assume that the clock used to generate the UART bitclock is
>>>> always "BASE_BAUD * 16" (1843200).  While this may be true for many UARTs,
>>>> it isn't true for AMD's CZ/ST which has a 8250_dw and uses a fixed 48 MHz
>>>> clock.  The main 8250_dw driver uses devm_clk_get to get the "baudclk" and
>>>> uses its rate to initialize uartclk.  For AMD CZ/ST, this "baudclk" is
>>>> actually a set up in acpi_apd.c when there is an acpi match for "AMD0020",
>>>> with a rate read from the .fixed_clk_rate param of the corresponding
>>>> apd_device_desc.
>>>>
>>>> This patch attempts to add a way to inform earlycon about this clock.  As
>>>> noted above, the information is actually already in the kernel and used by
>>>> 8250_dw - I would happy be to hear recommendations for wiring this data
>>>> into earlycon that doesn't require adding another command line arg.
>>>
>>> And it should not require that for sure!
>>
>> But it does require that. There's an input clock to the uart ip block.
>> That is a design constraint by the hardware and is required to make
>> baud calculation work.
>
> I mean it should not be user's headache to provide this information to
> the system.
>
>> It's not a firmware problem.
>
> If it's ACPI, then it's definitely firmware issue, since SPCR provides
> a baudrate.
>

earlycon is another implemetnation of driver binding/settings that is
done before the rest of the kernel driver stack. SPCR provides
baudrate, but that's only one piece to the puzzle. You need to know
the UART input clock which you admit is hard coded in the current
driver. It's not possible to configure the divisor in the UART without
knowing the external clock. That's a real dependency that can't be
worked around. The moment the code attempts to configure the baud it
has to know the input clock -- otherwise the calculation is inherently
wrong. Or are you suggesting to lie about the baud such that the the
math works out even though the values are not real?

>> Its the driver's problem in that it
>> assumes an input clock to the uart block that does not reflect
>> reality.
>
> So, driver can't get this info from device tree or what?

There is no device tree on x86. And ACPI driver binding is not fully
initialized when earlycon is being processed. Yes, this can be solved
by getting up the entire ACPI stack, but then that's not really
'early' in the kernel's initialization sequence.

>
>>> Okay, configures a necessary IPs to feed UART with expected 1.8432M clock.
>>
>> That's only possible if there is a clock divider on the front end of
>> the uart block. For this hardware that's not the case. I actually did
>> this very thing on intel chromebook devices, but it was only possible
>> because there was a hardware divider that could be tuned to reach the
>> assumed clock that the code currently assumes.
>
> OK.
>
> --
> With Best Regards,
> Andy Shevchenko
