Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C338C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC6A214FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC6A214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJQJDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:03:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64997 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726430AbeJQJDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:03:54 -0400
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200"; 
   d="scan'208";a="46234779"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 17 Oct 2018 09:10:46 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 9C4774B6ED69;
        Wed, 17 Oct 2018 09:10:41 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 17 Oct 2018 09:10:46 +0800
Date:   Wed, 17 Oct 2018 09:10:01 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-efi@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <keescook@chromium.org>, <bhe@redhat.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <ard.biesheuvel@linaro.org>,
        <indou.takao@jp.fujitsu.com>, <caoj.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v8 1/3] x86/boot: Add acpitb.c to parse acpi tables
Message-ID: <20181017011001.GB12871@localhost.localdomain>
References: <20181010084119.17539-1-fanc.fnst@cn.fujitsu.com>
 <20181010084119.17539-2-fanc.fnst@cn.fujitsu.com>
 <20181011105708.GB25435@zn.tnic>
 <20181016024844.GA12871@localhost.localdomain>
 <20181016124036.GG5212@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181016124036.GG5212@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: 9C4774B6ED69.AE372
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:40:36PM +0200, Borislav Petkov wrote:
>On Tue, Oct 16, 2018 at 10:48:44AM +0800, Chao Fan wrote:
>> Sorry for disturbing you again, I want to make sure this detail with you.
>> You mean that I need splite this as a function and put it to
>> cmdline.c, right?
>
>Extract that functionality into a generic helper so that
>handle_mem_options() and your get_acpi_rsdp() can call it instead
>of duplicating the code. Also, why aren't they both using
>cmdline_find_option() directly?

Yes, I found cmdline_find_option() is enough for me.

Thanks,
Chao Fan

>
>If something's missing, extend cmdline_find_option() to serve your
>purposes too instead of copying the same code.
>
>Make more sense?
>
>-- 
>Regards/Gruss,
>    Boris.
>
>Good mailing practices for 400: avoid top-posting and trim the reply.
>
>


