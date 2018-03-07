Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELt7J7ze0i3vO8qniXgNYiqOrgt3RJmLZoUWOGX7Rha9RYBCMhaMErsQOtB3W4O3oRiA4WGy
ARC-Seal: i=1; a=rsa-sha256; t=1520455495; cv=none;
        d=google.com; s=arc-20160816;
        b=HPf7lcuy7SrO+5OlSzZ0bArUA7gCSqq13jnTlHiRFbayHGJepPEe9cfA8vo0pUuOLH
         9JJar0LULPerWT/cXh8V1DPZvz1z4p/CI8/yNVgzO94kCi51P8xVjgf8Ags8StGUPgmT
         EWtxm1w8/buxPZOPvijI9kvxNKktxNaJTVd2dUeFnrniENjlv+ByHbrVyEnA+KmhU2Y2
         XZCvhjHISZv8Xf0Rm2pVkymIwA6++lqXjz3+8PanbXskd/eP/VE2K20fS1bXevPSzL6v
         tmTi9pyoqd2FQjfMFq0+BHDjE/ZCJw+hYSFI6Q0QFLyoyHwhSZnGD0bfOCKTAWyOK7tF
         Xj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=CwY6JRt5QNS2VMuLIT/7MXEPo2AM3/qmbA3reUizj7w=;
        b=VFFGd80uPw4N7f7DHhKazFs4lWh1NeN5JGT9HTi80p6AiW0CI9+cUO0isMe54TrkfU
         vAjN6tH1E5eeSUuNEFaX9fhLQ45Q3koUPrWrz5ebAI4srlQ+ZgOQt/w3VvI2f226TNPz
         Gm4b2Yd2qzUuCCWjyypaBprvyLzlEW/3vbqUIqTv/MdQLiNb378rWMBVuJQxcxIOUivW
         T4eKd3xrIt3c3unTRFrqbKeSRd1zkTj0F4xB+fYGXbimrT+5Dm9XliqpXuMZsK5j6rGb
         0/Rg90cG5EytYUwBD7gH55jXPoUwRpAMvLU/P5DaoaezzeSuZdd4ZsLBBjUk5LRptbRQ
         fuJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5752133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Wed, 7 Mar 2018 20:44:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 daniel.baluta@gmail.com
Subject: Re: [PATCH 05/11] Staging: iio: accel: Add _REG suffix to registers
Message-ID: <20180307204450.2cc869e6@archlinux>
In-Reply-To: <1520236170-14668-6-git-send-email-himanshujha199640@gmail.com>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
	<1520236170-14668-6-git-send-email-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594083207295076170?=
