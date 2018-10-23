Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5E5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785AB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785AB2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeJXBAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 21:00:41 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:38206 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeJXBAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 21:00:41 -0400
Received: from svr-orw-mbx-02.mgc.mentorg.com ([147.34.90.202])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1gEzfL-0004qd-UZ from Steve_Longerbeam@mentor.com ; Tue, 23 Oct 2018 09:36:23 -0700
Received: from [172.30.89.8] (147.34.91.1) by svr-orw-mbx-02.mgc.mentorg.com
 (147.34.90.202) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 23 Oct
 2018 09:36:21 -0700
Subject: Re: i.MX6 MIPI-CSI2 OV5640 Camera testing on Mainline Linux
To:     Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>
CC:     <jacopo@jmondi.org>, Jagan Teki <jagan@amarulasolutions.com>,
        <p.zabel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
        <gstreamer-devel@lists.freedesktop.org>,
        <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAMty3ZAMjCKv1BtLnobRZUzp=9Xu1gY5+R3Zi-JuobAJZQrXxg@mail.gmail.com>
 <20180920145658.GE16851@w540>
 <CAHCN7x+U=Y=-v1UP5UYvY8WtUFRJGjmx=nawTuE=YcHdm_DYvA@mail.gmail.com>
 <c1cb34b0-b715-cf08-6f75-2842f1090c5d@mentor.com>
 <20181017080103.GD11703@w540>
 <CAHCN7xLx6uAmYiGh3p=piZFwE0VkfixTLqdjETibKwk2+DhMzA@mail.gmail.com>
 <CAHCN7xJKuPYg04WfRzbYWO4bGoHHnD16LBPRsK1QsiYY1bL7nA@mail.gmail.com>
 <20181022113306.GB2867@w540>
 <CAHCN7xJkc5RW73C0zruWBgyF7G0J3C5tLE=ZdfxTKbrUqs=-PQ@mail.gmail.com>
 <CAOMZO5ATm4BRzPEQOU+ZD6bHCP2Aqjp4raRYhuc+wNe0t4+C=w@mail.gmail.com>
 <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
From:   Steve Longerbeam <steve_longerbeam@mentor.com>
Message-ID: <d78877f8-2c23-2bf0-0a9c-cd98b855e95e@mentor.com>
Date:   Tue, 23 Oct 2018 09:36:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHCN7x+csKEk25CF=teUv+F5_GoTe6_3Yqb5PODLn+AmCCm88w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 10/23/18 8:19 AM, Adam Ford wrote:
> On Mon, Oct 22, 2018 at 7:40 AM Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Adam,
>>
>> On Mon, Oct 22, 2018 at 9:37 AM Adam Ford <aford173@gmail.com> wrote:
>>
>>> Thank you!  This tutorial web site is exactly what I need.  The
>>> documentation page in Linux touched on the media-ctl links, but it
>>> didn't explain the syntax or the mapping.  This graphical
>>> interpretation really helps it make more sense.
>> Is capturing working well on your i.MX6 board now?
> Fabio,
>
> Unfortunately, no.  I built the rootfs based on Jagan's instructions
> at https://openedev.amarulasolutions.com/display/ODWIKI/i.CoreM6+1.5
>
> I tried building both the 4.15-RC6 kernel, a 4.19 kernel and a 4.14 LTS kernel.
>
> Using the suggested method of generating the graphical display of the
> pipeline options, I am able to enable various pipeline options
> connecting different /dev/videoX options tot he camera.  I have tried
> both the  suggested method above as well as the instructions found in
> Documentation/media/v4l-drivers/imx.rst for their respective kernels,
> and I have tried multiple options to capture through
> ipu1_csi1_capture, ipu2_csi1_capture, and ip1_ic_prepenc capture, and
> all yield a broken pipe.
>
> libv4l2: error turning on stream: Broken pipe
> ERROR: from element /GstPipeline:pipeline0/GstV4l2Src:v4l2src0: Could
> not read from resource.
> Additional debug info:
> gstv4l2bufferpool.c(1064): gst_v4l2_buffer_pool_poll ():
> /GstPipeline:pipeline0/GstV4l2Src:v4l2src0:
> poll error 1: Broken pipe (32)
>
> I can hear the camera click when I start gstreamer and click again
> when it stops trying to stream.
>
> dmesg indicates a broken pipe as well..
>
> [ 2419.851502] ipu2_csi1: pipeline start failed with -32
>
> might you have any suggestions?


This -EPIPE error might mean you have a mis-match of resolution, pixel 
format, or field type between one of the source->sink pad links. You can 
find out which pads have a mis-match by enabling dynamic debug in the 
kernel function __media_pipeline_start.

Also make sure you are attempting to stream from the correct /dev/videoN.

Steve

