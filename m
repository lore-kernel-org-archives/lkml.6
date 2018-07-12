Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1C4C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D2121475
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U2+bOgTn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D2121475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeGLFLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:11:45 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39468 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeGLFLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:11:44 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so23099248qtp.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ufqvxcUy98e9ZkobqyQmGhNUR7lvR6XWEDUj8Oj7DwQ=;
        b=U2+bOgTndfEP4T+08xIWCQPZKgqvn8uckcsojv0ksA2BMC+diSzuKGs1AWmcKMQjPQ
         /OpmADTXBeAQP7FzCCisPPgklzi9UJFeQoI2oywsWWWM9rK/igknlIaspcBhbt2e928z
         gg/aQXsHjdryrbgq4ACqtSwklEL5YxX0onY+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ufqvxcUy98e9ZkobqyQmGhNUR7lvR6XWEDUj8Oj7DwQ=;
        b=rqrAdOjMMVzmrnaqN8arzXtrYJ2Cx+6fOTAefFY3EGcoN84N3ixid+ApNKm9dya2z9
         JSn78msuTBUwKaswdzvGuqNpbbTw11pj9QgJcrI9bpuM57ikWL20H/yGCHIUTpAI8KA1
         2Ts90x0j/8a9IXFv3HD4eq2l8og5tHFHEfcUs4CuDh84pCWPPbKSu/9Tk0LEIvz5ZhuB
         o4V6mIVIprf9AywwqZiqDL0OH1qHg79W+CMYNxA5J+PiiBwfBCgx4LhCmgyZJecDrdGD
         7bRdW36HNW8BnahC5z1cqz3xynORffIOvXrSBPhQh3ynZ5JXFNJN60XEQtJ++n1SXv+G
         UfXg==
X-Gm-Message-State: AOUpUlGzilIBpW98LJVfQD4Rv1Sa7WwTUbux+K+Lc7P8leKFN4ZX2jal
        Cnr2yzri19V5PyAlqSycGT4zBc1GLIPnPZ0VKCnxNQ==
X-Google-Smtp-Source: AAOMgpfxWYmBkBLSCB74Y3CxDU23sttgolYCWJWATlDnDgeboYiTosPLwAE08YlB8F2wa5K+06NLz2iTNOaejUjRTN0=
X-Received: by 2002:a0c:c586:: with SMTP id a6-v6mr743167qvj.188.1531371835037;
 Wed, 11 Jul 2018 22:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <ee06e59ae84a9b9013480c58bd4678e44d201a42.1531135999.git.amit.kucheria@linaro.org>
 <CAD=FV=X3B3wKv3jNLM8f9YvdRNkp6CNF1JmE+bMTBnR4CMvyww@mail.gmail.com>
In-Reply-To: <CAD=FV=X3B3wKv3jNLM8f9YvdRNkp6CNF1JmE+bMTBnR4CMvyww@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Jul 2018 10:33:43 +0530
Message-ID: <CAP245DUrfURnyWs_zts9ks85SxMMdzLUfzQ2Wq4wcan0aaB+wQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt: qcom: 8996: thermal: Move to DT initialisation
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Lists LAKML <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:09 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > We also split up the regmap address space into two, one for the TM
> > registers, the other for the SROT registers. This was required to deal with
> > different address offsets for the TM and SROT registers across different
> > SoC families.
>
> The splitting into two regions is actually optional and that should
> probably be mentioned in the commit message.

On the contrary, after this refactor, all new platforms with the
v2.x.y TSENS IP should use two regions. The only reason for patch 2 is
that we're stuck with supporting old 8996/8916 DTs. I'd prefer to
phase out support for the old DTs if possible. I don't want to
encourage any new bindings with a single address space.

> > Since tsens-common.c/init_common() currently only registers one address
> > space, the order is important (TM before SROT). This is OK since the code
> > doesn't really use the SROT functionality yet.
>
> Nowhere in the commit message does this say you're also adding a 2nd
> block of thermal sensors.  It seems like you should say that
> somewhere.
>
> ...and it should also be obvious in ${SUBJECT}.

Fixed.

> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 8c7f9ca..6c8a857 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -461,7 +461,17 @@
> >
> >                 tsens0: thermal-sensor@4a8000 {
> >                         compatible = "qcom,msm8996-tsens";
> > -                       reg = <0x4a8000 0x2000>;
> > +                       reg = <0x4a9000 0x1000>, /* TM */
> > +                             <0x4a8000 0x1000>; /* SROT */
>
> Note that the unit address is supposed to match the first "reg"
> address, so either these should be reversed or you should update your
> node name.  AKA your node name should be this now:
>
> tsens0: thermal-sensor@4a9000

Fixed.

>
> > +                       #qcom,sensors = <13>;
>
> As per my responses to other patches, " #qcom,sensors" is undocumented
> and doesn't appear to be read by the driver.

This feature was merged earlier. See commit 6d7c70d1cd6526 (thermal:
qcom: tsens: Allow number of sensors to come from DT)

Regards,
Amit
