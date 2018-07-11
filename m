Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7ECC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D74420883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D74420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbeGKPf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:35:56 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:40789 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbeGKPfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:35:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id w126-v6so49986690oie.7;
        Wed, 11 Jul 2018 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RoVJAnCBLNo/B3X5hXyvWjTekjcTqj8icjxDXe314nQ=;
        b=CkwMrGdIndd0R+EwTZINRr/8lx3NyY8wkIAlSqoIgEodG7Qn3AkBRL+/JQyO40+Ccw
         URK1vzVPT4GSBjIP4L5K56jElpp/C7MDUcvRfUbX02V1DUgMa58Itt9Kk163iV7Bc3Ky
         61JwfXbeoNfH6Z5K6N/MUcRcyM8JZDNaYvly8uCHTnER5ZncIKR75jsJOtn2dBmWpIpN
         eXwJ5wEAQLAEsVRqnQnOoO5+vqr4ABtpPYVZZM1lxe5FAIzwt2TbYSGkyhCTO4IDhtdl
         00tEWUc5q9cGjGxE+VHee7Vk1ZmbXu0uQiatdmvqyzueDXKWvJOhSsP+gB1XGApnLWuX
         OeGQ==
X-Gm-Message-State: APt69E38UkMGXm6WjnlkIn6IHGN834rKCDB9JE/F54heGifNw3XgH35y
        1pp+8kvlaMN58zoztx2G/A==
X-Google-Smtp-Source: AAOMgpebNx6MkhsLq7nwUpDQahjzaVKDxuBaJkbmNEfVyqhG6rrTu+cya+O1Pmm0y+ukcciVZ2tFGA==
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr34339838oif.290.1531323063697;
        Wed, 11 Jul 2018 08:31:03 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n84-v6sm18486oif.23.2018.07.11.08.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:31:03 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:31:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ASoC: qcom: dt-bindings: Add sdm845 machine
 bindings
Message-ID: <20180711153102.GA20357@rob-hp-laptop>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-2-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530870195-13576-2-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 03:13:11PM +0530, Rohit kumar wrote:
> Add devicetree bindings documentation file for SDM845 sound card.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,sdm845.txt      | 80 ++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt

Reviewed-by: Rob Herring <robh@kernel.org>
