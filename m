Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-670130-1522322512-2-15988591546701930694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522322510; b=PxKMot0tjpuew3slKDCTkortQ3lhzcGr499nzPuHbkgFjRhJ2h
    X40n0nVqOMFzor0aPj7ipmaKrpyIK4l3YHSWEBcnrt2EiFuzYE3+z5GCGQVcs4Tc
    ZtocRq9pf7AcljLJEdXICUmqPr8FMjhx+ZcQnODeSl5+JTWzwqLfA9PAW0Z6DtH5
    V5fteuYas9Umfcwyv8O0KYDaIe+UZ7SoCTWwuQEvc23ga0ifKzspytS8YAUrkHIC
    unmQioxtgaqDkJz/7LAcjpA+pKHIy7SFed5MD3QCjkWKlWHBoVfTCSyf4q05FGTK
    Qwr0XavVdcdaBCrOKL184cB8OqQqo0y0/avQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522322510; bh=8Rks+Hb3Sewlz1sVAFEoJuNtvt/WqE
    Pbg8Xtgyenv88=; b=Lcc7ky+k2dDAuT//VCp9uolxMNBTdPbS2Yi4GXcFK+wySu
    AFu/sZm8n0m6R/Ls5gifkq1bU2piUh7NMbrcXfJ4nZMmcLpbHRRHYH3CDEZbLh03
    UsSviLq+tsbA5h1XvI7M02SaT6ctvuI7C0b2Th0puis+OjjdG1rnRPGCPKJvvMIE
    h+KHUIGynjam/1KC7z0x64zy4fheHZrZPYvxDcB3SgbXCm8j+xPerIgipuyd8EDr
    kMw9yQ5WYN+itJ3lq6BfKtKVKrGJHjwu/Ryfy9dliG4fk7JGTRvx4r/NSXulrDmt
    +6DCAtfFvSVF7jw+TJTVJ7Bea9nsapNSX+7iHt9w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLarDPUkhI4n6F5DkwkCA3m5WS0qzuVFvYTZNSrCxibeaCiGLKPuUOEY91KPV0L2HL1sj04P5VzZOBywzgr7e4h67yYRbHTbqBMFnhuiblbk8XZfQusw
    7Arpb+LfWSDiU+vih/DqrFuG60kcsXAK9N6Yfpc+Ml0/bNLuF7Nm7oCC6UWJuYWD4REEwa2gvKJH7DZzWCp/fYBaSjYXyVq0mieQyJkFEzLGxH/cM/unAMq9
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8
    a=20KFwNOVAAAA:8 a=07PhjVXsacdrd5iPd-YA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC2LVr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 07:21:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752584AbeC2LVT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 29 Mar 2018 07:21:19 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/3] virt: vbox: Add vbg_req_free() helper function
Date: Thu, 29 Mar 2018 13:21:14 +0200
Message-Id: <20180329112116.26488-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a preparation patch for fixing issues on x86_64 virtual-machines
with more then 4G of RAM, atm we pass __GFP_DMA32 to kmalloc, but kmalloc
does not honor that, so we need to switch to get_pages, which means we
will not be able to use kfree to free memory allocated with vbg_alloc_req.

While at it also remove a comment on a vbg_alloc_req call which talks
about Windows (inherited from the vbox upstream cross-platform code).

Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c  | 66 +++++++++++++-----------
 drivers/virt/vboxguest/vboxguest_utils.c | 14 +++--
 include/linux/vbox_utils.h               |  7 +++
 3 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 190dbf8cfcb5..7411a535fda2 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -114,7 +114,7 @@ static void vbg_guest_mappings_init(struct vbg_dev *gdev)
 	}
 
 out:
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	kfree(pages);
 }
 
