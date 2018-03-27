Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AIpwx48O/UIn544W3Qq9k0pdOb/EJ7AUtYjNAM7pxhq7eAWQhqnNyNGOZyNgtsGGX1ylRcaiqlHl
ARC-Seal: i=1; a=rsa-sha256; t=1522126848; cv=none;
        d=google.com; s=arc-20160816;
        b=j7p4iZ9ssOJ+6d+AQyje8vsRKxW247rxCjVl/EtS84JP2jImyUEfuDrZod0DaJg81D
         YEDpajix9W5bY9c90S7PC3GFK4YTrdCO55/eE1l0Gz0vWUzBfTQaveH0WAVJEsORvF3s
         vU+bFhcFC6PrysVw6GszkXraAQyMpyIVsyGxPLk3XtbetTwJv4ZuyaAPEy9Gb5rgikbW
         0BWOVAMVMbRfGux0oKAGElzIyPwLWxmWLGn+C5YpcCtTCNaCC/32uvy266IQ37B4qHfy
         GZZl4zPSMZFKKqot0lo9dWRwHK1L1nlPlUY5P+EyhqwDG/jEWoMGeCJJzuVrSPmsWVtI
         mthA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:user-agent:in-reply-to
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=YIepli3Y92hMZcH7S4dm8b4P1of++XMDaBX0KOPlyew=;
        b=FPmz89NX3CL0vENVw+UFjycW1+WsfNj39CYGP+axDaIeShle0uRmaS2LAQ2KuyN1sR
         BBzrfSbIoGgxGunxiIP+sRuMbOT9oUaOQx+t+Bhx1fkJZkDGbP4xxV6eTocel7YYgMo9
         mSncbycT/Fq8kfbmSGHA/yJox3nMRP8AN4j5L7j3ops43A1wmjWKpTa07NR2t4NAneFS
         YiCa7dp8IINM/WbNliyJv4qzMnkzwLOUSl//uRMnuVCV0YYtFM/oXjYgqjgGKMPOMMlT
         tNI/RALRUYms3HXeR2FWAimjJxnPrrhxG4LeLhUnn/UaA921IzhxNmjKdxBUEhTXl3Tw
         Vlrw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=FQRjW7RF;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=FQRjW7RF;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180327050047epoutp0430784ee03c13fe291454fa7912c8eadc~frk2Gh6oT2585725857epoutp04P
X-AuditID: b6c32a39-591ff70000000ff4-ef-5ab9cffe1f03
Date: Tue, 27 Mar 2018 14:00:45 +0900
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org, dan.carpenter@oracle.com, mchehab@kernel.org
Cc: arvind.yadav.cs@gmail.com, ji_hun.kim@samsung.com,
	linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: media: davinci_vpfe: add error handling
 on kmalloc failure
