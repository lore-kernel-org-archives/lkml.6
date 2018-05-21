Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqJOAsavvFTg5Gws0Hy02Ng01TfWWU2M/nIT+knDBApTrjKZIPB+XGiNejhCJyk/JRXmJQT
ARC-Seal: i=1; a=rsa-sha256; t=1526937519; cv=none;
        d=google.com; s=arc-20160816;
        b=t1S6/tpYZBjJCQSRFfV/JsHgvXjRbD4rgifcR218+bgj3aDHac3jvaOJaBMG66z9Nq
         aom0Lz++XbxvZE4HB8ca9k0Ii+FllWYKqmIXovOKSyQHgYyKlZitzKbIYImvrj93Jebw
         WrtLoPYl45yCq9+Cw9mzjvcDeA43WGgSApto1rnUVJlUNDcbtNjvLU/y6/NGMO+oUF3Y
         9so3RGYkcclUzgwVvgGuh/n/36zGpIXjdVa7gvgTn8dE3EqPECBdTsdt8m3CulvRGjI/
         TSsEmpc0bXKd5RVU8zj1qU6dB1TuWoPY+DOknsSEOZQAbRUd73+QUy36N9VOnzwTng7E
         qnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=N3NZVY3VL6zzzwJ17733YqBLR0u86u41nY7fqfue+wc=;
        b=YJJhY4OMrDSDvDgR6CFoJBSrWyns+9JRPts9uVlCRxSOpasIxYDx+AD6BCGWX+m87t
         igHkgYzFrB+wDQB/kurWws3E5zPb+ZQscMz/NpBFt0d6SYj7PNCpA0d69Y1mZngZswpI
         /lUviQbiOQqUXpkbcoGUu5iWpuiVwvQS5DjQS2yL1w6X/hnmt0CJW3q9iN18/z2QZlgk
         PEOJNeUwTQqkqYOCVD6k2adCFM8D/2L53kkLrD3JD89bphaYMKWCG+dGJhAt0vMaz6f3
         O0eIHRQx2WSa2Z+6xwouKZoDIIsZR0Ml+M8oVGYqLEU/X0H6zjz6O3crnBykTERDWKn2
         TxMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wGrVdAQq;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wGrVdAQq;
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
Subject: [PATCH 4.14 23/95] drm: Match sysfs name in link removal to link creation
Date: Mon, 21 May 2018 23:11:13 +0200
Message-Id: <20180521210452.986271536@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110036205273170?=
X-GMAIL-MSGID: =?utf-8?q?1601110036205273170?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -749,7 +749,7 @@ static void remove_compat_control_link(s
 	if (!minor)
 		return;
 
-	name = kasprintf(GFP_KERNEL, "controlD%d", minor->index);
+	name = kasprintf(GFP_KERNEL, "controlD%d", minor->index + 64);
 	if (!name)
 		return;
 
