Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B09CEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E72089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sssua68m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8E72089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754319AbeFLS4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:56:36 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43724 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbeFLS4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:56:34 -0400
Received: by mail-lf0-f67.google.com with SMTP id n15-v6so9061lfn.10;
        Tue, 12 Jun 2018 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=F45+7eMwaB1PS2GbhzxNHdboD5CR51q523s4loyzq/c=;
        b=Sssua68mOWqq7dw+0NB4Sfeb4R7EHYtS7Ez0znsS5tInVYafJLqbIb8OIRZAL8XAze
         tmfvLXeLZfZTsVCScaXf/iP4+Cu0f1EGNgCu/E42E9VvBLDuNd6Itz+VUzABfJZFi7I4
         r95wc9oMvpwFNKSX/KryajdgIhx4Leqif04Gi/UE9sSYwf1IfNIz+pfd+zyETy7OWrNy
         UTyBifNQMMA1Bb0qpLvs5VaM5CbMOYD5NkrivSPzfVoTPrmbnK/XWJ6s3TEaB0GuRj4F
         0g9bZ6n6XJzY+w2uOmHI69WHxkwy/ozU6j1BmkU2fXxqXAq3oAGHLxLFEzwXG3kbk5cv
         WWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F45+7eMwaB1PS2GbhzxNHdboD5CR51q523s4loyzq/c=;
        b=umqNHyiCdQfIPoPV0+WLqLKrJobFvddG+yPmKBgpw+9t+tzfG4+gcEBrZfG89uUaYD
         zAw8kIuWletbiVnusHJ1kMI3Xgje5EXnhR/ynJCp9vjg5HD84LsEPP97tQuAVXnAJXwf
         AWIjR7e0n3GubIMffeHUeLOAwxTTur0hUiAWEkWRbVz7Ci4UL99mtF1xgA/mqHjztKs3
         /pfVKA8+nITUr0JBkWCgScp9Zm6z0V/TuwGnmq2FRqDgXOuEmxR7BDr6LiD1LjGBjFvB
         dsTPTnoCgXr0bsF6/QTD9jUTaRHkiSTIrKYJbQhMv4BqIuGTEEINFiGZbJV4TlFH9FfM
         oVBA==
X-Gm-Message-State: APt69E2cPMoQ5PTdKllUNuDNFxmQZgki/MiJAwTii/++Mk63xfMOL9IL
        dHQ/hbC2l8sXcdDdD7Ch0EDaKuFH
X-Google-Smtp-Source: ADUXVKIeU2wHEWbSb6FmPiN4TImBo9eNkDEVINxGpBIlshKDqZPuQ6am01MyeSaQLQv+H+u3yIX94w==
X-Received: by 2002:a19:1714:: with SMTP id n20-v6mr906831lfi.54.1528829792732;
        Tue, 12 Jun 2018 11:56:32 -0700 (PDT)
Received: from [192.168.1.232] ([195.84.96.49])
        by smtp.gmail.com with ESMTPSA id y20-v6sm154751lfe.40.2018.06.12.11.56.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 11:56:32 -0700 (PDT)
Subject: Re: [RFC PATCH v4 2/8] usb: typec: helper for checking cable plug
 orientation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-3-heikki.krogerus@linux.intel.com>
From:   Mats Karrman <mats.dev.list@gmail.com>
Message-ID: <595c8953-040a-5697-0f79-ea6622d88bcb@gmail.com>
Date:   Tue, 12 Jun 2018 20:56:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608112941.26332-3-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On 2018-06-08 13:29, Heikki Krogerus wrote:

> This adds function typec_get_orientation() that can be used
> for checking the current cable plug orientation.
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>   drivers/usb/typec/class.c | 11 +++++++++++
>   include/linux/usb/typec.h |  1 +
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 53df10df2f9d..02db9bcbac0c 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1279,6 +1279,17 @@ int typec_set_orientation(struct typec_port *port,
>   }
>   EXPORT_SYMBOL_GPL(typec_set_orientation);
>   
> +/**
> + * typec_get_orientation - Get USB Type-C cable plug orientation
> + * @port: USB Type-C Port
> + *
> + * Get current cable plug orientation for @port.
> + */
> +enum typec_orientation typec_get_orientation(struct typec_port *port)
> +{
> +	return port->orientation;
> +}

+EXPORT_SYMBOL_GPL(typec_get_orientation);

Isn't this a candidate for an inline?

BR // Mats

> +
>   /**
>    * typec_set_mode - Set mode of operation for USB Type-C connector
>    * @port: USB Type-C port for the connector
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index 672b39bb0adc..a5f6433e218b 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -265,6 +265,7 @@ void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
>   
>   int typec_set_orientation(struct typec_port *port,
>   			  enum typec_orientation orientation);
> +enum typec_orientation typec_get_orientation(struct typec_port *port);
>   int typec_set_mode(struct typec_port *port, int mode);
>   
>   #endif /* __LINUX_USB_TYPEC_H */
>
