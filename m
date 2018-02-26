Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtaZyfEnqlCP6mm+v8e0YGP5/tPcZRJf6J1ovEGd68/STqQ0hhjThioI9eRJ7MSfFZ0Kk9d
ARC-Seal: i=1; a=rsa-sha256; t=1519676531; cv=none;
        d=google.com; s=arc-20160816;
        b=dWO72uKI/1ujKdPNyQgX2V8PSzKg9LkyvVP/6lElj7+uRXI0GrwDaiI4g7k6rLxbXR
         Vz7kD/a/y7hpVyAsTnQFKsw12RN00QuAGiNgBBQalsL6zaRihTKuu8NLljpDSmwq59O0
         bJW83zFh4YqRoY8KruSyHrK+UxfBVQkphr7PHa53HTlp/sYYUvjzhDU/+8iFGriuIZKj
         4s12vCFjQkP2N1y5dQXHlJmJ/E5DJUC9PkMLuEDGLH/lKgKKLhRbB1LnpXV6uZaTzkmk
         l4CI4eaVxnRbMQEQQtIOuNa+q7tjiOlu3sM+rZcyeeqod20rOe6lDqZEjREfj3OAHbuu
         Gc0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zcgU2s50g4OEhbwYlrygutvt2AHbdpvrVM/DRCaYGZw=;
        b=C3rvEIuvvHMWRkh5aLPR3+GjxY/4YDOLu59KFuWYpodNUlaQ6GtlW8otBjeStrkhqF
         qVPItf7H2nZGjpgbQv6ugPlLiXZluWMw0Ui+qFXZ0BMrmTQ/r5SwUAsqX9hIMm/YuHYx
         9yY1M2y3bL+ixqI5wj/sZt4CCtiUc65ME8CIzYm/YiwzDa8ZFETBN507MIPCUISKl/xv
         FyhKgHb1gEf/ngmkX6Pt0FdX+HwXxAzcrVgCgWL79dCtKCXsXxW+cjICy9baq9t8KmnC
         fDGih96gVgd5Ifrm8C4La1zS1Qcvyqth76MqLrkg/x1R/BF1y/fNM2BRHuYEWekFTw5E
         1k1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 26/39] drm/amdgpu: add new device to use atpx quirk
Date: Mon, 26 Feb 2018 21:20:47 +0100
Message-Id: <20180226201644.816387018@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496338608308970?=
X-GMAIL-MSGID: =?utf-8?q?1593496338608308970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 6e59de2048eb375a9bfcd39461ef841cd2a78962 upstream.

The affected system (0x0813) is pretty similar to another one (0x0812),
it also needs to use ATPX power control.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -568,6 +568,7 @@ static const struct amdgpu_px_quirk amdg
 	/* HG _PR3 doesn't seem to work on this A+A weston board */
 	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
 };
 
