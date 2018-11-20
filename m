Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917D4C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B75920672
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 13:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B75920672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeKUAJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:09:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53600 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725843AbeKUAJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:09:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 275EEAF9B;
        Tue, 20 Nov 2018 13:40:09 +0000 (UTC)
Date:   Tue, 20 Nov 2018 14:40:07 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Backed up kernels
Message-ID: <20181120144007.016e4998@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro, Michal,

When I run "make install", if a kernel by the same version number +
flavor string already exists, a backup is created with ".old" appended.
Over time, this adds many entries to my boot menu, makes some package
updates take much longer (e.g. when all initrds must be regenerated),
and ultimately confuses grub2, which fails to find the matching modules
directory under /lib/modules.

You could argue that grub2 could be fixed to find the right modules
directory, but in fact there is no guarantee that the modules built for
the new kernel are fully compatible with the old kernel. Keeping a
backup copy of the old modules is also not possible, because both
kernels have the same $(uname -r) and therefore the modules of both
kernels must live under the same /lib/modules/$(uname -r), which
collides.

Given that, is there really any practical value in saving a backup of
old kernels? I'm doing kernel development for 15 years and I can't
remember ever booting one of these ".old" kernels. If my latest
development kernel doesn't work for any reason, I will just boot back
to the distribution kernel.

Therefore I am asking, can we change "make install" so that it does NOT
create a backup copy of an existing kernel?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
