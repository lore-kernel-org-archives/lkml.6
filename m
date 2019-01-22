Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EABC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8CE20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 07:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfAVHeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 02:34:12 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65129 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726423AbfAVHeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 02:34:11 -0500
X-IronPort-AV: E=Sophos;i="5.56,505,1539619200"; 
   d="scan'208";a="52559857"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Jan 2019 15:34:10 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id A91C24C4A88F;
        Tue, 22 Jan 2019 15:34:07 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 22 Jan 2019 15:34:08 +0800
Subject: Re: question about head_64.S
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <kirill.shutemov@linux.intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
Message-ID: <023da151-bb1d-1b11-ec1d-01eb675d528f@cn.fujitsu.com>
Date:   Tue, 22 Jan 2019 15:31:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6aebbf86-2ba1-c517-dc47-054279daec49@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: A91C24C4A88F.A7EAA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Kirll,

On 1/15/19 7:45 PM, Cao jin wrote:
> Hi,
>   I have been digging into this file for a while, and I still have 2
> questions unclear, hope to get your help.
> 

> 
> 2.
> Why gdt64 has following definition?:
> 
> gdt64:
> 	.word	gdt_end - gdt
> 	.long	0
> 	.word	0
> 	.quad   0
> 
> obviously, gdt64 stores the GDTR content under x86_64, which is 10 bytes
> long, so why not just:
> 
> gdt64:
> 	.word	gdt_end - gdt
> 	.quad   0
> 
> With above modification, it can boot.
> 

Seems you introduced gdt64 code in commit beebaccd50, could you help
with this question?

And it also remind me of another question about adjust_got which is also
introduced by you. Because I failed to construct a test environment with
ld version less than 2.24 until now, so I wanna do a quick ask here:
does it make sense to adjust GOT from the 4th entry of it? Because as I
know, the first 3 entries are special one, which (I guess) will be not used.
-- 
Sincerely,
Cao jin


