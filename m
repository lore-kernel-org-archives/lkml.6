Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217B3ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B286220881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8MAUEOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B286220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeIPCzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 22:55:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42199 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeIPCzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 22:55:21 -0400
Received: by mail-pl1-f194.google.com with SMTP id g23-v6so5690503plq.9;
        Sat, 15 Sep 2018 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HU7kikOQ8N5r1SbH1w2kVP/GhptrxpVltOgdNsulNZ4=;
        b=F8MAUEOWmk0gtiooscdj7tuzoC5qOc8ZBOuYS/ts+SFHjGT3GpXBICLq35eyDhDu1F
         2t2Hu5fZWW6P7skqkrDorMWAQJsAwaU7Ls3DcKWFAwI5i0gZfFVdvcP3neXeoV5YIshI
         /tSl3xkh3vfxK48S3rPel32Cd2bhT53Qul8vU7VxuTb9U8De4rlnkNHQokA0kWvbMGIG
         7ywJ9tKr5fYj9teX+2p/Hrz92qQvgGqzaxSjAd/OJpnrjF7s95TTKJndE/VQtZZcWei7
         Le0mmYOWV/1NTyernR9xDobMtcstP58ONpb7/+lXncu2V7uBqkQO6ZNkK+uD1NOY+Qz6
         D3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HU7kikOQ8N5r1SbH1w2kVP/GhptrxpVltOgdNsulNZ4=;
        b=muP2rtda2gqZdTMcUjXBlVUyrb6Px3eHdKVt6UYdNhMUQ5D9CZPteQ8zhyoTCMkHA6
         0x30hHIdMvsFyQjd513DNJXskttkHsqp8JjTSvE4RqzngE7LpwIt09KXvYXb+tOpJQSv
         LXpNR/PacRQqFdohwsJMJn4gELm9EO9ltJ/+PoBdEOwpEeIUqwxEyrb4sHIPrE1Iq6OM
         XdhfvPoa8yKGTIiDma0llFKdvgIJmlQt/Q9HBhMyJtXiroruCCXThsIfnnQwen7hiOyx
         eipQ4qMOs4ZwRbjbAI5cYqFtwC597ujTfmtDrijqSwSPMMBP6L6/wzr2Wldhb1k9snSr
         Wm1g==
X-Gm-Message-State: APzg51AHyoNym3PAp2oCcagc+AJuzcolp1yoq+Uc+vLRImrhGzhL5dw9
        bXgEpNcMDV2/nzUD2PpYVIg=
X-Google-Smtp-Source: ANB0VdYil0cc8MUoaTaBG+UP2syj7eXTDfFXNYM9vMDaKv0YzmQEljIJVh9s+8xikmM9zL5cw2UNGg==
X-Received: by 2002:a17:902:558f:: with SMTP id g15-v6mr18225518pli.38.1537047295280;
        Sat, 15 Sep 2018 14:34:55 -0700 (PDT)
Received: from [10.0.2.15] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id b64-v6sm13680474pfg.66.2018.09.15.14.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 14:34:54 -0700 (PDT)
Subject: Re: [PATCH net-next 1/7] dt-bindings: net: vsc8531: add two
 additional LED modes for VSC8584
To:     Quentin Schulz <quentin.schulz@bootlin.com>,
        alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
 <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c1102b61-fc17-c55b-fe27-b85dcd8aeccb@gmail.com>
Date:   Sat, 15 Sep 2018 14:34:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/18 02:44, Quentin Schulz wrote:
> The VSC8584 (and most likely other PHYs in the same generation) has two
> additional LED modes that can be picked, so let's add them.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
