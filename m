Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3343216-1520693664-2-24490029910544649
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520693663; b=Nq29R6owH3MvfXDvOKyXiMHXq2V8yLAcDb7Vd/IcKKB3FAg
    u65np26UNV64U3hjhTJp69P1uI2B5W+BHj1zd1JMBSc75mcTGAwkdF5TcRgWHrAP
    cR3R7VPenbS9tXMCrtWb7r8O3o8b8OkEVrHoN7un2vRd4UP6lgrFLlIhRykc1Biw
    9BwtkfJDi8ywgunFXTPv2nFv3m+sitrH50bK1uabHfynk0+9/AN2zSD7Ghlqphcf
    e7aOHR4ZbNZig71dYv8zx9ou9DYlc87nGiB2032aTtzq0fauAhi4NIT6e6kGor2I
    KO2FN5jeCLmeun6kIkPnjaEw5WU/6OjGFKHRjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520693663; bh=m
    SWVSK8z6YhY62qVyT64ApJ5HPKUHBzICUhgkmenQK0=; b=H+n+oXYXH6hVgO5Sm
    ReUJ9f44lBLF+8I10DwULMie8lHndgWYIys4m2Pk4tPl0CIBgtTR99jeAPXoBdLP
    FVIf7U6cnD/z8xuWwB1k1SlB0gJV4F62nUgxhdMgWmL4fDITypdbLw42TWTBUlDO
    omjqItCapFsFx2ysPIE/Y3YxVlA5wloieAFB2LvlDflstN2RAEj/WC+fl5AZsOOt
    Aiq9v0qgobuBO4p8onw/zBKBqZ5qRIKllQwnmmDfVOdiAb8Wsj1X5sNQGackIjEU
    ATdgNQSvnmVG9thcVs4tZD+epNFb5Iq3pZxBIe7opFECd9cctj07w6LmlNslmW7B
    zbvtg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1035920685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 10 Mar 2018 14:54:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 11/12] staging: iio: tsl2x7x: remove unnecessary sysfs
 attribute
Message-ID: <20180310145410.3dac7025@archlinux>
In-Reply-To: <20180304014942.18727-12-masneyb@onstation.org>
References: <20180304014942.18727-1-masneyb@onstation.org>
 <20180304014942.18727-12-masneyb@onstation.org>
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

On Sat,  3 Mar 2018 20:49:41 -0500
Brian Masney <masneyb@onstation.org> wrote:

> The tsl2771 and tmd2771 devices create the
> in_proximity0_calibscale_available sysfs attribute. These two particular
> devices do not support changing the proximity gain value on the
> chip so this patch removes that sysfs attribute. As expected, these two
> devices already did not create the IIO_CHAN_INFO_CALIBSCALE channel and
> proximity0_calibrate sysfs attribute.
> 
> Page 38 of the tsl2772 data sheet shows that the proximity gain can be
> adjusted with bits 2-3 on the control register:
> https://ams.com/eng/content/download/291503/1066377/file/TSL2772_DS000181_2-00.pdf
> 
> Page 35 of the tsl2771 and tmd2771 data sheets shows that bits 2-3 on
> the control register are reserved and changing the proximity gain is
> not supported:
> https://ams.com/eng/content/download/250264/976045/file/TSL2771_DS000105_3-00.pdf
> https://ams.com/eng/content/download/250283/976077/file/TMD2771_DS000177_2-00.pdf
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This one applied without the previous so I have done so.

Applied.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index fb91c46c8747..8c29a52153c1 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1477,7 +1477,6 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> -	&iio_const_attr_in_proximity0_calibscale_available.dev_attr.attr,
>  	NULL
>  };
>  

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
