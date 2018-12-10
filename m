Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F8EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E4520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq9YAwoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3E4520821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeLJNUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:20:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42629 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeLJNUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:20:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so5246355plp.9;
        Mon, 10 Dec 2018 05:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yztR7wv9WVTETIuuWQuG3q3HlE0Hz1iQ49yrKE0yleA=;
        b=Xq9YAwocZWgc932zPArJkdqerA+V1ciK9b+Iv+IP8hYVf4qhQuZPRCG2irY+0k7bzh
         s3sG7ed5U3VTKkxEXA8Zul293bJLCdYYNccgY5XMTObYUfTJGz4REgNfrDwPxXwI6+ZY
         hOKzHI6VikSXPF+xiDgYRxXFT1ph2WuF89ULi5ad+ug9Lsy2MAFqPZKba6KlHT6Wdtm2
         EGxUiYdfDBew3JnMrWcs1XDvnJNTkYERt8LqMxXiJoy5vRGpqJP5yRRKpuS4TvsMjseR
         9KM4sdimsu3BotCF9No5DeWVHcy6Tot5bzSxgmYIDn1an+d6W1AwSXWcGod7v+4vFkUW
         4LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yztR7wv9WVTETIuuWQuG3q3HlE0Hz1iQ49yrKE0yleA=;
        b=govA7dUOUXqdCF3kH9AirpCipR8LMg0h9M+KQG7U2dlUK11jn9PB80CWUxMdclSQ9L
         fHY4YNEh1OW+EZ+674HDUU9sg5HSV/aibhp9Os2SpeszbFUzd9uvfDZZE7/Hy2N+Q9eE
         xPu//jqJp11fNxDhT/00TPP4XWCaHdIO/qGY+Q8nRv3o81bzJCEAu6GAtncTgTyo/uUm
         mo70u3GpYPLTznGDvOqkFCKQfi4QvkFdlMAqsSdJvyZtCSkSmQIcA2ABb13wNvOS21CM
         feTYJMe5d/m2VHQHUChyh3h0199dxlvbU1iNg+H2u+XrEQEI+2qXC26sXZMGbQM/bmjK
         2HBQ==
X-Gm-Message-State: AA+aEWb0DZm3s11hF7AY967MkVmh5dn6flfVsvVk1icMzN74U8YqCYyf
        LFz+lGz2F0m+DLuGZ6v6EVc=
X-Google-Smtp-Source: AFSGD/U9HskEw1WvAhfP2TUvcxP3L53IAJgZ48GyNzAwYfEshPRDZ0vRWSWGaathwsciJ06a3FCcNA==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr11820354pld.227.1544448048454;
        Mon, 10 Dec 2018 05:20:48 -0800 (PST)
Received: from [10.1.1.7] (ppp118-209-129-45.lns20.mel8.internode.on.net. [118.209.129.45])
        by smtp.gmail.com with ESMTPSA id o8sm20100892pfa.42.2018.12.10.05.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 05:20:46 -0800 (PST)
Subject: Re: [PATCH 1/1] usb: dwc2: disable power_down on Amlogic devices
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, hminas@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     Arthur.Petrosyan@synopsys.com, christianshewitt@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-amlogic@lists.infradead.org
References: <20181209190129.11870-1-martin.blumenstingl@googlemail.com>
 <20181209190129.11870-2-martin.blumenstingl@googlemail.com>
From:   Brad Harper <bjharper@gmail.com>
Message-ID: <81fb7231-8bc1-c8e9-4901-20676632a10b@gmail.com>
Date:   Tue, 11 Dec 2018 00:20:41 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181209190129.11870-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 6:01 am, Martin Blumenstingl wrote:
> Disable power_down by setting the parameter to
> DWC2_POWER_DOWN_PARAM_NONE. This fixes a problem on various Amlogic
> Meson SoCs where USB devices are only recognized when plugged in before
> booting Linux. A hot-plugged USB device was not detected even though the
> device got power (my USB thumb drive for example has an LED which lit
> up).
> 
> A similar fix was implemented for Rockchip SoCs in commit c216765d3a1def
> ("usb: dwc2: disable power_down on rockchip devices"). That commit
> suggests that a change in the dwc2 driver is the cause because the
> default value for the "hibernate" parameter (which then got renamed to
> "power_down" to support other modes) was changed in the v4.17 merge
> window with:
> commit 6d23ee9caa6790 ("Merge tag 'usb-for-v4.17' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing").
> 
> Cc: <stable@vger.kernel.org> # 4.19
> Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Fixed the issue on the Odroid C2 sbc with amlogic meson gxbb soc, 
devices are now detected when connected after boot

Tested-by: Brad Harper <bjharper@gmail.com>

> ---
>   drivers/usb/dwc2/params.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 7c1b6938f212..38c813b1d203 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -111,6 +111,7 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
>   	p->phy_type = DWC2_PHY_TYPE_PARAM_UTMI;
>   	p->ahbcfg = GAHBCFG_HBSTLEN_INCR8 <<
>   		GAHBCFG_HBSTLEN_SHIFT;
> +	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
>   }
>   
>   static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
> 

