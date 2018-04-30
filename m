Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525129003-6-11431755569305126249
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525129002; b=IK936Jc9r3CIC12UUjtho3r6dExeKQXp9EHaYVdDbV6nbg62tA
    fPJv4rjTJ6SBCc8+xcPHzwRzvh0ciNAGgA2iksEN5ZJkWoH5h4CXafJRt5B3z8Lg
    6Dybj61K7bopR6sgD4u6mqbkYsZg+tPWJe8zUqLwAaFQOCHvPQIzI+OBgD6jyd24
    kvvechxlUfcWbUgapAkyeHYRzsQWHI+VFfZPfG5Z3Mwus9dhSL9sEU3LyQ4sSj0R
    Ua+UY6oTZ60he+6vF88BcRg9A1L+7TZE2vIo/EqRKG1uzaIijCMN9bp0kRqCZj+c
    wwKxzSHJAu7sIqvXOR4obq3QzwVBQbZMMxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525129002; bh=NM08I
    FVgPT+EoWz5PZRZkCszOMTwW0GF2Qn8IPhav1M=; b=XfZfHc5C79XwFYuSF0kfs
    OW20NWQ3pxErG/5smpUE/Bsh4CQTzCK2cVWYMYcihFa5xTrGzGwdz1rfLR7aSw67
    niZOUfF6Fbyb1LAUxUzIWe2ccsP5uXKpZEAoubMzpA2atF0W5n+Lsl5+zbxIlmKj
    E14G9KVFoen2swumrUOuiR2nkzX4rx79kl5VCebaAJs2QmgafNjW5pdBwszIP+bz
    eqWJZomAGVW6mvxKw3f1qiNgK/WR4hx4LgBS6fljNzit3tZmPUq5nTTcN6Qxyhqf
    rE7Lx10zVI8SmqQsBtXi7HKTi0kDzMyKJ+teSzEn5Ff0k9gKJx6U+FWsHJd46zK+
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=umn.edu header.i=@umn.edu header.b=FfRG/QfK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tr0iaHee;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=umn.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-85 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=umn.edu header.i=@umn.edu header.b=FfRG/QfK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tr0iaHee;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=umn.edu header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNZ3l/M8Rr5S2xAqLwBSQwIUz2ICHrpxlrSvRF/7rG6vmKSEDXAe/6nyWUpOPjBISTexeWBJQT3NLA0BGlBCnSP4wFMzk+PY8PGMdjlFjGbwVxuSNKSA
    QpluVb2gYs20HwBoISiGEuh6FdtFXFCA+d31Z1pfsmoo5MGqJpwlT//1zfrIFGNANn3YveBGDdZ74j6JxKGi8kqHjBkfV53rGBdJu4ZEs5sWdmjE2z6Gf2Si
    /PnqVm+1iGpoF69CuczwqA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=KWp4I6BPwhDTIPqJYpIA:9 a=FUxDmg5hsxb7-LyT:21 a=yi8e6WHvIafMrYml:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrRbYybn42pT7wQWkTqe8anF/ZyxKNI9hSLeYdvcck0OFVbQW1TJ3iPVl2FhyOnq0x9NVxDlA==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH v2] staging: lustre: llite: fix potential missing-check bug
 when copying lumv
Date: Mon, 30 Apr 2018 17:56:10 -0500
Message-Id: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Roman Storozhenko <romeusmeister@gmail.com>,
 Andreas Dilger <andreas.dilger@intel.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In ll_dir_ioctl(), the object lumv3 is firstly copied from the user space
using Its address, i.e., lumv1 = &lumv3. If the lmm_magic field of lumv3 is
LOV_USER_MAGIC_V3, lumv3 will be modified by the second copy from the user
space. The second copy is necessary, because the two versions (i.e.,
lov_user_md_v1 and lov_user_md_v3) have different data formats and lengths.
However, given that the user data resides in the user space, a malicious
user-space process can race to change the data between the two copies. By
doing so, the attacker can provide a data with an inconsistent version,
e.g., v1 version + v3 data. This can lead to logical errors in the
following execution in ll_dir_setstripe(), which performs different actions
according to the version specified by the field lmm_magic.

This patch rechecks the version field lmm_magic in the second copy.  If the
version is not as expected, i.e., LOV_USER_MAGIC_V3, an error code will be
returned: -EINVAL.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
---
 drivers/staging/lustre/lustre/llite/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/lustre/lustre/llite/dir.c b/drivers/staging/lustre/lustre/llite/dir.c
index d10d272..80d44ca 100644
--- a/drivers/staging/lustre/lustre/llite/dir.c
+++ b/drivers/staging/lustre/lustre/llite/dir.c
@@ -1185,6 +1185,8 @@ static long ll_dir_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (lumv1->lmm_magic == LOV_USER_MAGIC_V3) {
 			if (copy_from_user(&lumv3, lumv3p, sizeof(lumv3)))
 				return -EFAULT;
+			if (lumv3.lmm_magic != LOV_USER_MAGIC_V3)
+				return -EINVAL;
 		}
 
 		if (is_root_inode(inode))
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
