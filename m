Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3574DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E820652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+XQ/k6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfAQSWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:22:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44060 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfAQSWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:22:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so5095462plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=dReFyKYXiOidZgU2OcyUG92lx8S5lCm1nDtk9mPCDvw=;
        b=T+XQ/k6MwYLriRAvipTB9m3rj7yGkub9dONI6/jEKQkF9+1BLHIgSdmNaGGyNyLdxV
         hEIhaMq53cyi6zIf4Hm8YFNdDbwQrrpp7txTxQwXpU2+itFAyPIkYm9XnKfNzR5w8/O/
         yCu4Sourv6KkSnvMNqc/pVI5bLjv1/3qzSzK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=dReFyKYXiOidZgU2OcyUG92lx8S5lCm1nDtk9mPCDvw=;
        b=UnHQ03lz8J7ZgJfWXcxkbzgZ2oBQBaN+I0Zs0dRwCTXlOsuIDjHhKI6aPZEmkFsSMN
         yeXWSua7/kxU8kqT4qD2wNUJISVLwRG4jU4G03LM0ZYnoveukTXKT0Gm8u3J+1LB3CfL
         0N/LWGMi+32BHiNZ9xzqDmdmqUeItXS/lx1IxT9Z5H1znsCTVcN/hwnZ6Rob5COuB6Ow
         vtyeY1gXklFK86lODrqN3qBASdSEeihMvk8MLBQwmj504jp9XjWUHLYUSTclGTBXBcVH
         ettwbqFkwCkLjbsJ8HjX29GTuziShuWpHiq9qqHr7hUEa/Vpnt++tSiEVLOYDyixqcHo
         +BkQ==
X-Gm-Message-State: AJcUukcnQjtN6CFRBaSteSNoOBwwyzny4C6n3cLGeSjAkl0uD9gLgizJ
        0IPhlXBL2Cf/cadbCcoFRwRiAqGpns5Wgw==
X-Google-Smtp-Source: ALg8bN6AnPsoRQ87hal/FOe4wOnNvEFGc8EG0F/gcxjiuhBVdhFDITDFp7w69j0qWDZAcIVr1vYUTQ==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61mr15998519plb.185.1547749358184;
        Thu, 17 Jan 2019 10:22:38 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w3sm5525942pge.8.2019.01.17.10.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:22:37 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/2] arm64: dts: qcom: sdm845: Extend ranges and describe DMA space
User-Agent: alot/0.8
In-Reply-To: <20190117042940.25487-3-bjorn.andersson@linaro.org>
References: <20190117042940.25487-1-bjorn.andersson@linaro.org> <20190117042940.25487-3-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154774935672.169631.8429033154347254149@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 17 Jan 2019 10:22:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-16 20:29:40)
> For devices attached to an IOMMU, translation between IOVA and physical
> addresses is no longer 1:1 and dma-ranges should be specified to
> describe the available IOVA address space.
>=20
> On SDM845 the busses are implemented with 36 address bits, so dma-ranges
> must be defined to reduce the size of the IOVA address space from the 48
> bits supported by the SMMU. Without this DMA allocations may end up with
> IOVAs outside the valid range, that gets truncated by the bus between
> the device and its translation unit.
>=20
> Also extend ranges to describe the available address space.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

