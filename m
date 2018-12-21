Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56895218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQMPtfnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbeLUAxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 19:53:06 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38023 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731018AbeLUAxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 19:53:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so1724530pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 16:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:cc:to:from
         :in-reply-to:user-agent:references:message-id:date;
        bh=HlVXxPgV+Vp6VResQkgApoO0DqWUZVZJjbqjHEAaOxE=;
        b=OQMPtfnAvEcnotUVRgcQJmv/CmclUhvuTIOfc7jB480Mfz9OIASwIJTHLXTlwdTckr
         ST+4ULUY2m/vZ+Fsx78/kKMovfemGCEAqdRmy8ApQFFZPB+6j03CKIh6E7DQypDgMrUa
         qdBMYNVDl7gXMoMJv3lFXiZRAjzuL+43tMh4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :cc:to:from:in-reply-to:user-agent:references:message-id:date;
        bh=HlVXxPgV+Vp6VResQkgApoO0DqWUZVZJjbqjHEAaOxE=;
        b=GScCiFOV+dv0R+vOfC2bdy05/BJrGRDK2PLS6Xzm7/X4wM3o64FpvrBaiEfwfWcUt8
         /UqrSM+0ch0sBagB44BgmSu1mWwqoTaO5EFv9HzwIukaNtVunEa2tWWJSsYrBHU3G6fZ
         Yz03cUY+6lPpbmYJJwCOfkNkEKCG756cTude4AhDIrKypq3O8na67VHZ97dOQGMANfCS
         sjGyzQjZimMQxyhTl2IP0tVD3FYXZne5QVvRUPnfr40YFnYlxoGyOkYgIYSiCylx+vAF
         08j+BJfn+7YSMRC8uRca4MNPfH6sXfwWbkjlHmD4i1x7Gk+hPWSXzNIZwI9iJaz/yYDi
         kGUQ==
X-Gm-Message-State: AJcUukeVbx5hHX8xwCHe3YYuXuWKOldBP9Dajnq6e+t7aeo/yHGk62Cu
        ltRRqZ1NR7R3GLslIekf5q8PFg==
X-Google-Smtp-Source: ALg8bN67Et14VOB/Onm+WLJc2BqNTUUAJw4tUfojMT5CgK0WmRgoJQNc92OVRenjPurIcXixAhWbPA==
X-Received: by 2002:a65:560e:: with SMTP id l14mr400090pgs.168.1545353585003;
        Thu, 20 Dec 2018 16:53:05 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z9sm55005053pfd.99.2018.12.20.16.53.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 16:53:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 5/8] drm/msm/dsi: 10nm PHY: Get ref clock from the DT
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181219235528.114830-6-mka@chromium.org>
User-Agent: alot/0.8
References: <20181219235528.114830-1-mka@chromium.org> <20181219235528.114830-6-mka@chromium.org>
Message-ID: <154535358322.13075.15370567255941355044@swboyd.mtv.corp.google.com>
Date:   Thu, 20 Dec 2018 16:53:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-19 15:55:25)
> Get the ref clock of the PHY from the device tree instead of
> hardcoding its name and rate.
>=20
> Note: This change could break old out-of-tree DTS files that
> use the 10nm PHY
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

