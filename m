Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5483C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8420820666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8420820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJCFwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:52:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40693 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725744AbeJCFwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:52:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id s5-v6so687881pfj.7;
        Tue, 02 Oct 2018 16:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jgn3x29TLqlDShyodvnATB2J6qvN3hbeOkOfMWO96M8=;
        b=pDm/fqBsN2jFUkdHv5YbwcK4K+HJxTZ5li5BoPucFyeh5yg2+BNu6mPLKJyGmx1qZC
         4PP+M8rtKixNS6Py6dfHZ0xoih3gBo4pQKk7W9pmYsgyVjgx19eJCCbXjTsJy33i/i4u
         R745RNdHbG02EZQSIofH6B/DUbRhzOAzq6Acv3muDC7RDITcxfRGiHRUM3mZmZzG5qzZ
         NHyN9UrM9IVr5syLLcESWXWT1VEx+rhLRKjF3brKaJe1v20lPx8CDxfOAwOTBTlB0Web
         PPjltCefAJYZDiT1/wgMEIlO/ycjoaYqhQdGKVt4NI7Fi6bweIbvxSLPNdNJ5980Z+Ly
         Jp0w==
X-Gm-Message-State: ABuFfohsh+uUPWDnu1hgoNmCQfQl3ivyLByOmUbAfFzvvZlBvrbos2yC
        9b8r5kxsGEBN8Hh2Gl9YO3c=
X-Google-Smtp-Source: ACcGV60ZzTEaYAaAciG/LQq/HoRCf21bSg4gGQHj/wnUYgIO7Wd+p6tgJnZSaRQuO0eczu8xUxSD+A==
X-Received: by 2002:a63:3e06:: with SMTP id l6-v6mr15818437pga.96.1538521593882;
        Tue, 02 Oct 2018 16:06:33 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id c2-v6sm23422282pfo.107.2018.10.02.16.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 16:06:33 -0700 (PDT)
Message-ID: <1538521591.193396.8.camel@acm.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 02 Oct 2018 16:06:31 -0700
In-Reply-To: <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
         <10b12992-3570-4646-374b-82cbd7276839@acm.org>
         <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
         <1538503063.193396.6.camel@acm.org>
         <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 15:33 -0700, Nick Desaulniers wrote:
+AD4 On Tue, Oct 2, 2018 at 10:57 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 Explicitly initialized global and static variables end up in the .data
+AD4 +AD4 section and need space in that section.
+AD4 
+AD4 Unless the initial value is zero.
+AD4 https://godbolt.org/z/curRoO
+AD4 
+AD4 So you don't wind up with an increase in binary size simply by having
+AD4 global variables initialized to zero, right?  Instead the kernel knows
+AD4 to create a zero'd out mapping for bss.  You don't need a run of zeros
+AD4 in the binary.
+AD4 
+AD4 So I disagree when you said earlier +ACI-zero initializers should be left
+AD4 out to minimize the size of object files.+ACI I assert they don't affect
+AD4 the size of the binary.
+AD4 
+AD4 If you had many global variables all initialized to zero, why would
+AD4 you encode that many zeros in a binary, when you can just set a size
+AD4 on the bss section and have the kernel create the appropriate sized
+AD4 and zero'd mapping?
+AD4 
+AD4 +AD4 That is not the case if the
+AD4 +AD4 initializer is left out and these variables end up in the .bss section.
+AD4 
+AD4 From my above link, gcc will put globals without initializers into +ACI-common.+ACI

No matter what particular compiler versions do with explicit initialization
to zero, the preferred kernel coding style is to leave out such explicit
initialization.

Bart.
