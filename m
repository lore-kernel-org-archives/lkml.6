Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC9C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F90E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fTPP/HZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F90E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeLLSZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:25:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33388 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbeLLSZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:25:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so8993500plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=XaPwitIqp/uHw6KH2ByrX+1rApYCMM7IHrLGFCUFFuI=;
        b=fTPP/HZCAbAx6DOqv6nCHF6e2ZMsdHs2ATYf5VMOcnulvllyLAhHCtg0m8HveOXUP7
         OWiT6VSFC8dPO7xXY33GWe2SHUSWE2O5vcSgknHtNoLU6LI/Pw7iwog9wp/hgADpubMG
         qBaidqLwuK5tJem3JSULbVPPOD1GbY94AjWb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=XaPwitIqp/uHw6KH2ByrX+1rApYCMM7IHrLGFCUFFuI=;
        b=c6ivzXfx0tj/qcYBFH5z1iFVxDvkKOjSS91C3txkzG35cCqUZFjr0aAxG/Vr3oM/+h
         hXfh6VQmK9esordQkLoktaf9BBaMBWKMBk6lOt6zhutJZpdoaYViTjwYrjr/oVGlqFPe
         pTP9eFWShuAijKO6waf6yOQkuBXFW6Fo53coY6pXJCDD8BQO/J4rLBW5Nvmi55HZXa4T
         /DhvAr8509fwcNZEOseTta8SxvJQOwhpgVh+QIlwvusDQ/gXNKnc6xA6t6Cr+Kelt6+r
         YdMGoj50ATuJIMzJngFb+c/qdbPRK5kAauLMl5dWLWtZaozhBKrNkk6DIytF3bovKVXn
         02Og==
X-Gm-Message-State: AA+aEWYdNshF77AeGKvbJxkHNF9HuBD56HxAo6DNQWVfTz/3uMNrC4UR
        PRhhZ1W0mDUUPgd5jb56VpP9vg==
X-Google-Smtp-Source: AFSGD/WRfRJAzjp9259Fc4wtdfvSCr4tGBIbps93SXXSV2rucl3sS0FfnTpKiHHIGYfDzwjfGM/YAg==
X-Received: by 2002:a17:902:1008:: with SMTP id b8mr20014309pla.252.1544639130470;
        Wed, 12 Dec 2018 10:25:30 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x3sm58701613pgt.45.2018.12.12.10.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 10:25:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181212092131.13046-11-rnayak@codeaurora.org>
Message-ID: <154463912916.17204.12857180383621384088@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v7 10/10] soc: qcom: rpmhpd: Mark mx as a parent for cx
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181212092131.13046-1-rnayak@codeaurora.org> <20181212092131.13046-11-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Wed, 12 Dec 2018 10:25:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-12 01:21:31)
> Specify the active + sleep and active-only MX power domains as
> the parents of the corresponding CX power domains. This will ensure that
> performance state requests on CX automatically generate equivalent reques=
ts
> on MX power domains.
>=20
> This is used to enforce a requirement that exists for various
> hardware blocks on SDM845 that MX performance state >=3D CX performance
> state for a given operating frequency.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

