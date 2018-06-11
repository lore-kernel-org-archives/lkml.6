Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xcE3AaUQHlvCTQAAmS7hNA
	; Mon, 11 Jun 2018 06:03:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 47B88607A4; Mon, 11 Jun 2018 06:03:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/mJNZNH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9C43C60791;
	Mon, 11 Jun 2018 06:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C43C60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932295AbeFKGDO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:03:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54430 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeFKGDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:03:12 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so12416263wmf.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HcadxBjlA8VuO8oHYdJZPtEhCagymzn/NpDt8l6U0Jo=;
        b=f/mJNZNHXXSeOq7zM58BFJv4cNveLVmq6OdCj8wTuYAPkfbaw7haoWnXv7QSpfKi4M
         9hnpS8o2dykS1QzhotT/pCfjkTmj5q9+QOZbHyVNxwYiYq4Zk2Zg89CYcUd0y4rQqaus
         PAckXqmXGK8+A+8LFXGain7gA1Bvm8RRoUm3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HcadxBjlA8VuO8oHYdJZPtEhCagymzn/NpDt8l6U0Jo=;
        b=KTH70ehip9/WC0Hw3xsTh+b2ZemhU7f8pruCKF7iAaDuN4VQjFAQI/jEVkE6beVN4i
         c82+8lY7GR5mpWRgXFKEvZOltQLPh9ahH4dmswk1w8oGv9Txkpx3dTuJiLZBTlYJevdt
         BGDicC8Z+5GGeXViQpfJsshXu3ePf5QmKdxC4mHJ7lEpWHW9VRnuYxRKBs4Im0R4piDo
         XiOUiTLMn5bCOVK8yiB/J06XCFbAW9T18xmp23PkgpXCjh5QCuqcW4S6EctO+coYqr6B
         cIPM2rWlXK5H1+h3jQl/sG8PkXWUGanxAiyHAUiOVGwXwOOroMABv/yvnLp5AQEY4qop
         KWPA==
X-Gm-Message-State: APt69E1ON1GyJF5KWRFejAnVwEQW/I0wmIxcMcH+XP/8LJ8WS0FcaETQ
        Y0vCJ2kCjo4VmA/BCDcLhp3laA==
X-Google-Smtp-Source: ADUXVKJ7RVBbdm3BU8pmSVV0uhIGKng4uUnPGuWclITfinmsQUsrmwSoJaAlQsm1kS5K1VWYF5XK6g==
X-Received: by 2002:a1c:3682:: with SMTP id y2-v6mr6656323wmh.59.1528696990843;
        Sun, 10 Jun 2018 23:03:10 -0700 (PDT)
Received: from dell ([2.31.163.53])
        by smtp.gmail.com with ESMTPSA id i46-v6sm79421342wra.36.2018.06.10.23.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 23:03:10 -0700 (PDT)
Date: Mon, 11 Jun 2018 07:03:08 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Hans Verkuil <hansverk@cisco.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, airlied@linux.ie,
        hans.verkuil@cisco.com, olof@lixom.net, seanpaul@google.com,
        sadolfsson@google.com, felixe@google.com, bleung@google.com,
        darekm@google.com, marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
Subject: Re: [PATCH v7 0/6] Add ChromeOS EC CEC Support
Message-ID: <20180611060308.GB5278@dell>
References: <1527841154-24832-1-git-send-email-narmstrong@baylibre.com>
 <04598b47-5099-6695-da43-6e7148145cfa@xs4all.nl>
 <55c2c02d-5675-0821-97ec-6a805659b807@baylibre.com>
 <898f025f-9c59-be61-a2b4-5fbbcbc659c2@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <898f025f-9c59-be61-a2b4-5fbbcbc659c2@cisco.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jun 2018, Hans Verkuil wrote:
> On 08/06/18 10:17, Neil Armstrong wrote:
> > On 08/06/2018 09:53, Hans Verkuil wrote:
> >> On 06/01/2018 10:19 AM, Neil Armstrong wrote:
> >>> Hi All,
> >>>
> >>> The new Google "Fizz" Intel-based ChromeOS device is gaining CEC support
> >>> through it's Embedded Controller, to enable the Linux CEC Core to communicate
> >>> with it and get the CEC Physical Address from the correct HDMI Connector, the
> >>> following must be added/changed:
> >>> - Add the CEC sub-device registration in the ChromeOS EC MFD Driver
> >>> - Add the CEC related commands and events definitions into the EC MFD driver
> >>> - Add a way to get a CEC notifier with it's (optional) connector name
> >>> - Add the CEC notifier to the i915 HDMI driver
> >>> - Add the proper ChromeOS EC CEC Driver
> >>>
> >>> The CEC notifier with the connector name is the tricky point, since even on
> >>> Device-Tree platforms, there is no way to distinguish between multiple HDMI
> >>> connectors from the same DRM driver. The solution I implemented is pretty
> >>> simple and only adds an optional connector name to eventually distinguish
> >>> an HDMI connector notifier from another if they share the same device.
> >>
> >> This looks good to me, which brings me to the next question: how to merge
> >> this?
> >>
> >> It touches on three subsystems (media, drm, mfd), so that makes this
> >> tricky.
> >>
> >> I think there are two options: either the whole series goes through the
> >> media tree, or patches 1+2 go through drm and 3-6 through media. If there
> >> is a high chance of conflicts in the mfd code, then it is also an option to
> >> have patches 3-6 go through the mfd subsystem.
> > 
> > I think patches 3-6 should go in the mfd tree, Lee is used to handle this,
> > then I think the rest could go in the media tree.
> > 
> > Lee, do you think it would be possible to have an immutable branch with patches 3-6 ?
> > 
> > Could we have an immutable branch from media tree with patch 1 to be merged in
> > the i915 tree for patch 2 ?
> > 
> > Or patch 1+2 could me merged into the i915 tree and generate an immutable branch
> 
> I think patches 1+2 can just go to the i915 tree. The i915 driver changes often,
> so going through that tree makes sense. The cec-notifier code is unlikely to change,
> and I am fine with that patch going through i915.
> 
> > for media to merge the mfd branch + patch 7 ?
> 
> Patch 7? I only count 6?
> 
> If 1+2 go through drm and 3-6 go through mfd, then media isn't affected at all.
> There is chance of a conflict when this is eventually pushed to mainline for
> the media Kconfig, but that's all.

What are the *build* dependencies within the set?

I'd be happy to send out a pull-request for either all of the patches,
or just the MFD changes once I've had chance to review them.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
