Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524327633-2-3077052563180861342
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524327632; b=PZm/CdGXEkfxF9ZWFifqnCxqlVXRkYlW7xuIqpco+hBEHSQWOy
    aAhDLCth+JnC4twxSr1ZNUHqN3I1Pye+RsM2PfuJpiVqaiib8XpvlhjwfbT5kxZM
    flGYqbf+ihRsziLMVAOSEjm8l9q8CrLUjNrUGNjBfdBydA7AUY/ajYxF8x1/qXmu
    x/fj1P6fT6q+josplNERSdWVV1DisFoQNE+WbCg48B8SKuTuZOssVWBdvfW5ZrN+
    SdfFhgv7EG5zGpI3KfOrXUAQhSJRhdQT3no0Xz16usFHB/xV7fEA6xGXu8ZDx5KG
    VOFmrZEdqSsv8ezzV9UU3A3EbbDreGw/gnYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327632; bh=fB1ij
    Xoj3bzIfpi5Wp5At7OmyhUyaeP3W+pL850aKVo=; b=uK4rZH2zlK3I5DCTX+kqk
    FcDdEK9ZcAE7OTjqQba/ymEGhJ2zWP8Ss1V/uNUbLMB3zGXdTQHS6ydLocHgDt0i
    pKKPeUMj6sYS1F3aqtw06wEJm0qbsjT7EBIqZd6Bd0d7aNRQP5OnHA8MiI49J8Sm
    HqutcAemiiY3rmrZRB6uiW/IC5NAzaDTLD1MiGN33Z+mspQsR1whZkg50srkUEr3
    MKMfJYhoeIeX79MMkyGZZEkkEL9+FEnTZFmsZD3Ivoh2z0DXn3sg80/Ls0fRi0M3
    i1/JpGnRXtAZPH/EPJKHSq9qod47NaCWYUHMRDoPGu3XmWoyKF1ayWJEJ0xa3dlX
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJwuHUbBYiM77Wgdz/5JHZK6yl36NrlzAW0GWSJQjLxwpQgPDQpkUSO2AyemlzWkgi7yVljp6rNRjheQE0472J5tF+C0KAolo473LodTZ8fnvtyQrjEQ
    //VcTpTFpi6Kz9Gsic/xfjV8iWANX/k2IfbEmW4Q95Y8RU0D4pMBTzINXvBIckVvmL27jcgGBZ2vCg7/eDOM5W/BYSgvVlap5H51xwV1QF/xwNoKUj0WlfAc
    CFNgjSq+4ADG5fXlnHqv6A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=Y7xxY9pC7d6IIOhQDC8A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7186820C0F
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:20:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 04/13] staging: iio: tsl2x7x: simplify
 tsl2x7x_clear_interrupts function
Message-ID: <20180421172019.450ec9c6@archlinux>
In-Reply-To: <20180421004153.19073-5-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-5-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:44 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_clear_interrupts() takes a reg argument but there are only
> two callers to this function and both callers pass the same value.
> Since this function was introduced, interrupts are now working
> properly for this driver, and several unnecessary calls to
> tsl2x7x_clear_interrupts() were removed. This patch removes the
> tsl2x7x_clear_interrupts() function and replaces the two callers
> with the i2c_smbus_write_byte() call instead.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 95a00b965c5e..f37fc74b8fbc 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -271,20 +271,6 @@ static const u8 device_channel_config[] = {
>  	ALSPRX2
>  };
>  
> -static int tsl2x7x_clear_interrupts(struct tsl2X7X_chip *chip, int reg)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_write_byte(chip->client,
> -				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN | reg);
> -	if (ret < 0)
> -		dev_err(&chip->client->dev,
> -			"%s: failed to clear interrupt status %x: %d\n",
> -			__func__, reg, ret);
> -
> -	return ret;
> -}
> -
>  static int tsl2x7x_read_status(struct tsl2X7X_chip *chip)
>  {
>  	int ret;
> @@ -714,9 +700,15 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> -	if (ret < 0)
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> +				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s: failed to clear interrupt status: %d\n",
> +			__func__, ret);
>  		return ret;
> +	}
>  
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
> @@ -1341,7 +1333,13 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  			       timestamp);
>  	}
>  
> -	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> +	ret = i2c_smbus_write_byte(chip->client,
> +				   TSL2X7X_CMD_REG | TSL2X7X_CMD_SPL_FN |
> +				   TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0)
> +		dev_err(&chip->client->dev,
> +			"%s: failed to clear interrupt status: %d\n",
> +			__func__, ret);
>  
>  	return IRQ_HANDLED;
>  }

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
