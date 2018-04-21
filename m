Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-364443-1524328780-2-17315187343222619868
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
    1524328779; b=Z8DvORSLyPS1onryqSQN0vV5bZPqnK43/IGQoYMOmpIQSKFgv8
    djF5fQGsipPTxR5XQuZPBvzgQSeuD+/tGWzdzXC1rsEsXtz0jn7nrfJVBExBZ2Uj
    C0EDp0uMjlNcp09qmr8FNRKbx06jzSVwVeld+zg2uHfPEjCTHnqgRUPgH6W4r+r3
    qfZ2ceTlq9obiiLf7GKwYeKe8GWI9QZ362BOzy7fPoa/drDAYvrbudItP0RFwirR
    qKiY7vFJI50IFF6R0A4se9sBUI/oKWC4KFzuHACUOnDsG6XD3wQvR/4wcHe0GXzX
    Pr35CFLuDPbQ9iim8nkRvQgSkhI6ylXjKRkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524328779; bh=fmjwZ
    PmbfoxZglTNfglFhzWXPdzePOTjydQ9Q8jfkpo=; b=ishXfYE95XvYccrEr8+nr
    P7fzE2wV7OoVy8Z6akmV6KIDX2ZBJK+3DruKXPZIDXmfoyHNrr4h8U/D6k9s9+g3
    4QngR7M9HX9u6M1u4VRs+YfZbbRxsBPQC7XtmSImWis6SuysxPvEIfl/C3tGQeFN
    SKxwst9qkkLupVWedJRV+sDCEONgMSnIfg5+KPHpbqEyfG0fjgaKQJhNM26xtrsn
    tWOWqJZM0GEiGW8xtkzOi11SU3dcFWBQs/ARcXXUaQOtxtnt+dlMot54nQkG1lO8
    R4uvyyyW269bUfC8re3qiBWYLjP8qxGG0bOH1UVKhYJrcaTk0pGKe1IokEr7sIJQ
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfMQCQ4ltkrTw/OVSsjNmgfuTBGGOPYnhaVNOJheD6VscXYXYYMY6NGVXYrhh4dR9z5zw3y6cBdHTjElttKejJc2MJC0AyeWqLwQxBDBLLByKBie0VHqA
    x2u393wvIHjD/jvwNzXPz0PYc1PYMOGo8LtGXetoMJccI4m34gWOMPZPGMc9TF4iFdHf2HE0wIwXhDFtxuRPFWBHAsUZQcu1799o9KafzeQKv8uiNoibZwr9
    3RC3vonFOo7ZgC90nsC67w==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tvE6cUz2AAAA:8 a=DDOyTI_5AAAA:8
    a=uarWUWpaM1eVBszjDLIA:9 a=iURj6LT6v9Ml416-:21 a=xpsYgFJBhW0qLos4:21
    a=CjuIK1q_8ugA:10 a=sFRLSohfApMN8RASoVBY:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BE321742
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 17:39:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Subject: Re: [PATCH 11/13] staging: iio: tsl2x7x: use device defaults for
 als_time, prox_time and wait_time
Message-ID: <20180421173927.41475990@archlinux>
In-Reply-To: <20180421004153.19073-12-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
 <20180421004153.19073-12-masneyb@onstation.org>
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

On Fri, 20 Apr 2018 20:41:51 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch changes the defaults of the als_time, prox_time and
> wait_time to match the defaults according to the TSL2772 datasheet.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied, thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index a7b4fcba7935..293810ff11b9 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -201,11 +201,11 @@ static const struct tsl2x7x_lux *tsl2x7x_default_lux_table_group[] = {
>  };
>  
>  static const struct tsl2x7x_settings tsl2x7x_default_settings = {
> -	.als_time = 219, /* 101 ms */
> +	.als_time = 255, /* 2.73 ms */
>  	.als_gain = 0,
> -	.prox_time = 254, /* 5.4 ms */
> +	.prox_time = 255, /* 2.73 ms */
>  	.prox_gain = 0,
> -	.wait_time = 245,
> +	.wait_time = 255,
>  	.prox_config = 0,
>  	.als_gain_trim = 1000,
>  	.als_cal_target = 150,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
