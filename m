Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELsEkmdrVTKa97l80S6ZPu98YmglySIudhuGzoAUUpo0VJMtwV+DDXwIrhyl/6zEallmfr3c
ARC-Seal: i=1; a=rsa-sha256; t=1521607315; cv=none;
        d=google.com; s=arc-20160816;
        b=kbFiIcbNkHHaflD6qwZbxljWf1dd6wALDTnEt3nhv6yDWv6etXirCUs/wPydB00F9Z
         aM6vALJRSzHNKvGmsAQyqYVwe/YGIUBarTiuMkPhHKT26WLyj++zP4H+YoDP7SLcHAuV
         j3qJB9SeXJ1U2Gmunxtf7YdN+/Wa8i5bvCqlXXmPKG9OtrLRPdYIJfXUDEkSX9/t5oLm
         aF3ef+EbOdxArCUEUSEepD3rzVVA9JtUiBl7w9WWkCFB1Q7bK2hatZgC+8r9qq4UhNeW
         0g72VFl/Zb2j9qum3QGxLOS66KhMhl+1C+2P6SiBnEP8KJI/qJarXXhtj5sEBSWhNlYa
         dYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=0VOeSeP4cusJ8mtTUqTQkz3lEYPAEneFJctHBhWhSKM=;
        b=KwtflCi3jtn+y5jCxBV4kWSHvWzcmXvLw6XN9tHl+Wtwqbb6bjOKZt/+ZmHxn6jBkd
         Z+yg9Z+QWXDyRn6dtSYMQ9GNHqIylJ2xznSMRcCI9HL1nmXgIe66PV9PqECwuhNogC1b
         tFiG7myPKLG/p6ZurNLfcfvnDapfpBe8YY5C/UgeuOhdzLQD6AIjilXtaD3j+g9iN8po
         BOjc6CgIe8+kEziEYQC2FqWm2kSqmIPkvCslAl3/wnqu/5UCKl++hURfcq43fYjFOdzo
         gom20bCNiILnJeqs4IdFgv11LyYCiCy+s1kf8dR6aWqPokCe+BO4RhaCUXVVKB2gpfmk
         w4qA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 203.18.50.4 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 203.18.50.4 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hkpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:41:53 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 6/9] arm64: tegra: Add pwm based fan support on Tegra186
Date: Wed, 21 Mar 2018 10:10:41 +0530
Message-ID: <1521607244-29734-7-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520912881725218?=
X-GMAIL-MSGID: =?utf-8?q?1595520912881725218?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add pwm fan driver support on Tegra186 SoC.

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---

V2: Removed generic-pwm-tachometer driver dt node and using pwm-fan driver
    for reading fan speed.

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
index 19e1afc..27ae73e 100644
--- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
@@ -1053,4 +1053,10 @@
 		reset-names = "tachometer";
 		status = "disabled";
 	};
+
+	pwm_fan {
+		compatible = "pwm-fan";
+		pwms = <&tegra_tachometer 0 1000000>;
+		status = "disabled";
+	};
 };
-- 
2.1.4
