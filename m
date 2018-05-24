Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163053-2-10496633231119176873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163052; b=lGurTzDk4hFlX8C6nPjzrgVtq9nFVo2P2ZiVE+pEJowderHCB4
    C1/r/zD/Fw5ALZLaAJT9SLQEvN4KQremJP6gkAN84ZPLZ+JaUQIZZrAXFTWcNGZz
    oggJGXHLsfDgL+cr/wFpzEAzKccNVO9ZnuUzT20z2R1eQ7C057/H4/6zVVgIUGbl
    2TjlRYrmqal6KWKqXywByFpKSCcNY/EnxC0jtAMkPbAmMXH1PVBMU3acTxxrkdh+
    mmPEwkLb101iu+YYYDkFbttPSocsLEP0qG77z+JTnk2BqcGU0vpkIjrX9tXvKIgy
    BQwrVXz/2nG4WIlCpQajZv54qk9Y58VaqQgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163052; bh=Z4ve07MOQKqKRVoXWIQF7MYVzqrb6O
    mZd10w/fn+aZU=; b=CXXvuVc+lJWuCoOSOt+WXFSSNPN6SiGp825XP/4LHkhx5Y
    fIi6HErvLzNMR+AvkIhNeeeUO3z9LrVYuFJzvPiEK8xWzan1Hi+scaNVqbtrv1b5
    bgc7l2GSB+1uWqFG5NBw9wF1rAOCBQre3PPP7h9oTH+SKyyOXf5rb+XecxurDiCR
    sWL8w2TKL8w+C+Dg9e6g7ph7oDDp4BKeI4pCNZya8seN7/N74uPuV3YB8Ewfq92j
    1KshIy3M9XZSHwqm8g+SodAEhTcudSlHhlzUMEkjxCSaS4rFF4xVYMKgcFLPvwk2
    ENTO/vhOtNlwPKeUPe33J8cYzlX37oYYyrvJ4qXA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=fl+X892e x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=fl+X892e x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEcwe/wZn3X7vaFpQR+MnTKH0qeQln/QWX2BjRX8a3x3ToTeliWbBRc+KVaBcdCHC96UTPdTjIy4pu87u5DfoYRfq1c8la0NrgwXElXDM3MiJoHM4yql
    tNYWvWFZnliFOZjcKNsE05eh2qWoUI0PFPqlRYhiA8N1yaj9/hiwr2hLPLvj9USnbjEZKOLhLCT7JIOK9ISoUFBsK2wzu7345fy58cajntvneQG8pfYSJFmp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8
    a=lUoSDrnz3zN8yKeRpAYA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966587AbeEXL5S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966813AbeEXJpl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 69/92] btrfs: fix crash when trying to resume balance without the resume flag
Date: Thu, 24 May 2018 11:38:46 +0200
Message-Id: <20180524093205.984977330@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 02ee654d3a04563c67bfe658a05384548b9bb105 upstream.

We set the BTRFS_BALANCE_RESUME flag in the btrfs_recover_balance()
only, which isn't called during the remount. So when resuming from
the paused balance we hit the bug:

 kernel: kernel BUG at fs/btrfs/volumes.c:3890!
 ::
 kernel:  balance_kthread+0x51/0x60 [btrfs]
 kernel:  kthread+0x111/0x130
 ::
 kernel: RIP: btrfs_balance+0x12e1/0x1570 [btrfs] RSP: ffffba7d0090bde8

Reproducer:
  On a mounted filesystem:

  btrfs balance start --full-balance /btrfs
  btrfs balance pause /btrfs
  mount -o remount,ro /dev/sdb /btrfs
  mount -o remount,rw /dev/sdb /btrfs

To fix this set the BTRFS_BALANCE_RESUME flag in
btrfs_resume_balance_async().

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3850,6 +3850,15 @@ int btrfs_resume_balance_async(struct bt
 		return 0;
 	}
 
+	/*
+	 * A ro->rw remount sequence should continue with the paused balance
+	 * regardless of who pauses it, system or the user as of now, so set
+	 * the resume flag.
+	 */
+	spin_lock(&fs_info->balance_lock);
+	fs_info->balance_ctl->flags |= BTRFS_BALANCE_RESUME;
+	spin_unlock(&fs_info->balance_lock);
+
 	tsk = kthread_run(balance_kthread, fs_info, "btrfs-balance");
 	return PTR_ERR_OR_ZERO(tsk);
 }
