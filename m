Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D69C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB7218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bv1fUhnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBFVNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:13:12 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35978 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfBFVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:13:11 -0500
Received: by mail-ot1-f41.google.com with SMTP id k98so14596434otk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0PgXjthxkZk3Ufdb1fh03uEwdbvqWjN/wnRUmZtQl2Q=;
        b=bv1fUhnZ6zhqHtJBG3t3vgVmkWWEleksggAv0l465s06NrRJRJxmwK6OzpJbKWtgK9
         zosOcAO+4CSMhASgfiulrdwiL9eoLhrGjP5AR7iyhR+brbB2PInE2bItnPtVQQA/VrZ+
         b9bHWosmKfHyvqDn0hyxXGjPsqbfhOCLtyfu2U/6MQz6G+ysDbF9D+RoSEBMPEOlgbdb
         gDn0YfgQQte/KuQipm6TqT47N/8MV6+49wHHJxN2UK0F9MUyY4KIOrhj/6yf+HmFkxG8
         n25jeLFpPhkb/Dsr+7BwFClbUjXPt6ogLCt1lw6uTTxbicdo+XxUHsvG+UT0zO34tIxz
         wHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0PgXjthxkZk3Ufdb1fh03uEwdbvqWjN/wnRUmZtQl2Q=;
        b=VgdrsRAyBuivSzYsRptoqr00szEZNY9Z0Bn0OklyYqZwTYO6FpAzmc4+aILfQjIsfy
         ThL4L6hA38VzHQIg6tJBN03/j/PFz7scibs0iqGteJBgNL/u1FV/Fnn0pzs4k26Mt11X
         61UrQhiebnquad9ZCvAAHVM+q0uTkgE4PuN1sjNgMULNXuZnoj6I2MxtTJ+aUsegDkWC
         XP+kMdhgSTz0ueSwnTvsNhoeXVa5nFE21HKPp3kyMv6jexLIXNiDJOSKFHMyprHSAIPZ
         SEVjdjVHo2zU3/wOzCJyKvmwXnCBghINEk6AcU9DzFEfNzCyRwT7IL+NazgKyo1Za14M
         wdkg==
X-Gm-Message-State: AHQUAuYSrw+Rk039orjH9trK6SB+6+uaalyBpdwCGZoX9bPI7w7GZ7bX
        j6EYuIb1Ay3rk+gjPpTxJe7Y0jsFRNDUtYCYJi70bUhkk8A=
X-Google-Smtp-Source: AHgI3IZr2WhfIPS7ltcZa19tvNkTX24MYpR2e1s55dnmMzDupLbTjZ4oLnmSquY4cQLdGIBLypdWBkeo6eIqr2YKfa8=
X-Received: by 2002:aca:240a:: with SMTP id n10mr665334oic.73.1549487590099;
 Wed, 06 Feb 2019 13:13:10 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Feb 2019 13:12:59 -0800
Message-ID: <CAPcyv4jyCDJTpGZB6qVX7_FiaxJfDzWA1cw8dfPjHM2j3j3yqQ@mail.gmail.com>
Subject: [LSF/MM TOPIC] The end of the DAX experiment
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before people get too excited this isn't a proposal to kill DAX. The
topic proposal is a discussion to resolve lingering open questions
that currently motivate ext4 and xfs to scream "EXPERIMENTAL" when the
current DAX facilities are enabled. The are 2 primary concerns to
resolve. Enumerate the remaining features/fixes, and identify a path
to implement it all without regressing any existing application use
cases.

An enumeration of remaining projects follows, please expand this list
if I missed something:

* "DAX" has no specific meaning by itself, users have 2 use cases for
"DAX" capabilities: userspace cache management via MAP_SYNC, and page
cache avoidance where the latter aspect of DAX has no current api to
discover / use it. The project is to supplement MAP_SYNC with a
MAP_DIRECT facility and MADV_SYNC / MADV_DIRECT to indicate the same
dynamically via madvise. Similar to O_DIRECT, MAP_DIRECT would be an
application hint to avoid / minimiize page cache usage, but no strict
guarantee like what MAP_SYNC provides.

* Resolve all "if (dax) goto fail;" patterns in the kernel. Outside of
longterm-GUP (a topic in its own right) the projects here are
XFS-reflink and XFS-realtime-device support. DAX+reflink effectively
requires a given physical page to be mapped into two different inodes
at different (page->index) offsets. The challenge is to support
DAX-reflink without violating any existing application visible
semantics, the operating assumption / strawman to debate is that
experimental status is not blanket permission to go change existing
semantics in backwards incompatible ways.

* Deprecate, but not remove, the DAX mount option. Too many flows
depend on the option so it will never go away, but the facility is too
coarse. Provide an option to enable MAP_SYNC and
more-likely-to-do-something-useful-MAP_DIRECT on a per-directory
basis. The current proposal is to allow this property to only be
toggled while the directory is empty to avoid the complications of
racing page invalidation with new DAX mappings.


Secondary projects, i.e. important but I would submit are not in the
critical path to removing the "experimental" designation:
* Filesystem-integrated badblock management. Hook up the media error
notifications from libnvdimm to the filesystem to allow for operations
like "list files with media errors" and "enumerate bad file offsets on
a granulatiy smaller than a page". Another consideration along these
lines is to integrate machine-check-handling and dynamic error
notification into a filesystem interface. I've heard complaints that
the sigaction() based mechanism to receive BUS_MCEERR_* information,
while sufficient for the "System RAM" use case, is not precise enough
for the "Persistent Memory / DAX" use case where errors are repairable
and sub-page error information is useful.

* Userfaultfd for file-backed mappings and DAX


Ideally all the usual DAX, persistent memory, and GUP suspects could
be in the room to discuss this:
* Jan Kara
* Dave Chinner
* Christoph Hellwig
* Jeff Moyer
* Johannes Thumshirn
* Matthew Wilcox
* John Hubbard
* J=C3=A9r=C3=B4me Glisse
* MM folks for the reflink vs 'struct page' vs Xarray considerations
