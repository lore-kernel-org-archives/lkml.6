Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv58h+ugq65zt8193I9g9ScJH5btPLrPM/uIhsxfUk82Y0bw+qCDbNZuh4H9dMzS5wvKZ0v
ARC-Seal: i=1; a=rsa-sha256; t=1520954950; cv=none;
        d=google.com; s=arc-20160816;
        b=z7bOJ31VlyNFlQ4wz+0Cmtcwo5t1FrbmN9ORVvkrLCFctON58VfntoDAo0VsILarKt
         YtWVmrKfie/YuuHEkUwCILK2bcafTqYBf+fZSnNvt9klarZGgVthZkCPRzqmpaxsgBWh
         wibmX1zuGYN8IuUgXoaA6GdIaI3K4JqBuGjnBKiVjSqrGLRqC3JPGbnUrzioUf7KgPBs
         PI0k1J4gS3sMBa5IoFU5T/v4ik8JIo4ecaAk506c5/OBXovZXNx1Mj8NiPxwjvvzze32
         DB9MGjGKBHofB1CM7hvnLexuTYAf+4jwmNSNMFY+FGN0YvQmTDXB6lLje51ahKGqiJxJ
         tJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8IdF9qq23VwiSjqYEKawhNEofbYBsYBsBKPBZmqIujE=;
        b=Iy+U/zqSk/yZp9eKlUPwTICKZSIOItMAIRC2Olfl4zT2l6xa6lW5m/whmmr0eK+jOk
         wFZ+wZAwHdDjZYSyUiZBvJNcUulTtOL10bbrN77ZNbk9uOw+/5MTj5zzgYuzYfZacs/v
         oVHDI6k3U3S7dNaCwAG2gArIH7KXh51TupQMiov5Lk4xaq7o86lIwId4VTpyD9dZ5RCa
         eia2UwJxQfgCquIYk8tTxF0CZbehCCBo5S0yVTQKy/s4ngPgO/4y6BZCTg7DbaHkZvaX
         JjwgHYcHyNdVWzSuWO43uTn5ZZemueB586I8aOIhLj7zToufgePpPLk5vMyeQP7lC3uw
         UuEQ==
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
Subject: [PATCH 4.15 037/146] drm/amdgpu:Correct max uvd handles
Date: Tue, 13 Mar 2018 16:23:24 +0100
Message-Id: <20180313152323.402639584@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836857521659981?=
X-GMAIL-MSGID: =?utf-8?q?1594836857521659981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -301,7 +301,7 @@ int amdgpu_uvd_suspend(struct amdgpu_dev
 		if (atomic_read(&adev->uvd.handles[i]))
 			break;
 
-	if (i == AMDGPU_MAX_UVD_HANDLES)
+	if (i == adev->uvd.max_handles)
 		return 0;
 
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
