Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xsWsBCVxGVsSawAAmS7hNA
	; Thu, 07 Jun 2018 17:53:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EA88D6074D; Thu,  7 Jun 2018 17:53:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="jRjwOYKH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 75B1260590;
	Thu,  7 Jun 2018 17:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 75B1260590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935136AbeFGRxi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:53:38 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35570 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933639AbeFGRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:53:36 -0400
Received: by mail-qk0-f193.google.com with SMTP id d130-v6so7118129qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LS6PmAi4sloohTRVQpI8M2Tjq0EIscUrLtDbb8awbag=;
        b=jRjwOYKHWlWkttqHwIMKR1JvzqKnebwp3khtUfUCygVrwlWPGm+MpUBV0z3niBg+r1
         IUnu+senQXSMgiSc4mDctAX3750ZfAnioFuiorSBh3bLWL4ruvn7hFUHnA5tkUoHHQjK
         CusdF0UCu5isV+WpJplb4Z3P78curbwjoiD9atX1KI9lO3Qgsw+Omgvo8C6EqjOTg52p
         1LSCvl0R8zaXl3RpeWaEsUtm/hbMwpiI4mhE1OSBPrvanHoe4q0AzGHoDdVEeWSQV81W
         noqJ/zyfXWB7Jw1DPRU8tZ+lxc9hZyDFHZ0KLqvdzoMWKkqS3Zrb8tHLcLh3mOn3/jTY
         kLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LS6PmAi4sloohTRVQpI8M2Tjq0EIscUrLtDbb8awbag=;
        b=ipAkYOVE5r1n71/HigBHKDDivz0M/aTFpbOFB1SLJM5ZnolH4nuIXJVeqsGIjWRF6/
         EdtAkOGPO8vjXjBJLjj86iuHAtHqvWCludwXeWezKJKOwiGqwyIL1fJQJzoz7MuzMdRd
         WOwTgE6rqmMtr2x3rXH/VKebTUi88w8OXaJw6sMSgWx1z5H9q3dJRaXIud31vDud+MRk
         W7/92po/gQxtY5ct17I/FCMD/li+mTA1paFDPbfCFuY5civ1zXsS2uwrZS+uIALwJbgH
         O8ZgcPttTqe8cjHHGiUitPO3CZkuEytlZ3tBffVV3IDeOsvBVrE2sqdvdvFtDGZA+B40
         411g==
X-Gm-Message-State: APt69E2V987U8/Vn6+07mILjfNPEe9uJ99FrDyqW/RVBJ6NBMjWmJTh8
        CQH2BRZ9OqfoN86g0uR0CxLsCA==
X-Google-Smtp-Source: ADUXVKLPHqIPeDICeFeN6xwbQuj8JoBSA6wSYU6elgwHKa96rboAanS8MEsIyZNmwMnNHuxnVOA5Pw==
X-Received: by 2002:a37:3389:: with SMTP id z131-v6mr2436976qkz.309.1528394016077;
        Thu, 07 Jun 2018 10:53:36 -0700 (PDT)
Received: from skullcanyon (cable-192.222.221.38.electronicbox.net. [192.222.221.38])
        by smtp.gmail.com with ESMTPSA id r1-v6sm24558253qke.14.2018.06.07.10.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 10:53:35 -0700 (PDT)
Message-ID: <3c852dec2279fa95af268357a438d442ddb70d44.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 1/2] media: docs-rst: Add decoder UAPI specification
 to Codec Interfaces
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: dave.stevenson@raspberrypi.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?=
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?=
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        todor.tomov@linaro.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 07 Jun 2018 13:53:33 -0400
In-Reply-To: <CAAFQd5BSq+kz0xxrFVFKhA4XFJE1hF8NHomQSGqYzNo+Swdyyw@mail.gmail.com>
References: <20180605103328.176255-1-tfiga@chromium.org>
         <20180605103328.176255-2-tfiga@chromium.org>
         <CAAoAYcOJ5Q2rHqGEmcStxxXj423a3ddKOSzvwRV6R5-UxhM+Hg@mail.gmail.com>
         <b767d9d7-5a26-f6f8-3978-81e8d60769c2@xs4all.nl>
         <CAAFQd5BSq+kz0xxrFVFKhA4XFJE1hF8NHomQSGqYzNo+Swdyyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 07 juin 2018 à 16:30 +0900, Tomasz Figa a écrit :
> > > v4l2-compliance (so probably one for Hans).
> > > testUnlimitedOpens tries opening the device 100 times. On a normal
> > > device this isn't a significant overhead, but when you're allocating
> > > resources on a per instance basis it quickly adds up.
> > > Internally I have state that has a limit of 64 codec instances (either
> > > encode or decode), so either I allocate at start_streaming and fail on
> > > the 65th one, or I fail on open. I generally take the view that
> > > failing early is a good thing.
> > > Opinions? Is 100 instances of an M2M device really sensible?
> > 
> > Resources should not be allocated by the driver until needed (i.e. the
> > queue_setup op is a good place for that).
> > 
> > It is perfectly legal to open a video node just to call QUERYCAP to
> > see what it is, and I don't expect that to allocate any hardware resources.
> > And if I want to open it 100 times, then that should just work.
> > 
> > It is *always* wrong to limit the number of open arbitrarily.
> 
> That's a valid point indeed. Besides the querying use case, userspace
> might just want to pre-open a bigger number of instances, but it
> doesn't mean that they would be streaming all at the same time indeed.

We have used in GStreamer the open() failure to be able to fallback to
software when the instances are exhausted. The pros was it fails really
early, so falling back is easy. If you remove this, it might not fail
before STREAMON. At least in GStreamer, it too late to fallback to
software.  So I don't have better idea then limiting on Open calls.

Nicolas
