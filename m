Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B88ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AAD206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 20:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AAD206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeKIGD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:03:26 -0500
Received: from mout.gmx.net ([212.227.15.15]:50305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725723AbeKIGD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:03:26 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0MQiVh-1fvvTW0Kfl-00U0zw; Thu, 08 Nov 2018 21:26:07 +0100
Message-ID: <1541708719.12945.2.camel@gmx.us>
Subject: BUG: KASAN: slab-out-of-bounds in cts_cbc_encrypt+0xec/0x3c0
From:   Qian Cai <cai@gmx.us>
To:     linux-kernel@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Date:   Thu, 08 Nov 2018 15:25:19 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EhR9gZcI7kOZSGMKgX86ZXq7/hCTgrDp9HCM/rpzwabldd8kSDo
 9GVI8b/cqjqTJXpPzjN8OO3ggXdhmMq7rpQVsVhJPQkZN4xULhFLU1Lo0Zk9ve4f+3UBQ9f
 1FGsWftafHHjSJXXuQVVPXNvXD6xVeFjlB//R0AFP79vhEzCJ1Q5cS2UfoXRkH0I+mHfALO
 823i9jnWNk9XPmuv4yVIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aHDBJnjCduw=:PzeRA/dpieOlCcg+sSS0uJ
 tGUiHJamwObQsZAEf8VNFrl1JO50ESvW1Fbw0RB/NPsnh3LhN8gQa0CCS62PGS2EbEXF2h8MD
 7HyXo8McR2lAuzQ9ei/K79mRAWZaWSCnFaDIiQmCtxDi34nFZ0MukkYAfDlw8BCo5WdEuNNR+
 6AcLjRZmzBdPvqMVp3WlkiF+kmHvUq07pJI2Fx45YJRTwJrKaHjubIFPz0zz0vwBaXh0Cg7IC
 IqScwxAbX7BtQDKPt9q8KSbSdMco7DSewgIEFbazyKZuHiKgO6qcwX4T+eIBpatXuPxYRN21U
 s+rMqdNTeVScFEHk1Zt1F3/bmNq+48aqOri0oTWiLahEMjr1BV0GTFkG41l6CJaEUpjT6Z1QL
 weKLMa8zYB966XbSoMpNQgeN2C52igeLPzykTfSBYmr3lbV/QCPJvOw8haLEiuP7Bdk1nu6JW
 AiAUsjCO9DK49S1Ld4308JLa/+Jo5q+U2pruWYvfE/L/2olI+DCjchoqV9WudJt6ob67RNFTe
 aLXB7tT3tlTNeOAq4/ow7n7KX4SBCWARh6tFx8NgVdEuh39rcvyAP0Nyu22tGmRFIX0bnu7/U
 NxC0+Qf/42A95de+HIlEsZDH5dygBxm04O0H9JEclc7xLA8uvF+aNC+jCJ3PXNmVEJsBtR7bF
 OirlvBJM3k4txPIpXYa1KtabsZlZebN6ahmEZmbceFkRhE8FWTbCBblF1iSYBZhfonj8v7j5Z
 BBpNdlueZjisjC9qkoYpIPugDhIfGgN5Ai+2+55zBDXPjezTPUcoT4S0MmaBJ/BHz7+nYRcGW
 kfwDOCgQCySnceKEhVCGvM9AGlliKsfO+HeMupvIS89shd4eLTdqeqokzOP+TBr204671j7pl
 709jG2F78KMw5SYG1+GvxhR2E0crheBVlnicn8j7BecBzN6skz1s6Msm9CcXoF
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just booting up the latest git master (b00d209) on an aarch64 server and saw
this.

[   42.448373] BUG: KASAN: slab-out-of-bounds in cts_cbc_encrypt+0xec/0x3c0
[   42.455157] Write of size 8 at addr ffff801dd06aaa40 by task
cryptomgr_test/409

[   42.464065] CPU: 3 PID: 409 Comm: cryptomgr_test Tainted: G        W       T
4.20.0-rc1+ #6
[   42.472517] Hardware name: Huawei TaiShan 2280 /BC11SPCD, BIOS 1.50
06/01/2018
[   42.479826] Call trace:
[   42.482306]  dump_backtrace+0x0/0x248
[   42.486014]  show_stack+0x24/0x30
[   42.489372]  dump_stack+0xb8/0xf4
[   42.492730]  print_address_description+0x68/0x2b8
[   42.497492]  kasan_report+0x22c/0x340
[   42.501199]  __asan_store8+0x90/0xa0
[   42.504818]  cts_cbc_encrypt+0xec/0x3c0
[   42.508703]  simd_skcipher_encrypt+0xc4/0x198
[   42.513115]  __test_skcipher+0x6d4/0x1030
[   42.517173]  test_skcipher+0x48/0xf0
[   42.520793]  alg_test_skcipher+0x78/0x110
[   42.524852]  alg_test.part.6+0x238/0x4e8
[   42.528823]  alg_test+0x60/0xa8
[   42.532002]  cryptomgr_test+0x5c/0x68
[   42.535710]  kthread+0x18c/0x1d0
[   42.538977]  ret_from_fork+0x10/0x18

[   42.544102] Allocated by task 409:
[   42.547547]  kasan_kmalloc+0xd8/0x188
[   42.551254]  __kmalloc+0x1f8/0x470
[   42.554698]  __test_skcipher+0x18c/0x1030
[   42.558757]  test_skcipher+0x48/0xf0
[   42.562376]  alg_test_skcipher+0x78/0x110
[   42.566435]  alg_test.part.6+0x238/0x4e8
[   42.570406]  alg_test+0x60/0xa8
[   42.573586]  cryptomgr_test+0x5c/0x68
[   42.577293]  kthread+0x18c/0x1d0
[   42.580560]  ret_from_fork+0x10/0x18

[   42.585684] Freed by task 0:
[   42.588597] (stack is not available)

[   42.593722] The buggy address belongs to the object at ffff801dd06aa880
 which belongs to the cache kmalloc-512 of size 512
[   42.606397] The buggy address is located 448 bytes inside of
 512-byte region [ffff801dd06aa880, ffff801dd06aaa80)
[   42.618277] The buggy address belongs to the page:
[   42.623127] page:ffff7fe007741a80 count:1 mapcount:0 mapping:ffff801dc0010880
index:0xffff801dd06a5880
[   42.632548] flags: 0x1fffff0000000200(slab)
[   42.636785] raw: 1fffff0000000200 ffff801dc000fac0 ffff801dc000fac0
ffff801dc0010880
[   42.644625] raw: ffff801dd06a5880 000000000040002c 00000001ffffffff
0000000000000000
[   42.652461] page dumped because: kasan: bad access detected

[   42.659606] Memory state around the buggy address:
[   42.664455]  ffff801dd06aa900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00
[   42.671765]  ffff801dd06aa980: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
fc
[   42.679075] >ffff801dd06aaa00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
fc
[   42.686383]                                            ^
[   42.691759]  ffff801dd06aaa80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
fc
[   42.699069]  ffff801dd06aab00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
fc
[   42.706377]
==================================================================

Any idea?
