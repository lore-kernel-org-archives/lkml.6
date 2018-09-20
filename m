Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC578C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EBC21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EBC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731603AbeITMVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:21:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731159AbeITMVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:21:33 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 687C183F4C;
        Thu, 20 Sep 2018 06:39:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-74.pek2.redhat.com [10.72.12.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 295A430912F4;
        Thu, 20 Sep 2018 06:39:27 +0000 (UTC)
Subject: Re: [PATCH 1/3 v2] resource: fix an error which walks through iomem
 resources
To:     Borislav Petkov <bp@suse.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
References: <20180919125251.8181-1-lijiang@redhat.com>
 <20180919125251.8181-2-lijiang@redhat.com>
 <20180919132949.GB9122@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <32409e2a-533b-c317-5519-26e0993cd30e@redhat.com>
Date:   Thu, 20 Sep 2018 14:39:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919132949.GB9122@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 20 Sep 2018 06:39:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月19日 21:29, Borislav Petkov 写道:
> On Wed, Sep 19, 2018 at 08:52:49PM +0800, Lianbo Jiang wrote:
> 
> ...
> 
>> In fact, we should get the resource A and B when we walk through the
>> whole tree, but it only gets the resource A, the resource B is missed.
>>
>> Signed-off-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> 
> Before looking at this: the SOB chain of all three patches is wrong.
> Hint: see section 12) in Documentation/process/submitting-patches.rst
> 
Thanks for your advice, Borislav.

I have discussed with Dave Young, and he suggested that i might add a Suggested-by
tag instead of Signed-off-by tag for him. What do you think about?

I will modify the invalid SOB chain and post it again.

