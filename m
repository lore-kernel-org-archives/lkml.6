Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2790900-1524760182-2-158399465429002990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', cc='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524760181; b=G3tgjYc+D+QL9HgpNPJL+6WPXhZSZe1eriXzTyqtCeGcNSEjM8
    EHAxHV1/efICbQmklrofEzJbTIeBBRxUCbK9qMEOeiDDBRu7+fgAzbt9Teth5SKR
    CchGRM3v6jWs1bBXoMKNe5mYBpktMKF8fhxfiG5VgkiLiB5LxRh0GavW7R3lMSqA
    e2DHXZaMX4hdJU2NVI3ONkwLzI7yssRND1xVkB5yXP+DFRR4QjUoD5VAFPtkyZi0
    IAauEIqhZ8iXxijf3PYVjVMif+5xfcylGOA0STA9UeksfdCAeXhw3doojlmhRD6u
    R4q0fM6y+FuWj+ZVWgJOulcynlchv3dSJXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524760181; bh=FVX1xAMMqiH
    9qwFzhtceu8Ls6PZCO/6uGWCP0KeRFQQ=; b=FX+bgFPIYcncb2J16VwJV/NVphc
    sj8MQ2n8UPWK1jm0+X5ewi2EFw8oxbX7PcY+1YbZ5tvnlJ57SYiDH+Eaymfrgo1J
    Xhc9McOITlOomzegjsoP6MApiTABzocUoPojQmTjeajPPefGHC3Hvc7qJSLp5iy1
    8Lm1CnV9NqqB2OfjkbAvset7KfG5GuwudkEX8PQ+N+sFoEU/78ljGeWrOg6hNY1I
    fagPmh3GhSkgGQGEneKoFhACtt9uQsQJBi/3WthlDB5Zw3v4i3zpp8RHzYTZ6/EN
    h1WZmSunsKo7VtNHZxCd850t1fJl9g+oFF68LXoQ6mAdn/q1y0tFLCCE8BA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E+LekiYi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QQp5BJFa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=E+LekiYi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QQp5BJFa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEwLcfVi7ecZqrhz70uMlNqFGwTyEcVaO7EAi80l8oNCW5ljJXduZXijru/+BY7m1cqi0C274VXdpjMg90C/cSjX8YhKRaj4I1IJLrOuDFSwiWkJuzVZ
    aF/o/NI5nAO+Luo572FmGN6fOhfz8A5zAbk9qeO7IzoLS7G4Y7KxCQzeZubxKkio8PkY/OFtLuLhVabvcrn7KFg5+VbNxu49/4KdZbZRUUG8Hn/UwoFA4P7E
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=pwOLkft8kJkGR7X-bIkA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755659AbeDZQ3j (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 12:29:39 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33719 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeDZQ3j (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 12:29:39 -0400
X-Google-Smtp-Source: AB8JxZrkJrPUF3VqeZYRAN+L+4bb0mRyNBIGQwJRImmM6NJkJrpTJDdQMM1yG9bIsRVRBSG60FIAvQ==
Date: Thu, 26 Apr 2018 18:29:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Lars Melin <larsm17@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        SZ Lin =?utf-8?B?KOael+S4iuaZuik=?= <sz.lin@moxa.com>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Williams <dcbw@redhat.com>
Subject: Re: [PATCH] USB: serial: option: adding support for ublox R410M
Message-ID: <20180426162921.GB335@localhost>
References: <20180426062831.320-1-sz.lin@moxa.com>
 <20180426070927.GT4615@localhost>
 <72c63853-aa2d-e74c-1112-36d54ef52a85@gmail.com>
 <20180426081403.GA335@localhost>
 <87r2n25i6i.fsf@miraculix.mork.no>
 <3895ed90-bbb9-e7ce-34c0-a1654646cf83@gmail.com>
 <98b50ae7-b889-6811-476e-9cdc8a62a484@gmail.com>
 <20180426161228.GW4615@localhost>
 <09866ede-25cf-3ca1-1be6-e720b4b5dd23@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09866ede-25cf-3ca1-1be6-e720b4b5dd23@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 11:22:25PM +0700, Lars Melin wrote:
> On 4/26/2018 23:12, Johan Hovold wrote:
> > On Thu, Apr 26, 2018 at 06:40:46PM +0700, Lars Melin wrote:
> >> On 4/26/2018 18:39, Lars Melin wrote:
> >>> On 4/26/2018 18:19, Bjørn Mork wrote:
> >>>> Anyway, Qualcomm based designs are definitely handled by both drivers.
> >>>> Using qcserial only makes sense if the interface layout matches one of
> >>>> the defined shared schemes, which currently are:
> >>>>
> >>>>      QCSERIAL_G2K = 0,    /* Gobi 2000 */
> >>>>      QCSERIAL_G1K = 1,    /* Gobi 1000 */
> >>>>      QCSERIAL_SWI = 2,    /* Sierra Wireless */
> >>>>      QCSERIAL_HWI = 3,    /* Huawei */
> >>>
> >>> It seems to me that this Quectel device matches the interface layout for
> >>> Gobi1K:

> > Yeah, but qcserial appears to select a different altsetting for the DM
> > port for Gobi 1000, an altsetting which this particular device does not
> > have.
> > 
> > I didn't re-read the full thread I referred to earlier, but I think in
> > it, Dan mentioned Gobi 1000 device requiring firmware to be loaded too.
> > 
> > So if it's not a G1K device, we probably shouldn't be using qcserial
> > even if the interface layout happens to match.

> Good point, I forgot about the required firmware loading for Gobi1K.
> So this device should be handled by the option driver.

Yeah, we probably should document all of this at some point. :)

I didn't include the patch in this weeks -rc updates, but I've queued it
up for the next batch.

Thanks everyone.

Johan
