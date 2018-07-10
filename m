Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6795C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2933208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2933208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934307AbeGJPuP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:50:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46712 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeGJPuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:50:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id r17-v6so16931027edo.13;
        Tue, 10 Jul 2018 08:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aYa0PFt8DqcBporqUUzFJFBCR++uNyDpX43KSkICBF0=;
        b=rLCrPQZVAxwV69KxBcKHyUA8COpb0Cj+g7PfKIiGx52MKCxjqBfvJfs2XZ9l9XRaeB
         v5vyVRr8SpZj5d/KYXJOBM/WpNZNKRhAVcvuNl3KMfi4G4xTS/29vayctwYGMDw9Sdvv
         KhnG5C2R+hK5FZCUXjX/6AXAAPaCWaDWhGUW598FacXqvbPctQ4JpIjC7720eokxQ7Ku
         py57JDkf/tQHuQsHf8jVv598fySFa3LrG9SNM9ua8ZAI/agBJ5w3CiwD0ZMz3whgQkhW
         1EneywqsjUqM3VfZckObtuNoAtCzHCLIbDPdvmF6vWTAZUysUv5fnqk27MatZxrlZwDO
         5YEw==
X-Gm-Message-State: APt69E2PUQPSdlk29LAwDDJLpGvkq+8cRwqKnLZ2Gvn73zh5ra24+61n
        1k9RpqCCMm6kOjgtccBI7G8q7z0i
X-Google-Smtp-Source: AAOMgpeUPiKVNfqwCEjPAjTHQ6pQdTXkSjR61c0RHR2NZXKajykj8Gz9EaB3njsF9go+rzpqsZVuow==
X-Received: by 2002:aa7:d6c6:: with SMTP id x6-v6mr27911360edr.148.1531237812926;
        Tue, 10 Jul 2018 08:50:12 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id c6-v6sm8222088edt.41.2018.07.10.08.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:50:11 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id h9-v6so15158510wro.3;
        Tue, 10 Jul 2018 08:50:10 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr20425414wrb.155.1531237810709;
 Tue, 10 Jul 2018 08:50:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:49:50
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-14-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-14-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:49:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v64E-mzbf0gL91=51ZfTrb=+8QwNr1SXMi8Vj547jC4t9w@mail.gmail.com>
Message-ID: <CAGb2v64E-mzbf0gL91=51ZfTrb=+8QwNr1SXMi8Vj547jC4t9w@mail.gmail.com>
Subject: Re: [PATCH 13/17] ARM: dts: sun8i: r40: Remove fallback compatible
 for TCON TV
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
> While registers between A83T and R40 TV TCON are the same, R40 TCON TV
> driver has to set additional muxes in TCON TOP. Because of that, remove
> fallback A83T TCON TV compatible.

Nit: device tree doesn't care about the implementation. You can however
mention that hardware interaction makes it not so compatible. :)

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
