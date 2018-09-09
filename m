Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1476CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8C020833
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 19:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/zDbKQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8C020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIJAmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 20:42:52 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43545 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeIJAmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 20:42:52 -0400
Received: by mail-pl1-f194.google.com with SMTP id f66-v6so577799plb.10;
        Sun, 09 Sep 2018 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hcro95bS/xyvnkepZZ+Phehq/MdcVVSwfMZygXPm4O8=;
        b=Y/zDbKQNC3j3a+146eDkW8Ma0YzZR3on3MDpNsBA6lT7Ah1n8JNKFjwP7gO6oorIyA
         i2HI6wkzbcXCrk909XieZSu7wJGAFaN9dk6uzpH0ErqCLACQUi1+7bfJ02f/nur43hPG
         xNHzxI4juIaxwHZjLLPY4vGheLHleoWrqku3Wz/QjEn9i8HYLYORsr7i89oOEfV+UIbC
         XdBUn2V9cjKKD6lAmNcd2JJ6R0oFSR4UZrWAti6wYNTAWM9YxGk9iMMKSbEiCslSfa+F
         lR+KR3gLAt8dqkm6VTKYJY2tRmGpzeMfm/cwVPENMSgjdWRprwi42vf1QXG+rFMZotoJ
         5c/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hcro95bS/xyvnkepZZ+Phehq/MdcVVSwfMZygXPm4O8=;
        b=m/S4vMHyDPa1KvAJdWpsx7AVyuSDH2j5ZzGEu2h7IA5dHhqo1xOwKwqCi4ebDYRn1O
         apnptrTPRSZ7Ki+zussEe3HxPF/WzYdhOehNmsmgK3ZvnxeGR538v6SWnsRsqqgcGNAa
         UB6e/nyHC/4j80T0Q+2E/boKSMDc8243mOtPmrNwOvOhYLPB6Mw6s+SZ2mhf/Y2c1RWC
         E2zu7+eI3oO+5te1HwsOC6b/eMg2+pUQgiJoOfw7cJdvlzX+NJ9fToUdtVYkiRL33cKK
         ocRmEq0IvYn06xX3BZpSDo10Yf1v0YGMmWdARZRqfHvCIRxe6cob5Wla4Wszi8aXi3cS
         7jlg==
X-Gm-Message-State: APzg51Aies0/D4wV4AXuLDgmQV725L2D1g8fzceS2ucJu/XRcAo/eTm+
        qBXuXJZZ/NKhySh/EqXEcKYagkFY
X-Google-Smtp-Source: ANB0VdYFSovlMShnh5e+hDUUmfOv+SADZPvGZwxuIHebc0TdjT0wm0XYry8rMiuAnARSVsr7TNF9Zg==
X-Received: by 2002:a17:902:9302:: with SMTP id bc2-v6mr18683190plb.280.1536522726378;
        Sun, 09 Sep 2018 12:52:06 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l84-v6sm31422866pfg.3.2018.09.09.12.52.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 12:52:05 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: get the vbus source and charge values from
 the devicetree
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180909180531.28092-1-angus@akkea.ca>
From:   Guenter Roeck <guenter@roeck-us.net>
Message-ID: <3f2ae49a-9029-3f75-fb2d-abebc537594a@roeck-us.net>
Date:   Sun, 9 Sep 2018 12:52:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180909180531.28092-1-angus@akkea.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 11:05 AM, Angus Ainslie (Purism) wrote:
> If the board is being powered by USB disabling the source and sink
> can remove power from the board. Allow the source and sink to be
> initallized based on devicetree values.
>
> Changed since V1:
>
> use devicetree values instead of hardcoded initialization.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>   .../bindings/connector/usb-connector.txt           |  4 ++++
>   drivers/usb/typec/tcpm.c                           | 14 +++++++++++---
>   2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> index 8855bfcfd778..afe851a713c3 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -22,6 +22,10 @@ Optional properties for usb-c-connector:
>     or Try.SRC, should be "sink" for Try.SNK or "source" for Try.SRC.
>   - data-role: should be one of "host", "device", "dual"(DRD) if typec
>     connector supports USB data.
> +- init-vbus-source: set the initalization value for vbus-source to true.
> +  If this property is not present the initial value will be false.
> +- init-vbus-charge: set the initalization value for vbus-charge to true.
> +  If this property is not present the initial value will be false.
>   
This change will require DT maintainer approval.

Thanks,
Guenter

>   Required properties for usb-c-connector with power delivery support:
>   - source-pdos: An array of u32 with each entry providing supported power
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index ca7bedb46f7f..7f5d4f209e07 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -2462,9 +2462,7 @@ static int tcpm_init_vbus(struct tcpm_port *port)
>   {
>   	int ret;
>   
> -	ret = port->tcpc->set_vbus(port->tcpc, false, false);
> -	port->vbus_source = false;
> -	port->vbus_charge = false;
> +	ret = port->tcpc->set_vbus(port->tcpc, port->vbus_source, port->vbus_charge);
>   	return ret;
>   }
>   
> @@ -4266,6 +4264,16 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
>   		return -EINVAL;
>   	port->port_type = port->typec_caps.type;
>   
> +	if (fwnode_property_present(fwnode, "init-vbus-source"))
> +		port->vbus_source = true;
> +	else
> +		port->vbus_source = false;
> +
> +	if (fwnode_property_present(fwnode, "init-vbus-charge"))
> +	        port->vbus_charge = true;
> +	else
> +	        port->vbus_charge = false;
> +
>   	if (port->port_type == TYPEC_PORT_SNK)
>   		goto sink;
>   


