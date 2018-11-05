Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869CA2084F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MsyuiUe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 869CA2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbeKFGdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:33:24 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38195 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeKFGdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:33:20 -0500
Received: by mail-ua1-f68.google.com with SMTP id g10so3746051uak.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bq9rklDlPyykU9VuuBXq87FoiCOx1DH+DDQO0viI5E4=;
        b=MsyuiUe/4P8x1Vi5xYtymi2UZG305A+iodClMZIY95lyo/Pow7pEXmaBt21Uj1k1Uh
         5jburPDpff5I+jgaQIbBwWxdVIfkBxHVBze2qnHp4pf4oOHz4cEToChvt4Ns5zu9pkww
         6xajs4CDmF0nnfhXog+QZG1/zU0Yzibm3b60cOCHrDOAGAzNVREVDYDQ8acTKQpSefwb
         VfW8ADd6dwk5G7zHzMTQDXdhB/5FaBx6nzLnIf7ZsVI/e6l8ABlZg63z6T+VEEYyGV/g
         e0dL0xtCxdGn8wXYjcU/jOpDrva38DrycTFKL8x/8mktos8pBrMUBolDItEpD9kPjoXR
         2RMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bq9rklDlPyykU9VuuBXq87FoiCOx1DH+DDQO0viI5E4=;
        b=omFI0WhT7ReyuzkWdgV/whivoFHTay8lv9lVkDY6hRa8tKxMzE9Yh5UnyLXijxfqAG
         d/lRDOTa1iweLphX56A5rJFxjaK+gp+V4efybRO+ip7iYaZwMLNtUi4/oUhITdsILiCd
         kKk+T37I0s1rmIDaaGEia+jxYnM4J5FZje4SWf2GSiyumsTT61zEVC5t7uVl4TG3x4Vm
         v/cVzdL+KgxA7hm5rrEeAg2hy0uuM0mR1NW9/bcSyMRUESbIknj8O3liQVkxwO0/esWU
         nG2RB3ZS3fF6vs/p6PhQGfyTliI78+bTzu3wbSG4LJyulIqN24ClZHZxWnIsujHfKQzb
         ZAEQ==
X-Gm-Message-State: AGRZ1gJg6iitRXzA3CHuYVnXug8EszAk27+AH+Rd8N1tmgv8+wAVZZ5n
        m+9BsYGKwy5XPawkfeQe5/UaVNejWcqEav7PnISltA==
X-Google-Smtp-Source: AJdET5cF5G1rE36zSDDsVA7EokA5rFoj7sNiT+sQ5Io8UtjOHQxwyJvlavZaMEVMCWQ6lVFciDqtjQJcnC3ppc4/25s=
X-Received: by 2002:a9f:3743:: with SMTP id a3mr394764uae.86.1541452303305;
 Mon, 05 Nov 2018 13:11:43 -0800 (PST)
MIME-Version: 1.0
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org>
 <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com> <20181105203657.GA32282@bogus>
In-Reply-To: <20181105203657.GA32282@bogus>
From:   Doug Anderson <dianders@google.com>
Date:   Mon, 5 Nov 2018 13:11:31 -0800
Message-ID: <CAD=FV=VitZ4dyYGxinQ=nsrfM+U7duGbxeN3bdbRxfx-2AWxyQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for SDM845 SOC
To:     Rob Herring <robh@kernel.org>
Cc:     vbadigan@codeaurora.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org,
        stummala@codeaurora.org, sayalil@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 5, 2018 at 12:37 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 01, 2018 at 01:29:54PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Nov 1, 2018 at 5:07 AM Veerabhadrarao Badiganti
> > <vbadigan@codeaurora.org> wrote:
> > >
> > > For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.
> > >
> > > Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > index 502b3b8..f2ffbeb 100644
> > > --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> > > @@ -7,6 +7,7 @@ Required properties:
> > >  - compatible: Should contain:
> > >                 "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> > >                 "qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> > > +               "qcom,sdm845-sdhci" for sdm845 SOC
> >
> > It's up to Rob of course, but IMO it seems a nicer way forward to
> > include both the SoC-specific string and the "version" string in all
> > cases.  I'd write this for the full text:
>
> Fine by me if you update all the dts files.

Done and done.

https://lkml.kernel.org/r/20181105210921.253707-1-dianders@chromium.org
https://lkml.kernel.org/r/20181105210921.253707-2-dianders@chromium.org


> >  - compatible: Should contain a SoC-specific string and a IP version string:
> >       version strings:
> >            "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
> >            "qcom,sdhci-msm-v5" for sdcc version 5.0
> >       full compatible strings with SoC and version:
> >            "qcom,apq8084", "qcom,sdhci-msm-v4"
> >            "qcom,msm8974", "qcom,sdhci-msm-v4"
> >            "qcom,msm8916", "qcom,sdhci-msm-v4"
> >            "qcom,msm8992", "qcom,sdhci-msm-v4"
> >            "qcom,msm8996", "qcom,sdhci-msm-v4"
>
> I assume you meant to append '-sdhci' here?

Oops, yes!

           "qcom,apq8084-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8974-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
           "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"

-Doug
