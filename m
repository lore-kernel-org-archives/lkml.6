Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4336BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123F7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 123F7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeK0NzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbeK0NzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8886630820CE;
        Tue, 27 Nov 2018 02:58:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 438F060BE8;
        Tue, 27 Nov 2018 02:58:43 +0000 (UTC)
Subject: Re: [PATCH 0/2 RESEND v7] add reserved e820 ranges to the kdump
 kernel e820 table
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-ia64@vger.kernel.org, linux-efi@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, ard.biesheuvel@linaro.org,
        tony.luck@intel.com, fenghua.yu@intel.com, dyoung@redhat.com,
        bhe@redhat.com
References: <20181124051223.19994-1-lijiang@redhat.com>
 <35e8ade5-d5a8-b5e4-180b-44b4ff0a83b1@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <463c284b-115e-0784-ca07-a430127e6176@redhat.com>
Date:   Tue, 27 Nov 2018 10:58:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <35e8ade5-d5a8-b5e4-180b-44b4ff0a83b1@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 27 Nov 2018 02:58:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年11月27日 02:54, Dave Hansen 写道:
> On 11/23/18 9:12 PM, Lianbo Jiang wrote:
>> These patches add the new I/O resource descriptor 'IORES_DESC_RESERVED'
>> for the iomem resources search interfaces, and in order to make it still
>> work after the new descriptor is added, these codes originally related
>> to 'IORES_DESC_NONE' have been updated.
> 
> This is rather anemic "0/" text.  Could you please include some more
> background in here?  The 2/2 patch is pretty good in this regard, but it
> needs to be here, too.
> 

Thanks for your comment. 

Originally, this patch added the e820 reserved ranges by accurately comparing
a string. It only modifies fewer code paths. Please refer to patch v6.
https://lore.kernel.org/lkml/20181114072926.13312-2-lijiang@redhat.com/

Because the string comparison is fragile and error-prone, this patch used the
solution that adds a new descriptor 'IORES_DESC_RESERVED'. Please refer to this
link: https://lore.kernel.org/lkml/20181120192935.GK2527@zn.tnic/

When passing the e820 reserved ranges to the second kernel, why does it need to
compare strings accurately or add a new descriptor 'IORES_DESC_RESERVED'?

-The reason is that it can not exactly match the e820 reserved resource ranges
when walking through iomem resources with the descriptor 'IORES_DESC_NONE'.

Thanks.
Lianbo
