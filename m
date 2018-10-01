Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B579DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC4C2064A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC4C2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeJARHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:05 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:33546 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728913AbeJARHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:05 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 6vSbg5njMw2L86vSegYh3D; Mon, 01 Oct 2018 12:29:57 +0200
Subject: Re: [PATCH v3 0/3] Add Amlogic video decoder driver
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20180928142816.4311-1-mjourdan@baylibre.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <cfb89cf9-4fce-7fab-48e1-a0311b80d993@xs4all.nl>
Date:   Mon, 1 Oct 2018 12:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180928142816.4311-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKPxlZ47TzekGJHu685g+KpGTMAzsDiod4R9Ixs0N1PM1oOiwsI97BCtsG88OhOnf8jcsvREJzd7jxQ0FXkBmG85VSeB6C4rzcq1iL7sQZicNQ+cWdPd
 0m+mC/C2V0WFJ9WtS/kFSaKYRARpYr9hcdrnIxL1iBSaHEhCnepc/upGdMAywCryKt1VZeRBJKlOXXI9KvRC8os1AsXBI2TeNInyjr4YNXzj5HewPC76Xcmq
 91BPaZoVrk09GZKFy+pv7nokETu2RRGi/o/NuFXZPioumKfsJE3YWaCnJLmqXwqjN5Bg53BUI4GN2wfKrMzjM+QnUQ38HdPnmIwYlvSdZvFEY0Tozc1C1gT5
 332tsZqCqs6PLgOWaoz2SWwneHNSZWqzKJKKPEOJN8FgVG6btPk3uajSGCto9abFZ/tR6LuxpLYE4XVGubGGklZQ9sfHaF6oZkYZQEqNjrHklZDMp2j3XUHb
 z2yRrngnrmfBLEjPZBGhB2aOMZ58H/3igHVrdZ+y8tzqr/w7tCrhVqLsgErKQ/YQhnpJ1uKc95keBY6tCfWGHlP5qexYxAC6KuoeCVm4iBr4f/qp/7L702dM
 MxCbJLwTwSFQ4ln0S84aVZMY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 04:28 PM, Maxime Jourdan wrote:
> Hi everyone,
> 
> This patch series adds support for the Amlogic video decoder,
> as well as the corresponding dt bindings for GXBB/GXL/GXM chips.
> 
> It features decoding for the following formats:
> - MPEG 1
> - MPEG 2
> 
> The following formats will be added in future patches:
> - MJPEG
> - MPEG 4 (incl. Xvid, H.263)
> - H.264
> - HEVC (incl. 10-bit)
> 
> The following formats' development has still not started, but they are
> supported by the hardware:
> - VC1
> - VP9
> 
> The code was made in such a way to allow easy inclusion of those formats
> in the future.
> 
> The decoder is single instance.
> 
> Files:
>  - vdec.c handles the V4L2 M2M logic
>  - esparser.c manages the hardware bitstream parser
>  - vdec_helpers.c provides helpers to DONE the dst buffers as well as
>  various common code used by the codecs
>  - vdec_1.c manages the VDEC_1 block of the vdec IP
>  - codec_mpeg12.c enables decoding for MPEG 1/2.
>  - vdec_platform.c links codec units with vdec units
>  (e.g vdec_1 with codec_mpeg12) and lists all the available
>  src/dst formats and requirements (max width/height, etc.),
>  per compatible chip.
> 
> Firmwares are necessary to run the vdec. They can currently be found at:
> https://github.com/chewitt/meson-firmware

Are you trying to get this into the linux-firmware repository?

I believe that Mauro requires that before he will merge this driver.

So I think this driver will be ready to be merged once v4 is posted,
dt-bindings is Acked and the firmware is merged to the linux-firmware repo.

Regards,

	Hans
