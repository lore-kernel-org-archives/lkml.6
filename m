Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAB6ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B47B208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 20:40:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B47B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeJGDpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 23:45:06 -0400
Received: from gateway30.websitewelcome.com ([192.185.146.7]:13197 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbeJGDpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 23:45:05 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 84A6C1118C
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 15:40:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 8tN7gqGvC79N38tN7gxHQt; Sat, 06 Oct 2018 15:40:21 -0500
X-Authority-Reason: nr=8
Received: from 174.206.93.92.rev.sfr.net ([92.93.206.174]:44748 helo=[192.168.43.69])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1g8tN7-004LGi-1Z; Sat, 06 Oct 2018 15:40:21 -0500
To:     Maxime Desroches <desroches.maxime@gmail.com>,
        gregkhl@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180929020300.23321-1-desroches.maxime@gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] Staging: rts5208: rtsx_card: Fixed multiple coding style
 issues
Message-ID: <98626de4-3914-7c8d-047d-84cd4a339073@embeddedor.com>
Date:   Sat, 6 Oct 2018 22:40:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180929020300.23321-1-desroches.maxime@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 92.93.206.174
X-Source-L: No
X-Exim-ID: 1g8tN7-004LGi-1Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 174.206.93.92.rev.sfr.net ([192.168.43.69]) [92.93.206.174]:44748
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/29/18 4:03 AM, Maxime Desroches wrote:
> Fixed multiple coding style issues
> 

What kind of style issues are you trying to fix?

Please, always be specific about what you are trying to fix. This makes
it easier for the maintainers to review your patch and give you feedback.

Thanks
--
Gustavo

