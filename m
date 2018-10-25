Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB432084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVY69mTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB432084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeJZAXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:23:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52734 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbeJZAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:23:38 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9PFia5M065399;
        Thu, 25 Oct 2018 15:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xBO8T8XDdZdMKUwUWW/yjoYQvr0eZ5kn8rov2lraqss=;
 b=eVY69mTRPt2+HNkGgVLvcxbuXODPpeXCTD0otuLazZ+9Drst1Yn+FVrdyvfXSscJh6N9
 /jJT26oP2aW7BOlgLfcq23C3QsgGSFP2AjSzVNWdYyErvUIEyOb1z1S2bkvu0NKmZhTG
 +seHWCaFELviq/g0YNsF/qLimsAuV5FnJOmcNERRIMnFIpL5D3AJOhAnKp25+fGDrhRc
 UKcevaujlNpJu8atx36i6TeB6/OSXdfi1KSrfd7dydZutkD4EJSXWgV1UZuySy90qJR/
 PyrlUH5Vabt3CRa0pPpMnm2UVAMTIQckQcGtdtYNRGaFkaIs3cnQVbBYfCIkxxos3wnT FA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n7vaqagub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 15:50:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9PFo9eT030491
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Oct 2018 15:50:10 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9PFo95j013594;
        Thu, 25 Oct 2018 15:50:09 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Oct 2018 08:50:08 -0700
Subject: Re: [Xen-devel] [PATCH] xen: drop writing error messages to xenstore
To:     Juergen Gross <jgross@suse.com>,
        Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20181009160959.31076-1-jgross@suse.com>
 <5126873e-ade5-86b0-4ebf-58cb47c9cbe7@oracle.com>
 <90ae453c-f018-60d3-b7a9-e69cd39c0777@suse.com>
 <b1e130bc-983f-f8df-0f5f-66971cc60454@oracle.com>
 <ff88433c-e808-9491-c5a7-ebc5600c7920@suse.com>
 <69f2a1ba-2a4b-bb03-7819-f1d0d6294539@oracle.com>
 <80e05287-920b-3f8d-e329-2d34f7117d60@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <3a3e9c44-1fd5-dc27-bd1c-1b6e19ffbd95@oracle.com>
Date:   Thu, 25 Oct 2018 11:50:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <80e05287-920b-3f8d-e329-2d34f7117d60@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9056 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810250132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/18 8:36 AM, Juergen Gross wrote:
> On 11/10/2018 13:03, Joao Martins wrote:
>> On 10/11/2018 06:05 AM, Juergen Gross wrote:
>>> On 10/10/2018 18:57, Boris Ostrovsky wrote:
>>>> On 10/10/18 11:53 AM, Juergen Gross wrote:
>>>>> On 10/10/2018 17:09, Joao Martins wrote:
>>>>>> On 10/09/2018 05:09 PM, Juergen Gross wrote:
>>>>>>> xenbus_va_dev_error() will try to write error messages to Xenstore
>>>>>>> under the error/<dev-name>/error node (with <dev-name> something like
>>>>>>> "device/vbd/51872"). This will fail normally and another message
>>>>>>> about this failure is added to dmesg.
>>>>>>>
>>>>>>> I believe this is a remnant from very ancient times, as it was added
>>>>>>> in the first pvops rush of commits in 2007.
>>>>>>>
>>>>>>> So remove the additional message when writing to Xenstore failed as
>>>>>>> a minimum step.
>>>>>>>
>>>>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>>>>> ---
>>>>>>> I am considering removing the Xenstore write altogether, but I'm
>>>>>>> not sure it isn't needed e.g. by xend based installations. So please
>>>>>>> speak up in case you know why this write is there.
>>>>>> So this:
>>>>>>
>>>>>> "This will fail normally and another message about this failure is added to dmesg."
>>>>>>
>>>>>> Brings me to the question: What about {stub,driver}domains? Ideally you
>>>>>> shouldn't be looking at domU's dmesg as a control domain no? I can't remember
>>>>>> any other error node, but if something fails e.g. netfront fails to allocate an
>>>>>> unbound event channel - how do you know the cause from the control domain
>>>>>> perspective?
>>>>>>
>>>>>> Irrespective of xend or not: isn't this 'error' node the only one that
>>>>>> propagates error causes per device from domU?
>>>>> What does it help you in dom0 if you have an error message in Xenstore
>>>>> if a frontend driver couldn't do its job? Is there anything you can do
>>>>> as a Xen admin?
>>>> The admin may want to know, for example, that a hotplug in the guest failed.
>>> Shouldn't he ask the guest for that? There are dozens of other possible
>>> problems letting hotplug fail which won't write anything to Xenstore.
>>>
>> But I think nothing stops people from using their own hotplug script that could
>> use this error node (or even something else).
>>
>>> This might be interesting for development/test purposes, but I really
>>> question it to stay in mature code.
>>>
>> You're right in all of it: it doesn't convey the error in a agnostic manner, ATM
>> doesn't report all errors involved in the device setup, and when a
>> xenbus_dev_fatal happens you might end up looking at the guest anyways. But
>> there might be users right now of this node e.g. cases where you have a bunch of
>> known/trusted Linux guests working as backends (which also use this error node,
>> it's not just frontends *I think*) which you would be able to recognize the
>> error messages to inform the admin e.g. maybe QubesOS? It is merely an
>> informative error message node, but it seems better than just a simple
>> XenbusClosed state, with many reasons that it could lead to. Anyhow, just my 2c.
> If there are any users this will be in rather old Xen versions only, as
> writing the Xenstore node is _failing_ with newer Xen versions (that was
> the original reason for writing that patch).
>
> So back to my patch: any reason not to take it? After all it will only
> remove the not very helpful kernel message that writing the Xenstore
> node failed.

For the patch itself:

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracel.com>

(For the possible future removal of the write altogether --- I'd rather
keep it. "rather old versions" --- tragically, we are still on 4.4)
