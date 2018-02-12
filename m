Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1362587-1518441830-2-2312155770375977166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518441829; b=ck8iSVj5YOcx4bRrvSnkbJxtLP90qnuDTNAAAPSZzljCXOS
    d5tl/9NaWeb07VEpJ+ynxXIWkFzLMPx/jccdqGJ5BFHC0y62h0C8SWyGwTkHG/7e
    Jcn7kg1zPcFBcWlmI9BBOOuOnYCuNG1NBkUzJ2IXPceph2WQSTLkHPM2cdiQX6fA
    ImIVyUaHW1kk4aVkSNZ13GYvKc20pKCR2+B/z0R++otA+BtZmoSx6r8z8LHcVTk3
    oS4YePbqwI+Nwbbzp9E6ckEYhGHa8VG/6++G+PeaOhr4T0BZYYJuW0bQjV4ai3Nh
    OH4jk9sgHMCD2KEwg/1sWRrb/IMmCkdGIOn3XuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518441829; bh=r
    Uqrfc1CVqnBIEQPGL3V9CB4xmU7ymuljHFN0D9FApg=; b=hf4pubV2EixpSLQGV
    uOeUADsiZdVp2JGHYSQL8QAtFmgdU2js6LxT5MRmtzw/ZKZaN82WaWyFSdHRH96E
    TrrzXxrr4ThJ4vn5c8ZRCRK+f3zh9AVp7N3VYShkMWRH9vRmcUgZHDX2J0YddYjJ
    jDm0BVZ6D6wjpM37fp5bhT7I07tzkYXqFww0jktWC0cwzbtSBRzU20tDRiHgrYFz
    yX39NZ46dyuHQD0r3x3fRu2gsEMfkMUuY3JtEUl5n63LBBLPQcavF4orK605xnRA
    L23APgd1CJffTPdNliZPqeWNTsS/923NvezKN/As6PDpd9DQTNtfILox6gjzIfx6
    TH2yA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=K/wFxHSi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=K/wFxHSi x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 16:18:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212131826.ebazvmp6iv7i5fav@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120173
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I think -M is prefered for these types of diffs?  Not sure.

On Mon, Feb 12, 2018 at 05:24:59PM +0530, Himanshu Jha wrote:
> +static int adis16201_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16201_info;
> +
> +	indio_dev->channels = adis16201_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;

We should clean up the IRQ which we enabled in adis_init() instead of
returning directly.

> +
> +	/* Get the device into a sane initial state */
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_cleanup_buffer_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return ret;
> +}

Otherwise it looks fine to my not-an-iio-expert eye.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
