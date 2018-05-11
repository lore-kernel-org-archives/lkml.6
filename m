Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AB8JxZpk626jYdCKnGjLxgSPER/XENHlyq7KiJbAy/GO/nPHKMuWU54XmG8nCX0iOE3SmBb65uPe
ARC-Seal: i=1; a=rsa-sha256; t=1526051398; cv=none;
        d=google.com; s=arc-20160816;
        b=BfpHUHuO/i9wUkFNbYrLJScPH8s1NgoL2GEOboUPAXfrHMjuMFrroB1PyXUYRRYDBQ
         fLjcogme2mTVzTjsp8w3KtNoSX0VEAs9YeDOv7U+QyHt1Whxe/VMjBqgGqm2InQ7qLuE
         74xT79gUdffPttsDSgZGQ1vV4QoKBctfvGCA8wECtR82WZtOJsDHY1rTAk3mZ5/sWfoU
         ezJpCQNwWCDGtQB71bmk3IKhBDC70a4sCPsHzzxq6rBBc4IjR2sTJLqvvTk2dSfJ7dfC
         nxROT/UVBtVaTt5L4FxdU7zpz9tG34mpsAeO7XrTNWWdLnN3nuCsK++aWbGWEn4k2EF6
         pS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=AcSWmsoOUU/E+Kw3bR/rRTqR6GEpWgoc7oyBDq9h5QM=;
        b=Ef9e3sC/vTr1l5B2CiDpi0OCnLBJ75Np/VH7CVuj5wlvvTVVUoSgx2H1+G7Bhbvqja
         5b11vHDDGh7t1tf4z3gH90KwuxDVO/vd2tB9BrHnHqDXMNfvkyx/AAlSqlrLnjmnEO4s
         /YL5ZRGKI071zS4SHAUpMtDU6cUsqXdXVF9RiNw/P7R3nAx9mBl48qZtUaBOd4S5Sk2i
         PrB63vwAK9DRvXaKb5diNSbj+eHfCkKNeOhpUE8Vj5AQo9mZNXmsYbvUxZXEOcu/Eplq
         jd8zCkGldK3tw0zbFZuAz93odm58ANOdio/dxOCed+iQXDNBYTmJtyvWnJGtq4bMvF5y
         /vWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.49,389,1520895600";
   d="scan'208";a="326529934"
Date: Fri, 11 May 2018 17:09:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
    gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
    chen.chenchacha@foxmail.com, keescook@chromium.org,
    arvind.yadav.cs@gmail.com, linux-media@vger.kernel.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/3] media: staging: atomisp: Fix an error handling path
 in 'lm3554_probe()'
In-Reply-To: <f762630a681c08d9903cf73243dd98416ae96a7c.1526048313.git.christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.20.1805111709390.20118@hadrien>
References: <cover.1526048313.git.christophe.jaillet@wanadoo.fr> <f762630a681c08d9903cf73243dd98416ae96a7c.1526048313.git.christophe.jaillet@wanadoo.fr>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600180660963930909?=
X-GMAIL-MSGID: =?utf-8?q?1600180871594956422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Fri, 11 May 2018, Christophe JAILLET wrote:

> The use of 'fail1' and 'fail2' is not correct. Reorder these calls to
> branch at the right place of the error handling path.

Maybe it would be good to improve the names at the same time?

julia

>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/staging/media/atomisp/i2c/atomisp-lm3554.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> index 723fa74ff815..1e5f516f6e50 100644
> --- a/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> +++ b/drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
> @@ -871,7 +871,7 @@ static int lm3554_probe(struct i2c_client *client)
>  				     ARRAY_SIZE(lm3554_controls));
>  	if (err) {
>  		dev_err(&client->dev, "error initialize a ctrl_handler.\n");
> -		goto fail2;
> +		goto fail1;
>  	}
>
>  	for (i = 0; i < ARRAY_SIZE(lm3554_controls); i++)
> @@ -879,7 +879,6 @@ static int lm3554_probe(struct i2c_client *client)
>  				     NULL);
>
>  	if (flash->ctrl_handler.error) {
> -
>  		dev_err(&client->dev, "ctrl_handler error.\n");
>  		goto fail2;
>  	}
> @@ -888,7 +887,7 @@ static int lm3554_probe(struct i2c_client *client)
>  	err = media_entity_pads_init(&flash->sd.entity, 0, NULL);
>  	if (err) {
>  		dev_err(&client->dev, "error initialize a media entity.\n");
> -		goto fail1;
> +		goto fail2;
>  	}
>
>  	flash->sd.entity.function = MEDIA_ENT_F_FLASH;
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
