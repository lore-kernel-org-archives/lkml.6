Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA2CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BD421471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gN7POpZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17BD421471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeGLFUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:20:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46254 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbeGLFUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:20:13 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so7622167qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hh/0cv/4n3fwTOMZZpnwgzx9YFl2tRlk4NjLuWaCiN8=;
        b=gN7POpZ/DaJlmY+y2w8JME8ULflQovuRkCyxExMevlo3FS61R/PE7cbAwMRCCzpLnu
         Jx+ShGvL1nhO5aJKS6lOEVUXU8qp/YiJ/v2cJfk8O+sFs5ngKTJxU5w8PWKJjfTlmAv4
         3jLUI+WsqnB9E1Lw+oL9Cdda9urxnbr2SnSFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hh/0cv/4n3fwTOMZZpnwgzx9YFl2tRlk4NjLuWaCiN8=;
        b=RrOILXytN6NoayE6l0EpDZ5fgyry7+o9c6oNLubGV8vjBzNMd5CxdMyPPOcCUn1LcT
         qtjQdJuY9E/Y1ywyvjV/a38vg6i8bBPBxYfMDdJv4DUTUgkzBdoy9MKunR/1SHwh/gYw
         ylQX7E/OlyiSNyUwdV9Lx4hmnwvkOZbY2taRCwGCFFjaykXmA1wKtsXxZ4VSww4PdNJQ
         u2ylhTDXUz0WYHATS3ZuNCGQ9hAHDOHLTKg0M1rLafzwC89LYdQ1Dy4mDxPlAe/HKliq
         IlU+LAyinswhSRoFn/85D4KcdLiLnJop/hnRQ3IEB9CENiKLU7ts0J8jRT9X5lTSZS79
         untA==
X-Gm-Message-State: AOUpUlFRa7gvrHrVV8cWbZ2VES+mxFtOxDc4eo5ESUp6WYtnwBO82Rvy
        oUYSrNbFaWZXQfPznf0Xm6D3PAkg1dj2BQ0D/MeX8w==
X-Google-Smtp-Source: AAOMgpc9K8AdMYPjnU2PsnK4gAxvTIXwVkk/xv7sHZG7AEgvV0OFV3+UFeYnG8Qzxt/aqeOD8ITfkT64vTAKry4RK6U=
X-Received: by 2002:a0c:9281:: with SMTP id b1-v6mr745170qvb.115.1531372341841;
 Wed, 11 Jul 2018 22:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1531135999.git.amit.kucheria@linaro.org>
 <278b59d6a25f874a087995368cecec2572b5be89.1531135999.git.amit.kucheria@linaro.org>
 <CAD=FV=WFEubDtHkL7-8DF6nPuRL4HBHOghc3YekazXUnS6vrBA@mail.gmail.com>
In-Reply-To: <CAD=FV=WFEubDtHkL7-8DF6nPuRL4HBHOghc3YekazXUnS6vrBA@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 12 Jul 2018 10:42:10 +0530
Message-ID: <CAP245DXXXLSAX7aTW5ynA6dii7w2m8_i6K4Y_CeBs91xk2y2pw@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] thermal: tsens: Add generic support for TSENS v2 IP
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 12:10 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Mon, Jul 9, 2018 at 4:43 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> > SDM845 uses v2 of the TSENS IP block but the get_temp() function
> > appears to be identical across v2.x.y in code seen so far. We use the
> > generic get_temp() function defined as part of ops_generic_v2.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > ---
> >  drivers/thermal/qcom/tsens-v2.c | 6 +++++-
> >  drivers/thermal/qcom/tsens.c    | 3 +++
> >  drivers/thermal/qcom/tsens.h    | 5 ++++-
> >  3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> > index 34ba6c7..f40150f 100644
> > --- a/drivers/thermal/qcom/tsens-v2.c
> > +++ b/drivers/thermal/qcom/tsens-v2.c
> > @@ -69,8 +69,12 @@ static const struct tsens_ops ops_generic_v2 = {
> >         .get_temp       = get_temp_tsens_v2,
> >  };
> >
> > +const struct tsens_data data_tsens_v2 = {
> > +       .ops            = &ops_generic_v2,
> > +};
> > +
> > +/* Kept around for backward compatibility with old msm8996.dtsi */
> >  const struct tsens_data data_8996 = {
> >         .num_sensors    = 13,
> >         .ops            = &ops_generic_v2,
> >  };
>
> Something seems fishy here.  You have a ".num_sensors" for sdm8996
> hardcoded to 13 but you don't have a ".num_sensors" for your new v2.
> Where does num_sensors get set for everyone else?  In patch #3 you
> have a new "#qcom,sensors" but:
>
> 1. Nothing reads this as far as I can tell, so that means everyone
> will end up with 0 sensors.
>
> 2. On your 2nd block of sensors in the sdm8996 device tree (see
> earlier patch in the series) you try to set qcom,sensors to 8.  ...but
> since you still have a compatible of "qcom,msm8996-tsens" you'll get
> 13.  That seems wrong.  ...or did I miss something?

Refer to commit 6d7c70d1cd6 (thermal: qcom: tsens: Allow number of
sensors to come from DT) merged earlier. #qcom,sensors will override
the platform data if defined.
