Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AB8JxZqGXEW9PBu8lM4wY2qB20+uR9sEYB11fIgHxtp8I8cYnwMwaejWXTG9kbTwLehYUPFQg6bU
ARC-Seal: i=1; a=rsa-sha256; t=1524934878; cv=none;
        d=google.com; s=arc-20160816;
        b=WEC17intI8fJwSkEK6ZbjqLKqONEkNELIepLJoqCB44U1hK3ZYAXmimwtq3Oz2w8Lp
         9FhR4NOJ0X/4lB5r3e8SwLUw/t99wzomuXEXkl8mmCNBh1KhenMdFA+WHJ0/6Gw6eVso
         nmVw62mSecgxU+4gvk6dTzWQ4XNdy+ZmWT2EtUYrHtaVr4knuaHE7YIXHETDU9vEfy+J
         eFMifx8FYjCeRnunPBobeIDSsVmB1ZKDS3VPLBT5kg4PlmbPVtThbvADb9L6s+0SaS4A
         xgRr/zoW7zDDuTPHpYfJUbbVYPut8CaFYcGf6G/J2iGpqkPbkQZU7Hjw5e3TPCa9g/os
         gnkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=vjfiCPFFTj+tYvVwDUr/VeGWyYf8bMgmNwLfmcIoQno=;
        b=gzv+F25TQ1dLK1NvxzMuNVa47IDCfJ/R9vtxDYmi1aLRqzL91bXzsuGovmgA6XATZy
         mRMNhwMo29Y4zIiGEQYhwPo/laur/NOjyj00yRL8GBKiS996w4NkEfREKvKzEnIJi2zi
         VsD3Ubxb5c1Tn2tK5Py6tquCWABo2TTJYEQxUvsQ3EpOSsvZkTKkZxuKyQ8hbJx1/HeT
         O5ie1nSr5ouW/dTX50pCcO9gt4EdaUVfncaT09Dfj+uHPgSgCHLpzIuNybceT2Qh7mT2
         HOuVXSdf4xlgWeG7Zlsc2C/W0VijZNdcs54l0SqRnLztLJkGzKLflc9Z6TzULy1vXIHS
         EBxw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488EE2256D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 28 Apr 2018 18:01:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org, Hartmut
 Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Andrew Morton
 <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, "Andrew
 F . Davis" <afd@ti.com>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: afe: add binding for
 voltage-divider
Message-ID: <20180428180111.2bbaee8c@archlinux>
In-Reply-To: <20180427142917.zdtopxwy72snrv2q@rob-hp-laptop>
References: <20180423210809.29586-1-peda@axentia.se>
	<20180423210809.29586-3-peda@axentia.se>
	<20180427142917.zdtopxwy72snrv2q@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598572688738180066?=
X-GMAIL-MSGID: =?utf-8?q?1599010115232091558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 09:29:17 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, Apr 23, 2018 at 11:08:07PM +0200, Peter Rosin wrote:
> > An ADC is often used to measure other quantities indirectly. This
> > binding describe one cases, a "big" voltage measured with the help
> > of a voltage divider.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >  .../bindings/iio/afe/voltage-divider.txt           | 53 ++++++++++++++++++++++
> >  MAINTAINERS                                        |  1 +
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt  
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Same white space issue. Fixed.

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
