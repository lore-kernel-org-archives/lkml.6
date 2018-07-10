Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F61C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE0A208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="diPrB7Nw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE0A208E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933186AbeGJJ3l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:29:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751515AbeGJJ3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:29:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id b15-v6so13835977wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 02:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLXQsHpwQJV2tT5eDkh6Kl5lcvb25GB9y7Db4WxyYvo=;
        b=diPrB7Nw7OyRZn8B20B3BEzWgFnWi5nYcFkkRweb3kLVogkqPcxKEN5B1Rc9h4o7+7
         TeLk9p57qR1JIHCEKegRC2WDaJ4IK1uHTc0CjmtuVvhEDa1IwxG9IdEPxAXF8v64zvkj
         UX6J/0N4GWSW7ZwpEJWmvfPauBrKtdqpZQgj3olkGVF6b3pxGlLWiURhGDlwEOHnHct1
         +BHDfZOlI257BGDW1HTbx+hFKo43usr/h02yMjKS56eavaP9bKuyHrDap7yrT43onCUg
         gY79vZ6jcGibUeLln8YNUudBEk7cUu67QPXAa3rD2z9b3XmtbRQtUzfupxPg6S3nCrEj
         0Bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLXQsHpwQJV2tT5eDkh6Kl5lcvb25GB9y7Db4WxyYvo=;
        b=rOkuy5a3gz3q8HO8PY5ZEMsmeDS4bPGvpUt36h8zzL09SnsUK21VJXfckr1RmGmv/0
         kLIEHh2h/BuFO+cJpJkwZMpG+mLxNwpG97a/jk128tX+L89DfsLxRNsFW+GnFSHwgL6R
         8Kpla/R9a64bIOr3GD2LG+21SBsXDChhoUfng3dOY4KnpUk/wc9AZGWN3zCjbaF73x/N
         6YPLujkXQfvSN8d01Rdrf5YwEZ9pa3RmBGN+j45F5kODoMoRZIBW3XUavegQNAplYfJ+
         vPYOHejuFCHhOOeEr0pRzD0WnnDcl53tb73uLDiwZPs0uHxpf7dR20LqAAO2Yli4fnEi
         yXDQ==
X-Gm-Message-State: APt69E1AJitQh95TQw7epP2r6vTc0lr6T7LSXggU/UcF1uZw8SVXikzo
        Le/eFzAH6cdJPk8OvIhUfqM0Sw==
X-Google-Smtp-Source: AAOMgpcxlSEGLCqukTGom3/213q+zjAYrt8ABLORwKQOI9lBYK976bXljOwFU6MunDW9UOTEiKaWEw==
X-Received: by 2002:adf:9465:: with SMTP id 92-v6mr19043457wrq.283.1531214978229;
        Tue, 10 Jul 2018 02:29:38 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id v1-v6sm530893wrs.28.2018.07.10.02.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:29:37 -0700 (PDT)
Message-ID: <1531214976.2708.52.camel@baylibre.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A
 SoC
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Jian Hu <jian.hu@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        "Bo.yang" <bo.yang@amlogic.com>,
        "Xingyu.chen" <xingyu.chen@amlogic.com>,
        "Qianggui,song" <qianggui.song@amlogic.com>,
        "Sunny.luo" <sunny.luo@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 10 Jul 2018 11:29:36 +0200
In-Reply-To: <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
         <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-09 at 19:12 +0800, Jian Hu wrote:
> Add new binding for Meson-G12A SoC Everything-Else part

nitpick: I would prefer if the words 'clock' and 'controller' was somewhere in
the description.

Maybe "add new clock controller compatible for the EE domain of the g12a SoC" ?

> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> index e950599..0833006 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  		"amlogic,gxbb-clkc" for GXBB SoC,
>  		"amlogic,gxl-clkc" for GXL and GXM SoC,
>  		"amlogic,axg-clkc" for AXG SoC.
> +		"amlogic,g12a-clkc" for G12A SoC.
>  
>  - #clock-cells: should be 1.
>  

