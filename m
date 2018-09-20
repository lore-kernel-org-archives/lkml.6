Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB767C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9332147D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v7IapQr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9332147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388130AbeIUAgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbeIUAgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:36:39 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72FA214C2;
        Thu, 20 Sep 2018 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537469508;
        bh=Yvu/N1EKlA/F38VY/EkNz9Vl8IT6XPTnue0an1ho8Kc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v7IapQr6xJMV0Gas5Ev8CJYLMVdsBiDci8EFgADeTLFsKKIHUFkCo0idhSFY3wKnY
         lAdK1C4CEcfJaxkpf9v3ibfeybb0YXTqEFyZccSChdE8/3ya6DxqEy5b0XRZxQQeMf
         90cNHIgUX8iAlv4t33J0pIvkKOdXu1E0l9jKsoLM=
Received: by mail-qk1-f172.google.com with SMTP id z78-v6so6136626qka.0;
        Thu, 20 Sep 2018 11:51:47 -0700 (PDT)
X-Gm-Message-State: APzg51C6GSe/fxTjDx+8CyUDMbqljGdz4tsfV8I5EwxwdKW6Kr2CGUk+
        OVXmUEa2PgKvqwMBchNi2Kxn5QZ2tLAcbKREPQ==
X-Google-Smtp-Source: ANB0VdbivjFUiMf6/5j+1/HsAFRG+nq45uK2MqkHjvOj79pwH8YtZcgcJCwfUgMWqrGiVWDBb3t2AeRUzzgm1rU4DcM=
X-Received: by 2002:a37:ddcf:: with SMTP id u76-v6mr8470135qku.184.1537469507132;
 Thu, 20 Sep 2018 11:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180627045234.27403-1-rnayak@codeaurora.org> <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop> <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
In-Reply-To: <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Sep 2018 11:51:35 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
Message-ID: <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: power: Add qcom rpm power domain
 driver bindings
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Collins <collinsd@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 11:31 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
>
> On 7/4/2018 11:27 AM, Viresh Kumar wrote:
> > On 03-07-18, 16:35, Rob Herring wrote:
> >>> +qcom,level values specified in the OPP tables for RPMh power domains
> >>> +should use the RPMH_REGULATOR_LEVEL_* constants from
> >>> +<dt-bindings/power/qcom-rpmhpd.h>
> >>> +
> >>> +   rpmhpd: power-controller {
> >>> +           compatible = "qcom,sdm845-rpmhpd";
> >>> +           #power-domain-cells = <1>;
> >>> +           operating-points-v2 = <&rpmhpd_opp_table>;
> >>> +   };
> >>> +
> >>> +   rpmhpd_opp_table: opp-table {
> >>> +           compatible = "operating-points-v2-qcom-level";
> >>> +
> >>> +           rpmhpd_opp_ret: opp1 {
> >>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> >>> +           };
> >>
> >> I don't see the point in using the OPP binding here when you aren't
> >> using *any* of the properties from it.
> >
> > Yeah, that's the case for now. But there are cases (as Stephen
> > mentioned earlier [1]) where the voltage values (and maybe other
> > values like current, etc) would be known and filled in DT. And that's
> > why we all agreed to use OPP tables for PM domains as well, as these
> > are really "operating performance points" of these PM domains.
>
> Rob, are you fine with these bindings then?

Okay, my only thought is whether we should just use 'reg' here, or do
we need 'level' for anything else and should make it common?

Rob
