Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF93208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF93208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934368AbeGJP4v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:56:51 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35740 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933796AbeGJP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:56:50 -0400
Received: by mail-ed1-f68.google.com with SMTP id b10-v6so16938558edi.2;
        Tue, 10 Jul 2018 08:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sFJgnebbdYO3u1u1RHDwVn3p0a6RqE+snYl0Qe6aLE8=;
        b=mHjX6W43IUZ2pyOzzaooUhyhFfLv4urx/efjVXxIKx0RbbEsk5XwfLnoMcY6tltGjc
         /qHto+LvbFydiXfPjfGdCKiHXZJOkbmsQmYE7ML7Au5e9bWy/eMtp0UJAM9fWN3lTdcU
         PYgHr/fVfWNXE1Q+6JREiuGBzwqol0JMzzVYP7YY699jDD/VA9m9UMCwPe6j24rqOOD8
         7qwxsGyvHl1DqCp9tncBgV1gJIs/WwbBCvcMsMfA8vZbrUUY/8l+U1oZbHvmK4UupMiV
         SbtP5qYVe7QjSqWJqlp2QjdjlsgxQvB8UFbuNSSaQ7Zhp2OqDZ65M5c/+eaBX56O+ozP
         2qbg==
X-Gm-Message-State: APt69E1I5vn4rYvFsFPg+NHAEqApb+q/BxiZ2oIIB2RAxACynLl5dwKF
        2Ye2kqmRWKXN+ayCnJiIyjld8ED9
X-Google-Smtp-Source: AAOMgpdzmwO5zogVAOdCWqR986VAEilviYUClVnqdA97nE6QPUTjoQPmKAnMlHOBUwG1f8VzcwqWyg==
X-Received: by 2002:a50:92c5:: with SMTP id l5-v6mr26795375eda.52.1531238208618;
        Tue, 10 Jul 2018 08:56:48 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id b18-v6sm8924244ede.21.2018.07.10.08.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:56:47 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r16-v6so15179681wrt.11;
        Tue, 10 Jul 2018 08:56:47 -0700 (PDT)
X-Received: by 2002:adf:f9c9:: with SMTP id w9-v6mr17736496wrr.105.1531238207548;
 Tue, 10 Jul 2018 08:56:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:56:27
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-11-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-11-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:56:27 +0800
X-Gmail-Original-Message-ID: <CAGb2v65TTC_JmcrAvd0fYDuMs4H+MwvqrL+LUfGpp_zY+qsavQ@mail.gmail.com>
Message-ID: <CAGb2v65TTC_JmcrAvd0fYDuMs4H+MwvqrL+LUfGpp_zY+qsavQ@mail.gmail.com>
Subject: Re: [PATCH 10/17] drm/sun4i: tcon-top: Add helpers for switching mux
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> We want to be able to set TCON TOP muxes at runtime. Add helpers for
> that.
>
> Old, static configuration of muxes at probe time is preserved for now.
> It will be removed when R40 TCON starts using them.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
