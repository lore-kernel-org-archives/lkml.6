Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523979196; cv=none;
        d=google.com; s=arc-20160816;
        b=SIob3ryFfm8E8nn8lcPFExH1Qi1B/E0ghqvkk7tXLUj1UuUo3RCanyiXPHiZ9CGPwI
         EeP4iNPuvonCpNWvwO68UbVZNqPFOTh6ne5dUnb3yRhtzz5nAH5X7N4kLz0gwHF/ucHO
         Lq4eRwg0d0QNlcb9DfwUoyTRk54tXHsIXKtfb2AaMClfL8kLjZvjtgyrXFx7QUoi8yC8
         vNtKs7Bz2xGsvLnD+AbB8/umchtWzSVXGZoRsfYXrH7eda52Hp55ZSXVS5V0wdCVKjyk
         hEGxxq/wqmfl70ow9UaxAa0Op0ebRTGrBio9WbQmhISqhD91wotJpWdds4inS1Af/Pnz
         NoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=zar0Az+f9bL4O/6NzD6a9uezAy6/Sp8yMn0gvwWtqPU=;
        b=KYJGv1z+JwHpvBnEfiSwN2h4LWYo8V8cis8XRbEh6eROLXhObDp1i7rtwW8c1wVcIX
         d3CVPtHNGNX6HSFOOd5TKUKBtmBRQajOGLwq3eJwIZ1AoajEDB5EV/WL6lCoIVbg5tLD
         AJslUSE6gMb70szL+ppBWIB8lwjIT6FIxVfBeEKRFUoZungzQPiOrkROrHGe5X5umENz
         Nj4hQI31E3PeWMLwvex08m2XIsNlCxiLflQlMUS5CZkMs4sn2o1raTzmqUv+A9q7At5t
         TNnvbIGGv2fVDCZ24iO6SlMFMOlXrJFIsNq7FaYhLohBovy1EqohOec/dVP5CkUuyZQ4
         1q7w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HqGGSG/j;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HqGGSG/j;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+dCqg9h+9T2Sq/Df+Qg/khEBPK3rTbqMAhtnQBSCllUnNic9Lt5h1X9RgNMMgxGoXLVaZHYA==
From: Andres Rodriguez <andresx7@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andresx7@gmail.com,
	gregkh@linuxfoundation.org,
	mcgrof@kernel.org,
	alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com,
	kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: [PATCH 0/9] Loading optional firmware v3
Date: Tue, 17 Apr 2018 11:32:58 -0400
Message-Id: <20180417153307.3693-1-andresx7@gmail.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008010331583963?=
X-GMAIL-MSGID: =?utf-8?q?1598008010331583963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This re-spin includes fixes for the kernel-doc style as pointed
out by Randy Dunlap. Otherwise it should be functionally identical
to the previous iteration.

New changes can be found in patches 4 & 5.


Andres Rodriguez (9):
  firmware: some documentation fixes
  firmware: wrap FW_OPT_* into an enum
  firmware: add kernel-doc for enum fw_opt
  firmware: use () to terminate kernel-doc function names
  firmware: add functions to load firmware without warnings v4
  firmware: print firmware name on fallback path
  drm/amdgpu: use firmware_request_nowarn to load firmware
  ath10k: use request_firmware_nowarn to load firmware
  brcmfmac: use request_firmware_nowait2 to load firmware without
    warnings

 .../driver-api/firmware/request_firmware.rst       | 29 ++++----
 drivers/base/firmware_loader/fallback.c            | 24 +++----
 drivers/base/firmware_loader/fallback.h            |  8 ++-
 drivers/base/firmware_loader/firmware.h            | 28 +++++---
 drivers/base/firmware_loader/main.c                | 78 +++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c                |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |  8 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              | 12 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              | 32 ++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 12 ++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c              |  4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  2 +-
 drivers/net/wireless/ath/ath10k/core.c             |  2 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |  7 +-
 include/linux/firmware.h                           |  6 ++
 29 files changed, 177 insertions(+), 107 deletions(-)

-- 
2.14.1
