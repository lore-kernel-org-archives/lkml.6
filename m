Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FBFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FD020675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxVErPDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfAPXCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:02:42 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40807 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfAPXCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:02:41 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so3728142plq.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 15:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=u/Qmfy0uSg9phq/QiqFcUGs4W8KS3Yos6m3ESK+a6cA=;
        b=IxVErPDA72L5TQWkuh9ICSKvf/4nk2zdFFLeQDpDChwHmLyX6662N2DQ9cXbyN76rR
         X4zKTp4sx+SYbdv4oBCAfVdYElJGnMMYFHoXOhGX6HF8usMxpl+i4i277Adl6tM14aXB
         ksu5Y94+XKZ5AHlu91hxUv2vx5KxSgW8CuhAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=u/Qmfy0uSg9phq/QiqFcUGs4W8KS3Yos6m3ESK+a6cA=;
        b=dGp25qe/f1yzg02rv2hORrAPH++vPcwHNKQpAU3yfjl9cfPguybN2jYbP9RXvgSTtG
         pNPKfyR4ncceNFuM/9+qCuiigtkCwuH+jGJt0TAdOTZYh1ombngQ6hhTfYxh6VwK71v0
         cjyszTDdTjm8m3RLZEGkI7+T7tfuN8ce+sfvmj1mtoCxIVEnNIqwQqzFMqRjCem61N7x
         WYh7Uox6nSHwAcEQXLrmxCkt/yy4+m8kSdHGnrZCO9GWbTH7NuaXVJNBaDsu+OZDrpzA
         cs1Qs4LdNxbjTCJDzlxz9rNppDhklTKnLSNctKvM7OtIZItYR8tB81KncSxcN75y90ys
         gG/A==
X-Gm-Message-State: AJcUukd/jsKn2yqKDL/4m0xcJ+SsLUAB2jZQYbxGRm5ltya10eIoiIKY
        jIOGLrBbvoKDHq7P5H0hgFhcdA==
X-Google-Smtp-Source: ALg8bN6pjAZ37OGjKtrbS3yO2YFLvmFPZHpPqe3DaRjyaZUzF6PpprXw6IGM9dthFTt7/unWWtiFeg==
X-Received: by 2002:a17:902:1127:: with SMTP id d36mr11989847pla.299.1547679760995;
        Wed, 16 Jan 2019 15:02:40 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l3sm11311750pga.92.2019.01.16.15.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 15:02:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm845: Expand soc bus address range
User-Agent: alot/0.8
In-Reply-To: <154767899836.169631.10485468432153568181@swboyd.mtv.corp.google.com>
References: <20190116071939.23136-1-bjorn.andersson@linaro.org> <154767410807.169631.11634052870112778681@swboyd.mtv.corp.google.com> <20190116221003.GW9278@minitux> <154767899836.169631.10485468432153568181@swboyd.mtv.corp.google.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Message-ID: <154767975942.169631.1254649555789319450@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 16 Jan 2019 15:02:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-01-16 14:49:58)
> > >=20
> > > Do we need #size-cells =3D <2>? Maybe it could be #size-cells =3D <1>=
 and we
> > > can avoid having to specify a second size entry that's always going to
> > > be 0 because we don't have devices with huge IO regions in the SoC. Or
> > > does it need to be 2 for the large size of the size element of
> > > dma-ranges and ranges here? Looking at the code I think we can rely on
> > > the size-cells of the parent node so I think it will work with size o=
f 1
> > > here.
> > >=20
> >=20
> > The "length" part of dma-ranges is described using #size-cells number of
> > cells, so with 1 there's no way we can describe this being 36 bits.
>=20
> Yes, but doesn't the #size-cells of the parent node (i.e. root node in
> this case) dictate the number of cells of the "length" part of the
> dma-ranges property here? I hope that we don't need to push down the
> larger size of 2 just for this reason, but I admit I haven't run the
> code to understand this all properly.
>=20

Ok, nevermind. I read the code more and looked at the spec and I'm just
talking nonsense on this point.

