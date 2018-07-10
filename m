Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A662C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5494208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5494208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933922AbeGJPU4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:20:56 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35443 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:20:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id b10-v6so16853044edi.2;
        Tue, 10 Jul 2018 08:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3ltJVsbi2p7MW8rNDQJQzZGWJq3wfo0PBEGRDv+RRno=;
        b=DOs7iwf9yYsmjRYa1BeGh2EAEIiaauh3lhnIMgZdZCROMz4Vtn8pkCqQlCj0Q39Rz9
         8UTZrav8QdPc8BMJF9a2Grtjzz7SJF0gpl1jwobiPDPxBLbLPFjCPVoOnTcizuLKDiUw
         esxbDgw7n5kD77gljD7aMEuZrQxsQna1Kkg+5trGl2bxMsYJ0n9u4gHhrZpT/EFleQoX
         GQYAiZBdZEcn4iN1Okx5q9aLvMm3clwzUygQ9oM3jspBrcSUpn8iXd3ocnQjuBGhKCSv
         vHxrEGACRqKXbSjnjvYRcxolaxSb1UFqeHTJZlQxrvB8IQeuBqCNP5yo6uq5U0jLEhE/
         csJA==
X-Gm-Message-State: APt69E3ihnRfqn4bwQVgj/gfEejElXoyzcm4drK3EmgrzghDvLoGN9ep
        F3L6uVoDhEBxmDwau+iORZbSJb67
X-Google-Smtp-Source: AAOMgpe3IziKPTXM7NLXgzkHSOBYs3eLkpiM5n8IGn0LngDH5g8QAF0m6AdYKVzx1GVytPGlSUxcbw==
X-Received: by 2002:a50:9fe9:: with SMTP id c96-v6mr7443421edf.17.1531236052842;
        Tue, 10 Jul 2018 08:20:52 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id u3-v6sm2049414edo.44.2018.07.10.08.20.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:20:52 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id r16-v6so15056284wrt.11;
        Tue, 10 Jul 2018 08:20:51 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr20338724wrb.155.1531236051311;
 Tue, 10 Jul 2018 08:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:20:30
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-2-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-2-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:20:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v6556Gqs0H+L7W1oiyevep8aTwMWJs8ipBOcX+-=BdNYfA@mail.gmail.com>
Message-ID: <CAGb2v6556Gqs0H+L7W1oiyevep8aTwMWJs8ipBOcX+-=BdNYfA@mail.gmail.com>
Subject: Re: [PATCH 01/17] dt-bindings: display: sun4i-drm: Add R40 display
 engine compatible
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

On Sat, Jul 7, 2018 at 1:50 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 has pretty unique display pipeline. It supports two outputs at the
> same time.
>
> Possible outputs:
> - 1x HDMI,
> - 2x TV output
> - 1x VGA,
> - 1x MIPI DSI and
> - 2x LCD outputs
>
> That is the biggest number of possible outputs from all Allwinner SoC.
> Because of that, add new compatible for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
