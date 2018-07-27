Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FD9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2C6208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2C6208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbeG0PX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:23:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38196 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbeG0PX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:23:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so4008406edr.5;
        Fri, 27 Jul 2018 07:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0eOBvJVIpx0K2eLRk2AWHhmh3Q//6wL6P7i0Ljfjduk=;
        b=d8PkdvNtk3TkhmsLlFRlCtIXjoCFgkxljrQ1F4dYMhKsXrUVCp6yk6v6cih4u4ffiB
         WF8uyiGognEcV9/nOTcaJAFqPHySqVZ8n95CIMMh49+rdf/mHeY0799nwr2teAsGv3Yo
         Tk5+ROIg8ej5InU9qKSjEo0k94jrtCNgeUEDqz1PXn7X2cuBBmxKgrjJ1Of5MqebY7nP
         NZWw7ljrJLBMvflIuCFmol+5Nd5oCtvkSUT951wNS3rEtweKHb020ZzrzipT4f+dWu0v
         u37K2HmIoEp5qqS+4ArmItoTOMCqLnnfYdkwpuUJwpaJyrtiymKunE/XModuHxfSoNG+
         Vicw==
X-Gm-Message-State: AOUpUlGIDwXacIEog3xyVLqy0xgqiBqZxKip4jUtNSHj4/m6Jks77DM/
        kUS7MlichagYLOINe+Vf7ivodUh1jtY=
X-Google-Smtp-Source: AAOMgpdpqOGI3kvw0pF9LUixqAfU0agbbQcZCw6kHBQ1XeiojF8MJlH1LSm5DbghmLZLHzjik2NzPA==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr7644503edp.7.1532700109953;
        Fri, 27 Jul 2018 07:01:49 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id h1-v6sm1936922eds.69.2018.07.27.07.01.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:01:49 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id j5-v6so5170415wrr.8;
        Fri, 27 Jul 2018 07:01:49 -0700 (PDT)
X-Received: by 2002:adf:e90c:: with SMTP id f12-v6mr4873850wrm.126.1532700109100;
 Fri, 27 Jul 2018 07:01:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 07:01:28
 -0700 (PDT)
In-Reply-To: <8c0b2fbec0302a15292d3629570ab1268fd306b8.camel@bootlin.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-10-maxime.ripard@bootlin.com> <8c0b2fbec0302a15292d3629570ab1268fd306b8.camel@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 27 Jul 2018 22:01:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v67k_bwATPiaRVifR0gnAaG56VztpW9WifOExQbLqm2Csg@mail.gmail.com>
Message-ID: <CAGb2v67k_bwATPiaRVifR0gnAaG56VztpW9WifOExQbLqm2Csg@mail.gmail.com>
Subject: Re: [PATCH 9/9] media: cedrus: Add H264 decoding support
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Pawel Osciak <posciak@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        nicolas.dufresne@collabora.com, Jens Kuske <jenskuske@gmail.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 9:56 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Hi,
>
> On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
>> Introduce some basic H264 decoding support in cedrus. So far, only the
>> baseline profile videos have been tested, and some more advanced features
>> used in higher profiles are not even implemented.
>
> Here are two specific comments about things I noticed when going through
> the h264 code.
>
> [...]
>
>> @@ -88,12 +101,37 @@ struct sunxi_cedrus_ctx {
>>       struct work_struct run_work;
>>       struct list_head src_list;
>>       struct list_head dst_list;
>> +
>> +     union {
>> +             struct {
>> +                     void            *mv_col_buf;
>> +                     dma_addr_t      mv_col_buf_dma;
>> +                     ssize_t         mv_col_buf_size;
>> +                     void            *neighbor_info_buf;
>> +                     dma_addr_t      neighbor_info_buf_dma;
>
> Should be "neighbour" instead of "neighbor" and the same applies to most
> variables related to this, as well as the register description.

This just means you've been hanging out with people who use American
English. :)

ChenYu
