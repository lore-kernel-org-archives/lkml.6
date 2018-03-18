Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELsvykDYnC1vZQiUD8E1L+VwWgEEARVaBnMETzI4XmHcmuSayDv+GrFIdb1i7kVOnNGdawhh
ARC-Seal: i=1; a=rsa-sha256; t=1521361196; cv=none;
        d=google.com; s=arc-20160816;
        b=LpiogKxEhGna/qlOopV13lK8WjwrL+rrvcKdNolhjFY6EGx3yTu1XzhfJscpM/YR3k
         sYZ3zHDcmW0pvrjCvXLXGoLfS+x395T28mrcFAzTQOuxwj28Ajwws65AbmyufpZhnORV
         KJrofTx8/fWmeS3cSqRjeJ97z+fjsv8+vdzfA+eZ7ih8MjBcV3KteeEOTVfm52rpu6l2
         ElmHUOjX7q6clAL1/vxVDsh75rsukrYrU8TRSbQoQVq/NHceQ5d3Xk+2OnCR0jymY+jF
         a2Y/x1r9ykuNSuvLjRJccvmdh2FaxoN6zBT7Ein41O4j/KMf1Pe6iUhXyginkrj4AKPs
         FT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=UD/Ghuy+gM6yhFV41Lh9zEkPnOKp2pNu6XL0yDipRMs=;
        b=wPcMDyqzqRf5b7ccbzNQMFAo25P2JdCnykEgqykTNs0zp3VH4Gyu7wBg1dR/4tt71L
         vDbtKF+GzOjqw5AWG9CJ1jzUHJIGeEu8m7BCjVThwJu9DLBK4StJny0PixwnYLOnUmCu
         5tqMoFfTkaczb2TDYBhyqdgtl2QyEFC6+3UfjacgV4vC2J56GJlRfTGA0O/SmmLt8oO5
         1mpVDiO6QUS05F2EJgU6+0FFpMyaF1FnrP5k2u96vwrtpHNZU6j3qrvz8bqCLdHvZGNf
         0YpgrcsE8lOa8MR18fSW8gyvUbHtUyPBTcW+pUJU+O3O2m0z6y6RSJi/tXH3K3Ez7Ukd
         aIHg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A70720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 08:19:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 daniel.baluta@gmail.com, 21cnbao@gmail.com
Subject: Re: [PATCH v2 1/9] Staging: iio: accel: adis16201: Rename few macro
 definitions
Message-ID: <20180318081950.71f465bb@archlinux>
In-Reply-To: <1521230786-18155-2-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
	<1521230786-18155-2-git-send-email-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595126123635195009?=
X-GMAIL-MSGID: =?utf-8?q?1595262838465596495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 01:36:18 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Rename the macro definitions with suitable names specifying their
> purpose.
> 
> * ADIS16201_STARTUP_DELAY_MS: Remove the comment specifying the delay in
>   microseconds and rename it with addtition of _MS suffix.
> 
> * ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH: Rename the macro to make it
>   similar to other misc control registers which denotes the data ready
>   polarity.
> 
> * ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT: Rename to denote it is a
>   failure bit.
> 
> * ADIS16201_GLOB_CMD_FACTORY_RESET: Remove ambiguous _CAL suffix and add
>   _RESET suffix instead to denote factory reset command.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Nicely described and well put together patch.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> v2:
>    -explained every change in the process of renaming macros. 
> 
>  drivers/staging/iio/accel/adis16201.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 0fae8aa..767ebf0 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,7 +20,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY	220 /* ms */
> +#define ADIS16201_STARTUP_DELAY_MS	220
>  
>  /* Flash memory write count */
>  #define ADIS16201_FLASH_CNT      0x00
> @@ -118,7 +118,7 @@
>  #define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
>  
>  /* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16201_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
>  
>  /* Data-ready line selection: 1 = DIO1, 0 = DIO0 */
>  #define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
> @@ -135,7 +135,7 @@
>  #define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
>  
>  /* Flash update failure */
> -#define ADIS16201_DIAG_STAT_FLASH_UPT_BIT  2
> +#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
>  
>  /* Power supply above 3.625 V */
>  #define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
> @@ -146,7 +146,7 @@
>  /* GLOB_CMD */
>  
>  #define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16201_GLOB_CMD_FACTORY_CAL	BIT(1)
> +#define ADIS16201_GLOB_CMD_FACTORY_RESET	BIT(1)
>  
>  #define ADIS16201_ERROR_ACTIVE          BIT(14)
>  
> @@ -290,7 +290,7 @@ static const struct iio_info adis16201_info = {
>  
>  static const char * const adis16201_status_error_msgs[] = {
>  	[ADIS16201_DIAG_STAT_SPI_FAIL_BIT] = "SPI failure",
> -	[ADIS16201_DIAG_STAT_FLASH_UPT_BIT] = "Flash update failed",
> +	[ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT] = "Flash update failed",
>  	[ADIS16201_DIAG_STAT_POWER_HIGH_BIT] = "Power supply above 3.625V",
>  	[ADIS16201_DIAG_STAT_POWER_LOW_BIT] = "Power supply below 3.15V",
>  };
> @@ -303,11 +303,11 @@ static const struct adis_data adis16201_data = {
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16201_STARTUP_DELAY,
> +	.startup_delay = ADIS16201_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16201_status_error_msgs,
>  	.status_error_mask = BIT(ADIS16201_DIAG_STAT_SPI_FAIL_BIT) |
> -		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_BIT) |
> +		BIT(ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT) |
>  		BIT(ADIS16201_DIAG_STAT_POWER_HIGH_BIT) |
>  		BIT(ADIS16201_DIAG_STAT_POWER_LOW_BIT),
>  };
