Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuLXh/KHAO63b6IH8veYlqG2HOL2mRDe2vLjklJWe+4TtJRjTtM0lePK3s9qNAItfkPnAGv
ARC-Seal: i=1; a=rsa-sha256; t=1520485468; cv=none;
        d=google.com; s=arc-20160816;
        b=ZorR1o4kfHJ5yK+5kPUDjrzeu0d++Owh0X3BzJUceQeJA6JVGIxWPkxMAYzk3Mtmgu
         rA4b24knydCR+xxR1osC1CRm0/UT1N/Jc+zoueQlH85yhoDQE2dfV0p3z7h04l0hnZYj
         EF6luPiFWkA4HPYsywHtBL9SwDb9h/yRmuWUqildGbjigGcFUZV9dJRp6FXQmRsgJbhD
         3jEJgqAYdqVcvpwUTtH7p/RAlf5RjAX3LxWs0ED/WH5pFS1w925v5HQi6ezsVW9jwYcf
         oIT/4JolUJYrlEMayCP6+yOU68K4B1u8DXqOv5fWcVL15NodYEmc4DDYRLafhV/mVMn0
         zl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=I7atogOTg33G0Z4TNuWW8dYziPm86zMX7xm5cVE4cS4=;
        b=oMsPDsdn6o4TNruGLgM9+FoVTqx/km5ofhjJ6AxLfZL4qeS95N4DPtAl9icIczitc+
         tCYU+dYV/5IrxGEzjmBwrfrASDr4IAjqVdPa3vz7BoSIuSY62UGqP/r0FIltu1E4ht0B
         TrdGOrKKbP5cMk8XTyGsFKEBu++ABmPhMFFk95HagB64ym1xgCexFIbxc5O4LuVk8Mse
         o8c94dFe5cczxR4F8NmVPKjdX4hbqsqgeIzczGOEFeTaamsD3sznTtgXZmp72a3eu7t3
         xFmZGO4lc6rB5BYndWAiwuWtVBbwgo4zj9JwXM61BTKVoEqLeR9X3jpLpUW4WwzNRyal
         Aa6A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=GV/Mc00k;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=GV/Mc00k;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.137 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Walker <robert.walker@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 179/190] coresight: Fix disabling of CoreSight
 TPIU
Thread-Topic: [PATCH AUTOSEL for 4.9 179/190] coresight: Fix disabling of
 CoreSight TPIU
Thread-Index: AQHTtppWiTljdp25w0um3ODed6tzAA==
Date: Thu, 8 Mar 2018 05:00:11 +0000
Message-ID: <20180308045810.8041-179-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:7NJR1HbYkshgMwKEa3z0H6outS0XqAglae6XcHia+eAf5bgtu6KDZ09bnyUi0DZGVCKI/d8w2aAYg7nDAlHjL2H9WC9UG+zBnw2A5fvQ+PvQzs2rbzVpWhibWmr8CwbLKsl/RPuKA7a85XT3YXEv9Dbi9Wq+T2PGDYKQDVvM22qBvW/wuVpd14iM13qoMiZ8quD9j7K2whABROU+6CT7IkqKnlElAhEebkAfZPUYLP3BqhzRohgzYrOzdA/xH45V;20:m4lPjAn4StrECsmmMqlhVkg1rCNK3lGOOzZQQLttOj3CZcQn9lU1cuAKOugiCGrDYgI1cWj3e095edZmKJqkx4nH/zQRmn9fFY8BLtjHBigGi6p35KMVS6+HMMx6N6Soqx7sxCTajXYB0PFKaPYY9lqLSMrVLrrhkB5xFp3nk7k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b8c5982-c396-447e-c5ff-08d584b21143
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919B0A0E34551C40D3AA643FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(575784001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: AYaItFzNpw8esm44jSKiT5O/SPX7C2mcY0jxZHJ4qLccWB7V9STl92c2+r5VI5AbFZthxcJ82oqXvoS7lftGH/xo+prdGuOKedBzLzh3dGF5GIat+LtfDvRLJllOYz3zCO3CxE/OhGtrs3GfsJat4KJwuFAeHgyR4+DJ0Z+cLWzdAZjNfxxs2OjQ5uqo8A7z1G126x0Z80d0pXeB4cS/ZcJC/8hlbrdCJls3PNEooqWet3WL802PBJjpvbupxnhmO46ng+R3zI6IHXj9PejKl3OaDjo+pYQxlNkqwO5fhHa/FFqemyMDiMZZGq3lF2Ynh87zIv8uAKjDNZxisr1tPA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b8c5982-c396-447e-c5ff-08d584b21143
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:11.8227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344116420518797?=
X-GMAIL-MSGID: =?utf-8?q?1594344570519133866?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Walker <robert.walker@arm.com>

[ Upstream commit 11595db8e17faaa05fadc25746c870e31276962f ]

The CoreSight TPIU should be disabled when tracing to other sinks to allow
them to operate at full bandwidth.

This patch fixes tpiu_disable_hw() to correctly disable the TPIU by
configuring the TPIU to stop on flush, initiating a manual flush, waiting
for the flush to complete and then waits for the TPIU to indicate it has
stopped.

Signed-off-by: Robert Walker <robert.walker@arm.com>
Tested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtraci=
ng/coresight/coresight-tpiu.c
index 0673baf0f2f5..ff579a7c6d00 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -46,8 +46,11 @@
 #define TPIU_ITATBCTR0		0xef8
=20
 /** register definition **/
+/* FFSR - 0x300 */
+#define FFSR_FT_STOPPED		BIT(1)
 /* FFCR - 0x304 */
 #define FFCR_FON_MAN		BIT(6)
+#define FFCR_STOP_FI		BIT(12)
=20
 /**
  * @base:	memory mapped base address for this component.
@@ -85,10 +88,14 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdat=
a)
 {
 	CS_UNLOCK(drvdata->base);
=20
-	/* Clear formatter controle reg. */
-	writel_relaxed(0x0, drvdata->base + TPIU_FFCR);
+	/* Clear formatter and stop on flush */
+	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	/* Wait for flush to complete */
+	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN, 0);
+	/* Wait for formatter to stop */
+	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED, 1);
=20
 	CS_LOCK(drvdata->base);
 }
--=20
2.14.1
