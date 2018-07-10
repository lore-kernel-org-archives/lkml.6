Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3CDC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDCF208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDCF208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbeGJQQk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:16:40 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39362 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934326AbeGJQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:16:38 -0400
Received: by mail-ed1-f44.google.com with SMTP id w14-v6so16999786eds.6;
        Tue, 10 Jul 2018 09:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0/GkL0f87Q3s2mn4ZLMWfKmf5fxxt27T5VQhPb22TuY=;
        b=dCIWL+G+SwH8pyW+et3Tx1096HQbgRbS3NIfOspi6OapBQIswD8uBo3QhjmrS5VfsX
         MF5fXD75YPrKvWeYLAxL5ZAPaAMPMfu3+zAY3y6QidHvnq5SU6pasD7m5bA7QeUsZ+iy
         FRAJohgc8YsvBlUIX+zL3tXq9R13gECyrbDIJcjw+aWo8WNEshIJJUGkINemI6Ntvbfs
         bc/Z1GCFeuCZY9bXXxax2m9/nbcl3MsJojDeH94e6v9FQAz5YMd5Wmo+5xjbikxPV5MF
         H1mJAE3R3EQQ63udAPBTI4avZh/cPu+CeFI0X6OnVGAvL1ZEXNI3XL7ZSF3iSt7IDpId
         c4Ew==
X-Gm-Message-State: APt69E0Bq1a5v4PGQ4l1TH655cmp8cRhVXerLozxy331q8ktr9E/f1qJ
        HB3YYvVS0czPW7rvj7xYleF7OUtB
X-Google-Smtp-Source: AAOMgpdVg/X2FmjV5syLSrOk/t4+vDfR/V1/CtsAs/eZBRBpY+8cPr27LA7F7L5+d7iQsnpXUWQOIQ==
X-Received: by 2002:a50:a0a6:: with SMTP id 35-v6mr28004420edo.280.1531239397155;
        Tue, 10 Jul 2018 09:16:37 -0700 (PDT)
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com. [74.125.82.42])
        by smtp.gmail.com with ESMTPSA id p30-v6sm11980090edc.5.2018.07.10.09.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:16:36 -0700 (PDT)
Received: by mail-wm0-f42.google.com with SMTP id i139-v6so25091928wmf.4;
        Tue, 10 Jul 2018 09:16:35 -0700 (PDT)
X-Received: by 2002:a1c:8c12:: with SMTP id o18-v6mr14248982wmd.120.1531239395812;
 Tue, 10 Jul 2018 09:16:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 09:16:15
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-16-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-16-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 00:16:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v64=Mzwz6eZxvHO6XuCNa5XQcQDt8HkOrFqRO8MXTVSRjg@mail.gmail.com>
Message-ID: <CAGb2v64=Mzwz6eZxvHO6XuCNa5XQcQDt8HkOrFqRO8MXTVSRjg@mail.gmail.com>
Subject: Re: [PATCH 15/17] ARM: dts: sun8i: r40: Disable TCONs by default.
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
> R40 has 4 TCONs, but only 2 of them can receive some kind of output at
> the same time. Let's disable them by default, so only those which are
> really connected on board can be enabled in board dts file.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Originally I had wanted all TCONs enabled by default. But that would
require some more work for dynamic assignment of TCONs to CRTCs, which
is way out of scope for this series. So,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

I'll think about if and how this could be done.
