Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E3C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E4D20665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E4D20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeJWAAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:00:49 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:34211 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbeJWAAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:00:48 -0400
Received: from [10.101.224.151] ([185.7.230.214])
        by smtp-cloud9.xs4all.net with ESMTPA
        id EcKjgwuUoSskCEcKngRKVE; Mon, 22 Oct 2018 17:41:45 +0200
Subject: Re: [PATCH v2 0/2] Document memory-to-memory video codec interfaces
To:     Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?UGF3ZcWCIE/Fm2NpYWs=?= <posciak@chromium.org>,
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
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
References: <20181022144901.113852-1-tfiga@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <6621f3b9-a5a0-d33f-306f-d405db34da2c@xs4all.nl>
Date:   Mon, 22 Oct 2018 16:41:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022144901.113852-1-tfiga@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOWJpmC70DmdV61HPzqO1bMfsTX7BtsIQc0LflB+Xv2HFkNAG7K+XkBF/m1H/NzSzvJS+c6YBXkVhzmvfPj2eMCYccrldCgByYkGi4/dsUWPlnVwh6Pn
 7qxx2ibOAli4KpK03yc/ESM3rxxEC31J20WisVUCHdKLbjl5COlJ94/HsR0uFq7Wxe4lSlGCTrZl4p4kxMRRcbkxTXmgU3Be4dTwpC94+jIKOZ87von4YDJj
 NqtMKsuPw0Q8wmvQimu1981jPPYnEjAO4Y0N8gilN8A6K7i97OYsLwaO+HSlCbgb9yVlOH4Jehz+4/r9f83YMJOy53ZiRO4YjTmYGIicgpd/+x6XoBQuK2US
 h2xaa+KtaJovZHduwu8mKe9LJRreOhoKZB7zMA+3qhwav27v0jN3mK94XPea6/EukMLIVgYNrR/rNR5hxaaCKpSznc+uSpH0SSljGG9tUu/cctdvt9DsuDVQ
 VXkAACAMxWlSqHGz6nz+wASvM0ARvuQmru+vE62aqlo0SCf5oAJqkayluuUQhKSEsKGvLUNNHd5BEvsnK/xvWjJKcAnbGwUvQo3YVfYLwdgu8Mkehludiszw
 qovM378BDZj8qjza34ZLi+G9rkA6kdGeRveG7OOwWUN4Aot0nJwD89nNcEfZTh/oTR/SWTKFBmPbkUroL1q/b8gDIzfBVESzZP9UqS0CL7c73hJavOVio4ub
 jgglTxP1fFoCmyTaSDZbLEBP8ssyrf520D8ysKT1LylVatki35Ha++/5jV85FZjDCcGES2qNa/+kkkAXD+UQabyoczvLgrM+uTs2uuKfKMcCfVB0fmSYjQYV
 /KsoYzD0V8euXKos6DctwY2AadsqJhHAFd+zlopkCaaYs+M+AHcBQ3D9HmFFuY3aWtef8SqqHST9JC0E8I4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz, Alexandre,

Thank you for all your work! Much appreciated.

I've applied both the stateful and stateless patches on top of the request_api branch
and made the final result available here:

https://hverkuil.home.xs4all.nl/request-api/

Tomasz, I got two warnings when building the doc tree, the patch below fixes it.

Regards,

	Hans

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>

diff --git a/Documentation/media/uapi/v4l/dev-decoder.rst b/Documentation/media/uapi/v4l/dev-decoder.rst
index 09c7a6621b8e..5522453ac39f 100644
--- a/Documentation/media/uapi/v4l/dev-decoder.rst
+++ b/Documentation/media/uapi/v4l/dev-decoder.rst
@@ -972,11 +972,11 @@ sequence was started.

    .. warning::

-   The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues
-   are streaming. For compatibility reasons, the call to
-   :c:func:`VIDIOC_DECODER_CMD` will not fail even if any of the queues is not
-   streaming, but at the same time it will not initiate the `Drain` sequence
-   and so the steps described below would not be applicable.
+      The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues
+      are streaming. For compatibility reasons, the call to
+      :c:func:`VIDIOC_DECODER_CMD` will not fail even if any of the queues is not
+      streaming, but at the same time it will not initiate the `Drain` sequence
+      and so the steps described below would not be applicable.

 2. Any ``OUTPUT`` buffers queued by the client before the
    :c:func:`VIDIOC_DECODER_CMD` was issued will be processed and decoded as
diff --git a/Documentation/media/uapi/v4l/dev-encoder.rst b/Documentation/media/uapi/v4l/dev-encoder.rst
index 41139e5e48eb..7f49a7149067 100644
--- a/Documentation/media/uapi/v4l/dev-encoder.rst
+++ b/Documentation/media/uapi/v4l/dev-encoder.rst
@@ -448,11 +448,11 @@ sequence was started.

    .. warning::

-   The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues
-   are streaming. For compatibility reasons, the call to
-   :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is not
-   streaming, but at the same time it will not initiate the `Drain` sequence
-   and so the steps described below would not be applicable.
+      The sentence can be only initiated if both ``OUTPUT`` and ``CAPTURE`` queues
+      are streaming. For compatibility reasons, the call to
+      :c:func:`VIDIOC_ENCODER_CMD` will not fail even if any of the queues is not
+      streaming, but at the same time it will not initiate the `Drain` sequence
+      and so the steps described below would not be applicable.

 2. Any ``OUTPUT`` buffers queued by the client before the
    :c:func:`VIDIOC_ENCODER_CMD` was issued will be processed and encoded as
