Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E532C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5CA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g7ZY/jLf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A5CA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeIKGpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 02:45:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36156 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbeIKGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 02:45:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B1jPKT130753;
        Tue, 11 Sep 2018 01:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=CNj0WoAnlKmb28PnPxHebCdQ9LYDLzuoU8SqRQPgBsU=;
 b=g7ZY/jLf86vbatUDR+MWM5JCCMZD0SclUQynM2iXAiJe65h9veAp45nQbhXcRwDSw+9o
 StFlfMdFnpsX/ppgsYK8ySlqws7tJUe7dDTj9i5T58R78T8lHMnK8EsgXASDTF6xXA55
 kT1UBTpIdXS7k85Ys/j8R1GVY+3rydwC2DfbTepzUWbKd5Bu2aKGoWk9tOExspTLRZtG
 Fc5bxvuHyJxXju+X85WtixqAqMskvoCSsi0ke9PUSGYw0rO+hw9ZFvXnI+hlPdSAsBbt
 10S7hxSRUQd9riEP0OpgQDEprILWz7Ejl88oi14+vFfSfBvrtRUb3v+Sx9Yqv0u+uwT0 LQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cph5vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:48:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8B1mFEN008380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:48:15 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8B1mFmd010180;
        Tue, 11 Sep 2018 01:48:15 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 18:48:14 -0700
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
Date:   Tue, 11 Sep 2018 09:48:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180910161135.GA27430@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=625
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming

On 09/11/2018 12:11 AM, Ming Lei wrote:
> Hi Jianchao,
> 
> On Mon, Sep 10, 2018 at 09:40:35AM +0800, jianchao.wang wrote:
>> Hi Ming
>>
>> On 09/09/2018 08:58 PM, Ming Lei wrote:
>>> Now percpu_ref_reinit() can only be done on one percpu refcounter
>>> when it drops zero. And the limit shouldn't be so strict, and it
>>> is quite straightforward that percpu_ref_reinit() can be done when
>>> this counter is at atomic mode.
>>
>> As we know, when the percpu_ref is switched to atomic mode, the values
>> of the per cpu will be sumed up to the atomic conter in percpu_ref_switch_to_atomic_rcu.
> 
> Right.
> 
>>
>> However, the tricky part is:
>> when we switch back to percpu mode, how can we know the exact value of the value of every cpu ?
> 
> The exact value of each CPU is zero at the exact time:
> 
> 1) when percpu mode is switched from atomic mode
> 
> percpu_ref_switch_to_atomic_rcu() is the point where no any percpu inc/dec
> can happen any more. And in this function the percpu count is sumed up to
> the atomic counter, meantime this patch clears the percpu value. It means
> once the refcount is switched to atomic mode, the percpu value is always
> zero, doesn't it?
> 
> 2) when the percpu-refcount is initialized at percpu mode
> 
> the percpu value is zero too.

What we want to get is to switch the percpu refcounter to percpu mode from atomic mode when
the refcounter has _not_ been drained to zero, instead of just to discard the warning, right ?

When we have sumed the values of every cpu's refcounter to a global atomic counter, how can
we give the values back to the refcounter of every cpu ?


Thanks
Jianchao

> 
>>
>> Draining the percpu refcounter to zero before switch it back to percpu mode should be relatively
>> easy to implement. And also, this is the initial intention of percpu refcounter, only switch
> 
> No, I don't think so, we can extend the percpu-refcount implementation to
> cover the NVMe timeout case easily. Then no necessary to reinvent a new wheel
> to address that issue.
> 
>> to atomic mode when want to drain the refcounter. 
> 
> 
> Thanks,
> Ming
> 
