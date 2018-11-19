Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22913C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D533420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fV+uxrb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D533420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbeKSWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:40:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45017 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbeKSWkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:40:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id k19-v6so25919174lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 04:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGd2aNLMi4YSf0GDmSdQabhtqjal3B4onAW9mAOTWAg=;
        b=fV+uxrb2brDoMBoFHehdIB/uHqnlG8PcLTlDDhytZ/w0py+bSOLKmRpBt67VuMxvS9
         KFy1V86lF0Wz2dOS5GKFGNWlKZsa2DItdHPxX8EbhGNzveXEUJseteHsKRpxPJHF969a
         ZyezARBfbJZpCvhCp7TtdyJN/62is19/d95RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGd2aNLMi4YSf0GDmSdQabhtqjal3B4onAW9mAOTWAg=;
        b=ro5vepiUA97hL5cZDdzX3W/xiQFZQLeKxbjGne5O+WeRLKkO0Nj0ut6YkQHjxru4jL
         K+LLsdFxHMFwoOBzH5i5LEUk2H7QlLeRWzSlaJFYRblII7D4hgYfIV5awOXKLeU9VNd8
         8WsPUmpvZgXgO6rztOnUVoAieHP1sZM+qLzRxAww7UjE5wtUqL3+mJQufRMgEaFpFjta
         5T7X/X02/mIw/NSt52wyFOGw7hw2qW3gGmnOJWfjjzRlmsuOOAXPuVk/UiNdOzNIzUuz
         uojB+XpF3s+y4gJOmDw8efmSLmM1DjT1t8Ko4fjImthxbEbbexD1FGnjv9DRrHhvigq0
         73jA==
X-Gm-Message-State: AA+aEWZgNiqjoOSe1Qn8cYTCxvECqOG5rkJKuTeHLL7apsvmSk7F2fgD
        wYBkLemL+e/4UEaJhq6/LS/Xy0zEzpYNOF4581l9qA==
X-Google-Smtp-Source: AFSGD/UqtvWir8DtGvbO9xmWtkjDaapS46zG6DF7VcbBiNCeJ5ygJqwugu0gGK5CxCrt3HHbi8nq+0AlpH2sHA2++Go=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr6825091ljk.4.1542629831302;
 Mon, 19 Nov 2018 04:17:11 -0800 (PST)
MIME-Version: 1.0
References: <20181113095142.32015-1-benjamin.gaignard@st.com> <20181113095142.32015-2-benjamin.gaignard@st.com>
In-Reply-To: <20181113095142.32015-2-benjamin.gaignard@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Nov 2018 13:16:59 +0100
Message-ID: <CACRpkdZ0oc7sZ=4WDCNZfE6W44CkPMhgYEYJrHgYb0TrGUjy=g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: stm32: Document hwlocks properties
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:51 AM Benjamin Gaignard
<benjamin.gaignard@linaro.org> wrote:

> Add hwlocks as optional property
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Patch applied.

Yours,
Linus Walleij
