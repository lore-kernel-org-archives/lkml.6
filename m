Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6939C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8403D20666
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHde2f/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8403D20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeH3AZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:25:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35364 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeH3AZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:25:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id w8-v6so1235487pgs.2;
        Wed, 29 Aug 2018 13:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8tDwdz00v+AQcT8jjIGGkH7HjOpYbPDPeXpys4ojHRg=;
        b=nHde2f/J14Vn3PjrDSuoTQyywae3fSIKFy4DYGP+xH9yduAm35qrV717lLK+iu4d7C
         TIXO2YEAHoNPwyU0WS/AKqcINvR+BR7WdfUOhtqVZNuaG1AMxW+0oyjTZUvf0ag/fS2L
         Bija+tQXTgwRImtEhn9vIB1tXPT04voHTQCCMRqC4KzbwuTtm8rld819JyXYTeFQfkxC
         gtzveyzS9GQN1qWqwUMRUocCIUNrR2LrbSNCW2QD9ix/v9cZXoNkCb0iTCgh54yljWog
         yA3Mvo/D6JNS7X9BTSPbCS539jgnU/NxtIIkxL54nFk9S8W8gFQqEZ8fQ/Tj+TQqnnxU
         5QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8tDwdz00v+AQcT8jjIGGkH7HjOpYbPDPeXpys4ojHRg=;
        b=VRE2+tuKA0EDPFx/+gBFQZrHU1bt9gAv+52cdWUBZhcrteoxVE9c2VD+w0Lc0OeyCg
         M21UaUQzVus5NWQGlXIF90D3aZFzzemIBn6eg7F4lo0e9JYMe54+03URTar8pnlJlMlc
         NzySYk5v19j0D6eWUu2aQ8wCekL5N7mWrE5IZp5WyIOsJsuO1w5FDvGUh+1YRm0KRUsB
         dGc4ho/K6jWgN/OHGVj0PMtfVofQoovf4PVuBoiSNdEd42B3LKCnnmkYaejYa7mMj9Pp
         RwuKvZzbdf11rvygxv/CfozZx7jBtsmlSZqALy8H3OVZbiwKlKJvzvC8yoWaWrKQxQpj
         Vuqg==
X-Gm-Message-State: APzg51C+VJQs5Cdvg40svjLno9OEugypq1ZePkXflfGpWFJbzpMcGqaF
        QrqHhqPuO1t90pUOXVkqzaM=
X-Google-Smtp-Source: ANB0VdbMk/7yICmqTzpgeZzT8lPzLGmQu0tI7n9BCDkv6ouMftwvirrb3bSvosgyBsrteUPA9Tj/Aw==
X-Received: by 2002:a62:20d8:: with SMTP id m85-v6mr7389718pfj.74.1535574440308;
        Wed, 29 Aug 2018 13:27:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j184-v6sm7400372pge.77.2018.08.29.13.27.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:27:19 -0700 (PDT)
Date:   Wed, 29 Aug 2018 13:27:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] hwmon: drop unnecessary OF name NULL checks
Message-ID: <20180829202718.GB29801@roeck-us.net>
References: <20180829200221.13492-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829200221.13492-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 03:02:21PM -0500, Rob Herring wrote:
> Checking the child node names is pointless as the DT node name can
> never be NULL, so remove it.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linux-hwmon@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ibmpowernv.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 4935897f1527..0ccca87f5271 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -458,9 +458,6 @@ static int populate_attr_groups(struct platform_device *pdev)
>  	for_each_child_of_node(opal, np) {
>  		const char *label;
>  
> -		if (np->name == NULL)
> -			continue;
> -
>  		type = get_sensor_type(np);
>  		if (type == MAX_SENSOR_TYPE)
>  			continue;
> @@ -589,9 +586,6 @@ static int create_device_attrs(struct platform_device *pdev)
>  		const char *label;
>  		enum sensors type;
>  
> -		if (np->name == NULL)
> -			continue;
> -
>  		type = get_sensor_type(np);
>  		if (type == MAX_SENSOR_TYPE)
>  			continue;
> -- 
> 2.17.1
> 
