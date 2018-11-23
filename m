Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BD7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816E20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1816E20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lio96.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440301AbeKXCZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:25:34 -0500
Received: from er-systems.de ([148.251.68.21]:42998 "EHLO er-systems.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440273AbeKXCZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:25:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 49EB7D60075;
        Fri, 23 Nov 2018 16:40:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id 1EFF7D60073;
        Fri, 23 Nov 2018 16:40:48 +0100 (CET)
Date:   Fri, 23 Nov 2018 16:40:47 +0100 (CET)
From:   Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
In-Reply-To: <20181123065143.GC23835@kroah.com>
Message-ID: <alpine.LSU.2.21.1811231636220.17615@er-systems.de>
References: <20181121183147.869199006@linuxfoundation.org> <alpine.LSU.2.21.1811222148260.12239@er-systems.de> <20181123065143.GC23835@kroah.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-74181308-1594332927-1542987648=:17615"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.100.2/25146/Fri Nov 23 15:18:52 2018 signatures 58.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---74181308-1594332927-1542987648=:17615
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 23 Nov 2018, Greg Kroah-Hartman wrote:

> On Thu, Nov 22, 2018 at 09:53:35PM +0100, Thomas Voegtle wrote:
>>
>> Doesn't compile for me on OpenSuSE 15.0 (gcc 7.3.1):
>>
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   CC [M]  drivers/gpu/drm/i915/i915_gem_gtt.o
>> drivers/gpu/drm/i915/i915_gem_gtt.c: In function ‘gen6_dump_ppgtt’:
>> drivers/gpu/drm/i915/i915_gem_gtt.c:1771:41: error: format ‘%llx’ expects
>> argument of type ‘long long unsigned int’, but argument 5 has type ‘long
>> unsigned int’ [-Werror=format=]
>>     seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
>>                                     ~~~~~^
>>                                     %08lx
>> cc1: all warnings being treated as errors
>
> Warnings treated as errors?  That's rough, sorry, don't do that :)

I had CONFIG_DRM_I915_WERROR=y for whatever reason. 
The whole thing confused me a lot.
Sorry.

       Thomas

---74181308-1594332927-1542987648=:17615--

