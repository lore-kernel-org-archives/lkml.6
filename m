Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4098462-1520452405-2-14763686593156942230
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
    t=1520452404; b=RweOGi6s19+hX1vC3XJsv6hX7q4yc4U5bgHnD9I7z8OClU2
    M0v2wPFsPqfxwllSOJanZBK7brMtc4Axo7jiDLEThIGXoPQ6IZs/5zdMgZpgMo15
    jMfGrnds/5MA4WLOGYOi+ie90au5W/pzW8/89kI6/5umATVyHb0iNS8N0TEW1Cki
    uTHAe5GUor/jLJaL4FM47vF+UsOBT9jPSHz99CDZ6cxHYu/04IHRuOmHEui/ksRU
    6c+FCdb/RULemZthnf9wtqMZt7MEgtlQLVAHx6oby5+PNmWS34SLxfm7jMVxD/RO
    5Chb65YsKZWWo51fS5ZGd0QzwYmmUppM/OCxLCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520452404; bh=7
    4SnXgoy7uTww5TvTiVKrLlwZuYQrF3ncES2/wUFb0g=; b=oyFlRi7b/eJfMOR5M
    Pf3jvhgFjorLn4Lt6QLacY3XlVzVmqdGqvl5V4zR/E1URWV7Ha2kjs4xTEN0ehGL
    hMLDSGMA+vEnfGM5v4lU3nZm8fzvB+V20Ng2gnv5rfhHBMg2D4c4XUMJK4ynh4lo
    vG0RZthdFtKqUE48unebcFdhffthMzJXgZ4ESMsgWKPqBhdet/4L0ZxwKIOFqFZH
    l9laGeIDx0GaVSdxMA7KKWsZAFweQRB13FI0gICpCpBFrY/XUG+4UZ+LqTSRYI28
    ez1Dvrtzkt5LvaaBHb2GhKmBGfVNT8M6eF3r7iT3lsI3nzXyQcVvvd+qC1VIO3wo
    Dujnw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
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
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3532920685
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 19:53:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [PATCH] staging: iio: Remove unnecessary cast on void pointer
Message-ID: <20180307195315.7cd6fe93@archlinux>
In-Reply-To: <20180307131717.GA12326@seema-Inspiron-15-3567>
References: <20180307131717.GA12326@seema-Inspiron-15-3567>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 7 Mar 2018 18:47:17 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> 
> - (T*)
>   e
> )
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.git
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index bfe180a..bf76a86 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -254,7 +254,7 @@ static const struct attribute_group ad7816_attribute_group = {
>  static irqreturn_t ad7816_event_handler(int irq, void *private)
>  {
>  	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
> -		       iio_get_time_ns((struct iio_dev *)private));
> +		       iio_get_time_ns(private));
>  	return IRQ_HANDLED;
>  }
>  

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
