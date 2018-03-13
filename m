Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuLsgG9E45EzD5lMkn95+XuNs6v3W72uq/H+ymu2v9nx6d5C4JXxcVmJiTx9hDRoRRwt4VO
ARC-Seal: i=1; a=rsa-sha256; t=1520955515; cv=none;
        d=google.com; s=arc-20160816;
        b=hSoUTX7jmamn+5jK9w53YESz56pBfe6BdpcPFaXb+3ziYbk4mY3m2tmDDnE7WKWRHr
         tD8eZx/XRy/Jo1prxdvy2g+pdV/qckxc7rWwcRJrec0R0Vyh+9El+K+OO+fHg40vLLiO
         O8bM2lmAIL1nYZAP41wWsAWHUg6KCd2fsN5B0fXwSpoth89xv5OviL1AupNbx+fX9wRp
         8hHTLwskytYDMJyblZJ5c19ughzfCY0Ocjk5FIWbRpWpgNubduTvlijOZY3xCe8T+RpG
         LPvwmb+BVKd4dBUXggJ5nDBoN4OvDN+s6piJ5ewiq2+YNANvNaypwyEW8uaSFSEG257b
         M5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3wpdP8uBaim6yX+pzxSwj1DWEOGqPQwyUCx5lLSSN4A=;
        b=QuBuohz6LkLYOgHUDpbzPpgCIVNUp2zbe0mVXNc69UyH4P8oa+MB2/HjMRaJQLsZy1
         v/7V0BrHd7iaZHupR5LRnHvaG5fasc9IKKYKC7h6dzhM5csz3HCqCfNdZDljmvbsXed1
         iq/W6NuVzrwwxUic2jvb8Kzekwob6HbHcydjMsxb/u8rZYfFw5eMwm9vnWF2JQx2EtlN
         vblHCFWeja1h6z2m+Ro3i08Ocu5AXzbuKkMLnsJ6x9RTQsO/o0LlLlUcxTYhbh5SqQhz
         D/IYSsFWTramFY51+UimK1Y+FVFXsvsvKcfiR2Ur62QTaDzgKpjewt33eTH6kTqgmpT4
         lD+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	James Zhu <James.Zhu@amd.com>,
	Leo Liu <leo.liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 076/140] drm/amdgpu:Correct max uvd handles
Date: Tue, 13 Mar 2018 16:24:39 +0100
Message-Id: <20180313152503.267473700@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836857521659981?=
X-GMAIL-MSGID: =?utf-8?q?1594837450954560404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -297,7 +297,7 @@ int amdgpu_uvd_suspend(struct amdgpu_dev
 		if (atomic_read(&adev->uvd.handles[i]))
 			break;
 
-	if (i == AMDGPU_MAX_UVD_HANDLES)
+	if (i == adev->uvd.max_handles)
 		return 0;
 
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
