Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF0C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A919820866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHk5BADs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A919820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeLNJRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:17:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50888 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLNJR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:17:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so4976533wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 01:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7UCphVpGxcgorfFMBuUs6+drT6tpgBRcwZsgdfxlhF4=;
        b=CHk5BADsuqOP/zMPk6h9fYHYJRhPt5i4RFkjYeHyiAlqQZUQj5DS70zq5W5O5WlHEL
         L9FNz24uf4eYK1XoruC11b0/4hiXrzxH48FU1SHEMQdfoQ4OZQOV9VT5v0Sj0gFr9CHG
         ToD3N2JY3ymOLXEsjqDRJXOnDp6EEPqx+W9+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7UCphVpGxcgorfFMBuUs6+drT6tpgBRcwZsgdfxlhF4=;
        b=IgHlxooU/1vPn9l0Juz2gtnMmwlsfVm2TXSs19H0qHbfQNmbvPUfoR28ugPz8J27uS
         U+Vv/ceWccLE72WN7iCmSwXdUqFZ42JNwbUeBzN9H/X2300ZLUrObFy0gWwYbH12msMs
         B/TzYoEkJfzwz9hLEwtb0iAL2i5045b7PXbR2PQRGvHTzegSm5lxWrANJ75beFfQB9ny
         +yIvBvjVvHWjJFDOOfaQo3LeOzQRriMWSN5y6Q4DOfDv6AzNiPc4DKm/ctOL1uJw9Ybo
         +ih1gAkzBGAEI5i2gKrjy5QhCgIIlagkdWPUIkIXJkJ6Sr0+3NG5DqmdeFgRBirnLDop
         V2wg==
X-Gm-Message-State: AA+aEWbCAYD4sa6z+xP+xkr2bXLcXQvolouSxyiaIwnxAofpw+b1e7pe
        54dzJOWMHIAXA9PH3Ilu988I4Q==
X-Google-Smtp-Source: AFSGD/X/EA5xiLHEZ0OUya6FXxpT2ZTa9Gbbt5BVpadmOd95AyCBJvVkI5EidKP3n0i0FLL53lnYsg==
X-Received: by 2002:a1c:a58a:: with SMTP id o132mr2712844wme.6.1544779047107;
        Fri, 14 Dec 2018 01:17:27 -0800 (PST)
Received: from [192.168.0.40] (77.37.95.92.rev.sfr.net. [92.95.37.77])
        by smtp.googlemail.com with ESMTPSA id b12sm2861827wrt.17.2018.12.14.01.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 01:17:26 -0800 (PST)
Subject: Re: [PATCH v2 1/4] dt-bindings: Correct RISC-V's timebase-frequency
To:     Atish Patra <atish.patra@wdc.com>, linux-kernel@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@lst.de>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
 <1544742869-19980-2-git-send-email-atish.patra@wdc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5d652370-4782-23b2-9896-b9666b3cc1e7@linaro.org>
Date:   Fri, 14 Dec 2018 10:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544742869-19980-2-git-send-email-atish.patra@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2018 00:14, Atish Patra wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
> 
> In RISC-V systems, timebase-frequency is per cpu instead of one
> instance for entire SOC as there is a individual timer per each CPU.
> Fix the DT binding accordingly.

Why not use a fixed-clock instead of this timebase property which forces
to declare a global variable to be exported from arch/riscv to
drivers/clocksource ?

In addition, please add the 'Fixes' tag

> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [Atish: Update the commit text]
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
> index adf7b7af..b0b038d6 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
> @@ -93,9 +93,9 @@ Linux is allowed to run on.
>          cpus {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> -                timebase-frequency = <1000000>;
>                  cpu@0 {
>                          clock-frequency = <1600000000>;
> +                        timebase-frequency = <1000000>;
>                          compatible = "sifive,rocket0", "riscv";
>                          device_type = "cpu";
>                          i-cache-block-size = <64>;
> @@ -113,6 +113,7 @@ Linux is allowed to run on.
>                  };
>                  cpu@1 {
>                          clock-frequency = <1600000000>;
> +                        timebase-frequency = <1000000>;
>                          compatible = "sifive,rocket0", "riscv";
>                          d-cache-block-size = <64>;
>                          d-cache-sets = <64>;
> @@ -145,6 +146,7 @@ Example: Spike ISA Simulator with 1 Hart
>  This device tree matches the Spike ISA golden model as run with `spike -p1`.
>  
>          cpus {
> +                timebase-frequency = <1000000>;
>                  cpu@0 {
>                          device_type = "cpu";
>                          reg = <0x00000000>;





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