Message-id: <20180327050045.GA12754@ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-disposition: inline
In-reply-to: <1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGczvT6ZRYvZbtBqI0o6ig1E5tYWrEYCQyCahN9KkEcYSxEGhL
	OsWI+iC4Y0VxCVg0KSoYEWWRXQJaFKOioiIqBk1MJMGFYFwwRsC2owlvX/77//ecc+8hMWUR
	EUZmWx283crlUkQA3tITFRMz9aTdpCl9GsUMHqvEmE9TZTjT2fdbxuy7WEcwxx+2AqZ5KJx5
	3nGOYJz1zVKmuvGPJEHOvu3qwdl217CMbaw5QrDd52tl7NcPQzhb0lQD2G+N840yE78qi+cy
	ebuKt2bYMrOt5ngqeVP62nR9rIaOoQ1MHKWychY+nkpMMcasy871dkapdnC5+V7JyAkCtXz1
	Krst38GrsmyCI55KpWmtmtbEqbVarVoXl7ZSq/datvJZ3+pLiLzxWTtflQ9L9wJ3QDGQkwjq
	UHlxN14MAkglbANoZHpC4jtQwgmADn1S/Dc1nX0kFfV6gCamQsXAKECTD174AziMRD9PDwAf
	EzAKNRwd9HMQTEFlvz/7K2CwAaAvFX3+mwIhh6pfX/WzAi5FV36dIkSei36deov7GIPL0KPe
	60DkcPR+slzmYzlMQkNlXX5/MFyITt9vIXwFEHxHoP5roxKx7UR0+7sTEzkQfbzX5A2TXg5H
	z+7Gi/Ju5B5ow0Xeg15PV/2LrkDHnP2YWHc2GvvhlIpRBTp8UClaWDQ9Ng5EXoMGKlwy8VFc
	AJU8b8FPgHmuGeO4ZozjmjGOG2A1IITPEyxmXqDz9GqBswj5VrM6w2ZpBP79iza0gd7HKR4A
	SUDNUiQQ7SallNshFFg8AJEYFaTIqfJKikyuYBdvt6Xb83N5wQP03j8pxcKCM2zebbY60mmd
	QaOL1er1tIbRUaEKozHRpIRmzsHn8Hweb/+fk5DysL3gjGYk4k3y9JIckmzvNr84/r7IXZxa
	t6jDuH2gM1JSSue4O7Nfyt8YtwEhIfYkbZgdtvRS84WkxZuXhd50FnL4rYhauUe1YdcWVWuR
	PGjE3jvH0zVYsODi0SThwH6JE9aupFjD+uH+tMrD6HJDyY0PG++cKIwwje9UXuqHIWORFC5k
	cXQ0Zhe4v2/dYuCVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQd1/53dGGfxcKmZxrXchs8Xrf9NZ
	LPac+cVu0bx4PZtF/+ntjBZbb0lbXN41h82iZ8NWVotlm/4wOXB63Nt3mMVj56y77B6bVnWy
	eeyfu4bd4+PTWywefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlfF5Qx9bwQeeihsz7rI2MC7g
	6mLk5JAQMJHYMvMsaxcjF4eQwDpGiQ33ljFBOC8ZJdbMOMoMUsUioCrxbcoVRhCbTUBTYmP3
	NTBbRMBHYvqvNywgDcwCGxklnpxcBNTNwSEskCjxdkUUSA2vgLbEyh+T2SCGzmGUuL54HztE
	QlDix+R7LCA2s4CWxPqdx5kgbGmJR39ngNVwCrhL3Jq+jw3EFhVQkZhychvbBEb+WUjaZyFp
	n4WkfQEj8ypGydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxNjMDw33ZYq28H4/0l8YcYBTgY
	lXh4Z3DsjBJiTSwrrsw9xCjBwawkwpu9FCjEm5JYWZValB9fVJqTWnyIUZqDRUmc93besUgh
	gfTEktTs1NSC1CKYLBMHp1QDY/2SCNGpqxapn7c+IN3/+ePxNotfbomW1fw7MtVVq+bJy/+N
	2KhZk6Y02fpLypwfKf8r3pvVLFITmLe2UP5srurVrxOW1AZYH/ovWOJyKvmR+xKf3rKoLWVe
	AfZBZXuvSZ2Yt8gzp6hyw6/Fy659etXruzd2j5IwX/vfmLOGejoHMq9U9RnJKbEUZyQaajEX
	FScCAIYTWGB7AgAA
X-CMS-MailID: 20180327050046epcas1p16921ee8b21a013f9a344500c45903e50
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2
X-RootMTR: 20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2
References: <CGME20180321043915epcas1p3955f5a57c6728cd1f386f805879fc3f2@epcas1p3.samsung.com>
	<1521607150-31307-1-git-send-email-ji_hun.kim@samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520748173520537?=
X-GMAIL-MSGID: =?utf-8?q?1596065682737429816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 01:39:09PM +0900, Ji-Hun Kim wrote:
> There is no failure checking on the param value which will be allocated
> memory by kmalloc. Add a null pointer checking statement. Then goto error:
> and return -ENOMEM error code when kmalloc is failed.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
> Changes since v1:
>   - Return with -ENOMEM directly, instead of goto error: then return.
>   - [Patch v3 1/2] is same with [patch v2]
> 
>  drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> index 6a3434c..ffcd86d 100644
> --- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> +++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> @@ -1280,6 +1280,9 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>  
>  			params = kmalloc(sizeof(struct ipipe_module_params),
>  					 GFP_KERNEL);
> +			if (!params)
> +				return -ENOMEM;
> +
>  			to = (void *)params + module_if->param_offset;
>  			size = module_if->param_size;
>  
> @@ -1323,6 +1326,9 @@ static int ipipe_g_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>  
>  			params =  kmalloc(sizeof(struct ipipe_module_params),
>  						GFP_KERNEL);
> +			if (!params)
> +				return -ENOMEM;
> +
>  			from = (void *)params + module_if->param_offset;
>  			size = module_if->param_size;
>  
> -- 
> 1.9.1
> 
> 

Are there any opinions? I'd like to know how this patch is going.

Best regards,
Ji-Hun
