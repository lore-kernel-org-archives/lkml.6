Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3969059-1525419013-2-18266231015777023641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525419012; b=mnJiaobJS6WqwlYuEq9Cw8GEhbz0eOrWygoqKkdVh5iru9VMjO
    rD4ukLXxhkyenME4+QLEDkvsFZgLbgDUmkOCXMxlA8BMbjo9euu6fnY5q3FFo3Vx
    BkrYWqgYFlGaKNQYewtra36GK3dYqv0DbhU7XIVQIPrMlM3W6d3KfVvQOIZbnPLr
    BwFiZBSr01ILD9DDl4w+U8E4y7uA0Blc3FkXt+/r6Y2T8GkUu37VnDxvXN2ZxIFd
    MwOPQV9UTbss+26g3Ov06c7MZ+WewUz9E8IQoBtjIEcTfwg49Usm8Q9vVUf9QzmD
    w4Dczu2zRbZvWgLZZn6jbrlXAd/+Q0g8Okdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525419012; bh=k7gHW
    FKo3NRwd1DewYZXTo5S+VsHFtNnpL1hiqbvdvQ=; b=PmiZY0eqYqvgGWTlrT+5R
    eRvg9t2PM8wo57tWi7wi3O28bLL99aUBQf1dnRzfvpWLwIZt1nBSlKSfy+DcW/L0
    3a4jFMtoJa5gQFJFijgVWO1g4hUX9rsoELhXExvYNWjLN43GSkCvk+aZ3psMHa8P
    X8RxYPJGgdplEmF/9mHSvOOkuv4NTLw9/WgZ5k8b4LehgiZ26iO87AUWpJoxLSA5
    gM2wj8BG9yVnwDSuTPQzvRVE0MdJib+QO3B/0LdAowfB77aSws6/CTohCDN2dKAk
    MfYkC/ViON+pxSApTBb9rRYQkv/M3dl2ZhlCo5ulLYKF3S7m+XdSaEiYRnm3/Z3l
    Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=umn.edu header.i=@umn.edu header.b=I/MKawXf x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ezYJRmOs;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-85 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=umn.edu header.i=@umn.edu header.b=I/MKawXf x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=umn.edu;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ezYJRmOs;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=umn.edu header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-85 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIalSRlKrdRsnTftelTWLmfCiOHn4xk6AM+uL7y8RXcgafDXwOQgJ6OMMVVuib6uzfiyIjMfJzC3GxFbrjYi3tjOYTealhunbge2qZBr9UEzhO+9Hdff
    xqkgwulv0iVxfOVpOsQ7tnmTLgATbLFEiZWbuTSahI71lsaR5hkc3OFDOhnfEoru1mtpl3Ed7dfh6NrX+M59A7MO3KWtFn8PQjloH6tx+Mo2E5XJjgj+XGgH
    pfzSqNjaVLeGWQYZf5GIaA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8
    a=UOqyD728wtIlDOF3Wv8A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=IfwFsOU2cUPMhbyG:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpzrqG0GM5f4IPT+hQmpRpNTLu5ZNGKORouzoSeNlh5Fe2yTQC7mjFbINva3KjlFlyF9j1NwA==
From: Wenwen Wang <wang6495@umn.edu>
To: Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH] media: staging: atomisp: fix a potential missing-check bug
Date: Fri,  4 May 2018 02:29:54 -0500
Message-Id: <1525418996-19246-1-git-send-email-wang6495@umn.edu>
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Alan Cox <alan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

At the end of atomisp_subdev_set_selection(), the function
atomisp_subdev_get_rect() is invoked to get the pointer to v4l2_rect. Since
this function may return a NULL pointer, it is firstly invoked to check
the returned pointer. If the returned pointer is not NULL, then the
function is invoked again to obtain the pointer and the memory content
at the location of the returned pointer is copied to the memory location of
r. In most cases, the pointers returned by the two invocations are same.
However, given that the pointer returned by the function
atomisp_subdev_get_rect() is not a constant, it is possible that the two
invocations return two different pointers. For example, another thread may
race to modify the related pointers during the two invocations. In that
case, even if the first returned pointer is not null, the second returned
pointer might be null, which will cause issues such as null pointer
dereference.

This patch saves the pointer returned by the first invocation and removes
the second invocation. If the returned pointer is not NULL, the memory
content is copied according to the original code.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
index 49a9973..d5fa513 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
@@ -366,6 +366,7 @@ int atomisp_subdev_set_selection(struct v4l2_subdev *sd,
 	unsigned int i;
 	unsigned int padding_w = pad_w;
 	unsigned int padding_h = pad_h;
+	struct v4l2_rect *p;
 
 	stream_id = atomisp_source_pad_to_stream_id(isp_sd, vdev_pad);
 
@@ -536,9 +537,10 @@ int atomisp_subdev_set_selection(struct v4l2_subdev *sd,
 		ffmt[pad]->height = comp[pad]->height;
 	}
 
-	if (!atomisp_subdev_get_rect(sd, cfg, which, pad, target))
+	p = atomisp_subdev_get_rect(sd, cfg, which, pad, target);
+	if (!p)
 		return -EINVAL;
-	*r = *atomisp_subdev_get_rect(sd, cfg, which, pad, target);
+	*r = *p;
 
 	dev_dbg(isp->dev, "sel actual: l %d t %d w %d h %d\n",
 		r->left, r->top, r->width, r->height);
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