> Signed-off-by: Maxime Desroches <desroches.maxime@gmail.com>
> ---
>  drivers/staging/rts5208/rtsx_card.c | 96 +++++++++++------------------
>  1 file changed, 37 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_card.c b/drivers/staging/rts5208/rtsx_card.c
> index d26a8e372fce..b45abbe29bc2 100644
> --- a/drivers/staging/rts5208/rtsx_card.c
> +++ b/drivers/staging/rts5208/rtsx_card.c
> @@ -647,9 +647,8 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
>  	dev_dbg(rtsx_dev(chip), "Switch SSC clock to %dMHz (cur_clk = %d)\n",
>  		clk, chip->cur_clk);
>  
> -	if ((clk <= 2) || (n > max_n)) {
> +	if ((clk <= 2) || (n > max_n))
>  		return STATUS_FAIL;
> -	}
>  
>  	mcu_cnt = (u8)(125 / clk + 3);
>  	if (mcu_cnt > 7)
> @@ -688,15 +687,13 @@ int switch_ssc_clock(struct rtsx_chip *chip, int clk)
>  	}
>  
>  	retval = rtsx_send_cmd(chip, 0, WAIT_TIME);
> -	if (retval < 0) {
> +	if (retval < 0)
>  		return STATUS_ERROR;
> -	}
>  
>  	udelay(10);
>  	retval = rtsx_write_register(chip, CLK_CTL, CLK_LOW_FREQ, 0);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	chip->cur_clk = clk;
>  
> @@ -790,49 +787,44 @@ int switch_normal_clock(struct rtsx_chip *chip, int clk)
>  	}
>  
>  	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, CLK_LOW_FREQ);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  	if (sd_vpclk_phase_reset) {
>  		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
>  					     PHASE_NOT_RESET, 0);
> -		if (retval) {
> +		if (retval)
>  			return retval;
> -		}
> +
>  		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
>  					     PHASE_NOT_RESET, 0);
> -		if (retval) {
> +		if (retval)
>  			return retval;
> -		}
>  	}
>  	retval = rtsx_write_register(chip, CLK_DIV, 0xFF,
>  				     (div << 4) | mcu_cnt);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  	retval = rtsx_write_register(chip, CLK_SEL, 0xFF, sel);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	if (sd_vpclk_phase_reset) {
>  		udelay(200);
>  		retval = rtsx_write_register(chip, SD_VPCLK0_CTL,
>  					     PHASE_NOT_RESET, PHASE_NOT_RESET);
> -		if (retval) {
> +		if (retval)
>  			return retval;
> -		}
> +
>  		retval = rtsx_write_register(chip, SD_VPCLK1_CTL,
>  					     PHASE_NOT_RESET, PHASE_NOT_RESET);
> -		if (retval) {
> +		if (retval)
>  			return retval;
> -		}
> +
>  		udelay(200);
>  	}
>  	retval = rtsx_write_register(chip, CLK_CTL, 0xFF, 0);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	chip->cur_clk = clk;
>  
> @@ -878,9 +870,8 @@ int enable_card_clock(struct rtsx_chip *chip, u8 card)
>  		clk_en |= MS_CLK_EN;
>  
>  	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, clk_en);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	return STATUS_SUCCESS;
>  }
> @@ -898,9 +889,8 @@ int disable_card_clock(struct rtsx_chip *chip, u8 card)
>  		clk_en |= MS_CLK_EN;
>  
>  	retval = rtsx_write_register(chip, CARD_CLK_EN, clk_en, 0);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	return STATUS_SUCCESS;
>  }
> @@ -924,9 +914,8 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
>  	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, mask, val1);
>  
>  	retval = rtsx_send_cmd(chip, 0, 100);
> -	if (retval != STATUS_SUCCESS) {
> +	if (retval != STATUS_SUCCESS)
>  		return STATUS_FAIL;
> -	}
>  
>  	udelay(chip->pmos_pwr_on_interval);
>  
> @@ -934,9 +923,8 @@ int card_power_on(struct rtsx_chip *chip, u8 card)
>  	rtsx_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, mask, val2);
>  
>  	retval = rtsx_send_cmd(chip, 0, 100);
> -	if (retval != STATUS_SUCCESS) {
> +	if (retval != STATUS_SUCCESS)
>  		return STATUS_FAIL;
> -	}
>  
>  	return STATUS_SUCCESS;
>  }
> @@ -955,9 +943,8 @@ int card_power_off(struct rtsx_chip *chip, u8 card)
>  	}
>  
>  	retval = rtsx_write_register(chip, CARD_PWR_CTL, mask, val);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	return STATUS_SUCCESS;
>  }
> @@ -969,9 +956,8 @@ int card_rw(struct scsi_cmnd *srb, struct rtsx_chip *chip,
>  	unsigned int lun = SCSI_LUN(srb);
>  	int i;
>  
> -	if (!chip->rw_card[lun]) {
> +	if (!chip->rw_card[lun])
>  		return STATUS_FAIL;
> -	}
>  
>  	for (i = 0; i < 3; i++) {
>  		chip->rw_need_retry = 0;
> @@ -1009,36 +995,33 @@ int card_share_mode(struct rtsx_chip *chip, int card)
>  
>  	if (CHECK_PID(chip, 0x5208)) {
>  		mask = CARD_SHARE_MASK;
> -		if (card == SD_CARD) {
> +		if (card == SD_CARD)
>  			value = CARD_SHARE_48_SD;
> -		} else if (card == MS_CARD) {
> +		else if (card == MS_CARD)
>  			value = CARD_SHARE_48_MS;
> -		} else if (card == XD_CARD) {
> +		else if (card == XD_CARD)
>  			value = CARD_SHARE_48_XD;
> -		} else {
> +		else
>  			return STATUS_FAIL;
> -		}
>  
>  	} else if (CHECK_PID(chip, 0x5288)) {
>  		mask = 0x03;
> -		if (card == SD_CARD) {
> +		if (card == SD_CARD)
>  			value = CARD_SHARE_BAROSSA_SD;
> -		} else if (card == MS_CARD) {
> +		else if (card == MS_CARD)
>  			value = CARD_SHARE_BAROSSA_MS;
> -		} else if (card == XD_CARD) {
> +		else if (card == XD_CARD)
>  			value = CARD_SHARE_BAROSSA_XD;
> -		} else {
> +		else
>  			return STATUS_FAIL;
> -		}
>  
>  	} else {
>  		return STATUS_FAIL;
>  	}
>  
>  	retval = rtsx_write_register(chip, CARD_SHARE_MODE, mask, value);
> -	if (retval) {
> +	if (retval)
>  		return retval;
> -	}
>  
>  	return STATUS_SUCCESS;
>  }
> @@ -1050,30 +1033,26 @@ int select_card(struct rtsx_chip *chip, int card)
>  	if (chip->cur_card != card) {
>  		u8 mod;
>  
> -		if (card == SD_CARD) {
> +		if (card == SD_CARD)
>  			mod = SD_MOD_SEL;
> -		} else if (card == MS_CARD) {
> +		else if (card == MS_CARD)
>  			mod = MS_MOD_SEL;
> -		} else if (card == XD_CARD) {
> +		else if (card == XD_CARD)
>  			mod = XD_MOD_SEL;
> -		} else if (card == SPI_CARD) {
> +		else if (card == SPI_CARD)
>  			mod = SPI_MOD_SEL;
> -		} else {
> +		else
>  			return STATUS_FAIL;
> -		}
>  
>  		retval = rtsx_write_register(chip, CARD_SELECT, 0x07, mod);
> -		if (retval) {
> +		if (retval)
>  			return retval;
> -		}
>  		chip->cur_card = card;
>  
>  		retval =  card_share_mode(chip, card);
> -		if (retval != STATUS_SUCCESS) {
> +		if (retval != STATUS_SUCCESS)
>  			return STATUS_FAIL;
> -		}
>  	}
> -
>  	return STATUS_SUCCESS;
>  }
>  
> @@ -1120,9 +1099,8 @@ int detect_card_cd(struct rtsx_chip *chip, int card)
>  	}
>  
>  	status = rtsx_readl(chip, RTSX_BIPR);
> -	if (!(status & card_cd)) {
> +	if (!(status & card_cd))
>  		return STATUS_FAIL;
> -	}
>  
>  	return STATUS_SUCCESS;
>  }
> 
