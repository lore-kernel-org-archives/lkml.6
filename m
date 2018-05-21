Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo9JjInhIbGX0Uwo5s0KLPkhJpDorAHzUP27LDcWk+GWrZooQ3+DBgYdYfMG+Y/EkgfRfS2
ARC-Seal: i=1; a=rsa-sha256; t=1526937272; cv=none;
        d=google.com; s=arc-20160816;
        b=JBDvHe8hEgGDMY4L2s+4FzRTAyTLlhwp+jq5tvndSKjDNt5q8oSnVFRtSjW7S7MXdD
         GiexdJgV6zMKdJQfqDNg836KrhSmp5AMLzpX7fkCohi+1baFrGOyCk6mfJFmb1Jzdwvp
         t1AWyCK+STM9rm6xuY57Cx5tJ7ZnS7JzPJ202yILSX0AZcuyUeyXa8QSDh03dmkJb8Wg
         BY11/ifoz52qAX7DIJHOkt54pIbfnK8ZKDSiGZ3IIzLrNeKG2o5ICN97WbG3mIRdsWHC
         H7eqCgbYUF36FCqftSkeNuhq2luHrlvwyYMEiWhHLAMPbkHZdcds8HCBynWTvU5ML16q
         7m2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=avLtrpdk3hBDuxmHk+zgwTGqQVRRoSjV/OlnIbbc0/E=;
        b=NXk8VvjN41v/ZZ7h2fWeXhY+pt48iC0Zwu4x+X9/i3zjPJy5L8urZtKxApnA/nbJn/
         E3JWo6is2wpArWg2njm+FirDiODmqUMmvEhVUA66dx77M8ESwbAA4mAP19ZtVzvwYMPb
         icahvoU46d0W1avN3yj0LL1cOofG2eXA9Iocu12FP7qb0k8Ml51gIJVx9vwMzAdl0RTY
         MSyv2sij1aw5cChYdhR9qgQR6fVT5mSU1DKXRDLM8mwYQccaIyGjjsEyJkOxZiXQJ/Pe
         /JSOIaOyiZE23mQzyfTE7BMVm5TOffNkaqFnyeUt9QJZSCVGLpzKxLVlB5vXdcBhmBe7
         x/gA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZVAEjbcF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ZVAEjbcF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.9 09/87] spi: pxa2xx: Allow 64-bit DMA
Date: Mon, 21 May 2018 23:10:45 +0200
Message-Id: <20180521210421.086088277@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109777677915566?=
X-GMAIL-MSGID: =?utf-8?q?1601109777677915566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit efc4a13724b852ddaa3358402a8dec024ffbcb17 upstream.

Currently the 32-bit device address only is supported for DMA. However,
starting from Intel Sunrisepoint PCH the DMA address of the device FIFO
can be 64-bit.

Change the respective variable to be compatible with DMA engine
expectations, i.e. to phys_addr_t.

Fixes: 34cadd9c1bcb ("spi: pxa2xx: Add support for Intel Sunrisepoint")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-pxa2xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -38,7 +38,7 @@ struct driver_data {
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
-	u32 ssdr_physical;
+	phys_addr_t ssdr_physical;
 
 	/* SSP masks*/
 	u32 dma_cr1;
