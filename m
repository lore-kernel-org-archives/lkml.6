Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/+IvIEE/IjVcRw3ecRhy1lMAnJXg9lr5+Ejxbce4+S8TPxCUyqFxSBPSq29amUpp0LcakU
ARC-Seal: i=1; a=rsa-sha256; t=1523473357; cv=none;
        d=google.com; s=arc-20160816;
        b=uV/Z4fi95cA+WuY5wKXJsPV8/toSE4mCH/wuJea93J9wYzDIOX69nTwEapj7F2z6A+
         19kJ1XjbN2/KkQRCLMmGE1VcKGGLxhiht2xL3eXrHN+EzL8GMe7/H8dEVwHX4dBH4Tgn
         FTgbSx3dinLpffgNikZHVIP8Tdrqi8thKIc+bKMmglNgwXF+oKdpjEd6P3MNvcw+hZg8
         pnws5zC5+nP3kHa9gV9XO2lFiQyULZI6FkZwqwLniUF2t+tEcP7iOVJ0qIiE2OqdS4ST
         c4tFOU6b7o0sZQ/nb/c4VNOLyRLzNqz/vXUWZBOALm2asjiqc3k3hKZVyDVPAfb9v6cY
         pZWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fIYEHa6Y5YepFxQI0cHsK4jnPzvnyUWqx+YtwX1prBk=;
        b=WX3odlqPXfQzmOeDiNO1mhroNksUGHXFjIPDC65aXucfZZ4dj0nEpfgit3rP3PRKrj
         JwAUtpcqWuLLxKzChfqHiNl90REfxuBsXy+0fD0niWkct73ZQgpaltbedqs1oYWMP/Nf
         KyiY1gRsrZaMdFkUa86Z8g0icY36vB95GP2p/M8VltalfxdZ7obk//V7Mk5N1ndfwv/y
         yuIO/sE9ES33xrkixQQcJBBWKnkW0F2QeaL1voRLcGZk7b3zCRtag05rb5TwIQO6l1/R
         irail1R39Y1xN2y4/oj4qkJbHfnbkCGousB/EE6wR6VAXBAFaKDas5kIFBVvIq7lIU70
         qbpw==
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
Subject: [PATCH 4.9 211/310] ARM: imx: Add MXC_CPU_IMX6ULL and cpu_is_imx6ull
Date: Wed, 11 Apr 2018 20:35:50 +0200
Message-Id: <20180411183631.640062443@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476761935649946?=
X-GMAIL-MSGID: =?utf-8?q?1597477598632885687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -131,6 +131,9 @@ struct device * __init imx_soc_device_in
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
@@ -73,6 +74,11 @@ static inline bool cpu_is_imx6ul(void)
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
