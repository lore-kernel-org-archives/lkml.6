Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C876AECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847982151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 13:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847982151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbeISTMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:12:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:51744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727657AbeISTMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 15:12:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3E9A5ACDE;
        Wed, 19 Sep 2018 13:34:16 +0000 (UTC)
Subject: Re: [PATCH] xen: issue warning message when out of grant maptrack
 entries
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20180918093200.17499-1-jgross@suse.com>
 <f75e7a31-eef9-e444-0440-f46c3cd111fa@oracle.com>
 <b1245f25-d780-a560-c78d-4d393ee4a8e4@suse.com>
 <38478db4-2c54-3115-375d-59bfe40b3144@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <de1d3ca3-608a-8fd3-de61-2a2b2eaf3681@suse.com>
Date:   Wed, 19 Sep 2018 15:34:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <38478db4-2c54-3115-375d-59bfe40b3144@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/18 15:29, Boris Ostrovsky wrote:
> On 9/18/18 1:17 PM, Juergen Gross wrote:
>> On 18/09/18 19:03, Boris Ostrovsky wrote:
>>> On 9/18/18 5:32 AM, Juergen Gross wrote:
>>>> When a driver domain (e.g. dom0) is running out of maptrack entries it
>>>> can't map any more foreign domain pages. Instead of silently stalling
>>>> the affected domUs issue a rate limited warning in this case in order
>>>> to make it easier to detect that situation.
>>>>
>>>> Signed-off-by: Juergen Gross <jgross@suse.com>
>>>> ---
>>>>  drivers/xen/grant-table.c | 25 +++++++++++++++++++------
>>>>  1 file changed, 19 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
>>>> index 7bafa703a992..09f6ff8c1957 100644
>>>> --- a/drivers/xen/grant-table.c
>>>> +++ b/drivers/xen/grant-table.c
>>>> @@ -1040,18 +1040,31 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
>>>>  		return ret;
>>>>  
>>>>  	for (i = 0; i < count; i++) {
>>>> -		/* Retry eagain maps */
>>>> -		if (map_ops[i].status == GNTST_eagain)
>>>> -			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref, map_ops + i,
>>>> -						&map_ops[i].status, __func__);
>>>> -
>>>> -		if (map_ops[i].status == GNTST_okay) {
>>>> +		switch (map_ops[i].status) {
>>>> +		case GNTST_okay:
>>>> +		{
>>>>  			struct xen_page_foreign *foreign;
>>>>  
>>>>  			SetPageForeign(pages[i]);
>>>>  			foreign = xen_page_foreign(pages[i]);
>>>>  			foreign->domid = map_ops[i].dom;
>>>>  			foreign->gref = map_ops[i].ref;
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		case GNTST_no_device_space:
>>>> +			pr_warn_ratelimited("maptrack limit reached, can't map all guest pages\n");
>>>> +			break;
>>>> +
>>>> +		case GNTST_eagain:
>>>> +			/* Retry eagain maps */
>>>> +			gnttab_retry_eagain_gop(GNTTABOP_map_grant_ref,
>>>> +						map_ops + i,
>>>> +						&map_ops[i].status, __func__);
>>>> +			break;
>>>> +
>>>> +		default:
>>>> +			break;
>>>>  		}
>>>>  	}
> 
> 
> After having a second look at this (and at the risk of embarrassing
> myself again with this patch) --- aren't we supposed to test status
> after gnttab_retry_eagain_gop() call, and then actually set foreign
> properties?

Right. Thanks for catching that!

V2 coming soon...


Juergen

