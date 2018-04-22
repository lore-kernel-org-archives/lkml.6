Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+jYB6Fuo0vqugaNT8NIHvPyLmQGe0kCb1ommduWHjibhJAgM61zPfCnIUX987RGKQnhgpw
ARC-Seal: i=1; a=rsa-sha256; t=1524406516; cv=none;
        d=google.com; s=arc-20160816;
        b=a7MPmQ69ARNEOOTHfJql2i1djRpQ9L9+avp2Elo3Mcwex3MlFRNSyRFX1bpm42u1ju
         6DqvtNM1G3RSDa25Hh9/Bvs4YKxtbekG1+mOe4+0DBDemVixB7eh7EOlCzfvTplMbvho
         F1MZDP5JfzJCi57CVcVe0eZPaX9+rzka80MtfvSuyIICadoJhSkRhALx4US7ciBVeKv7
         ih6+Le77UFfLAzhvNkGYy6L2Hmqtrg7BtkQoqEQoWOBko4FtbQbZ7uCGHMtXblRdoDK0
         u3AuT+KPUf99G3r32sJRiHtih6XK6AaiMFozyQh6wnYLMRJ+YupNUrKtGuDtG3oeN0Q+
         IsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=swIHSjf1oyxNU/v8QVS7U20eeNrmWnQ3D3Rx+0dXOjE=;
        b=jQqLCedZZB+Cdvj8ndQKurp24Vg2hmZ7mN0oHZ4IKEIDT/Phf+FKreX8rvGEk2G9h8
         pT9jwZP5ZUf/QHnIeSRycc/rFvuv0feL3io/+RuhLylqtZlxNcug6jo/wKVb9/qWZ6re
         578wdGHuGZ3jV2Fwyhq3TiBI3UhVdeHilvkLcLyy9sfNSwBfsXr4/m9AAEwBOBHWfYx7
         1klVBY5oJwnBzLblkbW/IFhSrWZpN57Apd7wk4VGj7uuQvBeLy3U8C4dxY/gerfFm+o5
         GheUM5qU34rK2rQd9LadU93X6jwU2R2HzHLhdsAGLoIyJWdUoc6gf1AM5s8tce2xzgqr
         pvNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.9 66/95] drm/amdgpu: Add an ATPX quirk for hybrid laptop
Date: Sun, 22 Apr 2018 15:53:35 +0200
Message-Id: <20180422135213.126961918@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455199192532999?=
X-GMAIL-MSGID: =?utf-8?q?1598456087743458858?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 13b40935cf64f59b93cf1c716a2033488e5a228c upstream.

_PR3 doesn't seem to work properly, use ATPX instead.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=104064
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -569,6 +569,7 @@ static const struct amdgpu_px_quirk amdg
 	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x67DF, 0x1028, 0x0774, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
 };
 
