Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2352240-1526376093-2-13316439444661160715
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526376093; b=nWfdyK3z/QqqswdWt9/pQhMAUx5I6uj3ZD5fG2J8uO/NNOlQVi
    kPMGU6cMkJCXg+rImIc0cvNqCQF0TFzZZJhFG112gQQIgMheALb0OlPhCW4a4qac
    EKTgFSVjTzpZhapQe0KzHKWAsXPTEUHp+DlQiLhUjpB/W8lh9lExPw+Yx8YkKBW+
    Y2X6JfSZM+UqbceNEgIJ7+pTk43ENC7NLd/bbm4FjXf28Yxl9xdWj/g2wkotz/DA
    hSRK9Qu4r3Z6yGUhhWom9Y33SF+FmGUxqF03lrw7SATTXkmSxQshRgewiSYHNf5I
    i45/7rpNjw5QkTPaB3t7jyZg5NMzNsguK4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526376093;
    bh=TF3MPMFniIVkwigEj+/WGah/UvzzR6qciXf1+wka0to=; b=DImdEzOjSgbY
    +wVqKr/cMzPr+fLFBqBIzDWFfMSWS+Q+L7LW+wciIoTwa7IhKgbrMTmx+V8ZADJD
    tINel5l43t1Uspqpu9T/VewJqimCUVHYMDPhqEEkrLb1k5KZ4nhl59LqVMc/RZlX
    +QX3V3kTpNXtD9Tf9fstDg1jtslkRoTO52wasYhpRwtmkX8CkyCrMBD3+DTQcVhM
    FViagNy59E/QyqnWDVvs5MSnZA+55ZZ75QW/1aIGvsz08DTaeE3kVb3EfNegfIGI
    ymgns3ixS2MRWcKg9ZuzfFiki48mjuEIgq9+6MkM6MSWKEsLbB1rn0f5OJ1v59n9
    BH/aiXsvdQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL9XqhOlBYfCkWaFYUL3n/0rVaCMbQZhlDoz/RObAjerniz4+Erh2/BqfsM1BehFHkulJv0cLR084zfS9ceSeWKXhuI2///qe8UFwA1CTmmDNP3GHbNl
    Fk8z5HUC+0pR6SjOXrG2iq7Gq0GiSIuQOTzSDP9iSqLiA304ZYNH2m1AlbUZO9FX4cb6PyrKDLY9fBGWLIHMcA9ECJRJAeff1g65yi86gBayqJjv3totUjr0
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=Cv1HJbGTawSLZoveSIoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeEOJVO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 05:21:14 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:63196 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeEOJVN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 May 2018 05:21:13 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="14192677"
Message-ID: <c23cdde58b9f724f51787c6c38478df983be6efa.camel@microchip.com>
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
From: Radu Pirea <radu.pirea@microchip.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>
Date: Tue, 15 May 2018 12:22:24 +0300
In-Reply-To: <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
         <20180511103822.31698-6-radu.pirea@microchip.com>
         <CAHp75Ve3Ugnjjm8EZkPQTZSvH1qad1e5SqjOn8zz5syHSQea_g@mail.gmail.com>
         <5a3930b867cf8c279953d08c5d5dd1d93113a43b.camel@microchip.com>
         <CAHp75VdRrL25Jgnbk64Qqc5RY3uJdcntJ3xwRdp3F+rRFeTHBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-14 at 20:38 +0300, Andy Shevchenko wrote:
> First of all, do not remove mailing lists from Cc and people if you
> are not sure they do not need your stuff.
> 
Sorry. My mistake. 
> On Mon, May 14, 2018 at 11:11 AM, Radu Pirea
> <radu.pirea@microchip.com> wrote:
> > On Sun, 2018-05-13 at 16:33 +0300, Andy Shevchenko wrote:
> > > On Fri, May 11, 2018 at 1:38 PM, Radu Pirea <radu.pirea@microchip
> > > .com
> > > > wrote:
> > > > +static void at91_usart_spi_cleanup(struct spi_device *spi)
> > > > +{
> > > > +       struct at91_usart_spi_device *ausd = spi-
> > > > >controller_state;
> > > > +
> > > > +       if (!ausd)
> > > > +               return;
> > > 
> > > Is it even possible?
> > 
> > Theoretically yes.
> 
> I would like to know real circumstances when it might happen.
That check was used in debug stage of driver. I will remove.
> 
> > > 
> > > Anyway the code below will work fine even if it's the case.
> > > 
> > > > +
> > > > +       spi->controller_state = NULL;
> > > > +       kfree(ausd);
> > > > +}
> > > The question is, why you didn't utilize what SPI core provides
> > > you?
> > 
> > I tried, but it did not work the way I expected.
> 
> So, what is not going as expected in "SPI core takes care of CSs"
> case?
> Did you use oscilloscope for that?
Yes, I used and CSs was not asserted. Anyway, I will will try again.
> 
