Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1341486-1518441024-2-2428060482607472510
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518441023; b=aC45opjD4i8OqBNBBd/aGDAEk0V8R/2CCE99MjlG67zdd0n
    Bkb2E+02DOHNvHOVr5Ezm+SgSorvenbSQ/AYBCD/JZAWbJCQFVsATF5XPTWH3FxR
    2nNZTtq5zDyDjTtX/ZY+w575EtCRgeXN3Uo5cc0L2rvvsGpmGPiPE6j4UPBr14Z+
    GNyr94wkkJnaj9vcWWmjXOJ9/pT+olbJSQ6Sxne4MPbJLQm1Fud6t+RPNcvCQKzi
    H1t6DOPpFjzjzvdqrP8cTZTnIJGqiEvjALQ0nIA4/ZX5SxEignHtWWFGN/vTPeYC
    u2IMM2b+jNRkAW7EQntqftl4wqQjqpHjPiJ4LMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518441023; bh=4
    xGYLX6Oll4d1v8Cw5D+ExWZIlonN62kOCY249RPOKo=; b=TOr1mcydfKZ0GI8p2
    CQYHWv73u/mZR/35O+aLOX120Naf6PpjrGaWkN4yB+iviZvVvpiATjvg2Jyfsd8e
    CMVslvdSQtx80FIO1tri7LRGrYiCaSRTPqX70RH5iWT/cs5oFZri3KH1VNVk3HQx
    jYbEmgSGKMoNtXduV4vI0EEFdRnH2rYfB8P0xHTHFXkvtHSGJe4dWlCngzwqR+Lw
    LvwmXg84wylLB5zzTz4E0ZicYetf3JCo2/C+deulR5gBw9WdzmF2xEtQ+nD1cV7j
    WvJJ/p+T234P6TOyC4+1wcm1hbmI56Ffyol4a3605mW6KeKU5S6yjE8muY8P2cRQ
    91muQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sxJm49WJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sxJm49WJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 12 Feb 2018 16:10:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Subject: Re: [PATCH 3/4] staging: iio: accel: Use sign_extend32 and adjust a
 switch statement
Message-ID: <20180212131000.h4tbinr4s6m4ckh4@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1518436499-8584-4-git-send-email-himanshujha199640@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802
 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120169
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

On Mon, Feb 12, 2018 at 05:24:58PM +0530, Himanshu Jha wrote:
> Use sign_extend32 function instead of manually coding it. Also, adjust a
                                                            ^^^^^
> switch block to explicitly match channels and return -EINVAL as default
> case which improves code readability.

Greg likes to say something along the lines of "when you start your
sentence with "Also, " that could be a clue that it should be a separate
patch.".

> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16201.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 011d2c5..6800347 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -112,12 +112,17 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
> -			if (chan->channel == 0) {
> +			switch (chan->channel) {
> +			case 0:
>  				*val = 1;
>  				*val2 = 220000;
> -			} else {
> +				break;
> +			case 1:
>  				*val = 0;
>  				*val2 = 610000;
> +				break;
> +			default:
> +				return -EINVAL;
>  			}

I don't think this improves readability.  The -EINVAL is to handle a
driver bug which we haven't introduced yet.  Probably we would be better
off printing a warning or something?  But it feels weird to introduce so
much code to handle a bug which would actually be pretty difficult to
write.  The original code is fine.

>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> @@ -155,9 +160,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  
> -		val16 &= (1 << bits) - 1;
> -		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> -		*val = val16;
> +		*val = sign_extend32(val16, bits - 1);

Yeah.  This is a nice clean up.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
