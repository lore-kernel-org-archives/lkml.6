Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HPIvEDtwGVvtaAAAmS7hNA
	; Thu, 07 Jun 2018 17:49:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 24B71608B8; Thu,  7 Jun 2018 17:49:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="ZfIQV2D2"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 96075606DD;
	Thu,  7 Jun 2018 17:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 96075606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933928AbeFGRto (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:49:44 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38250 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933071AbeFGRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:49:43 -0400
Received: by mail-qk0-f194.google.com with SMTP id y4-v6so7097834qka.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=duQouZSRXkmxXr25ZTDg9oEegzdU2yaYumwuKpagJN8=;
        b=ZfIQV2D2wx76HDYDvb4Gbk/ZYsyenheTFSPGZ7SYfHBnU0bxerkV+7k/6v8a5BSwXz
         rXt0UqfnwcDd52iR5SeveDJ/6saM8dM82CJQ603YVRSAnRFFXEcl3pj4+l1raHWQllJi
         DDZHpVX+hFcSoIOjgng+Y/FM24wLcPELOkKIZN3zf9ViTTE15uGPXPlSBCXsijV/52UT
         lnsIfTKj+dgFcU0IDjl751f9tLeVu/+rOIsYdNzIuRitYvgF9+5eiFUU3d1I1UDldZIs
         OXp1XeBxft1M+tH1uFTxMgnhWaLEbIa9sQTozxIURfOFV/CwwtN+jy6WuMq87uAJHm6n
         ntAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duQouZSRXkmxXr25ZTDg9oEegzdU2yaYumwuKpagJN8=;
        b=IbL1gC0cq2s/UYd+zN/9IzGeRsrlKmYWkvX139guDCJHhKHJ9Ds+5FJ0N+6VJEyqNW
         Dz55VEi41fvvRdS3bgkCL9/awI2nQt2q7z9fPu2X0XaJ+9KzKRtb7t6RIKMAyN8F8O3F
         5IWv6EqSclp0+Mh4626wrzOeUCpaQ39Uwk3dxzM/QMiZp3D5XgMN+M4p10X1vsv4phj9
         qZpQRTgit+Fo5Zdv8KMyi2lqoZBrdn8ZK8lewsoaZZFsBIqOKd60lDEwbNk20/BBev5G
         afLU728KkwaWGSxK+V94XpVPrzwGVFMPc5Tc+u3iSastBH8A0ZkTtSk2SPKXqpkwUXCB
         jNsg==
X-Gm-Message-State: APt69E30l2mhNJ5ZOqIhcGw3yj65zilxT7Q8U+EdlCJSmIl67UYDH0O6
        d0yQZ8DiCM2AuWLi6D+YoL1j+Q==
X-Google-Smtp-Source: ADUXVKISY10aabeUvkLXJZACaVT3t0qnULZCupFc9GpeBjbQ3vl4jTQPCqIv6ig3UzghQUR3RAVh9Q==
X-Received: by 2002:a37:4946:: with SMTP id w67-v6mr2568911qka.394.1528393782385;
        Thu, 07 Jun 2018 10:49:42 -0700 (PDT)
Received: from skullcanyon (cable-192.222.221.38.electronicbox.net. [192.222.221.38])
        by smtp.gmail.com with ESMTPSA id p72-v6sm33114694qkh.5.2018.06.07.10.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 10:49:41 -0700 (PDT)
Message-ID: <d1f991320ad327dc952edd2b3a374bbf36e79efd.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 1/2] media: docs-rst: Add decoder UAPI specification
 to Codec Interfaces
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Tomasz Figa <tfiga@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com,
        Tiffany Lin =?UTF-8?Q?=28=E6=9E=97=E6=85=A7=E7=8F=8A=29?=
        <tiffany.lin@mediatek.com>,
        Andrew-CT Chen =?UTF-8?Q?=28=E9=99=B3=E6=99=BA=E8=BF=AA=29?=
        <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        todor.tomov@linaro.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 07 Jun 2018 13:49:39 -0400
In-Reply-To: <CAAFQd5Bk2VVdPW2C9erQ-vgWDV5ySZH+WeWGyqtrzNug2F1SuQ@mail.gmail.com>
References: <20180605103328.176255-1-tfiga@chromium.org>
         <20180605103328.176255-2-tfiga@chromium.org>
         <1528198888.4074.13.camel@pengutronix.de>
         <CAAFQd5BKdqPWVREeuprWS43kPz7XZR5buiPUZY5UKhaaQCMOBg@mail.gmail.com>
         <1528281896.3438.6.camel@pengutronix.de>
         <CAAFQd5Bk2VVdPW2C9erQ-vgWDV5ySZH+WeWGyqtrzNug2F1SuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 07 juin 2018 à 16:27 +0900, Tomasz Figa a écrit :
> > > I'd say no, but I guess that would mean that the driver never
> > > encounters it, because hardware wouldn't report it.
> > > 
> > > I wonder would happen in such case, though. Obviously decoding of such
> > > stream couldn't continue without support in the driver.
> > 
> > GStreamer supports decoding of variable resolution streams without
> > driver support by just stopping and restarting streaming completely.
> 
> What about userspace that doesn't parse the stream on its own? Do we
> want to impose the requirement of full bitstream parsing even for
> hardware that can just do it itself?

We do it this way in GStreamer because we can and is more reliable with
existing drivers. I do think that the driver driven renegotiation is
superior as it allow a lot more optimization. Full reset is a just the
slowest possible method of renegotiating. It is not visually fantastic
with dynamic streams, like DASH and HLS. Though, we should think of a
way driver can signal that this renegotiation is supported.

Nicolas
