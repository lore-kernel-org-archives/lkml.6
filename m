Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFE720859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c5OVW35m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfAOTFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:05:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39092 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731438AbfAOTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:05:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so1750099pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=jVLDPji61vZbeTZY3dBL/t+hsWMxEb14cJ8x51Qazuo=;
        b=c5OVW35ms4Off2eQ0KHcCQ/IBHMA3sc9drQcC3wK7CAcIih0/YMdeFy0+hrVMHqGp5
         wg7Eyf8ebclm412wddwC/Xi+VFMUVe1XcOFRFy5gGGRiL6R5VCrkGRZnpVb1mcbFw9uw
         6wDTNhwKqEGpB6VydpH9IWxCvB2JyFj3hK+Z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=jVLDPji61vZbeTZY3dBL/t+hsWMxEb14cJ8x51Qazuo=;
        b=apRDgi0iHSOZ6lTixE0Uu7GQw+BpGsCZY+l/Cb/1CS57dK1EO2AVmd56Lbxe7/SF32
         2vb23X7HVoLzcFK7rOGOL/IdxZX3wtMm6Nji9PyUH94C4lAM09qS0hgitt0C5xiSrjC9
         KjnEUGSuh1EKgxZ1IoP02TFgIBRoKz94RDKfVu1LIIUCIJ+BZWC/bzsOgkWQPVaYTkW5
         4jKvcvO43mTSF9Ep8P0rGPqw/nKHvypMVuSB5T4DbnpSRQBRVn+GZqO2XkFAoY1ThE6v
         tZ81pK7+KmSwqDhMrj9vdAexoKytuWgLaTZxoTOLK41PxjG0pzLPvsnHYay6au7KwXen
         +O9A==
X-Gm-Message-State: AJcUukcX29h89udPxer8QhpgNGqwUFam2U+smP+BgDGndXBfGWp/Gr/d
        ubsKVLCm9FC3avvPgH2Y4dq17w==
X-Google-Smtp-Source: ALg8bN4rS7WS+Slg/v9Zym3pd3CSedk8IHzlzNLjYd5EktJFUcpJd8TXJ0v2Ckxd7LRkc3mQ7HG59w==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr5627978pfe.130.1547579132787;
        Tue, 15 Jan 2019 11:05:32 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c4sm6801736pfm.151.2019.01.15.11.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 11:05:32 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 03/10] cpufreq: Replace open-coded << with BIT()
User-Agent: alot/0.8
In-Reply-To: <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org> <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        linux-kernel@vger.kernel.org
Message-ID: <154757913102.169631.11045991510648105366@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Tue, 15 Jan 2019 11:05:31 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 08:34:55)
> Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
> comment formatting while we're at it to make it easier to read.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

