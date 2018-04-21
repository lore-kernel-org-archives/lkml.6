Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524327839-2-12370761160824656850
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
    1524327839; b=YYRt97WwPFcNuA10K1fxVC1CCAQr79d308MU/NKtle13ZMhjAg
    UVHkhdjLd9wToQI0rgAgeKx/YfEF8/EyRev+RRlzQrnh2Ir3Tsi8mfpSSiRAuE0+
    MlZnxuRqSAxRtxFZo8yJNEG5rKoiid64HcJThLsuaovFTeK03/OtUSs7uAAx0kUn
    rNl+/y3vpzTj7o5gumA6bQxMOGEyI0/mxdyUBDyJ/1JCdLfvTT9LWzJ0K9JFIh5D
    BTPAfxWIZh9pXzZBS56T8tbzxaMf1cjscoGL5sfqCPfiwEfIJ2KvQfTuC1+jNABq
    3bpx8aijgpgNMs06qKLgr/xWAqndxq1+XTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327839; bh=t1JJz
    dLdVt8xSaTSzGaZmyT1osBo0ItIv4wvUkSxaWI=; b=kRZidwgD2rCP2KSvFnF18
    0Evw0xSXpOvwKARpJmfuO4JsOooBiOybIUZ6RuUiQpCSzniD7cI1EaYngB01EtJF
    N5JIsh+TxEySjuczNYW2+MVTILhRKibKzbWSIRpsbg09FODLVDJ/MAHA2u8COTvb
    DSW4KOSdjObjHUB+Eu/g0ckIYXt36eRwllc1w9DfFmLUR+izeV6+GpHFJewwE8uA
    x/5QOwHH/5j/fDT6/kj1XGyA8561aprvh5dc6wvwyxS9+oYck1+DkK0Y1VXU7WEn
    gh3F5y91zkIq0R7ERVwaAYVnukiT+eOIieikQab0duy0A5FCt/o8nh0O9VyknROG
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfMpuYlWXaRP0k4ZktKkt/lNjA0tL18lS7ehTcP2obwmHkD6U+itJrzvQz8W5993dTC7kuZolSvruv1VCwXuawuX5T/AubjXr9Jd4G1vXDpEJfGnebmtG
    g+FqMev2q1KRss/40yLDbFqLhe4RDK4BgT9aR5mbz6N1A6a+Tm6nQI8xhXojw9SijNCzzBIDhJn7v2Bh5SJ0BCXYmv0i3Wh2rrLQfjImKUsWXGKLBkd4fAnv
    xLcNORq2rsv/2ZU3LHFTVw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=QMfWv8vFp5p0oPFkFAcA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13D720C0F
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:23:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 05/13] staging: iio: tsl2x7x: remove unnecessary chip
 status checks in suspend/resume
Message-ID: <20180421172345.4c0e17a6@archlinux>
In-Reply-To: <20180421004153.19073-6-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-6-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:45 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_suspend() and tsl2x7x_resume() both check to see what the
> current chip status is. These checks are not necessary so this patch
> removes those checks.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This description could have been clearer... The key point is we
can always know what state we are in when we hit these functions anyway
(I think).

Anyhow applied as is to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index f37fc74b8fbc..8d8af0cf9768 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1682,27 +1682,15 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  static int tsl2x7x_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
> -
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> -		ret = tsl2x7x_chip_off(indio_dev);
> -		chip->tsl2x7x_chip_status = TSL2X7X_CHIP_SUSPENDED;
> -	}
>  
> -	return ret;
> +	return tsl2x7x_chip_off(indio_dev);
>  }
>  
>  static int tsl2x7x_resume(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret = 0;
>  
> -	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_SUSPENDED)
> -		ret = tsl2x7x_chip_on(indio_dev);
> -
> -	return ret;
> +	return tsl2x7x_chip_on(indio_dev);
>  }
>  
>  static int tsl2x7x_remove(struct i2c_client *client)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
