Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524327075-2-2157061111585073997
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524327074; b=jrmamOhIQ+0TjagYHz6Ksy23H0aG+n2J6yWF2YNZtpnPIUByWi
    MR5zIoGw23kffVG2c3avNK8tBSWJp/ZiJzNsvSqlaL6EsCjMF8fFqz++yAlwpeUj
    7SHUcFRGBEojY+KrXt5uRcpBLoUJscYuW4HGF9HM26s7YYgBpn0M+WSc3D84DkDR
    ojxz4dYwB8dIyEQW5kYIJFunlsee42SHdaFjMTfsARuC1RG4m4AzkivFKmORUkp5
    H2mXk50BE5BJBb9aCLL1KNHn1zim8t9WxS65bRNfxup6ExaUJVxeBy6hNCqRXPcJ
    XcB3+HY2VufcUR2FH+bIUGJcUGptwvwlOP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524327074; bh=Aja0C
    ABfGx3tESTn5jMsM5A7EY2vXNFh9VP+PE2IG7E=; b=nys14Xgj86G7cqq3rE2iC
    vOdxCsRgd8F2TjE/09Nu8cr+o9R1BickMRs4IM3skqOIKEJrU6Q2yvzmvQWkgmhP
    AG9xzeRNjPBXuouG50sPb9BZUB5Ne0YjqHU6H+idqeQ+JX2TLRljyACa6JQU+MZZ
    kdRGHxDhAyWMaT7WrCb3k9XItHMImxif5GywzLoa3HM+ykDjwfpBTXs5ms39lW7w
    jS7m+IK7XeaUPaWgXnv2XHk95EKpTiOdM1FWPDvoBIOYrQkZRP/tUyef6Tb4ZqCh
    RXVNgPTIbiLTzB8kT/5E4rnHkl0mtRoiAQHHw8vdx3mAJkh1x+Ak19lGa4q1SsFn
    A==
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
X-CM-Envelope: MS4wfFyRdByIR1wWjVgGTxETyecySAJ1ttkaxCx9hecd64m0PlITVNaWmN9RRdUTRcmKOWeWp7eE+6SzpAUiWXYunFACP9nHOC9vNtlGvgUYb496VSdLJaYj
    A4stu4smzMLnp3vbiO1yqa5Oat5eHUuYRBM/4ltqmUW6Yamnhmz9ySnCegt0pebwSg8KXIL3coBC5hoVFcptDk+enf1gXkWTjoh87qMVK6+qY32KWiYzzl+t
    W5TRpwSrFhJVGGQkbuuAiw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=LDBv8-xUAAAA:8 a=DDOyTI_5AAAA:8
    a=hNnsMTUY-ymsQq6Y_0kA:9 a=TNvcACd1Xu4EW6kJ:21 a=mHxZRNQWnjuj181E:21
    a=CjuIK1q_8ugA:10 a=DZeXCJrVpAJBw65Qk4Ds:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A443F20C09
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:10:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH 48/61] staging: iio: adc: simplify getting .drvdata
Message-ID: <20180421171059.5ea717aa@archlinux>
In-Reply-To: <20180419140641.27926-49-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-49-wsa+renesas@sang-engineering.com>
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 19 Apr 2018 16:06:18 +0200
Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:

> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Applied, thanks,

Jonathan

> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/staging/iio/adc/ad7606_par.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index 3eb6f8f312dd..a34c2a1d5373 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -18,8 +18,7 @@
>  static int ad7606_par16_read_block(struct device *dev,
>  				   int count, void *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	insw((unsigned long)st->base_address, buf, count);
> @@ -34,8 +33,7 @@ static const struct ad7606_bus_ops ad7606_par16_bops = {
>  static int ad7606_par8_read_block(struct device *dev,
>  				  int count, void *buf)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad7606_state *st = iio_priv(indio_dev);
>  
>  	insb((unsigned long)st->base_address, buf, count * 2);

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
