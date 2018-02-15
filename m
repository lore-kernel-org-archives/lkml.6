Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2077773-1518716260-2-17125514054593355827
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518716259; b=g0QRZibWeGrlFL7wyofcP+TvftnFYzSJgy6bbn7P0QNjqrg
    M19wzwLndPY48KDVIL/ZC71zHkpEzt/r6XmyLa69uXK2Uiyx/BjHqRBrTilAlJWx
    +pGUqXMmU+TQFg6KGkr3lNW2SpaEyXnarvhWkn8At65HwWpdI4Q9R5ka/OqCzsea
    oj7ALr/9sY7par14oq9q8AaX2Yc2IpRVQn3BeJEbnrIadCpaenOZKnNy71q7OJks
    oGiZIAu7QKOO56qOeZB1zljLpmms9/r6UxL/jSgeKbiEwA8J+OdzaTNWjmyown94
    cDj+ZLsIeRk6sLWD6JSJdvkAZrtE7mHZsxO7Pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1518716259; bh=rKqtV8jdgd1iFKwbvNQ8UVhxM7CgUw+i+DN155FsdVY=; b=a
    IiA+6ItOjQGLLNy2cyRFkgi/ZFecJ+QiclX07p/vikNH3DMui8MaxmSf9I1ASull
    CObGLG/F98K/XhCYMbh88LVh8k6UWsMswlEN3JQYzcecCOXEbptsrq/3OD+WKeE8
    DkZBkIyddNJfYlj7MUi2ejApfHjc7u6hhjp4I3F3C4REzCatA/dcBYB/gpBDGgPE
    /QFdxJ0XlPdbc9P0RWyHPcXL12MIz8hJGFoV64cBquUO5ClAhBzavFlbd/liZBju
    Rdm1Kt56U0I4DxhJXTD7NbVn9uAMkeGtbn7VphVP130lDFy+6EXQ4jKMJqS4jojR
    6F3uf02GksEsfgky3xAYg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ETN8oTaw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AI2gCuDE;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ETN8oTaw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AI2gCuDE;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x227x/trfO6Izbk/y4fbQxCkA2vpIKsBaTqnsQdvbIPZQUZ1rjlyyb++34dJDYo6HaaSfoOzTwQ==
Subject: Re: [PATCH v2] media: imx: capture: reformat line to 80 chars or less
To: Parthiban Nallathambi <pn@denx.de>
References: <ee47261e-aa6d-150f-e7f0-b80c74fdec1d@gmail.com>
 <20180215092545.25475-1-pn@denx.de>
From: Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <93193990-0686-4787-01e0-ec4dc491ff7a@gmail.com>
Date: Thu, 15 Feb 2018 09:37:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215092545.25475-1-pn@denx.de>
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

Acked-by: Steve Longerbeam <steve_longerbeam@mentor.com>


On 02/15/2018 01:25 AM, Parthiban Nallathambi wrote:
> This is a cleanup patch to fix line length issue found
> by checkpatch.pl script.
>
> In this patch, line 144 have been wrapped.
>
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> ---
> Changes in v2:
> - Changed commit message
>
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
