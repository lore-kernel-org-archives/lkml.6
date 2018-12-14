Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92379C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C67D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPgZdCjK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C67D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeLNMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:44:41 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37267 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbeLNMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:44:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so4872130wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lPSksvhVy6YF41PEgDMAtPKdDYkNxoTk2/v3Z+Pnw3U=;
        b=IPgZdCjKmKFBoQVpiWN/nqiADAagfCr4YRJ7XZeDQuno06TPN53DhdHjttovWz2ujt
         ExWBEUlLl4PtEm2CYCQez+jZPIhKBmvGaz/t9QBdciSQmSV+Cu7N0+HMVZEo3j6ICGvM
         9bFkRWUulfWnVQ37ttjXB6K50hkeml+XYJsiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lPSksvhVy6YF41PEgDMAtPKdDYkNxoTk2/v3Z+Pnw3U=;
        b=EsvtVs5teinjmi1Mc2F2V0kt66Fe0KJzWNNzbXfBW4mdVFHn0cpB+eWstvFyBP+pcs
         Uw/MME6uO5/FyUPtN7zxFB41inhyJ2ITOv510OuO30eeX4NldzkCJnv3F6POefViHbjZ
         B7URF8FtDS6TXzbZL8BBPtSs5hb3Qb48wWOqmI69ibziI2m7H7bnoaayuapUOvIB9DWX
         Rjz62Zx2naaCsTCtXhgCiKntSuv1mNJmK2kSsUX/61WU9WjIxUwRvKfXNRCYmS4ee5DH
         K6zjAGjaa1Ic09ANtYD5ucozvSuiVNa33TOynMqAz9Xv22V7089jO2xo1zIEbNOdmi9h
         TBsA==
X-Gm-Message-State: AA+aEWZ9JHtz6Q4aiReinXIts+iLBLfKUMHZS1M2mv5JPzK9i6KCcOD6
        D7vZWiQZmbL/8Ulnl2F23DhWwg==
X-Google-Smtp-Source: AFSGD/UrEmXG/9jvBX5QIEa703+4lxlYPk5e1J3cvAoqX5YeuKr8rFF+YO1LAegNxRMu+9NfzZDIVw==
X-Received: by 2002:adf:8143:: with SMTP id 61mr2432403wrm.47.1544791478711;
        Fri, 14 Dec 2018 04:44:38 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id p14sm3618704wrt.37.2018.12.14.04.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 04:44:38 -0800 (PST)
Subject: Re: [PATCH 0/4] ASoC: qdsp6: Add support for audio over DP
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, asishb@codeaurora.org
References: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <83118861-b0ca-4ea7-b68f-a4db46774618@linaro.org>
Date:   Fri, 14 Dec 2018 12:44:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544790569-10608-1-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2018 12:29, Rohit kumar wrote:
> Add support for Audio over display port AFE port
> 
> Rohit kumar (4):
>    ASoC: qdsp6: dt-bindings: Add q6afe display_port dt binding
>    ASoC: qdsp6: qdafe: add support for display_port_rx
>    ASoC: qdsp6: q6afe-dai: add support to Display port RX dais
>    ASoC: qdsp6: q6routing: add display_port_rx port routing
> 
Nice work Rohit, All the patches look good to me!

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
