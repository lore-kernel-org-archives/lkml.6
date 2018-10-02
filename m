Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6204EC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161762082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aOZv02xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161762082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeJCAI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 20:08:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37524 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbeJCAI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 20:08:57 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so313103pfi.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX97xYLhCZrGHl8og9Qk69El28f07YxnhNPgoplAH08=;
        b=aOZv02xtm358uVrjerHYykczSATtkZt7pE4297OxS3ME0QqxmpfiaVCKkd4Dkx5Y2w
         8gyOAcXLm/04M9xGpIyhT2bJhDNPCw7E5HmcFtNOxXysiV+AzUxgqOFqPkAhjF9YklDj
         qvq9Lms0caEuDAe+V+BRQODMcD4UVbJ7kdY+fSpgDQhWnVblctxi/P9jnLKO4MlDrrOY
         QcZ649Q0bXV3A501bF5HrQjCa0wpieYfU7UljUgQW9IYRDGaqUV/2GKd0P72BbIbEY7J
         0MejAjuFwYzes3ecXOp0XjfnQAhugBYPyrW5tVAnYvwg0J/PTb29EZi81MszxGZwe1rw
         G4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX97xYLhCZrGHl8og9Qk69El28f07YxnhNPgoplAH08=;
        b=D1TU0oh3pMzTCRlhXZWtqWQWn3/teAmsN8CfflK5RNn7WjrUR8eKxpp/Gup6fA2RWn
         23nrwYpEPBLsRptYLmlLR87pOLkL0iRyUuvu1Bw88SwTZQemcHDD2F29kUUNVzFjo8bf
         gWoGPOuNvxBF6Dpco8Dwp11AElYMx1+i8oIgBFWofkL8rRCGubchAtDN6PyFh5aPWrqs
         Z16XL4ivLAFUqDuwSLVvMIYyThlnbktHfMZXcgN9HXlW70KLcZVzZvksFvcKP0AQ5Njm
         RBN/7eIdhzfUvARRIzgc0eC5MTRM2uFUx8Z86tb7bMls85y6d8MxBkKCDEzBljk6IV5U
         nXyg==
X-Gm-Message-State: ABuFfojFIuJF+Iq2aw2rr78MpfZYAkAukDdFmaxYNxGtzCm2SPkRhdnc
        nnFRkDiIMLY4WNKUJkjt4hiYtcR4yPIXROID1TBvzA==
X-Google-Smtp-Source: ACcGV60CGvpKJju91y5Q+9nBpJZ97rT4NFLOCccBvBsS3H4eL5ymJbOhC1noOk5Y8rLs96ZrAMhLOg2yyeW2XxIeg6s=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr15553852pgn.145.1538501069685;
 Tue, 02 Oct 2018 10:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com> <10b12992-3570-4646-374b-82cbd7276839@acm.org>
In-Reply-To: <10b12992-3570-4646-374b-82cbd7276839@acm.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Oct 2018 10:24:18 -0700
Message-ID: <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     bvanassche@acm.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 6:16 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 9/30/18 1:54 PM, Nathan Chancellor wrote:
> > diff --git a/include/scsi/osd_types.h b/include/scsi/osd_types.h
> > index 48e8a165e136..6b6fdcafa6cc 100644
> > --- a/include/scsi/osd_types.h
> > +++ b/include/scsi/osd_types.h
> > @@ -28,7 +28,7 @@ struct osd_obj_id {
> >       osd_id id;
> >   };
> >
> > -static const struct __weak osd_obj_id osd_root_object = {0, 0};
> > +static const struct osd_obj_id osd_root_object = {0, 0};
>
> Structure definitions should occur in .c files instead of in header
> files especially if the header file is included from multiple source
> files. Please consider moving the definition of osd_root_object into a
> .c file.

> Additionally, zero initializers should be left out to minimize
> the size of object files.

Sorry, my understanding was that global variables either occupy the
.bss section or the .data section, depending on whether they were
zero-initialized vs initialized to non-zero, respectively (where
non-initialized are treated as zero initialized).  Looks like without
the explicit zero initialization, compilers will put the symbols in a
"common" section, which `man 1 nm` says is also unitialized data.  I
didn't think .bss sections occupied space in an object file or binary;
the kernel's loader would set up the mappings at execution?  Can you
clarify?

>
> Boaz, the most recent osd patch that is neither trivial nor treewide
> refactoring is six years old (51976a8c85ce ("[SCSI] osd_uld: Add osdname
> & systemid sysfs at scsi_osd class"). That suggests that nobody is using
> this driver anymore. Can this driver be removed from the kernel tree?
>
> Thanks,
>
> Bart.



-- 
Thanks,
~Nick Desaulniers
