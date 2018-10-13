Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9670C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7861720693
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfEqni4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7861720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJNDU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 23:20:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33542 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeJNDU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 23:20:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id e4-v6so16863463wrs.0;
        Sat, 13 Oct 2018 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ENsa8mKA+KYkiEx8WLYfD1y5jJU/TfSdYYuBy4wsARY=;
        b=MfEqni4r7gugGbRVeFZc/OiTvtv96qeAh4+PCJqG0vDxOZ+QVNgmyq3KvIxBtrfb0s
         ckcfJJyAJUK+NzxITaqCII+ohHnuGNSSBprb0axyBcV1sqCDqQbTrKsRaZoJLPfJYrcs
         7LJt53TAX/4p4fgWzQak3awH50Meh8vQ5U6792qHISQZYwgFWGlCcXjGyj/GEMGSHYRZ
         +7YJQcAjuQ7nFr3SVte+QPHrq4JBZEBVeUma0olj8nA2PYX0KH06RGOwXphzeBGW8io0
         A9jAqqu+BEqitG6uA17NM4+/9iFWAFxAquILG1pHN77uzFAs7sKAikadc0PgceRU1FUL
         hOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ENsa8mKA+KYkiEx8WLYfD1y5jJU/TfSdYYuBy4wsARY=;
        b=UOkiY6/X5bkUCrqVX/7mgxX7wEaupr+MePNINuFz9ALrQt8EeRHGMzjSQ+32RLe/A2
         V6ujipyBbcxrnoVyFTWw0Hdh76edjalvG+g0M1ck7s3xkNMPPgehTsAWnIhS1YyQcN6j
         8XsMGgJvdFrVQ3MfdtIwikrOfjKN3T0lw1hjb55xwfDbJCCiv0AaVduqNbeGNkQJGufk
         junpZx68ujAdxN4Teb8vYtoxo80sc7llg63xfM8+75F9cv8aO9ThRG3z2y8cPjhu8hbS
         WP1zEgxRpwCoYskfs/4NQrHiCdlCLhbpgjs9+C85/mCn94bhBGGb8NpnRLYfoLeiIHt4
         GhKw==
X-Gm-Message-State: ABuFfogIPYNvRHpIt4h28C+fS4ci2BfI79PCZgXwxjrsmilT9ltuDJJu
        6dhsGOE9IVWfyED1S0GrvrBZOwT3IJc=
X-Google-Smtp-Source: ACcGV634FjblERVVJ6u7MGTI2CnjquLzD+eRer3J/7Pdf6zgNuNqHJwiF/g3rAfNzrDjxMTjOWzy5g==
X-Received: by 2002:adf:8141:: with SMTP id 59-v6mr8715867wrm.127.1539459727435;
        Sat, 13 Oct 2018 12:42:07 -0700 (PDT)
Received: from laptop ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id s1-v6sm4229601wrw.35.2018.10.13.12.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 12:42:06 -0700 (PDT)
Message-ID: <a6e3c6c059a4a593d7c9228ed260ea24f993a3f6.camel@gmail.com>
Subject: Re: [RFC v2 2/7] dt-binding: interrupt-controller: Document RTL8186
 SoC DT bindings
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 13 Oct 2018 22:42:04 +0300
In-Reply-To: <20181012201346.GA17471@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
         <20181001102952.7913-3-yasha.che3@gmail.com> <20181012201346.GA17471@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-12 at 15:13 -0500, Rob Herring wrote:
> On Mon, Oct 01, 2018 at 01:29:47PM +0300, Yasha Cherikovsky wrote:
> > This patch adds device tree binding doc for the
> > Realtek RTL8186 SoC interrupt controller.
> > 
> > Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Jason Cooper <jason@lakedaemon.net>
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@mips.com>
> > Cc: James Hogan <jhogan@kernel.org>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  .../interrupt-controller/realtek,rtl8186-intc  | 18 ++++++++++++++++++
> 
> .txt
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, will fix for v3.


