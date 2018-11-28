Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E38FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055FF21019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG4Tlx7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055FF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeK2Iuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:50:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32904 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2Iuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:50:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so10124886pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dVdQQBUpOIC2sJT0JnOvbWts94OUFN16X4bpsko7CQY=;
        b=RG4Tlx7bCQiG0Ah6qLEZBX7I5gCsvrvLyESH0eAf7jS+oRBzil+yQWLNiUYe0msX/0
         afT0+8gmNangdAKu5gFF7M57FYt34QYEbzOF/7vAuzty117sOuwer/tOOVD9qUdpHT9u
         Qo/jEH1IE6PXdVcX2Q8xd+L/ydEnS2nHIh+SdJASCk+EpCozoBr6rsVYqIWMUOarJTzK
         NbNYR9Rrn8NpeppcgG65Dwyq1wZdwZ4HCEjwhHMzvJl0k6QchMaJ4E+g7c1xC78PMMt5
         CoCPX/wUAtnyUKoC8JXX35Cw+fGF/gWU8uVq9GOhfqDkkQqZ46ByAjD0tGrqtGpydTX3
         3ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dVdQQBUpOIC2sJT0JnOvbWts94OUFN16X4bpsko7CQY=;
        b=SuGi5DLNIhgxgq5PnNQHSYZXe6zcxeYa2Brap10d3LMb0Z/SOZBpJRsO65mqaHVQKC
         OAvl4X0bZT3q/Vq1/dTMeTLxWCqpeP4mRUgleUGYZlUi8pAD6kRyb/SEP1qpvZ1MzUuz
         LukdJiLESC0hfV3E0jnz2xTUAXPsDzay2cFsqvD1JcxRS9EfipMboYpe4VPr0Ag1nHYG
         2t1fMtUe09sOStqZ/MFC2BUwPfrfJOgziyZxLZ3c542XSV6gZmVEbFpgvsfw/svkaLnJ
         xZj5FeSEo3+LjrJ5KTT0y9G9c3jngBLTBu3N2lDFayuo4wqid2NEKkyD3e/DFR6PsNuu
         U9IA==
X-Gm-Message-State: AA+aEWYK7QMpEFhno5mmcY48GtV7s632R5LbZfsN4ZSZ1eO8l44HxhAD
        E0HMqwV1WuYub1g+covUORpn/XIX
X-Google-Smtp-Source: AFSGD/UQpXPYftcrss/EROHOqFKbUnZhrakJU48AIolIhSOIGX6IdMmQlyiFpFzG69wX/RtvNigU/Q==
X-Received: by 2002:a63:2ac9:: with SMTP id q192mr34636197pgq.58.1543441652185;
        Wed, 28 Nov 2018 13:47:32 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q75sm6133113pfa.38.2018.11.28.13.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:47:30 -0800 (PST)
Subject: Re: [PATCH v2] soc: bcm: brcmstb: Don't leak device tree node
 reference
To:     Yangtao Li <tiny.windzz@gmail.com>, computersforpeace@gmail.com,
        gregory.0xf0@gmail.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, treding@nvidia.com,
        olof@lixom.net, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181124145223.29208-1-tiny.windzz@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d9a0cefe-1c8e-2d34-802a-d5f8de01df7b@gmail.com>
Date:   Wed, 28 Nov 2018 13:47:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181124145223.29208-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/24/18 6:52 AM, Yangtao Li wrote:
> of_find_node_by_path() acquires a reference to the node returned by it
> and that reference needs to be dropped by its caller. soc_is_brcmstb()
> doesn't do that, so fix it.
> 
> [treding: slightly rewrite to avoid inline comparison]
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied to drivers/next, thanks!
-- 
Florian
