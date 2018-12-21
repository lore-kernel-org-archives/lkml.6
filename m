Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A97BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC11206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 11:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZuFAoMV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbeLULDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 06:03:10 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:39981 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389954AbeLULDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 06:03:10 -0500
Received: by mail-wr1-f43.google.com with SMTP id p4so4803273wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 03:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fASZqrnxIf0HySSUKVGNJo9EcPSrUZowZgwuAGXp6yA=;
        b=AZuFAoMVge1yh513gfCqA5jtOfu1b+sBGTVKBBicltQG/3pst7sflRzCIcItn2ZWNy
         H/deohkmP1wAm+ZuUQ27PIQi3/rXr4NHxfFbckuhpF3ufiAp/w4N+3UgVbZ7jbQ324mP
         /zWESGxat758VZbJ0jpLINbW4GJJcNAydNFyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fASZqrnxIf0HySSUKVGNJo9EcPSrUZowZgwuAGXp6yA=;
        b=ZEq7Rv7PbEiaMdk2UV46bzD8k0wOws25VM0+5iZjQah0+6F0bGCtm9lHV5ltVw0V5A
         3DVomhzvP6IKoUWpsXimBFHGnwPE8l9tbDNFiRDkI/TTxMuCF4BHtG0Cd/GbVWfUvmUN
         hQeml5c0/spBQYH6N7kFLIQcsd/tSZProbu8YDr7cRl8+ZThOT9zcEkOFlYmxZvQiXsu
         iEiCu5kNpS/tq8dwCEZjLhVowB3d1Z+550KeWfMpuJPs8T6amJeGu5OJrYflCOPc0V6m
         MQgX7uHKeIqzyaOnyE+L8DiW9XEasp6K3gk71v6MW686ojxY9UyHJNw0duplGXT2sXaE
         e2SA==
X-Gm-Message-State: AJcUukdqyAvVfbJnVycstE93wCrXkPYgKX6NpToKTo+zLCKAkXKUUWNg
        jV9xnW5mWjipETQM7Dhx4eQePQ==
X-Google-Smtp-Source: ALg8bN47bNWZpx6ZefsIu/EiA9Y5S090L2X2HmUFTifoCTg8v8ZQ5dLLQ5sPjB6W2GEDedwmZDS7IQ==
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr1982575wrn.73.1545390188125;
        Fri, 21 Dec 2018 03:03:08 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id a62sm9577312wmf.47.2018.12.21.03.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 03:03:07 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:03:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [RESEND v2] mfd: cros_ec: Add commands to control codec
Message-ID: <20181221110305.GP13248@dell>
References: <20181218090626.46625-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218090626.46625-1-cychiang@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Cheng-Yi Chiang wrote:

> Add EC host commands to control codec on EC.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)

Re-applied.  Clean this time.  Thanks for rebasing.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
