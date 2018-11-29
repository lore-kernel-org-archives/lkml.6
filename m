Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B328AC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6782081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6782081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeK2OvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:51:17 -0500
Received: from mout.gmx.net ([212.227.17.20]:38681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbeK2OvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:51:17 -0500
Received: from ovpn-120-189.rdu2.redhat.com ([98.118.28.103]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0McEDD-1g8csY0XFX-00Jc4N; Thu, 29 Nov 2018 04:47:21 +0100
To:     ard.biesheuvel@linaro.org
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Qian Cai <cai@gmx.us>
Subject: kmemleak reports leaking in efi_mem_reserve_persistent()
Message-ID: <983f2d06-04d1-e309-c3a6-965aa6b61eb4@gmx.us>
Date:   Wed, 28 Nov 2018 22:47:19 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OO0J9WJmrGfGhXWoZwkeNvfY7JCrIAz1tDouljxZACmY8aCCLRG
 kY35A/6oQLiTzI8VvyF8nFYy4Aoz8lQpOneIBf4lex/trn/4VmXiJmJAhdjrvCNYI5rkIq2
 EZ1yYxbRcBaXpYrT5tHp1YnzzwMihMSgm+CATBHr0xZ6NGYNYVgGAnwBbxlA8U0+2QEK43w
 dseOhgKfBMra/n8oB5FWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qkrh+GrFsJ4=:F/SWjoB0iWezy1dT+gQDYq
 oADDDWVQ3PTaDGJ7PqGHjRIS0ti2/fHGzlY47DMePfUe9aJUTnCXMYaLQPB+15lnZTUmCaMea
 Vo0tyF2NPDy5Yk+BVaMNRV81gzYAndhywxDZYbIkOD4PyyhREhBmqOL+dqSEz9eSQuCwwHUi2
 eH7PPGe48W62S0+UMxkSzbgmnAd7vK75evJ5hEUNgwbt3gf9RGS9CmYvMyNx6SNFP2JIj/vUk
 eWRhtwmbvt1aJPwZpddhaFPtXASlvd+tEEEWgwn8au5+rONefR/fZdtg43xsC57En+dgaOaOj
 NiggtcktuAxQxNVu5fklw/oaZWFu/5Jr4iy277p4y8QJYg7kxcMxhs7+I4c2as4/+5NR3BoNc
 FWl6d18TAlSaetTMstlgmaiSl+luqHUyOscj2+eVQrzj4lXGoGeKkc35OgRe4Q4qlurWZVxVX
 qRfhaZTMXy/phBL7Fcs54i8Ra3sEi57+arFuKYNBshhAG3UYf7jzN1pYaGoQt/RI3wWXPfJI0
 ht644x21IShahALnl/JTiK44SRM1kGbokNLTKakIB8dQLejRsO7mE7w8KuWMSICzkAsPjxSVN
 ig2ZWXL0cHlkM/oGn3eCw5SAwFeJBFftGdTvYQXFS8nko0ahuxzpDATr9w95DVXjp0gCImOjO
 w0GJrNlnfD/WFvbXrWaR6iHi3qqaoetzR1Rj4IESsIMfnSkJQn4CXq9IPykHBmR6IgcNs33i6
 /ydZinDd1tcmd1mV13AqvL/+gEsxQkgIFLA3Rcw6zKnco7mjvJKuLS8rKex0AMRITRLXNuMLR
 +aIzzLPW2dyOjEHP8vUPFDXjdU1iOAwzEPOnOiRz3zcey4OovZ94ular58z0+3WI1xSDhEwLx
 hbPxaWelShZaOi4WcFr73NPst0gcvouOsrWgSDR1PoxRFk/SPa9L3wmVkY2m0W
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unreferenced object 0xffff8096c1acf580 (size 128):
  comm "swapper/63", pid 0, jiffies 4294937418 (age 1201.230s)
  hex dump (first 32 bytes):
    80 87 b5 c1 96 00 00 00 00 00 cc c2 16 00 00 00  ................
    00 00 01 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
  backtrace:
    [<000000001d2549ba>] kmem_cache_alloc_trace+0x430/0x500
    [<0000000093a6dfab>] efi_mem_reserve_persistent+0x50/0xf8
    [<000000000a730828>] its_cpu_init_lpis+0x394/0x4b8
    [<00000000edf04e07>] its_cpu_init+0x104/0x150
    [<000000004d0342c5>] gic_starting_cpu+0x34/0x40
    [<000000005d9da772>] cpuhp_invoke_callback+0x228/0x1d68
    [<0000000061eace9b>] notify_cpu_starting+0xc0/0x118
    [<0000000048bc2dc5>] secondary_start_kernel+0x23c/0x3b0
    [<0000000015137d6a>] 0xffffffffffffffff

# ./scripts/faddr2line vmlinux efi_mem_reserve_persistent+0x50/0xf8
efi_mem_reserve_persistent+0x50/0xf8:
kmalloc at include/linux/slab.h:546
(inlined by) efi_mem_reserve_persistent at drivers/firmware/efi/efi.c:979

This line,

rsv = kmalloc(sizeof(*rsv), GFP_ATOMIC);

I didn't see anything obviously. Is it just a false positive?
