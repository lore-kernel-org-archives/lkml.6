Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 274E6C004E4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C491C208CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FIJOhn5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C491C208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936026AbeFNDMQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 23:12:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60596 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935846AbeFNDMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 23:12:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5E3A2bF034144;
        Thu, 14 Jun 2018 03:11:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=9pq6vCHRlWIUihC4aEOjs4KGaESdcPkpRK4YoCsZjWs=;
 b=FIJOhn5hTnF//VZhZVtxCiZmmuxmpxd+x8tO0NsTA6c0CNOO4dC5r69BiKBNYJwaLQgg
 9PYpX7Y9UE0ZBhu5duIdlTTmqKiPvMSIbgT3za8/TstS+s9LcMxJkODL5bV6ym+MA+/w
 MWBzhlVfDrFVMGOeou7drSBGVQeMECPLhQuB3cAsNoIfSKbJZ8oO6T0k87m7OU0Q3WQc
 Q9b9Zr5O3O5PVWgRORkEqEQ4oioej1kwygYOpwrUrviU+22sY/Qb/OiI7OvjgcwZ5kHm
 K+V3XHSvkJ/qcf/z7jlKTXCREYC2UO3Cln7KYOc7QfiG3MdijxUNq7pNjUbFzaxHKwDp wQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jk0xrb558-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 03:11:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5E3BogG027431
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jun 2018 03:11:51 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5E3BntK029034;
        Thu, 14 Jun 2018 03:11:50 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 20:11:49 -0700
Subject: Re: kernel BUG at drivers/scsi/scsi_error.c:197! - git
 4.17.0-x64-08428-g7d3bf613e99a
To:     Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc:     "randrianasulu@gmail.com" <randrianasulu@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <201806091606.51078.randrianasulu@gmail.com>
 <025bf705-15b0-65e5-4b16-6c91d41c1730@infradead.org>
 <40617b19667b3c1302f8a903c19f2fa2f409b12a.camel@wdc.com>
 <5ca74fb7-af70-31c3-0e3f-bace058e5a57@oracle.com>
 <20180613140411.GA32701@lst.de>
 <09e8bd7605febd091679172d68ca1e9ca3990c91.camel@wdc.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b9942f20-9949-ebd8-b574-e4730a12b0ae@oracle.com>
Date:   Thu, 14 Jun 2018 11:12:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <09e8bd7605febd091679172d68ca1e9ca3990c91.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806140034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph and Bart

On 06/13/2018 10:08 PM, Bart Van Assche wrote:
> On Wed, 2018-06-13 at 16:04 +0200, hch@lst.de wrote:
>>> I suspect this is due to we could expire a same request twice or even more.
>>> For scsi mid-layer, it return BLK_EH_DONE from .timeout, in fact, the request is not
>>> completed there, but just queue a delayed abort_work (HZ/100). If the blk_mq_timeout_work
>>> runs again before the abort_work, the request will be timed out again, because there is not
>>> any mark on it to identify this request has been timed out.
>>>
>>> Would please try the patch attached on to see whether this issue could be fixed ?
>>> (this patch only works for scsi device currently)
>>
>> The patch isn't really going to work without a caller of your new
>> __blk_mq_complete_request helper, is it?> 
> __blk_mq_complete_request() is already called today by blk_mq_complete_request().
> However, it's not clear to me why that function is exported by Jianchao's patch.
> 

Sorry for the confusion about this path.

In the current blk-mq timeout mechanism of 4.18, the reference count of request only ensure the request tag
will not be release during the timeout handing, this is a great idea to fix the life recycle issue.

But we don't protect the timed out request against the normal completion path.
For example, if a request is in scsi abort or eh procedure, it still could be completed by the normal completion path.
Before this, blk_mq_complete_request cannot proceed to invoke __blk_mq_complete_request if a request is timed out,
because we have marked 'completed' or 'aborted_gstate' when we find the request is timed out. In the blk-legacy, we
still do this with blk_mark_request_complete in blk_rq_check_expired and blk_complete_request.

The patch I posted here is to change the request state to MQ_RQ_COMPLETE if it is timed out, then we could protect
the timed out request against the normal request again. But we have handed the task of completing a timed out request to LLDD, and blk_mq_complete_request cannot work any more, so I exported __blk_mq_complete_request here for the time out path of LLDD to complete the request. There is another patch to replace the blk_mq_complete_request to __blk_mq_complete_request, but I did't post here due to this is just a test.

For scsi mid-layer, the scsi_mq_done will invoke blk_mq_complete_request, the abort and eh procedure will finally invoke blk_mq_requeue_request and blk_mq_end_request, so the this patch should work for scsi.

Thanks
Jianchao

>> Either way the concept of doing error handling without quiescing the
>> queue just looks bogus to me and will end up with some sort of race
>> here or there.
> 
> The SCSI error handler already waits until all pending requests have finished
> before it starts handling timed out commands. This e-mail thread started with a
> report of a crash in the SCSI error handler, which is a regression introduced in
> the v4.18 merge window.
> 
> Bart.
> 

