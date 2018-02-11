Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324299-2-2466415216288647618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324298; b=dYyhBlyeNrRFxsBOMJM2L1M0W2D63UBKjrS3NIgNSB4uECx
    mEUEHXUCQSbiMNqupU5PMssPJ0cPX/hdlLALNLHz4mSXckf6Ia9pV95OzH9ceWsA
    4cHW9ES+0hYzONHE1rx+aHrKRxtF7TFkjRREtepWCOXJRFWZJkiLv96O1LGqTp8a
    o2BhySM5QWN4U53bisapOCCymnvzrU9oqjhJHNrPeKjMvJJHmT6wSPm1HoHPdwfL
    vF3LEDkuElYUvyMOIYTqpVwlSfKN/KvF5i4x4fpV5PELxJBTszvYM2F+etnghhwn
    vvaxZS/WoW0n60lLINsu59SVoeEbi0/8EGxZMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324298; bh=JRG144OaGBn2ysYfTZg
    DLWGaq+3J4bsbD6k49QUWJRQ=; b=B9/kzCEXtYfipLMqArdBibv4S+FnnmNY7Mi
    MSGWyit6lmVUfu7I8+OxjbhvpHYbGPItf8knpqyW8fJ0xMkrsnmsDl35xCAgvL6J
    QXcePAqrOgaZn3T6XU849cgeq343hivWFjWoUVwhtwAPNZRz0wmRXWS9Ee4Gk7Mu
    eN9JysrjbInfcvNRLPCvIIBv3n2i7IXc/W9poj3azLJCog9H82lYAsxw+8d+8YMQ
    91djpz1BpoUc9r4XAO1iLPs1zb66tsQB4DmdQZ2WWHdfoWGljbYCjTuwYvZmFmka
    H1wWqqSMSlnJ1Tgxp6gOn6C5zpe7pA9csNxYQvgUU/0oIdv+EPw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeBKEnE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:43:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41895 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752874AbeBKEd7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Hou Tao" <houtao1@huawei.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.413876914@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 074/136] dm: fix race between dm_get_from_kobject()
 and __dm_destroy()
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

commit b9a41d21dceadf8104812626ef85dc56ee8a60ed upstream.

The following BUG_ON was hit when testing repeat creation and removal of
DM devices:

    kernel BUG at drivers/md/dm.c:2919!
    CPU: 7 PID: 750 Comm: systemd-udevd Not tainted 4.1.44
    Call Trace:
     [<ffffffff81649e8b>] dm_get_from_kobject+0x34/0x3a
     [<ffffffff81650ef1>] dm_attr_show+0x2b/0x5e
     [<ffffffff817b46d1>] ? mutex_lock+0x26/0x44
     [<ffffffff811df7f5>] sysfs_kf_seq_show+0x83/0xcf
     [<ffffffff811de257>] kernfs_seq_show+0x23/0x25
     [<ffffffff81199118>] seq_read+0x16f/0x325
     [<ffffffff811de994>] kernfs_fop_read+0x3a/0x13f
     [<ffffffff8117b625>] __vfs_read+0x26/0x9d
     [<ffffffff8130eb59>] ? security_file_permission+0x3c/0x44
     [<ffffffff8117bdb8>] ? rw_verify_area+0x83/0xd9
     [<ffffffff8117be9d>] vfs_read+0x8f/0xcf
     [<ffffffff81193e34>] ? __fdget_pos+0x12/0x41
     [<ffffffff8117c686>] SyS_read+0x4b/0x76
     [<ffffffff817b606e>] system_call_fastpath+0x12/0x71

The bug can be easily triggered, if an extra delay (e.g. 10ms) is added
between the test of DMF_FREEING & DMF_DELETING and dm_get() in
dm_get_from_kobject().

To fix it, we need to ensure the test of DMF_FREEING & DMF_DELETING and
dm_get() are done in an atomic way, so _minor_lock is used.

The other callers of dm_get() have also been checked to be OK: some
callers invoke dm_get() under _minor_lock, some callers invoke it under
_hash_lock, and dm_start_request() invoke it after increasing
md->open_count.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2912,11 +2912,15 @@ struct mapped_device *dm_get_from_kobjec
 
 	md = container_of(kobj, struct mapped_device, kobj_holder.kobj);
 
-	if (test_bit(DMF_FREEING, &md->flags) ||
-	    dm_deleting_md(md))
-		return NULL;
-
+	spin_lock(&_minor_lock);
+	if (test_bit(DMF_FREEING, &md->flags) || dm_deleting_md(md)) {
+		md = NULL;
+		goto out;
+	}
 	dm_get(md);
+out:
+	spin_unlock(&_minor_lock);
+
 	return md;
 }
 
