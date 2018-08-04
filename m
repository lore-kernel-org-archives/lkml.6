Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88152C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49943217CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 12:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49943217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeHDOoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 10:44:32 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:44006 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726744AbeHDOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 10:44:31 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id lvuOfCz5A6brUlvuSfFLs6; Sat, 04 Aug 2018 14:43:53 +0200
Subject: Re: [PATCH v6 0/8] Cedrus driver for the Allwinner Video Engine,
 using media requests
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4e8a0286-7e49-5622-1895-ac3268224152@xs4all.nl>
Date:   Sat, 4 Aug 2018 14:43:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFzPnAa1QZX/9m5xmsvcyD0giK4Z9S47S2BA/Q58q2cfLtjzU2QzjCraeViylQAAhYn0QYSa+u8LE2SxFHa5QN3gak9kfAAUZaxy6VVkAe9mVE0SD0QW
 +hSdFRuiDFUxYSMRQldGfw6BwaRRZB4cicvaIbsYuF/B+0igmfIFf9PcetjybQjVc6aISKG7XZi7VqTSoVuMzwWEE0Y603zFcM6Byu8CfLB7RsOYEUj0haxw
 j24bhGY9rFLlz44KpdLZRVwabruYgyaK1HkB/paIhY5qCTsYSfou8axxObY1d1cdl1XJORtK8uwBvXBJK+0TFcuho45tl19LaScaPD/kd4fumJMMFUJaeJR3
 xRjm8BHvU0ui8m0AHKwuhMrnH+wwByiGDtbkJvOUUDTV1oJoyowPbBI3BAxqle20cyEP5nkicT402sRiksCA06RiqoOEXF2a2/Eeb5cIU/vchxwEm7kG2ohk
 L+ybuvG0JewB+r5dd3tUtTlc5HPnnl4uAdUToa7B1XkfCqi6e1X9TsH6ZNmw0V8KhpQHXsXe6PzF1OZCOxsSZCOELW3v7ENu+AcQdL1SpCdXsBDR/wIXoqzF
 JFWLoB3jSuTaAMwQflv/uLqxDN0b7GTNTzra7ONGZy+hyKZ9NXpraU/DEQ+OeUkpSTGtNGVv7zRXPP+F4OtUviVQ6VX8ASkofatg4tF1mOExS2J/uAn9hUjQ
 gBsDT2SCqste1Z3QY8GwdZpgy+d/nnL+UCgdQZJmPbFfLB+46ZrirjDsPgHQL/O/BtYh6n2kXDxx0N8X6QaQRFII10gIKG1/OclEp5tWAfyERv3yqGlZmMAA
 VOkHCP3h1/p25w1UzHwn0T7Kw5+qJnZ99sRw7dbWg5QmQACcIIZfow7ZYS5lshuLwtfOmcbIAXo4Olueed7IxUg5BxCH6LQCrzBggKpHPXOGQLmkvimCkHqa
 coh9b/1CAq8NhfKd5LY82albQW1v/B1IouQOlmlhMXFa2+E3ipnwGpEoLAnJ/6zAk8w9lnhPMLXk3dzL0ZqF9pWEkgFIj7MNEIsO0bzV4BZj4exjYhsaP4jW
 AVCknMONXWJdE84i7KB9GOKD8qCDkI2upEY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/25/2018 12:02 PM, Paul Kocialkowski wrote:
> This is the sixth iteration of the updated Cedrus driver,
> that supports the Video Engine found in most Allwinner SoCs, starting
> with the A10. It was tested on the A13, A20, A33 and H3.
> 
> The initial version of this driver[0] was originally written and
> submitted by Florent Revest using a previous version of the request API
> that is necessary to provide coherency between controls and the buffers
> they apply to.
> 
> The driver was adapted to use the latest version of the media request
> API[1], as submitted by Hand Verkuil. Media request API support is a
> hard requirement for the Cedrus driver.
> 
> The driver itself currently only supports MPEG2 and more codecs will be
> added to the driver eventually. The output frames provided by the
> Video Engine are in a multi-planar 32x32-tiled YUV format, with a plane
> for luminance (Y) and a plane for chrominance (UV). A specific format is
> introduced in the V4L2 API to describe it.
> 
> This implementation is based on the significant work that was conducted
> by various members of the linux-sunxi community for understanding and
> documenting the Video Engine's innards.
> 
> In addition to the media requests API, the following series are required
> for Cedrus:
> * vicodec: the Virtual Codec driver

This will appear in for 4.19.

> * allwinner: a64: add SRAM controller / system control
> * SRAM patches from the Cedrus VPU driver series version 5

What about these? Are they queued up for 4.19 as well?

I'll post a rebased reqv17 later today that includes the
"add v4l2_ctrl_request_hdl_find/put/ctrl_find functions" patch.

Regards,

	Hans
