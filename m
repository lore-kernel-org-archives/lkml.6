Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A5BECE563
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B57F2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKV8yvHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B57F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbeIPCaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:30:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39377 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:30:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so5828060pff.6;
        Sat, 15 Sep 2018 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=52wM23miKhQQURXb36arlPc340qHl50JD2n/tdybVwM=;
        b=XKV8yvHPpJ3BkNf/e0dcPcvwOKLiPvLJjo0n+yCcjUs8Gu/nhnNjoBrAMnKQy3X/9j
         kS8KmIXakx0ySvmnwJVAvM5B+7Juu1cAvdbtaB0Foh1ig5V/gBpJjfs9eETtd42nXPI4
         VKgMEGnBRcKB09toindp3S6tt7mXCsLsgvewZIlK8ea3BfikosN4RI7pHXDBeu5CP7CY
         NHd4fO2tmqIMcMfjj2AR6RHnf18b1kBVRT02tAdLAr/1cw8oyPzTRtkhS+e7fB79cd2h
         EnSrwAQ4uvgZ3elEKPU8JN4wRAVN0MjxUr7iXvbRbpOZJ5qi+/nbgxxfUq0i/+RBydXx
         rX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=52wM23miKhQQURXb36arlPc340qHl50JD2n/tdybVwM=;
        b=UqmSSPtlK4IUkR7vZvkB35/K2M8FSKm2FH48XQvAcrrelavUzA4RDSx2yKhm2hq3xM
         Ye8sx/iRV+PA9rNyqoZUzHdPx8tzCSLXjtBuzSjWv01J/08AFnGJaShtOnbkH0WVKaaP
         +0B56NW6w1t9smmJ5UiJZAVJDT0dSwwIwT3TeUm5TyIx0DpUT5zFbKE0ValgCGee/fsz
         8Sf0hKgd6Z+CDoIimYKDWgC459qJgGCPpUQvdpbdvIi0rJXEqobXYAEsRp7mcDgITfPx
         CuRX3B1L8RdlSk3KHi/xs76yaSLEpPkCtfN/03M29MT9tItHj5qQ+ZGcKLmmepjCEdS8
         ABaA==
X-Gm-Message-State: APzg51B1zP0MeUPoyyTgMv5ytD6fBaDQFJhp8D38TimaVFNjgwa7ktfa
        a00M/VAoHdizqsKLJ2keKFw=
X-Google-Smtp-Source: ANB0VdZgm5fryjA5iku9YcYp44leOfor7W3pRICZVnQnduM74RMIvDCiLu+gBZNbfXF4MRyiwnYE8Q==
X-Received: by 2002:a63:1921:: with SMTP id z33-v6mr17695361pgl.302.1537045801935;
        Sat, 15 Sep 2018 14:10:01 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id f75-v6sm18012919pfk.85.2018.09.15.14.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:10:00 -0700 (PDT)
Subject: Re: [PATCH net-next v3 08/11] MIPS: mscc: ocelot: add SerDes mux DT
 node
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <ba95add3d931177ef55666e856164523903d1148.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d7ca96be-5a66-0a9a-62b2-936595122058@gmail.com>
Date:   Fri, 14 Sep 2018 19:30:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ba95add3d931177ef55666e856164523903d1148.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> The Microsemi Ocelot has a set of register for SerDes/switch port muxing
> as well as PCIe muxing for a specific SerDes, so let's add the device
> and all SerDes in the Device Tree.
> 
> Acked-by: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
