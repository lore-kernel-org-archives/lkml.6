Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A53FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C7920894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C7920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeG3Q6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:58:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33062 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbeG3Q6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C60ACFB5E;
        Mon, 30 Jul 2018 15:23:19 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw.lab.eng.bos.redhat.com [10.16.186.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 696222026D68;
        Mon, 30 Jul 2018 15:23:18 +0000 (UTC)
Subject: Re: [PATCH] x86/MCE: Fix CPU microcode version output
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, Filippo Sironi <sironi@amazon.de>
References: <20180703164844.9742-1-prarit@redhat.com>
 <20180703165849.GA17773@agluck-desk> <20180703214300.GA15087@zn.tnic>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <e76c74b6-4008-9f7d-83bf-dd48433a7ea3@redhat.com>
Date:   Mon, 30 Jul 2018 11:23:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180703214300.GA15087@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 15:23:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 30 Jul 2018 15:23:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'prarit@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2018 05:43 PM, Borislav Petkov wrote:
> On Tue, Jul 03, 2018 at 09:58:49AM -0700, Luck, Tony wrote:
>> On Tue, Jul 03, 2018 at 12:48:44PM -0400, Prarit Bhargava wrote:
>>> On systems where a runtime microcode update has occurred the
>>> microcode version is wrong because boot_cpu_data.microcode is
>>> not updated during runtime.
>>>
>>> Use the per-CPU microcode version in the MCE message.
>>
>> Other option would be to fix the microcode update code to make
>> sure that boot_cpu_data.microcode is right.
> 
> Yes, I already requested that:
> 
> https://lkml.kernel.org/r/1527852626-7258-1-git-send-email-sironi@amazon.de
> 
> Looks like Filippo has a patch already. CCed.

Filippo & Borislav, did the patch get committed to a -next tree?

P.

> 
