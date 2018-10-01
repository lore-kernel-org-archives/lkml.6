Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AB5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DD02084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DD02084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbeJASrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:47:05 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:47097 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728999AbeJASrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:47:04 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 6x0ygwoON2xRe6x11gSfqR; Mon, 01 Oct 2018 14:09:33 +0200
Subject: Re: [PATCH v3 2/3] media: meson: add v4l2 m2m video decoder driver
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20180928142816.4311-1-mjourdan@baylibre.com>
 <20180928142816.4311-3-mjourdan@baylibre.com>
 <6fb97945-e63a-b98b-bf07-0a5088ac7232@xs4all.nl>
 <CAMO6naxoXMsb=SEH8mu=7YBhFW_-6YzvR0K3mMaHD1rZ-_UJxg@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <10d8641a-f605-5693-676c-02ca023259da@xs4all.nl>
Date:   Mon, 1 Oct 2018 14:09:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMO6naxoXMsb=SEH8mu=7YBhFW_-6YzvR0K3mMaHD1rZ-_UJxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfLQ2gPHHL1XYgPRStsz2hs2VF6jhtq+xIibME2MIcIBl5Pgc0vyUu27jYf/byD4OEDDmCJTpBzMwH8ADW8D4UsqQbdSqDsEZFD2R3Om8wuH1hUkRJS3X
 dDXxFuF4/11J6LSeZz9AWV2k7wx/pA2TKmjkJ5QDGHk14JdKXpKzDHBk442cs0Ml8bXMfHxZF3d6HWUOrQ1vVI5vbEInblh85O5DW5CMrIqu370rM8ecI+4O
 hgdhvPdprTlBJyrI2glA7Nx3zaq45tNCPVoFPwQIVwevpIRpYCDc8eNU3NM2pMkiXUDg/SiGkKMznUNah6JZMYZ6aaSAz07q+xHT9waqYlagQgE6+aPaeylS
 iqH3Z7h+IHtX0L2ja2BrRb3a0hWbshhzjDe+2C8pYMoEzPMBdnqg7+DySRJAHbSPLHkO64LKxHSZk/8WHkb9u6+INrzXQ58WiIj5ZneKErTqrwKisQi+3eim
 5MERIzI0rcfnbnxrtPSCXealRXiGrH1v6KzfE33OeP0m4HRL4/UPcwODKexL+A6t/2ynpcDJhhfAh29J
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 01:57 PM, Maxime Jourdan wrote:
> Le lun. 1 oct. 2018 à 12:26, Hans Verkuil <hverkuil@xs4all.nl> a écrit :
>>
>> On 09/28/2018 04:28 PM, Maxime Jourdan wrote:
>>> +             }
>>> +
>>> +             return 0;
>>> +     }
>>> +
>>> +     switch (q->type) {
>>> +     case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>>> +             sizes[0] = amvdec_get_output_size(sess);
>>> +             *num_planes = 1;
>>> +             break;
>>> +     case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>>> +             switch (sess->pixfmt_cap) {
>>> +             case V4L2_PIX_FMT_NV12M:
>>> +                     sizes[0] = output_size;
>>> +                     sizes[1] = output_size / 2;
>>> +                     *num_planes = 2;
>>> +                     break;
>>> +             case V4L2_PIX_FMT_YUV420M:
>>> +                     sizes[0] = output_size;
>>> +                     sizes[1] = output_size / 4;
>>> +                     sizes[2] = output_size / 4;
>>> +                     *num_planes = 3;
>>> +                     break;
>>> +             default:
>>> +                     return -EINVAL;
>>> +             }
>>> +             *num_buffers = min(max(*num_buffers, fmt_out->min_buffers),
>>> +                                fmt_out->max_buffers);
>>
>> You can use clamp here. That's easier to read.
>>
> 
> Ack
> 
>>> +             /* The HW needs all buffers to be configured during startup */
>>
>> Why? I kind of expected to see 'q->min_buffers_needed = fmt_out->min_buffers'
>> here. I think some more information is needed here in the comment.
>>
> 
> I'll extend the comments to reflect the following:
> 
> All codecs in the Amlogic vdec need the full available buffer list to
> be configured at startup, i.e all buffer phy addrs must be written to
> registers prior to decoding.
> The firmwares then decide how they use those buffers and the
> interrupts only tell me "the decoder has written a frame to buffer N°
> X".
> 
> fmt_out->min_buffers and fmt_out->max_buffers refer to the min/max
> amount of buffers that can be setup during initialization. In the case
> of MPEG2, the firmware expects 8 buffers, no more no less, so both
> min_buffers and max_buffers have the value "8".
> 
> But even if those values differ (as for H.264 that will come later),
> the firmware still expects all allocated buffers to be setup in
> registers. As such, q->min_buffers_needed must reflect the total
> amount of CAPTURE buffers.

That's much better, thank you! Now I understand why you do this :-)

Regards,

	Hans
