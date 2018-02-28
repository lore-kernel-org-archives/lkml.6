Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-420878-1519831409-2-17538136476424503989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519831408; b=dm5K36oc5ZhYWV25mroR77wHDdCLXzKTYsJKKesIzS315Rb
    mGstwGIEx89UWDIug45a60WRz+vr9lFYbiDioHa9bZk/a5P44oXCP7PYfyLvgjc2
    ias3cOlkMl3OgIt1c4ukSQHYtQmCvXkHk7AbCCqlILnJVTHYmNRfoJep/C1kW0X2
    AhP1/cqekft5GKwKi+vG/EtNRil1Ls9g/PwWrX/eF8fG/ie77SlMfoGiFG1sKHuS
    m/vp06/TNmBGKNSjwYIxay1sgh1KqsjholI9nQnjWz2q81+jiafgSOZ5DafOhJD7
    Mg8l3o7Yyl76/B5yBz4nFWPcBKokwSCVHTKqGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831408; bh=Y1z3YWmDxrgEVp1hhWx
    dYYOV0M+HYBm/qjSh4gx4CFk=; b=aNjVcdUuJMP+cmiU/WaT+ncZ4meCx68sV1i
    mEaqDKStJivLJVzwC+IlohJU8kD/xlMkRt5e49t8fOh40ObQ/B3WCQXrHrZDfQqM
    Ecfk5TWDuAFk8tH67Sc/RaTRssBeMaCQZyY9oQSMhxzx76WmDu/mlgghJ7YSo4e4
    2Tk/BzgJKum4iCU7ENahWmZUVCkYraPNWmNUKtCZmOSqhtUuGv5olfozO2hp0EDx
    ClfE+bWQfvaSfptlouiXIfjQVYxUJ8L6vPz8PGaOuRtYlydMJJwkOLQDS1W4WH/o
    Ml/F92XakzyxhRrGRlA7M4uoUmH0WT+IM5HHwDZgjDqB6B4v/+g==
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
        id S1752763AbeB1PX0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:23:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752892AbeB1PWq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:46 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Juan Zea" <juan.zea@qindel.com>,
        "Shuah Khan" <shuahkh@osg.samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.18292864@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 061/140] usbip: fix usbip bind writing random string
 after command in match_busid
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Juan Zea <juan.zea@qindel.com>

commit 544c4605acc5ae4afe7dd5914147947db182f2fb upstream.

usbip bind writes commands followed by random string when writing to
match_busid attribute in sysfs, caused by using full variable size
instead of string length.

Signed-off-by: Juan Zea <juan.zea@qindel.com>
Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/userspace/src/utils.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/staging/usbip/userspace/src/utils.c
+++ b/drivers/staging/usbip/userspace/src/utils.c
@@ -34,6 +34,7 @@ int modify_match_busid(char *busid, int
 	char match_busid_attr_path[SYSFS_PATH_MAX];
 	struct sysfs_attribute *match_busid_attr;
 	int rc, ret = 0;
+	int cmd_size;
 
 	if (strnlen(busid, SYSFS_BUS_ID_SIZE) > SYSFS_BUS_ID_SIZE - 1) {
 		dbg("busid is too long");
@@ -58,13 +59,15 @@ int modify_match_busid(char *busid, int
 	}
 
 	if (add)
-		snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "add %s", busid);
+		cmd_size = snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "add %s",
+				    busid);
 	else
-		snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "del %s", busid);
+		cmd_size = snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "del %s",
+				    busid);
 
 	dbg("write \"%s\" to %s", buff, match_busid_attr->path);
 
-	rc = sysfs_write_attribute(match_busid_attr, buff, sizeof(buff));
+	rc = sysfs_write_attribute(match_busid_attr, buff, cmd_size);
 	if (rc < 0) {
 		dbg("failed to write match_busid: %s", strerror(errno));
 		ret = -1;
