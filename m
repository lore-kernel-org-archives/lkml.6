Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616AFC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24976208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24976208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opengridcomputing.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeIYBpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:45:12 -0400
Received: from 72-48-214-68.dyn.grandenetworks.net ([72.48.214.68]:41336 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725824AbeIYBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:45:12 -0400
Received: from [10.10.0.239] (cody.ogc.int [10.10.0.239])
        by smtp.opengridcomputing.com (Postfix) with ESMTPSA id 566372265F;
        Mon, 24 Sep 2018 14:41:25 -0500 (CDT)
Subject: Re: [PATCH] iw_cxgb4: Use proper enumerated type in c4iw_bar2_addrs
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20180924192903.16796-1-natechancellor@gmail.com>
From:   Steve Wise <swise@opengridcomputing.com>
Message-ID: <f1c6aef0-40d4-f0c4-b008-28ca22280d46@opengridcomputing.com>
Date:   Mon, 24 Sep 2018 14:41:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924192903.16796-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2018 2:29 PM, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/infiniband/hw/cxgb4/qp.c:287:8: warning: implicit conversion
> from enumeration type 'enum t4_bar2_qtype' to different enumeration type
> 'enum cxgb4_bar2_qtype' [-Wenum-conversion]
>                                                  T4_BAR2_QTYPE_EGRESS,
>                                                  ^~~~~~~~~~~~~~~~~~~~
> 
> c4iw_bar2_addrs expects a value from enum cxgb4_bar2_qtype so use the
> corresponding values from that type so Clang is satisfied without
> changing the meaning of the code.
> 
> T4_BAR2_QTYPE_EGRESS = CXGB4_BAR2_QTYPE_EGRESS = 0
> T4_BAR2_QTYPE_INGRESS = CXGB4_BAR2_QTYPE_INGRESS = 1
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Looks correct, Thanks.

Acked-by: Steve Wise <swise@opengridcomputing.com>
