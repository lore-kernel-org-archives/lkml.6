Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21691C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC4392087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 01:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4392087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJKIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 04:55:49 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7526 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726007AbeJKIzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 04:55:49 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="45900142"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Oct 2018 09:30:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 060224B6ED81;
        Thu, 11 Oct 2018 09:30:56 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 11 Oct 2018 09:31:01 +0800
Date:   Thu, 11 Oct 2018 09:30:16 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <ard.biesheuvel@linaro.org>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181011013015.GA6667@localhost.localdomain>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010171616.GD5533@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181010171616.GD5533@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 060224B6ED81.AB533
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 07:16:16PM +0200, Borislav Petkov wrote:
>On Wed, Oct 10, 2018 at 04:41:16PM +0800, Chao Fan wrote:
>> In the earliest time, I tried to dig ACPI tabls to solve this problem.
>> But I didn't splite the code in 'compressed/' and ACPI code, so the patch
>> is hard to follow so refused by community.
>> Somebody suggest to add a kernel parameter to specify the
>> immovable memory so that limit kaslr in these regions. Then I make
>> a new patchset. After several versions, Ingo gave a suggestion:
>> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1634024.html
>> Follow Ingo's suggestion, imitate the ACPI code to parse the acpi
>> tables, so that the kaslr can get necessary memory information in
>> ACPI tables.
>> I think ACPI code is an independent part, so copy the codes
>> and functions to 'compressed/' directory, so that kaslr won't
>> influence the initialization of ACPI.
>
>You say "copy". I'm still about to look at the code but can those
>functions be carved out in a separate compilation unit which ACPI *and*
>KASLR can both link with so that there's no duplication?

Sorry for my poor English, I used 'copy' but they are not same.
Maybe 'imitate' is better.
Just like I said in my log, The ACPI part need to handle the map
between physical address and virtual address.
But in KASLR part, I remove these operations.
So my code is simplified version.

Thanks,
Chao Fan

>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


