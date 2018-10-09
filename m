Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15DAC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9B1213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9B1213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJINtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:49:24 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:60493 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbeJINtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:49:23 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 9lafgWJsxSskC9laiglPj6; Tue, 09 Oct 2018 08:34:01 +0200
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <b2dc51d7-fc92-2e7b-3a07-55a076b95d8b@ideasonboard.com>
 <20181008140302.2239633f@coco.lan>
 <00b0a8af-b7a5-cb49-0684-0fd0efefa196@xs4all.nl>
 <20181008152348.7ef6d77e@coco.lan>
 <931ca67d-3ac6-afc1-f933-c9733d561767@xs4all.nl>
 <20181008160029.1bd1f5a8@coco.lan>
 <CAD90VcY+n_jAWqQ09JBSE==aUxNB7Yc2BNNZRGsP4jd74OW3+g@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <609798e1-ab23-75d8-ddc2-40fe55cb85d3@xs4all.nl>
Date:   Tue, 9 Oct 2018 08:33:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAD90VcY+n_jAWqQ09JBSE==aUxNB7Yc2BNNZRGsP4jd74OW3+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHIvX00Rs3NmTaxNLgo+Mr+F+0Btc44mvpFREO6AZMGqGFlruIZxSodfVBEISv1b59PfOy0H/ElfSAIlU7qR7ZDnjtp+Xj1kGMOx2o2vqD/NgLsAMH+G
 XaEbG6Uf8MtR3UcvVgV8ihQTyRzVaWYDJrxx06DIITjEjjguZp2mZ7niLKttDNDaJ+ruEyPVqknfx8X4MkLM5Ub7zPQUulWJODX2sTC9kdu1YvsI68g1pnNv
 IRUObzQk4oueLiP98NTD01Ip7CO3+Z/+p6d2Zc+2V2Cjg+QiixDzUMZCR5hK8YJsX8QIsQckfTXmq6k0zpVyqtuvs9gvGq7kCWcz6AYrU+Zk6xSsRsvEYG0J
 Hso22uXL+++jTYLq6hk84tHRsIpGqPlImRidZqB+RcXnG+3h8cRaYYVNwE19A8S4mGp643OiVTBpnU6kVW8VMoCSZzbx1XOLG/YbtOEOQq4POfeUvu8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2018 08:01 AM, Keiichi Watanabe wrote:
> Let me back to the topic about interval.
> I'd like to send a nex version of this patch to avoid duplication of intervals.
> 
> We need to choose two intervals from the three options: 1/20, 2/25 and 1/40.
> As Mauro said, we would want to have 2/25 for a fractional rate.
> Then, I think adding 2/25 and 1/40 will work well.
> If it's okay, I will send an updated version.

Fine by me!

	Hans

> 
> Best regards,
> Kei
> 
> On Tue, Oct 9, 2018 at 4:00 AM, Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
>> Em Mon, 8 Oct 2018 20:31:10 +0200
>> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
>>
>>>> (gdb) list *vivid_fillbuff+0x1e9b
>>>> 0x1936b is in vivid_fillbuff (drivers/media/platform/vivid/vivid-kthread-cap.c:495).
>>>> 490                                 ms % 1000,
>>>> 491                                 buf->vb.sequence,
>>>> 492                                 (dev->field_cap == V4L2_FIELD_ALTERNATE) ?
>>>> 493                                         (buf->vb.field == V4L2_FIELD_TOP ?
>>>> 494                                          " top" : " bottom") : "");
>>>> 495                 tpg_gen_text(tpg, basep, line++ * line_height, 16, str);
>>>> 496         }
>>>> 497         if (dev->osd_mode == 0) {
>>>> 498                 snprintf(str, sizeof(str), " %dx%d, input %d ",
>>>> 499                                 dev->src_rect.width, dev->src_rect.height, dev->input);
>>>>
>>>
>>> There is a bug with hflip handling in that function. Nothing to do with the
>>> resolution. I could reproduce it by just checking the hflip control.
>>> I'll investigate.
>>
>> Ah! Well, as I said, I got it only once last week while trying to use
>> vivid for some event racing test. I didn't have time to actually
>> seek. On that time, the bug only manifested when I changed the frame
>> rate.
>>
>> Thanks,
>> Mauro

