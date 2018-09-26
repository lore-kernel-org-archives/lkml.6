Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD2FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518CD208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKKU5wTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518CD208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeIZN4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:56:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45135 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIZN4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:56:00 -0400
Received: by mail-io1-f68.google.com with SMTP id e12-v6so22497785iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKX10PnVlp0eohc+w1DrbmLk4ZSr3ERUutwcBjyF4JY=;
        b=BKKU5wTij94eE2U87PyAejEmFW3b1OGTljBXE2fv0WitJG5dQtxIy2lKOYtvJ6PcjA
         nNCSMjXM8L/0aWzowFxznbNFx0r81UNyDTsQ+QdPAfU/NtiQOZiR8A6WO4p0VP+wZY69
         vmIMNi2XQIoPTTspdYOKoRP1rBhuIdC2fD+OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKX10PnVlp0eohc+w1DrbmLk4ZSr3ERUutwcBjyF4JY=;
        b=WZcY5ys8GhOJGXDIkaAsPHOTwAmw8wL3E9nZKekjArEFoYJPj0ue6IMCglG1qAW6jr
         NOnQXYnR2jdO/tlMIZ+JDj8qaX3drtbdE++VvhUhSW/q7wmXXH+DNAr4Otx/huIg+1W4
         ALUVBDEDiir903PgDToVdQOJIchG55CVcmsswFonojgxWAxfKDsYVNZtSASLuZvgOlUY
         nm9vbyzzGyN6F18xtDCAkXqBLcA3kXQsuzE0zl04pWo+E3XZcm3wcLXunJq2OaBgtSN6
         Z9hFuHo7uu5o/GL6rUhXU93HMrLmgRz5WerqOCRk64K1O9iYqLRFp5bq6zCpp7/tFA/M
         Rcpw==
X-Gm-Message-State: ABuFfoi9YRvWRmllmmKrqnmNDvowY8HHmUQTsl8Nu20SiGDvf3OxUZ5z
        aC+uH0XyfvZvglogQmlh5LGWFaW+4zUjv17c5Nq/AA==
X-Google-Smtp-Source: ACcGV63pJt2gpSdBkctsOVs4tSPPhw17p7E1Nc4IFs4kjKGtFDR7FY3qPNSaKqtG/vg2fGAQ3DEU0MCEoEcxU7vBBLI=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr3957689iof.304.1537947863866;
 Wed, 26 Sep 2018 00:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180920013712.2361-1-bjorn.andersson@linaro.org>
 <20180920013712.2361-4-bjorn.andersson@linaro.org> <5baa1afa.1c69fb81.5cb9b.99f3@mx.google.com>
In-Reply-To: <5baa1afa.1c69fb81.5cb9b.99f3@mx.google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 09:44:12 +0200
Message-ID: <CACRpkdYdmBM3_o=U9VRSDt3DJEH-nyJ4pDiwnzs4VttAEEnBWg@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 1:24 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, 19 Sep 2018 18:37:11 -0700, Bjorn Andersson wrote:
> > Add the binding for the TLMM pinctrl block found in the QCS404 platform.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  .../bindings/pinctrl/qcom,qcs404-pinctrl.txt  | 200 ++++++++++++++++++
> >  1 file changed, 200 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
>
> Reviewed-by: Rob Herring <robh@kernel.org>

I put this on the v2 patch where the only change was a dropped leading
zero in the example (sboyds comment).

Thanks!
Linus Walleij
