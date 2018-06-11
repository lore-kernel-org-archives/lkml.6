Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fLdhFiQBHlsgQgAAmS7hNA
	; Mon, 11 Jun 2018 04:57:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3000C601D2; Mon, 11 Jun 2018 04:57:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZbCWxHW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9AB8960351;
	Mon, 11 Jun 2018 04:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9AB8960351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeFKE5F (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 00:57:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54322 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753875AbeFKE5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 00:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VOqS9g23yn9EAcYZ/9FXbV9SL/UDzrBfVZEqizhUZds=; b=DZbCWxHWEIGJUAHEEdF976hqAx
        PlRFv7XTEDUU0owhimEYxhAhYVzOB+duVdBiFN2aFm/zNMVciKAsGmbx3HFCg/jk3aXM+pvmywgZ7
        CAQMiGzNB+T0Ooz1TXVCMH7EQ6Z5wcfuU5XWDYOpjUTvzvJwXw7TMGI6RwH2TAEXjRKkOFESYkKs5
        +TzLjcoTf9YunxNkYSLzdtnYfozEVw/jIa74XRj8uZ25jywr/3zhYk/bgTf3y31LWyE2fqH4q2TLw
        JTumgBUiqM2gdWi3/+PNnaDPHGX74a42fNJiuDsZQOBUYCG9Z6DBMYScsl15INzhsZrKkkwGLKssb
        B7BEEGPw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSEsC-0003yC-E1; Mon, 11 Jun 2018 04:56:09 +0000
Subject: Re: [PATCH] optoe: driver to read/write SFP/QSFP EEPROMs
To: Don Bollinger <don@thebollingers.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: brandon_chuang@edge-core.com, wally_wang@accton.com,
        roy_lee@edge-core.com, rick_burchett@edge-core.com,
        quentin.chang@quantatw.com, jeffrey.townsend@bitswitch.com,
        scotte@cumulusnetworks.com, roopa@cumulusnetworks.com,
        David Ahern <dsa@cumulusnetworks.com>,
        luke.williams@canonical.com, Guohan Lu <gulv@microsoft.com>,
        Xin Liu <xinxliu@microsoft.com>, steve.joiner@finisar.com
References: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <37dfd504-5921-54f2-b90e-a26595fc0a5e@infradead.org>
Date: Sun, 10 Jun 2018 21:56:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611042515.ml6zbcmz6dlvjmrp@thebollingers.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/10/2018 09:25 PM, Don Bollinger wrote:
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 68a1ac929917..9a08e12756ee 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -111,4 +111,22 @@ config EEPROM_IDT_89HPESX
>  	  This driver can also be built as a module. If so, the module
>  	  will be called idt_89hpesx.
>  
> +config EEPROM_OPTOE
> +	tristate "read/write access to SFP* & QSFP* EEPROMs"
> +	depends on I2C && SYSFS
> +	help
> +	  If you say yes here you get support for read and write access to
> +	  the EEPROM of SFP and QSFP type optical and copper transceivers.
> +	  Includes all devices which conform to the sff-8436 and sff-8472

	  This includes
and then please s/sff/SFF/ (2 places).

> +	  spec including SFP, SFP+, SFP28, SFP-DWDM, QSFP, QSFP+, QSFP28
> +	  or later.  These devices are usually found in network switches.
> +
> +	  This driver only manages read/write access to the EEPROM, all
> +	  other features should be accessed via i2c-dev.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called optoe.
> +
> +	  If unsure, say N.
> +
>  endmenu

thanks,
-- 
~Randy
