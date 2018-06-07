Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R9IPCUjcGFuTZAAAmS7hNA
	; Thu, 07 Jun 2018 07:22:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3BEAC6089E; Thu,  7 Jun 2018 07:22:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0746A605A2;
	Thu,  7 Jun 2018 07:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0746A605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753283AbeFGHWB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:22:01 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:51328 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752880AbeFGHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:22:00 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id QpEzfDH5adJgZQpF3fSw70; Thu, 07 Jun 2018 09:21:58 +0200
Subject: Re: [RFC PATCH 1/2] media: docs-rst: Add decoder UAPI specification
 to Codec Interfaces
To: Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Tomasz Figa <tfiga@chromium.org>
Cc: LMML <linux-media@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?UGF3ZcWCIE/Fm2NpYWs=?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20180605103328.176255-1-tfiga@chromium.org>
 <20180605103328.176255-2-tfiga@chromium.org>
 <CAAoAYcOJ5Q2rHqGEmcStxxXj423a3ddKOSzvwRV6R5-UxhM+Hg@mail.gmail.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <b767d9d7-5a26-f6f8-3978-81e8d60769c2@xs4all.nl>
Date: Thu, 7 Jun 2018 09:21:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAAoAYcOJ5Q2rHqGEmcStxxXj423a3ddKOSzvwRV6R5-UxhM+Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMrRA2iiMrb1xQaKfc9dH9VT/lQXFUiptkUaK8WR9auPcR9RudJo5j98uo0R0f9H1SqYcWJjRdH/Bp/2Y5AaF8T1mSnylE+Re0VOiSp7AwtwMcbPGrhB
 RF1v+jeM4+pqt74Yf1uknSIvZ8cQSmR1kROOU4RSMYkV9JTary0GnK1w0A1DWhwy8zM9dV97h1OtxgpwJ55keBn3efgiQfq1RWcAsJN6340MxzKSSztqNNCn
 eAiRGRGPAJu/WcI4KnNT+xOVvCEmuvmepKtNZSBFrJSSMEYWZraTGZFRJNHu1tsiAkyaDcXkZe2F04BWd8yljtJru0bZJp8GpCpiiEg223ktNOpadeX0AKvu
 4Orgkjbtlo+1O9EIYKoVezRUegGyAokq4kSaS6MyHj/UwX/pc4RMqn1fsoeKzaFYCoAdS5Mc3Ec0xX/y0rK/WvVdTDgZEuQQn0VHtYqyF3cacOZay2w2//HU
 R13XudZq3SSbOAsiwvo4LUqsAJQZzFDgh9p7/9/SWOXova8gjXr9a6l8VP0JdiE4EPbvEPLWuuXaSeL/ozOIaqY0qgYtSzi67yKaCGHWzHqrAROo3RZ/z5Zj
 l4RyJHodRVdCzJ0PMCinv1v7lHMjB9OIIdCw665do9JSaDHh48YwB42dNBo2j2YhxZA/83bHpxK6pGDEO6iFI40Rp3wNPjTiuuCm6wBqg+qjkN7HkYzpYfdw
 zjAd2Q1KXcDOkx5pOkM5+BlyD/X54wLNYqMtuAYV2TDjfREM0WbQnfX6LdeZy4lw2EnetOOeYkobDLEe4RNlNZ1/Frf9ZQkT+FVbc7U6Nu2yosJXnjVqoxCC
 6F4o/psNTBp5GdvnPgIdyTNY3RdEA9Ru8dfY1xx0u9AZdGGVqD4Sju/P0KO2VtePw4iujwk/1GZdXIr8HNozsZ6a9aFfs1pJJIQzMcn4ombuFQX0XnEdV3SX
 vlo1eBiqiUReoPY4s7+ClvIusSQi7ifka8XHPCisFMaxFkrW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 03:10 PM, Dave Stevenson wrote:
> Hi Tomasz.
> 
> Thanks for formalising this.
> I'm working on a stateful V4L2 codec driver on the Raspberry Pi and
> was having to deduce various implementation details from other
> drivers. I know how much we all tend to hate having to write
> documentation, but it is useful to have.
> 
> On 5 June 2018 at 11:33, Tomasz Figa <tfiga@chromium.org> wrote:
>> Due to complexity of the video decoding process, the V4L2 drivers of
>> stateful decoder hardware require specific sequencies of V4L2 API calls
>> to be followed. These include capability enumeration, initialization,
>> decoding, seek, pause, dynamic resolution change, flush and end of
>> stream.
>>
>> Specifics of the above have been discussed during Media Workshops at
>> LinuxCon Europe 2012 in Barcelona and then later Embedded Linux
>> Conference Europe 2014 in Düsseldorf. The de facto Codec API that
>> originated at those events was later implemented by the drivers we already
>> have merged in mainline, such as s5p-mfc or mtk-vcodec.
>>
>> The only thing missing was the real specification included as a part of
>> Linux Media documentation. Fix it now and document the decoder part of
>> the Codec API.
>>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>  Documentation/media/uapi/v4l/dev-codec.rst | 771 +++++++++++++++++++++
>>  Documentation/media/uapi/v4l/v4l2.rst      |  14 +-
>>  2 files changed, 784 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/media/uapi/v4l/dev-codec.rst b/Documentation/media/uapi/v4l/dev-codec.rst
>> index c61e938bd8dc..0483b10c205e 100644
>> --- a/Documentation/media/uapi/v4l/dev-codec.rst
>> +++ b/Documentation/media/uapi/v4l/dev-codec.rst
>> @@ -34,3 +34,774 @@ the codec and reprogram it whenever another file handler gets access.
>>  This is different from the usual video node behavior where the video
>>  properties are global to the device (i.e. changing something through one
>>  file handle is visible through another file handle).
> 
> I know this isn't part of the changes, but raises a question in
> v4l2-compliance (so probably one for Hans).
> testUnlimitedOpens tries opening the device 100 times. On a normal
> device this isn't a significant overhead, but when you're allocating
> resources on a per instance basis it quickly adds up.
> Internally I have state that has a limit of 64 codec instances (either
> encode or decode), so either I allocate at start_streaming and fail on
> the 65th one, or I fail on open. I generally take the view that
> failing early is a good thing.
> Opinions? Is 100 instances of an M2M device really sensible?

Resources should not be allocated by the driver until needed (i.e. the
queue_setup op is a good place for that).

It is perfectly legal to open a video node just to call QUERYCAP to
see what it is, and I don't expect that to allocate any hardware resources.
And if I want to open it 100 times, then that should just work.

It is *always* wrong to limit the number of open arbitrarily.

Regards,

	Hans
