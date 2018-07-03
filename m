Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8BDC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FE624D2D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="biac48P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FE624D2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeGCGk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:40:28 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:60413 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753661AbeGCGkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi; s=20161220;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=6gQPuDh45c4y3cZ4OJoFFboGXYHkRhrnzaKLZcDS/Ww=;
        b=biac48P9Dpo7nxYBw5IxrZijQ2xK5omf1hz8iyb1LHvii7veTm1aZKzKIHW8ja5yLzpqufxpzWXrkTGpz9Ffdp7Jky5X3eMkmRP4Q0LtNUECC3xxyimg822MEe8clILZ/ZgHBYUAal5iFPsqwMldKKsP4G2O5BIsnHNEbW8C7kp49lN4BPNeqBvS8hKXPIxoChWOfzBfhaj5Ffq8xgLhPMtDBrWdrj1r2DaH0jLmVWuhkZH438LXgmnFPOKaNE4Uynj5mbae8ALS08SOmv2rbBmY/SVQRM7ktBc7EyhNCDoyxCwdxFV+iEsFq0CrLgdLvCqElxYy1y5D/1Jd+poGDQ==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1faEz3-0002of-5K; Tue, 03 Jul 2018 09:40:17 +0300
Subject: Re: [PATCH v3 6/8] serial: Add Tegra Combined UART driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        jonathanh@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-7-mperttunen@nvidia.com> <20180702131851.GH13096@ulmo>
 <50c4702b-3d59-e443-5075-c888f83a2615@kapsi.fi> <20180702134731.GI13096@ulmo>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <02120216-e305-5968-3567-d7174c2a8b13@kapsi.fi>
Date:   Tue, 3 Jul 2018 09:40:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180702134731.GI13096@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.2018 16:47, Thierry Reding wrote:
> On Mon, Jul 02, 2018 at 04:30:07PM +0300, Mikko Perttunen wrote:
>> On 02.07.2018 16:18, Thierry Reding wrote:
>>> On Mon, Jul 02, 2018 at 02:40:31PM +0300, Mikko Perttunen wrote:
>>>> The Tegra Combined UART (TCU) is a mailbox-based mechanism that allows
>>>> multiplexing multiple "virtual UARTs" into a single hardware serial
>>>> port. The TCU is the primary serial port on Tegra194 devices.
>>>>
>>>> Add a TCU driver utilizing the mailbox framework, as the used mailboxes
>>>> are part of Tegra HSP blocks that are already controlled by the Tegra
>>>> HSP mailbox driver.
>>>>
>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>> ---
>>>>
>>>> Notes:
>>>>       v2:
>>>>       - Removed (void) casts for unused variables.
>>>>       - Changed the uart_set_options() call to be on one line, even if its
>>>>         over 80 characters.
>>>>       - Added defines for magic numbers.
>>>>       - Style fixes.
>>>>       - Changed Kconfig entry to depend on the Tegra HSP driver instead of
>>>>         just the mailbox framework.
>>>>       v3:
>>>>       - Removed FLUSH bit, as it's unnecessary and slows down printing
>>>>       - Removed call to uart_set_options
>>>>       - Added mbox_free_channel calls to remove()
>>>>
>>>>    drivers/tty/serial/Kconfig       |   9 ++
>>>>    drivers/tty/serial/Makefile      |   1 +
>>>>    drivers/tty/serial/tegra-tcu.c   | 291 +++++++++++++++++++++++++++++++++++++++
>>>>    include/uapi/linux/serial_core.h |   3 +
>>>>    4 files changed, 304 insertions(+)
>>>>    create mode 100644 drivers/tty/serial/tegra-tcu.c
>>>
>>> The driver looks good to me. But for my own understanding, is there some
>>> way we can make use of the multiplexing? That is, could we add a
>>> mechanism to have the driver filter out only a specific stream? Could we
>>> also specify which stream to send data back to? What happens by default?
>>> Which stream is data sent to?
>>
>> There is no multiplexing on the producer/device side (i.e. what this driver
>> does). The mailbox specified in device tree specifies the stream we send
>> stuff to. The mailboxes are per-CPU (we use the CCPLEX mailbox here), so it
>> cannot really be changed.
> 
> Oh, I see, so there is one stream per pair of mailboxes? That is, the
> mailboxes we specify in the DT define which stream we receive from and
> send to?

Correct.

Mikko

> 
> Thierry
> 
