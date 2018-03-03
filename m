Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-384599-1520093169-2-13327969342129196700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520093168; b=MGtg6UGP2feRGxjvwr48YjQTA3aOZLRntOznJ6eRoX04EjA
    VVVx1PZj2gDp9Fh/3eVaDwwocIBCM8alkQpVYjl2XutunAj15mfk7fY9bP9j5gDz
    KQvLBmCfhqIupj09Dl+rPNG1NGwJ7wbQUTkUOXv1FTbFe/hYDsw7w8JhT8WIAHwR
    4zt1FbeetfVmMRaaT90EIIgQmZijXGJmbx1ZZ4reQGADCYJW35n6KITksS2sR+uD
    jA7fPZ+t6qqIpxUdHew/+7zOvQ46Ee7DA6Ey8qE0NaH9mdabc/YztRWZPKNgvOIt
    9sfq+eEUEBVOuHazX+VUjuSeZCuf6UGBxMA615Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520093168; bh=p
    64nyPlbbBAqvGU/T6qhpZdYhTusMCvA5vzW3WB0w9s=; b=wqThr1vG32DBGSHjo
    ZyP1wxjSJKYKyhQNAbp7eCVIvrlSctb4+0Fpl9+vTslkaLJyNcK5jUSBz8KZ3S1X
    oR8MXuxPIKsQI1Oqn9epWBg6w964CElddmPDFaKhSqGg6R6g9E8jF9mGa3IgacTO
    y11nM0i76YzkOocvbBV2y8V49CVAg8r+oy8181mvKRzF9d4wOkBeN3udFXzv2hUP
    jpXon0dlHa+3DK0BGM2S+9hwR19H1EDPZk5KiJKt7ZCoBsQ/CaUf4zGve9vggNl9
    hwZh5AfVjG8yRAzWpX/nsDMAfCZX+OdLr0BuSCbywD3G7a8XQmgmqqtxIgPxhcZK
    Gx1Xg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A1C2133D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 3 Mar 2018 16:05:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 6/6] Staging: iio: adis16209: Use sign_extend32 and
 adjust a switch statement
Message-ID: <20180303160557.26462aa7@archlinux>
In-Reply-To: <982b80d683b8c8e8c61cbc5b0864c265ea2ac768.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
 <982b80d683b8c8e8c61cbc5b0864c265ea2ac768.1519995673.git.shreeya.patel23498@gmail.com>
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

On Fri,  2 Mar 2018 19:04:49 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Use sign_extend32 function instead of manually coding it.
> Also, adjust a switch block to explicitly match channels
> and return -EINVAL as default case which makes the code
> semantically more clear.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Changes are fine, but 2 changes to different things should be
in 2 patches.  Please split. I'd probably have taken this anyway if
it hadn't been queued behind the requested changes to the previous 2
patches anyway.

Good work on this series though so looking forward to v3. 
Note please mark the set as [PATCH v3] to make it clear it
is the 3rd version of some of this.

> ---
>  drivers/staging/iio/accel/adis16209.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 7363fd0..5ab44a4 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -150,10 +150,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
>  			*val = 0;
> -			if (chan->channel == 0)
> +			switch (chan->channel) {
> +			case 0:
>  				*val2 = 305180; /* 0.30518 mV */
> -			else
> +				break;
> +			case 1:
>  				*val2 = 610500; /* 0.6105 mV */
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
>  			*val = -470;
> @@ -197,9 +203,8 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(st, addr, &val16);
>  		if (ret)
>  			return ret;
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +
> +		*val = sign_extend32(val16, bits - 1);
>  		return IIO_VAL_INT;
>  	}
>  	return -EINVAL;

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
