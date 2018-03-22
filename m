Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeCVS6w (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:58:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55706 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751739AbeCVS6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:58:50 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E4611602B6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v4 4/6] infiniband: cxgb4: Eliminate duplicate barriers on
 weakly-ordered archs
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-rdma@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Steve Wise <swise@chelsio.com>,
        Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
References: <1521514068-8856-5-git-send-email-okaya@codeaurora.org>
 <201803221430.P43GJl9U%fengguang.wu@intel.com>
 <3664b253c730dbf83f4528acaedb3a88@codeaurora.org>
 <3e9c006e4541acbce11743dbda553e84@codeaurora.org>
 <20180322184833.GB9469@ziepe.ca>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <2c575798-53d8-6ae3-5f54-f697abf067bb@codeaurora.org>
Date: Thu, 22 Mar 2018 13:58:46 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322184833.GB9469@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/2018 1:48 PM, Jason Gunthorpe wrote:
>> AFAIS, even writeq won't compile on this arch. I started questioning this
>> build test.
> I have the same confusion. Did you figure out an explanation?

I did a compile test without the relaxed change. It built just fine.
CONFIG_64BIT is also not defined in the .config file from kbuild.
I also dropped this patch on v5 due to Steve's request.

However, I think I still need an answer for 
v6: RDMA/qedr: eliminate duplicate barriers on weakly-ordered archs #2
I can switch to #include <linux/io-64-nonatomic-lo-hi.h> there.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
