Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA87BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1E320685
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qnptbl+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfAKDX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:23:59 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:59713 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfAKDX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:23:57 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0B3MdXb025916;
        Fri, 11 Jan 2019 12:22:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0B3MdXb025916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1547176960;
        bh=dHVdZkiaMCF0q2pQX0sg3OgZLXbLHfQrNIEcJS2+HS4=;
        h=From:To:Cc:Subject:Date:From;
        b=qnptbl+C1jaGrWvepQmh+NmhMRCUtbfFF6zUx4HcBIGJjrkXLqxe7U+AC0m0hXKMx
         LbaVO+dn1JclfM15kkRvwJOyx4sGBiJnN6VUKQlT5X3bb6DRGfDR/Rf/DWInKgEIIH
         EG8unbM4W1QacNMCNwvZWjoKnes5cnNDQBd57nRPHlhNWhCbrtc8yTyj4Eju7hSL7T
         YAWSDi1HT1orjal/Z5J877vNp4PAeSYIinFKUcoR56+7VZH6KZfuj1Eq8mxyzMtK66
         VFT+bL/MeFcku0JiWks8yvTc1OlTqkW9VwGuPwjMh3rvjy2d913K2cSfK608cr57cf
         d0CFFlGLuHtPw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] powerpc: some header search path cleanups
Date:   Fri, 11 Jan 2019 12:22:30 +0900
Message-Id: <1547176954-17739-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to get rid of crappy magic from Kbuild core makefiles.

Before that, I want to drop as many useless paths as possible.
Actually, many Makefiles are adding around pointless options.

This series cleans some powerpc Makefiles.
(only compile-tested by 0day bot)



Masahiro Yamada (3):
  KVM: powerpc: remove -I. header search paths
  powerpc: remove redundant header search path additions
  powerpc: math-emu: remove unneeded header search paths

 arch/powerpc/Makefile          | 4 ++--
 arch/powerpc/kvm/Makefile      | 5 -----
 arch/powerpc/math-emu/Makefile | 2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.7.4

