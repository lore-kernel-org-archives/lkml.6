Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5429C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D92075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp6odfYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4D92075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbeIFUSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 16:18:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39842 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730342AbeIFUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 16:18:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so5484170pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TdOEH/ArQN/TM8QP7eG0uNP+WJggPMoEBy/TP4J47fY=;
        b=fp6odfYxdqP470ks4HaHYwYpZXhtZ83HEue6uQETfb0WAr6Jfnkw1/naiW8GsBb4Ba
         KDeSpzDjYleJw0zHpAD15At52mc8rt6kEIrZ6izRrPxajqeQfcqoNS6yClcXOHVwk57C
         OrO5DQ9SSaYtQ4jlyiPDGP/46k80OL1cAq/h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TdOEH/ArQN/TM8QP7eG0uNP+WJggPMoEBy/TP4J47fY=;
        b=MhFWoaqzgKH0ki9c7+yoZYRR7GJHSdmjnlsrR7v7rxSvuIWldProlg2MVMdoBK2TAe
         QDxP4G+NBzWOLdzCmdnaOSzR8HTxcT8rYj80okyUpOGigA2THXKSWHqlP1gwTuONmT8y
         kcD17qtK3+o/ZC4eqY29Jg26scSRc80ojoWbqo7Xgk5h0JlFVETFwsM8H66IRRtS6MiO
         P+ysoz+WADTaJqzH7gjQYJgHmR+fenHpKxUh2eulT71vfM67rE/Mn9DUvuYlevMV+63W
         0OKY9ifsfPc9nf7vyEhUXNskAf0z196cHZPxtQ7G7vcS5xyB5fJgKC1n6C/cFTSZ9zaQ
         a3BQ==
X-Gm-Message-State: APzg51ChqcmD8iDmgfRDQCVIltAE8pQtz1Y1qAB0+YwCUieXo5E0Zyom
        nisRN27CIRF26VyZsL3axeRT2Q==
X-Google-Smtp-Source: ANB0VdaE2kgiU9K/vxG/GxQ7NMH+IcwwZK0IfX83BTv6029TlihL3T3tQ2SK5Z93UJ+ljHFDyfggmg==
X-Received: by 2002:a62:46c8:: with SMTP id o69-v6mr3518485pfi.21.1536248550534;
        Thu, 06 Sep 2018 08:42:30 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j27-v6sm10438334pfj.91.2018.09.06.08.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 08:42:29 -0700 (PDT)
Date:   Thu, 6 Sep 2018 08:46:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/8] arm64: dts: qcom: msm8998: Add tsens and
 thermal-zones
Message-ID: <20180906154627.GA3286@tuxbook-pro>
References: <20180904050123.26601-1-bjorn.andersson@linaro.org>
 <20180904050123.26601-4-bjorn.andersson@linaro.org>
 <CAHLCerM2por+ES+OhH2nUOOPF_tmYjk6zGdw-2dr=JRu5Jfrbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerM2por+ES+OhH2nUOOPF_tmYjk6zGdw-2dr=JRu5Jfrbg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Sep 06:53 PDT 2018, Amit Kucheria wrote:
> On Tue, Sep 4, 2018 at 10:31 AM, Bjorn Andersson
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
[..]
> > +               tsens0: thermal@10aa000 {
> > +                       compatible = "qcom,msm8998-tsens", "qcom,tsens-v2";
> > +                       reg = <0x10aa000 0x2000>;
> > +
> 
> use the SROT and TM split for v2?
> 

You're right, lets use the new style from the beginning.

Thanks,
Bjorn
