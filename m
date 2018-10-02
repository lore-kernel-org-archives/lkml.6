Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A15AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECB82064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECB82064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbeJCAmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:42:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45104 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeJCAmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:42:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23-v6so328398pfi.12;
        Tue, 02 Oct 2018 10:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHQalcPe77VvkFXaX4smZmsIPYKvGDd7NTwICe+XGdM=;
        b=N9PEQo5zyMfTg9+oHZjQFpBu7i8TZbCA+rNyZiZgogqvTltzxjBqKqMxAsTzJgulAD
         Tj2VQMMzj1lMwsrKY5msNJxvuUjmmFTGeC1GmfhGv+MMXMF2I3lFmyFX3t81vOFdsMT6
         kRi8lDlvycSr4vXxH0CPadKXPgeUViEBjMtrRScvLsx6ItEir1Zetcrg7z59DZHQBZMt
         IGRxRjnO1OAKLqp1rCnPi4f6YQiIivg+46JgQYZ59t2oxlsiqzVg9qPEhAUJ5JsYORfx
         NIUtOjiT4w4e2qnDM1BK4kBvbnuEWcxdPN+cdeBxB79KUvO3KvA2iKbvz4ubYBRmFo8X
         1uFg==
X-Gm-Message-State: ABuFfogcSZvJbaPbrwVQrp0pv1i9HiQUkMjvKuqlUTqqyZXu5F0+nfO5
        MkuNpxCIitmoaSX7slSXvmc=
X-Google-Smtp-Source: ACcGV60PVoHuHU8U1CTR5ScgVCkJYqy61xwngsuWeNrycFnVmNOw7vBsI/mT/unasluz+qP7aeL/uA==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr17547033pfm.254.1538503065842;
        Tue, 02 Oct 2018 10:57:45 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j14-v6sm6272494pgh.52.2018.10.02.10.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 10:57:45 -0700 (PDT)
Message-ID: <1538503063.193396.6.camel@acm.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Oct 2018 10:57:43 -0700
In-Reply-To: <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
         <10b12992-3570-4646-374b-82cbd7276839@acm.org>
         <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 10:24 -0700, Nick Desaulniers wrote:
+AD4 On Mon, Oct 1, 2018 at 6:16 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 Additionally, zero initializers should be left out to minimize
+AD4 +AD4 the size of object files.
+AD4 
+AD4 Sorry, my understanding was that global variables either occupy the
+AD4 .bss section or the .data section, depending on whether they were
+AD4 zero-initialized vs initialized to non-zero, respectively (where
+AD4 non-initialized are treated as zero initialized).  Looks like without
+AD4 the explicit zero initialization, compilers will put the symbols in a
+AD4 +ACI-common+ACI section, which +AGA-man 1 nm+AGA says is also unitialized data.  I
+AD4 didn't think .bss sections occupied space in an object file or binary+ADs
+AD4 the kernel's loader would set up the mappings at execution?  Can you
+AD4 clarify?

Explicitly initialized global and static variables end up in the .data
section and need space in that section. That is not the case if the
initializer is left out and these variables end up in the .bss section.
From https://en.wikipedia.org/wiki/.bss:

+ACI-In computer programming, the name .bss or bss is used by many compilers
and linkers for the portion of an object file or executable containing
statically-allocated variables that are not explicitly initialized to any
value. It is often referred to as the +ACI-bss section+ACI or +ACI-bss segment+ACI.

Typically only the length of the bss section, but no data, is stored in
the object file.+ACI

This is why checkpatch warns if a global or static variable is initialized
explicitly to zero. From scripts/checkpatch.pl:

our +ACQ-zero+AF8-initializer +AD0 qr+AHs(?:(?:0+AFs-xX+AF0)?0+-+ACQ-Int+AF8-type?+AHw-NULL+AHw-false)+AFw-b+AH0AOw

+ACM check for global initialisers.

                if (+ACQ-line +AD0Afg /+AF4AXAArACQ-Type+AFw-s+ACoAJA-Ident(?:+AFw-s+-+ACQ-Modifier)+ACoAXA-s+ACoAPQBc-s+ACo(+ACQ-zero+AF8-initializer)+AFw-s+ACoAOw-/) +AHs
                        if (ERROR(+ACI-GLOBAL+AF8-INITIALISERS+ACI,
                                  +ACI-do not initialise globals to +ACQ-1+AFw-n+ACI . +ACQ-herecurr) +ACYAJg +ACQ-fix) +AHs
                                +ACQ-fixed+AFsAJA-fixlinenr+AF0 +AD0Afg s/(+AF4.+ACQ-Type+AFw-s+ACoAJA-Ident(?:+AFw-s+-+ACQ-Modifier)+ACo)+AFw-s+ACoAPQBc-s+ACoAJA-zero+AF8-initializer+AFw-s+ACoAOw-/+ACQ-1+ADs-/+ADs
                        +AH0
                +AH0

+ACM check for static initialisers.

                if (+ACQ-line +AD0Afg /+AF4AXAAr.+ACoAXA-bstatic+AFw-s.+ACoAPQBc-s+ACo(+ACQ-zero+AF8-initializer)+AFw-s+ACoAOw-/) +AHs
                        if (ERROR(+ACI-INITIALISED+AF8-STATIC+ACI,
                                  +ACI-do not initialise statics to +ACQ-1+AFw-n+ACI . +ACQ-herecurr) +ACYAJg +ACQ-fix) +AHs
                                +ACQ-fixed+AFsAJA-fixlinenr+AF0 +AD0Afg s/(+AFw-bstatic+AFw-s.+ACo?)+AFw-s+ACoAPQBc-s+ACoAJA-zero+AF8-initializer+AFw-s+ACoAOw-/+ACQ-1+ADs-/+ADs
                        +AH0
                +AH0

Bart.
