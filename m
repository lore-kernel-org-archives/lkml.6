Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D50C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B15F21725
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B15F21725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbeHNXD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:03:57 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36545 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:03:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so8761277plb.3;
        Tue, 14 Aug 2018 13:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nMoYNTSGMVuKPdmK/7b4F9EmNEYBDjphHPxHoDoCsgg=;
        b=DqXcQ93U4V2J/gA7hhTWPeC29pZc5dLmraxdQC+9rdCGsCDF/KW1gIoxuVt9NWf+G+
         4JP/GWD/BXB2r6xOjya1nsQ08YIBnnXioTPoDo6IitNI6j2OjYfh8mvneV8KzU9PoDyD
         +oqG5J68MXvpRP6ZS1eqyhrr8I/cBHWoAEBI4kK5fvkgJBTGpDDRETf6y2GrTVCH8hR5
         jNnLOc/duGknCAjP8AZnfT13q+/Gr3BxRznJpNd9lIzPGDrJud3g0C8xj4AfzQwIw02T
         LL2CdYFKzz4NXAfugrQ1knRC+DrCbjhx5yaF+M7q29l61Ua6Liwwx+NANaoD1mGCnhVW
         aIWg==
X-Gm-Message-State: AOUpUlHamRLYSWhsKMQJA+4mcEC1L6NAc/A5y2LZH1KZgCb0O8tutNfi
        vWboC4pgNs/rpLy7c5PRMA==
X-Google-Smtp-Source: AA+uWPwDebSa3dWRYQtlwineMzqLrux+T+fg+6ctVBMYwGX9THqjbB+LMG4GDQIuf6YAOb9JohmwtA==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr13774401plk.133.1534277707399;
        Tue, 14 Aug 2018 13:15:07 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id r198-v6sm51222118pgr.8.2018.08.14.13.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:15:06 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:15:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v0.1 PATCH 3/7] dt-bindings: mmc: add DT binding for UniPhier
 SD/eMMC controller
Message-ID: <20180814201502.GA26094@rob-hp-laptop>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
 <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533622642-13989-4-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 15:17:18 +0900, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> This SD/eMMC controller is used for UniPhier SoC family.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../devicetree/bindings/mmc/uniphier-sd.txt        | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
