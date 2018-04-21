Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524327544-2-4369506153325946899
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524327544; b=rGcfHJ8kIVTrbvNEFjdgEV1qlutpnqSOHj4EEQ4hp9nGXJ0FHH
    N9r58J2FFG7CyJ7FQXOUHZ3LV2n0yrGfGYAYBzJhw1zPeSrhoAovRJDFHCsnjnS8
    g6bvTs8SEX4oOFqRjW69uk2o/kIc6R/kyg44Reg1wW8YrPq8ZlWCQN9wX1p4K4vX
    PV5/ymmNkJmZ4EnnZ9sVBm6VmLOJg12pNuc1XCc4vpfLkDVjzTIoMze+aAT28Bqu
    uxqkc3MIM/egvMvna2/p9nc2ANQrfsOEp1vu4F2HaKf+e6BWZBdLn1BtlliPsUsk
    xyVr1fVWB/98/8CXThNh6pcoxSOooWLpF+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327544; bh=yf8K3
    YHDH4LG/dwJ+caYEw24uBNPJpdNtu24Aj18o84=; b=KEYI8WfJ174EFMzkatNBM
    UxLCHoS/Zz5E12w+aRwDvkVo+ERt1j77B3XDAasiQknwJ74SGPmLmxeK9MGTZLwZ
    +Rjx91YEBecJYPUjdhibDFbPLy6lpuS2UgVuc4kMvMyLfT0AaTiGQwe5IbC3aMkt
    1YEgCiGuTiDQ4KndL+fL003l5Tj+TsqZwMEulCPDuTjJoh1bKCdS7lzhkkurhz5F
    CKqUUfvvjW7LD9d5pNs0get/2d9+KwsKkLhWbGXvrPgM6Yd89Rij2DBDPfvqDjPG
    SMCzNhG2X+4GK/JDHQb4wyZUICJ6vsYmU29A3eUOfxprpp6odJGyH8cPXgGLJcoe
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGLPtBYr0sTah4DS89QjiOb+CkaorqtWub5xDwMTAtfkV1HjKdwSPYJIpmDi82VwLKM0Bt6vzVmAdVtzkcHhvwa9AnKkt5gCTw/jOUpU/PCmEktTGmH0
    XNQ5KTi6zWgTuY4XaMM1Qm2xLCit3r8Nv2qsilpeELG9rxb5mpQXXSuQqyxwNRWpgM3TXiKoTeuUI3a8oo12KMvKRmhl6hNkpnPDr5dy7lVAyuwoyNXxZWey
    aryVMU13jrIbCSCw1cSZ0g==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=vF300QZyJD9UiKfyMJsA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72F420C0F
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:18:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 03/13] staging: iio: tsl2x7x: don't return error in IRQ
 handler
Message-ID: <20180421171851.1543aba0@archlinux>
In-Reply-To: <20180421004153.19073-4-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-4-masneyb@onstation.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
 pmeerw@pmeerw.net, knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 20 Apr 2018 20:41:43 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_event_handler() could return an error and this could cause the
> interrupt to remain masked. We shouldn't return an error in the
> interrupt handler so this patch always returns IRQ_HANDLED. An error
> will be logged if one occurs.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
There is a slight argument that we should report an error from the 
interrupt clear if it generates an error, but I'm not that bothered
as that is unlikely to happen and people rarely see these errors in
their logs anyway.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 9cdcc8c9e812..95a00b965c5e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1320,7 +1320,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  	ret = tsl2x7x_read_status(chip);
>  	if (ret < 0)
> -		return ret;
> +		return IRQ_HANDLED;
>  
>  	/* What type of interrupt do we need to process */
>  	if (ret & TSL2X7X_STA_PRX_INTR) {
> @@ -1341,9 +1341,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  			       timestamp);
>  	}
>  
> -	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> -	if (ret < 0)
> -		return ret;
> +	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
>  
>  	return IRQ_HANDLED;
>  }

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
