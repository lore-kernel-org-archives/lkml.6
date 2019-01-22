Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAC1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC9220856
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcYx1BvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfAVS66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:58:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40058 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfAVS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:58:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so11467340pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :references:subject:from:message-id:cc:date;
        bh=7n996eizIHOZB8ObkrUMaDzi4+lB9X87FLco778lNQo=;
        b=AcYx1BvDdMXNDcb0MwDOi0eAbYuwQ+v//FUPCT6JRYaR1RldCQk2Ax0N88obUwax8r
         U6fFcbd1fkuNoWqxLNSyxqi8wf23iBYwLladnWqZxxY/8BQ1zPZM4sUxpEakecDAnKVr
         gzecddzicBmlJYRQ6bVP60A85qJXUgz46jhQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:references:subject:from:message-id:cc:date;
        bh=7n996eizIHOZB8ObkrUMaDzi4+lB9X87FLco778lNQo=;
        b=IZI4gHTLwhankCrpIapxDQ6er4Evot/pVISmoIZXLjyA++QPtSSeRUPCLWCNGSSxNk
         J7V28h7XnNFBOOVRevxHalbLVZKPdAP0xfbgLEZpu8OfB9O5V56C9MY9u8g6a7rS/aPq
         7zSWaoPsVpo/7ITfQ1gv4+s5N5ShoMTjz4l/05dEsuA9hAIEYfL60FlRriJ8kTbdfIgz
         vSIQfXzzQBU7KNl50WBXdcrRumx71rGzClkb7T+0ZJxPLLHFWntNniOZq+5iU04vB+wY
         Tw2+KVQJhBM+CJcXjpgE7IiI06LH6OhuC+njU1dTfo4psOrvw22dhkJ1jMBffWLubJU1
         YiLQ==
X-Gm-Message-State: AJcUukc3EKgoflZoo3J93rI7b/QV8o3XBWMyxUQWAfnzE1GEW7kuONxW
        ynXjAP0KAzkCJq3Lc/SCNUR+QQ==
X-Google-Smtp-Source: ALg8bN5ttFVZQXDeQh4FN9DFG4mw8l6cWhO5GDyQgOfw9uoUCmCyOp4iOjjBmrIIeMbZ3QRn6gShUg==
X-Received: by 2002:a63:104d:: with SMTP id 13mr33282463pgq.303.1548183532817;
        Tue, 22 Jan 2019 10:58:52 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n70sm26850366pfi.185.2019.01.22.10.58.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 10:58:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
In-Reply-To: <20190122055112.30943-2-bjorn.andersson@linaro.org>
User-Agent: alot/0.8
References: <20190122055112.30943-1-bjorn.andersson@linaro.org> <20190122055112.30943-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v3 01/10] arm64: dts: qcom: sdm845: Update PIL region memory map
From:   Stephen Boyd <swboyd@chromium.org>
Message-ID: <154818353130.20280.17905705223316470797@swboyd.mtv.corp.google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Jan 2019 10:58:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-01-21 21:51:03)
> @@ -103,10 +138,30 @@
>                         no-map;
>                 };
> =20
> +               venus_mem: memory@95800000 {
> +                       reg =3D <0 0x95800000 0 0x500000>;
> +                       no-map;
> +               };
> +
> +               cdsp_mem: memory@95d00000 {
> +                       reg =3D <0 0x95d00000 0 0x800000>;
> +                       no-map;
> +               };
> +
>                 mba_region: memory@96500000 {
>                         reg =3D <0 0x96500000 0 0x200000>;
>                         no-map;
>                 };
> +
> +               slpi_mem: memory@96700000 {
> +                       reg =3D <0 0x96700000 0 0x1400000>;
> +                       no-map;
> +               };
> +
> +               spss_mem: memory@97b00000 {
> +                       reg =3D <0 0x97b00000 0 0x100000>;
> +                       no-map;
> +               };
>         };
> =20

What's the plan if certain configurations don't use all these carveouts?
Can we mark the reservation nodes as status =3D "disabled", or the reverse
and mark them as status =3D "ok" in all boards, and then reclaim the
memory for peripherals we don't care to use?

