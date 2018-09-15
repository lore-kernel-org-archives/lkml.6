Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0641ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5992087E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPfAQGw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5992087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbeIPCXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:23:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34680 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727640AbeIPCXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:23:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so5833595pfi.1;
        Sat, 15 Sep 2018 14:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HXZJcgW+WvZzVZmA613r9fLZvBiK5tou1MxALAsh8os=;
        b=fPfAQGw5u1jCVD2T3ZXOLiWIRpmej68Rr1YrNpv+7g48OWIMNe+rE8eNz5TqjcYYaY
         6UT38RjHeFEwVhq31eB5PpFDU21JCZ/U670QVIxYGAie01wJWAs5rCEcfCkDSSXbVLO1
         VryxTPsdQU45iRljqT4M3nbMaGcU+taDOTVykZqVaKh/JzPnnAmoUxvBvwARXqRcO27s
         ZjvmWC/Tyi0y2QoL34nmouRXkHK0vmhPk0knlMbt7Z82wvYWaWHNKZQpesldjwW73OAE
         E7jHOPCED1xzH513Vrv64R6TJ1OQd9sebHamaIxcnpDHgLE/Vx/MR2QGSDk+SfmxKKyW
         waDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HXZJcgW+WvZzVZmA613r9fLZvBiK5tou1MxALAsh8os=;
        b=eLwAGAGQN/B4US3l3LiXk3pYbeS+lKKNqyIZxsUHv6QUMQRm0jv4qy8tKCdrWqcfM3
         EK1F0tuyP/5yczLyGiSWuSEjG38pS2Q16eTiRePq9nUpn6kkb5t4pnllTZUNPM9ui2pr
         f5MvwSQrSL5RkD745H2JgwRI6dPycSZAaNNrU/cuyD6zsrPR1gHz6YreqlRsDGaMMnWL
         aKmK9588UZrAIKhvzA2NBwmZKxA9xEezEN3/1yLd0llUsxbIFH1yGMd1Fa/VUvQdWcWI
         t5V3wy2ue5CTLiyx5v4/Cpx9MyxCj8gv8RMw+rV4CO5LVU37ZdbYuZJ41zvSPBM+GwYW
         Yu5w==
X-Gm-Message-State: APzg51DvnFD/ouro7ejhpBcadZL2fKEQlTl1VamHXL9pRZw03mkEtI9H
        +1iUqUI/PGX3HZcpQ835qcU=
X-Google-Smtp-Source: ANB0Vdbn4HbMHXqVAwXYWJSLZGtAyvsDtEeVZGeDvlD6OaWQ8SKY8W3mTA7EX7QyFH8WQUyZ6nJBzQ==
X-Received: by 2002:a63:d946:: with SMTP id e6-v6mr17425555pgj.24.1537045405435;
        Sat, 15 Sep 2018 14:03:25 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id y128-v6sm14687387pfb.56.2018.09.15.14.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:03:24 -0700 (PDT)
Subject: Re: [PATCH net-next v3 03/11] net: mscc: ocelot: get HSIO regmap from
 syscon
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
 <d9b23949e81272006e076e0b58d90e0541f80c7f.1536912834.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <193ba88f-38ff-9ba1-8126-bd6da590e5a3@gmail.com>
Date:   Fri, 14 Sep 2018 19:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d9b23949e81272006e076e0b58d90e0541f80c7f.1536912834.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 01:16, Quentin Schulz wrote:
> HSIO address space was moved to a syscon, hence we need to get the
> regmap of this address space from there and no more from the device
> node.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
