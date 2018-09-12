Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B59C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UQrKiXtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECF720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbeILVvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:51:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34915 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbeILVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:51:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so1300021pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=9wP8+9i5XJMvzEOFa+si4rgDR5ROxmCGUsjpVlLxVtM=;
        b=UQrKiXtGD3p4HXeX3sedmPK2UKvudNsO1sfpzd99ouN/C9ezDJ8G9+EFH5P5PrpZZT
         KwIOiMvSF+8jOdic/jMthd2luIJv5cm3fIqb6uDz7lstNlQbC1jDUyRLHZs9UDE9ZWIo
         vZQHlDSeBZel+RWY82GVfPMLGVKhwdgfH/B8KKzx+Q3eI0HWKBzWGhewoObD9s2YIPpt
         6BwbAvvfXmvMQqYx9LyVzUf6b5zoZdCQrvb4xoeEOpyyrt6Rj5LMstdGHDer4oBJ+8kc
         +6LKw65/6It6NKK5FrCpvI679zmmGlcY5QT83lEy1mhEOwXV0sCYOO5RdGrExm2v7Zxm
         9ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=9wP8+9i5XJMvzEOFa+si4rgDR5ROxmCGUsjpVlLxVtM=;
        b=T6L/IZL5chbI5ohBSVnOhVmlJFwDX4PbSP+6aniaQK+9AP0K3DP7hZnw9kT6hqcwP2
         Y0lfHTlRw+c2CbPITG4Pr91mKLug8QL3ID1CtoMvEnDey/HVFjYym1iTQ7NaRBEMzQwk
         w5FmjdYWfZdtxI+Vc5ltEOLm01iPcGVm3aQshOuVZpckklt+1N6V6vBnr4iFYhrKuzDh
         1wYr6D+fgGj8rSvMF3WhGOmRh/jWdpx163JqIojBLFhc6F5RfC0tDhkPjx+U5WgmjbQK
         lzYvW9Va0YqJILsiar+0bUdE+Bqw/gJuvKiPcSIpopc4HafUtBCLFn5jPTS7UOlwkgCc
         Jltw==
X-Gm-Message-State: APzg51DTRf1i6gtf2V3HyybCfrugDr9+EwbXMAkPg+1BTtaqLYTXAXcM
        mtEEOzCkoB7Zm62Subsuu29NJGHNrRU=
X-Google-Smtp-Source: ANB0VdYR0eRBY0k5X5JrhM0jOkflnCV8tsljGYbZwOehf+HVnbeAPijJ2qauNAoxLm4fOzt28R2FOw==
X-Received: by 2002:a62:3909:: with SMTP id g9-v6mr3365313pfa.176.1536770747568;
        Wed, 12 Sep 2018 09:45:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id f13-v6sm1999117pgs.92.2018.09.12.09.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 09:45:46 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:45:46 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Sep 2018 09:45:43 PDT (-0700)
Subject: [GIT PULL] RISC-V: A single fix for 4.19-rc3
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-2cf2fc4d-085f-4974-96ad-e27b240611d6@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to send this out last week as I was going to the GNU tool cauldron.  I
haven't gotten through my backlog yet so I don't have any other patches for
this RC, so I figured I'd just send out the old tag.  If that's an issue I can
make a new one.

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.19-rc3

for you to fetch changes up to e866d3e84eb7c9588afb77604d417e8cc49fe216:

  riscv: Do not overwrite initrd_start and initrd_end (2018-09-04 17:04:50 -0700)

----------------------------------------------------------------
RISC-V: A single fix for 4.19-rc3

This tag contains what I hope to be the last RISC-V patch for 4.19.  It
fixes a bug in our initramfs support by removing some broken and
obselete code.

----------------------------------------------------------------
Guenter Roeck (1):
      riscv: Do not overwrite initrd_start and initrd_end

 arch/riscv/kernel/setup.c | 7 -------
 1 file changed, 7 deletions(-)
