Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EE6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E452146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E452146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbeKPB6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:58:44 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44328 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeKPB6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:58:43 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so4553143edd.11;
        Thu, 15 Nov 2018 07:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ptgeYb1FlkwS0J6Br5d/GQGb4cuDk43I1rTOG0NNzk=;
        b=bD4fvV8bRZF3/e5kNHGAaQyuBa/HzBNvE3RHPGxE1iUKxGSe8a8jlcWTx6LFqkwQ7N
         VRRNoriZY1kipDJfochIv94nxdY+XxFJKrbmPHpQMeSdPA7h98KTScEhWAjOT7xTw1Mr
         92FJj20jBNVEWL2ZdG0Bj0LqRIeoO3MCv4m5PMMYH9g9uUps1qSQwWqnQKOOI+J0dGCy
         G8LAMWlsOweEgOCj/M6k9lU3A4gVsZJohstONE2Dzl8wP1dm2VYxfYEGdsJRILY6/tk/
         R7SoBvr7+fOTRRQwbxFRlpFasYnEJ05btFLvVJIzyC9m26VTu8FtJGg0WTxbFwVSe0QF
         FrKg==
X-Gm-Message-State: AGRZ1gLmgduaEn0Ogfuy+KJGSkdWYSdBpNfRgFPrJV59ruH/yqcuZZUZ
        hR1jAO0De55AfLWDn7UOOptgq/LdN9o=
X-Google-Smtp-Source: AJdET5cqA6AS3O2wNfjPJQ5C3U9U9XTLTopMnYmrSVhDM/j35l8iiByXd6TRw7JLwboVOnmcVELQDA==
X-Received: by 2002:a50:9f64:: with SMTP id b91mr6104534edf.235.1542297019749;
        Thu, 15 Nov 2018 07:50:19 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id j8sm3620109ede.55.2018.11.15.07.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 07:50:19 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id f2-v6so18387318wme.3;
        Thu, 15 Nov 2018 07:50:19 -0800 (PST)
X-Received: by 2002:a1c:9f01:: with SMTP id i1-v6mr5569222wme.8.1542297018887;
 Thu, 15 Nov 2018 07:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com> <20181115145013.3378-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181115145013.3378-2-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 15 Nov 2018 23:50:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v679sG+KqmkGway8E-CdgQa8ybBv8K2RdNwfB7zWAJkaXQ@mail.gmail.com>
Message-ID: <CAGb2v679sG+KqmkGway8E-CdgQa8ybBv8K2RdNwfB7zWAJkaXQ@mail.gmail.com>
Subject: Re: [PATCH 01/15] ARM: dts: sun8i-a33: Remove heading 0 in
 video-codec unit address
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> This cosmetic change removes the heading 0 in the video-codec unit
> address, as it's done for other nodes.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Nit: I'd prefer the subject prefix format be "<family>: <soc>: ... ",
or "sun8i: a33:" in this case. This format seems to be used more often
than your alternative format.

I can fix it up when applying.

Acked-by: Chen-Yu Tsai <wens@csie.org>

ChenYu
