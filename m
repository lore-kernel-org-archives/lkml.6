Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtA/Vv+p1libZKKaWYGM+sZTtn5ZKq37tXQIa//PcKmDe1Az3XQhpK2AQWa6Q+S4pp2fePc
ARC-Seal: i=1; a=rsa-sha256; t=1521214305; cv=none;
        d=google.com; s=arc-20160816;
        b=IVNoMiBWPzkKQdi0KHJEJMM6ngL+Li8Ug3LintDZKQwp0JZ7Y/jtd7foLbTW46Hled
         MjIs2yOu21hHNv75KuOFmEv0kIofn9kQPGfM6vxW0J4X0lJQzczlL20FHs5y5zTBjilI
         6u1zzebYfJuTkJq7VoOJzRui50QSDdlf+Hm5P4tABjdq8xb8STj2xLokPN6bfY6npGA0
         tH+uSBVxgkljiLxtDGc0HnAMBseMFRAcghu1xoZ3h7V8pLVpEp2bTYljQ7aOcih08a5G
         dj4JuazvDNj2iHsHgMisKagl3aLkzhVL+uaYJerHSqyX1u4zWPXF9TjCs0+Tl4F4NmLr
         tWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GQqCoQf8cXVCkfp1TvT8uHnp1MytoCtCCwcCxOJVg8U=;
        b=nFWnjlsTj27iXWUdkuyqP/h/gSyFS/s1WLwSDKNj/4sJvwelAoEmZiLzU49v4yGYtT
         g6e8OFO+ZJW5qtXL3grllqkiHMIX6tS4wmkBevkKTnzqNRppKFv0YLWovrddlzgb1kUb
         7Qv64NxCcaS+SlqYhz5TegE8OlTdliPHTFr6M/gF57pghCyIIpQe0h1B6VKGqKXBEkcS
         pNIFEEKraCQlyzV6mIziyyXhvnt+2Q06h/DV5EtbmPCgj93an1fzwEDtlXtJMFGUpGs+
         eN+S1XgdsibCpC+VSnNbppeLfgh+f9oBlQ39D6z1ED2GSJGMirr3VT5+fHpkB4t/0Iqx
         DWTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Zhu <James.Zhu@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 15/86] drm/amdgpu:Correct max uvd handles
Date: Fri, 16 Mar 2018 16:22:38 +0100
Message-Id: <20180316152318.346823930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108811396791046?=
X-GMAIL-MSGID: =?utf-8?q?1595108811396791046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Zhu <James.Zhu@amd.com>

commit 0e5ee33d2a54e4c55fe92857f23e1cbb0440d6de upstream.

Max uvd handles should use adev->uvd.max_handles instead of
AMDGPU_MAX_UVD_HANDLES here.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -277,7 +277,7 @@ int amdgpu_uvd_suspend(struct amdgpu_dev
 		if (atomic_read(&adev->uvd.handles[i]))
 			break;
 
-	if (i == AMDGPU_MAX_UVD_HANDLES)
+	if (i == adev->uvd.max_handles)
 		return 0;
 
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
