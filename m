Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085ACC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CC12077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h/HSJKMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CC12077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeICSqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:46:50 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52729 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbeICSqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:46:50 -0400
Received: by mail-it0-f65.google.com with SMTP id h3-v6so1351326ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TwpHXLpxlg4crJ0gbKrtE6NumJZop7l3vMeJJyv/qIE=;
        b=h/HSJKMKSJZAjBHshWc14w2TOBDpGFtrSP/AGHrkCIPVX4sjtig3UtypceG6XBo96k
         wBaGNskxGHh6e8hhbnj4+dpaZWKxM0WpSKOnRMDfbPFM0/r0xU3dGHPst2w+68sjwJIH
         10xueBlhBpRsuhbkM+sFrsnv0NsZ369T8U9F05k05JC0G73YkOmwS2DcbwGgHszlij+g
         8fhl3JX8cUmUWc+BEqBnkl+oi0vAiNHB1+aHfXlw5KemVRB0p5VHzvFNnBbDXF8kKiPp
         pRT5/IIGWUVVyNbYiDxmfBAAFRmwZKoWg4ltKrmak4t5RqjGud0miR60AHvZl3/AUG1i
         p2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TwpHXLpxlg4crJ0gbKrtE6NumJZop7l3vMeJJyv/qIE=;
        b=hsoRMNBqT4PJL/vGYNXdmJg+ESyNviFlk+ko2WF06LRyquQl4PJFzmD+edzQ4I4Dvv
         z0jE2yGrrU+WZOedHoDbuCBPg06frUvSDlBHXmwSmyKgd9qA8dR6M+dB9DE2UjynKl2T
         GLyBtYKAjh0Sqhtra5Gu7IHJlBtrpx4FDGZlMzYiu9JzhBpy0g495vV2cryYCCblnMIA
         vbxrdUOMeV7GIReTHOXbbdF9ER2uFh+OBArNs8qsZzj9NnQT7QzFnqjm5yptCOMbQDRQ
         FVhQjuPbFcudr9Y0OBbRCY8Pzt8CLyn0xlQO4ZPED1ZZa8cCz+a/HQ5U8urWrdDsxYA3
         FBIw==
X-Gm-Message-State: APzg51CVe22IAN9aBQBjzDmqHB8tljmvP1SFJjnFpTfu50iyLi+ddzXv
        jKdPa4Y7aP4klkdzAz8LwMEH1A==
X-Google-Smtp-Source: ANB0VdbMEvQDJ0ITL95dKIabMDpZkh7h7yPD6HFCOnafxPfhjAdAAgSrRI0oAAjh3OAO0/x6BYrpZw==
X-Received: by 2002:a24:4207:: with SMTP id i7-v6mr5396387itb.24.1535984785005;
        Mon, 03 Sep 2018 07:26:25 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.22.static.utbb.net. [107.191.0.22])
        by smtp.gmail.com with ESMTPSA id u204-v6sm5743659itb.34.2018.09.03.07.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 07:26:23 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] ata: ahci_platform: support allwinner R40 AHCI
To:     Corentin Labbe <clabbe.montjoie@gmail.com>, hdegoede@redhat.com,
        mark.rutland@arm.com, maxime.ripard@bootlin.com,
        robh+dt@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f70d43de-1305-997e-687a-d6e9978e37f5@kernel.dk>
Date:   Mon, 3 Sep 2018 08:26:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180903100201.23131-1-clabbe.montjoie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/18 4:01 AM, Corentin Labbe wrote:
> This patchset add support for allwinner R40 AHCI controller.
> 
> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> by this serie, so no regression should come with it.
> 
> Patchs 1-7 should go via the ata tree
> Patchs 8,9 should go via the sunxi tree

Applied 1-7 for 4.20, thanks everyone.

-- 
Jens Axboe

