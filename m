Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3060114-1521075333-2-2923047042147821812
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
    t=1521075332; b=gSU38w24XhAazMq7d0rw3E5yQhy3ckfjU0o54twDzTzk8zI
    xUxDJnKkVvv7z1A+rmSirNhcs3dRCENcBDz7bHrinP6zI0WUPvhWgOhVwAQl/t/9
    RsimxORiOF2iX3LJG6ep2iyySiv0sWWI1bFQ8v2OKzcXGvRMaSZR0AOJUFfQsExp
    RfSzylgcPS57lyf7JwkCjx8fl6N6QJuqlaNxbBoqEJ6EAvbqOM8hyBEVQCTtiiXX
    bfXOBAfggWbKMV0x37ToOZsw5IOym+QGKRfOMp/TJydz1MfH5mGt69VXcIA0sJ5j
    DO1N0JbEYHHy6NqKItbvc8vY18KQICZtuXri3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521075332; bh=jfOr5UXuDvMB0xq1UmSt8AF94Ok2B7q1kjPlZr
    8UGQc=; b=GM2Vzd55P/OOf4mS4I67645D5d5mt+Qd57MXT66xZLcHIaS7CJUxb0
    LTBjowMZv/oDSqiymyZ4jj42Dwrh7SdIZ4QjfllR0LQlTqLGfK9nyzP4HhlijacB
    nksPpXX6T1HDhpk5xqgbQuB/KUnGSBLeAlmt8tDZ/PBlEQ0PeYu/rWuyS+CXrTqM
    XhViDY4tkE2/lOWqg5W/JoCILN4akQdeltqoIjF3hpi/oYrN5FHfw+uzx65v+gQN
    ZlOshmPqP1QFcPzOWQWMpZF/zsMWm0GiCdGZOCd2eubdjV5BwgYlrFa2wi8/YpsA
    wcnFPylnqkTQfv/GNxfza+aU2uMaoQBg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Q4YiCG9I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fsWazP/b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSST19xd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=Q4YiCG9I x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fsWazP/b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSST19xd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCOAzY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 20:55:24 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:33122 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbeCOAzV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 20:55:21 -0400
X-Google-Smtp-Source: AG47ELtM72JT4WhRB3DJOgalGDf36RvRHpRjZKEPpvJ3vZe3Vvlx0O1pwihBOp4LBvGupoM6MK9ZvA96Afr1ZW3tbjo=
MIME-Version: 1.0
In-Reply-To: <CAGS+omCkKT9WHApnG+i+2Sn0zihBFV1ufuQn5+jfE3asuoTAEQ@mail.gmail.com>
References: <20180314214439.27806-1-djkurtz@chromium.org> <20180314214439.27806-4-djkurtz@chromium.org>
 <CAGXu5jK4QdG83FGAx94GAmU=tpuhN1dypTh5n_Pes8n7shEZuw@mail.gmail.com>
 <CAGXu5jJXNK3h5P-YzRJ3hxBer305ik4FHuhcixzprnRnefU7Qw@mail.gmail.com> <CAGS+omCkKT9WHApnG+i+2Sn0zihBFV1ufuQn5+jfE3asuoTAEQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Mar 2018 17:55:19 -0700
X-Google-Sender-Auth: erC5BUhK6_AM_2fAwGhJn5ZTm8U
Message-ID: <CAGXu5j+cOZXCTx3SZT2u5rVv4zDpEhX6hjdp+4DUtN=kE+Q-PQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: core: Allow skipping old serial port initialization
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaron Durbin <adurbin@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <mbrugger@suse.com>,
        David Howells <dhowells@redhat.com>,
        Vignesh R <vigneshr@ti.com>, Sean Young <sean@mess.org>,
        Jeffy <jeffy.chen@rock-chips.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 5:23 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> On Wed, Mar 14, 2018 at 5:00 PM Kees Cook <keescook@chromium.org> wrote:
>
>> On Wed, Mar 14, 2018 at 3:58 PM, Kees Cook <keescook@chromium.org> wrote:
>> > On Wed, Mar 14, 2018 at 2:44 PM, Daniel Kurtz <djkurtz@chromium.org>
> wrote:
>> > Sorry for being dense. What tree is this against? I can't find mention
>> > of amdcz in Linus's tree nor linux-next.
>
>> As I watched this email send, I noticed the "3/3" in the Subject. ;) I
>> see the amdcz support now. :P
>> https://patchwork.kernel.org/project/LKML/list/?submitter=18441
>
>> >> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
>> >> index a27ef5f56431..02570edaddd8 100644
>> >> --- a/include/linux/serial_8250.h
>> >> +++ b/include/linux/serial_8250.h
>> >> @@ -136,6 +136,12 @@ struct uart_8250_port {
>> >>         struct uart_8250_em485 *em485;
>> >>  };
>> >>
>> >> +#ifdef CONFIG_SERIAL_8250
>> >> +extern bool serial8250_skip_old_ports;
>> >> +#else
>> >> +static const bool serial8250_skip_old_ports;
>> >> +#endif
>> >
>> > Where does serial8250_skip_old_ports get used where CONFIG_SERIAL_8250
>> > isn't defined? (i.e. why is the #ifdef needed here?)
>
>> This question still stands, though.
>
>  From the same patch: https://patchwork.kernel.org/patch/10283641/
>
> if (CONFIG_ACPI_SPCR_TABLE && !CONFIG_SERIAL_8250)
>
> in other words, if serial ports are disabled, but we still want to parse
> the APCI_SPCR_TABLE, which "defaults y if X86".
> Perhaps that logic should be changed (no need to parse ACPI SPCR table if
> we are going to disable serial anyway)?

But won't this break? "static const bool ..." but the code tries to
set a value but I'd expect the compiler to still yet about it?

I think you could drop the .h #ifdef and use:

if (IS_ENABLED(CONFIG_SERIAL_825) && amdcz_present(...)) {

-Kees

-- 
Kees Cook
Pixel Security
