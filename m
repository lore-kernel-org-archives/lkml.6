Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+wM+whxdXdAC+BSx3g3USf92WlMxjAu93ooJAgfae9rhPeZ3RGK9U05BIZuWHlRu5VDhP/
ARC-Seal: i=1; a=rsa-sha256; t=1523472559; cv=none;
        d=google.com; s=arc-20160816;
        b=EPHEsKN60e82CrGdVM7bju/cmO4dLdUgeT6hOhbbCaHQ47C3kDjV/kkD+WBUNP1Yvc
         2DviTFUAr/HBcmOT03hbV51W59JimQs+pTvsJtq6Dbukqu5b6QUjCZOgWZqtSztuX1n0
         NZ2WC0U/VJbkswzv7K7LTI+cE5RFprGcZvvDQ5bR7zAbILrtL5j4/BA610l6Ihy3rC/g
         Hy62e7VOuBpAg+dDZOxMYQWCsViJYoJrhvD04bFLFk3ixolK7EIfkHQSyVj5JJwast/I
         tUAgRaghm/EB5j4MvRwDLpNf0U4l/M2ZZl4I5VpRwDqb/saSI1Bv6i37oNMwr+oJK1DP
         AJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6cA762b/A7MfUAC9pXKEXp1iDna7refHwgUMWDQ0uK4=;
        b=hsHVtQQhDLPusXGnGBp6uPZSiIEggqrH5A4sZV28ftkhrSskHxqa1rOn63B4lo7KzJ
         6YqcavEK/w7fBu/eB34vj1t3Geg7fD7kumkqokw4lfRCe2A4rrWUBhbX4xyHP5bJB22F
         J+ZZAPfz96ufknp+sasKGoZWHO8Ov5RJzEMnUMxNhyWyxPSDqUBeqZFOL1WVG9GRBym4
         2Ymct3PtEUa6d7bR6Iq4IWOBto2SPvCsy59BadO3XvVGbBV5eKYZedhCVJF5J+an49be
         8sacz6owRsGlXF2vS9nvNZY0t2j3R5fGCXcQ/41M245TX4iL5cD5m28oIuW/kAleAerl
         NSvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Leonard Crestez <leonard.crestez@nxp.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 128/190] ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
Date: Wed, 11 Apr 2018 20:36:14 +0200
Message-Id: <20180411183559.683220826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476761935649946?=
X-GMAIL-MSGID: =?utf-8?q?1597476761935649946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leonard Crestez <leonard.crestez@nxp.com>


[ Upstream commit b3ea575770c7eeb259c77b6861cd14d00eb309df ]

Support for imx6ull is already present but it's based on
of_machine_is_compatible("fsl,imx6ull") checks. Add it to the MXC_CPU_*
enumeration as well.

This also fixes /sys/devices/soc0/soc_id reading "Unknown".

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-imx/cpu.c |    3 +++
 arch/arm/mach-imx/mxc.h |    6 ++++++
 2 files changed, 9 insertions(+)

--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -133,6 +133,9 @@ struct device * __init imx_soc_device_in
 	case MXC_CPU_IMX6UL:
 		soc_id = "i.MX6UL";
 		break;
+	case MXC_CPU_IMX6ULL:
+		soc_id = "i.MX6ULL";
+		break;
 	case MXC_CPU_IMX7D:
 		soc_id = "i.MX7D";
 		break;
--- a/arch/arm/mach-imx/mxc.h
+++ b/arch/arm/mach-imx/mxc.h
@@ -39,6 +39,7 @@
 #define MXC_CPU_IMX6SX		0x62
 #define MXC_CPU_IMX6Q		0x63
 #define MXC_CPU_IMX6UL		0x64
+#define MXC_CPU_IMX6ULL		0x65
 #define MXC_CPU_IMX7D		0x72
 
 #define IMX_DDR_TYPE_LPDDR2		1
@@ -171,6 +172,11 @@ static inline bool cpu_is_imx6ul(void)
 	return __mxc_cpu_type == MXC_CPU_IMX6UL;
 }
 
+static inline bool cpu_is_imx6ull(void)
+{
+	return __mxc_cpu_type == MXC_CPU_IMX6ULL;
+}
+
 static inline bool cpu_is_imx6q(void)
 {
 	return __mxc_cpu_type == MXC_CPU_IMX6Q;
