Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1385ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7675E20820
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jwwRHiUD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7675E20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbeKBLYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 07:24:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33938 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKBLYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 07:24:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id a132so875919qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:cc:from:to:message-id;
        bh=og2f4Mjnq+O5R9oN9TwRI4yCSScumQBGymtGP23YD1M=;
        b=jwwRHiUDCFJyS1J+uGUzMZjMMmvax2KIt1Frrc6BNUZ1D5p36NPZ9M8Kjcj+4ZFGtk
         DWrZK2+2UitfGpEkS6/+oK9RW5P1PyASYkrIZZ9DSOM81cGHoOFtFE7aRkjDR5O2ISPZ
         +hoMQ9C+iwHYLuc8hQ7td+tX9LPQGAfTmNGF9uQsLf3rUAZ7l3PoTM1Nlr5WnPW2E9BK
         4v/FovHxJ7/smjkUjYmTnPf6lAz72tJBPKRFAGI6J2wHhtbOjsl8zkCOpnTA4bFihAWn
         PVpBS+pnVcgiQ5oa7xW+ou0d2enc5eYSZT9PkWUKSAbInKp8XiPxQAUn9Yvfb3m5+OkA
         Gdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=og2f4Mjnq+O5R9oN9TwRI4yCSScumQBGymtGP23YD1M=;
        b=ah/GHKB0ofase1/gm+x2QJMYNmDQoSFDA19ZN/iXcfeLETB9fFxwy9tGnxmcaBueON
         HStVRJIoeKbwroNNBgGPRrsyYS2KzD6YAB1TBeHjdrO2588rDerBOMyCDw9exvR/HPrv
         7tHJV3+H9kjJPk7Ot3oG1J1/MbeuSfFPjCREsM1cgszW56+l7FYdnB1Mz3QQOVZtPz0O
         7jp4Ohnh6zKDtwJ39w7x/2zR4x7cGhCG3dwoAcKV7BmGGSLS+MDUtCDEuZ+v2dnG+r1S
         UNDyB7/GoJShhONHihMxWTX0Xv8Pxy671HAvWhM1QPo0fOfMzbMm3IkED0E1tm/aRS+m
         v/WA==
X-Gm-Message-State: AGRZ1gJ2Agl6p8h36xJ4PPoxfigj1EqNjZ7pQ3KJ9v5nSqKJps6d6w6V
        x+FKWxljFw7oxSEP1J/R5vyl8HxcvzY=
X-Google-Smtp-Source: AJdET5cYNQfhu6O+UDWcXkanAbxASflT4uJv81zRTp0sc3JAjRaPIkG+FEXE4gzB/V78f6tkd/Hl7Q==
X-Received: by 2002:aed:34a6:: with SMTP id x35-v6mr8469384qtd.93.1541125151196;
        Thu, 01 Nov 2018 19:19:11 -0700 (PDT)
Received: from localhost ([199.255.44.5])
        by smtp.gmail.com with ESMTPSA id 5-v6sm23299527qtz.8.2018.11.01.19.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 19:19:09 -0700 (PDT)
Date:   Thu, 01 Nov 2018 19:19:09 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Nov 2018 19:18:28 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 4.20 Merge Window, Part 3
CC:      linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-cb2ea62c-8d08-467b-bea5-657b42a5acbf@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit baa888d25ea64d0c59344d474284ca99cfdd449a:

  Merge branch 'next-keys2' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security (2018-11-01 15:23:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-4.20-mw3

for you to fetch changes up to ba1f0d95576902c10930d3467e638bac38f942f1:

  RISC-V: refresh defconfig (2018-11-01 17:04:07 -0700)

----------------------------------------------------------------
RISC-V Patches for the 4.20 Merge Window, Part 3

Sorry for the last minute patches, but it was suggested we try to push
this in before rc1 to make it easier for people to keep their branch
rebases sane.  Since this is just a single defconfig update that is
intended to have no functional change I thought it would be worth
breaking my own PR rules.

----------------------------------------------------------------
Anup Patel (1):
      RISC-V: refresh defconfig

 arch/riscv/configs/defconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
