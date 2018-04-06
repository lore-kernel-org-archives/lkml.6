Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx481TaDIMInAl4LjPYKX7wPF2yA4/u+5c8bY7tDPTxFDl0eALFcCPndr6n7nrUuum6kQzGaa
ARC-Seal: i=1; a=rsa-sha256; t=1523021970; cv=none;
        d=google.com; s=arc-20160816;
        b=FR72h2SjH+7M1dFlHxgfrHWcBWoTGIWTZKJLj3KdbWuaCRkqT7eUkzD/rj4iGO4I3p
         DVdRnlqBFO8lntMQBBrU34tb/9J47iJxeKUZyrGGOlr57y1mLPL4yJjIvxAAWC7iGjvm
         VLkwOoE3zF2e9sTabK2lxzKY81Ct9ackaJzpDjtwvCoa0xqjOWxqKLcYg1lpBvlSZxPU
         YejT2o7a83HgEau62WeePBT+2zZWNs/VsUJ5NNGTCq/cancn8kX5GUIqTLTygu/TFrdk
         1cfRANIWEHVtgcCmHlKyFkWbPL1+Rdvmzbq4OyxHYxQ4oyBUnyexyq2xzRE4lEXmPltM
         i2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YHvNSNGXCF04ndhE5RcQ19LWxyj8Y5QDBefptQDXXV4=;
        b=N05MbABw0je7TUJ9kwqq7+/8XAHsibQbcCxCVpmYxiAT+Rd1wCybIIuf8pdNbjObL6
         OB7cSSsr4OtZIGeMgurwmyHQsEkjkJ6dQzL/FeYTkn81RdMVI+wS0dd09uRIJE1BhU45
         H/cNBVsO0jR8De5hWopEUoXZPW2N0h5GCwEqT3fFwWjZ0pDnfnnaxJHV9PqjmcyklAtU
         OQQkPKD63anP2j1r7xOGjMhe++RTNRQkuxxJG5fypDjEmeaC+kuQn1iB3Y2A1oE7Mpu/
         PBSX4LKOnbm1hykFM9bm7a8rsxfTW1n8qJB65+1vmaFtBCfHxpV7YrijTzYK4Xa55/xQ
         BSzw==
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
Subject: [PATCH 4.14 34/67] phy: qcom-ufs: add MODULE_LICENSE tag
Date: Fri,  6 Apr 2018 15:24:04 +0200
Message-Id: <20180406084345.846193640@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004285935237557?=
X-GMAIL-MSGID: =?utf-8?q?1597004285935237557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -689,3 +689,8 @@ int ufs_qcom_phy_power_off(struct phy *g
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ufs_qcom_phy_power_off);
+
+MODULE_AUTHOR("Yaniv Gardi <ygardi@codeaurora.org>");
+MODULE_AUTHOR("Vivek Gautam <vivek.gautam@codeaurora.org>");
+MODULE_DESCRIPTION("Universal Flash Storage (UFS) QCOM PHY");
+MODULE_LICENSE("GPL v2");
