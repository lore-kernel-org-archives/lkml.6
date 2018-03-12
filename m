Return-Path: <kernel-hardening-return-12455-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELv7jyt6q3jzW5KVQZ9ut4Bkz6B+P3g3mh4AhFlfleLF2cqvxPEDEBCGifW3CSpbjkwsWXM3
ARC-Seal: i=1; a=rsa-sha256; t=1520858985; cv=none;
        d=google.com; s=arc-20160816;
        b=YUm70aQ4ZsgxqmdR9a62vtqgokQ4+i2KaRgzZ3Wma2bDHUtGp5RHc8OOdJdIb6CDZ+
         ThXN/qb8y5OYMrAFgdYB6sBVCCw4ALTyOzSuDU0wo40lASl0y/FnLv8+hTiA5gRvgiFJ
         Fp5hIMitw45JT2shc5kazVZpyhc2KYm3swXKNlVwp0VBm5HI2KY1rXDtuJ3uuae6+A78
         w4pyF9uxeMsf8+OhjoV22jTkWnd74TB+YN3IoEFYY+hB8w2kU7n9XibELu4/s+Yb0ySH
         UUn3/b+iF+SY9NaoI6SDALwGifzjSI7ROcFchTBfWy3nXlQ3LzfVZ/zFp8r3ONIxMI9w
         xxaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=qFmRZ4InlsOIi+TUyCUrQpTQhnr06YdhUplOMDsgPew=;
        b=J9Njm6Wae0IWKG3S5ct5DlBLFpaVNURjtqXkiyfo8rs7gQuqiERz2t6xzTfCfL2GDu
         X70P4W/E8kDpBWbYpdLDj+uMbR3HvweyvTiu6Pn9olJDS23fOgOGQ4L37gk3jC7mShRf
         W8zqbrZwNanwsdtZaLI0gO2x9L+vx+j53k6OvAy5RBT5msWFG0w57NIb2K8oIY8g5V84
         sjZRbx3I+Gnt0r7eotNbZyqsz4lJsZt1Iqg1eNhsubvDY+g6eNXvVOgOK1fEHzS9Ju/a
         6oClHTiOec5LYOU/X4zX9g6gp4ItN1nq4UlS3F5KAz7FcM0Rick95qEcKSpWPwa/MH5q
         VzPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12455-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12455-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12455-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12455-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: EXT: [PATCH 3/4] gpio: Remove VLA from xra1403 driver
To: Laura Abbott <labbott@redhat.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>, Semi Malinen
	<semi.malinen@ge.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>
References: <20180310001021.6437-1-labbott@redhat.com>
 <20180310001021.6437-4-labbott@redhat.com>
From: Nandor Han <nandor.han@ge.com>
Message-ID: <2ba65a3e-3bc9-d709-caf9-f0c512d718a3@ge.com>
Date: Mon, 12 Mar 2018 08:06:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001021.6437-4-labbott@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [3.159.212.192]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1803120071
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594736231408516491?=
X-GMAIL-MSGID: =?utf-8?q?1594736231408516491?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10/03/18 02:10, Laura Abbott wrote:
> 
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621)
> 
> This patch replaces a VLA with an appropriate call to kmalloc_array.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---

This looks good to me.
Reviewed-by: Nandor Han <nandor.han@ge.com>

Nandor

>   drivers/gpio/gpio-xra1403.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-xra1403.c b/drivers/gpio/gpio-xra1403.c
> index 0230e4b7a2fb..8d4c8e99b251 100644
> --- a/drivers/gpio/gpio-xra1403.c
> +++ b/drivers/gpio/gpio-xra1403.c
> @@ -126,11 +126,16 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>   {
>   	int reg;
>   	struct xra1403 *xra = gpiochip_get_data(chip);
> -	int value[xra1403_regmap_cfg.max_register];
> +	int *value;
>   	int i;
>   	unsigned int gcr;
>   	unsigned int gsr;
>   
> +	value = kmalloc_array(xra1403_regmap_cfg.max_register, sizeof(*value),
> +				GFP_KERNEL);
> +	if (!value)
> +		return;
> +
>   	seq_puts(s, "xra reg:");
>   	for (reg = 0; reg <= xra1403_regmap_cfg.max_register; reg++)
>   		seq_printf(s, " %2.2x", reg);
> @@ -154,6 +159,7 @@ static void xra1403_dbg_show(struct seq_file *s, struct gpio_chip *chip)
>   			   (gcr & BIT(i)) ? "in" : "out",
>   			   (gsr & BIT(i)) ? "hi" : "lo");
>   	}
> +	kfree(value);
>   }
>   #else
>   #define xra1403_dbg_show NULL
> 
