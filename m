Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6FC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EAC208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9EAC208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966208AbeFOT4h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:56:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52730 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966065AbeFOT4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:56:36 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fTupk-00070u-Dc; Fri, 15 Jun 2018 13:56:33 -0600
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-5-logang@deltatee.com>
 <20180615194929.GA24025@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6fab7e2b-e7aa-8e67-a318-5ce790677c0d@deltatee.com>
Date:   Fri, 15 Jun 2018 13:56:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615194929.GA24025@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 4/8] NTB: ntb_pingpong: Choose doorbells based on port
 number
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 01:49 PM, Serge Semin wrote:
> Regarding the patch. The idea of using the port number instead of linearised
> unique index should also work for Intel/AMD/IDT drivers. But the ports-space
> linearization algorithm was created for the case if the real port numbers
> would exceed the available Doorbell bits. I thought this might be the case of
> multi-ports version of the switchtec driver.

Well, the switchtec driver splits its 64 doorbells in two sets, one for
each port right now. That will likely have to change when we go to a
multi-port implementation. In that case we will have 64 doorbells and a
maximum 48 ports. So I don't think we have to concern ourselves with
more ports than doorbells.

> Needless to say, that if Switchtec driver had the ports-index API implementation,
> this patch wouldn't be needed.

As I've said, it's impossible to write for the crosslink topology so the
clients must support that case.

Logan
