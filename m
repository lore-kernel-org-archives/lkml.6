Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814BEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551F3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfBVNd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:33:59 -0500
Received: from foss.arm.com ([217.140.101.70]:60924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbfBVNd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:33:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04380A78;
        Fri, 22 Feb 2019 05:33:59 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 779AC3F690;
        Fri, 22 Feb 2019 05:33:57 -0800 (PST)
Subject: Re: [Xen-devel] xen/evtchn and forced threaded irq
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dave P Martin <dave.martin@arm.com>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
 <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
Date:   Fri, 22 Feb 2019 13:33:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/02/2019 12:38, Oleksandr Andrushchenko wrote:
> On 2/20/19 10:46 PM, Julien Grall wrote:
>> Discussing with my team, a solution that came up would be to introduce one 
>> atomic field per event to record the number of event received. I will explore 
>> that solution tomorrow.
> How will this help if events have some payload?

What payload? The event channel does not carry any payload. It only notify you 
that something happen. Then this is up to the user to decide what to you with it.

Cheers,

-- 
Julien Grall
