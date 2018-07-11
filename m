Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96E4C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A13208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A13208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeGKIlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:41:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43513 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeGKIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:41:19 -0400
Received: by mail-ed1-f66.google.com with SMTP id u11-v6so18576554eds.10;
        Wed, 11 Jul 2018 01:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=48ucaaWx/CC2z8EG4ldeDD70ZSZL6O6oQOxVgjydS2c=;
        b=CPHEMnVxFC9KzX+M6OfjBBRQp2aZe3ehr7gzvWWGyiChxRh2ThHkEK6IMFMM/hrMrg
         mk2jSFDzoTYlj0VVFYPSPLR/cONAn/k4ekpknKVtZlTmSkiT+te5B+iLl2n3CKH6rFzh
         NkFjyWvWATmOYoMjwNg+H1JuYJXt00y966G+lx5gjM9WCrKryGBmnqJPE75tkurlmZar
         Wlx+GOXGFgTq1TsTEvm0cXFTtcailFZZ+xXLVtKlV4Dm4f24c3ZsCMh0L+dPymq9oLp2
         3xwbGm5HQUwZ5kXooIXyTKwFVcDzM9Zv4R8R+Vp/INZnG5vnTi+ddwa69rGPrHaroIs7
         vXpA==
X-Gm-Message-State: AOUpUlGAXwFFrPFlvRUD/JAv+VAQm9/61/7I56wfDHDpHqK5R/v2l8L7
        ffpHvZEwRy3PJnC2bmLtth7xdXke
X-Google-Smtp-Source: AAOMgpeVT3ZBllMXLOJSy4E2uvipRhSyhH6eKVvZHtZbiylJ1hQ/eaS419Zz9TQEfgUM3eKmeoREwg==
X-Received: by 2002:a50:9b5d:: with SMTP id a29-v6mr1778368edj.167.1531298287668;
        Wed, 11 Jul 2018 01:38:07 -0700 (PDT)
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com. [74.125.82.45])
        by smtp.gmail.com with ESMTPSA id r25-v6sm3676405edb.45.2018.07.11.01.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 01:38:06 -0700 (PDT)
Received: by mail-wm0-f45.google.com with SMTP id i139-v6so1562879wmf.4;
        Wed, 11 Jul 2018 01:38:06 -0700 (PDT)
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr15639274wmi.116.1531298286139;
 Wed, 11 Jul 2018 01:38:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 01:37:45
 -0700 (PDT)
In-Reply-To: <20180711083036.7attjq4hm5ay5gmn@flea>
References: <20180710203511.18454-1-jernej.skrabec@siol.net> <20180711083036.7attjq4hm5ay5gmn@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 16:37:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64wpL11phjM0u05rSSh5QPrxEnoZc6nxmK51EBCGSV3mA@mail.gmail.com>
Message-ID: <CAGb2v64wpL11phjM0u05rSSh5QPrxEnoZc6nxmK51EBCGSV3mA@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Allwinner R40 HDMI refactoring
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
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

On Wed, Jul 11, 2018 at 4:30 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Jul 10, 2018 at 10:34:53PM +0200, Jernej Skrabec wrote:
>> This series fixes several issues found in R40 HDMI patch series after
>> it was applied. Conversation can be found here:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/586011.html
>>
>> Patches are based on latest linux-next (next-20180710) and are ordered
>> in such way that they don't break R40 HDMI at any time. Because of that
>> I suggest that whole series goes through drm-misc to preserve that order.
>>
>> I also tested those patches on H3 to make sure it doesn't break other
>> platforms. However, it would be nice to test for regressions also on
>> older SoCs (with DE1).
>>
>> Best regards,
>> Jernej
>
> Applied all patches but the patch 10, thanks!

Patch 4 actually has an error. Hope you haven't pushed it out yet.

ChenYu
