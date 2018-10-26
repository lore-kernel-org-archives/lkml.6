Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B0ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A145920848
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A145920848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJ0HDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:03:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33111 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeJ0HDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:03:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6-v6so1127317pln.0;
        Fri, 26 Oct 2018 15:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ga8LLf7y0fQKPbE2i5i0i3bPljcA2+aMO7qH3FU+os=;
        b=Uq3pVm0pHWH+Qyfw0YbnQoWHlvOJn9fwMwqrccion5PSsSymCuYTq2fbkQOS3aO0Mh
         mHlEa2SzELc7eWbMeyxEK/9hQ1GydqTyXbNiRscxh8qml1m5bhaIcUtI2P3w5E8qfrVA
         SST0DOHT3tnN+JKqtvJfPNAMcZshfYlSAqKnlHpnJ8CDs52gE0LPwifRMDDNapSEXF8N
         RYCFqB8BVm1gVeFNyagsgSu07whf0KDKf9IZtP4VvmWDxF14FM1X+bZVuXpR/pFnDd+W
         piX9h0wfFLux5vK9WGvt2jB5MfimJ3h6Y+Tb6LwJdjsAongBP/h/NCVibivkJosh3KPs
         a+Fw==
X-Gm-Message-State: AGRZ1gJorfdm3Ymo2PKuuULQ87JK84QSVNF6vH1r0tyfd7z8OOQKeNAr
        6tr7YsY8d+y+YzmORN9yXHY=
X-Google-Smtp-Source: AJdET5crPh3mtpnrKNRno4zGX0z4gIwRG3/x2FVVa8S5K+EB3U79BhPv9rIY9UFvIO98+8x0ZBqLjQ==
X-Received: by 2002:a17:902:6a8b:: with SMTP id n11-v6mr5145205plk.16.1540592687248;
        Fri, 26 Oct 2018 15:24:47 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z15-v6sm14085895pfn.170.2018.10.26.15.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 15:24:46 -0700 (PDT)
Message-ID: <1540592684.66186.136.camel@acm.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Date:   Fri, 26 Oct 2018 15:24:44 -0700
In-Reply-To: <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
         <10b12992-3570-4646-374b-82cbd7276839@acm.org>
         <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
         <1538503063.193396.6.camel@acm.org>
         <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
         <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
         <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
         <20181025225548.GA10326@flashbox>
         <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
         <1540576908.66186.103.camel@acm.org>
         <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
         <1540589437.66186.124.camel@acm.org>
         <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
         <1540591147.66186.127.camel@acm.org>
         <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 15:07 -0700, Nick Desaulniers wrote:
+AD4 I don't disagree with you, I just don't see how what you state can be
+AD4 reconciled with Linus' response in
+AD4 https://lkml.org/lkml/2018/10/27/44.  Those two viewpoints seem
+AD4 incompatible to me, but maybe there's a nuance I'm missing?

I don't think there is any disagreement nor that there are any conflicting
viewpoints. As explained in previous e-mails it is unlikely that anyone is
using these kernel drivers and as far as I know Linus is OK with removing
unused kernel drivers.

+AD4 Nathan and I are just pointing out a small fix to eliminate a small
+AD4 warning, deleting all this code does kind of feels like +ACI-throwing out
+AD4 the baby with the bath water.+ACI A nuclear option for what would be a
+AD4 small change otherwise.  Maybe it's good to discuss the EOL for
+AD4 exofs/osd, but can we please decouple that conversation from the small
+AD4 change Nathan and I are proposing?

Removing a kernel driver is not a nuclear option. You may not be aware of
this but it happens all the time. From a maintainer point of view it is a
very sensible action because there are people who keep submitting cleanup
patches for kernel drivers they do not use themselves. Every individual
patch needs some attention and hence causes some work for a kernel
maintainer. Removing kernel drivers that are not used helps to reduce the
workload of a maintainer and hence is a rational action. Additionally, if
anyone would ever complain about removal of a kernel driver, it can be
brought back by reverting the commit through which it has been removed.
Martin, please reply if you see this differently.

Bart.
