Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2202530-1521047559-2-15698236135398433818
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
    t=1521047559; b=banR2G2GJhVKtMyW23Hv0CCVwH18xZKu1zNI4CbVE7s87mv
    wRM93UJoFeXlGl2J6rUcgsxz6/4hYwCagIN/T/p74fD3Fr97SQzhojEIQxHwo2UQ
    mo9AmclqhjmvM37KiIm5e9YN4j0j4pwCZnmViOQJVP+DKBBRIuoqEmmo9tZN0zFi
    XbaiMy+37s4+XKd95/KSAXRKV0TWV7YaFVR1XtroyZGrCU3Zh0lh8jPpCVAaHt0G
    b0V9PKxf4+acoFowSNTED+YzNHp8bv40cGMd/xUn4hlgw9DWo8eAVPSRCKbYGulh
    NYNnbq5X2+8tqynxWMQISzWi8ml9QSMghlMlGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521047559; bh=zKnrjX9CJzIErrxbb7D/3PPOoJzwitWA5bJHWt
    A+BKE=; b=MHzj+w73pdlW/qGm8UDgu+PZPTbpLgjQuJegvPk8taz86Odupw5njZ
    GY3uTA0+w+rPWYsULITIV0a2B7Zqehibd6KifZSqFM5mIgfVTBsHdIK8E/TiHD51
    fU0JnPFKWd1MnRzn3dxXyWdZWLqib2052hNQyDmDHbNbaXAWDkWe4q4oPxz60oeh
    vhM6HjAgZ99/CBl+f8myXNP/wJSCMsSQ4+hyPudR1RrhKkuD+G576NmUW4Yl1fdU
    Slp2u4N3FaKEfo7p5AafWP7CzOnr8mVT5JIG8CfI6O8LqxCDzFtm8zUfcntoO/Mq
    GxEgNrTaM7cC6bhPzYKwfLV8/b9+1rIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=PePuyeeB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=nHlQmgQ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PBTh2xB9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=PePuyeeB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=nHlQmgQ8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PBTh2xB9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeCNRMg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 13:12:36 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33822 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751943AbeCNRMf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 13:12:35 -0400
X-Google-Smtp-Source: AG47ELtmnKkOrd1H6MVbHZcZygAElTpFMklOdO0YZm9m/qCgC+D15xH+xnmf/BpGkcxvzELacCdTpyqlBuRB1v+a9w8=
MIME-Version: 1.0
In-Reply-To: <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com> <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
From: Aaron Durbin <adurbin@chromium.org>
Date: Wed, 14 Mar 2018 11:12:33 -0600
X-Google-Sender-Auth: uufzqPrwf-gDgJphjXv-ya6zJMQ
Message-ID: <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Aaron Durbin <adurbin@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 10:38 AM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Mar 14, 2018 at 6:29 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
>> On Wed, Mar 14, 2018 at 4:54 AM Ricardo Ribalda Delgado <
>> ricardo.ribalda@gmail.com> wrote:
>>> On Wed, Mar 14, 2018 at 1:36 AM, Daniel Kurtz <djkurtz@chromium.org>
>> wrote:
>
>> In fact, the recommended way is to have firmware specify an ACPI SPCR table
>> with OEMID="AMDCZ " (see https://patchwork.kernel.org/patch/10281307/) to
>> configure proper access and address.
>
> Hmm... I was thinking it's already there. And thus, this is just a
> quirk for *existing* firmware that doesn't correctly configured
> hardware.
> (Yes, I'm aware about one nuance in SPCR specification I'm trying to
> address via official ways)
>
>>  With an SPCR table in place,  the
>> kernel command line just becomes "earlycon", with no parameters.
>
> SPCR *provides* an address of UART (required by specification).

What is "it's" in your first sentence? The access method? Baud rate
can't be configured ever in the kernel w/o knowing the input clock to
the uart block. That's already been brought up, and it is inherently a
requirement to know that to recalculate the divisor. These patches are
doing early OOB binding to set the proper input clock because: 1. SPCR
doesn't have that information 2. you nak'd the generic way of
specifying the input clock on the command line. Sadly, this situation
is not unique to this hardware. There is hardware all over that does
not meet the current assumptions being made in the early uart drivers
within the kernel.
