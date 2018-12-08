Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69CE20700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D69CE20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbeLHSdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:33:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:34212 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeLHSdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:33:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E386CEBD;
        Sat,  8 Dec 2018 10:33:31 -0800 (PST)
Received: from [10.0.2.15] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34C513F575;
        Sat,  8 Dec 2018 10:33:28 -0800 (PST)
Subject: Re: [PATCH v4 03/10] sched/topology: Provide cfs_overload_cpus bitmap
To:     Steven Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1544131696-2888-1-git-send-email-steven.sistare@oracle.com>
 <1544131696-2888-4-git-send-email-steven.sistare@oracle.com>
 <9253783d-d53f-9587-61eb-2505bca5fc0c@arm.com>
 <5c145b18-773d-756d-b0b9-1b939c441bd6@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <42abaaa5-6e3e-7362-7622-565f98e9629f@arm.com>
Date:   Sat, 8 Dec 2018 18:33:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5c145b18-773d-756d-b0b9-1b939c441bd6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 22:35, Steven Sistare wrote:
[...]
>>> +	if (!sds->cfs_overload_cpus) {
>>> +		mask = sparsemask_alloc_node(nr_cpu_ids, 3, flags, nid);
>>                                              ^^^^^^^^^^ ^^^
>>                                                  (1)    (2)
>>
>> (1): Is this necessary? Wouldn't cpumask_weight(span) suffice?
> 
> weight does not work because the ids are not consecutive.  As a future 
> optimization I have a patch that computes a local CPU id within the LLC
> and uses that as the bitmap index, and that uses weight.  For this first
> series I am keeping things simple.
> 

Oh, duh, non-contiguous spans strike again. Fair enough!

[...]
