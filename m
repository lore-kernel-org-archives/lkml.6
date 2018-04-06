Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+PSZ/q3xeZUlbqPEiD1a9idu/76T7srPOhO8Dyxl+1y5FnO+UD2EMLLU9wVmJzgRKE9TjH
ARC-Seal: i=1; a=rsa-sha256; t=1523022129; cv=none;
        d=google.com; s=arc-20160816;
        b=xukdRW9xGFIGUlW7Ec0x00k/Vxw7+dIBsibXiuLXHHAlD3huPELs4BcZghq22pDtWT
         oJGZPmEm5qxD1r6++Ds7OyllhQbGGdQbUQCwH/YjwTeKaVki5/Q6hcpuXYrvXBG701uH
         oi6syMzGqSmklvWYcljQnO7PiOzrMq8XmiRocne+XixwA/gXdxGpfYabbEazsoUDfA/S
         Xr6AmCPly5K+dH3fvAh0Ii+E1psemBpOJ9hMvJk1igGJ7hP85QhntUQrhPe2izfQwnqA
         nmznJhiqpfVJCIZZbSAKnzCCwSD6HSgA3xVYyEBcwts6WYru/lfn8gaZ8rC0+4yqZBZi
         7lRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=INgCciu4DCjhZSGUgcp5GRiABI7zKeaIzK/+T7npQqE=;
        b=csIhSgg0iluuMS0f0X/CRL8xKSin7Cto6jWJR052LBIK8k2yCrjkBe8QrgVJIjBaZ1
         8uBzxPD/2aseloeQGriI8AmkCOIHVreFPIjz3Qe+iimmQMnPipmxFvf3LHA2Ua22aZlN
         HG6lk8Fx797bXrBBXrwTxSzj/B4xoOww+z32nkS0bjBSoBjEjYv2OUQrSAWVhTwZM7/v
         l3YeWMmAJsS2n21iyGmxSGSK2O5FLl9hhmPwVaq1HYAyDWEc8UmzIALOAu2Fq9HuUJX9
         SVSyE0/dkRbCCO66wP05aH4pCHHj83CHtfuavx70N93uUD+QImBnvBlqIKmFanMRErm2
         rhAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.15 37/72] phy: qcom-ufs: add MODULE_LICENSE tag
Date: Fri,  6 Apr 2018 15:24:12 +0200
Message-Id: <20180406084352.345488368@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084349.367583460@linuxfoundation.org>
References: <20180406084349.367583460@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004285935237557?=
X-GMAIL-MSGID: =?utf-8?q?1597004452441137341?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 59fba0869acae06ff594dd7e9808ed673f53538a upstream.

While the specific UFS PHY drivers (14nm and 20nm) have a module
license, the common base module does not, leading to a Kbuild
failure:

WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o
FATAL: modpost: GPL-incompatible module phy-qcom-ufs.ko uses GPL-only symbol 'clk_enable'

This adds a module description and license tag to fix the build.
I added both Yaniv and Vivek as authors here, as Yaniv sent the initial
submission, while Vivek did most of the work since.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/qualcomm/phy-qcom-ufs.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/phy/qualcomm/phy-qcom-ufs.c
+++ b/drivers/phy/qualcomm/phy-qcom-ufs.c
@@ -675,3 +675,8 @@ int ufs_qcom_phy_power_off(struct phy *g
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ufs_qcom_phy_power_off);
+
+MODULE_AUTHOR("Yaniv Gardi <ygardi@codeaurora.org>");
+MODULE_AUTHOR("Vivek Gautam <vivek.gautam@codeaurora.org>");
+MODULE_DESCRIPTION("Universal Flash Storage (UFS) QCOM PHY");
+MODULE_LICENSE("GPL v2");
