Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PsGAAxXCGlvwGwAAmS7hNA
	; Fri, 08 Jun 2018 17:51:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 01808607E4; Fri,  8 Jun 2018 17:51:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="1BI0VBJ/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 72712605A5;
	Fri,  8 Jun 2018 17:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72712605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeFHRvd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 13:51:33 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36174 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbeFHRvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 13:51:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id u4-v6so21308243lff.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKX0Izhddjn2Kkw8I5/FYW4PKd61LnRfmj/8+Yty3Vk=;
        b=1BI0VBJ/igEaQ2ySLI/RY9MRHYy8i3dlrvoJDSCc6Bk4hYA696zx60w/PFnC8GGolu
         QIg4YUthddhWFqpG3XSbUIhvPI0iKk7L6LH2vvyoeWt4lBc8YdWDoRz6uW3bGhotB9jg
         XUc4GOAAGhPpVuKLTk0lC04aVIYm+9Szj9Ve4PZQD8AcZQk/7y0gA1h4DKSjdTGcCrH/
         pm6JubpUIDFGyDls3yeHJkBH40AHOttADNz3cPugVp4gWBkKgJuKfRXGT7CSCw28TRkR
         YILDpKHUlCJxmvsK5xE7SIyFtraLLiLQIvWrY1OmCKcOwPW9BwYo13TKhabTUvJVgSBq
         4VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=EKX0Izhddjn2Kkw8I5/FYW4PKd61LnRfmj/8+Yty3Vk=;
        b=cttbhn43l6A/mFuRS++qBUb8EBRR00DuWKR5Jlu/vnoHq6+U/vT7+U+N4JwS6CWLPD
         WINPWQ6MtrzsiXGn6Bzovxpluwv5yul/ABqZQ4eDLHxZaPjiXUKuuqhG4KI7ZgeDG79p
         CWyR2UmcezXMkvmmba2SLdosNasHBZ4rHXeJD5/4zyiti0x72x44j/L01nTEMasHWWWb
         0JnsM/6JFsVw8ir1Q1LhI2+o9Filk3Kp8LYZFUd89H4T4Cyx07cOPCb1nxIjyl99v3dM
         sKEe9jH3VfmeI5eNEoQ7X/JslTtMdUV3RU8G7SmhRq3DYS5ycYh1j+B3pfjEEcxIPpfN
         ApiQ==
X-Gm-Message-State: APt69E0eeF4BL2bps/NSfZicuSytty+4KSvs2G6SthETTBvl/uNpVnb7
        iS9EL4UjoT1HHs1yWW8ji5HYp0pGUy0=
X-Google-Smtp-Source: ADUXVKIk+dnbwDa8VR67Ms50384tdjGJcVtXwbNeou7Ss7MzG3hLAFLVGXLNblKosgmmFcte70jWtQ==
X-Received: by 2002:a2e:8151:: with SMTP id t17-v6mr5191952ljg.32.1528480290323;
        Fri, 08 Jun 2018 10:51:30 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.218])
        by smtp.gmail.com with ESMTPSA id q66-v6sm3049256lfg.17.2018.06.08.10.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 10:51:29 -0700 (PDT)
Subject: Re: [RFC PATCH v4 7/8] usb: typec: pi3usb30532: Start using generic
 state values
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180608112941.26332-1-heikki.krogerus@linux.intel.com>
 <20180608112941.26332-8-heikki.krogerus@linux.intel.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <89e0f9ac-4b9e-6fa1-de23-5ce305e1d2f0@cogentembedded.com>
Date: Fri, 8 Jun 2018 20:51:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180608112941.26332-8-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 02:29 PM, Heikki Krogerus wrote:

> Instead of the tcpm specific mux states, using the generic
> USB type-c connector state values, and with DisplayPort
> using connector states defined for the DisplayPort Alt Mode.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/mux/pi3usb30532.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/mux/pi3usb30532.c b/drivers/usb/typec/mux/pi3usb30532.c
> index b0e88db60ecf..bcea242852f2 100644
> --- a/drivers/usb/typec/mux/pi3usb30532.c
> +++ b/drivers/usb/typec/mux/pi3usb30532.c
[...]
> @@ -83,21 +83,24 @@ static int pi3usb30532_mux_set(struct typec_mux *mux, int state)
>  	new_conf = pi->conf;
>  
>  	switch (state) {
> -	case TYPEC_MUX_NONE:
> +	case TYPEC_STATE_SAFE:
>  		new_conf = PI3USB30532_CONF_OPEN;
>  		break;
> -	case TYPEC_MUX_USB:
> +	case TYPEC_STATE_USB:
>  		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
> -			   PI3USB30532_CONF_USB3;
> +			PI3USB30532_CONF_USB3;

   Unrelated white space change, inconsistent with the others below...

>  		break;
> -	case TYPEC_MUX_DP:
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_E:
>  		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
>  			   PI3USB30532_CONF_4LANE_DP;
>  		break;
> -	case TYPEC_MUX_DOCK:
> +	case TYPEC_DP_STATE_D:
>  		new_conf = (new_conf & PI3USB30532_CONF_SWAP) |
>  			   PI3USB30532_CONF_USB3_AND_2LANE_DP;
>  		break;
> +	default:
> +		break;
>  	}
>  
>  	ret = pi3usb30532_set_conf(pi, new_conf);

MBR, Sergei
