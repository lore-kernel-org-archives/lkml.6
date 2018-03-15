Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2930480-1521073428-2-6117896651355329206
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
    t=1521073428; b=XNqkooYPoO8ipTmCVCgrJyymP1VXCqB4CW78Ptg2xlhhuQ8
    aGLmSVM8y6Z15Ld6uAtRn1dJUYG04sJtJs7z+2tvy6Xe/Vunhn30mJtxn+4nceWD
    TJC6wnLRfmRcIqjEaKrnbEeR9JtFcet1DEjbL9ZDKsoUVAkarlFZCOOFEVub4xAw
    2ZwqK0acAWiTomV1GeGzxUd7oeG/1JT/98CIjkCtwWbO33A3IddtHdnQfabsBIL4
    oC3Ods/oZ278kri/IIvRVfP8LXFfwBCapexdpBFV/Zu/gtnEMe2mCdMm4HCJWds4
    tLGew8aW7XuHaEtF3IcQpyIIR+vw9Omqa9+3TjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521073428; bh=MhNcfdkBcDOvOz5jkqnBsl03wG5K7P6kP/YH3+
    D+PBM=; b=DB/j9rYGSB0bk4qN/FUKf8OWUsk8/3sY/ECO+3sMuFv53AU44WcfCh
    hkXXZPV4IO2mdl+lLOX79ELQWqXFWfYE/lvummIH/1tu8q33qc/FwLXKF5BRS2Vw
    ru1HiRrqOUPn9A8Z0YCgowty61gBrnjC7RFBwiH5mBp8Q5eNjUSFfu4Nlv3O3ZcB
    zf7fj1XAtMXE+8hEmq9obn7mvYg7eoHo50sJvSmh1h3NtbYS/k6ug1JtZ9BSGfGP
    yMUWZC4Sm+KBMttKtpM6JV3m4sTMLOsxr53KO6NUKQdXc23f9YRoWEpKLvs27Jyq
    uBLxAPMWfVU/Iq3c4yrglsZCjcemOtjg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=XWSlbqdC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qfOito39;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=XWSlbqdC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=qfOito39;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeCOAXp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 20:23:45 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39136 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeCOAXo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 20:23:44 -0400
X-Google-Smtp-Source: AG47ELucTuDc8QEC9fY5cqN6p0o+56UOroSdegna7cEQ/ERYqoLoQXylMLR7AxcjzndSTaP+VgYBcyyiwPFHlKAMJtM=
MIME-Version: 1.0
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-4-djkurtz@chromium.org>
 <CAGXu5jK4QdG83FGAx94GAmU=tpuhN1dypTh5n_Pes8n7shEZuw@mail.gmail.com> <CAGXu5jJXNK3h5P-YzRJ3hxBer305ik4FHuhcixzprnRnefU7Qw@mail.gmail.com>
In-Reply-To: <CAGXu5jJXNK3h5P-YzRJ3hxBer305ik4FHuhcixzprnRnefU7Qw@mail.gmail.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 15 Mar 2018 00:23:31 +0000
Message-ID: <CAGS+omCkKT9WHApnG+i+2Sn0zihBFV1ufuQn5+jfE3asuoTAEQ@mail.gmail.com>
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

On Wed, Mar 14, 2018 at 5:00 PM Kees Cook <keescook@chromium.org> wrote:

> On Wed, Mar 14, 2018 at 3:58 PM, Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Mar 14, 2018 at 2:44 PM, Daniel Kurtz <djkurtz@chromium.org>
wrote:
> > Sorry for being dense. What tree is this against? I can't find mention
> > of amdcz in Linus's tree nor linux-next.

> As I watched this email send, I noticed the "3/3" in the Subject. ;) I
> see the amdcz support now. :P
> https://patchwork.kernel.org/project/LKML/list/?submitter=18441

> >> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> >> index a27ef5f56431..02570edaddd8 100644
> >> --- a/include/linux/serial_8250.h
> >> +++ b/include/linux/serial_8250.h
> >> @@ -136,6 +136,12 @@ struct uart_8250_port {
> >>         struct uart_8250_em485 *em485;
> >>  };
> >>
> >> +#ifdef CONFIG_SERIAL_8250
> >> +extern bool serial8250_skip_old_ports;
> >> +#else
> >> +static const bool serial8250_skip_old_ports;
> >> +#endif
> >
> > Where does serial8250_skip_old_ports get used where CONFIG_SERIAL_8250
> > isn't defined? (i.e. why is the #ifdef needed here?)

> This question still stands, though.

 From the same patch: https://patchwork.kernel.org/patch/10283641/

if (CONFIG_ACPI_SPCR_TABLE && !CONFIG_SERIAL_8250)

in other words, if serial ports are disabled, but we still want to parse
the APCI_SPCR_TABLE, which "defaults y if X86".
Perhaps that logic should be changed (no need to parse ACPI SPCR table if
we are going to disable serial anyway)?


> -Kees

> --
> Kees Cook
> Pixel Security
