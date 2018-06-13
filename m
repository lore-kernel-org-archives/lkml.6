Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4F1F0C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EF1208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aggl0kSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EF1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935860AbeFMVFg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:05:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37443 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935448AbeFMVFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:05:33 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so2224957plc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wzxZ2QBCbK+ZPOxBJwHYogS3SvBQEdo6tnoZ9mZk5kc=;
        b=Aggl0kSiukDmP5AwHBj5ibjWF9jvtLDKiPrNoZZJV09z8RNZlNswg4crvRPBNF562G
         ADYoMSoniiNUK1ZSxiOe6so58IRekAlhFanh3d+c0AimPOF3ySmHmyQj0QuLgyR0G6CC
         b3Bbb5/xdQ/dd3F2fRqEN8wcdAo+h0ddXMzYaHR3BXs4ZPJEdu3H7oqxpg8EjjdVK4iU
         Z257LNKm8n1EjmdeqipDfuelseJuq9VZUyax7sRTNRNEwU6uhJ73DOsNkmUhQmjjoVZp
         IgOx1panXavc2XTj4D7E8vYr7LJKj6zakX7IUhUcR8nwN4hTm03cOl1QiKaioMIgNGAA
         WDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wzxZ2QBCbK+ZPOxBJwHYogS3SvBQEdo6tnoZ9mZk5kc=;
        b=Rm8nU+sEKxQgN6ngLhOuFhiOg0LGdBYMiiJIRTGALuprdjG89lGOsdY55sVI4CRfKD
         j/dv6gJ+DAvUESUS9FiST1U02QlGbngOLpjooEAonxen6Hc8dF5orTET+mN95bt8aM2I
         Ho6prY740TPwVEDDXgdbkU8vsrW4mQwi46aczi3jHrjNOCr7PTtw6EA/4mpqdMLgJipI
         5qsSqvGo8H3+KfgX1ZYo0ES8cpZntXWWLxRRS1SkapGcIk1WZP3ABggcPRM5Ltolq7JI
         XjhvVxLO89/Hise/L+BBqHIDmQqPXy/cgZEWz0OARAl6zRjfRfNVK4osBHaCyHqNWW9E
         rAVQ==
X-Gm-Message-State: APt69E1rW9C93mH8UnEwJZ4aqDGPJ/h8M7enkHjr0buz9TpuxjjiYRt+
        Kr596in02IRbU5rHPKg5Iulw2Q==
X-Google-Smtp-Source: ADUXVKLwToYK6Qschw2JnYq8Fb4V+LGVinprEzNpmuP10QXqD0XxbQIP0IIAp3xzlf4NEAmVdqGjBA==
X-Received: by 2002:a17:902:206:: with SMTP id 6-v6mr6804773plc.294.1528923932841;
        Wed, 13 Jun 2018 14:05:32 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm8692976pfg.98.2018.06.13.14.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 14:05:31 -0700 (PDT)
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        ndesaulniers@google.com, thomas.lendacky@amd.com, tweek@google.com,
        mjg59@google.com, joe@perches.com,
        andrea.parri@amarulasolutions.com
Subject: [PATCH v5 0/3] extern inline native_save_fl for paravirt
Date:   Wed, 13 Jun 2018 14:05:15 -0700
Message-Id: <20180613210518.113983-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

paravirt depends on a custom calling convention (callee saved), but
expects this from a static inline function that it then forces to be
outlined. This is problematic because different compilers or flags can
then add a stack guard that violates the calling conventions.

Uses extern inline with the out-of-line definition in assembly to
prevent compilers from adding stack guards to the outlined version.

Other parts of the codebase overwrite KBUILD_CFLAGS, which is *extremely
problematic* for extern inline, as the sematics are completely the
opposite depending on what C standard is used.
http://blahg.josefsipek.net/?p=529

Changes since v4:
  Take Arnd's and hpa's suggestions properly feature detect gnu_inline
  attribute to support gcc 4.1.

Changes since v3:
  Take Joe's suggestion to hoist __inline__ and __inline out of
  conditional block.

Changes since v2:
  Take hpa's _ASM_ARG patch into the set in order to simplify cross
  32b/64b x86 assembly and rebase my final patch to use it.  Apply
  Sedat's typo fix to commit message and sign off on it. Take Joe's
  suggestion to simplify __inline__ and __inline. Add Arnd to list of
  folks who made helpful suggestions.

Changes since v1:
  Prefer gnu_inline function attribute instead of explicitly setting C
  standard compiler flag in problematic Makefiles. We should instead
  carefully evaluate if those Makefiles should be overwriting
  KBUILD_CFLAGS at all. Dropped the previous first two patches and added
  a new first patch.

H. Peter Anvin (1):
  x86/asm: add _ASM_ARG* constants for argument registers to <asm/asm.h>

Nick Desaulniers (2):
  compiler-gcc.h: add gnu_inline to all inline declarations
  x86: paravirt: make native_save_fl extern inline

 arch/x86/include/asm/asm.h      | 59 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/irqflags.h |  2 +-
 arch/x86/kernel/Makefile        |  1 +
 arch/x86/kernel/irqflags.S      | 26 +++++++++++++++
 include/linux/compiler-gcc.h    | 29 ++++++++++++----
 5 files changed, 109 insertions(+), 8 deletions(-)
 create mode 100644 arch/x86/kernel/irqflags.S

-- 
2.18.0.rc1.244.gcf134e6275-goog

