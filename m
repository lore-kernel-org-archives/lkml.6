Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AB2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7AC2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cMyLxYs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfAVT2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:28:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45209 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAVT2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:28:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so12228080pfd.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 11:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :references:subject:from:message-id:cc:date;
        bh=xH4YLyKuLFYCKGMZOYqbJc5Msd0eGmZNsP8+q3c2eLQ=;
        b=cMyLxYs5E09Dr0LA931SFsrejydI7gITq7jxoEFTCEk8NM85oPspDs7uiP1pXSN5nZ
         26wHzb3jPiRRlvNukTbZciMBNMs3lQXCYljKhFBygByCrS2cVoQEQqvY6E+uuNReD3fH
         I7B46mkawUtE6NFp+9n6T3ajKPpil3ZabkBr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:references:subject:from:message-id:cc:date;
        bh=xH4YLyKuLFYCKGMZOYqbJc5Msd0eGmZNsP8+q3c2eLQ=;
        b=gd5l7/NSVa/bH8J1YTTQVhII1QJSwnHNdW/Rrr4gCs/C3F6C/uiz8fIrsami3M+L1c
         v9eTMpmNZDKfVRZatJIP0RhXgcTw+4BF0kdJJGjk1iPbsa0xlPTlaUaVhs3X4ejxEeoi
         nmpquvCLj1niDQVgKGxFWmZCyfQNlIa4wo73N+q0RScnxrMclf12fafJcqonKDnFPIEl
         5KXm6NLIGPyp72souWmo1N5mGwIPn3yVizW+UwxmlkksSdmncvezn+5hsEEetQDbPL6B
         PwPxx2WxFDJxdHFg+y8mMP/rXMv54N8MA/OzuaPRlbTIfFf2UuuKRS17/iplILR06NTO
         hLZQ==
X-Gm-Message-State: AJcUukcbtnWtFOR1I2gsLqfaBsMjflg6TjR7Y9aTuuT4VFwnKCxZhHMZ
        LbcM2/AyAJrMF3UE/zeLnbvmAA==
X-Google-Smtp-Source: ALg8bN6K522kU6aEcc/PCcyzk9rfxfJeGD9l8UKPrxGTzW9rovm5lAfNTY7eDG/esJz2LHJDzy1jyQ==
X-Received: by 2002:a62:1542:: with SMTP id 63mr34845652pfv.230.1548185304733;
        Tue, 22 Jan 2019 11:28:24 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id m3sm32447278pfi.102.2019.01.22.11.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:28:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
In-Reply-To: <20190122192537.GC31919@minitux>
User-Agent: alot/0.8
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-5-bjorn.andersson@linaro.org> <154818385792.20280.7601798748317142776@swboyd.mtv.corp.google.com> <20190122192537.GC31919@minitux>
Subject: Re: [PATCH v3 04/10] dt-bindings: soc: qcom: Add AOSS QMP binding
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154818530327.20280.1477070677484130832@swboyd.mtv.corp.google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Jan 2019 11:28:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-22 11:25:37)
> On Tue 22 Jan 11:04 PST 2019, Stephen Boyd wrote:
>=20
> > Quoting Bjorn Andersson (2019-01-21 21:51:06)
> > > Add binding for the QMP based side-channel communication mechanism to
> > > the AOSS, which is used to control resources not exposed through the
> > > RPMh interface.
> > >=20
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >=20
> > > Changes since v2:
> > > - Update indentation of example
> > > - Add colling device subnodes to the description
> > >=20
> > >  .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 75 +++++++++++++++++=
++
> > >  include/dt-bindings/power/qcom-aoss-qmp.h     | 15 ++++
> > >  2 files changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,a=
oss-qmp.txt
> > >  create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp=
.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> > > new file mode 100644
> > > index 000000000000..881dc8c7907a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
> > > @@ -0,0 +1,75 @@
> > > +Qualcomm Always-On Subsystem side channel binding
> > > +
> > > +This binding describes the hardware component responsible for side c=
hannel
> > > +requests to the always-on subsystem (AOSS), used for certain power m=
anagement
> > > +requests that is not handled by the standard RPMh interface. Each cl=
ient in the
> > > +SoC has it's own block of message RAM and IRQ for communication with=
 the AOSS.
> > > +The protocol used to communicate in the message RAM is known as QMP.
> >=20
> > Just curious if QMP is "Qualcomm Messaging Protocol"? I don't think it's
> > ever spelled out in this patchset.
> >=20
>=20
> I believe that is the case, would you like me to spell it out?

Yes, at least once would be great. Thanks.

