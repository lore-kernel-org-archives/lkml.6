Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3210C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA35B218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA35B218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeHNKIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:08:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41845 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731936AbeHNKIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:08:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id s24-v6so9559191edr.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 00:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+UMWxCwxhsdQnIagoEmrsTXUBtubLl10+tKmepO+dC8=;
        b=sPGq2lt7HjViPwq6HC0W+mxfJqcbNyJ4k6gPvpoKbZDn1V46Q5b5gbLCOmVAtGW2cA
         xhHAm2KvY8QgRUJv8ssq/3wZrnHxj7atNpiv27iKFpXIzbfBsuOmAVcog/w5mDXaQHGv
         kvtcKZ5RcA71J4vcLQDDfMO5gQswKMyROtVzUiqXddGgQkp5W46DgpqGB4cbPygNBHRP
         T34ZIiJbHnD9gq/P966J10q2jveESpkpRPAAwmixZZ98p9OdmgKUZMNromKTbU4+87Nr
         /yuygqWElBwqE5bj0+Qaz3D0gOo6EknTSw9f6qaqKnC5q4hhfpaZNWly4PcojUkcDIhO
         43rw==
X-Gm-Message-State: AOUpUlEDHgK3q3OpE5aVDi0MdEHPLR/1rm3gX5XSuCQFqeDhx2pr27hz
        HJESZn1773Sb57lpELoW4GS+egK4TC4=
X-Google-Smtp-Source: AA+uWPzRWMQ3LahwScEplGhs7zHNsRSGZ0kVoziALLUFQM5Spfne0S1ozfyVqPZpbNwaNTYu77V48g==
X-Received: by 2002:a50:c292:: with SMTP id o18-v6mr26783738edf.188.1534231338776;
        Tue, 14 Aug 2018 00:22:18 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g2-v6sm10043110eda.22.2018.08.14.00.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 00:22:18 -0700 (PDT)
Subject: Re: [PATCH] bluetooth: hci_h5: avoid unused variable warnings
To:     Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Jeremy Cline <jeremy@jcline.org>,
        Kees Cook <keescook@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180813220419.4168133-1-arnd@arndb.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <60279ff9-95a7-c2d8-dcd3-6e505c22a0e6@redhat.com>
Date:   Tue, 14 Aug 2018 09:22:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180813220419.4168133-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 14-08-18 00:04, Arnd Bergmann wrote:
> When CONFIG_BT_HCIUART_RTL is disabled, the hci_h5 driver produces a build
> warning because of an incorrect set of #ifdef guards:
> 
> drivers/bluetooth/hci_h5.c:920:22: error: 'rtl_vnd' defined but not used [-Werror=unused-variable]
> 
> Replacing the #ifdef with an IS_ENABLED() check shuts up the error
> and simplifies the logic.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hmm, so now you're counting on dead code elimination to remove
references to unavailable symbols. I'm not sure I like this and
since Marcel has also indicated the does not like this fix I
believe we need another fix.

I will write another fix for this.

Regards,

Hans



> ---
>   drivers/bluetooth/hci_h5.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index 8eede1197cd2..b10e64ba0ff4 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -841,7 +841,6 @@ static void h5_serdev_remove(struct serdev_device *serdev)
>   	hci_uart_unregister_device(&h5->serdev_hu);
>   }
>   
> -#ifdef CONFIG_BT_HCIUART_RTL
>   static int h5_btrtl_setup(struct h5 *h5)
>   {
>   	struct btrtl_device_info *btrtl_dev;
> @@ -923,24 +922,21 @@ static struct h5_vnd rtl_vnd = {
>   	.close		= h5_btrtl_close,
>   	.acpi_gpio_map	= acpi_btrtl_gpios,
>   };
> -#endif
>   
> -#ifdef CONFIG_ACPI
>   static const struct acpi_device_id h5_acpi_match[] = {
> -#ifdef CONFIG_BT_HCIUART_RTL
>   	{ "OBDA8723", (kernel_ulong_t)&rtl_vnd },
> -#endif
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
> -#endif
>   
>   static struct serdev_device_driver h5_serdev_driver = {
>   	.probe = h5_serdev_probe,
>   	.remove = h5_serdev_remove,
>   	.driver = {
>   		.name = "hci_uart_h5",
> -		.acpi_match_table = ACPI_PTR(h5_acpi_match),
> +		.acpi_match_table = (IS_ENABLED(CONFIG_BT_HCIUART_RTL) &&
> +				     IS_ENABLED(CONFIG_ACPI)) ?
> +					h5_acpi_match : 0,
>   	},
>   };
>   
> 
