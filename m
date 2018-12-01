Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B85C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF83120834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 06:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF83120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLARRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 12:17:45 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38864 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726124AbeLARRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 12:17:44 -0500
X-IronPort-AV: E=Sophos;i="5.56,300,1539619200"; 
   d="scan'208";a="48892017"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Dec 2018 14:05:57 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 092524B6ED63;
        Sat,  1 Dec 2018 14:05:54 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 1 Dec 2018 14:05:55 +0800
Date:   Sat, 1 Dec 2018 14:05:39 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <bp@alien8.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v12 1/5] x86/boot: Add get_acpi_rsdp() to parse RSDP in
 cmdline from KEXEC
Message-ID: <20181201060539.GD30941@localhost.localdomain>
References: <20181129081631.11139-1-fanc.fnst@cn.fujitsu.com>
 <20181129081631.11139-2-fanc.fnst@cn.fujitsu.com>
 <20181129211003.saxfvyboxpsn5mdr@gabell>
 <20181130024346.GB30941@localhost.localdomain>
 <20181130173515.6zx5wvs52s5aqnge@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181130173515.6zx5wvs52s5aqnge@gabell>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 092524B6ED63.A996A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 12:35:16PM -0500, Masayoshi Mizuma wrote:
>On Fri, Nov 30, 2018 at 10:43:47AM +0800, Chao Fan wrote:
>...
>> >]$ make arch/x86/boot/compressed/misc.o
>> >  CALL    scripts/checksyscalls.sh
>> >  DESCEND  objtool
>> >  CC      arch/x86/boot/compressed/misc.o
>> >ld: -r and -pie may not be used together
>> >make[1]: *** [scripts/Makefile.build:294: arch/x86/boot/compressed/misc.o] Error 1
>> >make: *** [Makefile:1715: arch/x86/boot/compressed/misc.o] Error 2
>> >]$
>> 
>> Hi Masa,
>> 
>> So many thanks for your test.
>> 
>> Could you give me more details about this error? More error message.
>> Just on the first commit or the whole PATCHSET?
>> Cause I didn't get error both on this commit and on the whole PATCHSET.
>
>I built your whole patchset and got the error.
>The error depends on CONFIG_MODVERSIONS.
>If CONFIG_MODVERSIONS=y, you will get the build error.

Hi Masa,

Thanks, after that, I got the error.
About your solution, it can fix the error. But I am not sure whether
it's good.

Boris and Baoquan,
How do you think this issue.

Thanks,
Chao Fan

>
>Thanks,
>Masa
>
>


