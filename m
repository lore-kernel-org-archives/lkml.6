Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC33C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C2620815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="KrqGIiI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C2620815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbeKRLwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:52:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38293 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeKRLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 06:52:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id d19so43575244qkg.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OUuuLVKQmpzTRzbDcGUkrYelcoT1vhEiVcG0jYik4hI=;
        b=KrqGIiI6p1tXZa6hYaFyAQOohtHENWbzzXo3jUQZtFAvcKTAiqFZ4dYP+4ncrW9OA8
         +AYsMCDtOcHTYsl4kPp6k57YRnqpLaAlYX+OuZb7zkhrOVBMYMew45/7WfWUwCPoljNL
         qxsOooGwONEE/MPe5fC7LNQRBc+SOyVoqBq7Kj2yQw93sq8l1yAUZEwbqUF1UCVAIUR+
         SKJ+rrDt/s2WRKPhV8OUau1TCwt21oSVD4VU9tnIx5DCSuv/IGU3CNmcNFTWiTG0HEQK
         Ad0rGl4AdGDWYuoeNUVVb+Y3xmfrXij/WfqcqtohH0qLZZDtFnrJyycD7jLSsJunmhSK
         vAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OUuuLVKQmpzTRzbDcGUkrYelcoT1vhEiVcG0jYik4hI=;
        b=jrKm3ySgQimJSfJKUR5cyNhRfsmgIFe333PKjrPmxTPINa7wGzXy4QVq3ezIqS0Mi1
         pJvTwFKJzDs2lYmjfd0nH8tYBucdetZ3mI6S69EWNyEKhQpri1FZhPNXLvWX41oAOEGp
         4Ez6nMoOVz/Vn6zuUjy4ooLor2KsTrfpExR/15KDOHuAxV4T5tQ8fp1o1U3COu9FEqg9
         UGmZMUDAWBlNBmfOk8N5Tq1SMk4/M4F5KgMSH9F7GnJIclDRjrb3wbye2+HHl/kxc0F5
         j8CEXLBNiNeUH7l53L/rg4lb/f3YuzU8I/fHoxtTwDzMoaku5svtAOgChz4OSJligpqh
         1E3Q==
X-Gm-Message-State: AGRZ1gI45CODq1QuSWBdwzCTCsa5sl6YctGlVA1ps7vURY6tsEXQDYqt
        vBabtCyVSNqxvjXfxCJfTpunWQ==
X-Google-Smtp-Source: AJdET5cinZ2lBjQs1HinwJYRTkUJYt+hHeqVF7VAHrd3nrutp5J+zcu+X6rkX1Cz2stl+QqB5y9jIQ==
X-Received: by 2002:aed:3ff0:: with SMTP id w45mr15667187qth.214.1542504851129;
        Sat, 17 Nov 2018 17:34:11 -0800 (PST)
Received: from skullcanyon (cable-192.222.193.21.electronicbox.net. [192.222.193.21])
        by smtp.gmail.com with ESMTPSA id r142sm15606468qke.27.2018.11.17.17.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 17:34:10 -0800 (PST)
Message-ID: <dae0211b3bc01423f1e9de63e9b4ef0aee44c086.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
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
Date:   Sat, 17 Nov 2018 20:34:08 -0500
In-Reply-To: <d853eb91-c05d-fb10-f154-bc24e4ebb89d@xs4all.nl>
References: <20181022144901.113852-1-tfiga@chromium.org>
         <20181022144901.113852-3-tfiga@chromium.org>
         <4cd223f0-b09c-da07-f26c-3b3f7a8868d7@xs4all.nl>
         <5fb0f2db44ba7aa3788b61f2aa9a30d4f4984de5.camel@ndufresne.ca>
         <d853eb91-c05d-fb10-f154-bc24e4ebb89d@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 17 novembre 2018 à 12:37 +0100, Hans Verkuil a écrit :
> > > Does V4L2_CID_MIN_BUFFERS_FOR_CAPTURE make any sense for encoders?
> > 
> > We do account for it in GStreamer (the capture/output handling is
> > generic), but I don't know if it's being used anywhere. 
> 
> Do you use this value directly for REQBUFS, or do you use it as the minimum
> value but in practice use more buffers?

We add more buffers to that value. We assume this value is what will be
held by the driver, hence without adding some buffers, the driver would
go idle as soon as one is dequeued. We also need to allocate for the
importing driver.

In general, if we have a pipeline with Driver A sending to Driver B,
both driver will require a certain amount of buffers to operate. E.g.
with DRM display, the driver will hold on 1 buffer (the scannout
buffer).

In GStreamer, it's implemented generically, so we do:

  MIN_BUFFERS_FOR + remote_min + 1

If only MIN_BUFFERS_FOR was allocated, ignoring remote driver
requirement, the streaming will likely get stuck.

regards,
Nicolas

