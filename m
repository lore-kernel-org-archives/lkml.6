Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C24C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC82175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEC82175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbeHCPG4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:06:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:45008 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729854AbeHCPG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:06:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B578AD1E;
        Fri,  3 Aug 2018 13:10:38 +0000 (UTC)
Date:   Fri, 3 Aug 2018 15:10:35 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alistair Strachan <astrachan@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Stellar <tstellar@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>
Subject: native_save_fl() causes a warning
Message-ID: <20180803151035.238a19d2@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

It seems that this linux kernel commit of yours:

commit d0a8d9378d16eb3c69bd8e6d23779fbdbee3a8c7
Author: Nick Desaulniers
Date:   Thu Jun 21 09:23:24 2018 -0700

    x86/paravirt: Make native_save_fl() extern inline

introduced a new warning (with W=1):

./arch/x86/include/asm/irqflags.h:16:29: warning: no previous prototype for ‘native_save_fl’ [-Wmissing-prototypes]
 extern inline unsigned long native_save_fl(void)
                             ^

Please fix it.

Secondly, I am quite curious why you changed only native_save_fl() from
static inline to extern inline, when native_restore_fl(),
native_irq_disable() and native_irq_enable() are equally referenced by
address in arch/x86/kernel/paravirt.c and thus should suffer from the
same problem. Can you explain?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
