Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4004FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC1A20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 13:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkvrfFpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC1A20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbeFUNFi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 09:05:38 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46543 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933091AbeFUNFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 09:05:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so1512120pff.13;
        Thu, 21 Jun 2018 06:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2uaLy1MMq803Eg063vahB8go8u53tGlbAKXX9msUqys=;
        b=bkvrfFpctt/schzLX1OV5W/plvdmvbF7O0m50n/CZDg6ELuk4g/i2b7mvvdCoaNLAA
         WyEMegf/1+UIYU6VnP4Vd3Y8VHWGeFIfTmy71VHWh+m9qABJvygxRENZOJpGuS+fFWHe
         nchW8i7ZNp+/2qtG0WY0gKVZdioU6Nhc630vOZtdhh2wD2qPRq9Iei/In2L6TAZGdrgu
         n7Kzye4eQB6fJdur1mTfyfiMRISxdXimL2uN9TSe+H7MhGqzuVhlWUZDZ4QiTgCPYopk
         FH/VOXoenWKg1MYZrQ8YaL9UcSeyVsGTIsmfcUQ5+1TXPTwPGYME+wto79ZPf20rmafM
         bTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2uaLy1MMq803Eg063vahB8go8u53tGlbAKXX9msUqys=;
        b=Gl+ocvKtwwffoMlNDecWLeZxs+hqtPJBfCDAa+7yKnHNi2okOUlwPy4HWhi57WNbpo
         gAnO/31zW2pKOsliqqil0EJdeOEmxV2kZgNAZ3okuz8H23n87PdXAOp7Os60yNuEzps7
         PzD8eUROMBOcBjYdevCArB3cQOhmycZ2lARHBvwJ89uM1gcqxFlXk3ARDKMoz8o7UfQX
         owgAhHsIXcMK1gY7CflOfpvChrqn1T6j5HNM93MebaUkXeTzHhfmOYWTCIwpZXw28ePS
         rQh6JNt6jiB1FOTv63HOneRmm0NHpDIUE5hhsww7qkjae/4ZlWWVnYImIP+OyEv/VZHQ
         rsqQ==
X-Gm-Message-State: APt69E28T4hL4L3UfeMRMvPKLcT/mDYbePEYkkV0oMhTmzk4aGA4JpTF
        +KLAKd1hrSZkovT1LzJ+H94=
X-Google-Smtp-Source: ADUXVKIYGxyNmopVzzNBr1r+Zq479UkG9+WANT6o89ZLlIcw1P0BCHaScDCqt6TL7MvR2LhTIYAbqw==
X-Received: by 2002:a65:47cc:: with SMTP id f12-v6mr22507270pgs.173.1529586336137;
        Thu, 21 Jun 2018 06:05:36 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s27-v6sm11226987pfk.184.2018.06.21.06.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 06:05:35 -0700 (PDT)
Subject: Re: [PATCH] staging/typec: fix tcpci_rt1711h build errors
To:     Randy Dunlap <rdunlap@infradead.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        kbuild-all@01.org
References: <f344e5f3-4e92-1fd0-ef4d-7b96065466b8@infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <ed3064c8-d0b3-10c4-2eaa-ef50762e7756@roeck-us.net>
Date:   Thu, 21 Jun 2018 06:05:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <f344e5f3-4e92-1fd0-ef4d-7b96065466b8@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 05:05 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix Kconfig warning and build errors in staging/typec/rt1711h.c.
> The driver uses I2C interfaces so it should depend on I2C.
> 
> WARNING: unmet direct dependencies detected for TYPEC_TCPCI
>    Depends on [m]: STAGING [=y] && TYPEC_TCPM [=y] && I2C [=m]
>    Selected by [y]:
>    - TYPEC_RT1711H [=y] && STAGING [=y] && TYPEC_TCPM [=y]
> 
> and then:
> drivers/staging/typec/tcpci.o: In function `tcpci_probe':
> ../drivers/staging/typec/tcpci.c:536: undefined reference to `__devm_regmap_init_i2c'
> drivers/staging/typec/tcpci.o: In function `tcpci_i2c_driver_init':
> ../drivers/staging/typec/tcpci.c:593: undefined reference to `i2c_register_driver'
> drivers/staging/typec/tcpci.o: In function `tcpci_i2c_driver_exit':
> ../drivers/staging/typec/tcpci.c:593: undefined reference to `i2c_del_driver'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_check_revision':
> ../drivers/staging/typec/tcpci_rt1711h.c:218: undefined reference to `i2c_smbus_read_word_data'
> ../drivers/staging/typec/tcpci_rt1711h.c:225: undefined reference to `i2c_smbus_read_word_data'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_probe':
> ../drivers/staging/typec/tcpci_rt1711h.c:251: undefined reference to `__devm_regmap_init_i2c'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_i2c_driver_init':
> ../drivers/staging/typec/tcpci_rt1711h.c:308: undefined reference to `i2c_register_driver'
> drivers/staging/typec/tcpci_rt1711h.o: In function `rt1711h_i2c_driver_exit':
> ../drivers/staging/typec/tcpci_rt1711h.c:308: undefined reference to `i2c_del_driver'
> 
> Fixes: ce08eaeb6388 ("staging: typec: rt1711h typec chip driver")
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: kbuild-all@01.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/staging/typec/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- lnx-418-rc1.orig/drivers/staging/typec/Kconfig
> +++ lnx-418-rc1/drivers/staging/typec/Kconfig
> @@ -11,6 +11,7 @@ config TYPEC_TCPCI
>   
>   config TYPEC_RT1711H
>   	tristate "Richtek RT1711H Type-C chip driver"
> +	depends on I2C
>   	select TYPEC_TCPCI
>   	help
>   	  Richtek RT1711H Type-C chip driver that works with
> 
> 
> 