@@ -144,7 +144,7 @@ static void vbg_guest_mappings_exit(struct vbg_dev *gdev)
 
 	rc = vbg_req_perform(gdev, req);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	if (rc < 0) {
 		vbg_err("%s error: %d\n", __func__, rc);
@@ -214,8 +214,8 @@ static int vbg_report_guest_info(struct vbg_dev *gdev)
 	ret = vbg_status_code_to_errno(rc);
 
 out_free:
-	kfree(req2);
-	kfree(req1);
+	vbg_req_free(req2, sizeof(*req2));
+	vbg_req_free(req1, sizeof(*req1));
 	return ret;
 }
 
@@ -245,7 +245,7 @@ static int vbg_report_driver_status(struct vbg_dev *gdev, bool active)
 	if (rc == VERR_NOT_IMPLEMENTED)	/* Compatibility with older hosts. */
 		rc = VINF_SUCCESS;
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return vbg_status_code_to_errno(rc);
 }
@@ -431,7 +431,7 @@ static int vbg_heartbeat_host_config(struct vbg_dev *gdev, bool enabled)
 	rc = vbg_req_perform(gdev, req);
 	do_div(req->interval_ns, 1000000); /* ns -> ms */
 	gdev->heartbeat_interval_ms = req->interval_ns;
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return vbg_status_code_to_errno(rc);
 }
@@ -454,12 +454,6 @@ static int vbg_heartbeat_init(struct vbg_dev *gdev)
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * Preallocate the request to use it from the timer callback because:
-	 *    1) on Windows vbg_req_alloc must be called at IRQL <= APC_LEVEL
-	 *       and the timer callback runs at DISPATCH_LEVEL;
-	 *    2) avoid repeated allocations.
-	 */
 	gdev->guest_heartbeat_req = vbg_req_alloc(
 					sizeof(*gdev->guest_heartbeat_req),
 					VMMDEVREQ_GUEST_HEARTBEAT);
