Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524328005-2-11099087325941976809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524328005; b=CgAZN7Ru8DEOJJoWH7ZcVPa8yZnSzSTwN8ObxRUbhN+h+5fM7h
    MrthS1j01iIs9RIhrQS/VE+EWVH2Z0ltXs7I5+Hpm14ORW8IN/59lERF3CAlYHmZ
    F8UhTrN6/XR8KJU3D7uIoSpM11EjoDNaH6IMwIXcqocK+lHmgaBifOBYLVF66ZJe
    VVNL0FaAfD36obvQ4cx1lCHy/WM2IUvyq/Iq3oHxDZvfsVidlOHBUKSJZWFcBg3y
    GVdmOaXz+ihB8wh5xyJoA3f54+C7J6XN2lscv3aEzcS7jKNcJ7L3CabNSsbsyYAp
    IvdsVPkysCtvemw6w/Zayi048uoCaY4VON9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328005; bh=U8SCo
    VbxO/rbYYG/Vf/KqHtsVSYwXhHpAgXvdShMg7w=; b=WT4KCncUkAGmN3Ee84+ux
    7uTuYvVMEFVdML6z3QRzuOV42/l90cZ7bzEZaE5uDcR2HQ7t63KJeSFigHdez+hw
    Hjl8unyWyi75CvX2Vo5IHlj24ZfTs6/H87k0D2j6eRkyiLtzwSKc9eLUjZUA6TnA
    jmkWMMeqcC9qUgu1JBaBlzWpNX0Uk0LEs7Gt2HbNL8pvNP72Ylt+nzK6WydtoMrR
    EtyIBF4UegzeLRIecfn8iB/EswgRS/T/SY5UtOBhVMq2wGtsbWoIVonR2f+2vbIs
    djXPvhR8G8+5d5mHPhiJQWBP0ziAuD/kzsVMiRHz3o2hiq0AM3t9CyfNrVfIdFop
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOg4Vbwse9SNUygOEcIlAwo8E0G3ICQeym4z5Uz7qcb6JO2cXyS2RrhnxRlWQg9imyKWYAo0qOs55GH7YoTb4Mx+4W47qTM//XwpvNncUvkt2Aoq/LU7
    9QC2GzhXaNJ7YqQB15Bcn3gDNST3w/nT5H/4kRpo3aCRNx7FroOy7AZRRyUuKmcKUuQ/rOcZWW7kG6cuiUAa6Tqu8c21nUDS0AVIJL1ZmepaUvzZ7uREvOdL
    +dtSenJYRVHgr8INeApTDg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=BUyVczzuqhJINxrtzcUA:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F8820C0F
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:26:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 07/13] staging: iio: tsl2x7x: simplify device id
 verification
Message-ID: <20180421172632.61dfcd5b@archlinux>
In-Reply-To: <20180421004153.19073-8-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-8-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:47 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch renames tsl2x7x_device_id() to tsl2x7x_device_id_verif(),
> removes the unnecessary pointer on the id parameter, and only calls
> the verification function once.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
That double call is just weird..

Anyhow, applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index d202bc7e1f4f..56730baea927 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1277,22 +1277,22 @@ static DEVICE_ATTR_WO(in_proximity0_calibrate);
>  static DEVICE_ATTR_RW(in_illuminance0_lux_table);
>  
>  /* Use the default register values to identify the Taos device */
> -static int tsl2x7x_device_id(int *id, int target)
> +static int tsl2x7x_device_id_verif(int id, int target)
>  {
>  	switch (target) {
>  	case tsl2571:
>  	case tsl2671:
>  	case tsl2771:
> -		return (*id & 0xf0) == TRITON_ID;
> +		return (id & 0xf0) == TRITON_ID;
>  	case tmd2671:
>  	case tmd2771:
> -		return (*id & 0xf0) == HALIBUT_ID;
> +		return (id & 0xf0) == HALIBUT_ID;
>  	case tsl2572:
>  	case tsl2672:
>  	case tmd2672:
>  	case tsl2772:
>  	case tmd2772:
> -		return (*id & 0xf0) == SWORDFISH_ID;
> +		return (id & 0xf0) == SWORDFISH_ID;
>  	}
>  
>  	return -EINVAL;
> @@ -1612,8 +1612,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> -	if ((!tsl2x7x_device_id(&ret, id->driver_data)) ||
> -	    (tsl2x7x_device_id(&ret, id->driver_data) == -EINVAL)) {
> +	if (tsl2x7x_device_id_verif(ret, id->driver_data) <= 0) {
>  		dev_info(&chip->client->dev,
>  			 "%s: i2c device found does not match expected id\n",
>  				__func__);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
