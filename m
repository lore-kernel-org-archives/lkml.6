Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AA8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FDD205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FDD205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966415AbeFOUCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:02:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:52830 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966117AbeFOUCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:02:15 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fTuvD-0007FZ-N9; Fri, 15 Jun 2018 14:02:12 -0600
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Shuah Khan <shuah@kernel.org>
References: <20180609000819.13883-1-logang@deltatee.com>
 <20180609000819.13883-10-logang@deltatee.com>
 <20180615195152.GA25605@mobilestation>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b04fc30b-54fe-e1b0-3365-47b9bb5e9f13@deltatee.com>
Date:   Fri, 15 Jun 2018 14:02:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615195152.GA25605@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: shuah@kernel.org, Shyam-sundar.S-k@amd.com, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 8/8] NTB: ntb_test: Fix bug when counting remote files
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/18 01:51 PM, Serge Semin wrote:
> On Fri, Jun 08, 2018 at 06:08:19PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
>> When remote files are counted in get_files_count, without using SSH,
>> the code returns 0 because there is a colon prepended to $LOC. $VPATH
>> should have been used instead of $LOC.
>>
> 
> Good catch. Thanks for the patch. I discovered this problem myself a few days
> before you sent this patchset. So was going to submit the fix, but you were
> faster.

Thanks. It would be good to get Acked-bys or Reviewed-bys on the patches
you approved.

Logan
