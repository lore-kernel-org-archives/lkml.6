Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22435C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C868520815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="sQInObVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C868520815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeKRLoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:44:24 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33893 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeKRLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 06:44:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id a132so43621344qkg.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RlQNNoEj6mcLLeXGr5BT1Hf7yTVgK3f5siINVQLdNkc=;
        b=sQInObVBepdJSdnC0sxaMD2/C46x4TK65HER1CUVNfKg3cDOEHYXibgOyl4mHHs8mg
         q6VLYxug04qww8cI78UpwGXjKTzwnZqaKJhBq6Z+BOSF9DO7463EhbIy7Sxkw/A2sFLm
         g/oZAqH8lJzXatuOez2vdEzadQQPtuZoQ8Gn3hPdKL7/ybXuVuv4tRCb7AiFPOFD6fZ+
         NYRXmaoWVlIfDLZVuX+aG8U+qfSkjIISC+pUAIo3xX8zJOC346xwNQsIrQfDJSNjpLYL
         c6w/K+MzVBaXfLYPculr3sWNhqOf2QP8QfuTba8Qkrq7xkLBocmVocGQZ6V6VgPxKea0
         SLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=RlQNNoEj6mcLLeXGr5BT1Hf7yTVgK3f5siINVQLdNkc=;
        b=j1cZISz5iIDQkpolPrqUnjW7msvXWwUQcSI8BL6HDcY6xXff0c/97goEdlGEXqlo7t
         R+BhZwghRswTTpfXT3LCZBJM/64hbAcLjZsegzJqSCYoOhHQEv4/F7oZUjAw0hIuCMyD
         qqmHO3JAFB2mYoQQ1JwGVY9+pxnV2ag67mWlyyK6tCsS844H4ceR9UcDQPxr52noSWKR
         m62jZ6J/Bx2ChnsVKgFqVlfpxTsqU5Bc2bvi1EHc5njTGEej0Rvy7paXnUaJxuis4hFB
         xozjwPHz5IHyPTyqK+vq9jVe1V+MZR3MRcirc1cBUUagNZe2DJxe/6Ksgt06HeasoOUk
         G4nA==
X-Gm-Message-State: AGRZ1gLFO9XtIOGBfJNzZAFRFqaAuI9G60wnqSs19oSmNn4XL8WHv2qO
        j0hFGNcc6M+I/9BPp56Df58w2Q==
X-Google-Smtp-Source: AJdET5d+ItfsBVU3HWnPI9P+QgR0qXtzczm+Zz6BoiQhZaBaXUj1mGMkHnEU7ibf2ISz1vVQ454j3A==
X-Received: by 2002:a37:ac05:: with SMTP id e5mr16014928qkm.102.1542504346978;
        Sat, 17 Nov 2018 17:25:46 -0800 (PST)
Received: from skullcanyon (cable-192.222.193.21.electronicbox.net. [192.222.193.21])
        by smtp.gmail.com with ESMTPSA id 126sm14732741qkj.70.2018.11.17.17.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 17:25:45 -0800 (PST)
Message-ID: <d118bf3edaa6916c3a8138f248661ef5304883d7.camel@ndufresne.ca>
Subject: Re: [PATCH v2 1/2] media: docs-rst: Document memory-to-memory video
 decoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_O=C5=9Bciak?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Sat, 17 Nov 2018 20:25:43 -0500
In-Reply-To: <dd83d36b-c8a1-6f84-a4a2-103607897a64@xs4all.nl>
References: <20181022144901.113852-1-tfiga@chromium.org>
         <20181022144901.113852-2-tfiga@chromium.org>
         <45f6797a-5e9c-e2f9-2606-a5bb81d12f11@xs4all.nl>
         <8620b9ae8ba94bf24788def5775d559c1b5b0666.camel@ndufresne.ca>
         <dd83d36b-c8a1-6f84-a4a2-103607897a64@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 17 novembre 2018 à 12:43 +0100, Hans Verkuil a écrit :
> > > As far as I know all codecs have resolution/metadata in the stream.
> > 
> > Was this comment about what we currently support in V4L2 interface ? In
> 
> Yes, I was talking about all V4L2 codecs.
> 
> > real life, there is CODEC that works only with out-of-band codec data.
> > A well known one is AVC1 (and HVC1). In this mode, the AVC H264 does
> > not have start code, and the headers are not allowed in the bitstream
> > itself. This format is much more efficient to process then AVC Annex B,
> > since you can just read the NAL size and jump over instead of scanning
> > for start code. This is the format used in the very popular ISOMP4
> > container.
> 
> How would such a codec handle resolution changes? Or is that not allowed?

That's a good question. It is of course allowed, but you'd need the
request API if you want to queue this change (i.e. if you want a
resolution change using the events). Meanwhile, one can always  do
CMD_STOP, wait for the decoder to be drained, pass the new codec data,
push frames / restart streaming.

The former is the only mode implemented in GStreamer, so I'll let
Tomasz comment more on his thought how this could work.

One of the main issue with the resolution change mechanism (even
without codec data) is that you have no guaranty that the input buffer
(buffers on V4L2 OUTPUT queue) are large enough to fit a full encoded
frame of the new resolution. So userspace should have some formula to
calculate the required size, and use the CMD_STOP / drain method to be
able to re-allocate these buffers. So the newest resolution change
method, to be implemented correctly require more work (but is all
doable).

Nicolas

