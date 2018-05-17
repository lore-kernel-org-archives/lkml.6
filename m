Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2387529-1526575580-2-5556610117106140760
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526575579; b=Szw36JcZRwRLgWNhmsthhlhXXVD7a4Cr3OwVN6kdQ55aJK5b8r
    bnEb/OREBAJrbBHJmITcKO4OPoafvyiUqLZe1NCkHtRErq18tn9M2VzgchoQ38ce
    fLOuJztDIvmGt4elgwF/x2wYDbaZ4zay4cwTOMZn6uQQmQJnn2TyK01R0MKWSsne
    v9343rXI8h0frGBScyziR3mz24to5ZYdce9uEOhUazQAZrhD/sV34Cjz5Xr5yq64
    XA7DNnjt6eh0DS/ssZclkV2zdoSvCOL1I4AwtFbwmJQAP7H2uJQjE6AeahsBEWyM
    9eHLT/zi3PStCUuGhikj9PMlw6shMO3nq86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526575579; bh=4XnQLe+qQA1lYvii1G2MQ/f4qbpZUB
    zRpbU4VOtY5uQ=; b=Lm5ZkoLoz6OlOzaU2kEqRJjz1yt6KZzAUNTB6FpGsfs6cg
    WSjKAeTWil19AAeTZRy4oo4RGTK2O/gMdwt72an6c0WEfsZqZA5qpA8sJ8ciBa7L
    OoKT4WEcCuua12oxM1Uv70ieVCzjcds5LhpWoAroOAfhH4tdRckdQm6Xr/sCd6OZ
    UhuusYfABUKnLPRoVOWDzMhuDj7X3y93/sfd47nBwuYNmn4SQBK0ME/S7ntS+dB1
    MSNGFIkfS1EQCKuADn5O11t0zGVD3Y3/vueekIYxU4oBdSy9iaMgcZIwgQrbihuC
    fHTzDJXU8chSNv8JzkXBWXOyPqlO8k/cG6FM3dyA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=sirena.org.uk header.i=@sirena.org.uk header.b=puyo5BTc
    x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=sirena.org.uk header.i=@sirena.org.uk header.b=puyo5BTc
      x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=20170815-heliosphere;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ8x54x6MOpC/7V5m59BsC7pck+dh2pimFRe6A+FHhTLB9K1sBi4nj1ZHoqvBRth/aHaFmJDmB1BebbZjjHMtkurTvwl1suNp4VeigYtWn4Sw7xeClAe
    o/q5ztzifX5XazwHM7zXA6WK7Fap1ZXeGLFIqm0juZpXvvdLqG9kJWxfbDxR+zLFXm4oKBhg0b3fmtwC4webovdkJIz1ObeeJbU/WY9V/HeoeqcBpRUVWlGa
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=3XQcKgQYUIQwYxBhhq4A:9
    a=CjuIK1q_8ugA:10 a=ALnHXxPZyrtXQ2FLFXoA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeEQQqE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 12:46:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeEQQpG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 May 2018 12:45:06 -0400
Date: Thu, 17 May 2018 14:04:06 +0900
From: Mark Brown <broonie@kernel.org>
To: Radu Pirea <radu.pirea@microchip.com>
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH v3 5/6] spi: at91-usart: add driver for at91-usart as spi
Message-ID: <20180517050406.GF20254@sirena.org.uk>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-6-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
Content-Disposition: inline
In-Reply-To: <20180511103822.31698-6-radu.pirea@microchip.com>
X-Cookie: Are you a turtle?
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 11, 2018 at 01:38:21PM +0300, Radu Pirea wrote:

> +config SPI_AT91_USART
> +        tristate "Atmel USART Controller as SPI"
> +	depends on HAS_DMA
> +	depends on (ARCH_AT91 || COMPILE_TEST)
> +        select MFD_AT91_USART
> +	help
> +	  This selects a driver for the AT91 USART Controller as SPI Master,
> +	  present on AT91 and SAMA5 SoC series.
> +

This looks like there's some tab/space mixing going on here.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for AT91 USART Controllers as SPI
> + *
> + * Copyright (C) 2018 Microchip Technology Inc.

Make the entire block a C++ comment so it looks more intentional rather
tha mixing C and C++.

> +static inline void at91_usart_spi_tx(struct at91_usart_spi *aus)
> +{
> +	unsigned int len = aus->current_transfer->len;
> +	unsigned int remaining = aus->current_tx_remaining_bytes;
> +	const u8  *tx_buf = aus->current_transfer->tx_buf;
> +
> +	if (tx_buf && remaining) {
> +		if (at91_usart_spi_tx_ready(aus))
> +			spi_writel(aus, THR, tx_buf[len - remaining]);
> +			aus->current_tx_remaining_bytes--;

Missing braces here - we only write to the FIFO if there's space but we
unconditionally decrement the counter.

> +	} else {
> +		if (at91_usart_spi_tx_ready(aus))
> +			spi_writel(aus, THR, US_DUMMY_TX);
> +	}
> +}

This looks like you're open coding SPI_CONTROLLER_MUST_TX

> +	int len = aus->current_transfer->len;
> +	int remaining = aus->current_rx_remaining_bytes;
> +	u8  *rx_buf = aus->current_transfer->rx_buf;
> +
> +	if (aus->current_rx_remaining_bytes) {
> +		rx_buf[len - remaining] = spi_readb(aus, RHR);
> +		aus->current_rx_remaining_bytes--;
> +	} else {
> +		spi_readb(aus, RHR);
> +	}

Similarly for _MUST_RX.

> +	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;

You're actually setting both flags...  this means that the handling for
cases with missing TX or RX buffers can't happen.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlr9DUUACgkQJNaLcl1U
h9AZ8Af/TfudZuJqOMwmfzPzpWNjaK16fM6QqAxtb/t4AgLJi7gFUUFADP73Gxjs
2AMjNTH3hGmf6kHuRu2EcTmkLqg3a2TKXJ/pjJJxVABTwqwJ9X79hT9Sbt9lTRN9
jF2g/jHD21IbEEuC6q5W6m1sxmeJ5h5RKLLVy4D3k/Vtsak0iMN7STU/JoHHHjes
bge+7JUXHaJ4/L2p/a2tagPZ2UYtO/QstgEbytrtfVBXoG96KWL9zQ6gs7jNIFqb
iEaA/sdu9hEht0UgO3HAeKDj5wVaoo0W3vaFxxWXwc0bmUTjDT89KtjpjTkc+eY3
DAbap8+AlVu9k34DVGRPV1G13go1ZQ==
=o0Db
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
