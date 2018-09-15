Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB0DECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC2B20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 20:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZobPKWJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC2B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeIPCNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:13:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45329 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:13:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id x26-v6so5899268pge.12;
        Sat, 15 Sep 2018 13:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r1uQ/jY6qjXEKWhZQkouLdJNvd1j3y70Uw7eVRsdQao=;
        b=QZobPKWJyHq0YdxkBuK0nlSSk6iUBELq4AUO9XnYaaUsqWgZgUYTwABv4QdRcbTPaF
         p20Yc2zmDgG02hNBHXWjb+NamapOk8sBsnv9Gtm9a1ESMHI93al0TDlZesAA+MIuqAzZ
         r5T91axKuBm2OHUCgKAbLDCMMhC7Hqbksw1dXRNO5Hhy6r57axAmjvStok01shgyY80z
         rNrGo1AhIlMnUpmgwOFy7vMNKHu9U6qVoUJpY+XvYs7Czj23SmCKygWVGiOFqrXKbj28
         9vyaLoPpHceamF+mVyCR7vCrWUbuVtBh4jrVs6sDHHuJTFRkdRP+qCd0uzxM5AuDV3Ai
         BjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r1uQ/jY6qjXEKWhZQkouLdJNvd1j3y70Uw7eVRsdQao=;
        b=KfCFIsPEUvdDvIYjJQUjAjw4jRCZRIRxm/lEr10P+OFSF8lN1D9js66WYr6Feh7VqQ
         iJnT0dnJ4QaIrX3VSMbIYBwY35UvfaJdHOntMbCuRa2ruUZNcv6UlM5P/JsOOhFOLVxD
         6mPegV0NdaxL0LxP5UazbZQJ64PcyoWNMgbWnZPIpu85mJRZdghtuyPVxRtSJMv06IRm
         weMFjw3reOJdTo1nqAbNSgKWl4/qYxCAii4ODmNwPl/l0fX2vIHdP7rluVdiwFPldrjo
         rPVPF+0wCcY5moyTvAL0q7dAI2gZNIqFxhXd/oePwBn8UvgOro+iQRBXqTXNipWO9o61
         CcWw==
X-Gm-Message-State: APzg51BS91WXK9YBLWWCcfdHxRsdh5KVczCcwbsilkN+Y9mkmP3cxgjG
        s1FxvAQw9+PSmqeeKud9YR83Ehed
X-Google-Smtp-Source: ANB0VdaYIm+RfCmueslVoaxOC1Rxu/P8jMk7NCLPj/V6lvqzu0t6cXQl504JsOyT3zNtpHdYiAQaww==
X-Received: by 2002:a63:1204:: with SMTP id h4-v6mr17556484pgl.115.1537044773306;
        Sat, 15 Sep 2018 13:52:53 -0700 (PDT)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id c20-v6sm15872439pfh.143.2018.09.15.13.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 13:52:52 -0700 (PDT)
Subject: Re: [PATCH net-next 3/5] net: phy: mscc: remove unneeded parenthesis
To:     Quentin Schulz <quentin.schulz@bootlin.com>, davem@davemloft.net,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.616d15610d44a0e3d463acd8119859f243163ad2.1536913944.git-series.quentin.schulz@bootlin.com>
 <e3a1a9940e18c69ecf9aaecc3e2d9bf2a180a939.1536913944.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <9a590892-8d58-8a13-c4f4-504abf849c5a@gmail.com>
Date:   Sat, 15 Sep 2018 13:52:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <e3a1a9940e18c69ecf9aaecc3e2d9bf2a180a939.1536913944.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/2018 1:33 AM, Quentin Schulz wrote:
> The == operator precedes the || operator, so we can remove the
> parenthesis around (a == b) || (c == d).
> 
> The condition is rather explicit and short so removing the parenthesis
> definitely does not make it harder to read.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
