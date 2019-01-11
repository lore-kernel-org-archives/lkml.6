Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A3EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C5E21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fW2FVUtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390169AbfAKTGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:06:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35522 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731533AbfAKTGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:06:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so7378067pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=qK7ZN+tqgsDFrRNYWCEvChXDmU6TNgrEpZs04O24tMQ=;
        b=fW2FVUtftsyt30w4Q7FSQ5kJvq8KclT16mq27+FUeMNFkxc5Z/OaEAGo6aiYoSUPVL
         NYIxMnU/odpHLcW22HBn+bFyTRJSeroPWxJ/F72yoApcs8eNZW6sQaZ1pyG2wfDVX7Sv
         DOKnPgf2MG+RbrOkWoxTrGfHXABS4+95NDwQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=qK7ZN+tqgsDFrRNYWCEvChXDmU6TNgrEpZs04O24tMQ=;
        b=nIhDgvTOGhZa7F2Y8xaI+4TEUgCz3FMhL1/MVBEWQN0RY7Mu4RI7Jhi2tJLILC3vy6
         maQ/4weecEqTYf+5GjoYQAalaQyWmbhBSm6gG+BZtF6dltwKXZGIj8zYDIn/szMhTBL/
         /+EpqicNIJd0rP8TefE6WGrx1fmQNkvrkuKlNzZH69JgTrXZEhPJy/ZjlPPOCf2vhTfP
         bA6FvPt2Y8o5+tcWalwaCfemGmCjtQhVCtb5TvV+vGt1yL09tVGyw7s8vlo2RuBYuZtr
         y29pQjbxXb1gdA+5Fap6VGrOl6VEKIvyQmb9e+PBfnZ4XVTmUA+2sEK8I5fOhHls+JW+
         VRmQ==
X-Gm-Message-State: AJcUukcq0keYHyPHIvdcm8FKmuKHPzQoJHibzF61eypymctKzyFGWAzW
        8UcBxCTS6Q04Kyw+laHsYzIAWQ==
X-Google-Smtp-Source: ALg8bN6vUFVv3TDGYEeJ2LwD/pfuzUcrO3ClaAWtxRNUk2xz/YI4DMEOOVTk0UskHJ3O3vr6kN+r+A==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr16125820pfe.148.1547233566181;
        Fri, 11 Jan 2019 11:06:06 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p67sm132982099pfg.44.2019.01.11.11.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 11:06:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 1/9] dt-bindings: opp: Introduce opp-level bindings
User-Agent: alot/0.8
In-Reply-To: <20190110040209.6028-2-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org> <20190110040209.6028-2-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Message-ID: <154723356455.169631.14468856077074543422@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Fri, 11 Jan 2019 11:06:04 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-01-09 20:02:01)
> Add opp-level as an additional property in the OPP node to describe
> the performance level of the device.
>=20
> On some SoCs (especially from Qualcomm and MediaTek) this value
> is communicated to a remote microprocessor by the CPU, which
> then takes some actions (like adjusting voltage values across various
> rails) based on the value passed.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

