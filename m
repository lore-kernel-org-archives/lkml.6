Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D6EC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00D220834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsinEIB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00D220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbeJZGGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:06:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33427 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZGGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:06:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so2808570wmd.0;
        Thu, 25 Oct 2018 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pXeXT1bGIRgoB6EEvvy7stnLwiEBI6SOgVykDqQ2/LM=;
        b=YsinEIB+/2Jw41EaI7oHae+Ljat7nrENo0+1KhQE4zDVOefM2xLdlojMJrJ8PDzIZ3
         30LDSaknbN/zEDgYqmau40HWX+KOvvV3mUB4SF359LtLc03xtIlRGYiaYLWpZFScfWle
         BV0DlM058hiSS81HO7oXK/2nIst9I57akevUcXu+A/tiusDG+EIjZyEAjAN9mmxVE4P9
         z8mIyNJiRT1iL3Xt67Qs3UTkWcMVxfQkPI1ZvbO2jClz4Yh1LqzXNzNtvZiR84ELU4n7
         mEZUDXzlw/xt8nKPNL6Xq3ni7UIYNlTEAppXVVv+xWxTIw1cWWUuB6CDlGlvkDMv0iDv
         CpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pXeXT1bGIRgoB6EEvvy7stnLwiEBI6SOgVykDqQ2/LM=;
        b=HlEKvs5p7cqGiFE0xSn4AdfrdxlIHSd4AC6HVgNF1IAm7YuHLbI6po1v7n9KRpkdZR
         ihfOeWgloZLpeHgkYpKNwYVe+YAVaS1jgSIkISQa6fTSv2WBGF2Qs7qnDdx0DOI+xPYa
         EFK4Lko8qPRwMgm9euO/xXp4L+RgnsGhEPJCF3NPKQrrQq/XdU8g89+XKBlLV6X1cPK2
         MvLk2x373CMK+SgbnrkLYx5NETV3SdIVBguezHVkrnCW1pZ7+b3TPhV8/XrPGUMVzJmh
         xpk5T9oJqF6Rnyz56baCz3h8xnsQucmiZD0XVY1Q+Ku2fE8dUuKCEh9g6eN1m/tDfkPT
         93gg==
X-Gm-Message-State: AGRZ1gKvHh3MXfq0q1f5xboIZ/Ij+kWvpSS+p1az6cLhdO6RuVpRExZV
        8c+ZMmn210OEVTpt53eBxkA=
X-Google-Smtp-Source: AJdET5cHEGUsYQqbTXBk69jPMMYu8x1lwwZ9OEAhC/qdPdisCpXvWdMLt8PSznVbv+7ZqGs7SUJX+w==
X-Received: by 2002:a1c:85d0:: with SMTP id h199-v6mr3268892wmd.127.1540503106989;
        Thu, 25 Oct 2018 14:31:46 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l140-v6sm4400263wmb.24.2018.10.25.14.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 14:31:46 -0700 (PDT)
Date:   Thu, 25 Oct 2018 14:31:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181025213144.GB24709@flashbox>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538521591.193396.8.camel@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 04:06:31PM -0700, Bart Van Assche wrote:
> On Tue, 2018-10-02 at 15:33 -0700, Nick Desaulniers wrote:
> > On Tue, Oct 2, 2018 at 10:57 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > Explicitly initialized global and static variables end up in the .data
> > > section and need space in that section.
> > 
> > Unless the initial value is zero.
> > https://godbolt.org/z/curRoO
> > 
> > So you don't wind up with an increase in binary size simply by having
> > global variables initialized to zero, right?  Instead the kernel knows
> > to create a zero'd out mapping for bss.  You don't need a run of zeros
> > in the binary.
> > 
> > So I disagree when you said earlier "zero initializers should be left
> > out to minimize the size of object files." I assert they don't affect
> > the size of the binary.
> > 
> > If you had many global variables all initialized to zero, why would
> > you encode that many zeros in a binary, when you can just set a size
> > on the bss section and have the kernel create the appropriate sized
> > and zero'd mapping?
> > 
> > > That is not the case if the
> > > initializer is left out and these variables end up in the .bss section.
> > 
> > From my above link, gcc will put globals without initializers into "common."
> 
> No matter what particular compiler versions do with explicit initialization
> to zero, the preferred kernel coding style is to leave out such explicit
> initialization.
> 
> Bart.

Hi Bart,

I'm sorry if I didn't follow the conclusion of this conversation properly
but this is the below diff you were initially looking for, correct?

If so, Boaz and Nick, do you have any objections if this is v2? I'd like
to get this patch accepted so the warning can be fixed for everyone.

Thanks,
Nathan

================================================================================

diff --git a/drivers/scsi/osd/osd_initiator.c b/drivers/scsi/osd/osd_initiator.c
index e19fa883376f..4250f739beb3 100644
--- a/drivers/scsi/osd/osd_initiator.c
+++ b/drivers/scsi/osd/osd_initiator.c
@@ -58,6 +58,8 @@

 enum { OSD_REQ_RETRIES = 1 };

+static const struct osd_obj_id osd_root_object;
+
 MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
 MODULE_DESCRIPTION("open-osd initiator library libosd.ko");
 MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/osd/osd_uld.c b/drivers/scsi/osd/osd_uld.c
index eaf36ccf58db..770c758baaa9 100644
--- a/drivers/scsi/osd/osd_uld.c
+++ b/drivers/scsi/osd/osd_uld.c
@@ -73,6 +73,7 @@

 static const char osd_name[] = "osd";
 static const char *osd_version_string = "open-osd 0.2.1";
+static const struct osd_obj_id osd_root_object;

 MODULE_AUTHOR("Boaz Harrosh <ooo@electrozaur.com>");
 MODULE_DESCRIPTION("open-osd Upper-Layer-Driver osd.ko");
diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
index 48e8a165e136..eb31357ec8b3 100644
--- a/include/scsi/osd_types.h
+++ b/include/scsi/osd_types.h
@@ -28,8 +28,6 @@ struct osd_obj_id {
        osd_id id;
 };

-static const struct __weak osd_obj_id osd_root_object = {0, 0};
-
 struct osd_attr {
        u32 attr_page;
        u32 attr_id;
