Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBCCC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1803B21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 23:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfADXN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 18:13:26 -0500
Received: from atl4mhob21.registeredsite.com ([209.17.115.115]:35132 "EHLO
        atl4mhob21.registeredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfADXNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 18:13:25 -0500
Received: from mailpod.hostingplatform.com (atl4qobmail01pod2.registeredsite.com [10.30.77.35])
        by atl4mhob21.registeredsite.com (8.14.4/8.14.4) with ESMTP id x04NDNCH193618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 4 Jan 2019 18:13:23 -0500
Received: (qmail 40682 invoked by uid 0); 4 Jan 2019 23:13:23 -0000
X-TCPREMOTEIP: 174.118.245.214
X-Authenticated-UID: dclarke@blastwave.org
Received: from unknown (HELO ?172.16.35.3?) (dclarke@blastwave.org@174.118.245.214)
  by 0 with ESMTPA; 4 Jan 2019 23:13:23 -0000
To:     linux-kernel@vger.kernel.org
From:   Dennis Clarke <dclarke@blastwave.org>
Subject: arch/x86/platform/olpc/olpc-xo1-pm.c:159: undefined reference to
 `mfd_cell_disable'
Message-ID: <eaa688b4-b976-bd8c-01e0-0e5e43ee657c@blastwave.org>
Date:   Fri, 4 Jan 2019 18:13:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In 4.19.13 I was surprised to see :

ld: arch/x86/platform/olpc/olpc-xo1-pm.o: in function `xo1_pm_remove':
/usr/local/build/linux_kernel/linux-4.19.13_20190102221644/arch/x86/platform/olpc/olpc-xo1-pm.c:159: 
undefined reference to `mfd_cell_disable'
ld: arch/x86/platform/olpc/olpc-xo1-pm.o: in function `xo1_pm_probe':
/usr/local/build/linux_kernel/linux-4.19.13_20190102221644/arch/x86/platform/olpc/olpc-xo1-pm.c:133: 
undefined reference to `mfd_cell_enable'
gmake: *** [Makefile:1032: vmlinux] Error 1
Command exited with non-zero status 2

Which seems to be defined in drivers/mfd/mfd-core.c :

https://github.com/torvalds/linux/blob/6f0d349d922ba44e4348a17a78ea51b7135965b1/drivers/mfd/mfd-core.c

Seems odd given that #include <linux/mfd/core.h> is in both 
arch/x86/platform/olpc/olpc-xo1-pm.c and also 
arch/x86/platform/olpc/olpc-xo1-sci.c and not sure where the issue is 
however I have seen this twice
now. I'll hunt around and see if I can find where the issue is.

Dennis Clarke
