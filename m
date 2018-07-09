Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3424BC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB0B20871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB0B20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=grinn-global.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932534AbeGIJth (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:49:37 -0400
Received: from smtp.megiteam.pl ([31.186.83.105]:48708 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754317AbeGIJtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:49:36 -0400
X-Greylist: delayed 2133 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Jul 2018 05:49:35 EDT
Received: from [95.143.241.142] (helo=[192.168.0.120])
        by smtp.megiteam.pl with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <m.niestroj@grinn-global.com>)
        id 1fcSF0-0008Am-E0; Mon, 09 Jul 2018 11:13:55 +0200
Subject: Re: [PATCH 1/4] rtc: omap: fix potential crash on power off
To:     Johan Hovold <johan@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keerthy <j-keerthy@ti.com>, stable <stable@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
References: <20180704090558.16647-1-johan@kernel.org>
 <20180704090558.16647-2-johan@kernel.org>
From:   Marcin Niestroj <m.niestroj@grinn-global.com>
Message-ID: <19327b80-3f3e-0c23-b191-b6f0e823ca51@grinn-global.com>
Date:   Mon, 9 Jul 2018 11:13:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704090558.16647-2-johan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.07.2018 11:05, Johan Hovold wrote:
> Do not set the system power-off callback and omap power-off rtc pointer
> until we're done setting up our device to avoid leaving stale pointers
> around after a late probe error.
> 
> Fixes: 97ea1906b3c2 ("rtc: omap: Support ext_wakeup configuration")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Johan Hovold <johan@kernel.or

Reviewed-by: Marcin Niestroj <m.niestroj@grinn-global.com>

-- 
Marcin Niestroj
