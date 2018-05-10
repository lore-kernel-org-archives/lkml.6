Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2910789-1525994050-2-12655933975684391083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525994049; b=b/CRduDN8DyKK2H9LoKkr0qMv3iKNRl8I2Y1QrqxVMVw+YSPs9
    tioLsJxYXCecEmOB2Dv2UUxnxH5fas4C2qwvL3Th2FGpFjXJQQdCPaYKR1A4jI9+
    ie91W7sO8fLnynQU3uc/byfHsGsQ+hRHRNBCqbBsxCJokjtiUVeYb51adk5OcUOl
    PlnP3Q2amFlFui2edaC4h5YGbhdu6izmfFQSPfrtLn38bpMMO40kx/T06NWO74Y5
    H3j86lIWq3nfy4++gE0IalYJMzPOSvxiTxsk70CSklDFWydfKfMbOpBX81X2fwCK
    9M+PEgBakumfaWcx63S31Q3tVNk1nKLi4YkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525994049; bh=e4WIlOtBqwee5Tnvfvo+gE9rbSFRSB
    hZx8IRGLrTDH8=; b=D4IEvKfzTldZTHAj/QBwCXFohbTNySkNPQwVfSn2te1nHP
    dm4ScKxIjwAZLcnsqFjgGsGdzBfL+8LavS95bu5WQ6GPCGX/jhbnL3RqGPnkm1ar
    +lqaqo5Fgf3v7t+EIw6y/BZ7JpolxzYpTyLsIcHhPPtqVaoePhFTemlAAl5E8s7r
    XBg6XC8QNqn53u9sXCGMaxzkEghRWGA99M1IlkKEb6EgkqiG29FTPmwOPTQxEmxm
    AMSAVKG1WCkO8FB2GKn/9JBPKVWTMMP65pT8dH2UVbIxFx1MXBO8Q8KFaPC5kNTK
    L+a59w8D1Ndql6pmmlM62JSLWaZ31E9U63Gk68YQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=yPxvot4U x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=yPxvot4U x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAEdtjm0cY8MBPA0Uo6jaxh5ywQeTK1zO86Sf9hl2aaVRvTqE3G1IzgohhDTz7DY6W7LRg8sHNzQ8JhggFmg0qHqkPTTDlJoSsOV6f7c1/SPCu+kc1eQ
    RHlL8llpzDbgTMCQvQHmu8OZgBrTLdcOoLwUVXDJI9D7KNtAqD0XCookAKsO3m78ykw4ApEh+EEC74qIVMScphZB47wYcxFsZJLMYpaLC8MEP1ZDZeOdZQqR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=sHSQHrWPfPTVjrii0YcA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeEJXOH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750751AbeEJXOG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 May 2018 19:14:06 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com
Cc: sandeen@sandeen.net, dhowells@redhat.com, fliu@suse.com,
        jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 0/4] vfs: detect symlink corruption with attributes
Date: Thu, 10 May 2018 16:13:55 -0700
Message-Id: <20180510231359.16899-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Filesystems which detect symlinks with append/immutable should inform
users their filesystem is corrupted and their respective filesystem
checker tool should fix this.

In lieu of this though users may be stuck with pesky files or
directories which they cannot remove. We cannot expect all filesystems
to be updated to address this, so since the VFS does not let filesystems
set these attributes -- let the VFS enable users to remove symlink with
these attributes, but also provide a fallback warning, in case the
users's own filesystem does not catch it.

Sending again as RFC as this just goes compile tested so far, and it
is still unclear if this is the direction we want to go with this.

v2:

As per Darrick, even though the VFS should probably allow not so popular
filesystems to delete corrupt symlinks with append/immutable -- popular
filesystems should check for this themselves and inform the users of
corruption. These filesystems should have their respective filesystem
checker tools updated to correct this as well.

v1:

Sent out a single patch just to ignore the append/immutable attributes
set on symlinks.

Luis R. Rodriguez (4):
  vfs: skip extra attributes check on removal for symlinks
  xfs: add verifier check for symlink with append/immutable flags
  ext4: add verifier check for symlink with append/immutable flags
  btrfs: verify symlinks with append/immutable flags

 fs/btrfs/inode.c                   |  9 +++++++++
 fs/ext4/inode.c                    |  7 +++++++
 fs/namei.c                         | 24 ++++++++++++++++++++++--
 fs/xfs/libxfs/xfs_symlink_remote.c |  5 +++++
 4 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.17.0

