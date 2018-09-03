Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E47C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2AF20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2AF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeICQRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:17:42 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:55615 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727186AbeICQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:17:41 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id wnUIflUQVxO9BwnULfqYMK; Mon, 03 Sep 2018 13:57:50 +0200
Subject: Re: [PATCH 0/4] media: platform: Add Aspeed Video Engine driver
To:     Eddie James <eajames@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, andrew@aj.id.au, mchehab@kernel.org,
        joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <364c2565-fdb0-dd31-5852-6358066810a5@xs4all.nl>
Date:   Mon, 3 Sep 2018 13:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1535576973-8067-1-git-send-email-eajames@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCdQHA7n+nK8xU0LtFlxm6Ac7gJJ1zP74WLQXPNPvWiYo5+mEJOSHTItsodx8AhWEqhAiTV0EPytrULAINPWtPMe5iU38F0L7Vn2I3HC2rLJqZsD/djR
 kvyUsxFMV0bfvi9BwruPp/+D3VZx3rHtWndgASvVL+RuxFj8RG4R7kS3EO+X9jyMqCg/MD6Y4YcDVTTW9E6bSpj4HOySNo8NwFNU04CDMi7aCIW7JHoSxCUo
 nwY56ASXzGD+TG+Z1g5VJVLWJSMr623YLrXczB2cV3uL6md8gn5avvvmqtM/4smoCw/lKAxnWNsVtirQbzbAsiPrwM/1+4m3n4DU3T8i/E4i0ptCoIGsESMD
 9uP0VZp9z1RyFJCrX884Wza3wFQN/hsgOaMlNgWyOsTaUa1jnoV7/6KF6Kz6/f7FUJPG3TyGoArCxt1dZpVJ9JllP6yuPX5JBpGWXdhEqu1ZZh/ACezyqogv
 351mMfnEkPakUK4NVqLqdO7W9KvjsjLnZ2LY9sU9my1KTAleEr9DQSQ5ASurTEusz7wr1eutCgJfi7U3fak/A1Q2QOQP5LEm6Xvv5xohxe7xuZGMEP+9bhug
 xQyoRasxLWwfaaA/L7VqeMOkNP9X3tqL2vrgx+7rc0RzRp+ukpEJl5n55oOa8v/PgWg6ii9eOhY9ncodKrPwAwM0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

Thank you for your work on this. Interesting to see support for this SoC :-)

On 08/29/2018 11:09 PM, Eddie James wrote:
> The Video Engine (VE) embedded in the Aspeed AST2400 and AST2500 SOCs
> can capture and compress video data from digital or analog sources. With
> the Aspeed chip acting as a service processor, the Video Engine can
> capture the host processor graphics output.
> 
> This series adds a V4L2 driver for the VE, providing a read() interface
> only. The driver triggers the hardware to capture the host graphics output
> and compress it to JPEG format.
> 
> Testing on an AST2500 determined that the videobuf/streaming/mmap interface
> was significantly slower than the simple read() interface, so I have not
> included the streaming part.

Do you know why? It should be equal or faster, not slower.

I reviewed about half of the driver, but then I stopped since there were too
many things missing.

First of all, you need to test your driver with v4l2-compliance (available here:
https://git.linuxtv.org/v4l-utils.git/). Always compile from the git repo since
the versions from distros tend to be too old.

Just run 'v4l2-compliance -d /dev/videoX' and fix all issues. Then run
'v4l2-compliance -s -d /dev/videoX' to test streaming.

This utility checks if the driver follows the V4L2 API correctly, implements
all ioctls that it should and fills in all the fields that it should.

Please add the output of 'v4l2-compliance -s' to future versions of this patch
series: I don't accept V4L2 drivers without a clean report of this utility.

If you have any questions, then mail me or (usually quicker) ask on the #v4l
freenode irc channel (I'm in the CET timezone).

One thing that needs more explanation: from what I could tell from the driver
the VIDIOC_G_FMT ioctl returns the detected format instead of the current
format. This is wrong. Instead you should implement the VIDIOC_*_DV_TIMINGS
ioctls and the V4L2_EVENT_SOURCE_CHANGE event.

The normal sequence is that userspace queries the current timings with
VIDIOC_QUERY_DV_TIMINGS, if it finds valid timings, then it sets these
timings with _S_DV_TIMINGS. Now it can call G/S_FMT. If the timings
change, then the driver should detect that and send a V4L2_EVENT_SOURCE_CHANGE
event.

When the application receives this event it can take action, such as
increasing the size of the buffer for the jpeg data that it reads into.

The reason for this sequence of events is that you can't just change the
format/resolution mid-stream without giving userspace the chance to
reconfigure.

Regards,

	Hans

> 
> It's also possible to use an automatic mode for the VE such that
> re-triggering the HW every frame isn't necessary. However this wasn't
> reliable on the AST2400, and probably used more CPU anyway due to excessive
> interrupts. It was approximately 15% faster.
> 
> The series also adds the necessary parent clock definitions to the Aspeed
> clock driver, with both a mux and clock divider.
> 
> Eddie James (4):
>   clock: aspeed: Add VIDEO reset index definition
>   clock: aspeed: Setup video engine clocking
>   dt-bindings: media: Add Aspeed Video Engine binding documentation
>   media: platform: Add Aspeed Video Engine driver
> 
>  .../devicetree/bindings/media/aspeed-video.txt     |   23 +
>  drivers/clk/clk-aspeed.c                           |   41 +-
>  drivers/media/platform/Kconfig                     |    8 +
>  drivers/media/platform/Makefile                    |    1 +
>  drivers/media/platform/aspeed-video.c              | 1307 ++++++++++++++++++++
>  include/dt-bindings/clock/aspeed-clock.h           |    1 +
>  6 files changed, 1379 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/media/aspeed-video.txt
>  create mode 100644 drivers/media/platform/aspeed-video.c
> 

