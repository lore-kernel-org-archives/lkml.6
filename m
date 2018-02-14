Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4095665-1518649324-2-3788142619827010975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518649323; b=b4wfy5fgq4/hOGM/9yLMHy5dgjdelRMggZ7RC01CrHbjNy/
    FlkSlaK+5rOWus8PUTthtfXe5Uoc/wsZT/j4GhcAYdm2WXbicH/sX8ckSzao3fff
    6hK+kd2KoBwX16fnN0Bh2DVfeEH1wa1CsrJT9qfrJkMmVqHn57KwMiFbHtgJWXNw
    wc4kPRXPTzvuCBFSQoXjKPgPonLaJcfGxquLktXpDRYUcIPgkNKoLEkjhILuyr5k
    IQ7t78yrweNkjz0Xxv+LHcpS43M1GWWf3N5scWXPpmAazt1mNMVSaYZXBUElWj3F
    42DZWKS+BQ23ZJFCUWOkZre5AypmlnZfWgGMMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518649323; bh=oF39b1okC0M+yey41lZAE7U/sfwlqZ3oOXMbneVWy1M=; b=f
    4GRacxemlMATgA1Z3zr9rdk5RpYlNZcc+9wtXH7LdkpdW+HA8gN+IgjcmQMc6Dc+
    XDP/XycaEgFMolv7MckQcfsFzpRySg81ObacTtnAj8blWsVKcQXlD86zblYUG2Xt
    OflqJJudQc8vOmL7f4fdZti52nNSqmF42W/vg+zIqyFEZn3vQDREnWS92qRTzlQi
    xgt3xqn6l/uX9Jic/WyiwPYHab/PcA3ZpjsN+cbs1vCcOO4vSowOgCgjWItBE1/W
    K2oBkUWk/omXeIcoEdumQC088X1INK/qHUQqDwKAVL0CIfjvKiv4x6rM+xmXSLF2
    o4/IFbtMbU9AeKjvmrHrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L7wOtKw2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tMX78uhI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L7wOtKw2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tMX78uhI;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226Ihas623t1T+gLZn6m3vkc8yVS8R79zxh6l2eL8MTbScn++BmRID3qtcHrFeW52CeDAuYVPw==
Subject: Re: [PATCH] staging: media: reformat line to 80 chars or less
To: Parthiban Nallathambi <pn@denx.de>
References: <20180212120548.7391-1-pn@denx.de>
From: Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <ee47261e-aa6d-150f-e7f0-b80c74fdec1d@gmail.com>
Date: Wed, 14 Feb 2018 15:01:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180212120548.7391-1-pn@denx.de>
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de, mchehab@kernel.org,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Parthiban, please rename the commit title to

"media: imx: capture: reformat line to 80 chars or less"

Otherwise it is fine with me.

Steve


On 02/12/2018 04:05 AM, Parthiban Nallathambi wrote:
> This is a cleanup patch to fix line length issue found
> by checkpatch.pl script.
>
> In this patch, line 144 have been wrapped.
>
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
>   drivers/staging/media/imx/imx-media-capture.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
> index 576bdc7e9c42..0ccabe04b0e1 100644
> --- a/drivers/staging/media/imx/imx-media-capture.c
> +++ b/drivers/staging/media/imx/imx-media-capture.c
> @@ -141,7 +141,8 @@ static int capture_enum_frameintervals(struct file *file, void *fh,
>   
>   	fie.code = cc->codes[0];
>   
> -	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval, NULL, &fie);
> +	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval,
> +			       NULL, &fie);
>   	if (ret)
>   		return ret;
>   

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
