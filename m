Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03C7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9402151D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 14:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FE7aQpXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9402151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbeHBP7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732141AbeHBP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:59:07 -0400
Received: from mail-qt0-f178.google.com (mail-qt0-f178.google.com [209.85.216.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5A621523;
        Thu,  2 Aug 2018 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533218865;
        bh=cBv3OXnpORnSFCYXIej8OlPyAb+R5ul/5k09xIaxpD8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FE7aQpXImJ01lo83V7iAB8AD91m4BDN/PH9VfqM19KXIgRGjKwb8o453Vr+8c6+e9
         /kWAnm1kUtQ2qvlByH0na8kq31OY7nT6Rl1g3raiCfltyMSfEo95elrfg6dy0Dr0ai
         BgpfiC92aBwV8Bfu+JloJRA2IYpEd6xOXQVqQ8d0=
Received: by mail-qt0-f178.google.com with SMTP id d4-v6so2345837qtn.13;
        Thu, 02 Aug 2018 07:07:45 -0700 (PDT)
X-Gm-Message-State: AOUpUlFV9sdTQ3qxrk37pbkMpdvqt++/lrLefXKXi5MrxNTB2mVkWSWy
        wnTlvrHLDG/WkVwu1O/chBQVwf2wU1k/LXpu7Q==
X-Google-Smtp-Source: AAOMgpfd3r2DybMKHM9hYdDhvAB3JAS7x1n2gh3kzh0VmHE+TkC9ZPgTO31oYMoEkxf7N2smJcQDeSVB/N2+h4BcsAU=
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr2854778qts.354.1533218864327;
 Thu, 02 Aug 2018 07:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-2-srinivas.kandagatla@linaro.org> <20180731204315.GA5265@rob-hp-laptop>
 <53a4e82c-7270-fdbd-a2ea-efbfc2d747a2@linaro.org> <CAL_JsqKcxB2NZR94BP9-Qc8AAFsySPoADm2UA_ZV8V7JdP8-wQ@mail.gmail.com>
 <4c821ce9-6268-150f-2ab0-358f5b312ec0@linaro.org>
In-Reply-To: <4c821ce9-6268-150f-2ab0-358f5b312ec0@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Aug 2018 08:07:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKXfnCggFK3QC4Q2+-ZCGKdASJ87e=s6AUq4kYA-GWjg@mail.gmail.com>
Message-ID: <CAL_JsqJKXfnCggFK3QC4Q2+-ZCGKdASJ87e=s6AUq4kYA-GWjg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] ASoC: dt-bindings: add dt bindings for wcd9335
 audio codec
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vinod <vkoul@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 1:33 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Thanks for review,
>
> On 01/08/18 23:20, Rob Herring wrote:
> >>>> +- qcom,ifd:
> >>>> +    Usage: required
> >>>> +    Value type: <phandle>
> >>>> +    Definition: SLIM interface device
> >>> Wouldn't this be the parent?
> >>>
> >> No, Interface device is just like other slim device and is part of
> >> SLIMbus Component and has a unique address. Every SLIMbus component has
> >> one interface device.
> > I still don't understand what this means. If this is SLIMbus specific,
> > then maybe it should be named that way? Or it is QCom specific?
>
> It is SLIMbus specific, I will rename this to "slim,ifd" in next version
> which makes it clear!

'slim' is not a vendor. So 'slim-ifc-dev' perhaps. Unless IFD is a
well known acronym for someone familiar with SLIMbus.

Rob
