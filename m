Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBAEC282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC2B21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 00:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyzSmBnX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfAWAkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 19:40:53 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40190 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAWAkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 19:40:52 -0500
Received: by mail-ua1-f65.google.com with SMTP id n7so152422uao.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4G09eGQSUtCzRLs2M6LGUY+RLL2/d9Q2YQI9C3NhKo=;
        b=FyzSmBnX75NtHvML0B30Glmz5G/MFvX5XXMi95RqHWAWYD5D7tRhO2L94Q/RPUqYue
         5ueZKUexHi+WUgbyT/oycPz52Zrd6CimTe6cR/Nha7FF27zBxkr74R1+WsJlunKxU8+H
         LlAT3Crcnsg8zd1FP2oM/yZUrG8+tHg1p6WOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4G09eGQSUtCzRLs2M6LGUY+RLL2/d9Q2YQI9C3NhKo=;
        b=ECUuuxqPaKBYv7E7ZsMHmZEg+l9WMLyl+B7QJ1UO4tjUTOpQCL4X5X4e3mi4ecbUbu
         KIyBamWlQ2uJ0/DjpWKT7Ha8dYOqktSUY8alJax5m4IQUNSYmxFcophfaN7BqrPnMuKt
         jjCV5hvPk49m7PyCFHZHD0d2T19hvZEiseJ6M8Z1W2vK2AdTd4TwyRU5HAMs1oQptiNz
         iRG/AqmDuO9D1eoYpbdm3/1zGcMNtfa29qlR2diivutjPX7W/+6GSTfA9jpHI1dhm6Th
         fNxd3EAGr3VwdzxhglAFu7fT93fMHL+md/7EyWXd4yEpXL1aM7ex3d+R9nqoKFpxXdU5
         j5cQ==
X-Gm-Message-State: AJcUukc6yqUOmgQjNYrWWA4ePCAYj5lmPtZdBarDQRP6vc2/AZ/CGZE2
        V1Q7YVdbu5kkKwzNEqrapPdrX+t4W7k=
X-Google-Smtp-Source: ALg8bN4gddPLrddaOZlF8FnyQsOrOXTYPCdSSiSZiy/xsmbTpSkCyH0RIVyXHrUWHTg8JVZD/1jkhw==
X-Received: by 2002:ab0:7581:: with SMTP id q1mr47354uap.17.1548204050599;
        Tue, 22 Jan 2019 16:40:50 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id g195sm48856855vka.5.2019.01.22.16.40.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 16:40:49 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id t127so104300vke.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 16:40:49 -0800 (PST)
X-Received: by 2002:a1f:1e09:: with SMTP id e9mr53211vke.18.1548204048991;
 Tue, 22 Jan 2019 16:40:48 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-4-bjorn.andersson@linaro.org> <CAD=FV=WXind-uk7V_XTDgM83LZbmtKb2Ln6pQjmUkaZMz8SFsA@mail.gmail.com>
 <20190123002610.GE31919@minitux>
In-Reply-To: <20190123002610.GE31919@minitux>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Jan 2019 16:40:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wsk3s2NbX4pR6v9-kK41edLF4hd7B_BanoFkAXyLBwyA@mail.gmail.com>
Message-ID: <CAD=FV=Wsk3s2NbX4pR6v9-kK41edLF4hd7B_BanoFkAXyLBwyA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] arm64: dts: sdm845: Introduce ADSP and CDSP PAS nodes
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 22, 2019 at 4:26 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> > > +               clocks = <&xo_board>;
> > > +               clock-names = "xo";
> >
> > I've found that nearly all the places that refer to xo_board are wrong
> > and should actually point to '<&rpmhcc RPMH_CXO_CLK>'.  Maybe yours
> > should too?
> >
>
> Yes, xo_board is a fake clock representing the 19.2MHz clock feeding the
> cxo (or cxo2) pad of the SoC. So you're definitely right in that this
> should be referencing the actual 19.2MHz clock.
>
> We've kept referring to this as xo_board, as we don't handle probe
> deferral when gcc will probe earlier than rpmcc in the boot and for
> other non-clock drivers the fear of actually hitting 0 on the refcounter
> for this (you don't want to disable the cxo while running the system).

Note that, as defined in the device tree, "xo_board" is actually 38.4.
IIUC that is not actually a fake/bogus clock but represents the actual
crystal on the board.  There's a divide by 2 in the CPU though so most
peripherals consider "xo" as 19.2.

...OK, confirmed.  The actual RF_XO_CLK pin on the board is truly
connected to 38.4.

-Doug
