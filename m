Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF9C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FDF20672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IJKl3aDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FDF20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbeLKVv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:51:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37402 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:51:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so7546457plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=5U5yNzmEwBhEdLevIYOp0WpvRNXTTqLwKJRS0kXaBGY=;
        b=IJKl3aDtjKXXgthQ8cGjCVgLQZpOBVR1TMAteg34s+gnEm4KiHOyZIuYZxs8Bjzdil
         Eu7wHBr6gfamUvL+BVn1HU+xULgUDy+FXMJPaPFWM9DVu//8TVG61LW+3okqdE5WEuW8
         YWa2rQqqiu8WzTGiJIYFCcyWbZciDLLPzmMIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=5U5yNzmEwBhEdLevIYOp0WpvRNXTTqLwKJRS0kXaBGY=;
        b=GwRZRL+KF01deGMVn2DpjXY1OuOMurxW6oFcA01HGHNgeP/EyjtjOTUuRjHLIo7Du5
         0qlXxxgTyCMY97kJKpGf3BRd5y+Qj6WPDeBV3PtsBXkJnuWacxuqSnAIMjNEOLxvbr20
         Hj56tatiO/pPkNfKVqdEIHnk8Ml2Vu/FkJd6XGta71AOe70wtkwZd3HOvB8L7h9T6WAd
         MeNFeD0NgXd+cguNXjLngILtVUaWnXrOG0U9w53szmhDRlqwR75LoPzY+AM9l74t29Xj
         mIK/JIfq2OCGMCRdxH3FCHYBjpfkTcta0hpmZ9mNBX2kMaSlJswIjsHsC2jkc2QQgNQ9
         taOQ==
X-Gm-Message-State: AA+aEWbePzBHiCUxmEby2B6bYPExVlCihaYrJdrO+L+Xyv5N6zIDfeJE
        8ZeJfN/G7b+7NnuDZOaklP54Gw==
X-Google-Smtp-Source: AFSGD/UioIrkOKooOOJHlc7v3bgTT+CUY1s6EWE1wCL8WnlKcXHLVOqa0s/ww3lRX0UpvgEPuRBzBw==
X-Received: by 2002:a17:902:1682:: with SMTP id h2mr17531211plh.243.1544565115412;
        Tue, 11 Dec 2018 13:51:55 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d80sm41584408pfm.146.2018.12.11.13.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:51:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181211094938.25086-1-rnayak@codeaurora.org>
Message-ID: <154456511414.17204.10860688288502708116@swboyd.mtv.corp.google.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
Subject: Re: [PATCH v6 00/10] Add power domain driver for corners on msm8996/sdm845
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181211094938.25086-1-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:51:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-11 01:49:28)
> Changes in v6:
> * OPP binding updates for qcom,level reviewed by Rob
> * DT bindings for rpmpd and rpmhpd updated to specify the
> OPP tables as child nodes of the power-controller itself
> * Removed some module specific remains from the drivers,
> now that they can only be built-in
> * Added a simple_opp_to_performance_state() helper

Is the idea that it can be squashed into the patches that use it by
reordering the series? But otherwise left at the end of the series to
make things simpler to merge without it?

