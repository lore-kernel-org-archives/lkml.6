Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95023C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DBF206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58DBF206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeIHOvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:51:38 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:33874 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726472AbeIHOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:51:38 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id ya87f1ArYMsEFya8Bf6XuD; Sat, 08 Sep 2018 12:06:23 +0200
Subject: Re: [PATCH 0/2] Follow-up patches for Cedrus v9
To:     Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-sunxi@googlegroups.com,
        Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20180907163347.32312-1-contact@paulk.fr>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <11104c03-97ac-8b36-7d75-dfecb8fcce10@xs4all.nl>
Date:   Sat, 8 Sep 2018 12:06:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180907163347.32312-1-contact@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKXTDPScV/oT8+cYC5SkfopfgRqwdE399XpJT/DywIwz2yRS4vvgNkl4Q7770hOCxUcqwuHY9d/TCForw0KsRGhXMWBEAo86ay2mu3zLNAeQH2iFDnxe
 hhSy29wmEEBiMSfeGK6vdOO1auH5s4VT5mg8J2A2B14jd3YEqToXy/wz8/nJgEeI2oWsnEok0K7OVXZi/zejGwIbN9j+5uh9VlMDJ64DSuKlGGE1DW/JL1OQ
 AB03T6ao5Bo8usQN7lHt5dlk7wDI7mBMaYIYEIskuSGMWdJiGnYZmAodVDVG8L8mA6/r02TfGUfSDu1XTA/ri885KlZakGYulkNQDUH29hNWIfRTNgdCkDl5
 0frXA/C0OhxsmVdWKgUw/dP8rwL1rvo2bY9P1ZIA2dx8/AkS2yKFybkDe9kkVhzH0HPyEH8Ym7rG8qAR01yvfRJq9dJfZ9x+mOq2lLI7k5AcFSsmDOSTav87
 ElaSo+kJlPqsvp04pJ+cokNXep934N3UvYq1boE0epgyiMWJtsBJMbrb7+NzIZS9JaQaD3PS2+FTmK9kjVQmvheW5J3avMET5aXl1oJKj/4jUCUgFxgR+p1l
 sGGSIGv2n7K9g2dFwicgfkqUJqXK493yZohmel6V5D3hSYli83jrrFtoXRkybjHToMuydwzF+P+jrOwJXietWGDgt4lNTRnovKT/qrw9p0FzZRpl0hxb0DfC
 Me7NuIGVisMwl+KHOmmE/Cp7FASBlx4amkdVKQ7KfwiLbB3z8dYqW42QzcaxZh7XIhoAqsnqYBaQF0mAeuOsLq+QrCuiNuT0SRRCkE3HmNZUtuHvge2HfTGD
 zn06I2TkxFYaHqzPEWA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 06:33 PM, Paul Kocialkowski wrote:
> This brings the requested modifications on top of version 9 of the
> Cedrus VPU driver, that implements stateless video decoding using the
> Request API.
> 
> Paul Kocialkowski (2):
>   media: cedrus: Fix error reporting in request validation
>   media: cedrus: Add TODO file with tasks to complete before unstaging
> 
>  drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/staging/media/sunxi/cedrus/TODO
> 

So close...

When compiling under e.g. intel I get errors since it doesn't know about
the sunxi_sram_claim/release function and the PHYS_PFN_OFFSET define.

Is it possible to add stub functions to linux/soc/sunxi/sunxi_sram.h
if CONFIG_SUNXI_SRAM is not defined? That would be the best fix for that.

The use of PHYS_PFN_OFFSET is weird: are you sure this is the right
way? I see that drivers/of/device.c also sets dev->dma_pfn_offset, which
makes me wonder if this information shouldn't come from the device tree.

You are the only driver that uses this define directly, which makes me
suspicious.

Regards,

	Hans
