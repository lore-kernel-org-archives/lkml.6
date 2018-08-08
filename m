Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609BFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEEA21990
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedgreg-com.20150623.gappssmtp.com header.i=@embeddedgreg-com.20150623.gappssmtp.com header.b="EhMUmAXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DEEA21990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedgreg.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeHHRpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 13:45:31 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54390 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeHHRpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 13:45:31 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so3969710itb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20150623.gappssmtp.com; s=20150623;
        h=subject:cc:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=SpU3aME/3tE0sR9q/UkJWEwooAmdyayoqtYE11bRstU=;
        b=EhMUmAXfPk9Frm4/BWgxvkOnmixoz7Y+FlMX1hjW93oLQWVYY/GBnm6zxBy666579x
         20qxyxSNIOI4+gjMwL5l5DGaFaCCo4hZaAMkKA7vsxpxy6vxLtCcf3VdyWRHPaV1jy4C
         1yh6F1wqxmOkCPhFG6fw9k29oTN65mZZSuE6KLlOLegRwFLWHWHEwIFYGVHYwHYiq1vy
         FB4KRkqDjVb/fJekq+KD/AoBiQVkm37eToSl/IHUs+q9J2k8NGO9zlXB7k6QEEYqmM7o
         h39wH7BAFY+i4ZmlAGgVbkAF0KD0VgHqNYxisW5jmpn6VVIMveGCn5HdwPDdrc5GCwfk
         WJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SpU3aME/3tE0sR9q/UkJWEwooAmdyayoqtYE11bRstU=;
        b=sBQasKSjZtWlJ9iZSAxjDMAiZMbk2rsSEKvJ7iRqyTWLzm7+z6sSkv0sYBETsLan+O
         73epOCHnbfNQJnDAruWa45bE+93pfkoDaxdXnjtb3uD/ll9UcPA1CIuRL9NdaTzIq6Ds
         QAxPE/y095SXHcyTfZiDAYJ8y0gepyAGEr3S0ykLaWTvJH6XgouE8m5XSllkmWlJlXXQ
         0jGd+qDY7Pzo3w3sYyANeQc6D+25i0MSf1HVJWLf/s62w6thnfJ5jNODNMcRIdxYTlXn
         x2B2Lide9dyQADNFDBdDY97aBiU0t7Z7Ka2Ueq6zmephjg128/3855m0QdqjV3YSuikV
         ZFhA==
X-Gm-Message-State: AOUpUlEJDUxX7pT52CMOEG8IjXkh3nGEJxPrDz+gB6tDeKKZVs8IlIhi
        XOskAgLBmGHb8B9EajPuZtqF0A8jFUalpRuGGqx9pkbrhzbZiMLtA2DfqPOLaIOIZCtZLZLCK2e
        IWK4fOOmgm4KwUoTw8S28o3+3BrGlVhGp2r4ymZtQV13PgZprhZ0XgS39au+w+jh6pWnhZvN6W6
        C2vdUzfew=
X-Google-Smtp-Source: AA+uWPzAW8kBxXu8mpcQ/TWn425e93suLNsEKOWC/26yuvZkbl4WaZOqkJ0g2az7tBWg5MqMZ6F9mw==
X-Received: by 2002:a24:9197:: with SMTP id i145-v6mr2750018ite.39.1533741921357;
        Wed, 08 Aug 2018 08:25:21 -0700 (PDT)
Received: from [10.6.40.45] ([24.137.218.3])
        by smtp.gmail.com with ESMTPSA id b1-v6sm1303256ioh.43.2018.08.08.08.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Aug 2018 08:25:20 -0700 (PDT)
Subject: Re: [PATCH v2] staging/vc04_services: Fix alignment of function
 arguments
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20180808013455.18037-1-greg@embeddedgreg.com>
From:   greg gallagher <greg@embeddedgreg.com>
Message-ID: <78576030-1fdd-6e40-b6d8-8035b57df9e4@embeddedgreg.com>
Date:   Wed, 8 Aug 2018 11:25:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808013455.18037-1-greg@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-08-07 09:34 PM, Greg Gallagher wrote:
> Fix warnings generated by checkpatch.pl for alignment should match open
> parenthesis.  This is a coding style change only.
>
> Signed-off-by: Greg Gallagher <greg@embeddedgreg.com>
> ---
>   .../staging/vc04_services/bcm2835-audio/bcm2835-ctl.c  | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> index ec468d5719b1..8af303e25036 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-ctl.c
> @@ -94,7 +94,7 @@ static int snd_bcm2835_ctl_get(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_ctl_put(struct snd_kcontrol *kcontrol,
> -				struct snd_ctl_elem_value *ucontrol)
> +			       struct snd_ctl_elem_value *ucontrol)
>   {
>   	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>   	int changed = 0;
> @@ -174,7 +174,7 @@ static struct snd_kcontrol_new snd_bcm2835_ctl[] = {
>   };
>   
>   static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_info *uinfo)
> +					  struct snd_ctl_elem_info *uinfo)
>   {
>   	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
>   	uinfo->count = 1;
> @@ -182,7 +182,7 @@ static int snd_bcm2835_spdif_default_info(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_value *ucontrol)
> +					 struct snd_ctl_elem_value *ucontrol)
>   {
>   	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>   	int i;
> @@ -199,7 +199,7 @@ static int snd_bcm2835_spdif_default_get(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_value *ucontrol)
> +					 struct snd_ctl_elem_value *ucontrol)
>   {
>   	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>   	unsigned int val = 0;
> @@ -219,7 +219,7 @@ static int snd_bcm2835_spdif_default_put(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_info *uinfo)
> +				       struct snd_ctl_elem_info *uinfo)
>   {
>   	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
>   	uinfo->count = 1;
> @@ -227,7 +227,7 @@ static int snd_bcm2835_spdif_mask_info(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_value *ucontrol)
> +				      struct snd_ctl_elem_value *ucontrol)
>   {
>   	/*
>   	 * bcm2835 supports only consumer mode and sets all other format flags
> @@ -238,7 +238,7 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_stream_info(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_info *uinfo)
> +					 struct snd_ctl_elem_info *uinfo)
>   {
>   	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
>   	uinfo->count = 1;
> @@ -246,7 +246,7 @@ static int snd_bcm2835_spdif_stream_info(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_stream_get(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_value *ucontrol)
> +					struct snd_ctl_elem_value *ucontrol)
>   {
>   	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>   	int i;
> @@ -263,7 +263,7 @@ static int snd_bcm2835_spdif_stream_get(struct snd_kcontrol *kcontrol,
>   }
>   
>   static int snd_bcm2835_spdif_stream_put(struct snd_kcontrol *kcontrol,
> -	struct snd_ctl_elem_value *ucontrol)
> +					struct snd_ctl_elem_value *ucontrol)
>   {
>   	struct bcm2835_chip *chip = snd_kcontrol_chip(kcontrol);
>   	unsigned int val = 0;
Please ignore this patch, a new patch with the correct subject line and 
v2 description has been submitted.

-Greg
