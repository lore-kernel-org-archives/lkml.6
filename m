Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C388AECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAFF21523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEcfrXbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAFF21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbeIUTH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:07:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41743 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeIUTH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:07:26 -0400
Received: by mail-ed1-f66.google.com with SMTP id f38-v6so10699572edd.8;
        Fri, 21 Sep 2018 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=fSRwvwhOM0DKy71IgTaPgffXf+6iMoKDxt2k6I15FTE=;
        b=AEcfrXbnBy5AUFvarIpUgzacXp5/YWqVxLVHnBaQZaroY7uOKKAVi5dTAVD35ZqQuJ
         9ZQ7b1xtjdiWy6A3f5ec7vqorFfJsFW1xQQYfQtiiUsaZRiE1NrgVez4B3vO+Wzke8Dz
         JUiH8j9e0yfsbxMHrUgy2R9b+QzxtTQYUqC/SyXKjXU1u05RV2fNhkkOu7+KYncb1X6o
         Ww6Zl8IXJdhXI1Ane3EU/xysqamiY3YkkGNsr7XqgzZfXrncerW/q4Ga57TrYixFmZf1
         qGvDSIv2cLTOAYPEazqj3/cqGnqP8694+S2qq4eBSUYCevJOJei5fGG5dwwSx3h3YXEi
         poZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=fSRwvwhOM0DKy71IgTaPgffXf+6iMoKDxt2k6I15FTE=;
        b=MZ98LoAGcepa9fzBqpDWoGT5Mleugd9uzt4rNHob2DVmEZehcvQX5IjLoFzb/1aCt/
         yR+i8bj+NGvptu8T35X5PvMoy9Un57a4ZnfQOnqfbfS5sMoF7RW4BqsDjWJXBOzaOydw
         y44Nf4a/dfuEpqswHmgK9rpBAsG4LrmYz98SM0ArUsJNCpcwO5mkSAO86//BQ1kXvB4w
         WXYqViQOF8FFgcikdKxkQTJK8IGEkdn9Z+BOfpswCfV/12QVGbjMRj6F9DJ0WhFnUGzV
         +EsO0GCeMyVYH2EcLIjx6TimiJ+/8n80YdeNwUi9zvFo0Px2DJilNVRfS1L5AzYbACxq
         OjYw==
X-Gm-Message-State: APzg51AY6qqCh6hZ5ld0O0vCeknU8dII0ehqSs+g6VQvL1Pse0tFj0BJ
        qNHE9CYEClyULuR9bhHiXPnqp/Y4HvnPQIiNLa/JnSAT
X-Google-Smtp-Source: ANB0VdZu+LVCDutMGC9UgeG8i9oJsUb18Lj7GKS/RrJ6G30TNiZ+ZbM3USq+DNa4nwlQz0BXS9UrfxZ5cXjmrqFdm1E=
X-Received: by 2002:a50:baae:: with SMTP id x43-v6mr11836545ede.65.1537535914805;
 Fri, 21 Sep 2018 06:18:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 21 Sep 2018 15:18:23 +0200
Message-ID: <CAKgNAkhHYCMn74TCNiMJ=ccLd7DcmXSbvw3CbZ1YREeG7iJM5g@mail.gmail.com>
Subject: Cgroup v2 bug: "domain invalid" node can't be converted to "threaded"
To:     Tejun Heo <tj@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Amin Jamali <ajamali@pivotal.io>,
        Joao De Almeida Pereira <jpereira@pivotal.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

While experimenting with cgroups, we've found what looks to be a bug.
I eventually simplified this to what I think are the minimum steps to
demonstrate the issue.

The following shell session demonstrates the issue:

[Kernel was booted with cgroup_no_v1=all]
# cd /sys/fs/cgroup/unified
# cat cgroup.subtree_control    # show that no controllers are enabled

# mkdir -p mycgrp/a/b/c
# echo threaded > mycgrp/a/b/cgroup.type

At this point, the hierarchy looks as follows:

    mycgrp [d]
        a [dt]
            b [t]
                c [inv]

Now let's make node "a" threaded (and thus "mycgrp" s made "domain threaded"):

# echo threaded > mycgrp/a/cgroup.type

By this point, we now have a hierarchy that looks as follows:

    mycgrp [dt]
        a [t]
            b [t]
                c [inv]

But, when we try to convert the node "c" from "domain invalid" to
"threaded", we get ENOTSUP on the write():

# echo threaded > mycgrp/a/b/c/cgroup.type
sh: echo: write error: Operation not supported

Your thoughts?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
