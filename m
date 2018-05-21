Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo93hFVYgETGLBN18fW9g3tMIAGc+2RbWIVdsBbRif4Oqf0JEeFOTfv9EZcf/L77AyHxk5n
ARC-Seal: i=1; a=rsa-sha256; t=1526937899; cv=none;
        d=google.com; s=arc-20160816;
        b=GPP4+F+buik0yv4AeKRWPDNehdd2PdeQ5QrMpZ8/n3nxDTLYYmO1TxPAI3Qo7ixSwx
         tQ/8By9kyOZ+dt3pQdoiTJ+4+B+li2jcy6+ytMaT06ja0FDXVWs3KpNMPYE8kEYfqQhJ
         AKJl8sU6Jmq8p/XHcFEXakiWXXvnI5Xl5bO5QmECfI6/612Dndr5RK1PTB4K+JZ0ZGzC
         NM3QzTWc5uZnsvpRgAqmErsSvF0UgJV5v1i/wVxk2/bCV9MHTEWgAi/eJYNjUtkSFKHc
         fJ5SY72KIwDt3s3QjtNnOo9PrDYmI2hb156oQ4m9EXfAr/JG3NRGQK733nPD7AWI6FYw
         DtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TA8IuuZLXePI6EsWPZDYKnskGGngoqOWQ6BPSveCjuA=;
        b=s/qAyy+lpW6fNQPmi0yvXLBd0GG3y3Tpo9bHIg2Obk6n8HU+X87cnSW3N3xa9hqpkg
         euLOlV3zVRAbmKLor+HmcvCekslWP2A2EWExNGEEg7LzHg6hUMV8dGpEu00Kj50ywJuK
         LhfWkItsaH+GC/iZigjh3gdxOSOdGljUGY1TrA330XQGpyWE+Weq4HcC5Wv+W5dfJD4s
         uPHY1RCOMAw6wB8guYtlQoCbjHGWdCEtLcBGeuA0C07nu9sfsRyUNfa0k5VknZrA2iv2
         jsDzqOrpayUBfNyBb4XAhOrLMFA1H194IcsisS7Eh/cjhoS+RcLwBoTD79LPP4ljYlVs
         OR2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fsWQsMyf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fsWQsMyf;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dave Airlie <airlied@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Emil Velikov <emil.l.velikov@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Gustavo Padovan <gustavo@padovan.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Sean Paul <seanpaul@chromium.org>,
	David Airlie <airlied@linux.ie>,
	dri-devel@lists.freedesktop.org,
	Haneen Mohammed <hamohammed.sa@gmail.com>
Subject: [PATCH 4.16 034/110] drm: Match sysfs name in link removal to link creation
Date: Mon, 21 May 2018 23:11:31 +0200
Message-Id: <20180521210506.763714233@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110036205273170?=
X-GMAIL-MSGID: =?utf-8?q?1601110434797612896?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haneen Mohammed <hamohammed.sa@gmail.com>

commit 7f6df440b8623c441c42d070bf592e2d2c1fa9bb upstream.

This patch matches the sysfs name used in the unlinking with the
linking function. Otherwise, remove_compat_control_link() fails to remove
sysfs created by create_compat_control_link() in drm_dev_register().

Fixes: 6449b088dd51 ("drm: Add fake controlD* symlinks for backwards
compat")
Cc: Dave Airlie <airlied@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.10+
Signed-off-by: Haneen Mohammed <hamohammed.sa@gmail.com>
[seanpaul added Fixes and Cc tags]
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20180511041542.GA4253@haneen-vb
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -716,7 +716,7 @@ static void remove_compat_control_link(s
 	if (!minor)
 		return;
 
-	name = kasprintf(GFP_KERNEL, "controlD%d", minor->index);
+	name = kasprintf(GFP_KERNEL, "controlD%d", minor->index + 64);
 	if (!name)
 		return;
 
