Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD75C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F193C217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519572;
	bh=RSnV7q5gy6Lk9foJI+QJSzaz+IkyKY/HcGz1futdpk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c/sTwcmpd8EgwF81MIjMC3cwjQgR626es3x3FOXizVTCXfOcIg+31yMJaK7hALs/x
	 2rJ/AUgKIlfcCmkfVvBNujOwuaBxKV+wrRfIdnpM84g2qgCwuXlMnOwFvDPResVJpH
	 M8AnVN2mijEWKVgCLzqkD5qiObg9K8QNk5o2yH+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfBRTwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:52:50 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37935 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfBRTwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:52:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id m1so30311922otf.5;
        Mon, 18 Feb 2019 11:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dul4gDcTcJLKAu48vsv5MVk63uYOFdmwUVkWPuXdNcg=;
        b=XcmjfDqGysQ9ODCPTbuyPLvzO+Z2y04zS4dXgOUA3HhvXRUC+eQX0rGrYIDwQtedk+
         CjlbEM4Veejdhqb6LkPF4oyL3Yp4x69pjwChUFTUYMuObW6kpcS2lLtCIfavG/1zaUum
         Y6BfkkCGkDUlmmn+EXp1Phj2/IHuyP6HLdnQSI71HEORqiCulJ0vLZKKKkNAfKcnH0sS
         oi77KQHdgDPkC20fuc/hDpXGHGEL8rN3mdpeZBTLm/shz88/Hn+Ug6Tj5QFiA/3xzz8l
         pckaKYITdvdlbppi39Gkr05BxhQZ83GQtns7Dkjfqv26E/fNvWJEDVKsk6n5erQZ6n7c
         UI0A==
X-Gm-Message-State: AHQUAubatGbD+4lJRERHkhpUXHMPSaW4aamhCnUV1wrBqx2aGwzJ7Jei
        3aJ2GC4LRVs68hZMgm1VeFasVdE=
X-Google-Smtp-Source: AHgI3Iandc2NMqRfUvwDzmyh3cKf7Cu7hQrQU0sHviPbQ7LxyG9r0nntfq2Y67NXzIaDIBcfSCQBRg==
X-Received: by 2002:a9d:152:: with SMTP id 76mr16553146otu.259.1550519568890;
        Mon, 18 Feb 2019 11:52:48 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l108sm6113513otc.23.2019.02.18.11.52.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:52:48 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:52:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH v2 03/15] dt-bindings: Add documentation for Milbeaut SoCs
Message-ID: <20190218195247.GA9690@bogus>
References: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549628764-30587-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:26:04PM +0900, Sugaya Taichi wrote:
> This adds a DT binding documentation for the M10V and its evaluation
> board.

Most boards/soc bindings are using DT schema (yaml) now. We're not 
requiring that just yet, but I'd like to not add more. So can you 
convert this to schema. 

Rob

> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  Documentation/devicetree/bindings/arm/milbeaut.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/milbeaut.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/milbeaut.txt b/Documentation/devicetree/bindings/arm/milbeaut.txt
> new file mode 100644
> index 0000000..9fd053a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/milbeaut.txt
> @@ -0,0 +1,6 @@
> +Milbeaut platforms device tree bindings
> +---------------------------------------
> +
> +- Milbeaut M10V Evaluation Board
> +    Required root node properties:
> +      - compatible = "socionext,milbeaut-m10v-evb", "socionext,sc2000a";
> -- 
> 1.9.1
> 
