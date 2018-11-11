Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46645C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4DE21104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 01:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H00+/AtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4DE21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeKKL1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 06:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbeKKL1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 06:27:16 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9D12147D;
        Sun, 11 Nov 2018 01:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541900416;
        bh=ekpHzu82W08TcPdp921HpbM75hW2xnYVpHuJyJ7dx4w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H00+/AtU+jx8pPpU13sdiw0ZDOaZqT9l8Xcr+5wRA+aZeNopdjXbriCkC78IwHtjz
         6cHWD6FSC+N1NBSSbLwzMLXlX89m9wlLl3rgZouLJuI1gTbzoh2gvZXvUbgM0yaXI/
         O7NpRwKMtkb5rHScwC+qfbmYKQ7iHHeiaVlH4O7I=
Received: by mail-qk1-f179.google.com with SMTP id d135so8056324qkc.12;
        Sat, 10 Nov 2018 17:40:16 -0800 (PST)
X-Gm-Message-State: AGRZ1gJlDE0ogF89jCVsFHXPRzkLZPARjFrJtzgwf8UV4Si4DCmnspZe
        o0AqO6PM9PNUVSYXLPaR2RW2WD8ZOROUhtYp6Q==
X-Google-Smtp-Source: AJdET5cUhi1W9jpP76sQaovATYxsaUVPbfqHs3EA0pNS50gTZhKJmDxBwhAe7EtIZrU4ewuMgXMOP04Q5b4aFOBnaOg=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr14721377qvl.77.1541900415322;
 Sat, 10 Nov 2018 17:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-2-elder@linaro.org>
 <CABGGiswmpmSUmg9jEW7GnNtL2uXAN7jJOqFO5kG8adq71GuZpw@mail.gmail.com> <a4c9f0f8-d7c7-2756-cfdf-b67ce9f1ca3b@linaro.org>
In-Reply-To: <a4c9f0f8-d7c7-2756-cfdf-b67ce9f1ca3b@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 10 Nov 2018 19:40:03 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=CZR-SMwkk43hfZXcts0FYnsuZASg-RdyzASyMBCGmQ@mail.gmail.com>
Message-ID: <CAL_JsqL=CZR-SMwkk43hfZXcts0FYnsuZASg-RdyzASyMBCGmQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
To:     Alex Elder <elder@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        David Miller <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        ilias.apalodimas@linaro.org, netdev <netdev@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 4:38 PM Alex Elder <elder@linaro.org> wrote:
>
> On 11/7/18 8:59 AM, Rob Herring wrote:
> > On Tue, Nov 6, 2018 at 6:33 PM Alex Elder <elder@linaro.org> wrote:
> >>
> >> Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
> >> device tree nodes.
> >>
> >> Signed-off-by: Alex Elder <elder@linaro.org>
> >> ---
> >>  .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
> >>  .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
> >>  2 files changed, 151 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> >>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> >> new file mode 100644
> >> index 000000000000..d4d3d37df029
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> >> @@ -0,0 +1,136 @@
> >> +Qualcomm IPA (IP Accelerator) Driver
> >
> > Bindings are for h/w not drivers.
>
> OK.  I'll drop " Driver".
>
> >> +
> >> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
> >> +certain network processing tasks (e.g. filtering, routing, and NAT) from
> >> +the main processor.  The IPA currently serves only as a network interface,
> >> +providing access to an LTE network available via a modem.
> >> +
> >> +The IPA sits between multiple independent "execution environments,"
> >> +including the AP subsystem (APSS) and the modem.  The IPA presents
> >> +a Generic Software Interface (GSI) to each execution environment.
> >> +The GSI is an integral part of the IPA, but it is logically isolated
> >> +and has a distinct interrupt and a separately-defined address space.
> >> +
> >> +    ----------   -------------   ---------
> >> +    |        |   |G|       |G|   |       |
> >> +    |  APSS  |===|S|  IPA  |S|===| Modem |
> >> +    |        |   |I|       |I|   |       |
> >> +    ----------   -------------   ---------
> >> +
> >> +See also:
> >> +  bindings/interrupt-controller/interrupts.txt
> >> +  bindings/interconnect/interconnect.txt
> >> +  bindings/soc/qcom/qcom,smp2p.txt
> >> +  bindings/reserved-memory/reserved-memory.txt
> >> +  bindings/clock/clock-bindings.txt
> >> +
> >> +All properties defined below are required.
> >> +
> >> +- compatible:
> >> +       Must be one of the following compatible strings:
> >> +               "qcom,ipa-sdm845-modem_init"
> >> +               "qcom,ipa-sdm845-tz_init"
> >
> > Normal order is <vendor>,<soc>-<ipblock>."
>
> I'll use "qcom,sdm845-ipa-modem-init" and "qcom,sdm845-ipa-tz-init".
> (Or just "qcom,sdm845-ipa", depending on the outcome of the discussion
> below.)
>
> > Don't use '_'.
>
> OK.
>
> > What's the difference between these 2? It can't be detected somehow?
>
> There is some early initialization, including loading some firmware,
> that must be done by trusted code.  That can be done by either Trust
> Zone or the modem.  If it's done by the modem, there is an additional
> step required during initialization so the modem can tell the AP
> that it has done its part, and the AP can finish IPA initialization.
>
> There  is no way of detecting (e.g. by probing hardware) which is
> in effect so we use DT.  I discussed this with Bjorn, who said that
> this was a situation seen elsewhere and that using compatible strings
> was the way he suggested to address it.

Okay. However, if this is common for QCom blocks maybe we should
reconsider. I think compatible makes sense if the programming model
changes.

> > This might be better expressed as a property. Then if Trustzone
> > initializes things, it can just add a property.
>
> A Boolean property to distinguish them would be fine as well, but
> I would like to address this "common" problem consistently.
>
> Bjorn, would you please weigh in?
>
> >> +
> >> +-reg:
> >> +       Resources specyfing the physical address spaces of the IPA and GSI.
> >
> > typo
> >
> >> +
> >> +-reg-names:
> >> +       The names of the address space ranges defined by the "reg" property.
> >> +       Must be "ipa" and "gsi".
> >> +
> >> +- interrupts-extended:
> >
> > Use 'interrupts' here and describe what they are and the order. What
> > they are connected to (and the need for interrupts-extended) is
> > outside the scope of this binding.
>
> I used interrupts-extended because there were two interrupt parents
> (a "normal" interrupt controller and the interrupt controller implemented
> for SMP2P input).  A paragraph here:
>     bindings/interrupt-controller/interrupts.txt
> recommends "interrupts-extended" in that case.
>
> I have no objection to using just "interrupts" but can you tell me what
> I misunderstood?  It seems like I need to do "interrupts-extended".

Yes, in the dts you should use interrupts-extended. However, for
documentation purposes that aspect is not important. So we just use
interrupts most everywhere.

Rob
