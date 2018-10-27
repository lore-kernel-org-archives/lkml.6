Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD67ECDE46
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AD020831
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 02:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AD020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeJ0K7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 06:59:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52440 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbeJ0K7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 06:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E52C308424E;
        Sat, 27 Oct 2018 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-142.pek2.redhat.com [10.72.12.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F103519753;
        Sat, 27 Oct 2018 02:19:57 +0000 (UTC)
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        bhe@redhat.com, dyoung@redhat.com
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026163554.GA26331@nazgul.tnic>
From:   lijiang <lijiang@redhat.com>
Message-ID: <e8357c26-1969-f870-d2e5-62b77a1b4fd5@redhat.com>
Date:   Sat, 27 Oct 2018 10:19:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181026163554.GA26331@nazgul.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Sat, 27 Oct 2018 02:20:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年10月27日 00:35, Borislav Petkov 写道:
> On Fri, Oct 26, 2018 at 08:32:11PM +0800, lijiang wrote:
>> If SME is enabled in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
>> contains the memory encryption mask, so i have to remove the sme mask to obtain the
>> true physical address when dump vmcore.
> 
> Sorry, I have no clue what makedumpfile does exactly so you'd have to
> be more detailed (or wait until I look at it :)). Which kernel accesses
> which kernel's pagetable?
> 
> /me goes and looks at the makedumpfile's manpage...
> 

So sorry that i should provide more detail about this.
Thanks a lot for spending time reading the manpage.

> Ok, it uses vmcoreinfo to exclude pages which would mean, it accesses
> the first kernel's pagetable and traverses it.
> 
> Am I close?
> 

Yes, your explanation is perfect.

Thanks.
Lianbo
