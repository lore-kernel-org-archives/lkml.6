Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69F3C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3C20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 09:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF3C20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbeJEQQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 12:16:33 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:51365 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbeJEQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 12:16:32 -0400
Received: from [IPv6:2001:420:44c1:2579:51eb:3c7a:5e3a:802b] ([IPv6:2001:420:44c1:2579:51eb:3c7a:5e3a:802b])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 8MFogK7Z40ZZE8MFrgnLOS; Fri, 05 Oct 2018 11:18:40 +0200
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
To:     Keiichi Watanabe <keiichiw@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Shik Chen <shik@chromium.org>
References: <20181003070656.193854-1-keiichiw@chromium.org>
 <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5b236e95-b737-51b3-df4f-eea41a36735e@xs4all.nl>
Date:   Fri, 5 Oct 2018 11:18:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAD90VcbBUcpwLsY0sHim+mML6esSjZA2ocX0Ff-YiZxBsLTZ+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEIfFPaTD6NtdO+LnGDHLqo/szkqT8hlw7N63uTdSl3uFE+YBrbhK/S43ALch4DqcUKDzpaS33V8s0macMv82ykVEHKHzbFcHSRTdZLs7xHbb3p6033D
 WOShh+/3z7DWW2rdSYvKPMSkTj5HpZj/oJ/e7achZfouxQuc4wott/05Z5/MoxphBQF9Sqszv6PfbiSnHZtLOBg8OY8MhwRA4eVVgOG1djBf5rJ77qxnBniV
 2HGoY2LqbgGexXxraATqT1iqtHgytZBpRAIKTnRz375pHR9BgLDx0nLemGTMcidz2+btUnJv7YIoh1sSvSziR8e7MYw2WsLccpCjROnawE8FvqffgtNCXAfQ
 17YDZ4YQi7/K2rR/ZrjrvQG+7+9e58CwiXujvNDe4lEd+1/kXEDF/bjcqAsieEKO8mnKEoi5zFjkpTcUwed6fIWSrKgDz5lgsCHqvNcx16uAAMs2bVP5HIag
 OMEDCF6Z5vzVD4AP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/18 09:08, Keiichi Watanabe wrote:
> I think 480p is a common frame size and it's worth supporting in vivid.
> But, my patch might be ad-hoc. Actually, I'm not sure which values are
> suitable for the intervals.

I can apply this ad-hoc patch as-is.

Or do you want to postpone this and work on a more generic solution?
Although I am not sure what that would look like.

Proposals are welcome!

The main purpose of this code is to have something that kind of acts like
a real webcam that has various resolutions, and a slower framerate for
higher resolutions (as you would expect).

Regards,

	Hans

> 
> We might want to add a more flexible/extensible way to specify frame sizes.
> e.g. passing frame sizes and intervals as module parameters
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

