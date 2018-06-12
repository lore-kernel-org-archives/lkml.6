Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B4F87C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B7D2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XdWGHMUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B7D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933864AbeFLNpe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:45:34 -0400
Received: from smtprelay.synopsys.com ([198.182.37.59]:40481 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933448AbeFLNpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:45:32 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 04D731E04F7;
        Tue, 12 Jun 2018 15:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1528811131; bh=HlAy1UgzcZabioHZX9zlM0Jk5i3yJAa9CEFl86VKkyA=;
        h=Subject:To:References:CC:From:Date:In-Reply-To:From;
        b=XdWGHMUOzN4nFO1i/M+Y2QALVCKODB9gz8/wu5NVH8uZxO2ArSE5hApbTlrd71N03
         +c2LahnUvlUqgu+7fKFIspMPCycj10EhCBazX8t3Oe6nqL1m+QjaDich/6AmSZuKti
         MOUOL2JtNXX76U5QUcljD6LRKry6/zu7SKnYYLa0x4pVxU9HiOLMaX7w1M2m63OwGj
         HTSESKfSa4DbXdnhm8nHeSyTh2XydZCu4zgxNLZy0jLUzfJun72VoSoMY8DzYiI202
         mAzEkh/xqVvymOCKT571kYEWarWk9nizMmq7zSUHlw61K8oz/xzBCZYSd2ynVfxrvB
         lmIzMDPJ7ry4Q==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id CA4EE3252;
        Tue, 12 Jun 2018 06:45:29 -0700 (PDT)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 06:45:29 -0700
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 12 Jun 2018 15:45:27 +0200
Received: from [10.0.2.15] (10.107.19.20) by DE02WEHTCB.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 12 Jun
 2018 15:45:26 +0200
Subject: Re: [PATCH v10 4/4] [media] platform: Add Synopsys DesignWare HDMI RX
 Controller Driver
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1513013948.git.joabreu@synopsys.com>
 <5f9eedfd6f91ed73ef0bb6d3977588d01478909f.1513013948.git.joabreu@synopsys.com>
 <108e2c3c-243f-cd67-2df7-57541b28ca39@xs4all.nl>
 <635e7d70-0edb-7506-c268-9ebbae1eb39e@synopsys.com>
 <ca5b3cf7-c7d0-36d4-08ac-32a7a00afd7d@xs4all.nl>
 <f5341c4b-43e2-12f6-9c9f-2385d47bb2fd@synopsys.com>
 <86a5787d-6ed6-7674-35f9-c77341b4c36b@xs4all.nl>
 <3c15b537-33b3-f786-369e-5d82ab9eeb9c@synopsys.com>
 <ed3dabc0-66b2-d069-99f9-75b742709e9f@xs4all.nl>
CC:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        "Sylwester Nawrocki" <snawrocki@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Philippe Ombredanne <pombredanne@nexb.com>
From:   Jose Abreu <Jose.Abreu@synopsys.com>
Message-ID: <dbfa5d85-0cac-caab-07aa-0d048c68cea0@synopsys.com>
Date:   Tue, 12 Jun 2018 14:45:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <ed3dabc0-66b2-d069-99f9-75b742709e9f@xs4all.nl>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.19.20]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 08-06-2018 08:41, Hans Verkuil wrote:
> Hi Jose,
>
> I have not seen any updates for this series. What is the status? I thought we
> were close to merging this...

Good to hear from you! Hope you are doing fine! :)

A colleague of mine is working on this right now. We expect to
send a new series with some more features added.

Thanks and Best Regards,
Jose Miguel Abreu

>
> Regards,
>
> 	Hans
>
> On 12/15/2017 12:23 PM, Jose Abreu wrote:
>> Hi Hans,
>>
>> On 13-12-2017 20:49, Hans Verkuil wrote:
>>> On 13/12/17 15:00, Jose Abreu wrote:
>>>> Indeed. I compared the values with the spec and they are not
>>>> correct. Even hsync is wrong. I already corrected in the code the
>>>> hsync but regarding interlace I'm not seeing an easy way to do
>>>> this without using interrupts in each vsync because the register
>>>> I was toggling does not behave as I expected (I misunderstood the
>>>> databook). Maybe we should not detect interlaced modes for now?
>>>> Or not fill the il_ fields?
>>> As I mentioned above you as long as you get a good backporch value you
>>> can deduce from whether it is an odd or even number to which field it
>>> belongs and fill in the other values. So I think you only need to read
>>> these values for one field.
>>>
>>> Filling in good values here (at least as far as is possible since not all
>>> hardware can give it) will help debugging issues, even if you otherwise do
>>> not support interlaced.
>> Ok, I will fill the fields.
>>
>> Until the end of January I will be quite busy in another project
>> so if you could review the remaining patches of this series I
>> would appreciate very much ... This way when I have the time I
>> can code all the changes and send them at once.
>>
>> Thanks and Best Regards,
>> Jose Miguel Abreu
>>
>>> Regards,
>>>
>>> 	Hans
>>

