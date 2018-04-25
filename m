Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AB8JxZqGQFVmqBTSNXwT3+vHnNDhkFGKzuXjYh4sgGvMGYnvPzxybWpTVkfDZ0ZD0yWUUL/Dhiqp
ARC-Seal: i=1; a=rsa-sha256; t=1524652682; cv=none;
        d=google.com; s=arc-20160816;
        b=Gc8bxg0AIaZjl0l50tnCc/kviZ8hVLBZi1OoTGSes0PCSd0Xs+XQo6dyhdrLbLVNju
         uK97SlMEEV1Vn27wHNfeHBIUYZeEanXuQHSmaYvufVg07dcK5P/rzYI4ysYI3MEZKayL
         8+RPZCnkMWtEtgCMDQeM/zgwvVvPpKGaDEhLFuC04BevB+m5TxSM+TY5lAzG1XUpBvbk
         fH9jr8nDSxA/ZcF/sdRSD32szfPSguvm7/KiJGCFbOdqL+lsrDj/4TLjRAXwgvLNcais
         Hr7C0Oh171wlBnjtja29wdqt/apvDWzOXIq/o0iE++rN4rwVfdpXa77mcHu6B408PATE
         ZgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lvRmiAXZAqfwAypE1SGggqjy27DNSac9JGWeFJdEn34=;
        b=L9fLHQghS9U4RNlZdMsDft/p5fYxgSIZeQgWYM6Q5uR4do0jEaBCNiEcm/gNmwnCZ4
         6EuYK1cxgIxaXgsQgGjJILVhmWDhscLKRPCJdtmVUhkq1m7g+RPJtRVR6rErP7SQrw5J
         1YGHRZR04ZFez9NhLqCMf5nYG7wjU3zsh5V4TAWPO/QM/EfzTQU0vx1b7x5bZyS1lbm5
         TNsq5PxifhMoYOCsHgkWoJpheo3HbNLaiIrUcxSd4I2M46JO6eLCYWBlRPY037hdPMOn
         1UmFVrXuwntvibqI9Rt7Z39BwH1D7C1PbRQdVf6wz7KYWOxX5UQ7+RdImu8dw2LqML12
         PshQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH 4.14 007/183] drm/i915/gvt: throw error on unhandled vfio ioctls
Date: Wed, 25 Apr 2018 12:33:47 +0200
Message-Id: <20180425103242.903050776@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713951186925368?=
X-GMAIL-MSGID: =?utf-8?q?1598714210901442376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Hoffmann <kraxel@redhat.com>

commit 9f591ae60e1be026901398ef99eede91237aa3a1 upstream.

On unknown/unhandled ioctls the driver should return an error, so
userspace knows it tried to use something unsupported.

Cc: stable@vger.kernel.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/kvmgt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1153,7 +1153,7 @@ static long intel_vgpu_ioctl(struct mdev
 		return 0;
 	}
 
-	return 0;
+	return -ENOTTY;
 }
 
 static ssize_t
