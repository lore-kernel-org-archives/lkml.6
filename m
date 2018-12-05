Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D912C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFA22084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yij4jRbK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CFA22084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeLEOSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:18:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46776 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:18:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so19859047wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Fk6hYpsfUzbo91T2VasLZrL5SR5D7KS19VvEXx8ymHk=;
        b=Yij4jRbKEjpq/RoPHhGR+06a0ymDMfyjN7S6Bvrj7HT+vyK1YRd/LnufzWA/zVhd8I
         IyMwU/eenoNtgVHO+Rtg4WfBld/LMHnMDGu6K6b6EhYm9zvZd52kwv9g+3i7VcnStNKw
         3dVmhL1uDxtB8tdl7TfgyJXxpIgsefBTMsnoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fk6hYpsfUzbo91T2VasLZrL5SR5D7KS19VvEXx8ymHk=;
        b=frmkJ6UtfH9uLQRSDzZCwYByh4J57L24cWwtJZpfzY734u15sgQORkTqTI+5SrbetX
         jq9uQLh6YjSyySbD2dywZfSHiJoZx7WZsXw16yyTxQv2oRMA5bsGn10FPDdZZEww43QH
         nesPvNcfkbjv84TyAdVHAqKMS9xr9cFG8zvt7ab3ykJ+S26jGVioM89uoCz3KH/xunHl
         bYLuK6jjzesawgLYzkgLKj1ueaxWvTPa8OrsogrfJOWksJEv1tcC314W5hQxFZwgKY83
         iLziBLMqAy0CBnTXj+cdtv6uNp70Mp3Y7Kz29lm6N8ijKpFxq1opym8WYCHoGip8fnXP
         Xqtw==
X-Gm-Message-State: AA+aEWZQcL/1DOGeGmIoceY6obbzPDRzIN2OuHPhJ1YBqlnXrIYBX3h1
        NEGsoA8Ol5Np1oYF+5mSMJB8nQ==
X-Google-Smtp-Source: AFSGD/WB/Tsi+82caStlAXL7+L9U/4bgulEQ8HjgF14xKW1Q3x+p9AM662uicJcG9I5Bgp7U94ACSA==
X-Received: by 2002:adf:f703:: with SMTP id r3mr21659785wrp.93.1544019507828;
        Wed, 05 Dec 2018 06:18:27 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m4sm19207790wmi.3.2018.12.05.06.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:18:26 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH v2 1/5] ASoC: qcom: sdm845: Add board
 specific dapm widgets
To:     Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, tzungbi@chromium.org,
        Mark Brown <broonie@kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.org
References: <20181128090037.257359-1-cychiang@chromium.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a6401825-6ca4-d187-5626-4843c660c7fb@linaro.org>
Date:   Wed, 5 Dec 2018 14:18:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jimmy,


On 28/11/18 09:00, Cheng-Yi Chiang wrote:
> Add board specific dapm widgets so these widgets can be used
> in the route.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>   sound/soc/qcom/sdm845.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 


Am not sure why are you sending patches that are already applied to 
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/log/?h=for-next

It just wastes other people time in looking at something which is 
already applied.
Also it looks like you have not picked acked-bys on some of the patches!

thanks,
srini
