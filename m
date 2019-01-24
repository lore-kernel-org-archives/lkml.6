Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E643AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD86218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 12:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfAXMQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 07:16:40 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52975 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbfAXMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 07:16:39 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08874351|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03311;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.Dq5zod3_1548332185;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.Dq5zod3_1548332185)
          by smtp.aliyun-inc.com(10.147.43.230);
          Thu, 24 Jan 2019 20:16:26 +0800
Subject: Re: [RFC v7 0/5] pstore/block: new support logger for block devices
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548245116-6360-1-git-send-email-liaoweixiong@allwinnertech.com>
 <20190123182638.GD2792@darkstar.musicnaut.iki.fi>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <5f243418-c6bd-061e-1161-1c0139ad84bf@allwinnertech.com>
Date:   Thu, 24 Jan 2019 20:16:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190123182638.GD2792@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-24 02:26, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jan 23, 2019 at 08:05:11PM +0800, liaoweixiong wrote:
>> Why should we need pstore_block?
>> 1. Most embedded intelligent equipment have no persistent ram, which
>> increases costs. We perfer to cheaper solutions, like block devices.
>> In fast, there is already a sample for block device logger in driver
>> MTD (drivers/mtd/mtdoops.c).
> 
> I think you should add a patch for some actual block device using this
> new framework to show that it can work. What HW you think would be
> using things?
> 

I will try to add a patch. Actually, I have implemented it on allwinner
platform, but unfortunately these codes are unsuitable to submit to
upper stream.

In addition, there is already a sample for pstore/blk on patch 3 of
version 7. It names
blkoops. Blkoops is suitable for most block device as what it need is
just a path of a partition. We can use it to test most of features but
panic.

> A.
> 

-- 
liaoweixiong
