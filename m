Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1356340-1526124061-2-12878156489939613982
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526124060; b=eO9m6IIjpKgbbf9PWvIJk7J+dkW/NZhxZuOHrm/3qYCe9a4WqH
    WnWHreMmnQbH2VYNUXGtvjqfBWG0DL5dysczkWM+/+6QmOA8HEWlZlx/xwZFfEO8
    BFZJB5BYKJLsJkUL2Wi1QQ/AE57YkRlGIVY2HKDsVvwD4QZJ01VXS7QScKfVhbmX
    +YZ7Zm9fl2bPu4Jl8ntP9IILv1lI6LwyhVxxGyFiLXo7KJnAmUmhpQkKYvS4QAw9
    s8fSEgT0Vr0luzz8yuZDEK+/77Ymrd/WizJy6LR9YDlisHizF4ObPGpKS4NQHDBw
    n3EQV87UBnQV2sTB0w2dezjD/81eofa1wxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526124060; bh=4i/P2
    tGJrCDDIEhe4ZZFt4g2aYF9Q/Z+8w+cBZ5Knto=; b=c/QzXMgkLhHGrlEWuDN68
    i5pJePxyQetfxmf5L2T73fq47sUpR5Z/RVQ1cpdlQ/XPRGbmu0lnEX5fyyXlZrh8
    8Ac4qjogBFrORjWIHL1rvLT6xj+wDf1HYHRkp09I4X3cM01LCnFF50JIwFzLJgD6
    RSDwdG6ya15BUL0+T2GxvhI0xhpgb4HfL2QwThgEPLbUWGbhyDzaJrX9lq9VPTtZ
    KpBxp4NIh4iJJaI8YIe6N3rgK6FdLPZYcEGIF8oUg9r/jCBJW1V5LXZYQlB1FfIS
    cvr2jr+9NnzsvsSesLpJ7Yx/2g/Ekg5YkczLyJt9EOu06dw/E06fWYpzIPEWusbV
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=MYXgWV7w x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=MYXgWV7w x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNmYL1bWdzDw0iS8AWAd4tiZTo3nk44IIIL7jyhcTUmpdW/60w8gePxcUaC2Tx/+nHnYKEP0xyw8dm3p1XcQ4dvKKFWhnMsUc7o6xpjSXDXwtHreMvQq
    v6eW150hzHHcIZ8ta3bpM0UlPcWyzDcYaqGD0w7a/9w3zm89okZ8LwEnm4CUr8bb19NiHCh+PWFngd1NDyK+sqMzUxvPlbJ51BrMsT4c/IlCrNPTJZtaBMu8
    SByLwK+cpTzphw3f7TV8WA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=BqRi_4Bf5AOWHVa7HDcA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 12 May 2018 12:20:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH v3 4/9] staging: iio: tsl2x7x: use macro to populate
 tsl2X7X_device_info
Message-ID: <20180512122049.7e704d7a@archlinux>
In-Reply-To: <20180511001223.12378-5-masneyb@onstation.org>
References: <20180511001223.12378-1-masneyb@onstation.org>
 <20180511001223.12378-5-masneyb@onstation.org>
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
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de, drew.paterson@ams.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 10 May 2018 20:12:18 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch creates a macro that populates the tsl2X7X_device_info
> structure to reduce duplicated code in the driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 61 ++++++++++---------------------------
>  1 file changed, 16 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index f5ca5ada0358..51c1a90cb592 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1305,52 +1305,23 @@ static const struct attribute_group tsl2X7X_device_attr_group_tbl[] = {
>  	},
>  };
>  
> +#define TSL2X7X_DEVICE_INFO(type)[type] = \
> +	{ \
> +		.attrs = &tsl2X7X_device_attr_group_tbl[type], \
> +		.read_raw = &tsl2x7x_read_raw, \
> +		.write_raw = &tsl2x7x_write_raw, \
> +		.read_event_value = &tsl2x7x_read_event_value, \
> +		.write_event_value = &tsl2x7x_write_event_value, \
> +		.read_event_config = &tsl2x7x_read_interrupt_config, \
> +		.write_event_config = &tsl2x7x_write_interrupt_config, \
> +	}
> +
>  static const struct iio_info tsl2X7X_device_info[] = {
> -	[ALS] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALS],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[PRX] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[PRX],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[ALSPRX] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[PRX2] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[PRX2],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> -	[ALSPRX2] = {
> -		.attrs = &tsl2X7X_device_attr_group_tbl[ALSPRX2],
> -		.read_raw = &tsl2x7x_read_raw,
> -		.write_raw = &tsl2x7x_write_raw,
> -		.read_event_value = &tsl2x7x_read_event_value,
> -		.write_event_value = &tsl2x7x_write_event_value,
> -		.read_event_config = &tsl2x7x_read_interrupt_config,
> -		.write_event_config = &tsl2x7x_write_interrupt_config,
> -	},
> +	TSL2X7X_DEVICE_INFO(ALS),
> +	TSL2X7X_DEVICE_INFO(PRX),
> +	TSL2X7X_DEVICE_INFO(ALSPRX),
> +	TSL2X7X_DEVICE_INFO(PRX2),
> +	TSL2X7X_DEVICE_INFO(ALSPRX2),
>  };
>  
>  static const struct iio_event_spec tsl2x7x_events[] = {

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
