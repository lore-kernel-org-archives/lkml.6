Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F55A21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfBGVjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:39:14 -0500
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:43707
        "EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726622AbfBGVjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:39:14 -0500
Received: from [192.168.0.55] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id rrH0gsWspMXCVrrH1g3W9f; Thu, 07 Feb 2019 14:31:56 -0700
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Chinner <david@fromorbit.com>,
        Doug Ledford <dledford@redhat.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard> <20190207052310.GA22726@ziepe.ca>
 <CC414509-F046-49E3-9D0C-F66FD488AC64@oracle.com>
 <6b260348-966a-bc95-162b-44ae8265cf03@talpey.com>
 <20190207165740.GB29531@iweiny-DESK2.sc.intel.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <93012d17-d3f9-76d5-e6e0-ea39198db5a9@talpey.com>
Date:   Thu, 7 Feb 2019 16:31:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190207165740.GB29531@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNPBqiYWIPsqmJZqH2jytLAnIXKzGFJfDAQMUwijHbk9kJ8s97vSl4fnvGK6Eap6I3FFyYm5i7ddpt0pKnwEWuRGa1RIZVwDGf8TZLWSk9RU2ZvvrpNh
 Mkr/3cQUSXkgWKpICJJMV9/5Ql6fi+6Bfj7FG64fMPKAJ2rdJcdYD5IJdRsg1lD8qUd5EEhEe9B+hHys7VkQLU+5aw5XRN975P0xGY8BvaM0yim85LM35Dxu
 UU8Fi5VKSHrDIZDngF5mJCjJxszaPVzOHmbwhD04CyY/+0W6STERnASpIUMFH1JuxENPdW0ACHV6yVRp0TXeO1j5dbtHH+5TJLklB7bdDswnS1r/WXSoxGoK
 7JbF3m+lSgudUxZoh7PDoCe/rgh0CwMyMbT4jJVGWrC/yEzulQVo1syLVmfbKMgYOJZlezEXr2jG2ArW6LpDvFr3SgDWZ19SliffBBxKl/pQ8iysc78ba985
 Q1uxsQMmdIGPEnpPds6RNv8VEmRZVT5Xh+MxsYGR36slWZhsKBnEu63sv/spsSTs9fBES04WftDTS99AX9l3eHC0w7BU1EVaR7C3OFP8+AEXb1jeL0LRRyVh
 qpm9exdHAnKH3mUs/5itFSWS4LtSdgqQiu/iLEaArj5R7Fu1wMuGwm7EzP0fjNY8ZiU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2019 11:57 AM, Ira Weiny wrote:
> On Thu, Feb 07, 2019 at 10:28:05AM -0500, Tom Talpey wrote:
>> On 2/7/2019 10:04 AM, Chuck Lever wrote:
>>>
>>>
>>>> On Feb 7, 2019, at 12:23 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Thu, Feb 07, 2019 at 02:52:58PM +1100, Dave Chinner wrote:
>>>>
>>>>> Requiring ODP capable hardware and applications that control RDMA
>>>>> access to use file leases and be able to cancel/recall client side
>>>>> delegations (like NFS is already able to do!) seems like a pretty
>>>>
>>>> So, what happens on NFS if the revoke takes too long?
>>>
>>> NFS distinguishes between "recall" and "revoke". Dave used "recall"
>>> here, it means that the server recalls the client's delegation. If
>>> the client doesn't respond, the server revokes the delegation
>>> unilaterally and other users are allowed to proceed.
>>
>> The SMB3 protocol has a similar "lease break" mechanism, btw.
>>
>> SMB3 "push mode" has long-expected to allow DAX mapping of files
>> only when an exclusive lease is held by the requesting client.
>> The server may recall the lease if the DAX mapping needs to change.
>>
>> Once local (MMU) and remote (RDMA) mappings are dropped, the
>> client may re-request that the server reestablish them. No
>> connection or process is terminated, and no data is silently lost.
> 
> How long does one wait for these remote mappings to be dropped?

The recall process depends on several things, but it certainly takes a
network round trip.

If recall fails, the file protocols allow the server to revoke. However,
since this results in loss of data, it's a last resort.

Tom.
