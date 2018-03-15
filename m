Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3060114-1521076111-2-13240386961380089899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
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
    t=1521076110; b=dslekEelT5QptzPrtl4cnHV3ZyCqrRfEzB2MYQty0QrBA9F
    2kmCIIcCSHwgPnQYLSQVFOVpcIHHTVmhTdlkRfsu5wj+ZOkpMx1Gs7RX/uAvY4he
    qNUfHvgE2J73ddz1KfhXxYGGPWHrVi20VPy2y3CTh3o3isjjNlQIXqBLa4XrUQDt
    jeMnm7QS74lIkb9rLuHK84MLOXWknJBPq0YABACvn6sUE2vuzDffVZ7U5ELs2l3y
    QmauLZdOMzc0OtwhA7cXD8Lnf+ThZfFNOzEwB4UDSBJmQhhmsbOcx/W02T1hr70K
    Wh8NrZEOf0gBPDAqO3bRATn09uEO+PYapGc7XyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521076110; bh=gJGKu3GFJLu8OgMvi5KyHglbuDlp9miSQbvrxb
    +pz6s=; b=dmx7QUyaFRg3vdYevHkrZU/WRrVE63dySFjBYGlFBy8I7dvrLHaK5M
    2y0uBNqmqS64dyuv4jerese9bhDAIl9jFtiFcI+Oa6paPXm57CGVeePmfooZTvK4
    o63kS4i/ECTkKfDVsC220zmIwWb6ylKI0UVXgwNhAEMBKEmGJAlWQWJQk0wV0idL
    YmppswXq71b92OHjZSJpMsn/wD3kTLQpgm/2Gii1MSgvaC3ZvkVNGQMghQgfoaPW
    2u2kMiugXp00s86bJUhO5RcJm0MKKaEYDEdl/QV4cDMO7C1uKT1L0aLaHS6kvGqX
    oSZN2bVOhE77oUGyTV1xihRpCPxxoXTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Wz49jV+7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rTDpiAEA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Wz49jV+7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rTDpiAEA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751917AbeCOBI1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 21:08:27 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:36956 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbeCOBIM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 21:08:12 -0400
X-Google-Smtp-Source: AG47ELvAqNPyvt70m09kfWvi7f9UoFkt5R9MGsDswYo8d7aGA8j1wvFsHY9L/HxfKEcO5JgPYrOft7/hGzSePMsmwew=
MIME-Version: 1.0
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-4-djkurtz@chromium.org>
 <CAGXu5jK4QdG83FGAx94GAmU=tpuhN1dypTh5n_Pes8n7shEZuw@mail.gmail.com>
 <CAGXu5jJXNK3h5P-YzRJ3hxBer305ik4FHuhcixzprnRnefU7Qw@mail.gmail.com>
 <CAGS+omCkKT9WHApnG+i+2Sn0zihBFV1ufuQn5+jfE3asuoTAEQ@mail.gmail.com> <CAGXu5j+cOZXCTx3SZT2u5rVv4zDpEhX6hjdp+4DUtN=kE+Q-PQ@mail.gmail.com>
In-Reply-To: <CAGXu5j+cOZXCTx3SZT2u5rVv4zDpEhX6hjdp+4DUtN=kE+Q-PQ@mail.gmail.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 15 Mar 2018 01:08:00 +0000
Message-ID: <CAGS+omA8DFCy9eubH2X80nyajH-UqMyTsO5G6JkZNnpf_6g09Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: core: Allow skipping old serial port initialization
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adurbin@chromium.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jslaby@suse.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        mbrugger@suse.com, dhowells@redhat.com, vigneshr@ti.com,
        sean@mess.org, Jeffy <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>, matt.redfearn@mips.com,
        marc_gonzalez@sigmadesigns.com, linux-acpi@vger.kernel.org,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 6:55 PM Kees Cook <keescook@chromium.org> wrote:

> On Wed, Mar 14, 2018 at 5:23 PM, Daniel Kurtz <djkurtz@chromium.org>
wrote:
> > On Wed, Mar 14, 2018 at 5:00 PM Kees Cook <keescook@chromium.org> wrote:
> >
> >> On Wed, Mar 14, 2018 at 3:58 PM, Kees Cook <keescook@chromium.org>
wrote:
> >> > On Wed, Mar 14, 2018 at 2:44 PM, Daniel Kurtz <djkurtz@chromium.org>
> > wrote:
> >> > Sorry for being dense. What tree is this against? I can't find
mention
> >> > of amdcz in Linus's tree nor linux-next.
> >
> >> As I watched this email send, I noticed the "3/3" in the Subject. ;) I
> >> see the amdcz support now. :P
> >> https://patchwork.kernel.org/project/LKML/list/?submitter=18441
> >
> >> >> diff --git a/include/linux/serial_8250.h
b/include/linux/serial_8250.h
> >> >> index a27ef5f56431..02570edaddd8 100644
> >> >> --- a/include/linux/serial_8250.h
> >> >> +++ b/include/linux/serial_8250.h
> >> >> @@ -136,6 +136,12 @@ struct uart_8250_port {
> >> >>         struct uart_8250_em485 *em485;
> >> >>  };
> >> >>
> >> >> +#ifdef CONFIG_SERIAL_8250
> >> >> +extern bool serial8250_skip_old_ports;
> >> >> +#else
> >> >> +static const bool serial8250_skip_old_ports;
> >> >> +#endif
> >> >
> >> > Where does serial8250_skip_old_ports get used where
CONFIG_SERIAL_8250
> >> > isn't defined? (i.e. why is the #ifdef needed here?)
> >
> >> This question still stands, though.
> >
> >  From the same patch: https://patchwork.kernel.org/patch/10283641/
> >
> > if (CONFIG_ACPI_SPCR_TABLE && !CONFIG_SERIAL_8250)
> >
> > in other words, if serial ports are disabled, but we still want to parse
> > the APCI_SPCR_TABLE, which "defaults y if X86".
> > Perhaps that logic should be changed (no need to parse ACPI SPCR table
if
> > we are going to disable serial anyway)?

> But won't this break? "static const bool ..." but the code tries to
> set a value but I'd expect the compiler to still yet about it?

er... yeah.


> I think you could drop the .h #ifdef and use:

> if (IS_ENABLED(CONFIG_SERIAL_825) && amdcz_present(...)) {

oooohhh... nice.  I like it, will change.



> -Kees

> --
> Kees Cook
> Pixel Security
