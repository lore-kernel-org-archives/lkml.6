Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-880504-1522330465-2-17296465881540429839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522330464; b=MrGQXAZi0uHlszQALGNWjI+EFxq2adnwgeZvYAkkhFiCB+cSix
    o2R3kbaLW490qcospJhNoTvkhkmwj7h02ns9DMU63FguqiHsaKYbfTHDrA7gwnGc
    h+7RUfN/XP0OAJ+3JnG5cZoG0EHjLJ1jVkVJt8z2369pLzkN8FaDyrCUJeQQv1bH
    8MHwzM9WHFIgpGNlhm5gg84C4opoyOxw4QINhGQFt8LcdjGVzZnhxZNo3w2A8l6Q
    Bt6hNKkFxJALL8EMgTM4Xir51nA+h9PO/Lo4Y4AaUZN3htMavs3th/T7zQAKCIgv
    pQsi/AzBE6TDQznXF+3F0NAsF8iYaaH+Ltbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522330464;
    bh=SxhAd7M5xxliQ3aM2HZQAHgje65IyfSIiHERJJOuc6k=; b=PfltpLmVRdTi
    E0AaDtJ+id2eAjPWD5xzomwcXy5d5Fp42Czi+U+0K2oGXLJQibhs0H4NMOM9+oja
    2pNFFu29R/KSKKQfAkHwDdCSSQk8uXE3EWUNvX/ZSgatuQzxeacN8KRWiA7CrL7B
    MtjPlEFq6DpcZ/bIWCtgK5TKpmheKfs4SB9Ze/0h4wM56pOhOXoaB1p54UAcvrZC
    O5hpVXPboCBfc2GMrnqtafgUfa6daQbTdbTGX8KwpnpgXOlI4sUU1kC9gYEs9bYr
    NF66N2zxIV4gpgLV/scMd8pPkKmar8xuVc4lUKrcvPqz6M/ZUrA98h9A90AaIgVa
    4kZFnyVRCQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCh0Yu4qxtJglLuOI1SNul7zKYS5v+t79Y3VGJjTG39tH2PwrTdKUFuzWcHrDg5ephkcbljbg2upfAksyllywt8/yA3Ds2dYig0cgGsuqCs9/VyCu++s
    TYvDgLg1GatQ/olSiOpE2E9si9ZT4o3ZCfwzHgJRbL89ESky9uvr5QVxls6GMAaBiYnm5X2SESZYH8wVa49A2sqxKdg9Uf1UpH44AkewVzX5GYcEO54zOTpR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=cm27Pg_UAAAA:8 a=z1H5ADGQAAAA:8 a=VwQbUJbxAAAA:8 a=7bFJA7tuOba37-jmEPIA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=cNhwqobjEIRUxE0uuXBi:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeC2NeW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 09:34:22 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:53876 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752246AbeC2NeW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Mar 2018 09:34:22 -0400
Date: Thu, 29 Mar 2018 14:34:00 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Aaron Durbin <adurbin@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Message-ID: <20180329143400.6d9256a5@alans-desktop>
In-Reply-To: <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org>
        <20180314003655.12141-2-djkurtz@chromium.org>
        <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
        <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
        <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
        <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
        <20180326192428.71c23abf@alans-desktop>
        <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Mar 2018 20:56:45 -0600
Aaron Durbin <adurbin@chromium.org> wrote:

> On Mon, Mar 26, 2018 at 12:24 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> >> Sadly, this situation
> >> is not unique to this hardware. There is hardware all over that does
> >> not meet the current assumptions being made in the early uart drivers
> >> within the kernel.  
> >
> > Is there any fundamental reason you can't just embed dt entries in the
> > ACPI table to describe the other features you need. I appreciate it
> > doesn't solve the generic PC case but it ought to help for anything where
> > the firmware cares about Linux ?  
> 
> What's the method for doing that? Using _DSD methods? Or have a
> pointer to examples? Sorry, I haven't spelunked into the current state
> of bridging ACPI and devicetree in a while.

ACPI 5.1 adds an _DSD method UUID for device properties.

The kernel device_property_* interface will pick them up just as if they
came from DT tables etc.

Alan
