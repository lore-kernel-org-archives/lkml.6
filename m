Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AH8x224pOfi4DlAFHH1Qu0jRwQ8YF/xLnbViEsd/kVTx59Ei0ZMy8JI/bCXBXRrPS3nj6PAvrfSV
ARC-Seal: i=1; a=rsa-sha256; t=1519786606; cv=none;
        d=google.com; s=arc-20160816;
        b=ZkVVGf1Jagben9nPQG32rVv1WDg77ulrMjzox+QaP5m5WaELyIy04A48shzJ8Dv6xq
         Tj9JXv8Ba/ULyc/HXVvdbsxAONAOem1p6ezdlWkIlTm4Lwaeka2VT/vCtgMcmLwNkHal
         MyxqSVzTDcpe2BrAC7FBIHmoqtgTePxKqSOTIroQroo3zzcGNx3H/xK5qlta+sVpHqBh
         ZA8lo+cKhPzR/dPcpttRRE91K+CZP4nVH0MDc7+LPZtI/K8pXJ2+4GuxgYDwywPofHcT
         6bd5yemstyBMy/jKBVAuenqRP6JbnKgKZsoh6/4t+iP5TNiQBIV7VOfbtbZs40K+gIUO
         79rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ToAbSWF81jVVnIiDbKamVsVrabHTPYoMXvZtpwhSj3A=;
        b=u+vbKdtuKDUEIIjSXZjrzMWQFj7kM1B5ADUAGYR5dooRxd78RRxPgy6p4qMyGe4rRE
         w/6KMMjvRTpdrzxsBdUJ77Zl+/yOSZu0W6kmhri7bQGdxKsnKVsJg462YWjBiSbnNLyT
         Ud981QiIWsS9UB4af8xjrJMnE9HbmjKtxMnoQslFjddvzOO1IgOS/Gm+DcUNgRhUWtQT
         rlsURAgb6JJWi8m18KRoh2cBMxrXszmmiepBJZAo6s9QHAKR78AHDtSni7sMiqKYC/Rh
         Kti7H7jaSFtyr6PNE1HRNJ0P4GVvdeUknXLdfklLNqhEnvzzPYZ7afCGea8ZL3kfR4pN
         7IPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,403,1515484800";
   d="scan'208";a="34674472"
Date: Wed, 28 Feb 2018 10:55:50 +0800
From: kbuild test robot <lkp@intel.com>
To: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc: kbuild-all@01.org, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	roy.pledge@nxp.com, laurentiu.tudor@nxp.com,
	bogdan.purcareata@nxp.com
Subject: [RFC PATCH] staging: fsl-mc/dpio: qbman_pull_desc_set_token() can be
 static
Message-ID: <20180228025550.GA1581@lkp-snb01>
References: <20180226162807.20649-3-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226162807.20649-3-ruxandra.radulescu@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593611760894836455?=
X-GMAIL-MSGID: =?utf-8?q?1593611760894836455?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: 1628e2e4dc76 ("staging: fsl-mc/dpio: allow the driver to compile multi-arch")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 qbman-portal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
index f57c151..7b75c93 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
@@ -522,7 +522,7 @@ void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes)
 	d->numf = numframes - 1;
 }
 
-void qbman_pull_desc_set_token(struct qbman_pull_desc *d, u8 token)
+static void qbman_pull_desc_set_token(struct qbman_pull_desc *d, u8 token)
 {
 	d->tok = token;
 }
