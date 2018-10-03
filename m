Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3598EC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F053E2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nQ15V0o5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F053E2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeJCSEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:04:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36766 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbeJCSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:04:33 -0400
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E36CB7F;
        Wed,  3 Oct 2018 13:16:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1538565395;
        bh=JN/vAjcjDiWYekPpLxHUxKgNJFPOEcGKlXCh/HrnE8c=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nQ15V0o5bZErBajawprgiltVPAFFjoYJHB+IJsgx0ompzK3JuDaTe7Xlol/5H96Tg
         WOxEDI+bbxrUWUm/wWPMM4hjvKO7YUhd2bVoF0X7ExJbRsn6EuTqehDXQYc2NZE1hw
         +7KNGBOYzA41dnonaNR7b/S+LcBEA51NAIulk8a0=
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Message-ID: <ff25134a-6d61-6dd4-f157-8acd53722ad9@ideasonboard.com>
Date:   Wed, 3 Oct 2018 12:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kei,

On 03/10/18 08:08, Keiichi Watanabe wrote:
> I think 480p is a common frame size and it's worth supporting in vivid.
> But, my patch might be ad-hoc. Actually, I'm not sure which values are
> suitable for the intervals.

Aha - yes I did think the duplicates were a bit odd. Anyway, replied
inline there :)

> We might want to add a more flexible/extensible way to specify frame sizes.
> e.g. passing frame sizes and intervals as module parameters

I agree here, having recently extended this table my self with some
local patches it would be great to be able to request some more
arbitrary sizes and rates from VIVID in a more flexible manner.

Regards

Kieran


> 
> Kei
> 
> On Wed, Oct 3, 2018 at 4:06 PM, Keiichi Watanabe <keiichiw@chromium.org> wrote:
>> Support 640x480 as a frame size for video input devices of vivid.
>>
>> Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
>> ---
>>  drivers/media/platform/vivid/vivid-vid-cap.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/vivid/vivid-vid-cap.c b/drivers/media/platform/vivid/vivid-vid-cap.c
>> index 58e14dd1dcd3..da80bf4bc365 100644
>> --- a/drivers/media/platform/vivid/vivid-vid-cap.c
>> +++ b/drivers/media/platform/vivid/vivid-vid-cap.c
>> @@ -51,7 +51,7 @@ static const struct vivid_fmt formats_ovl[] = {
>>  };
>>
>>  /* The number of discrete webcam framesizes */
>> -#define VIVID_WEBCAM_SIZES 5
>> +#define VIVID_WEBCAM_SIZES 6
>>  /* The number of discrete webcam frameintervals */
>>  #define VIVID_WEBCAM_IVALS (VIVID_WEBCAM_SIZES * 2)
>>
>> @@ -59,6 +59,7 @@ static const struct vivid_fmt formats_ovl[] = {
>>  static const struct v4l2_frmsize_discrete webcam_sizes[VIVID_WEBCAM_SIZES] = {
>>         {  320, 180 },
>>         {  640, 360 },
>> +       {  640, 480 },
>>         { 1280, 720 },
>>         { 1920, 1080 },
>>         { 3840, 2160 },
>> @@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
>>         {  1, 5 },
>>         {  1, 10 },
>>         {  1, 15 },
>> +       {  1, 15 },
>> +       {  1, 25 },
>>         {  1, 25 },
>>         {  1, 30 },
>>         {  1, 50 },
>> --
>> 2.19.0.605.g01d371f741-goog
>>

