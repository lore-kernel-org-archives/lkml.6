Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06477C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D3720857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qgLLuoSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D3720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeIFGYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:24:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54050 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeIFGYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:24:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w861nA1G020512;
        Thu, 6 Sep 2018 01:50:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=v1MSzK+y/F7sKCneVWtm+Hyyfgc2IybAef9aVuLsPPs=;
 b=qgLLuoSKWQaHHASuFiFt18pkiNgaoTqdzDUDDapsPbkaAoGx/0aSYj2+XgGFFPBjKbm1
 beF0RQblUyyfueqFDTFiYrTpgZ5DdBCFt9VfEfgU1UEl5OmoU6aO8szNsynCXSuXFkNr
 sOyCYquAn4NDscMEXcB3fKmHGO7hPbz2dce6dJ+KOqjpAJwEM8BznAViYS881BJ8GLo+
 6dOtN84RVxVv8Xyh36ayBdtFrRxSSWmr7glkKJrS0Bngq5Fpgl+fdK38972s/DvpTSuX
 z0p3PaZfWl4H4Jltu3B3tDEo4CAf9XvWeCnuZucGUTdimEnL0V/4RPv1QGwyirlgOQDf mg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2m7jqpqgk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Sep 2018 01:50:55 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w861orJU031640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Sep 2018 01:50:54 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w861ormH028350;
        Thu, 6 Sep 2018 01:50:53 GMT
Received: from [10.182.69.224] (/10.182.69.224)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Sep 2018 18:50:53 -0700
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        jthumshirn@suse.de, bart.vanassche@wdc.com
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180905212659.GB21352@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b7074098-ab79-53b2-5cc6-25f859c4c666@oracle.com>
Date:   Thu, 6 Sep 2018 09:51:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905212659.GB21352@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9007 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809060017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/06/2018 05:27 AM, Ming Lei wrote:
> On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
>> Dear all
>>
>> As we know, queue freeze is used to stop new IO comming in and drain
>> the request queue. And the draining queue here is necessary, because
>> queue freeze kills the percpu-ref q_usage_counter and need to drain
>> the q_usage_counter before switch it back to percpu mode. This could
>> be a trouble when we just want to prevent new IO.
>>
>> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
>> nvme_reset_work will unfreeze and wait to drain the queues. However,
>> if IO timeout at the moment, no body could do recovery as nvme_reset_work
>> is waiting. We will encounter IO hang.
> 
> As we discussed this nvme time issue before, I have pointed out that
> this is because of blk_mq_unfreeze_queue()'s limit which requires that
> unfreeze can only be done when this queue ref counter drops to zero.
> 
> For this nvme timeout case, we may relax the limit, for example,
> introducing another API of blk_freeze_queue_stop() as counter-pair of
> blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
> from atomic mode inside the new API.

Looks like we cannot switch a percpu-ref to percpu mode directly w/o drain it.
Some references maybe lost.

static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
{
	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
	int cpu;

	BUG_ON(!percpu_count);

	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
		return;

	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);

	/*
	 * Restore per-cpu operation.  smp_store_release() is paired
	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
	 * zeroing is visible to all percpu accesses which can see the
	 * following __PERCPU_REF_ATOMIC clearing.
	 */
	for_each_possible_cpu(cpu)
		*per_cpu_ptr(percpu_count, cpu) = 0;

	smp_store_release(&ref->percpu_count_ptr,
			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
}

> 
>>
>> So introduce a light-weight queue close feature in this patch set
>> which could prevent new IO and needn't drain the queue.
> 
> Frankly speaking, IMO, it may not be an good idea to mess up the fast path
> just for handling the extremely unusual timeout event. The same is true
> for doing the preemp only stuff, as you saw I have posted patchset for
> killing it.
> 

In normal case, it is just a judgment like 

	if (unlikely(READ_ONCE(q->queue_gate))

It should not be a big deal.

Thanks
Jianchao

> Thanks,
> Ming
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=DAEJOGyHAQ8bbVD3QYxBNFE2vn70OyFrmEF5VkwzHRw&s=pmqDbwFqgHROYOJBCE4k9SKOc7PRMk4ESya6gYks_CQ&e=
> 
