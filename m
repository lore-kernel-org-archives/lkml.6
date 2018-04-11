Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+VgMkoJhT5nkrIGG+En0FMBtAE/irnS/JQTAiaIO+lwUJ4tpOTqZkXb9cDZEe2uWTzSIuA
ARC-Seal: i=1; a=rsa-sha256; t=1523473412; cv=none;
        d=google.com; s=arc-20160816;
        b=Wg3eqPOVITvE0JD9ieH4wY0gqn4dLP2M1XhkkxaftcX77iEtrZXiNrrMXiQoZ/CcJy
         Ng0UXNaD1vEVMk409SlSPZ+Jl7icgXdG21SzgrMdkPLEDqH6maklTPWSp2fwkCiENoTd
         ZXcx++oJ2hGPMhjuusXxtYjWQmZ6JHULIKrYPIe2Krt1I1/mGVZCL/pgFgcy5e+1V0ao
         PywZbv3lsev97fmKJjrCDan6TCQMoZM76Xxw9Zkl7uB4cSAyQ2eSvoXkMR0cJiR5xeAZ
         fyedr+CU77UpNoR9xfV6yY/WXmzq4hJ1RrI91P0kCMilZJiiPJ2p3U3pvPZk+VnKpcvp
         q1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9toQtqEFrrOK3UW2PKtC3tImFA0pVO99WFKdb4tPBrU=;
        b=XY0CZTwbVutWhcMQAX1GR/D6vyzwezI8NN9lsg5VZcJhFmRu9Oxi55kBho9SGiXzYT
         aDO5og8TRMTfnefQJA4gJq9W+HaS0DgVGe/V506xUqrmE9xziPKXX5S/xqMGZSJtqY7P
         Ok1KgOPoMYcaPn2A5xsxaQ9riX/g3D24F9Ra5cJMjHuiTCAxH8aA2ym3XGs47GarM4zh
         KiITQDPd8F4OF8GtI1Ha4i4RwWGiUTOfdsdN+/tU5e1ajsituXl3tpMV6/vIcDLwOUk+
         3lXHGfdV0NP3ebB6Sg+v+x1J4Wfg3LnE0Qbu1h9jsy1Gggs3Ts6jSS3F/+yX5n4Tm5PH
         wrjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 238/310] net: fec: Add a fec_enet_clear_ethtool_stats() stub for CONFIG_M5272
Date: Wed, 11 Apr 2018 20:36:17 +0200
Message-Id: <20180411183632.731138010@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477656113011538?=
X-GMAIL-MSGID: =?utf-8?q?1597477656113011538?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <fabio.estevam@nxp.com>


[ Upstream commit bf292f1b2c813f1d6ac49b04bd1a9863d8314266 ]

Commit 2b30842b23b9 ("net: fec: Clear and enable MIB counters on imx51")
introduced fec_enet_clear_ethtool_stats(), but missed to add a stub
for the CONFIG_M5272=y case, causing build failure for the
m5272c3_defconfig.

Add the missing empty stub to fix the build failure.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/fec_main.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2371,6 +2371,10 @@ static int fec_enet_get_sset_count(struc
 static inline void fec_enet_update_ethtool_stats(struct net_device *dev)
 {
 }
+
+static inline void fec_enet_clear_ethtool_stats(struct net_device *dev)
+{
+}
 #endif /* !defined(CONFIG_M5272) */
 
 static int fec_enet_nway_reset(struct net_device *dev)
