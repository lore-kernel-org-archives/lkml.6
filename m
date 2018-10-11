Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB4DC4161D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEE82085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 12:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEE82085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJKTlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 15:41:11 -0400
Received: from mail5.windriver.com ([192.103.53.11]:48656 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeJKTlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 15:41:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w9BCBwLP027796
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 11 Oct 2018 05:12:09 -0700
Received: from [128.224.155.90] (128.224.155.90) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 11 Oct
 2018 05:11:47 -0700
Subject: Re: net/tipc: recursive locking in tipc_link_reset
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "parthasarathy.bhuvaragan@ericsson.com" 
        <parthasarathy.bhuvaragan@ericsson.com>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@gmail.com>
References: <CACT4Y+bcxEz=P2E5TRj6A1qeCOQ+WtWR44WGLzqdDttLzD393A@mail.gmail.com>
 <DM5PR15MB15134EF6AA09E8268FA58D519AE10@DM5PR15MB1513.namprd15.prod.outlook.com>
From:   Ying Xue <ying.xue@windriver.com>
Message-ID: <e2797ecd-ef5d-7571-bbc6-4584c614162a@windriver.com>
Date:   Thu, 11 Oct 2018 20:05:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DM5PR15MB15134EF6AA09E8268FA58D519AE10@DM5PR15MB1513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.90]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon, please help to review the patch:
https://patchwork.ozlabs.org/patch/982447.

Thanks,
Ying

On 10/11/2018 06:55 PM, Jon Maloy wrote:
> Hi Dmitry,
> Yes, we are aware of this, the kernel test robot warned us about this a few days ago.
> I am looking into it.
> 
> ///jon
