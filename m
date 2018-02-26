Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226x/n3UVGlxeHPgkP1GfdHYxgHaa7BLlvdZrb/4Volh6XRmzpxu/gVC9Lkflg77tIoQOkGM
ARC-Seal: i=1; a=rsa-sha256; t=1519676938; cv=none;
        d=google.com; s=arc-20160816;
        b=SFfnogHTDbJPKXAAvh4q8AeH39cUYOSmhtxOr5Ct3mbTQlf5UTnMy5rPGxK7/kHv8L
         uQSLpx4LaEwiEMgQ+nAgJzu4a6GbuXuVJ2AlVKAAKfBGA7rnQ7upQ8RNg2wvbNhlzqVO
         QkEbGiZPhtRGqm388gT2Ce0w4sfa7jzuobOVBq29tevC+luM08YRbm77jf/veVZ2ZwIl
         8noPMtVoOdZ2mJdOO2b1rqC+P9Rvu3Po36iugirZJOPI+JDkjRH5gzgi1WAwQbIuW+qa
         Ut0tILWm7sHyD8i6qfdVYM2gvtjwsgb6DuSXYm+Q+QS/Sbs3tfYhQbXlKut2RvsUIDFN
         tV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FYeLj7P6cPQ/5l4+4TfUg7DASvteQH8bvmw5beMCM1g=;
        b=x8FRFkt4ab7R7naTVuKYe6vhrY883d1aW4qY2eqwHFgor5QMjZMAZkquSVXTUxIic5
         2ry3TdfHCa+l4q0SwR4w4vRWHd8jHrtPst3WTEnSNUAGmruv+zvMaiAbZhFDeRtUQ5Rb
         wVPhxEC12D+TYxSmBd0sHAPtI0gsoLWyhVOZbq4dC97/qoObuFXTpPEX0j+evu7px6pU
         7c9oZxv1sYR7Rq0+Xaf8mbYhE9oETrYhOucDBNy+SU7Eeb7Jhl7m6SiRYIKS7qjwhVpg
         TUui2aEmJrAF3SyfYHrHRRyV9VxjRTvKtch9B1RL6douitRK36xsxOJhz9xHh+LwgOSM
         2aFg==
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
Subject: [PATCH 4.15 62/64] drm/amdgpu: add new device to use atpx quirk
Date: Mon, 26 Feb 2018 21:22:39 +0100
Message-Id: <20180226202156.100546208@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496338608308970?=
X-GMAIL-MSGID: =?utf-8?q?1593496766127050455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 
