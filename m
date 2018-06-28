Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA27C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8F3274C5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w2DZV/Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8F3274C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935292AbeF1OEV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934483AbeF1OET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:04:19 -0400
Received: from mail-it0-f47.google.com (mail-it0-f47.google.com [209.85.214.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D65E274C5;
        Thu, 28 Jun 2018 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530194658;
        bh=j4XWBoJvimdaqESWUPcqR/mjpKhKiVca70dJFA9XwVc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w2DZV/YfMS2rmUvHZEdYyuHX+KarHQcc/vV46rErgNhVEjG0XGEQCZhiyd4EqXWPo
         78N6evHODZ3QWPLpNvZKCP89YvzdJYm+5v/wZMea26NcPfI3D+fc+P+WkzWjEn7ANc
         oZ5cglhPuYs+Q/lmasSWJh5Jlx9j7FsHWLRmdnGk=
Received: by mail-it0-f47.google.com with SMTP id u4-v6so12933888itg.0;
        Thu, 28 Jun 2018 07:04:18 -0700 (PDT)
X-Gm-Message-State: APt69E2XcYmns5fHXn+FDrF1No3B4cYrgJZHByty2Ghfrh2Z0UVoxp+q
        kn9WSMi2xE9Hfl0lrX8hJ5GnonUi0hgyWG95ag==
X-Google-Smtp-Source: AAOMgpdyUbosYn3Lvl54NqSvXLxk7GCjRnbUoytV9Mn9hA7CFdhea3F/YbZYJ++2TIpjAUmHvd0W7fhMeqkL1stJixU=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr8570521iti.106.1530194657733;
 Thu, 28 Jun 2018 07:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <1529578399-3633-1-git-send-email-rohitkr@codeaurora.org>
 <1529578399-3633-2-git-send-email-rohitkr@codeaurora.org> <20180625191737.GA13246@rob-hp-laptop>
 <5c976a29-b1ff-4fb5-9346-2288dfecd4c3@codeaurora.org>
In-Reply-To: <5c976a29-b1ff-4fb5-9346-2288dfecd4c3@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 28 Jun 2018 08:04:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrpxz=W1zB8cr0CSUF9a+8yYMmNGQzQGEAcs3__D-GpQ@mail.gmail.com>
Message-ID: <CAL_JsqJrpxz=W1zB8cr0CSUF9a+8yYMmNGQzQGEAcs3__D-GpQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sdm845
 machine bindings
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:20 AM Rohit Kumar <rohitkr@codeaurora.org> wrote:
>
> Thanks Rob for reviewing.
>
>
> On 6/26/2018 12:47 AM, Rob Herring wrote:
> > On Thu, Jun 21, 2018 at 04:23:18PM +0530, Rohit kumar wrote:
> >> Add devicetree bindings documentation file for SDM845 sound card.
> >>
> >> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> >> ---
> >>   .../devicetree/bindings/sound/qcom,sdm845.txt      | 82 ++++++++++++++++++++++
> >>   1 file changed, 82 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> >> new file mode 100644
> >> index 0000000..68feb08
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
> >> @@ -0,0 +1,82 @@
> >> +* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
> >> +
> >> +This binding describes the SDM845 sound card, which uses qdsp for audio.
> >> +
> >> +- compatible:
> >> +    Usage: required
> >> +    Value type: <stringlist>
> >> +    Definition: must be "qcom,sdm845-sndcard"
> >> +
> >> +- qcom,audio-routing:
> > Use just 'audio-routing'.
>
> This is same which is being followed in apq8096 machine driver. As all
> qcom machine drivers will
> mostly follow the same design, Vinod asked to pull out the APIs in
> common file - https://patchwork.kernel.org/patch/10479625/ .
> Same is for qcom,model. I will add missing documentation for it in the
> next patchset.

Yes, I know. There are lots of <vendor>,model and others, and I'm
asking folks to drop the vendor prefix.

Rob
