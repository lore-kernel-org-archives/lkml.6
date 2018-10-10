Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9123EC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BE520645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29BE520645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbeJJQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:33:40 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:8922 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbeJJQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:33:40 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="45872593"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 10 Oct 2018 17:12:22 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id D8DDC4B6ED74;
        Wed, 10 Oct 2018 17:12:23 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 10 Oct 2018 17:12:29 +0800
Date:   Wed, 10 Oct 2018 17:12:05 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <mingo@redhat.com>, <hpa@zytor.com>, <keescook@chromium.org>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <ard.biesheuvel@linaro.org>, <indou.takao@jp.fujitsu.com>,
        <caoj.fnst@cn.fujitsu.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
Subject: Re: [PATCH v8 0/3] x86/boot/KASLR: Parse ACPI table and limit kaslr
 in immovable memory
Message-ID: <20181010091205.GA10618@localhost.localdomain>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010085920.GB5533@zn.tnic>
 <20181010090620.GF25297@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181010090620.GF25297@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: D8DDC4B6ED74.A01E6
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:06:20PM +0800, Baoquan He wrote:
>Hi Boris,
>
>On 10/10/18 at 10:59am, Borislav Petkov wrote:
>> ... and we just picked up
>> 
>> https://lkml.kernel.org/r/20181001140843.26137-1-msys.mizuma@gmail.com
>> 
>> and without having looked at the rest of your stuff, if people accept
>> your solution, we don't need the silly parameter anymore, right?
>> 
>> Which means, we should not rush the whole thing yet until the whole
>> KASLR vs movable memory gets solved properly.
>
>Masa's patches solves the problem in memory region KASLR which later hot
>added memory may be big than the default padding 10 TB.
>
>Chao's patches is trying to fix a conflict between 'movable_node' and
>kernel text KASLR. If 'movable_node' specified, we rely on SRAT to get
>which memory region is movable or immovable, and movable region can be
>hot removed. But if kernel is randomized into movable memory, it can't
>be hot removed any more, this is a regression after KASLR introduced.
>So this is a different issue than Masa's.

Yes, they are two issues.
But if we can get more memory information by the function in
the new file acpi.c, semms it's helfpul to Masa's issue.

Thanks,
Chao Fan

>
>Thanks
>Baoquan
>
>


