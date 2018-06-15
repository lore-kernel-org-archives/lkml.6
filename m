Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD90C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E057208EA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E057208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966435AbeFOTvc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:51:32 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52666 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966065AbeFOTvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:51:31 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fTuki-0006yD-8W; Fri, 15 Jun 2018 13:51:20 -0600
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-4-logang@deltatee.com>
 <20180615194848.GA22880@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5fbee1ec-b66d-3e82-c19f-dbb8d8582509@deltatee.com>
Date:   Fri, 15 Jun 2018 13:51:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615194848.GA22880@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/8] NTB: Fix the default port and peer numbers for legacy
 drivers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 01:48 PM, Serge Semin wrote:
> Concerning the fix of the discovered issues and fixes introduced by this
> patchset. I'd suggest to add the ports-index callbacks to the Switchtec
> driver, which identify local and peer ports. After this the current version
> of all the test drivers shall perfectly work.

Well that will work for the simple switchtec case. The crosslink
topology CAN NOT produce port numbers like you ask. It is perfectly
symmetric and the two hosts cannot reliably figure out which is port 0
and which is port 1. So these patches support this case.

Logan
