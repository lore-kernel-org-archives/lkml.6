Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1976C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD22054F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aFHeU6cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfB0VDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:03:53 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41799 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfB0VDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:03:52 -0500
Received: by mail-ua1-f68.google.com with SMTP id j7so1980264uak.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m4IQK1l1iI3yPCF7+GOJJBX4vymOsS2iTn7qj8xkI9U=;
        b=aFHeU6clq/iPLk8y7quuguHWaEWf9YPjjhFdrh7y1obioxFbFLdtWn6dVDY55mOXmr
         k5ASDfUro/0x6eQ/TlGn+2/5++96WYWUJzLutu3EIz90sX08QPGlbO6/ai2svH+4M7Kb
         x75YX93AJi64DTWYdasPAYF7I/EZUzaBcfFmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4IQK1l1iI3yPCF7+GOJJBX4vymOsS2iTn7qj8xkI9U=;
        b=YddjVgNeqCGQ07YFSFlXOEilQ4DXvrkuWclu4LARp88WffaJwL0P8Bvn4UooYdL19u
         Ze0jBxg7xYGgCDeu2FjWCHQ1+4h5pioZQCKB93ZxfUZfiyFOhwUrPaxsgublaroLdl7x
         Ya5THkXECPRuxLN7vmBXtaq/H4rue1QC87wixnvJpbICwtjTR7vaH44Jz2T2JCMyIlxr
         YVSU4+tv4XtSmBnAXgEmtiVp0UA6LWjLsr45yDASMKKouEtukCcqEr/Y0pz6XOhI1hA/
         blr7Mb/90N07/GUIqnNx6X25sjvwCM9QJeynV+jj7Vk3ZxMAjM1J9duC0DNpbMemTX5v
         lgsQ==
X-Gm-Message-State: AHQUAub7SRK60HMGFW0vz/rX/3ak3DD/PISZ5+3SC/aaIjEz2JVhv/sq
        6wK0LxsHcdrqKVKfBzGOG0HnPgI06tc=
X-Google-Smtp-Source: AHgI3IZHCd1DkggP8d35wFa07iVyI0eNZxFeidnhm+VpyIUbcI6hbOdV39w5i9EhQdpMrTmcx5fR0A==
X-Received: by 2002:a67:810e:: with SMTP id c14mr2951897vsd.69.1551301430886;
        Wed, 27 Feb 2019 13:03:50 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id f130sm420571vsd.1.2019.02.27.13.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 13:03:50 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id q17so16789448uam.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:03:49 -0800 (PST)
X-Received: by 2002:a9f:3205:: with SMTP id x5mr3132173uad.104.1551301429370;
 Wed, 27 Feb 2019 13:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
 <20190206051335.23799-9-bjorn.andersson@linaro.org> <CAD=FV=UQwsKq1TujmmmR-OiSpMvUp_0b4Vi4Rh9TMGoKgkkkCQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UQwsKq1TujmmmR-OiSpMvUp_0b4Vi4Rh9TMGoKgkkkCQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Feb 2019 13:03:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wr7nHWdQFC_+vs5-r_cBGKCsUNZ0mOMMTxdKPe56GUuQ@mail.gmail.com>
Message-ID: <CAD=FV=Wr7nHWdQFC_+vs5-r_cBGKCsUNZ0mOMMTxdKPe56GUuQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 26, 2019 at 3:54 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Feb 5, 2019 at 9:13 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > From: Sibi Sankar <sibis@codeaurora.org>
> >
> > This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
> >
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v5:
> > - None
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 58 ++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 560c16616ee6..5c41f6fe3e1b 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1612,6 +1612,64 @@
> >                         };
> >                 };
> >
> > +               mss_pil: remoteproc@4080000 {
> > +                       compatible = "qcom,sdm845-mss-pil";
> > +                       reg = <0 0x04080000 0 0x408>, <0 0x04180000 0 0x48>;
> > +                       reg-names = "qdsp6", "rmb";
>
> I found that when I disabled IOMMU bypass by booting with
> "arm-smmu.disable_bypass=y" that I'd get this failure:
>
> ---
>
> [   13.633776] qcom-q6v5-mss 4080000.remoteproc: MBA booted, loading mpss
> [   13.647694] arm-smmu 15000000.iommu: Unexpected global fault, this
> could be serious
> [   13.660278] arm-smmu 15000000.iommu: GFSR 0x80000002, GFSYNR0
> 0x00000000, GFSYNR1 0x00000781, GFSYNR2 0x00000000
> ...
> [   14.648830] qcom-q6v5-mss 4080000.remoteproc: MPSS header
> authentication timed out
> [   14.657141] qcom-q6v5-mss 4080000.remoteproc: port failed halt
> [   14.664983] remoteproc remoteproc0: can't start rproc
> 4080000.remoteproc: -110
>
> ---
>
> Adding "iommus = <&apps_smmu 0x781 0>;" here fixed my problem.  NOTE
> that I'm no expert on IOMMUs so you should confirm that this is right,
> but if it is then maybe you could include it in the next spin of the
> series?  I got the "0x781" just by looking at the value of the GFSYNR1
> in the above splat.  I wasn't sure what to put for the mask so I put
> 0x0.

Upon more testing the "iommus" line that I came up with avoids the
global fault but doesn't actually work.  I just get:

qcom-q6v5-mss 4080000.remoteproc: failed to allocate mdt buffer

I'm hoping someone from Qualcomm can help out here and say how this
should be solved.  Thanks!


-Doug
