Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-29808-1520456859-2-14697096658889999976
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520456859; b=Y73y2r7ckrQCiiP88KDP8WLKVScMEwsxez1Z+9RLsOrM3FU
    0JRMteSvrMAyVK60wSDkAmMZtkNUdUgHiVXGpGG4UiMFV0ClqYIHR6cTlZl7CHB0
    s0wpX/r2MY59SpmuLnBxHu5NqeLwfVcvm2LrKlduTWCoKRKjRGWWlJWqpuQ1hRmK
    N+59Kvmpz1SW42q09xGeto57Lqa446/zCJUflZOWk3GzaqW4xuLND4JpGdCnXC+C
    Lph99o6e/IuguFxLHNBwJiiOVSh5rWSHHomad+zE8zkr9/1GQC5gAtxR6LeNWekv
    LOTilAdnnElHsWxtgThaaxB2FguBYNOGMgqJRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520456859; bh=c
    K3kuzWbRL0FSQGSEbaScbl54ZnN6V+nJUjAo6UZFmU=; b=ALKCKu86AKbhdzxS9
    PBBqo8abpGuYge+kepnaDdgSYLJVqB3gVeSpXkZENUkiEA5C4Ehco4sgCB5tiSDk
    RER2v1ByrDVxIsDN0qjzkm2UojGp6ENaHmW2SyUlEvkFMFa8qpagNAa/5P1sBSHL
    hjpMGqHHAqB2xkDiPNHtbEwG8ZLTnHgHkTTdAvUKlHSI6FoyHrhYLlvCKN/z+gDQ
    zQyf6x5/RP8kiiHvkxGl61snRKkynyTO3ofaH/M6BVBAxKe6LvqMqIqFfOkKcgmH
    OjCKwoSYtHztH3JOpQ82SvbuK2UdUwgTFUQ503lyAzffLcn8teC6QfCSCp0/n+0O
    +2kqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD942172D
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 21:07:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v3 3/4] Staging: iio: adis16209: Adjust a switch statement
Message-ID: <20180307210728.59457080@archlinux>
In-Reply-To: <5c523865f71eb68181bd2b207685bdf5e9b8da83.1520164945.git.shreeya.patel23498@gmail.com>
References: <cover.1520164945.git.shreeya.patel23498@gmail.com>
 <5c523865f71eb68181bd2b207685bdf5e9b8da83.1520164945.git.shreeya.patel23498@gmail.com>
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

On Sun,  4 Mar 2018 18:13:12 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Adjust a switch block to explicitly match channels and
> return -EINVAL as default case which makes the code
> semantically more clear.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan.
> ---
> 
> Changes in v3
>   -After split patch.
> 
>  drivers/staging/iio/accel/adis16209.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index eb5c878..9cb1ce0 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -155,10 +155,16 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
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

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
