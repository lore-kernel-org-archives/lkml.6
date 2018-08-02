Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB5BC46463
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1007821566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 18:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mNxhudHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1007821566
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbeHBUCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 16:02:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46670 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbeHBUCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 16:02:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so1746622pfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRP1Sk9Kx3HG9QXbtNpFoarptUAwpBfC7xVm/aH+giE=;
        b=mNxhudHbuqsz4nHsHaDXbAo/sTkXfmuL6dt8WjzjBndJdjh3FevDbdaB0wj0CCx/GY
         YpK/cmOpMdttNApbXjMbIIvgKYG0UmxGpSvrYtbHNzG+JY9Yj0dhudmZk891wG2WBpPP
         tkXGASa9cHg4xP4JpPtEqvAq4KkRXR01gNF4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRP1Sk9Kx3HG9QXbtNpFoarptUAwpBfC7xVm/aH+giE=;
        b=Y0of3mltYdCwHFcZ/WzERbp6YYsPHSEgj6fBq25JIFGobnIviW4d33xlRWmhFfsUxP
         G1Rt+FD3t9sNIN3XhS5oOG5jZTKM32MCLa64tb+f3j2k3SAiOOk5GQvAkUFINxeiz2Y9
         4RRRb4Bh4X0zhpXvvGF6RP9P0Gd9gL7zoss/4v7HHhLDczVDh5qVuZWJa14WVR1N1geh
         XJ9vxZEMtJ+eevrIqPY2MzmPFO7VpLW7HNedHpgjvjaxFkbeFDzKHH0rn2WbY65btftV
         8RFvPzk37vgcqd0n3gXGO3oI3LYwP/MDnWeCFARgDZhJji/r2IRzjsdsCqb0j7tuwq/+
         sUIA==
X-Gm-Message-State: AOUpUlEXUxsTzQiJzljS7/ccrSJQmqbys/wZggRlQEpkANU+geRgOYkp
        E/yFJhTsoE+Ys9bVfd0LEqoXaw==
X-Google-Smtp-Source: AAOMgpfwXF8IXhKMGxZyjDcO83jyuH2xHFSKj6+LWu7EFfO5e8t7peUtHwO566M9MY9unR5763JICg==
X-Received: by 2002:a62:404e:: with SMTP id n75-v6mr587577pfa.232.1533233439089;
        Thu, 02 Aug 2018 11:10:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 65-v6sm3880267pfq.81.2018.08.02.11.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 11:10:38 -0700 (PDT)
Date:   Thu, 2 Aug 2018 11:10:38 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v12 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180802181038.GO68975@google.com>
References: <20180802132518.8680-1-bgodavar@codeaurora.org>
 <20180802132518.8680-2-bgodavar@codeaurora.org>
 <20180802172043.GN68975@google.com>
 <366e23679cabb332b1ecde8396570f66@codeaurora.org>
 <58791a55af5532d476febddea6756fdb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58791a55af5532d476febddea6756fdb@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:35:54PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-08-02 23:24, Balakrishna Godavarthi wrote:
> > Hi Matthias,
> > 
> > On 2018-08-02 22:50, Matthias Kaehlcke wrote:
> > > On Thu, Aug 02, 2018 at 06:55:12PM +0530, Balakrishna Godavarthi
> > > wrote:
> > > > This patch enables regulators for the Qualcomm Bluetooth wcn3990
> > > > controller.
> > > > 
> > > > Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../bindings/net/qualcomm-bluetooth.txt       | 26
> > > > +++++++++++++++++--
> > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > > b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > > index 0ea18a53cc29..2175174415ee 100644
> > > > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > > > @@ -10,12 +10,22 @@ device the slave device is attached to.
> > > >  Required properties:
> > > >   - compatible: should contain one of the following:
> > > >     * "qcom,qca6174-bt"
> > > > +   * "qcom,wcn3990-bt"
> > > > +
> > > > +Optional properties for compatible string qcom,qca6174-bt:
> > > > 
> > > > -Optional properties:
> > > >   - enable-gpios: gpio specifier used to enable chip
> > > >   - clocks: clock provided to the controller (SUSCLK_32KHZ)
> > > > 
> > > > -Example:
> > > > +Optional properties for compatible string qcom,wcn3990-bt:
> > > > +
> > > > + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
> > > > + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
> > > > + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
> > > > + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
> > > 
> > > Are these really optional? If I understand correctly the driver
> > > expects the regulators to be there. Even if it could do with only some
> > > regulators specified the devm_regulator_bulk_get() call would fail if
> > > not all requested regulators are available.
> > 
> > yes they are required along with compatible string "qcom,wcn3990-bt".
> > i have taken reference wrt compatible string "qcom,qca6174-bt".
> > In which clocks and enable-gpios are required for driver to work, but
> > it was written as optional in doc.
> > 
> > below snippet from hci_qca.c for qcom,qca6174-bt.
> > 
> >  if (IS_ERR(qcadev->bt_en)) {
> >        dev_err(&serdev->dev, "failed to acquire enable gpio\n");
> >        return PTR_ERR(qcadev->bt_en);
> >     }
> > 
> >   qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
> >   if (IS_ERR(qcadev->susclk)) {
> >       dev_err(&serdev->dev, "failed to acquire clk\n");
> >        return PTR_ERR(qcadev->susclk);
> >      }
> 
> technically it is not correct then i will update as below
> 
> Required properties for compatible string qcom,wcn3990-bt:
> 
>  - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
>  - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
>  - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
>  - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
> 
> Optional properties for compatible string qcom,wcn3990-bt:
> 
>  - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> 
> are they above ok?


Looks good to me.

Optionally you could remove the 'Bluetooth wcn3990' part in the
regulator description, it is a bit redundant since it's already said
that these are properties for the 'Bluetooth wcn3990' compatible
string.

