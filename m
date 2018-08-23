Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9269AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B4C20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B4C20C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeHWLBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:01:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:41185 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726068AbeHWLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:01:22 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="43835116"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 23 Aug 2018 15:33:04 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0F9D74B69E17;
        Thu, 23 Aug 2018 15:33:00 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 23 Aug 2018 15:33:06 +0800
Date:   Thu, 23 Aug 2018 15:30:15 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <n-horiguchi@ah.jp.nec.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>,
        <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v5 3/4] x86/boot/KASLR: Walk srat tables to filter
 immovable memory
Message-ID: <20180823073015.GB6769@localhost.localdomain>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-4-fanc.fnst@cn.fujitsu.com>
 <20180823072535.GL29313@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180823072535.GL29313@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 0F9D74B69E17.ABC5B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 03:25:35PM +0800, Baoquan He wrote:
[...]
>> +static void handle_immovable_mem(void)
>> +{
>> +	char *args = (char *)get_cmd_line_ptr();
>> +	struct acpi_table_header *table_header;
>> +	struct acpi_subtable_header *table;
>> +	struct acpi_srat_mem_affinity *ma;
>> +	unsigned long table_end;
>> +	int i = 0;
>> +
>> +	if (!strstr(args, "movable_node"))
>
>If 'acpi=off' specified, better return too here.

Thanks, you are right.
Yes, I will think about it and add it to a suitable place.
May the position where we try to get the acpi table is better.
Or just here is also OK.

Thanks,
Chao Fan

>



