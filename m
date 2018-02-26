Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsa4Xf/AqFOEYDi0eA6tkfol0+LYO0TF8yZrWkvdCzimFTCfT3YSYj4jIuyQRtl+l+SXdHU
ARC-Seal: i=1; a=rsa-sha256; t=1519676916; cv=none;
        d=google.com; s=arc-20160816;
        b=in8Jlu0vm0iYyZqc7uwMfZN8Dngk5IJNmvdvaRzyzGTK8lccWdZ0tBRx+AnHtdLhdR
         cb1P3PPRm9NXiVsNADUNjgPMHwb6R5pBfIrDeWAR/E2AZeRUvabFBLWiLz8QW0ggjZ5H
         XJpQ5vzppwa6RvuEjgdNlfCYKJQehMCOjFRIWRb5bbvVUQM74CyvTx/CcMrpWmTw6Pao
         AhrzRPtH5+4WtIn8N1eyUrwhrMyUUDsouz+FiChvYJbqTSJcwrhR8VJg/jNrEpcyvQgo
         fefytsCISTbcvezh/teRfn6w9X5pPtRrAMMHuc9aCHiVe9L4i773w/6z2necTcUT/h8m
         f5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IQ2CXha6CJWn1zGyLrlA9bYf2kP2U9O66yzTG37fph4=;
        b=EZDTIfFN/I9HkU2sf04dO4Xewrs1WvcIq+rSwXIVil0kq3ZFRJHg2vcl+EVmW7oQTR
         BZGwn11p4TqPGaWlylu6wQJbshWxOoq0F/CYfeabtBuBF9X3act+asA5Lu0f7Wez05T1
         pKhe+5jLXQ08sT8NlCFil/FNu57yLKeHe2X39zaryLuajve25MHZU6RcTmglXruaryVG
         75D5aR9IACLDdqeQUZMUQQT/LlB4+e+ND4t3ePrTuMq6LglUs4uMdr48yQvwa38Pp7Mh
         EIUXr53KFZZrSFmwlZ4edgwKjQRqYnzS+6aN1r3VoGfZBdslWeJkgb/ovIkHJDw673Ak
         hfnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Huang Rui <ray.huang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.15 56/64] drm/amdgpu: disable MMHUB power gating on raven
Date: Mon, 26 Feb 2018 21:22:33 +0100
Message-Id: <20180226202155.831900463@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496531110567555?=
X-GMAIL-MSGID: =?utf-8?q?1593496742139594889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Rui <ray.huang@amd.com>

commit 400b6afbaa949914460e5fd1d769c5e26ef1f6b8 upstream.

MMHUB power gating still has issue, and doesn't work on raven at current. So
disable it for the moment.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/soc15.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -659,8 +659,8 @@ static int soc15_common_early_init(void
 			AMD_CG_SUPPORT_MC_LS |
 			AMD_CG_SUPPORT_SDMA_MGCG |
 			AMD_CG_SUPPORT_SDMA_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_SDMA |
-				 AMD_PG_SUPPORT_MMHUB;
+		adev->pg_flags = AMD_PG_SUPPORT_SDMA;
+
 		adev->external_rev_id = 0x1;
 		break;
 	default:
