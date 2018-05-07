Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488117-1525681280-2-4607489692768523738
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525681280; b=RsFvj+D6OtkLd7kXGawxISJljl4i9GcS1aC3cjuthvlixHK6qJ
    Z2Mb18cRJJxUmdgUGJvjw3X/U0sWfS5V9ArnjsmzkH/0SEoHoJDwn3Dgqq6GA8qa
    Gdg3wBoD6QG/Zhp2FRgWx+wvCsQQdsi/VEvZI00N+fc4stn4qCqIOj13Ywg/2PBE
    FPZGsfym0kwyF+tSX1y58o5eCJRE3OsP4dgFC5C6hT549lFqcQXovgv0Q7Nk4jCY
    bSvN2ZlMu0vxpi28/pVIVRCBnWol73aphYNbys9VQn1Svd3XrxIEPnILgXlFym0/
    KS1ajGoOpgQcbbZDiQo1vrXOi6GlWMjFgZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525681280; bh=7iS9z6QfKCeT5DTUAul2X7aQrHimte
    CljNMKa4qx46k=; b=h3k/9Dt0kZfmVaSJkbtuiSgCldb9MxVUO77wRioAN/MaKJ
    LcQ7DAYOr+4ckee2mtSJ1XOz94aKRTvBVboHpoGSa55xSHM7xt5+n5kEHSkCQ5lC
    eeWykV5iBgBnvJHEePLQkuCGx+5nwPVoN5Ks9V0HbFqBllJzfZudPKDRAzRYCjwb
    Pi5MKXqHCMAcxgL2TCMyiow9Uv9MSbP0SQCoV2zC5R+jwkS+PfUJMD1Jv56KWxDA
    kAvlmRKc6kaqEo59JOdqtk3CNE54gG6naSTKEyCMT0i2I0Y+DQPvVWZfMXx4Mp2K
    EM/CoS46cu6zl6HB00kp3l6p1Q2VNGZQWRbUga1A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=A7Pt3tlT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=A7Pt3tlT;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMO9RvA11Dwmp47eulBIEIqHmsNfy2fpHS68OrC9uTKh1MhTf2dzICRh0X3+X7k5K0sfts9+7wtEv7r9tudjAk8RKDiMO2+B9QlW+8vEunlCBQshrN2U
    E/ip+VeTn3m4ncj9UjGpWYnR++xz7GQWRZ3YgqFYB3iHQjDOhiTrL8N9A7jwJ53ddPM3ey08DNmZkuG7HMb5fqq06dRkNMv/6gCgG/786d7FUWAddU5T3fpi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=q75l-hZdVcqO2UtYMS0A:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeEGIVQ (ORCPT <rfc822;linux@kroah.com>);
        Mon, 7 May 2018 04:21:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32919 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeEGIVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 May 2018 04:21:14 -0400
X-Google-Smtp-Source: AB8JxZq1NRr22m9FZXRG8DSThV+Z4wQzsyRTWtE1Ntvslyk30+eBMFaMzgdq7kdTdvK+ua/9KKR40g==
From: Miklos Szeredi <mszeredi@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 0/3] vfs: dedupe: cleanup API and implementation
Date: Mon,  7 May 2018 10:21:05 +0200
Message-Id: <20180507082108.28186-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Al,

Please apply this is a small cleanup/fix series.  It is also a prerequisite
to the overlayfs file stacking patchset.

Git tree is here:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git dedupe-cleanup

Thanks,
Miklos

---
Miklos Szeredi (3):
  vfs: dedpue: return s64
  vfs: dedupe: rationalize args
  vfs: dedupe: extract helper for a single dedup

 fs/btrfs/ctree.h   |  4 +--
 fs/btrfs/ioctl.c   |  6 ++--
 fs/ocfs2/file.c    | 10 +++---
 fs/read_write.c    | 91 ++++++++++++++++++++++++++++++------------------------
 fs/xfs/xfs_file.c  |  8 ++---
 include/linux/fs.h |  2 +-
 6 files changed, 65 insertions(+), 56 deletions(-)

-- 
2.14.3
