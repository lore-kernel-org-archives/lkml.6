Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4087485-1525655618-6-12548516862395843836
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525655617; b=VFo+EUBJhZDaVlq5VTrF+N175dILHu5rvPTxBil8SEzHXLR3zZ
    aPUo3ye7DPETcngWc3oQt9CpfJCxKVQ22NqiFS3lK+plBE8AfTUvIG/6WRQswudp
    UslmVj9/6kMmkAzPcvi4JaXfGBLxFeTYs/4499NEVO/g0RQxVIiH0vWtiyyJZq/c
    3FajKaL95d4C0cbo1iW2OlkeRl0NxIgFXrxSEB6GvpWfQXKIum7ebUA0OLH7eOK6
    9L0WJWtom6nnaJ3Cp3dY/EU2Q0TdI+Y9rgKIDyH/KHhkSOwQz6iiZp8cGMiXEOsp
    HvkHXdA9pfAljojnGOFh2gqAi0uU/Q0m71sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525655617; bh=FllLt
    jW6z0lAv7Oq8oHXa+P2fIUf/9xp8ug/K1F7LOk=; b=TpD02l6wcpE/4HXIii3Rx
    MV0AqKbr/6vCv5ZW3Le+z/Nk0fOhrDCne23l2e+BKNHBFLUFRn/LmPNHOO9U3sxc
    3UuLyqvgDsJI+vBgx+DevHQ0atrElARaOL8EmsPtEyT8+sZy6OSQ43RSI7EAlJTH
    XvF6Nx/MiNmmSqo9u7/zGhGZjk1dOp10IW5nIDNSIzOZfF1MEaTFPNUhNVr7opwn
    Kmwl1k7px5bh8TkMVoj4dbVeA9VLecM84I0h+LGuz2T6EGk5kSoVVwY5T0pTT3Lt
    evAOxNZdoqLVR8JPZCaoL+RPJbXJ9KS6DUQ5SjlbIYctgn92VUEN9FAUImoLlLH8
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=s4tVoyDc x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=p07LtaFw;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=s4tVoyDc x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=p07LtaFw;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFDe4lbURSeAH/9GwgSpcUzSJgFWWQr6357cUEV33VNsxtPrI3ZZi0YJjwO86n/nzoYRO02AgOr5txegjmZ2h5MkkpkYSNOrorIo5EecWuCVYLxJwvpX
    18Dgfd+maSfLY3IocWGN5f/vNSuyjpe9TT82KcJ18b/5XuI0hPr0awcc8dYXUfBrnToVK1unUyDHckGpOA5kCSkT1OvI2kQxFXLv0PSoy1RnkiKaG0ZHSZCE
    3hQ6Sk4cpBg8zCDit7GVwA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=vY_346TuTMEA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8
    a=DDOyTI_5AAAA:8 a=Y-UwauKDSEipVRvAVY8A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqDnEnxSc9do4CmhogBLXlG75+D0CXK/5a68mb55FoIvaAU1q6+6eEJkf4/ZwuUM3s7NMF/QA==
From: Nathan Chancellor <natechancellor@gmail.com>
To: devel@driverdev.osuosl.org
Subject: [PATCH 3/6] staging: android: vsoc: Fix ending '(' warnings in
 function defintions
Date: Sun,  6 May 2018 18:13:25 -0700
Message-Id: <20180507011328.11982-3-natechancellor@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180507011328.11982-1-natechancellor@gmail.com>
References: <20180507011328.11982-1-natechancellor@gmail.com>
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Martijn Coenen <maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fixes checkpatch.pl warnings about lines ending with parentheses.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/android/vsoc.c | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 6ef7a011d789..b5307fa584d3 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -148,13 +148,13 @@ static int vsoc_release(struct inode *, struct file *);
 static ssize_t vsoc_read(struct file *, char __user *, size_t, loff_t *);
 static ssize_t vsoc_write(struct file *, const char __user *, size_t, loff_t *);
 static loff_t vsoc_lseek(struct file *filp, loff_t offset, int origin);
-static int do_create_fd_scoped_permission(
-	struct vsoc_device_region *region_p,
-	struct fd_scoped_permission_node *np,
-	struct fd_scoped_permission_arg __user *arg);
-static void do_destroy_fd_scoped_permission(
-	struct vsoc_device_region *owner_region_p,
-	struct fd_scoped_permission *perm);
+static int
+do_create_fd_scoped_permission(struct vsoc_device_region *region_p,
+			       struct fd_scoped_permission_node *np,
+			       struct fd_scoped_permission_arg __user *arg);
+static void
+do_destroy_fd_scoped_permission(struct vsoc_device_region *owner_region_p,
+				struct fd_scoped_permission *perm);
 static long do_vsoc_describe_region(struct file *,
 				    struct vsoc_device_region __user *);
 static ssize_t vsoc_get_area(struct file *filp, __u32 *perm_off);
@@ -203,14 +203,14 @@ static inline phys_addr_t shm_off_to_phys_addr(__u32 offset)
  * Convenience functions to obtain the region from the inode or file.
  * Dangerous to call before validating the inode/file.
  */
-static inline struct vsoc_device_region *vsoc_region_from_inode(
-	struct inode *inode)
+static
+inline struct vsoc_device_region *vsoc_region_from_inode(struct inode *inode)
 {
 	return &vsoc_dev.regions[iminor(inode)];
 }
 
-static inline struct vsoc_device_region *vsoc_region_from_filep(
-	struct file *inode)
+static
+inline struct vsoc_device_region *vsoc_region_from_filep(struct file *inode)
 {
 	return vsoc_region_from_inode(file_inode(inode));
 }
@@ -250,10 +250,10 @@ static struct pci_driver vsoc_pci_driver = {
 	.remove = vsoc_remove_device,
 };
 
-static int do_create_fd_scoped_permission(
-	struct vsoc_device_region *region_p,
-	struct fd_scoped_permission_node *np,
-	struct fd_scoped_permission_arg __user *arg)
+static int
+do_create_fd_scoped_permission(struct vsoc_device_region *region_p,
+			       struct fd_scoped_permission_node *np,
+			       struct fd_scoped_permission_arg __user *arg)
 {
 	struct file *managed_filp;
 	s32 managed_fd;
@@ -344,9 +344,9 @@ static int do_create_fd_scoped_permission(
 	return 0;
 }
 
-static void do_destroy_fd_scoped_permission_node(
-	struct vsoc_device_region *owner_region_p,
-	struct fd_scoped_permission_node *node)
+static void
+do_destroy_fd_scoped_permission_node(struct vsoc_device_region *owner_region_p,
+				     struct fd_scoped_permission_node *node)
 {
 	if (node) {
 		do_destroy_fd_scoped_permission(owner_region_p,
@@ -358,9 +358,9 @@ static void do_destroy_fd_scoped_permission_node(
 	}
 }
 
-static void do_destroy_fd_scoped_permission(
-		struct vsoc_device_region *owner_region_p,
-		struct fd_scoped_permission *perm)
+static void
+do_destroy_fd_scoped_permission(struct vsoc_device_region *owner_region_p,
+				struct fd_scoped_permission *perm)
 {
 	atomic_t *owner_ptr = NULL;
 	int prev = 0;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
