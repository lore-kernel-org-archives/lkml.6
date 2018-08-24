Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B66C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F3C20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxiHgi5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F3C20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeHYCsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:48:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeHYCsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:48:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id m3-v6so4016552pgp.6;
        Fri, 24 Aug 2018 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4yt0+fkTmJPxcnY0ORt8RlwbWhFVClTOW3vRQfmFe0=;
        b=UxiHgi5ICdS1kbRqJ/N2GTwWuLuqHPm6wtoenI6Wh8WEH7cENzQuJdnvZPcg6KXodH
         aJKuo4P/PSUdTmpX600ra8hQgVKTOL9jvgInkx8Xm9OEN8AiFr5dtYcwdu7s76zuR5KJ
         ykYuux3Y8ytFmlRIng4b+7s2412VuD0bsI1rhI2toEtdDvMq3f91hcQv+5mVVQ4lXgbA
         ZaEkePNfLZai5h3JzRUKfU9vz1EuDepkyfS4sJ2KwsNQGgjw3/u+0jd/6xpoj2OYyNKh
         TMFNdIyFR2X7mTbkxBhRzWFxUmLdmTQgNCwDu9gppObndC56J23miLnUdUi2v0t9pYah
         cRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4yt0+fkTmJPxcnY0ORt8RlwbWhFVClTOW3vRQfmFe0=;
        b=D5pDr9RrVzYGEPDhdCkzpz+ZkTGrHt8xChY8n4Af7YWu0Q1B9/y1QiZVXZ7jmNukzW
         mUAj8mvzMqof5TrvkBWeqm4gqQzYXgeHWdAQFFc5JQEjW502piVMCy1mQXgn0ZRvQQ9T
         O+GnKwH2VircpwQimVHhh4+h2BvNJyWL6p5VR8vHHMLCs9ltRK2l0YltVbyFEn6t3RKq
         vrPZqrISsTXFAZ/XMrpWqbXAnKNASglpnhHz12t7hIeUowgO4S3kHHG3VxrKB19KTlvH
         D9tGbQUm2vMu5CvRC7Swx4l7p2PBXMUnE0EopSgbpUYVOk27qHe/loG4LCvr+EmCCdMh
         E39w==
X-Gm-Message-State: APzg51CYnnnbc0jSS+HDcrCbw4QwocfkluuL96PGbIleweXkEvcHoepK
        czIN25OBXvUQVqWs/zLpto4tscGoqkI=
X-Google-Smtp-Source: ANB0VdYbO8OpfseemS9ZEuHaeNlYm/ku4hHHfQo/Jfv+r27XUH0Rso66l6bkO7mBctPUEpyPo5gpSQ==
X-Received: by 2002:a63:495f:: with SMTP id y31-v6mr3448821pgk.32.1535152318737;
        Fri, 24 Aug 2018 16:11:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id p73-v6sm13101142pfk.186.2018.08.24.16.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 16:11:58 -0700 (PDT)
Date:   Fri, 24 Aug 2018 16:11:55 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix
 documentation of 'reg'
Message-ID: <20180824231154.GA25163@localhost.localdomain>
References: <20180731185917.176074-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey

On Tue, Jul 31, 2018 at 11:59:13AM -0700, Matthias Kaehlcke wrote:
> The documentation claims that the 'reg' property consists of two values,
> the SPMI address and the length of the controller's registers. However
> the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
> the controller register length from the documentation of the field and the
> example.


queuing this for next merge window. Applied up to patch 3. both
dt changes go via your arch tree and you can add my ack on them.
Acked-by: Eduardo Valentin <edubezval@gmail.com>

> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v6:
> - patch added to the series
> ---
>  .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> index 290ec06fa33a..86fb41fe772f 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> +++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
> @@ -6,8 +6,7 @@ interrupt signal and status register to identify high PMIC die temperature.
>  
>  Required properties:
>  - compatible:      Should contain "qcom,spmi-temp-alarm".
> -- reg:             Specifies the SPMI address and length of the controller's
> -                   registers.
> +- reg:             Specifies the SPMI address.
>  - interrupts:      PMIC temperature alarm interrupt.
>  - #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
>  
> @@ -20,7 +19,7 @@ Example:
>  
>  	pm8941_temp: thermal-alarm@2400 {
>  		compatible = "qcom,spmi-temp-alarm";
> -		reg = <0x2400 0x100>;
> +		reg = <0x2400>;
>  		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
>  		#thermal-sensor-cells = <0>;
>  
> -- 
> 2.18.0.345.g5c9ce644c3-goog
> 
