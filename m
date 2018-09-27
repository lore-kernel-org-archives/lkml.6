Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E10FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CC921571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 21:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOcAeLK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CC921571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeI1D1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeI1D1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:27:37 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B937A216FA;
        Thu, 27 Sep 2018 21:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538082444;
        bh=uv0TeId7IdMxNEmopP0UrwlEvsX7ixnl1dD7ytjd/e4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tOcAeLK06Apv2NskWwBuoogPDCxvxdM9CCGPbIDnj0qWdl7uiIGcfdb1p/QukM8OL
         pdZWPQwm48PFkQoEp75ER+LOuJDJTADznhB5adFzdm3Oqamg4Pdn+uUn7fJIWFTAq9
         WYTBf0L0DTcbBtlUUlwledlovbZv+IGmvtYp8254=
Received: by mail-qt1-f170.google.com with SMTP id l2-v6so4349771qtr.12;
        Thu, 27 Sep 2018 14:07:24 -0700 (PDT)
X-Gm-Message-State: ABuFfojaoELM1WmWVpRZSf1jMpwWI3Mr4jCVNekrVgsotJfSEd+9ikyN
        F8FVk297jXiGiSju+GM1Ev9CMIu616/YP2RKxA==
X-Google-Smtp-Source: ACcGV601ZOMAwcvH2pBt4rVdl3V4fCBjnKF+nUxbYv/OfUDi6iKQ4ug8n66fgsb1UzpXDNSSVD+9rmYZsr4SiwoGjZc=
X-Received: by 2002:ac8:46d3:: with SMTP id h19-v6mr10047216qto.188.1538082444020;
 Thu, 27 Sep 2018 14:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <1538067327-5785-1-git-send-email-maksym.kokhan@globallogic.com>
In-Reply-To: <1538067327-5785-1-git-send-email-maksym.kokhan@globallogic.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 27 Sep 2018 16:07:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLtwy_odfY+7-Braa1vJFPxF-+P+UcEFNSJaQGFhd9qig@mail.gmail.com>
Message-ID: <CAL_JsqLtwy_odfY+7-Braa1vJFPxF-+P+UcEFNSJaQGFhd9qig@mail.gmail.com>
Subject: Re: [PATCH 2/8] drivers: of: ifdef out cmdline section
To:     maksym.kokhan@globallogic.com
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Daniel Walker <danielwa@cisco.com>, aborduno@cisco.com,
        rbilovol@cisco.com, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 11:55 AM Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
>
> From: Daniel Walker <danielwa@cisco.com>
>
> It looks like there's some seepage of cmdline stuff into
> the generic device tree code. This conflicts with the
> generic cmdline implementation so I remove it in the case
> when that's enabled.

What's preventing removing this or simplifying the DT code to just be
"give me the cmdline data from DT" and the common code deals with all
the combinations of config options.

Rob
