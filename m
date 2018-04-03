Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDCRrL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:47:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbeDCRrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:47:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 506046022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v5 3/3] RDMA/qedr: eliminate duplicate barriers on
 weakly-ordered archs #2
To: "Kalderon, Michal" <Michal.Kalderon@cavium.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "timur@codeaurora.org" <timur@codeaurora.org>,
        "sulrich@codeaurora.org" <sulrich@codeaurora.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "Elior, Ariel" <Ariel.Elior@cavium.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1521736009-23387-1-git-send-email-okaya@codeaurora.org>
 <1521736009-23387-4-git-send-email-okaya@codeaurora.org>
 <ac46b4e4-7e6c-c15f-06eb-01b1e4893d50@codeaurora.org>
 <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <3f8de63a-9036-a5ac-2369-2d9af80bb6ef@codeaurora.org>
Date: Tue, 3 Apr 2018 13:47:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CY1PR0701MB201215C9F38E8760732B595088A50@CY1PR0701MB2012.namprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/2018 3:42 AM, Kalderon, Michal wrote:
> The wmb before writel are used to make sure the
> HW observes the changes in memory before we trigger the doorbell. 

According to Linus, writel() guarantees observability. No extra
barrier is necessary.

https://www.mail-archive.com/netdev@vger.kernel.org/msg225806.html

There shouldn't be any wmb() in drivers unless it is used for a
very well-known reason. 

APIs like readX() and writeX() guarantee observability.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
