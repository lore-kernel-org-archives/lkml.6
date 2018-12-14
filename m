Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2413C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F642080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="HOByx6vk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F642080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbeLNLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:17:53 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45390 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeLNLRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:17:52 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so4541598ljd.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NeYXWjxsHkk/7WRS7gurrwcB/B/8FyaKxUFKC9PAFGI=;
        b=HOByx6vkjQJeeG+BAU5fbz5NN9xEyouzUP1e5cdPb2jVhpTXl1RnKurniZbochad82
         zd+WoyD/DIZk2US0AHWHa1DHMK1qv4wnqUovR1/wMPXlfBCQq7VclSV/vUk1xsWC2HwB
         JjTOm/wJl054xjn5/Evm5FrU/gDTRPxr2ndMGeH9R77D9EasXUDP+Zm6CymHozFwL9Rg
         M/sUXKGgR7o4QJqtd4XX3CHrticiDzEB0datiF/eGMQCwK0uA26IONhLmAdSapQlHG/u
         jlUO4V8SuPAnY6WZz/ytg+mb7H4AEg52ppdrIRl4yM8zYLnnPvCne79KtDEZSnuCHuO9
         /dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NeYXWjxsHkk/7WRS7gurrwcB/B/8FyaKxUFKC9PAFGI=;
        b=C69wbzJwzj88lkisp0ANbf0d4nwE0hxyyY0MCkwWeKMm1mI4i/SqxBR9UqlIV/KbS7
         dk3xF3GyxEZzGK0xBT7Wmthwtl01wnxaidTs28ugHWfAsZf0alq/7Ft6yzuNcf4Jcqd0
         zPVoSeWDgSkXmg0Uajw9xjkA5cIQrb/F1QJ5fierzCk7dG+9mc96rFeP7eoWB8R2ppSR
         +qUW2J/e5PR39uZCdicTL5yhgwulBXWhIKPftBqtqpsmA5u1RG4kLuyte271H0K0jJcc
         0YogTIplMluodshOem8AxmlO+DDIwcyFN+sBz6Y786l5zsogjmVu6Km/pSpOxhNiWeSM
         Fcgg==
X-Gm-Message-State: AA+aEWZZ/Y2nTX/nKxW/UGb9Qxgp2bJiqArqfn18xMFgJlzAhq6wfllp
        oFDgISVGLhK+s7ORqm1L4ezdL8mMGww=
X-Google-Smtp-Source: AFSGD/UDeSfqEuqZzHLa17q30RYnm2784EkVXvpHwcOPq25ri81bHX9HtrJbnQb+BtwtcSPOEh5ZRA==
X-Received: by 2002:a2e:1f01:: with SMTP id f1-v6mr1555239ljf.129.1544786269667;
        Fri, 14 Dec 2018 03:17:49 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.84.254])
        by smtp.gmail.com with ESMTPSA id b25-v6sm804519lji.94.2018.12.14.03.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 03:17:48 -0800 (PST)
Subject: Re: [PATCH] usb: dwc3: gadget: fix miss isoc issue introduced by IRQ
 latency
To:     Zeng Tao <prime.zeng@hisilicon.com>, balbi@kernel.org
Cc:     liangshengjun@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <67af347c-39fb-a11c-ab95-7741c58b6dd6@cogentembedded.com>
Date:   Fri, 14 Dec 2018 14:17:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1544805179-2248-1-git-send-email-prime.zeng@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 12/14/2018 07:32 PM, Zeng Tao wrote:

> If it's a busy system, some times when we start an isoc transfer, the
> framenumber get from the event buffer may be already elasped, in this

   Frame number? Else my spell checker trips. :-)

>  case, we will get all the packets dropped due to miss isoc. And we turn

   Remove the leading space, please.

> into transfer nothing, to fix this issue, we need to fix the framenumber
> to make sure that it's not out of date.
> 
> Signed-off-by: Liang Shengjun <liangshengjun@hisilicon.com>
> Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
[...]
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 9f92ee0..b63bd72 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1263,6 +1263,15 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
>  	return DWC3_DSTS_SOFFN(reg);
>  }
>  
> +static bool __dwc3_gadget_target_frame_elapsed(struct dwc3_ep *dep)
> +{
> +	u16 cframe =  __dwc3_gadget_get_frame(dep->dwc);
> +	u16 eframe = dep->frame_number & DWC3_EVENT_PRAM_SOFFN_MASK;
> +
> +	return (((eframe - cframe) & DWC3_EVENT_PRAM_SOFFN_MASK)
> +		> DWC3_EVENT_PRAM_MAX_SOFFN / 2);

   Please leave > on the previous line.
   And you surely know that the outer parens are unnecessary? :-)

[...]

MBR, Sergei
