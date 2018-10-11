Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A225C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD63520835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 11:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tfvcvXfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD63520835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeJKSaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:30:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54626 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbeJKSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:30:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9BArolh018108;
        Thu, 11 Oct 2018 11:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=f/4tcR6Qk0aYJm+8PZLaNqONoyNmujzIWMOxtTtamgk=;
 b=tfvcvXfUZLUyFT0HvQmfOk/KEoZmjlNBT6fXv25RJpkcRJsy/oRSsRfO5V3uvi1m3E/m
 Nb3XCUUlQ1+kUbYUbQO6QTioEntq6IWWuAHg0+75gETMElICYtzLXHA9V0kZsbx4XAL2
 9q7HfSi3lJsezyOqBcgXCV5613e8XZ6Tfmj0khqUf1xDrHVDVsdUpVE3PSB+nlwNZDFf
 JgnwK9GYB98mmBXu1+1M9PJRmH7pC+uZE5F/sV0UvcSjuZG8bqmY01H3X5A4vgGJ5yUV
 0lbhb7Xw4pcOhP7xqhh6P9tfafoiG55KwT9ZoWy2fGzZ2tTkIwRX5cWWxmAq3UB3EDvt Ag== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mxn0qbepc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 11:03:27 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9BB3RkY018389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 11:03:27 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9BB3Q4W007130;
        Thu, 11 Oct 2018 11:03:26 GMT
Received: from [10.175.217.19] (/10.175.217.19)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 11:03:26 +0000
Subject: Re: [Xen-devel] [PATCH] xen: drop writing error messages to xenstore
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20181009160959.31076-1-jgross@suse.com>
 <5126873e-ade5-86b0-4ebf-58cb47c9cbe7@oracle.com>
 <90ae453c-f018-60d3-b7a9-e69cd39c0777@suse.com>
 <b1e130bc-983f-f8df-0f5f-66971cc60454@oracle.com>
 <ff88433c-e808-9491-c5a7-ebc5600c7920@suse.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <69f2a1ba-2a4b-bb03-7819-f1d0d6294539@oracle.com>
Date:   Thu, 11 Oct 2018 12:03:24 +0100
MIME-Version: 1.0
In-Reply-To: <ff88433c-e808-9491-c5a7-ebc5600c7920@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 06:05 AM, Juergen Gross wrote:
> On 10/10/2018 18:57, Boris Ostrovsky wrote:
>> On 10/10/18 11:53 AM, Juergen Gross wrote:
>>> On 10/10/2018 17:09, Joao Martins wrote:
>>>> On 10/09/2018 05:09 PM, Juergen Gross wrote:
>>>>> xenbus_va_dev_error() will try to write error messages to Xenstore
>>>>> under the error/<dev-name>/error node (with <dev-name> something like
>>>>> "device/vbd/51872"). This will fail normally and another message
>>>>> about this failure is added to dmesg.
>>>>>
>>>>> I believe this is a remnant from very ancient times, as it was added
>>>>> in the first pvops rush of commits in 2007.
>>>>>
>>>>> So remove the additional message when writing to Xenstore failed as
>>>>> a minimum step.
>>>>>
>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>> ---
>>>>> I am considering removing the Xenstore write altogether, but I'm
>>>>> not sure it isn't needed e.g. by xend based installations. So please
>>>>> speak up in case you know why this write is there.
>>>> So this:
>>>>
>>>> "This will fail normally and another message about this failure is added to dmesg."
>>>>
>>>> Brings me to the question: What about {stub,driver}domains? Ideally you
>>>> shouldn't be looking at domU's dmesg as a control domain no? I can't remember
>>>> any other error node, but if something fails e.g. netfront fails to allocate an
>>>> unbound event channel - how do you know the cause from the control domain
>>>> perspective?
>>>>
>>>> Irrespective of xend or not: isn't this 'error' node the only one that
>>>> propagates error causes per device from domU?
>>> What does it help you in dom0 if you have an error message in Xenstore
>>> if a frontend driver couldn't do its job? Is there anything you can do
>>> as a Xen admin?
>>
>> The admin may want to know, for example, that a hotplug in the guest failed.
> 
> Shouldn't he ask the guest for that? There are dozens of other possible
> problems letting hotplug fail which won't write anything to Xenstore.
> 
But I think nothing stops people from using their own hotplug script that could
use this error node (or even something else).

> This might be interesting for development/test purposes, but I really
> question it to stay in mature code.
> 
You're right in all of it: it doesn't convey the error in a agnostic manner, ATM
doesn't report all errors involved in the device setup, and when a
xenbus_dev_fatal happens you might end up looking at the guest anyways. But
there might be users right now of this node e.g. cases where you have a bunch of
known/trusted Linux guests working as backends (which also use this error node,
it's not just frontends *I think*) which you would be able to recognize the
error messages to inform the admin e.g. maybe QubesOS? It is merely an
informative error message node, but it seems better than just a simple
XenbusClosed state, with many reasons that it could lead to. Anyhow, just my 2c.

Cheers,
	Joao
