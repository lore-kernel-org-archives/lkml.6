Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1066C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC99820879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmjxWxCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAVE7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:59:30 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:43547 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAVE7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:59:30 -0500
Received: by mail-lf1-f53.google.com with SMTP id u18so17062902lff.10;
        Mon, 21 Jan 2019 20:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=F31limMsuwrp6mOZxOkyAi4BJ2AflVhGZN9LOI1twic=;
        b=WmjxWxCip5KEn4ReV6j65ZIrGSEp4NBWetHBKmkuozOs2KJ2kqQy4/fiGS9TtvyNVn
         c+NH+O1cco3Sg0cTQuuyKluaOlliAePx1Y6Wuh/Gl+cjNIHzqu8lxgSYhlK3VRXlP4o3
         KnmUoQyn7+f64ixEOXb0AYVo8n6Pl0BtakpMzSAo1Oe6SjYZLa1l763V15a+1Q1FbUbn
         g9742S8ID4kOZXizIhXIg1a6Dr5GWZLJE06/Y3FQuuxTy/Zi4U4PSRVRwrCtR5DsH1Wr
         TN+78eSh1jP0WbczEa/IM6Yvz4YRtnIH6/RZnMqN/O9GZC4YZiVeElWTMDJfnGZEePPY
         KGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=F31limMsuwrp6mOZxOkyAi4BJ2AflVhGZN9LOI1twic=;
        b=K8c7yw2kWojzwzuWIO+gRPIdhV9U05IfRVdnd4psW73VTOKy+MW9iQciXZBh5r/o+h
         ag6K6NemuNu08aEPzCkfTFgWwuBnWdyfV8Q++ZIds+b1aj5XbNu7tR+hoLqk1kL7c47C
         tS/5GYVP5vRQztt9sjM9jno7D+V+eA+KU3hwA3+cZuuTNi1/56JzDo+fYCeq6yO2iUXw
         WZxaWDY4EHO1M55Qjss2L4AGPbzkgbz65JM81Jn2JBKlMZdP8uMWaQdAGAX1jHl92/23
         30ROOJWnXqF9DMhd6OkhnE0VlXs6EPUb6/oN2PXxqMKcAu2jCuUNRaPVZV6YdRmSGt35
         cT5A==
X-Gm-Message-State: AJcUukeCp3xoyHZDkY0vMFhwkj3TaAX9pl9eSapfmasghuGtGgU8qhcl
        kcHXFu/J6ewiK6jGfrPfPO4=
X-Google-Smtp-Source: ALg8bN7m1NlhLSJvW3X6dmJ7nmnumDbjhF7NV9VIRLNA48bm43u9Yj9VgAyQDu2UFNL7zJSdeuHFfA==
X-Received: by 2002:a19:4402:: with SMTP id r2mr18996907lfa.111.1548133167625;
        Mon, 21 Jan 2019 20:59:27 -0800 (PST)
Received: from supervisor.net28 ([178.121.95.126])
        by smtp.gmail.com with ESMTPSA id f8sm2642168lfb.2.2019.01.21.20.59.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 20:59:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Fabio Estevam" <festevam@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>
Cc:     bcousson@baylibre.com, "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>, linux-omap@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: n900: fix mmc1 card detect gpio polarity
References: <20190121032109.10220-1-spinal.by@gmail.com>
 <CAOMZO5DDM5=ZL8_-JZpX23ChoKhuBY7-bNaTE7JjDW0jwsHb4A@mail.gmail.com>
 <20190121200030.GJ5544@atomide.com>
Date:   Tue, 22 Jan 2019 07:59:24 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.zvz5hat5hxa7s4@supervisor.net28>
In-Reply-To: <20190121200030.GJ5544@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Arthur Demchenkov <spinal.by@gmail.com>
