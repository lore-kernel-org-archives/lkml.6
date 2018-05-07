Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-600594-1525685238-2-2843723926084269441
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525685237; b=L4GH+eZD5yvVeq7MmO2C8HS6/eiHzYpLA2H7jopkOosQOSlI50
    F5zzLrvd367xOIUTpgBCa1iCrW25BQorisC41rLuFl+WnnSXiho8gz6DuFj3DMLz
    /N/sxWbyePYsUWjRgAU6YgqOCnOAcPypnE0BIsfaHB5bTbmRcgVpxunvGm3Z1PXn
    4MfMHuLRa3zgh39ZE31xemvsfXjpZOBFBT3FPpBPF3Jv6Sgv7w0xA+uDc3ShEf+w
    67I4Mhoyt2Oz3K4uYs3VZJlR9b/AqqNrNwRtRGwdicNtZl+lcfrzliJ73nZcoaIl
    dNRVW+WDLzjZtsA1yU30ywwZ4KEf8EpCO4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525685237; bh=L092N5jb7oB
    bpIy+Yo4OHkRIMAA6KCzdbbaG6oKtrHI=; b=l+Hr0lMxwt4eVUqiV640eg9K8hm
    fe6iGwr5hSIRvYm8jbMEWrLzGSdvBwnSSShM56tTU/ITW+20V6YoB/v1uJekoI9Q
    5IPf8fwAHjNISHx1mZfcOHg4941FOJE22K0CHbkwbFFF9O+huXCygkmfBxPEWr2o
    WUUJ1rzc+A1kOYj10T9fSAJ9kWm3Gx1YiYfxd/JNVS+imt8UnhrG3JbtRLSMLxmE
    w4XpGL4Wbsrtjd1G4dUW2dXGsE6rXpEerh8hiNLnOkTtTrAV3atXzhkIUogFk/Bo
    RYXCta7ruiSLDr4eWlzgNpTKLPD8ab82jWe6aOYqpUseDgw/RjTsF6527Lw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=KBwW0m+Q x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Amz+qqW1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=KBwW0m+Q x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Amz+qqW1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBsF+w4qXqn7okMlOjhGZYvY5NrcRkyxpYKzzCDJzbIHEyH0Bv6mRQZGfJi2PcYE4QgbrNvG5Q9ljOtLBfa14eIV+0oYrSvl1bgCaC9KiZeRAZwjnhj6
    uRW6f7k/wsYaN6Itqxk3peNd6V4GAaUmAnWHg8ET5DetRZK3P9Q/S38oG396XeF4iqxIuogmQ+lJbmXRb4ANyoQazhOCmxN1jx8pJDsnDbfMzUSCmF1GemT2
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PxClEm-sD9_7Xx331N8A:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEGJ1P (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 05:27:15 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37749 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeEGJ1O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 05:27:14 -0400
X-Google-Smtp-Source: AB8JxZpC629W89JB86rWNOJX/lWFyxrbw3q8KUbt54Q227VXi9ymNSP+jpcGMNKaK0JJOfBtwu1Ipw==
Date: Mon, 7 May 2018 11:27:10 +0200
From: Johan Hovold <johan@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] tty: implement led triggers
Message-ID: <20180507092710.GQ2285@localhost>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 10:41:27AM +0200, Uwe Kleine-König wrote:
> Hello Johan,
> 
> thanks for your feedback.
> 
> On Mon, May 07, 2018 at 10:02:52AM +0200, Johan Hovold wrote:
> > On Thu, May 03, 2018 at 10:19:52PM +0200, Uwe Kleine-König wrote:
> > > The rx trigger fires when data is pushed to the ldisc. This is a bit later
> > > than the actual receiving of data but has the nice benefit that it
> > > doesn't need adaption for each driver and isn't in the hot path.
> > > 
> > > Similarily the tx trigger fires when data taken from the ldisc.
> > 
> > You meant copied from user space, or written to the ldisc, here.
> 
> ack.
> 
> > Note that the rx-path is shared with serdev, but the write path is not.
> > So with this series, serdev devices would only trigger the rx-led.
> 
> Where would be the right place to put the tx trigger to catch serdev,
> too?

I haven't given this much thought, but do we really want this for serdev
at all? I'm thinking whatever driver or subsystem is using serdev should
have their own triggers (e.g. bluetooth or net).

So it might be better to move the rx-blinking to the default tty-port
client receive_buf callback instead (i.e.
tty_port_default_receive_buf()).

And then the resource allocations would need to go after the serdev
registration in tty_port_register_device_attr_serdev().

> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Changes since v1, sent with Message-Id: 
> > > 20180503100448.1350-1-u.kleine-koenig@pengutronix.de:
> > > 
> > >  - implement tx trigger;
> > >  - introduce Kconfig symbol for conditional compilation;
> > >  - set trigger to NULL if allocating the name failed to not free random
> > >    pointers in case the port struct wasn't zeroed;
> > >  - use if/else instead of goto
> > 
> > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> > >  		struct tty_buffer *head = buf->head;
> > >  		struct tty_buffer *next;
> > >  		int count;
> > > +		unsigned long delay = 50 /* ms */;
> > 
> > Comment after the semicolon?
> 
> Given that this comment is about the 50 and not the delay member, I
> prefer it before the ;.

Hmm. I personally find it hard to read and can only find about 30
instances of this comment style (for assignments) in the kernel. And
arguably the comment applies equally well to the delay variable in this
case too.

> > Besides the ugly ifdefs here, you're leaking the above LED resources in
> > the error paths below (e.g. on probe deferrals).

> ack, the ifdevs are ugly. I'm working on an idea to get rid of them.

Sounds good.

Thanks,
Johan
