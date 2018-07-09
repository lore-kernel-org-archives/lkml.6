Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59FDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0D9208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TLbLApy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0D9208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933406AbeGIV6C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:58:02 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40186 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933328AbeGIV6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:58:00 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so38789846oie.7;
        Mon, 09 Jul 2018 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjDxdzolPn7ZmY0HPyyfqkVeUxoFjeOU9+DTxQgyoI0=;
        b=TLbLApy9MAWZGarYqOs/FByYOZ6HpEtb3Q2dzNtmC1V9z/q66TPWVlEtmSr4ar54Qx
         EteBr+eiM9ykrGIfWJ4GdrD4dWeuVKoAijFB0E0fFaYffOt56O5GtxPnmZk/fcza1PRb
         Dlt/8Uiv2Y0Mw4JikX47/XatZoEknqpqZRCRkY/iblMhlpHhwy+tb9S8WDTkPjmzofzl
         mHkE9HdX8wftd2OepNq75OCwyJjeoSHPDuDiobu8bjLMgCuez7URUPbD9tvK/QUXSEnT
         Dnlpwz4OdBOCG6AOMPkYMtNWe8Em2FaZaL2NsT2aMpwWJkz5uvIjYTWEcVNmzFyQz0q4
         yhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjDxdzolPn7ZmY0HPyyfqkVeUxoFjeOU9+DTxQgyoI0=;
        b=r5wAcR9YgOcFyj4WV3TgQxrJhxDbFDr1zwBdCXyd6dC4YTZg/Y3Hol9maYw0TY2Qt2
         fjmCmMqbS+h7hqS7kP0O4sNhBpmU3ArTa7OdW6QgQbtNBgzMSGbvO12vypHO9pjf++HZ
         qulkc9DtbkM6jXdoxnH1HB6CF648LIuCI+3YSCBZW5gGfhae2ttIGTkvVR8mHjogMZDC
         1Mc7mT/QPpkRcpl9RXO7aXDhJMhgmaVRT7nUg+yNiVYWk5j1DxmomZ4cJoyzJ4ToSIov
         aCs9rJoNxbyi5va/0aXhMy5y6iHFQs85WMdBcXg5DhMdu6ZTtU7TvbAUc045cWhxus5B
         6c+Q==
X-Gm-Message-State: APt69E0GLpDzAYMUewOKmVstXlWWmFSuT82fFknN/S4TyrOyeBAz6P+P
        I5ZRzzLdvSXLov+U3at6AlXsEB71r3BwW1AqgvuJknzz
X-Google-Smtp-Source: AAOMgpeY/QDmAiNFBr+1cfTmez12sayQ3iD4cjBSTW5mauIqK3I9h4/GiaQYYm3ngQWT78dyxeGcYW1yKmftjCufBno=
X-Received: by 2002:aca:c70f:: with SMTP id x15-v6mr26113252oif.97.1531173479848;
 Mon, 09 Jul 2018 14:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com> <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
In-Reply-To: <1531134767-29927-2-git-send-email-jian.hu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 9 Jul 2018 23:57:49 +0200
Message-ID: <CAFBinCBJp1xzo-CNW1HU-Odhrug31yQ7c3khB+XwvsNXp5-gTA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clk: g12a: New binding for Meson-G12A SoC
To:     jian.hu@amlogic.com, robh@kernel.org
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, devicetree@vger.kernel.org,
        sboyd@kernel.org, khilman@baylibre.com, mturquette@baylibre.com,
        yixun.lan@amlogic.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

adding Rob Herring so it doesn't get lost on the devicetree mailing list

On Mon, Jul 9, 2018 at 1:13 PM Jian Hu <jian.hu@amlogic.com> wrote:
>
> Add new binding for Meson-G12A SoC Everything-Else part
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
>                 "amlogic,gxbb-clkc" for GXBB SoC,
>                 "amlogic,gxl-clkc" for GXL and GXM SoC,
>                 "amlogic,axg-clkc" for AXG SoC.
> +               "amlogic,g12a-clkc" for G12A SoC.
should this be "amlogic,meson-g12a-clkc" instead?
that would make it consistent with virtually all other bindings which
use the schema "amlogic,meson<chip>-<ip-block>" (where chip is 8, 8b,
8m2, -gxbb, -gxl, ...)

see also: $ grep -R "amlogic," Documentation/devicetree/bindings/

>
>  - #clock-cells: should be 1.
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
