Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAE8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1B8208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1B8208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934327AbeGJPyV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:54:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41941 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeGJPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:54:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so733468edr.8;
        Tue, 10 Jul 2018 08:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/JdXMA9YpiUbzTwRTL0vH2J+02KycwqmZaTSVobbCHk=;
        b=BFzXNUPktCnc5XRkcEV6BPNPle90DXBQuwatMdiLJr218x6puPnRZOf484+wFSfejm
         wIdKqhOpAg6uipIc3Flc9I5RrGHZ2FfvLYTjvA9Wnll2ETMAVrgtk5dS1cOtpd5vGvyT
         CBxYS/hgVdHLnMicykOThcVrwn7DT28JCbBIFEG6sTAYwf4xIloMuvVyz+4EExSrffwc
         y1C/gun8Zv4ZS6faAmYxJnncskMVUvrgqKkRViIL+ODTsKhxj4uZEJ+A9Jtz5YHoSRo0
         HuYp/5T7xaHU/AzBjArGaoZjAEn52vShYUJO7wTjWB3Vsd/Pu0rqr5i2453gqy+UksyS
         rnCQ==
X-Gm-Message-State: APt69E3YnbuTGGvuA96WhLEUcQZ89kTJFtnjZlecHYgJWlm93ZU6D4GG
        /V/jpWBCA40zMH8Q4ec7JPZpVfs/
X-Google-Smtp-Source: AAOMgpcGJn42c3U5dgdfDmv98zC/3YFjTfd4K0CtjBnI1jsMbAN5DQloZYiLzCg55K/rhhnfeLx7Kw==
X-Received: by 2002:a50:cd8e:: with SMTP id p14-v6mr26574317edi.159.1531238057968;
        Tue, 10 Jul 2018 08:54:17 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id g14-v6sm5557625edm.25.2018.07.10.08.54.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:54:16 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id r16-v6so15171691wrt.11;
        Tue, 10 Jul 2018 08:54:16 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr20436662wrb.155.1531238056175;
 Tue, 10 Jul 2018 08:54:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:53:55
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-15-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-15-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:53:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v6442VWvuWnK1JCnxNqwRhp6pS+tVZkaRfs6xjYYxTRwfw@mail.gmail.com>
Message-ID: <CAGb2v6442VWvuWnK1JCnxNqwRhp6pS+tVZkaRfs6xjYYxTRwfw@mail.gmail.com>
Subject: Re: [PATCH 14/17] ARM: dts: sun8i: r40: Add missing TCON-TOP - TCON connections
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
> Current R40 is missing some graph connections between TCON TOP and
> TCONs.
>
> Add them.
>
> Fixes: 05a43a262d03 ("ARM: dts: sun8i: r40: Add HDMI pipeline")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
