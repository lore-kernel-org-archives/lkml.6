Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo3eP9gwcquppojAN1vPvyutRD2iPMkzSzVOKGgkorYeTWrB2/mF5x2G3Ota2haYS8GA6IW
ARC-Seal: i=1; a=rsa-sha256; t=1526937902; cv=none;
        d=google.com; s=arc-20160816;
        b=yFu4trZrKpo1fn34rXBegwyAndimSL220puTZ390t/WvrT0i9gJzeO9M7d1qHAwz1h
         0jl6NlbxXqJcXrBQfJj23EE2eXoEr3Xl661mPvgHiD0wirBHH+/h/4vx7PX8N9kVdOeL
         +rmul3mrZS1gRJLrLu64tqrl/GZHFwLWEv9kmVb4tH+MY6Aswbfw/Bq7+JYbtTGcsoQY
         X5aYb0aZAalePhjMur2Ae08Fp9bHRPjygmg+lbFtlzhtSNYG2vDVUW0E8nxMfmEgnp6Y
         T4DaNnmGw8dSfpVdZUrxCo+8O+RMCMthHI9ouLCPTpJB8BHCs0TbowMnXAU5ioXz3oEv
         RnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=swFjaaDSNkQHv2w/N76rV3KVRlTJdpNYgLSkrnxxJIw=;
        b=xJgQ9htHG24Es85GcKg3GMjcVEGo/nfHQ6blobQaCvyddNQPQ5c76kf2nYOM178GAN
         3O2Hg6IkU6dINZXlbTKbVhGE12jHZhuN0jU6E09CGrqFphdJCPlPeGah25UALQLzJHYb
         H5pq7rKmVEyV8lTfkiCV0vhmA9m/GRQjJCUwlBd4FRxk+KJJMKoJYp8Ui5t70uv3K5S8
         u48mfI8x4V1+Fn34t6dCl0TwapoLdi2Ag8QmVwQC2N9yCjqGF6Obfi6X87sFigvNfQjK
         pjSFoTAcKozls5xO6DmHk5t4REu6JJAzvelvA3pusBX/SG6g04Xp0uv0dXG93mJR3y89
         3UMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=feo+kSOF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=feo+kSOF;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 035/110] cpufreq: armada-37xx: driver relies on cpufreq-dt
Date: Mon, 21 May 2018 23:11:32 +0200
Message-Id: <20180521210506.829446267@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110437993449287?=
X-GMAIL-MSGID: =?utf-8?q?1601110437993449287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit 0cf442c6bcf572e04f5690340d5b8e62afcee2ca upstream.

Armada-37xx driver registers a cpufreq-dt driver. Not having
CONFIG_CPUFREQ_DT selected leads to a silent abort during the probe.
Prevent that situation by having the former depending on the latter.

Fixes: 92ce45fb875d7 (cpufreq: Add DVFS support for Armada 37xx)
Cc: 4.16+ <stable@vger.kernel.org> # 4.16+
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/Kconfig.arm |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -20,7 +20,7 @@ config ACPI_CPPC_CPUFREQ
 
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU && CPUFREQ_DT
 	help
 	  This adds the CPUFreq driver support for Marvell Armada 37xx SoCs.
 	  The Armada 37xx PMU supports 4 frequency and VDD levels.
