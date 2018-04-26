Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3023861-1524769959-2-11782058832744157413
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-1', cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524769958; b=FGoTV9TGAC+/l6nUpQWq9Be3J0YYh0XIjwumQoV1nsHTkNaaEe
    EjQxgm8j553SKZEoXoGEXmERW+nrnoKjVWm5U/2cd0IKQOwfxPReHFzd0UxOWM2V
    HGd0PAicsABgm/DVIcIPIvunzNqclU08NhTHO6gCHiVTzVzUi0xB8jt1LpsB6z8J
    5I47f6JG6tA5BDBY0vwiWLFz2W5piLU/PDVpTG9A6KwxYAO3HrNRb7r8A6qBzKdi
    5fecv/vmikJI7b+8GqPpepX7es3dl+2k6kibvc+RMgC9EpXMqzx78AC2/9eXwOkX
    uCYBCWBpmLonlSxPgjERM6X5jBe+LzrYizPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524769958;
    bh=KRGkDhre8xSPtX78yxDStnAj0ZsTf8x4HSsddJ5jRrc=; b=S5hXHBVojEE8
    RwM8Nd4uxXSJTa3/CYZX4eJLh5vP6KSL+uInYoN6OfKcpxpqcyY3z/+Z+Uhc26j8
    E9r9QKlew/5/kgaBlEV2nvznAd5ZJQ6R5quXWPU2wWQy0mksratAXy/OjdGNaPIa
    R8AcGyEX6RMJsQzARvb7G0lDIw/rOfpXeiGQBT5dJFsgcFNaDu8OVXscrufi6sRO
    Mgd+I9fQD/HDavsHCZ/6Plhc5u5QYleppDBcGnRvC0C96w/vdZWwC1amHlOU5exp
    SXKbPSHH9RpFuGD5KHbXMkmAuxG20DdEv5VGhjCJDKMdOoB7bK/1xJP2cOfbbsNs
    oifwCNDhOg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDKF935u41O3IvMr4ANU1mMPhgoLxO/JjFEi+LG5g2nXBXqYtUiXDMEx8yvRkqws8+bM3OvjLR0FHHc4CEg46pLFmoyv0bW+6ltYuwkt7HHPaiikbwYM
    45btut69UsCMoCyu8wHEgHT7Fd6kAe6yoGOGSa+w+TC/JdyeUJPImhNEn/9XfErgkRcelmc0L/04H+f75BGGotg518zCfgfysq9YfEsR2cItE8fobzuKNXe9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=FXlSwSmEOOAvhsM-sakA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDZTMh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 15:12:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751262AbeDZTMg (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 26 Apr 2018 15:12:36 -0400
Message-ID: <5fb0b88573985caeb5ce2732ae217f60fbcfe965.camel@redhat.com>
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
From: Dan Williams <dcbw@redhat.com>
To: Johan Hovold <johan@kernel.org>, Lars Melin <larsm17@gmail.com>
Cc: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        SZ Lin =?UTF-8?Q?=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>, stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 26 Apr 2018 14:12:32 -0500
In-Reply-To: <20180426162921.GB335@localhost>
References: <20180426062831.320-1-sz.lin@moxa.com>
         <20180426070927.GT4615@localhost>
         <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
         <20180426081403.GA335@localhost> <87r2n25i6i.fsf@miraculix.mork.no>
         <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
         <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
         <20180426161228.GW4615@localhost>
         <09866ede-25cf-3ca1-1be6-e720b4b5dd23@gmail.com>
         <20180426162921.GB335@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-04-26 at 18:29 +0200, Johan Hovold wrote:
> On Thu, Apr 26, 2018 at 11:22:25PM +0700, Lars Melin wrote:
> > On 4/26/2018 23:12, Johan Hovold wrote:
> > > On Thu, Apr 26, 2018 at 06:40:46PM +0700, Lars Melin wrote:
> > > > On 4/26/2018 18:39, Lars Melin wrote:
> > > > > On 4/26/2018 18:19, Bjørn Mork wrote:
> > > > > > Anyway, Qualcomm based designs are definitely handled by
> > > > > > both drivers.
> > > > > > Using qcserial only makes sense if the interface layout
> > > > > > matches one of
> > > > > > the defined shared schemes, which currently are:
> > > > > > 
> > > > > >      QCSERIAL_G2K = 0,    /* Gobi 2000 */
> > > > > >      QCSERIAL_G1K = 1,    /* Gobi 1000 */
> > > > > >      QCSERIAL_SWI = 2,    /* Sierra Wireless */
> > > > > >      QCSERIAL_HWI = 3,    /* Huawei */
> > > > > 
> > > > > It seems to me that this Quectel device matches the interface
> > > > > layout for
> > > > > Gobi1K:
> > > Yeah, but qcserial appears to select a different altsetting for
> > > the DM
> > > port for Gobi 1000, an altsetting which this particular device
> > > does not
> > > have.
> > > 
> > > I didn't re-read the full thread I referred to earlier, but I
> > > think in
> > > it, Dan mentioned Gobi 1000 device requiring firmware to be
> > > loaded too.
> > > 
> > > So if it's not a G1K device, we probably shouldn't be using
> > > qcserial
> > > even if the interface layout happens to match.
> > Good point, I forgot about the required firmware loading for
> > Gobi1K.
> > So this device should be handled by the option driver.
> 
> Yeah, we probably should document all of this at some point. :)
> 
> I didn't include the patch in this weeks -rc updates, but I've queued
> it
> up for the next batch.

Option is likely the right driver for this device.

qcaux was mainly for mobile phones that have a TTY (often cdc-acm) as
the modem port and a secondary DIAG/DM port driven by qcaux.  The DM
port doesn't have an interrupt endpoint thus it's not a normal modem
port requiring the larger buffers of option and its control signaling.

qcserial (as Bjorn mentioned) is only for actual Gobi-type devices with
the specific layouts and the firmware loading requirement where the 1K
and 2K devices start in a special 1-port mode waiting for firmware and
then become 4-port devices on firmware reboot.

Dan
