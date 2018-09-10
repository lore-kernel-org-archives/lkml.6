Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4004420866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4004420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeIJOHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:07:11 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:48420 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbeIJOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:07:11 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id zIGdf1IMSw2L8zIGgfJUft; Mon, 10 Sep 2018 11:14:06 +0200
Subject: Re: [PATCH 0/2] Document memory-to-memory video codec interfaces
To:     Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>, kamil@wypas.org,
        a.hajda@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        jtp.park@samsung.com, Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <andrew-ct.chen@mediatek.com>, todor.tomov@linaro.org,
        nicolas@ndufresne.ca,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        ezequiel@collabora.com
References: <20180724140621.59624-1-tfiga@chromium.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <bed0d45d-d5c0-d2dc-03d7-eedf99246182@xs4all.nl>
Date:   Mon, 10 Sep 2018 11:13:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180724140621.59624-1-tfiga@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfO7Po06B+pNkxnZnTT52T1RpE3JIQs+lVtVxvLV2psyw5PQHmTvSeQWGkyuGzCYhGObLhpbwNRM1h+S8T+RI1Se3Xy/lwv+ypiiDR+WsYiuhdsL3bCDl
 yXyWgle8NXfFauNPYY8WZXlsSHt4KSXz5evFrM5X/0wUC6IsGDj3JJBbCv2kcFrHL1xlQvp6RhDE7UvcU0AhxV84DmONLxWE6g4PLjDT8k0c+mbNQlX8nVWN
 iHEHJ7dQCn3S/iKFrUgP4DqCoMHXZ4cWsxFV98m8Kvaq+GHZ/pIHQArzA6xnv3DEENgb53uVRLoFvLSlGmY6f2GvWZblivsUDcFRRcE479ZzYHHAH+T1OewE
 rLuvxRcx79Va9lfXqlaa9IK86y5gIUH0BhKwOk7QizpiQ73CyqQr1OrdCgPL1mo29sePU5Tm50wrnUpeO2wfXwD1bA0+Jh9VgyUhs/4FGSRhqhILPOCSC7AO
 oybpn+dZuAvd8Kzpk3pkM4nGjGTCfcDAuDwMWmTqx8ZzVz7Uj5DUtv1kZ/Sf2LmDnBv8az4en6hhTjhHC2vi4HqvQIkBaJy5hAorhBu0Q/09yXFDwArejSMV
 gh/QOQLMyF9vuI+SJ2u7L81iqQHplCQn6h7f9NzjTHSxD/vQCVY0phHfH8yippUbQyjcpLo6E+g5DEoNU2i834Uapi2Pj4RTQ2B4ViYMFQEKnnUrko9eWfWa
 iANhEBZGzCnhG3xhzoy8h9VyxGg+N22LYePI8v5Pq3phgm9FWIV8MvNJksUmbhsQ57ETeipN3GjsTRFESJDD2ARuC6Yea/et0hXr1xAb2DBMxzRQwKuu3Euf
 YcGKpkMJ5AI+9NChPA31shLbUbjPAwpH9FzsnHvy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 07/24/2018 04:06 PM, Tomasz Figa wrote:
> This series attempts to add the documentation of what was discussed
> during Media Workshops at LinuxCon Europe 2012 in Barcelona and then
> later Embedded Linux Conference Europe 2014 in Düsseldorf and then
> eventually written down by Pawel Osciak and tweaked a bit by Chrome OS
> video team (but mostly in a cosmetic way or making the document more
> precise), during the several years of Chrome OS using the APIs in
> production.
> 
> Note that most, if not all, of the API is already implemented in
> existing mainline drivers, such as s5p-mfc or mtk-vcodec. Intention of
> this series is just to formalize what we already have.
> 
> It is an initial conversion from Google Docs to RST, so formatting is
> likely to need some further polishing. It is also the first time for me
> to create such long RST documention. I could not find any other instance
> of similar userspace sequence specifications among our Media documents,
> so I mostly followed what was there in the source. Feel free to suggest
> a better format.
> 
> Much of credits should go to Pawel Osciak, for writing most of the
> original text of the initial RFC.

I'm adding this here as a result of an irc discussion, since it applies
to both encoders and decoders:

How to handle non-square pixel aspect ratios?

Decoders would have to report it through VIDIOC_CROPCAP, so this needs
to be documented when the application should call this, but I don't
think we can provide this information today for encoders.

Regards,

	Hans
