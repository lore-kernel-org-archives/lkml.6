Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BA8C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEF325D63
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEF325D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932793AbeF1Cch (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:32:37 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46513 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbeF1Ccf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:32:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id r17-v6so4200712edo.13;
        Wed, 27 Jun 2018 19:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aX7VXYTRquYyqId9LY02tdjA+BbUw7REe86mHCw3Zgc=;
        b=VBzsjsEkWoWA0jK9WVXcH0sl31Fzegs5hL93wTTLnD1KsLaTME33KAn0do25jGAOyO
         nF2b/sI6xiea+6tleV2k0LinsxZ+o7Qmd+12aki/7zsPexzuzNH1qThimpHPqXairH0/
         VKoOKNgfO9rt2ziQMIF6j7m9e9qWB5U4UFpeN/8ofnsVP3fWiNorphKHVTOAijaz/OVW
         hq43usDKWtp5LjRZu4BT8jIlmI8+zoWKJU5aVRV1w9ZKjmGwBsDLQnkdRXvggtXLSz00
         iagqz1b7+Vem2y7aBMmAR5INFqJyiE3gNvygF94N8RQiSIpyh103lIoDkU2H0zuxv0bV
         uYMA==
X-Gm-Message-State: APt69E0mTreLW9TkQ1KZ81SxHfuVLkAJWiFUJFmFLiIECGGat3snUDOP
        I0YyqitDFc9xE07un0uF0z0ElWhK
X-Google-Smtp-Source: AAOMgpefZcgs9KbycIE1ccfY5BWpFmF+OX0XICSqosWH+V8YaFs8J5aiMAdfu4JaF2IA2tzwnZWacg==
X-Received: by 2002:aa7:d518:: with SMTP id y24-v6mr4273638edq.163.1530153153651;
        Wed, 27 Jun 2018 19:32:33 -0700 (PDT)
Received: from mail-wr0-f170.google.com (mail-wr0-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id q22-v6sm2545143edd.69.2018.06.27.19.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:32:33 -0700 (PDT)
Received: by mail-wr0-f170.google.com with SMTP id k6-v6so3850342wrp.4;
        Wed, 27 Jun 2018 19:32:33 -0700 (PDT)
X-Received: by 2002:adf:e94a:: with SMTP id m10-v6mr7064679wrn.126.1530153153316;
 Wed, 27 Jun 2018 19:32:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:32:12
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-22-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-22-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:32:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v66vEJZijF82u6cKf3j0J678=kNCCps5+=oj7iHCzM9n6g@mail.gmail.com>
Message-ID: <CAGb2v66vEJZijF82u6cKf3j0J678=kNCCps5+=oj7iHCzM9n6g@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] drm: of: Export drm_crtc_port_mask()
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:03 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> Function is useful when drm_of_find_possible_crtcs() can't be used and
> custom parsing is needed. This can happen for example when there is a
> node with multiple muxes between crtc and encoder.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