@@ -481,8 +475,8 @@ static void vbg_heartbeat_exit(struct vbg_dev *gdev)
 {
 	del_timer_sync(&gdev->heartbeat_timer);
 	vbg_heartbeat_host_config(gdev, false);
-	kfree(gdev->guest_heartbeat_req);
-
+	vbg_req_free(gdev->guest_heartbeat_req,
+		     sizeof(*gdev->guest_heartbeat_req));
 }
 
 /**
@@ -543,7 +537,7 @@ static int vbg_reset_host_event_filter(struct vbg_dev *gdev,
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
@@ -617,7 +611,7 @@ static int vbg_set_session_event_filter(struct vbg_dev *gdev,
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
@@ -642,7 +636,7 @@ static int vbg_reset_host_capabilities(struct vbg_dev *gdev)
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
@@ -712,7 +706,7 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
@@ -749,7 +743,7 @@ static int vbg_query_host_version(struct vbg_dev *gdev)
 	}
 
 out:
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return ret;
 }
 
@@ -847,11 +841,16 @@ int vbg_core_init(struct vbg_dev *gdev, u32 fixed_events)
 	return 0;
 
 err_free_reqs:
-	kfree(gdev->mouse_status_req);
-	kfree(gdev->ack_events_req);
-	kfree(gdev->cancel_req);
-	kfree(gdev->mem_balloon.change_req);
-	kfree(gdev->mem_balloon.get_req);
+	vbg_req_free(gdev->mouse_status_req,
+		     sizeof(*gdev->mouse_status_req));
+	vbg_req_free(gdev->ack_events_req,
+		     sizeof(*gdev->ack_events_req));
+	vbg_req_free(gdev->cancel_req,
+		     sizeof(*gdev->cancel_req));
+	vbg_req_free(gdev->mem_balloon.change_req,
+		     sizeof(*gdev->mem_balloon.change_req));
+	vbg_req_free(gdev->mem_balloon.get_req,
+		     sizeof(*gdev->mem_balloon.get_req));
 	return ret;
 }
 
@@ -872,11 +871,16 @@ void vbg_core_exit(struct vbg_dev *gdev)
 	vbg_reset_host_capabilities(gdev);
 	vbg_core_set_mouse_status(gdev, 0);
 
-	kfree(gdev->mouse_status_req);
-	kfree(gdev->ack_events_req);
-	kfree(gdev->cancel_req);
-	kfree(gdev->mem_balloon.change_req);
-	kfree(gdev->mem_balloon.get_req);
+	vbg_req_free(gdev->mouse_status_req,
+		     sizeof(*gdev->mouse_status_req));
+	vbg_req_free(gdev->ack_events_req,
+		     sizeof(*gdev->ack_events_req));
+	vbg_req_free(gdev->cancel_req,
+		     sizeof(*gdev->cancel_req));
+	vbg_req_free(gdev->mem_balloon.change_req,
+		     sizeof(*gdev->mem_balloon.change_req));
+	vbg_req_free(gdev->mem_balloon.get_req,
+		     sizeof(*gdev->mem_balloon.get_req));
 }
 
 /**
@@ -1415,7 +1419,7 @@ static int vbg_ioctl_write_core_dump(struct vbg_dev *gdev,
 	req->flags = dump->u.in.flags;
 	dump->hdr.rc = vbg_req_perform(gdev, req);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return 0;
 }
 
@@ -1513,7 +1517,7 @@ int vbg_core_set_mouse_status(struct vbg_dev *gdev, u32 features)
 	if (rc < 0)
 		vbg_err("%s error, rc: %d\n", __func__, rc);
 
-	kfree(req);
+	vbg_req_free(req, sizeof(*req));
 	return vbg_status_code_to_errno(rc);
 }
 
diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index 0f0dab8023cf..bad915463359 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -82,6 +82,14 @@ void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type)
 	return req;
 }
 
+void vbg_req_free(void *req, size_t len)
+{
+	if (!req)
+		return;
+
+	kfree(req);
+}
+
 /* Note this function returns a VBox status code, not a negative errno!! */
 int vbg_req_perform(struct vbg_dev *gdev, void *req)
 {
@@ -137,7 +145,7 @@ int vbg_hgcm_connect(struct vbg_dev *gdev,
 		rc = hgcm_connect->header.result;
 	}
 
-	kfree(hgcm_connect);
+	vbg_req_free(hgcm_connect, sizeof(*hgcm_connect));
 
 	*vbox_status = rc;
 	return 0;
@@ -166,7 +174,7 @@ int vbg_hgcm_disconnect(struct vbg_dev *gdev, u32 client_id, int *vbox_status)
 	if (rc >= 0)
 		rc = hgcm_disconnect->header.result;
 
-	kfree(hgcm_disconnect);
+	vbg_req_free(hgcm_disconnect, sizeof(*hgcm_disconnect));
 
 	*vbox_status = rc;
 	return 0;
@@ -623,7 +631,7 @@ int vbg_hgcm_call(struct vbg_dev *gdev, u32 client_id, u32 function,
 	}
 
 	if (!leak_it)
-		kfree(call);
+		vbg_req_free(call, size);
 
 free_bounce_bufs:
 	if (bounce_bufs) {
diff --git a/include/linux/vbox_utils.h b/include/linux/vbox_utils.h
index c71def6b310f..0b7cd179f2ee 100644
--- a/include/linux/vbox_utils.h
+++ b/include/linux/vbox_utils.h
@@ -33,6 +33,13 @@ __printf(1, 2) void vbg_debug(const char *fmt, ...);
  */
 void *vbg_req_alloc(size_t len, enum vmmdev_request_type req_type);
 
+/**
+ * Free a request allocated by vbg_req_alloc()
+ * @req:		Request to free.
+ * @len:		Length, must be the same as the value used for alloc.
+ */
+void vbg_req_free(void *req, size_t len);
+
 /**
  * Perform a generic request.
  *
-- 
2.17.0.rc1
