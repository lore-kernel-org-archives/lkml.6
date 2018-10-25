Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AACECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F51C2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F51C2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbeJZGTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:19:16 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35476 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJZGTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:19:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id 22-v6so8042555oiz.2;
        Thu, 25 Oct 2018 14:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I8jW87Hc6IXgDYXGOkJ1gRBXx3uV31YGzGLwPBoOH5I=;
        b=JLuMj1UO6t61X3OwOA10GoM/NkW4Ad9o/bErVGjQQf6mSiiIdyQPecv8T1EVh8nWmI
         l9Uk0LvqWmb6MCBWnA4bdg6Vs6+zJvMbBcPFLScWM0VEoI1nlvPmarpaCS7Tn9XF19uB
         Qcmh2wkxOB0tYeItVWMkDkCcvYskugVkMtvNaEekslEwjkCtyKdL8ookHARYk/VhqzZQ
         oXdUvv0mbch0Po7msiBalMzRLZKhCahfv/tBHPpH7SNpdoPZRdTpP2kDdjjPH51hIv5v
         AvtIUD8uMUU8kIxny6FZ2wWjo4smpGDAKcHcI0UwnTNiH20aQwHnkD0H4MJljtmly+uM
         Kufg==
X-Gm-Message-State: AGRZ1gJ1aS3OOh4IRe7b/Q0EmMpuxT5zNx5jnjEeRkJsu/84sqPYG2VY
        kaBIpeomusM8TV7fjjkfZA==
X-Google-Smtp-Source: AJdET5eiZFnUHh/tnem+wqrr3h0S2tzQX9Fz+1ZWnKRn0Ej7vXMWm4kObiY1UhKluAcLpSaQ1eHTsg==
X-Received: by 2002:aca:f1c5:: with SMTP id p188-v6mr588593oih.130.1540503892638;
        Thu, 25 Oct 2018 14:44:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m63-v6sm2855053oia.30.2018.10.25.14.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:44:52 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:44:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     dmitry.torokhov@gmail.com, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        masneyb@onstation.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        jonathan@marek.ca
Subject: Re: [PATCH v3 1/3] dt-bindings: Input: new bindings for MSM vibrator
Message-ID: <20181025214451.GA4937@bogus>
References: <20181025012937.2154-1-masneyb@onstation.org>
 <20181025012937.2154-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025012937.2154-2-masneyb@onstation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 21:29:35 -0400, Brian Masney wrote:
> This patch adds the device tree bindings for the vibrator found on
> various Qualcomm MSM SOCs.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../bindings/input/msm-vibrator.txt           | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
