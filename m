Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2684992-1520536289-2-3077831847767912882
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520536288; b=Sd1HR70HAL2htxYe1vbnQhFInbFJf9tIQYYvZOwU4xVrCFh
    42Gs9Jf+tDMUs65bXQspcoI9NSoTE1YO4d3TObUFXnYYSzDtGWVByGMPiTSFhCRq
    BsyN+iiyrFAOdlAi0yANzLhuargqAx+2iGXq3ZRl5OaceD9dvxes6PKvYWDtR4fb
    xu2Z6zStm7tmaGR1uAFdiC9RxT0ejMReyYdQ5M0SIVXowqoAP7AVdaK+JQRiH09X
    XcgMDi7eQkpNNdyAqreYX5Hj7Hr52Y0V0TyilSFOn7nVLHy4ep73wLKekbpwL9HR
    RKl0DojzX9ML9J3MVtkOj+UhRIFeYKQVY2yQBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520536288; bh=5
    ss+VbbGfUmJJIu3hImxaq4kd9y1brYthKSA+qR5RzU=; b=XST+5eC6Dy7LwSOlC
    jLecvX/49KCbelLauVNmuVdi+3wu6T9lKyv6UcI8/52za+6zBrOdPT3Gk5wc5tYl
    XVv0WKetzVzIvcVA1Cmu5VeNE+lvUanS0ZhuGo8M+BA0u7yAHt9Qp+1aUFRCuzRM
    QPyRwiScwfnWkDbPPFcjVXugkolMH/fm1LK0FDrz7V4/c6IEYVlUJ4wRFiP7LA5i
    GiXbUIZhd7DhTHG3jYlfrttCyy0Y0m7aNJC2PaOGmdFHQrlVfS7enRK44NLFtmgw
    i7SOjgfVjh0baesNZKGiEQRRa3L8/YMujM/dGCyaTRBYT0Bzlt0u1hrkQmdlOu4g
    8gnsw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iTUdyrKO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BJtOd4K0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iTUdyrKO x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BJtOd4K0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt1YDwZsNKIK5BlaYqfk92GaqpT88e/jaj/bTCbdtkMMI2hLWFZx1Mc3OcdTVbrjUJ9bSDN6Q==
Date: Fri, 9 Mar 2018 00:41:12 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH v4] Staging: iio: adis16209: Change some macro names
Message-ID: <20180308191111.GA2041@himanshu-Vostro-3559>
References: <1520532977-10653-1-git-send-email-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520532977-10653-1-git-send-email-shreeya.patel23498@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
 knaack.h@gmx.de, jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 11:46:17PM +0530, Shreeya Patel wrote:
> Make some of the macro names according to the names
> given in the datasheet of the adis16209 driver and
> have slight indentation in field definitions to make
> them clearly different from the register addresses.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
> 
> Changes in v4
>   -Have slight indentation in field definitions.
> 
>  drivers/staging/iio/accel/adis16209.c | 48 +++++++++++++++++------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index eb5c878..19636e2 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -68,21 +68,21 @@
>  #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>  #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>  
> -#define ADIS16209_STAT_REG			0x3C
> -#define  ADIS16209_STAT_ALARM2			BIT(9)
> -#define  ADIS16209_STAT_ALARM1			BIT(8)
> -#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> -#define ADIS16209_STAT_SPI_FAIL_BIT		3
> -#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
> +#define ADIS16209_DIAG_STAT_REG			0x3C
> +#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
> +#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
> +#define  ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> +#define  ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2

#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT    2
?
It represents flash update fail bit!

-- 
Thanks
Himanshu Jha
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
