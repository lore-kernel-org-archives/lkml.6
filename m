Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D2EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4689E222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ShgRT5dA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406717AbfBNSXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:23:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732475AbfBNSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:23:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so3507411pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:in-reply-to:user-agent
         :subject:message-id:references:cc:from:date;
        bh=v4Dgzc7R0xDWwvbr/g3YrHEwvNbN2URhboLnsepPrNU=;
        b=ShgRT5dAdYngTss+cNIVEnYaMNg5KOlCFhGwsaP01IPKjGrTmS7BpJDX0Iisvgszg7
         7d1pvvuY5xViakwboaPvnYTKAVqVwsEFsmXWhtOwQ1H9koJpjihp0Ty2Gzo2yV0czOAL
         61Lb61fTcwZuoEbJSLWH+5AvJr6Cdp2vAgsSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to
         :in-reply-to:user-agent:subject:message-id:references:cc:from:date;
        bh=v4Dgzc7R0xDWwvbr/g3YrHEwvNbN2URhboLnsepPrNU=;
        b=bxr5lLjge2+vNsrN8pR3Q/4CIf9bofynINf3UgCokNZz/V2UJhYGIur1dNHnecsavL
         9ZKk5VZRIfaQ1jjHeOVnpvYI+/uy7MlPssDHSXIFib33mKBGU/Km9OZ/4MeXeRuDMm40
         Fx7PtHdI1olMaRr5XBCzH6nFrwOdx9Z9K4Pf5acYWyqMHfY4GfuWv+jmDx0en1H7jEFL
         cukikc9JG+eo9U6yXE2UmO1IGZWd1G3r4zAZfRCHO7KbwSTqrRsdAND6o9jqx9xCA1yU
         BOn/LTx9pOIQLteZxiABiF2vPema5iUtPXY8pXfl7rdf0IFs8m5+9cN3hsFQji1dBdkN
         V9KQ==
X-Gm-Message-State: AHQUAuZWfmKiCvfUNh++y5aVZGqaaDqJ1qeNZjBWgeNthkdpaaKyoJS1
        G0a2VIqkzR9D1GjUKr3zm2mjjQ==
X-Google-Smtp-Source: AHgI3Ibw6XurjCeJcf/obgECg90b3RVMoBP6u4zwrf5K7lAz6myg3uBhMhDlvVIy3tJ3De3YHWUNvg==
X-Received: by 2002:a63:5962:: with SMTP id j34mr1187347pgm.297.1550168617620;
        Thu, 14 Feb 2019 10:23:37 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c17sm3780182pgg.0.2019.02.14.10.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 10:23:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
In-Reply-To: <20190214173633.211000-1-dianders@chromium.org>
User-Agent: alot/0.8
Subject: Re: [PATCH] soc: qcom: rpmhpd: Set 'active_only' for active only power domains
Message-ID: <155016861608.115909.15345028096522143351@swboyd.mtv.corp.google.com>
References: <20190214173633.211000-1-dianders@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Thu, 14 Feb 2019 10:23:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2019-02-14 09:36:33)
> The 'active_only' attribute was accidentally never set to true for any
> power domains meaning that all the code handling this attribute was
> dead.
>=20
> NOTE that the RPM power domain code (as opposed to the RPMh one) gets
> this right.
>=20
> Fixes: 279b7e8a62cc ("soc: qcom: rpmhpd: Add RPMh power domain driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

