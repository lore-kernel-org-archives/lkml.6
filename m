Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4845C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A078208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A078208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbeJROIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:08:48 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52024 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727496AbeJROIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:08:48 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46308327"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Oct 2018 14:09:24 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 49CB74B5CBE6;
        Thu, 18 Oct 2018 14:09:24 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 18 Oct 2018 14:09:31 +0800
Date:   Thu, 18 Oct 2018 14:08:47 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Baoquan He <bhe@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <hpa@zytor.com>, <keescook@chromium.org>, <msys.mizuma@gmail.com>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 2/8] x86/boot: Copy kstrtoull() to compressed period
Message-ID: <20181018060846.GH12871@localhost.localdomain>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-3-fanc.fnst@cn.fujitsu.com>
 <20181018040338.GC1885@192.168.1.4>
 <20181018055158.GD12871@localhost.localdomain>
 <20181018060128.GH1885@192.168.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018060128.GH1885@192.168.1.4>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 49CB74B5CBE6.AD91E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 02:01:28PM +0800, Baoquan He wrote:
>On 10/18/18 at 01:51pm, Chao Fan wrote:
>> On Thu, Oct 18, 2018 at 12:03:38PM +0800, Baoquan He wrote:
>> >On 10/17/18 at 06:20pm, Chao Fan wrote:
>> >> Copy kstrtoull() to 'compressed' directory so that
>> >> we can use it to change the address in cmdline from
>> >> string to unsigned long long.
>> >
>> >So you don't like simple_strtoull() in arch/x86/boot/string.c which has
>> >been used in boot/compressed/kaslr.c . Why? Are you going to clean up
>> >simple_strtoull()?
>> 
>> Boris told me use the new function in old version's review.
>> Both work well for me.
>
>OK, then maybe you can clear simple_strtoull() out in a separate patch
>since you have introduced a new one. Or after this patchset.

Yes, after this patchset, some cleanup will be needed.

Thanks,
Chao Fan
>
>


