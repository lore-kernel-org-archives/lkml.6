Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17142223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17142223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbeKNDPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:15:03 -0500
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:55030 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730813AbeKNDPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:15:02 -0500
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id McI1gJHP8SskCMcI5gtRc9; Tue, 13 Nov 2018 18:16:01 +0100
Subject: Re: [PATCH 0/5] media: Allwinner A10 CSI support
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <df54f2e6-e207-92de-767a-e356345a1a56@xs4all.nl>
 <20181113135259.onutfjtoi25afnfe@flea>
 <f07a0460-cdba-c1a5-acfd-66a39f447a5a@cisco.com>
 <20181113155227.62jjs3mpomwgr7xd@flea>
 <cb504ffc-b74c-d6e3-7bde-6c5840c87997@cisco.com>
 <20181113175558.3bfa3e8d@windsurf>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <2d25e395-af73-e69b-dc8a-3d0956d668f9@xs4all.nl>
Date:   Tue, 13 Nov 2018 18:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181113175558.3bfa3e8d@windsurf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGpF76RO1E3RZB48+wbAW1ls45P9GyLpnsGcnMx0s8v099pBinbiaXi2mcT7WrBLpqA3oY8h0mrusD8Sy8tEz4oCA6f5zWB/TYaSyLhNkOGboO3Psq9o
 SBU3zJDxfAVDEcmKXvvVlUxrl6g2ARlJBiWKsXqlJPIVADABFNhSRLjVrWlfD8NvklAN1F70EmBIK2m2nHfAz+mQbmesVcLBIthruxA9bngV37nyVhlvuJdj
 hzhjcSySlhU0lBlNVMH3F4b1z8q5PfLiMI997iU4GBzNVQgczpdumdxVEcEsNCRFDANNhTTb8piPCT6XA9s6NiobXTwFISuEZIGQT8TS6mKvHvb6E3s3f5wW
 7OFDdJHm6UnizpvweHYUgjBmxpv1mNoxLJvs7t7hCILdVSwEeafXEfgrimCbPPB9+QGBh9I3xf32IqFUJKKyw3PLfV7eEG+u95k/DaAbTBjjHsl0CRtFzgzZ
 NChk3X9FIzBV4A2P1t/8ziddB1hK1NbvlCKlnMzAOMooB+jTW21TOOr9ee1QoKzardkDXu3bPCHuTsWt07N4p5KB6GN8QtssEo4/Y9UIzqOrBgextaY2H63H
 eiDQAZYXg0N2nYy1vvM9Yre+J1nhZ6siucztXtQm7Vmd256yzXg49Awzm6Bk5+Fuy/9+F4W/3+4H6T/psX5M2NwjyJGSdQ/wiJMh0WhBW29xkwww4+vWmJ3q
 lF3GGGInomBiGVNM3R42lNfe6xGI0DWi
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2018 05:55 PM, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 13 Nov 2018 17:00:25 +0100, Hans Verkuil wrote:
> 
>> Weird, if I build directly from that tarball, then v4l2-compliance should say:
>>
>> v4l2-compliance SHA: not available, 64 bits
>>
>> So that's what I expect to see from buildroot as well.
> 
> Indeed, that's strange, I see that the v4l2-compliance Makefile does:
> 
> version.h:
>         @if git -C $(srcdir) rev-parse HEAD >/dev/null 2>&1; then \
>                 echo -n "#define SHA " >$@ ; \
>                 git -C $(srcdir) rev-parse HEAD >>$@ ; \
>         else \
>                 touch $@ ; \
>         fi
> 
> which correctly uses $(srcdir), so it shouldn't go "up" the libv4l
> build folder and pick up the latest Buildroot commit SHA1. I'll have a
> quick look.

I think it does, actually. If the tar archive is unpacked inside the
checked-out buildroot git tree, then it will pick up the buildroot SHA.

I fixed v4l-utils to be a bit smarter about this:

https://git.linuxtv.org/v4l-utils.git/patch/?id=98b4c9f276a18535b5691e5f350f59ffbf5a9aa5

Regards,

	Hans
