Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAF0C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5720874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 09:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eFeWxeqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA5720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937525AbeFSJpo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 05:45:44 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:64528 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756484AbeFSJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 05:45:41 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w5J9i6pv002346;
        Tue, 19 Jun 2018 18:44:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w5J9i6pv002346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529401447;
        bh=PLRrxaU0LLf9T+tfdS7AzmbE/5f3IgvVISr8sPVyAVw=;
        h=From:To:Cc:Subject:Date:From;
        b=eFeWxeqfPisOIKmLkjBpAwJmgbAqTY5iqyRyaKNIHcevhjEFG7eh6OBwSkvYUXw14
         01xxiPYTA3z64L5k9+MweYUCB29CHMiXZhg2ZKzZlxtN+upiI9oV+PfjESKW6g6SYQ
         aRC2GuaJ4x3/lx9fn/Cn2xMKR04Yx4mmWQoqao7ko9Mco7bP/qZCFf/+j5fzxStvlo
         jHxN2sWT/Hhwsao9cEXoa8Z4aKWLHlkfBWGd8cB+zj5l5Ik5htxdtfb98zhtr9RYm+
         afVjsBFmu6k8QAlncuxD4wkYtzSdzvPFJfmN2pGqNR/GFmzrfwnbVqWlqgErZD2J+b
         SgQ9Xo72DmqEg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] x86/build: clean-up 'archprepare' and 'archclean'
Date:   Tue, 19 Jun 2018 18:43:40 +0900
Message-Id: <1529401422-28838-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean-up from the build system point of view.

The archpreapre and archclean for the x86 purgatory are unnecessary.
Kbuild can handle them in a normal way.


Masahiro Yamada (2):
  Revert "kexec: purgatory: add clean-up for purgatory directory"
  x86/build: remove unnecessary preparation for purgatory

 arch/x86/Makefile | 6 ------
 1 file changed, 6 deletions(-)

-- 
2.7.4

