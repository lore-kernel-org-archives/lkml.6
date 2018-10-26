Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9A9ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3112085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3112085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJ0GJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:09:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37769 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbeJ0GJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:09:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so1111960pgq.4;
        Fri, 26 Oct 2018 14:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8ZkplFh25knoRHRMO1MxHek+dIiHws632VoX5LmWR0=;
        b=ekCWOw8TIU+QFNNsBbFdJtnX+zWrCgxs4mL+8JCRSyWnDhCx3gzks8DG5NtT5T3fxy
         3vZxPJgtkwJR3yQmtqjcakNlYJF7rJApc9VEgt5NBXc5mm1dZ3PZP7Vr/UXlX1idsBis
         Gj7ofXv5Cg7Xwwr11LLRzZE5IbHIKWnS+gOdaKZs8W1WotOMFxedUqv5qXoQEg2qTdgQ
         9ynY1tHCq//wA/83BExRmvVmes1EQyXyCWNE2+IpkG1l2geqjDP4FrK9E3tuSinNfbv2
         t6V1NjUbe4m/U9ph4yeu9KAw1hK/cva9zfJgXNrc4Ukiuu075ew5USr45hcFgVXLfJzd
         UPDA==
X-Gm-Message-State: AGRZ1gIQpWPoBnFPlwBXZxqEjvY6TewlZZ7dK4M3jGPWbvhFQLtaIdND
        xtfmjDkIi93MT6pp5PMybBE6PGnxifw=
X-Google-Smtp-Source: AJdET5cnjp8jzz7BPYCv54TzHmQcTc2qT5emTjwVqrRKHlqcm52qWWbk1Fh13cXgshnj3Au3RMq3Mg==
X-Received: by 2002:a62:6f43:: with SMTP id k64-v6mr5229707pfc.87.1540589439581;
        Fri, 26 Oct 2018 14:30:39 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 127-v6sm103511pfd.16.2018.10.26.14.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 14:30:38 -0700 (PDT)
Message-ID: <1540589437.66186.124.camel@acm.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>, ooo@electrozaur.com
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Date:   Fri, 26 Oct 2018 14:30:37 -0700
In-Reply-To: <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 14:00 -0700, Nick Desaulniers wrote:
+AD4 On Fri, Oct 26, 2018 at 11:01 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
+AD4 +AD4 +AD4 If creating one instance of this variable is a functional change, I
+AD4 +AD4 +AD4 can't help but suspect the original code was wrong.  But maybe Bart,
+AD4 +AD4 +AD4 Boaz, or Christoph can clarify or have more thoughts on this?  Looks
+AD4 +AD4 +AD4 like Boaz added this header in commit de258bf5e638 (+ACIAWw-SCSI+AF0 libosd:
+AD4 +AD4 +AD4 OSDv1 Headers+ACI).
+AD4 +AD4 
+AD4 +AD4 Hi Nick and Nathan,
+AD4 +AD4 
+AD4 +AD4 Had you noticed the following e-mail from early October:
+AD4 +AD4 https://marc.info/?l+AD0-linux-kernel+ACY-m+AD0-153849955503249?
+AD4 
+AD4 From this subthread with Linus, removal of the exofs fs and scsi osd
+AD4 code would be a user visible change and is not an option. See:
+AD4 https://lkml.org/lkml/2018/10/27/3
+AD4 https://lkml.org/lkml/2018/10/27/44

Hi Nick,

Linus wrote that removing a filesystem is considered a userspace breakage
if a user notices. The key part is +ACI-if a user notices+ACI. Who are the exofs
users?

Bart.
