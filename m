Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835CBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223422086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvLS542A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 223422086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeIZBwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbeIZBw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:52:29 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570B120880;
        Tue, 25 Sep 2018 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537904602;
        bh=xUjnwwWHaUElZaunMyyEO52IwSEnXoY6ne4VGRmHmY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QvLS542AvpVvnsTsOd+mOVRwASdl2UMOW2mkY9j93kQ2rCv2/blJ+TvJVVoZTCi+2
         yEMVhjPvtM5TqhNcXPBywbmRSHO2Ku/Ck6rODsrDYa60g0ffe1v2srC6kotfZ53900
         yISCPtAmzWfavMDouPNppuF9Su2cSdtqgsRsAA4M=
Received: by mail-qk1-f169.google.com with SMTP id b19-v6so14255337qkc.6;
        Tue, 25 Sep 2018 12:43:22 -0700 (PDT)
X-Gm-Message-State: ABuFfoj493M7fJd7cb2+zhuw/mGahTbzU8W8mdaPWHcHaR5NfvaS87EI
        hC+ZVeWG4k3xonf9Pqo3C7fS5bBkuqWra5EkvQ==
X-Google-Smtp-Source: ACcGV61k/w37BDTcOvXHNACqXE2RCXCGjtiTO5DL+J/GZ6Zh5yRcw32E2T/AunNrNf4xbgFRgV5fgJO2friPF2+2x5w=
X-Received: by 2002:a37:12d1:: with SMTP id 78-v6mr1895586qks.147.1537904601588;
 Tue, 25 Sep 2018 12:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180627045234.27403-1-rnayak@codeaurora.org> <20180627045234.27403-3-rnayak@codeaurora.org>
 <20180703223554.GA32313@rob-hp-laptop> <20180704055757.4li26b6poxllmh2k@vireshk-i7>
 <1463d24b-481d-eecd-9e44-e7a5a993e5fc@codeaurora.org> <CAL_JsqJe+m4hD3nxQDjOT1JzRoSMXppy1r6APV1w=NtgCr-X_A@mail.gmail.com>
 <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org>
In-Reply-To: <271db7b1-f65b-f42d-b00b-9362429b3749@codeaurora.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 25 Sep 2018 14:43:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
Message-ID: <CAL_JsqJQypZbeZRa2u2+nM96p0ZHMHgDSpMbXqZx6zn+OiZSrw@mail.gmail.com>
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

On Tue, Sep 25, 2018 at 5:25 AM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
> Hi Rob,
>
> []...
> >>>>> +   rpmhpd_opp_table: opp-table {
> >>>>> +           compatible = "operating-points-v2-qcom-level";
> >>>>> +
> >>>>> +           rpmhpd_opp_ret: opp1 {
> >>>>> +                   qcom,level = <RPMH_REGULATOR_LEVEL_RETENTION>;
> >>>>> +           };
> >>>>
> >>>> I don't see the point in using the OPP binding here when you aren't
> >>>> using *any* of the properties from it.
> >>>
> >>> Yeah, that's the case for now. But there are cases (as Stephen
> >>> mentioned earlier [1]) where the voltage values (and maybe other
> >>> values like current, etc) would be known and filled in DT. And that's
> >>> why we all agreed to use OPP tables for PM domains as well, as these
> >>> are really "operating performance points" of these PM domains.
> >>
> >> Rob, are you fine with these bindings then?
> >
> > Okay, my only thought is whether we should just use 'reg' here, or do
> > we need 'level' for anything else and should make it common?
>
> I am not quite sure I understood what you are suggesting here :(

You could use the  'reg' property instead of 'qcom,level'. Any reason
not to do that?

Alternatively, would 'level' be something useful in other situations
and should not be QCom specific?

Rob
