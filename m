Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 72E9BC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFE8208B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFE8208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933980AbeFLI7w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:59:52 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:58536 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933363AbeFLI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:59:50 -0400
Received: from [IPv6:2001:983:e9a7:1:5839:ca32:cf14:dfd0] ([IPv6:2001:983:e9a7:1:5839:ca32:cf14:dfd0])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Sf9Vf5RilxiYrSf9WfjhgF; Tue, 12 Jun 2018 10:59:47 +0200
Subject: Re: [PATCH v4 2/2] media: staging/imx: fill vb2_v4l2_buffer sequence
 entry
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Peter Seiderer <ps.report@gmx.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steve Longerbeam <slongerbeam@gmail.com>
Cc:     linux-media@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180315191323.6028-1-ps.report@gmx.net>
 <20180315191323.6028-2-ps.report@gmx.net>
 <892dd00e-83bc-7781-6684-603ff89378cd@gmail.com>
 <20180611224833.64a89c80@gmx.net> <1528792895.5280.7.camel@pengutronix.de>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7d270227-41ed-c9d8-e585-68820a78f25e@xs4all.nl>
Date:   Tue, 12 Jun 2018 10:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1528792895.5280.7.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJBrPzcgfGQT88P1Kb0iwaOdwp6GH0OZxpYFDE7QkaAV+9yQRMGQZ9ObT/7lVDWVBggy//ajuZuEEqGZP9VS0w7OS9gz1Va+b0WxFYW0o3E8Ikbb+2lD
 Qx8uKxx+wSoCIkSY/WToykEXDhpeldbgd6LopR6s6ZgEAZWnrxRxkQ3/6ZUECDi5Cwlu9xdHtjdGxo4BFLy2vXVpm4SdrqhyMxHrGjT8J/21SQntvTFUz0/o
 F8jTgEb2amsZ2XUF3GKSnKAGkLhP7QBXUndrFv0IxIP3Waov7Yg3ZsUbbDvQNP243e7/3t9nO1KhL/YaHGIlpLI0qYZ1o5SVHarUqnSdu1XjA6etT12BRQJe
 eQFyVAC80usldijd6JhVwuIovUnQoQB/DzLVn3R8c8alj771jxVlhn7KZEFOrILBfukBRb8vv4zhZOHwggzibpgU7jczbzDiksOM1Gv1AlMHNGflh6hLjc8e
 wO1+2FBA/bq6K2buxMU4g4FuD6jxZfufgc3VsQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/18 10:41, Philipp Zabel wrote:
> Hi,
> 
> On Mon, 2018-06-11 at 22:48 +0200, Peter Seiderer wrote:
>> Hello *,
>>
>> On Fri, 16 Mar 2018 10:05:44 -0700, Steve Longerbeam <slongerbeam@gmail.com> wrote:
>>
>>> Reviewed-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>
>> Ping? Anybody taking this one?
> 
> The patches have been marked not applicable in patchwork [1][2].
> They do apply on media_tree master.
> 
> [1] https://patchwork.linuxtv.org/patch/47946/
> [2] https://patchwork.linuxtv.org/patch/47947/
> 
> regards
> Philipp
> 

I changed the state to NEW and delegated it to me, so the next time I'm processing
patches I'll handled them. I suspect the state was changed by mistake by someone
(quite possibly me!).

Regards,

	Hans