X-GMAIL-MSGID: =?utf-8?q?1594313141698688024?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon,  5 Mar 2018 13:19:24 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Addition of _REG suffix to the register definitions allows a distinction
> between registers and register fields. The various registers and its field
> bits are grouped together to improve readability and easy indentification.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
This one looks good. I will pick it up once you've tweaked the
predecessor patches.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 133 ++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 445cb56..476b1c3 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -20,75 +20,64 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16201_STARTUP_DELAY_MS	220
> -#define ADIS16201_FLASH_CNT		0x00
> +#define ADIS16201_STARTUP_DELAY_MS				220
> +#define ADIS16201_FLASH_CNT					0x00
>  
>  /* Data Output Register Information */
> -#define ADIS16201_SUPPLY_OUT     0x02
> -#define ADIS16201_XACCL_OUT      0x04
> -#define ADIS16201_YACCL_OUT      0x06
> -#define ADIS16201_AUX_ADC        0x08
> -#define ADIS16201_TEMP_OUT       0x0A
> -#define ADIS16201_XINCL_OUT      0x0C
> -#define ADIS16201_YINCL_OUT      0x0E
> +#define ADIS16201_SUPPLY_OUT_REG				0x02
> +#define ADIS16201_XACCL_OUT_REG					0x04
> +#define ADIS16201_YACCL_OUT_REG					0x06
> +#define ADIS16201_AUX_ADC_REG					0x08
> +#define ADIS16201_TEMP_OUT_REG					0x0A
> +#define ADIS16201_XINCL_OUT_REG					0x0C
> +#define ADIS16201_YINCL_OUT_REG					0x0E
>  
>  /* Calibration Register Definition */
> -#define ADIS16201_XACCL_OFFS     0x10
> -#define ADIS16201_YACCL_OFFS     0x12
> -#define ADIS16201_XACCL_SCALE    0x14
> -#define ADIS16201_YACCL_SCALE    0x16
> -#define ADIS16201_XINCL_OFFS     0x18
> -#define ADIS16201_YINCL_OFFS     0x1A
> -#define ADIS16201_XINCL_SCALE    0x1C
> -#define ADIS16201_YINCL_SCALE    0x1E
> +#define ADIS16201_XACCL_OFFS_REG				0x10
> +#define ADIS16201_YACCL_OFFS_REG				0x12
> +#define ADIS16201_XACCL_SCALE_REG				0x14
> +#define ADIS16201_YACCL_SCALE_REG				0x16
> +#define ADIS16201_XINCL_OFFS_REG				0x18
> +#define ADIS16201_YINCL_OFFS_REG				0x1A
> +#define ADIS16201_XINCL_SCALE_REG				0x1C
> +#define ADIS16201_YINCL_SCALE_REG				0x1E
>  
>  /* Alarm Register Definition */
> -#define ADIS16201_ALM_MAG1       0x20
> -#define ADIS16201_ALM_MAG2       0x22
> -#define ADIS16201_ALM_SMPL1      0x24
> -#define ADIS16201_ALM_SMPL2      0x26
> -#define ADIS16201_ALM_CTRL       0x28
> -
> -#define ADIS16201_AUX_DAC        0x30
> -#define ADIS16201_GPIO_CTRL      0x32
> -#define ADIS16201_MSC_CTRL       0x34
> -
> -#define ADIS16201_SMPL_PRD       0x36
> -#define ADIS16201_AVG_CNT        0x38
> -#define ADIS16201_SLP_CNT        0x3A
> +#define ADIS16201_ALM_MAG1_REG					0x20
> +#define ADIS16201_ALM_MAG2_REG					0x22
> +#define ADIS16201_ALM_SMPL1_REG					0x24
> +#define ADIS16201_ALM_SMPL2_REG					0x26
> +#define ADIS16201_ALM_CTRL_REG					0x28
> +
> +#define ADIS16201_AUX_DAC_REG					0x30
> +#define ADIS16201_GPIO_CTRL_REG					0x32
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define ADIS16201_SMPL_PRD_REG					0x36
> +#define ADIS16201_AVG_CNT_REG					0x38
> +#define ADIS16201_SLP_CNT_REG					0x3A
> +
> +/* Miscellaneous Control Register Definition */
> +#define ADIS16201_MSC_CTRL_REG					0x34
> +#define  ADIS16201_MSC_CTRL_SELF_TEST_EN			BIT(8)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_EN				BIT(2)
> +#define  ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH		BIT(1)
> +#define  ADIS16201_MSC_CTRL_DATA_RDY_DIO1			BIT(0)
>  
>  /* Diagnostics, system status register */
> -#define ADIS16201_DIAG_STAT      0x3C
> +#define ADIS16201_DIAG_STAT_REG					0x3C
> +#define  ADIS16201_DIAG_STAT_ALARM2				BIT(9)
> +#define  ADIS16201_DIAG_STAT_ALARM1				BIT(8)
> +#define  ADIS16201_DIAG_STAT_SPI_FAIL_BIT			3
> +#define  ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT			2
> +#define  ADIS16201_DIAG_STAT_POWER_HIGH_BIT			1
> +#define  ADIS16201_DIAG_STAT_POWER_LOW_BIT			0
>  
>  /* Operation, system command register */
> -#define ADIS16201_GLOB_CMD       0x3E
> -
> -
> -#define ADIS16201_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> -
> -#define ADIS16201_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> -
> -#define ADIS16201_MSC_CTRL_ACTIVE_DATA_RDY_HIGH	        BIT(1)
> -
> -#define ADIS16201_MSC_CTRL_DATA_RDY_DIO1	BIT(0)
> -
> -
> -#define ADIS16201_DIAG_STAT_ALARM2        BIT(9)
> -
> -#define ADIS16201_DIAG_STAT_ALARM1        BIT(8)
> -
> -#define ADIS16201_DIAG_STAT_SPI_FAIL_BIT   3
> -
> -#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT  2
> -
> -#define ADIS16201_DIAG_STAT_POWER_HIGH_BIT 1
> -
> -#define ADIS16201_DIAG_STAT_POWER_LOW_BIT  0
> -
> -#define ADIS16201_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16201_GLOB_CMD_FACTORY	BIT(1)
> +#define ADIS16201_GLOB_CMD_REG					0x3E
> +#define  ADIS16201_GLOB_CMD_SW_RESET				BIT(7)
> +#define  ADIS16201_GLOB_CMD_FACTORY				BIT(1)
>  
> -#define ADIS16201_ERROR_ACTIVE          BIT(14)
> +#define ADIS16201_ERROR_ACTIVE					BIT(14)
>  
>  enum adis16201_scan {
>  	ADIS16201_SCAN_ACC_X,
> @@ -101,10 +90,10 @@ enum adis16201_scan {
>  };
>  
>  static const u8 adis16201_addresses[] = {
> -	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS,
> -	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS,
> -	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS,
> +	[ADIS16201_SCAN_ACC_X] = ADIS16201_XACCL_OFFS_REG,
> +	[ADIS16201_SCAN_ACC_Y] = ADIS16201_YACCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_X] = ADIS16201_XINCL_OFFS_REG,
> +	[ADIS16201_SCAN_INCLI_Y] = ADIS16201_YINCL_OFFS_REG,
>  };
>  
>  static int adis16201_read_raw(struct iio_dev *indio_dev,
> @@ -208,16 +197,16 @@ static int adis16201_write_raw(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_chan_spec adis16201_channels[] = {
> -	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT, ADIS16201_SCAN_SUPPLY, 0, 12),
> -	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT, ADIS16201_SCAN_TEMP, 0, 12),
> -	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT, ADIS16201_SCAN_ACC_X,
> +	ADIS_SUPPLY_CHAN(ADIS16201_SUPPLY_OUT_REG, ADIS16201_SCAN_SUPPLY, 0, 12),
> +	ADIS_TEMP_CHAN(ADIS16201_TEMP_OUT_REG, ADIS16201_SCAN_TEMP, 0, 12),
> +	ADIS_ACCEL_CHAN(X, ADIS16201_XACCL_OUT_REG, ADIS16201_SCAN_ACC_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT, ADIS16201_SCAN_ACC_Y,
> +	ADIS_ACCEL_CHAN(Y, ADIS16201_YACCL_OUT_REG, ADIS16201_SCAN_ACC_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC, ADIS16201_SCAN_AUX_ADC, 0, 12),
> -	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT, ADIS16201_SCAN_INCLI_X,
> +	ADIS_AUX_ADC_CHAN(ADIS16201_AUX_ADC_REG, ADIS16201_SCAN_AUX_ADC, 0, 12),
> +	ADIS_INCLI_CHAN(X, ADIS16201_XINCL_OUT_REG, ADIS16201_SCAN_INCLI_X,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
> -	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT, ADIS16201_SCAN_INCLI_Y,
> +	ADIS_INCLI_CHAN(X, ADIS16201_YINCL_OUT_REG, ADIS16201_SCAN_INCLI_Y,
>  			BIT(IIO_CHAN_INFO_CALIBBIAS), 0, 14),
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
> @@ -237,9 +226,9 @@ static const char * const adis16201_status_error_msgs[] = {
>  
>  static const struct adis_data adis16201_data = {
>  	.read_delay = 20,
> -	.msc_ctrl_reg = ADIS16201_MSC_CTRL,
> -	.glob_cmd_reg = ADIS16201_GLOB_CMD,
> -	.diag_stat_reg = ADIS16201_DIAG_STAT,
> +	.msc_ctrl_reg = ADIS16201_MSC_CTRL_REG,
> +	.glob_cmd_reg = ADIS16201_GLOB_CMD_REG,
> +	.diag_stat_reg = ADIS16201_DIAG_STAT_REG,
>  
>  	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
