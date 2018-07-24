Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD54C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF8D20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF8D20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbeGXJo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:44:27 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12480 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388559AbeGXJo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:44:27 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="42590124"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Jul 2018 16:39:01 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 283FE4B66A39;
        Tue, 24 Jul 2018 16:38:59 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Tue, 24 Jul 2018 16:38:57 +0800
Date:   Tue, 24 Jul 2018 16:36:57 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <hpa@zytor.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <keescook@chromium.org>,
        <yasu.isimatu@gmail.com>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>, <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v4 1/4] x86/boot: Add acpitb.h to help parse acpi tables
Message-ID: <20180724083657.GB818@localhost.localdomain>
References: <20180723092908.32656-1-fanc.fnst@cn.fujitsu.com>
 <20180723092908.32656-2-fanc.fnst@cn.fujitsu.com>
 <20180724060257.GE6480@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180724060257.GE6480@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 283FE4B66A39.AB313
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 02:02:57PM +0800, Baoquan He wrote:
>Hi chao,
>
>On 07/23/18 at 05:29pm, Chao Fan wrote:
>> In order to parse ACPI tables, reuse the head file linux/acpi.h,
>> so that the files in 'compressed' directory can read ACPI table
>> by including this head file.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> ---
>>  arch/x86/boot/compressed/acpitb.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>  create mode 100644 arch/x86/boot/compressed/acpitb.h
>> 
>> diff --git a/arch/x86/boot/compressed/acpitb.h b/arch/x86/boot/compressed/acpitb.h
>> new file mode 100644
>> index 000000000000..f8ab6e5b3e06
>> --- /dev/null
>> +++ b/arch/x86/boot/compressed/acpitb.h
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#include <linux/acpi.h>
>> +
>> +#define ACPI_MAX_TABLES                128
>> +
>> +/* Function to get ACPI SRAT table pointer. */
>> +struct acpi_table_header *get_acpi_srat_table(void);
>
>Since acpitb.h includes so few lines of code, not sure if we can move
>them into .c files directly.
>
>By the way, you might need to rebase this patchset on top of
>tip/x86/boot.

Sorry Baoquan,

I tried to add this patcheset to the tip/x86/boot branch using both 'patch'
command and 'git am'. I found no problem and no offset.
So is there some problems when you use them?

Thanks,
Chao Fan

>
>Thanks
>Baoquan
>
>


