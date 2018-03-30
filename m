Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3271353-1522409636-2-9348110162540803542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522409635; b=WNtudx9FKruuNy3bDIB+KdRB6KSMMcOCMV88v0/7XkilNPgIu2
    u9KZERPhP3GalGSMShisswNvNvYL9j9aYv/0tUkZYQf6OQRF3M2vthKQIfjajUZ6
    lIgbgttTKhMVvRoXAn8ipD02scLsqSbgGJNS8JQrDllr//4qJH1aGA9iTV1Lkp+I
    pExz9QP5sD24NYKQwqdKathOPRqx+VgsppbV2MduvmNXoYU6c4rz+7ySiYZm+O3T
    LV7kdVWJqOSELHKzDXVdhsccyJ1AKnpYeba6KtrbV4pvSQoferM2lvWqL2G1Ax/P
    k80ihgt+J98dwX89ZHfUZh+YIFCxl+famsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522409635; bh=h7pQ8
    XwlC1ulAIw5qilmKk1WpIMxgpIB9gh7qlMMYsQ=; b=KHexfF5KroC4RWng4QiJl
    84NbvSZFreoKSGkXm6ya+s/5Vwe040LLUoyjx5DM7J3mLufz2C8ZnCz5vSyCS1hF
    QL8zySUKkrl+IIJbF2sTMZ3t6xfsmSpf+MkdXQN1RVmp9FmZeJk0CogX0YvNZ/L0
    fcf+DIMOaFO3nnFDQtW0kAq+fyoIVgyO3TpRKhUbpRyAjHnnhXYQ8efun1lMP9+V
    mSr0/RU609iQwRvVsOIIjxKQEKCmytQBAKd7frOEjbHpBQB/PMJpOVLAWXmbwgW/
    wAsvZsvOpYDi++tbAAuQTUJgKoOekxFc05RfwOCx/46BuzddcUIJJhYD+hYUCnSo
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBbTI66KuPhM4m8vjO5a5PaGFqe9BArgRJzF2xJ6r8dXW5PvR8qM0k57/bZW0t+EzBKohZhrafmzKwCc5lgyxcGofjVfwbq6nUxvzQyqFS4NRdBwwK2E
    zVkek3hzybCqBvdUnsSZqSOQunuhArKwmAq9wxS+rUxoOQWK1k8pGrBvec62KdgqEGPMgLwBsTkM2eRKE3CgvA+Hvg1OL9XtEdmeBtfIgeF7TS+u7BiLvSoP
    bjwe5P8FIEZSjTkS4l5yeA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=SZeIkd869RRzi-bddtUA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4032175B
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Fri, 30 Mar 2018 12:33:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v6 3/6] Staging: iio: adis16209: Add a blank line after
 return statements
Message-ID: <20180330123343.7748a973@archlinux>
In-Reply-To: <517fdc2cff0ef238e74c2114fba1a73d2a40a999.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
 <517fdc2cff0ef238e74c2114fba1a73d2a40a999.1522306893.git.shreeya.patel23498@gmail.com>
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
Cc: devel@driverdev.osuosl.org, daniel.baluta@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net,
 knaack.h@gmx.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 29 Mar 2018 14:44:42 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Add a blank line after return statements to improve the code
> readability.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v6
>   -Introduce this new patch in the series.
> 
>  drivers/staging/iio/accel/adis16209.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 8f4fa6b..ee7e87b 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -277,6 +277,7 @@ static int adis16209_probe(struct spi_device *spi)
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> +
>  	st = iio_priv(indio_dev);
>  	spi_set_drvdata(spi, indio_dev);
>  
> @@ -290,6 +291,7 @@ static int adis16209_probe(struct spi_device *spi)
>  	ret = adis_init(st, indio_dev, spi, &adis16209_data);
>  	if (ret)
>  		return ret;
> +
>  	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
>  	if (ret)
>  		return ret;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
