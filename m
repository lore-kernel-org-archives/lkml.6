Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AF0C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C1320837
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eihCPtD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C1320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeIAV4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 17:56:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42880 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbeIAV4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 17:56:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id g23-v6so6834775plq.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=99FIWNDPiuMpCpXrUPd45LrW57/iG0XGhjC7ka4YtuA=;
        b=eihCPtD/vKOpTs32LZtGJFQuzco+ggI4VOnjr7YOy+mjVTNxtWZ+vpII70yxfO5jhZ
         8Voa/gnip7ThTv5hOgVATwRcxLLm/3cOnYdLewkaZT2y3i4e0phLBOzCEre50uZGj+qA
         co0xv6keM7axjMt8rv5mW8x/imouL3HbjpybPzMNUBcM+r8SborWxH2pIeHPVWO07C1L
         7H0zKSFIbhZDr5ozHZ4oNsF8I4YqSpaUy6r2wxURjtdk24UJV0VyuGALntZziP2THCUd
         rdC3GicVROE+lHO/OEBjhzweU0XK3nOr4Zk3m5Jeujwzi3/enz3kl5VeTFfsBTDHf6zm
         J6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=99FIWNDPiuMpCpXrUPd45LrW57/iG0XGhjC7ka4YtuA=;
        b=JucpH1LVkNSsBgccMHLjzCtSNzVdIBWgxuYxQuOSHGtNbktcKTpirGATM4LIpU8H0H
         YgbGuqlYIIQ1YwZxKjojOpeQySNnMT9FkcYIzb5sDXwpfxzhMPeKjqO0y2athVQapbLe
         DweGmK01KReQfpgEUCqY+Wvx0Yl1XzojfqPlYXAHymVgJXUaHvz6/CKyigEGpsTFkKHA
         2gaTquuEyNXX4Fffa4om3BJ0B6ytN3i6llA8Zb9MY4eMv50CFCrHX/SP3ncQGL2XVXQV
         RQZzChrBAEWQ4qj0SkXHq7njw6n0ofsCfQemNE23g9m1n3B8YmdzHOTo9zZlGE9K1Y/8
         JAHg==
X-Gm-Message-State: APzg51CXT4ZXDs7SsUoHe//dl2hibexSZj03jUct3k5riE1wbz2DSoYW
        IyDPN/XpglFUrPHwtDzaOCw=
X-Google-Smtp-Source: ANB0VdYizCFasaFDXNmhDpuKJ3k5Q4/Y9+kd6gFB5jedNFEpUngtY7vQDqxgYH+4za7NHjipWQ5vrA==
X-Received: by 2002:a17:902:22e:: with SMTP id 43-v6mr21116549plc.118.1535823835889;
        Sat, 01 Sep 2018 10:43:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c1-v6sm28951179pfg.25.2018.09.01.10.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 10:43:54 -0700 (PDT)
Date:   Sat, 1 Sep 2018 10:43:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] y2038: Remove newstat family from default syscall set
Message-ID: <20180901174353.GA14271@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Apr 13, 2018 at 11:50:12AM +0200, Arnd Bergmann wrote:
> We have four generations of stat() syscalls:
> - the oldstat syscalls that are only used on the older architectures
> - the newstat family that is used on all 64-bit architectures but
>   lacked support for large files on 32-bit architectures.
> - the stat64 family that is used mostly on 32-bit architectures to
>   replace newstat
> - statx() to replace all of the above, adding 64-bit timestamps among
>   other things.
> 
> We already compile stat64 only on those architectures that need it,
> but newstat is always built, including on those that don't reference
> it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
> __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
> newstat. All architectures that need it use an explict define, the
> others now get a little bit smaller, and future architecture (including
> 64-bit targets) won't ever see it.
> 

This patch causes my riscv boot tests to crash in -next

sbin/init: error while loading shared libraries: libc.so.6: cannot stat shared object: Error 38
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00

The following change fixes the problem for me, but of course I have no idea
if it is correct. Copying RISC-V maintainers for input.

Guenter

---
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 0caea01d5cca..eff7aa9aa163 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -16,6 +16,7 @@
  * be included multiple times.  See uapi/asm/syscalls.h for more info.
  */
 
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 #include <uapi/asm/syscalls.h>
