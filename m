Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-368919-1525245743-2-3954447040413639659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', cc='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525245743; b=DSr3De3TVlykoW4ESDgVBwXBNW3ql0fsypYchccIgR9jraGBP+
    PUgWdtde5Eqx6q7TnYIE7KAp5uJWhj6AnyFtJw5HvPg+mCxcbLYIcJ7Zgxe+Kq+l
    qHyqyfDTXH4e91FMRL3glN+rrizVSheRUU0/0gg17DtiFsYKhOnflD9nZ4bl8GdB
    qYIGg0gt8klN3TmjZgvo3m/nNsOxxb6x/eZwezCjiF8M+CQjNypyfF921aQD/g9D
    YO7tl1m/Qei7CbAa1EeS+wXgsjlx7SUlykaLI3k1R25C1py2VbRYFZO19GXRYo46
    s/rZ4q+rpLNILlYQUXWe9xEke0V9LD4vZgzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525245743; bh=dIs18935EGk
    MrTfiP/e1a6bnN8YPspjb/HfWT5cLlUM=; b=Uz0+Z0xP7wiQ20hp6+M1JulMJ4B
    /B4Ow12IcyWpFTS1DZ0A+g5n+VBw3YfPQ5REPIlMMCcrakFXe/U9h8B654o3bMwa
    mKSc5FATXMaVK+f+cX2j2nRwwal2p1TZy9OWfQBSMkUWi5982pOPfHsSKiKwiVIj
    NrRqdtR/tOjX7ZzZYq8q0IYH837mULRyNWhULUFzjlnLadCH/Bo4hkpYiHqXsEAh
    YbSSblw7dYKYVX8h9Usy4KgVDiyznNlfWXFQFzmFdK6+uh7BWi5+WzgtcLzneisV
    nXSoiNzmy1Xn59MNxf64YJ/qnXEBSqzR0e5p2Rddcrvmak6cn/wP3eWdeeA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=D3pvANgu x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ran6c/Qk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=D3pvANgu x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ran6c/Qk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfISERfxJa5NXAsGeXyTPteZ3I5g8FGcqWmuVLKGkp4WZ8zK9nImut6pZIgOlryF8xcAjFx2lCXGA5byGdiWQeg1vcIT0G1A8NbkIEdf67lghR/lNgbtj
    53/YeWLblETKdZ29BODSTaQ7rqPEMxsYESZbAa1pKVeL+3E1LUt637svPdcB2tVXHGxpCPLUSfo296rpSBFdf/YnWcQwtZm1ZvNyc1IpZBZUoDB50kHt2lvx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=D4433MFfJ3aqb8AI6a8A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750925AbeEBHWU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 03:22:20 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:37246 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbeEBHWS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 May 2018 03:22:18 -0400
X-Google-Smtp-Source: AB8JxZqF8FDEQAyXo5LRmYtGLkVpf8Bj0D5Qa9eV3mB99+fYrLn4ujxylpRF4yUl4wcJU4BW4vwoQA==
Date: Wed, 2 May 2018 09:22:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Dan Williams <dcbw@redhat.com>
Cc: Johan Hovold <johan@kernel.org>, Lars Melin <larsm17@gmail.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
Message-ID: <20180502072216.GA2285@localhost>
References: <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
 <20180426081403.GA335@localhost>
 <87r2n25i6i.fsf@miraculix.mork.no>
 <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
 <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
 <20180426161228.GW4615@localhost>
 <09866ede-25cf-3ca1-1be6-e720b4b5dd23@gmail.com>
 <20180426162921.GB335@localhost>
 <5fb0b88573985caeb5ce2732ae217f60fbcfe965.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fb0b88573985caeb5ce2732ae217f60fbcfe965.camel@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 02:12:32PM -0500, Dan Williams wrote:
> On Thu, 2018-04-26 at 18:29 +0200, Johan Hovold wrote:
> > On Thu, Apr 26, 2018 at 11:22:25PM +0700, Lars Melin wrote:
> > > On 4/26/2018 23:12, Johan Hovold wrote:
> > > > On Thu, Apr 26, 2018 at 06:40:46PM +0700, Lars Melin wrote:
> > > > > On 4/26/2018 18:39, Lars Melin wrote:
> > > > > > On 4/26/2018 18:19, Bjørn Mork wrote:
> > > > > > > Anyway, Qualcomm based designs are definitely handled by
> > > > > > > both drivers.  Using qcserial only makes sense if the
> > > > > > > interface layout matches one of the defined shared
> > > > > > > schemes, which currently are:
> > > > > > > 
> > > > > > >      QCSERIAL_G2K = 0,    /* Gobi 2000 */
> > > > > > >      QCSERIAL_G1K = 1,    /* Gobi 1000 */
> > > > > > >      QCSERIAL_SWI = 2,    /* Sierra Wireless */
> > > > > > >      QCSERIAL_HWI = 3,    /* Huawei */
> > > > > > 
> > > > > > It seems to me that this Quectel device matches the
> > > > > > interface layout for Gobi1K:
> > > >
> > > > Yeah, but qcserial appears to select a different altsetting for
> > > > the DM port for Gobi 1000, an altsetting which this particular
> > > > device does not have.
> > > > 
> > > > I didn't re-read the full thread I referred to earlier, but I
> > > > think in it, Dan mentioned Gobi 1000 device requiring firmware
> > > > to be loaded too.
> > > > 
> > > > So if it's not a G1K device, we probably shouldn't be using
> > > > qcserial even if the interface layout happens to match.
> > >
> > > Good point, I forgot about the required firmware loading for
> > > Gobi1K.
> > > So this device should be handled by the option driver.
> > 
> > Yeah, we probably should document all of this at some point. :)
> > 
> > I didn't include the patch in this weeks -rc updates, but I've
> > queued it up for the next batch.
> 
> Option is likely the right driver for this device.
> 
> qcaux was mainly for mobile phones that have a TTY (often cdc-acm) as
> the modem port and a secondary DIAG/DM port driven by qcaux.  The DM
> port doesn't have an interrupt endpoint thus it's not a normal modem
> port requiring the larger buffers of option and its control signaling.
> 
> qcserial (as Bjorn mentioned) is only for actual Gobi-type devices with
> the specific layouts and the firmware loading requirement where the 1K
> and 2K devices start in a special 1-port mode waiting for firmware and
> then become 4-port devices on firmware reboot.

Thanks for that summary. I've applied SZ's patch now.

Johan
