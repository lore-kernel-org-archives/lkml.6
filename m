Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2001CECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC3F208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 10:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC3F208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeGOLG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 07:06:56 -0400
Received: from www381.your-server.de ([78.46.137.84]:46189 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeGOLG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 07:06:56 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1feeVo-0006oc-Lq; Sun, 15 Jul 2018 12:44:20 +0200
Received: from [188.174.116.68] (helo=[192.168.178.33])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1feeVo-0009pf-Eu; Sun, 15 Jul 2018 12:44:20 +0200
Subject: Re: [PATCH 5/5] iio:adxl372: Add filter bandwidth support
To:     Jonathan Cameron <jic23@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
Cc:     Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1531409818-20300-1-git-send-email-stefan.popa@analog.com>
 <20180715113636.5394c756@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f16d0271-b203-ab02-50d8-fb0ef2ddc540@metafoo.de>
Date:   Sun, 15 Jul 2018 12:44:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180715113636.5394c756@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24754/Sun Jul 15 06:52:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/15/2018 12:36 PM, Jonathan Cameron wrote:
> On Thu, 12 Jul 2018 18:36:58 +0300
> Stefan Popa <stefan.popa@analog.com> wrote:
> 
>> This patch adds the option for the user to select the filter bandwidth. The
>> user can also read the available bandwidths which are always adjusted to be
>> at most half of the sampling frequency. Furthermore, the currently selected
>> bandwidth can be read via the read_raw function, while the write_raw sets a
>> new bandwidth value.
>>
> 
> How will the youth of today learn about aliasing if we are so nice to them?
>  :)  Good user friendly design choice btw.  If someone is doing something
> crazy where they actually want the aliasing they can hack the driver.

Actually they can't. The hardware itself enforces that the filter bandwidth
is below or equal to the Nyquist frequency. All the user can do is select a
bandwidth even smaller. :)
