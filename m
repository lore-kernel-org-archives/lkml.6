Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524328277-2-17049346797704548263
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524328276; b=cxReWqm+4dg/MsVFciob2rss3zkZkJwUrog124zxITTZkzHNg+
    V/cfkMRz3kr1VKR0yq7fQ52LbxVEQp/DseCkxzGvf/PXKChJT1HuPF1YE+XmF2Ev
    uekhS4J/fV5kNxs2O5szPhqeukkXL+UsDjXuUvZh+Ng5Kw3Vfk6H+wrwhnCFaQdC
    2EZG2nEmo1adn9NZTX5dXxIMSvzwpXyccQ7XBTqOYjxftvJVC1aH/ObghcxuCCon
    WxX5WJknP2ZQIcnvlQOqvhICBHeygpCqeD1VURBX53OrGXLKiDNpYYG2V2uNpyci
    mzH5gCAB2F9w+JuDdUlfVaZxgcSwDNnhuFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328276; bh=R2mLf
    LWtTuQcm2i2VMACcn8rWuBuTGjQ22NSwyK0bCs=; b=XFFnd4jXUCKbYEfiISs7m
    chQNebZNrl8BuICNfqDZ1uwqy6eSpoyBiGywQXYyd5U12z2bd4Ac2LYnAsfGEAfY
    jVfCeOc+ybBq9YoULwsC2I3iMbfUCNXrfBIvRZO/NmWa05xX0xU3CqFtZUK4m9da
    ovU6l4RY2L+YDxgmddYsXKLo6pxNHPwAYpVrADQE5nwWIbiWqYrcqtVhcQS3uYpK
    Bw99Z7u7C6MPWru2YL3voOP0lzLC8dr9C4lFVujKqpRMky09MSnnXSjwC2JO+O9X
    ygJbZn56QxpTCaQlfV2sDFyR05kSUyHRCdebH4R3BESLldxjCnLlWYgRXupp/tnk
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPqImYlmGCSkFd8xavt72IaOK8sfMENacDB+dXYAAv4lYREwAaDre31jdYXEAav1OA1Dl+ui1hSFmsT4kEGiSB3RkZu4reoJa2wBE9/KVrYFYwa2HBJQ
    jHgIKbjeQnlVGVqcmjPIvxY1YjXga3XZyRzMK5Y1B8ZvZBjPkx4iOjtmFawmW2T6MecK0KbaPNrPGzjkeo2efnNldgP+zn1F8XJl9okCnJPOWlYZ/GklTFsO
    ak2yRqIeXX4FgdVzc1juGA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=LFXnIVYEelBOnfSsvc0A:9 a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4FA204EF
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:31:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 08/13] staging: iio: tsl2x7x: add range checking to
 three sysfs attributes
Message-ID: <20180421173103.07a73ffb@archlinux>
In-Reply-To: <20180421004153.19073-9-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-9-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:48 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The sysfs attributes in_illuminance0_target_input,
> in_illuminance0_calibrate, and in_proximity0_calibrate did not have
> proper range checking in place so this patch adds the correct range
> checks.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Comment inline.


> ---
>  drivers/staging/iio/light/tsl2x7x.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 56730baea927..15bc0af1bb6c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -835,9 +835,10 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  	if (kstrtoul(buf, 0, &value))
>  		return -EINVAL;
>  
> -	if (value)
> -		chip->settings.als_cal_target = value;
> +	if (value < 0 || value > 65535)
> +		return -ERANGE;
How about using kstrtou16 which does this check internally...

>  
> +	chip->settings.als_cal_target = value;
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
>  		return ret;
> @@ -853,14 +854,12 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  	bool value;
>  	int ret;
>  
> -	if (strtobool(buf, &value))
> +	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	if (value) {
> -		ret = tsl2x7x_als_calibrate(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = tsl2x7x_als_calibrate(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
> @@ -946,14 +945,12 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  	bool value;
>  	int ret;
>  
> -	if (strtobool(buf, &value))
> +	if (kstrtobool(buf, &value) || !value)
>  		return -EINVAL;
>  
> -	if (value) {
> -		ret = tsl2x7x_prox_cal(indio_dev);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = tsl2x7x_prox_cal(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
