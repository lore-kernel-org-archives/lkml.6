Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BCCC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8252D213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GWBZuvGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8252D213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJINQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:16:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36688 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbeJINQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:16:27 -0400
Received: by mail-lj1-f195.google.com with SMTP id p89-v6so369253ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FtCNLCR9RVhtQdetaD7QRukgyTk0NIPbgawZ3rF5sy8=;
        b=GWBZuvGjuN/G9roXXzfZVVd3Z+u40QOJwop19V8YvFvf7dTb0l+9Y/666ctYb4sOAr
         CJZ7UEPm7nuz+8lU98JCnKmwxUO5kgw+feI2lGGnFh5y8d5T+JxxIQcn4r2eAOhV44H4
         hcyVSBMm+rm4v+yI1drsMZdc8fhBu0Q6gl9uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FtCNLCR9RVhtQdetaD7QRukgyTk0NIPbgawZ3rF5sy8=;
        b=VBmPxMLTd4CImYGz0UFwt4Pdw27lW1AyMKhNLzQHV4tdqnQLtbGoVpeReVBWDxW+Gi
         nOn7Qkx+aWvf/Hq4Gc0QhKm1l4Ohd5jCG3MCLPxcZ9VJfWJWNsJEIXI3h5ImZkG+uyhX
         v/MqMLVQ1MYnupOSIo4zD8ELVFIB+MOp7Wd1qfTNlOpyCX4ew1bISvE5y5iZvvtbAKL1
         rIWkub70Rd/NY2ep2KjFZa/4eh2fEV+4zor9FE4HhX9gzeCiXQ5oi2Kp8uaj8UmW/d7U
         oRWAOmRoCKSFBUAZDcsgpCIhd7MLnttjAIpBgn+PKtKLi0Cyoyps9J6mxfCNLyaydz1m
         86tg==
X-Gm-Message-State: ABuFfojAshRftv5SaKq4QA0eoh7Ry1gdNFzdZY9Qj8xOQDxD/HHh4hDB
        EJA6g/ZIpvoO5nbVjh282UBHKv+cGmd4GGTS4MfwHQ==
X-Google-Smtp-Source: ACcGV62roCwYpyVxfxK3FMKyDMh/F7kan6KYU9yp8L8UzMIVxKAzLkLq2aNT4LgIbfBh8PtygOmjIoKHTjfG7VBtDSY=
X-Received: by 2002:a2e:8e93:: with SMTP id z19-v6mr17521000ljk.86.1539064870924;
 Mon, 08 Oct 2018 23:01:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:92c8:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 23:01:09 -0700 (PDT)
In-Reply-To: <20181008160029.1bd1f5a8@coco.lan>
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <b2dc51d7-fc92-2e7b-3a07-55a076b95d8b@ideasonboard.com> <20181008140302.2239633f@coco.lan>
 <00b0a8af-b7a5-cb49-0684-0fd0efefa196@xs4all.nl> <20181008152348.7ef6d77e@coco.lan>
 <931ca67d-3ac6-afc1-f933-c9733d561767@xs4all.nl> <20181008160029.1bd1f5a8@coco.lan>
From:   Keiichi Watanabe <keiichiw@chromium.org>
Date:   Tue, 9 Oct 2018 15:01:09 +0900
Message-ID: <CAD90VcY+n_jAWqQ09JBSE==aUxNB7Yc2BNNZRGsP4jd74OW3+g@mail.gmail.com>
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let me back to the topic about interval.
I'd like to send a nex version of this patch to avoid duplication of intervals.

We need to choose two intervals from the three options: 1/20, 2/25 and 1/40.
As Mauro said, we would want to have 2/25 for a fractional rate.
Then, I think adding 2/25 and 1/40 will work well.
If it's okay, I will send an updated version.

Best regards,
Kei

On Tue, Oct 9, 2018 at 4:00 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> Em Mon, 8 Oct 2018 20:31:10 +0200
> Hans Verkuil <hverkuil@xs4all.nl> escreveu:
>
>> > (gdb) list *vivid_fillbuff+0x1e9b
>> > 0x1936b is in vivid_fillbuff (drivers/media/platform/vivid/vivid-kthread-cap.c:495).
>> > 490                                 ms % 1000,
>> > 491                                 buf->vb.sequence,
>> > 492                                 (dev->field_cap == V4L2_FIELD_ALTERNATE) ?
>> > 493                                         (buf->vb.field == V4L2_FIELD_TOP ?
>> > 494                                          " top" : " bottom") : "");
>> > 495                 tpg_gen_text(tpg, basep, line++ * line_height, 16, str);
>> > 496         }
>> > 497         if (dev->osd_mode == 0) {
>> > 498                 snprintf(str, sizeof(str), " %dx%d, input %d ",
>> > 499                                 dev->src_rect.width, dev->src_rect.height, dev->input);
>> >
>>
>> There is a bug with hflip handling in that function. Nothing to do with the
>> resolution. I could reproduce it by just checking the hflip control.
>> I'll investigate.
>
> Ah! Well, as I said, I got it only once last week while trying to use
> vivid for some event racing test. I didn't have time to actually
> seek. On that time, the bug only manifested when I changed the frame
> rate.
>
> Thanks,
> Mauro
