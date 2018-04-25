Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653182-2-2450675153035306047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653181; b=pnHgFeqr5DxpuOEoAu+usmbJQYxnejqqNifSuwlfCZIF1N9nuW
    XS7dFDEuuDLbMl5Iw5aG37gg1h19unQ+RFaDy2tjpVKHnnUFqmY/v4kOsLNUW0DM
    JyThEs1Jzk3R/yp1beram1d2bsQjJaOxdRA9xJ2YDmgJa+9w16WbEX+skGRsEknW
    AKlcgzXRuy/pvmgylcBN8dHV25tp2h15ZZge/fIUsZ6VdoYVT+QbMslsZ/JTux8K
    vZGJTK2C4D/XxyX3ZGORFsvWEiAX+kajHXwYc7dNpv0Jux0cMJ+dMOQIR5nXMUtv
    hMIVOMnenG38RCisgxXqr0O1nHic0xJsgksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653181; bh=iqmosItVENiu+6VprPjNMTXTZhD3yh
    Sg5/pOW+Pb/O4=; b=Z3bvy/M67XxIERKcKqw/WvUrVJshPp7uDy0Ntlsc12/PEX
    s3mC2lSeaMiGXO1vP0dRc1Zv9+u7k0vVaP9lM3P3jkFdRAOf+RjYt/Zk2OZrhHiU
    Tv0/jTiXW60umgfQwpjORIE9+AwscCZ72zLPdK5RPf8rZi6qIcObc3zdNGYEMdli
    9Rc3fq8PWTJ92SEC8RVX16ia4sb1c6Iq8nhy6bZ9vhFB84+qcp6JVHy6ERepgGgT
    V3+GlaFfwp4ml4FZLkyZ9+hj8nnNhlCtKaOxwqSjDSWRw10cln+eFgyyl46fJV7j
    r+k7SVR82/ZlrPMUkFLDAEcIi9+4AfEuoSLksUtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCcuON1f+/L7oYtUOlc31Ccak5HLw/grE8Ct5yhkYMxZMjZ8h3dLw329snT/MzI82kMCzoh5lK/QDVDulpPEuaVBSD4toXFQnJhqfr8HXC1Z+b5JLIND
    nTHjV++8PpAfkyUFx0BH4glsalk4GMhcdgHFAdZlglI/eTw9HIpE0/obwlGQd9Sc1CEU1EPpyEDXSlNKJXYF3iKdGYzqS5+DmqIWELCFR2TCGyrlkPHkM+/D
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=blYj7uNOJKGU-zgziaUA:9 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeDYKpK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:45:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754034AbeDYKpF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:45:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 149/183] bcache: fix for data collapse after re-attaching an attached device
Date: Wed, 25 Apr 2018 12:36:09 +0200
Message-Id: <20180425103248.522789608@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui@zte.com.cn>


[ Upstream commit 73ac105be390c1de42a2f21643c9778a5e002930 ]

back-end device sdm has already attached a cache_set with ID
f67ebe1f-f8bc-4d73-bfe5-9dc88607f119, then try to attach with
another cache set, and it returns with an error:
[root]# cd /sys/block/sdm/bcache
[root]# echo 5ccd0a63-148e-48b8-afa2-aca9cbd6279f > attach
-bash: echo: write error: Invalid argument

After that, execute a command to modify the label of bcache
device:
[root]# echo data_disk1 > label

Then we reboot the system, when the system power on, the back-end
device can not attach to cache_set, a messages show in the log:
Feb  5 12:05:52 ceph152 kernel: [922385.508498] bcache:
bch_cached_dev_attach() couldn't find uuid for sdm in set

In sysfs_attach(), dc->sb.set_uuid was assigned to the value
which input through sysfs, no matter whether it is success
or not in bch_cached_dev_attach(). For example, If the back-end
device has already attached to an cache set, bch_cached_dev_attach()
would fail, but dc->sb.set_uuid was changed. Then modify the
label of bcache device, it will call bch_write_bdev_super(),
which would write the dc->sb.set_uuid to the super block, so we
record a wrong cache set ID in the super block, after the system
reboot, the cache set couldn't find the uuid of the back-end
device, so the bcache device couldn't exist and use any more.

In this patch, we don't assigned cache set ID to dc->sb.set_uuid
in sysfs_attach() directly, but input it into bch_cached_dev_attach(),
and assigned dc->sb.set_uuid to the cache set ID after the back-end
device attached to the cache set successful.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/bcache.h |    2 +-
 drivers/md/bcache/super.c  |   10 ++++++----
 drivers/md/bcache/sysfs.c  |    6 ++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -906,7 +906,7 @@ void bcache_write_super(struct cache_set
 
 int bch_flash_dev_create(struct cache_set *c, uint64_t size);
 
-int bch_cached_dev_attach(struct cached_dev *, struct cache_set *);
+int bch_cached_dev_attach(struct cached_dev *, struct cache_set *, uint8_t *);
 void bch_cached_dev_detach(struct cached_dev *);
 void bch_cached_dev_run(struct cached_dev *);
 void bcache_device_stop(struct bcache_device *);
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -939,7 +939,8 @@ void bch_cached_dev_detach(struct cached
 	cached_dev_put(dc);
 }
 
-int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c)
+int bch_cached_dev_attach(struct cached_dev *dc, struct cache_set *c,
+			  uint8_t *set_uuid)
 {
 	uint32_t rtime = cpu_to_le32(get_seconds());
 	struct uuid_entry *u;
@@ -948,7 +949,8 @@ int bch_cached_dev_attach(struct cached_
 
 	bdevname(dc->bdev, buf);
 
-	if (memcmp(dc->sb.set_uuid, c->sb.set_uuid, 16))
+	if ((set_uuid && memcmp(set_uuid, c->sb.set_uuid, 16)) ||
+	    (!set_uuid && memcmp(dc->sb.set_uuid, c->sb.set_uuid, 16)))
 		return -ENOENT;
 
 	if (dc->disk.c) {
@@ -1190,7 +1192,7 @@ static void register_bdev(struct cache_s
 
 	list_add(&dc->list, &uncached_devices);
 	list_for_each_entry(c, &bch_cache_sets, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
 
 	if (BDEV_STATE(&dc->sb) == BDEV_STATE_NONE ||
 	    BDEV_STATE(&dc->sb) == BDEV_STATE_STALE)
@@ -1712,7 +1714,7 @@ static void run_cache_set(struct cache_s
 	bcache_write_super(c);
 
 	list_for_each_entry_safe(dc, t, &uncached_devices, list)
-		bch_cached_dev_attach(dc, c);
+		bch_cached_dev_attach(dc, c, NULL);
 
 	flash_devs_run(c);
 
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -265,11 +265,13 @@ STORE(__cached_dev)
 	}
 
 	if (attr == &sysfs_attach) {
-		if (bch_parse_uuid(buf, dc->sb.set_uuid) < 16)
+		uint8_t		set_uuid[16];
+
+		if (bch_parse_uuid(buf, set_uuid) < 16)
 			return -EINVAL;
 
 		list_for_each_entry(c, &bch_cache_sets, list) {
-			v = bch_cached_dev_attach(dc, c);
+			v = bch_cached_dev_attach(dc, c, set_uuid);
 			if (!v)
 				return size;
 		}
