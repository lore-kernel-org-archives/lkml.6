Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B8C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C20A2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C20A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933910AbeGJPXi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:23:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38027 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933359AbeGJPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:23:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id t2-v6so2266515edr.5;
        Tue, 10 Jul 2018 08:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A9F+plU0CTYxEg+okoH6Qfqa5mbYhRTGchTCzIwnp0o=;
        b=SLoa3kpT7cKkn5EQAvC9Pxc6EOLScg8lpn7Ntd+nMhPAZHUFS/1GrwiRJg5peQMRam
         UUuSEMovlWYJyPktRe20zRGbh4KbOnWTi03i3j95lc7CTW54WwZd1OH5iRYRgWIniD0X
         1a3Ns8/cwy1zG0aGdQT5IIRmzgvvlUlx3M2nySKnX+FuwP0ULkfjSpBs3Dvg+Idwqtsa
         dEHdEYP7ITMoKHFEShXBM2q6BmRJ43osP3gqfJSWZ7Pm1CWj6kbpRBlSwY7zR8AqeI+D
         S++PG8tTG21KlyIHQGTdX3CHLcsppQRkpeb6Ku3bYOHRbTiacjwNx+6S4cDz1pY/aL8m
         jMOg==
X-Gm-Message-State: APt69E1xQhByBpwMJ/vPUDUC51USB6wRbASwp3iHzuuSz+Ii3liA9CEm
        Kw6t1EmzF9JAo4MNcWeaBgkKi+9d
X-Google-Smtp-Source: AAOMgpcpZmBaHfQE8yoPRLH7+OHCqByEnyqA1/yLFW0sOGBlYLLHq3UEZwng6U3rVbaRSZwzTjXYfg==
X-Received: by 2002:a50:c28a:: with SMTP id o10-v6mr27837415edf.296.1531236215457;
        Tue, 10 Jul 2018 08:23:35 -0700 (PDT)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com. [74.125.82.54])
        by smtp.gmail.com with ESMTPSA id x21-v6sm6407973eds.78.2018.07.10.08.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:23:35 -0700 (PDT)
Received: by mail-wm0-f54.google.com with SMTP id h20-v6so8869405wmb.4;
        Tue, 10 Jul 2018 08:23:35 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr14737160wmi.16.1531236215015;
 Tue, 10 Jul 2018 08:23:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:23:14
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-5-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-5-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:23:14 +0800
X-Gmail-Original-Message-ID: <CAGb2v644vnkyG=zOLH43Ty7sprMTCnFTeXspgJv_=Z_rNvsg0Q@mail.gmail.com>
Message-ID: <CAGb2v644vnkyG=zOLH43Ty7sprMTCnFTeXspgJv_=Z_rNvsg0Q@mail.gmail.com>
Subject: Re: [PATCH 04/17] drm/sun4i: tcon-top: Cleanup clock handling
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
> There is no need to acquire reference to clock just to get its name.
>
> This commit just cleans up the code. There is no functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
