Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA36ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E504320856
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E504320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeJ0Ghx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:37:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45211 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbeJ0Ghx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:37:53 -0400
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so1073860pll.12;
        Fri, 26 Oct 2018 14:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5yTcwJRJM4gdNVPjEqblalys8SpQK7nf3a7/X02vvEU=;
        b=YQoL9n1tHSZrj5TIQAOBv8B1iAedvAGLUiS5Yf7P93sFsqyt4UUe3okPqHnDITfUtH
         whugLSqIRFuVKhcNiOGMiYjPvpjKjfjo24tU8Xmk5Zv9oLqDNwXzJmxmax4bBq4fRz8z
         7pyKAM3Y1Wu5wm3qm6Xm43rX0zuYW9I9vJuzO2/uw6p7qJyiyvk57EO2UcClBdFYW1fY
         0hFu1cdzXNxidXNa8IQa/xsBYw3P2mxlGPrZFAfIBGZWPQ1gsNUhZsQGfaL5RGr5dctn
         LMXfXG38To64HkOwRgw2yjKFc4dJ/zE6kjkU42FT0qJ1S8ekZyW/s7+rL2DfcKqKSbGF
         4cdw==
X-Gm-Message-State: AGRZ1gJp3J2tUDzw7U0tke1JQAoBFKOgtnrIHKFCvdvB0k/6ckC357e3
        G3+h3ILEziNTyAusOKGHfHA=
X-Google-Smtp-Source: AJdET5f47x1r4KIOoI07lU2V06lsgfCCojxZaRKXbtxw9egHZj1J1i0Pfd0+q84zUFg+GAOxHlFB7A==
X-Received: by 2002:a17:902:9f95:: with SMTP id g21-v6mr5186190plq.129.1540591149630;
        Fri, 26 Oct 2018 14:59:09 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p1-v6sm16358816pfj.72.2018.10.26.14.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 14:59:08 -0700 (PDT)
Message-ID: <1540591147.66186.127.camel@acm.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Date:   Fri, 26 Oct 2018 14:59:07 -0700
In-Reply-To: <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
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
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-26 at 14:36 -0700, Nick Desaulniers wrote:
+AD4 On Fri, Oct 26, 2018 at 2:30 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On Fri, 2018-10-26 at 14:00 -0700, Nick Desaulniers wrote:
+AD4 +AD4 +AD4 On Fri, Oct 26, 2018 at 11:01 AM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 On Fri, 2018-10-26 at 10:54 -0700, Nick Desaulniers wrote:
+AD4 +AD4 +AD4 +AD4 +AD4 If creating one instance of this variable is a functional change, I
+AD4 +AD4 +AD4 +AD4 +AD4 can't help but suspect the original code was wrong.  But maybe Bart,
+AD4 +AD4 +AD4 +AD4 +AD4 Boaz, or Christoph can clarify or have more thoughts on this?  Looks
+AD4 +AD4 +AD4 +AD4 +AD4 like Boaz added this header in commit de258bf5e638 (+ACIAWw-SCSI+AF0 libosd:
+AD4 +AD4 +AD4 +AD4 +AD4 OSDv1 Headers+ACI).
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Hi Nick and Nathan,
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Had you noticed the following e-mail from early October:
+AD4 +AD4 +AD4 +AD4 https://marc.info/?l+AD0-linux-kernel+ACY-m+AD0-153849955503249?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 From this subthread with Linus, removal of the exofs fs and scsi osd
+AD4 +AD4 +AD4 code would be a user visible change and is not an option. See:
+AD4 +AD4 +AD4 https://lkml.org/lkml/2018/10/27/3
+AD4 +AD4 +AD4 https://lkml.org/lkml/2018/10/27/44
+AD4 +AD4 
+AD4 +AD4 Hi Nick,
+AD4 +AD4 
+AD4 +AD4 Linus wrote that removing a filesystem is considered a userspace breakage
+AD4 +AD4 if a user notices. The key part is +ACI-if a user notices+ACI. Who are the exofs
+AD4 +AD4 users?
+AD4 
+AD4 See my thoughts on this in https://lkml.org/lkml/2018/10/27/27.
+AD4 Particularly the part about the IMO catch 22.
+AD4 
+AD4 Neither you nor I can claim +ACI-there are none.+ACI

That's not completely correct. The standard approach to check whether or not
a driver is still being used is to check its git history. If the number of
contributors is low and it was several years ago that a new feature was added
or a bug has been fixed it is likely that nobody is using that driver anymore.

Bart.

