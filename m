Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvVa0IjR2PlPhlrYSLjHwE9CB817BbrwfoaxIYfG9TGtQsK6UrEyuiJfxTPO6NUhM4YManM
ARC-Seal: i=1; a=rsa-sha256; t=1519676730; cv=none;
        d=google.com; s=arc-20160816;
        b=xCwnp3Uwtu9rLJkhocQZvhA+8Flfv/jk25AQngHZPmawbMt2NnMOVwxHF0M+VO8O+L
         pXm9RZJxKkqgWc0m8ej1BH2l0s24IdRflmCtArL4K7BUGpS0KKZXqFEBiCl1njsZZ5o1
         BjlYqdaNXaGCtU6mhfWCIdXynXiHuqNwKy0lhZeGbs8+z5Ro7a+hfw6u0ZBveCu7nwYg
         E/60EZWlSKMtfamY3PZflP/K78iyGmOVKhAwe89s9KBCmFCmO0Ivr8MnmExQQsJUWcNL
         wGfqEMZN2TDzPw/1GtV75GD/dlUjF7P+Jybdt8prL66RhlmW+Kv4cpglPtpzvkFqTW/I
         cWBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8XhWt0tE/5tGf7eOFDhSSHTT2nX0eptki1bIqvvVuRI=;
        b=LAGWHDqlk+5vRlKAMNNbkzv25qZ34zi8wevqUIdPjuoMfC/99MXE0ovUV3NjuwGSxW
         qwn2ZCZslMvwAViScCG9Wn9FX9XvgicIzppk7ztBBfnBJiOwmKuCIne34fK9214XFJ5P
         IEid3Ye/9NXy0qT7h6O+njtk3XymvRQrIZgLtIRagG2hCrc6lCBImDRSOj6Ns75XlZNc
         zY/ZWhPOR3TubSUC3T/J0v57fYEq6wEXLT6H48c5nq8mnQAfADSyS+r4P5ka3ZkDDqU+
         ycSPsiv+02SnMlKYrnn2vtl+YqsOaN1yQ29X8t3Rse9hFycp875Qj7/h47HVt9faVnC8
         HfNg==
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
Subject: [PATCH 4.14 53/54] drm/amdgpu: add new device to use atpx quirk
Date: Mon, 26 Feb 2018 21:22:30 +0100
Message-Id: <20180226202147.432021093@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496338608308970?=
X-GMAIL-MSGID: =?utf-8?q?1593496546975871912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
