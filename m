Return-Path: <ran.wang_1@nxp.com>
X-Google-Smtp-Source: AG47ELtRuGQqifkLtuH0JjasdMx9dHyE/GOjaw9gyNzNXKA+z7g/SrXrBbZfa/0mZdTMhvuQTxCv
ARC-Seal: i=1; a=rsa-sha256; t=1520340946; cv=none;
        d=google.com; s=arc-20160816;
        b=ocdOhg9TlyQL5MTSK/Ma7AnnEGv0VWSr+csEmw3JCFacVcwhcOUqc7W1mOBejmV/lP
         QeqOjFY3w4ZYMWr2kuGBqo9T/Bs2A0MILZ+ZuJfxaJIAmPAPI6DrbPpOC1KQzUAzTtKp
         j0g708bKSujgbTNwzu8DxcIUpCuyOlyxQ8SXJzqNVNK4fxzs8eFDy/6wg/WhRpksqN55
         f8+0vOgT+1H1e3nmbGiA+wgK00KXFcixbGeZQqsKnoWhhg8NFynUFKeVYyEggtnqYuLs
         E7CfKdfPJl+sUgoVq+DcUQ2owoNBR/jjQxgbFr0T54FTjcmvEMnH6K69vS/rBVk4jM7v
         5Z9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=z6cR3lyUlUzMtL/gfVGEOSFne4BFrOgZQn7CLz+2YhE=;
        b=R6glCjw98iPoxjnsHk58s7ABFK+mV6VEdi2btbxxpXXw11h+Gwy0JzGUddExz/r8fN
         u9vrQ+bM8yt2zO5FoTtdTkSnEkwDD3gOfaFB8Sf6KAmzFg2UjFJxe1DphzP7pHtd/7Xh
         rTae2TofaSXbFxvrnRrdSmZMtK6fqMs1YM0e8DkZuM8QzZ3WiLoi4AcclNIS3u7KS0Ia
         e+KlEXXQlAVWwKH+HvPMH5HBEohREUhZ17P/99PpTyr0UXXEWxmLYRF4d58pdtCcYfUB
         8lkOM3uwtrAAEQjgW6dwY8zPvyaVCLtuno1GFU4A6eNdoDQFwA4GG/b0iEvXyIvOek81
         obyw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ran.wang_1@nxp.com designates 104.47.36.84 as permitted sender) smtp.mailfrom=ran.wang_1@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ran.wang_1@nxp.com designates 104.47.36.84 as permitted sender) smtp.mailfrom=ran.wang_1@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=fail action=none
 header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Felipe Balbi <balbi@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Li Yang <leoyang.li@nxp.com>
CC: <ran.wang_1@nxp.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 3/3] USB3/DWC3: Enable undefined length INCR burst type
Date: Tue, 6 Mar 2018 16:59:11 +0800
Message-ID: <20180306085911.5930-3-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180306085911.5930-1-ran.wang_1@nxp.com>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131648145445570435;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(396003)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(5660300001)(2950100002)(6636002)(26826003)(498600001)(6666003)(8936002)(81166006)(86362001)(8676002)(68736007)(81156014)(85426001)(53936002)(305945005)(356003)(97736004)(50226002)(104016004)(50466002)(47776003)(36756003)(59450400001)(76176011)(106466001)(105606002)(1076002)(110136005)(16586007)(48376002)(4326008)(51416003)(54906003)(336012)(2906002)(77096007)(26005)(107886003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR0301MB1190;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD020;1:Pbc5WhWZjtKKp0c1aPRR6aT3lqB5AqzsDB4EtxgfKM9Tp0s6onSoG/TgREhPL1lNiP4Vus+nSG9MEwElsVMJBcmzA8C4AO8bGLhGJUf3IZlHo0t20lxX5ED1VEKO6Lfy
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d154acc-0483-402f-e623-08d583619313
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BY1PR0301MB1190;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1190;3:Lm8pSfBW6uA0GBdNlDC3bFgdL5X8eu7s/9lhZjK5Fk16m8PZUCTuamG877dOqi++xlGKX/ozGWjcmy+YDFEAU+qjZis4n49+4t5MJkIjzfuiCOHqeoJV89vo9y97AmbDd29qAzQ7rigHHRdG/E4SOizUBqbHudoQcMR0J56T02prAyUUXLrdzBApdHjawG17JjUyOaNSSFCTIZuHa+1/KOsuyIuZ3MeoNsTXfYtc2Zqk0sZHfWs3RnnMdh1ruebfRN9sJY+b4Bnvizlq19XTwhxpSpxN1C77uhd3Q6pxcyjMTek53TkJRbahI1ciOSPcMmBeJQH8GnsKGJPW/ONdhexB+HAAt16GIv/TBSMXJqQ=;25:iJWUa0Qqn2TD9bP7zpKLQ2vW6qFWP0vS8orArtNrPDdBIunR7Iqt91kuQfdAR65ysu7O5oDwW7EBLlTpA+Dr7VIOv6s3Op5S1PE43RMIX9QqrngG41A6xHAUDbHXXMwLvCvU7/+ykk9Tnt7m49jlA8iMefM77yOx7NV5A7weA0rzIjWey/fGxQc7cwbyDsWf6KNFiUVb55REIk0+ZjbK+B+my8P53HBTIaeiGKSxpnzduGiOLVmWJcfkhJ4LwlJFZ3xolp90Hl1XhvMTL3R8WjCSgRgOGXVMIWfHkKxDKrVGWHByQU+cg7Jz4PEp+A0MSgQPQfUhf72y1cC8mdnd8A==
X-MS-TrafficTypeDiagnostic: BY1PR0301MB1190:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1190;31:X0bgf7z12+oE0DkDPzrBsey8aistbEZxmsZwWi11x10NqYzQx5doDxaeIfGMHLP2eHTFRFDQdi2zMsBkkcL7alVCOA7hegB6p3uJLzNSpC0hvrcMwkpeIhqNYh08Qg8wZpOEN2fO8mbUVKcuWCgRgM7s5g4zH8Pm4h+DAMTrir/a7mBCRu8mFIwL2H9yQma6zIga1nLRGWnqqHxfMpN5ZWh/AAohfv2DjI8JRc4FsEs=;4:r5P2X5PPA/83VKh+qRuNdC3QI8Jq+8hTAwh2F9iRGms//+ZSXZZLtIq6IiZLQQVUw9NiIHfkiGp9C6LxlMUc99qfXIOY5gyTfvgxpN/y+q/b6e/Kj1JpNcok6MkK+gOLJmlJrvXy+SwMJfK6g17oRHfXxNa1/Eh583mmJwJsRBoyIRGWN6LHTSmPkciRTvmpeAysu5h44djEajVWuT6J136ZaYhkc9T3Q4W+3i19dMJyZWiAoD3I3OiK4L3EqN2/iu1eLwi8x9SVDcJxZwni+u1TNyro7+0CtWvtnEblHzOK3h9Y4yJvWZnjE6iXMH/L
X-Microsoft-Antispam-PRVS: <BY1PR0301MB11902642ACD86EEC05C47934F1D90@BY1PR0301MB1190.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6096035)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123565025)(20161123559100)(20161123556025)(20161123563025)(20161123561025)(201708071742011);SRVR:BY1PR0301MB1190;BCL:0;PCL:0;RULEID:(400006);SRVR:BY1PR0301MB1190;
X-Forefront-PRVS: 06036BD506
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR0301MB1190;23:0IAAHl/peZA3tpYm2eCxBVxyWEdT9rw6Q1mNTge?=
 =?us-ascii?Q?/cvdZJWinfcw5JQ88xseCBUPZnly14UeBViOmzJmCzHHgNy0wv5rDP7ZsRF5?=
 =?us-ascii?Q?YLWT++r8tDVv1v3COskDuOgNGtu9utllzP5GOMknPVN/duoF/UdzR/71wpLH?=
 =?us-ascii?Q?PIE48oHcn1oWOt4CLtVVbP94QBUfgMMuxFJUPOjceYFLbBk1r036QannUzi1?=
 =?us-ascii?Q?B6aZOJVHh38ag9VCRZtjoRGtY0A/4SqV9S9fQ339/pi8W/6gDJ4lPsXDzV+K?=
 =?us-ascii?Q?WrmS0RLLiKOW3H1ul+tgeau5PgZ+4++F6LS5hqAc9az1LjVnvaQk5bbM1CU9?=
 =?us-ascii?Q?CES9zSRjRqU0epUrPjiOlvY2pjpXoYFvALZjwK1WWQtaCzoKSuaarhKDTLiK?=
 =?us-ascii?Q?UVPuauwfhFrZ+RfZnT5NYaYkxIpU/xqStq07OPwteJGlL+Iv5uAeyJDI21/q?=
 =?us-ascii?Q?5Ok9yGaPIMQiLf63vuS3HVLieIYslDZIAD6dK7qHSeIPQmeFVwTbvhT8DFr6?=
 =?us-ascii?Q?RjxO3ATaYhSt414qhVlDDpHQ085MrpvamFYlUt/5YIjp9P5AjKP+U99zSnka?=
 =?us-ascii?Q?ZXqW00bciZd+kO+vKsTRQvm/cR8Lz9xHSMS4PNlZ3MmPgT65+PvELCna+0yl?=
 =?us-ascii?Q?upnrO/E0k5ftnwsT5qfXFkkMa3ZsDYZFecwLQpjaRXYNaOJ8hyHJuK8DLuDQ?=
 =?us-ascii?Q?Hw9SL/9OPGxXr5CXa/Oy2Nj0xNxspdW32nv5fnMlGrXrxJt1YVoYeV0OaFuJ?=
 =?us-ascii?Q?sI1s6eWWziBEKI6qYViFhcg9lWpR5CGAv7t5ZqkxAFe1k9Wih2FceV5xNsmt?=
 =?us-ascii?Q?OALGsXdtXq/jVABBNTjNgrHrHYV/VxZyCJaHFJnVDVBVWbzUlccs/DvN1Hvv?=
 =?us-ascii?Q?i2GohVQEuydnSl9VFmBkklw+pldpX/6mRSqP3T2eQrqsA6iBVWAH5oZFWqGx?=
 =?us-ascii?Q?AxdGkumbkrxj0pTeeFCjkk3/XDXLUlbtBWu1CUwHrypPQFA6tiWrqJhoNzZX?=
 =?us-ascii?Q?BBGAyqUEz+e1CmOBFW7UsCZolBzMt9k02Xyk5FPlQm0MYfq0gibv414R5In2?=
 =?us-ascii?Q?ygD2zV/7aQFiCZp9NgeVvPQyWwWDrOKaX7WSApIOW1aCTTfamGFnvQQQyP1K?=
 =?us-ascii?Q?vY7nTjmtD/z6ez7p4KLdkoSgGvYjkkFVrPPupIPFq2gukW9uGYB7HNw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: UwyuKOlPXVsi2J4MxiM3ULThkTBA0bP6Pt3XDchBBzCy3LajN1MxdM9/CBOkDE6bWnPABGWlM5WI3rf+XAW8zNDEvWneOlVG5faGKMgrGx3Zg1cCN1o63K4Q+VqXz86JgQzJi+Hang9SFmw2J+clof3CWDT/qYyNgY/78sRVkbbaJ2afXnZJQPDGtiGHqPWf
X-Microsoft-Exchange-Diagnostics: 1;BY1PR0301MB1190;6:I0YCJPQknW2Ul3UjhGMAO5V5dJOw3oZZu45iNWvays6Dm6ABR+JkADAOOu2AgON8ckjR13rqKIB14oaTZ1IcIT3udJ15mXaLReSXWF2Dyfiz3fMnuC51h6tJ787eDG1DcK7Rl/UYtFkwdGbNv05pd0ZIbWP2rOG3a22UiJ6KLao/5V+dz9BBPpe5sGLnJq7t3t/FNX75Zse/pkT95VAmTOOmCPILfIYz9gzjyUbEEIdD6KeTHYCjvJ/SxXv/pBWVtkM29LxbtLUJUWXGh3H95dh2141hiG7qIR033T1amrMcwD+poCPWFNsSe6pckhjwJleGOfT3cc7IFAlQZ1OJ+fKR5WQahbsK4G7JVgJWAWM=;5:TLvyisdx2m/Wy7alLuUhRAhkD26JPYYk8n7uU0qCPmGG5cghW7ZTnsFpLFyzvdAou9ZZDsodyWsG5m8FU+h+InUa5/Dv2TGFc8k+qIAwt0AHO7rYGKcLSl1ez1anm7qNJsNNKHz6YvEHk61PdqOZrBsNApIntY5e5I/34K4HAs4=;24:2yIo0fvYvBzPRgU8PHHyU2heLTQLBUT4DnRuPUFkUel/VyfM/ekY9RgUQSSMXy4qov5Ac4JnjmsYabP7wgLynCEoPBSs2uz857AK1XFJOe4=;7:yfckHmv2LMpJNgW01+cUHRipnmNir9pQVh8PNKE2/KEDggo8iZ0/vuAk5MhHHG2tbvp7X7V6jGZv0k/80G7fdhURfDvbQepR5Ylt2nZQTZe5yZgIm7v75PNEuEEK6m1vu11blhwAlW189T/GUFXrY5ohN30rpmquZF9AIN396DK0OGKPDIgzDm2y426ZbG1+EzmZ42TPEv04GAogxnsUOJZ8iLUXQ3LFyr7Z7AkWd5cjOAsm4aD2cHrC3KUv2oFG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 12:55:44.3074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d154acc-0483-402f-e623-08d583619313
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR0301MB1190
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594193028414625225?=
X-GMAIL-MSGID: =?utf-8?q?1594193028414625225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Enable the undefined length INCR burst type and set INCRx.
Different platform may has the different burst size type.
In order to get best performance, we need to tune the burst size to
one special value, instead of the default value.

Signed-off-by: Changming Huang <jerry.huang@nxp.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v5:
  - no change
Changes in v4:
  - Modify the codes according to the definition of this property.
Changes in v3:
  - add new property for INCR burst in usb node to reset GSBUSCFG0.
Changes in v2:
  - split patch
  - create one new function to handle soc bus configuration register.

 drivers/usb/dwc3/core.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |    7 ++++
 2 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f1d838a..8ea2bc8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -741,6 +741,87 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
+/* set global soc bus configuration registers */
+static void dwc3_set_soc_bus_cfg(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	u32 *vals;
+	u32 cfg;
+	int ntype;
+	int ret;
+	int i;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	/*
+	 * Handle property "snps,incr-burst-type-adjustment".
+	 * Get the number of value from this property:
+	 * result <= 0, means this property is not supported.
+	 * result = 1, means INCRx burst mode supported.
+	 * result > 1, means undefined length burst mode supported.
+	 */
+	ntype = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", NULL, 0);
+	if (ntype > 0) {
+		vals = kcalloc(ntype, sizeof(u32), GFP_KERNEL);
+		if (!vals) {
+			dev_err(dev, "Error to get memory\n");
+			return;
+		}
+		/* Get INCR burst type, and parse it */
+		ret = device_property_read_u32_array(dev,
+			"snps,incr-burst-type-adjustment", vals, ntype);
+		if (ret) {
+			dev_err(dev, "Error to get property\n");
+			return;
+		}
+		*(dwc->incrx_type + 1) = vals[0];
+		if (ntype > 1) {
+			*dwc->incrx_type = 1;
+			for (i = 1; i < ntype; i++) {
+				if (vals[i] > *(dwc->incrx_type + 1))
+					*(dwc->incrx_type + 1) = vals[i];
+			}
+		} else
+			*dwc->incrx_type = 0;
+
+		/* Enable Undefined Length INCR Burst and Enable INCRx Burst */
+		cfg &= ~DWC3_GSBUSCFG0_INCRBRST_MASK;
+		if (*dwc->incrx_type)
+			cfg |= DWC3_GSBUSCFG0_INCRBRSTENA;
+		switch (*(dwc->incrx_type + 1)) {
+		case 256:
+			cfg |= DWC3_GSBUSCFG0_INCR256BRSTENA;
+			break;
+		case 128:
+			cfg |= DWC3_GSBUSCFG0_INCR128BRSTENA;
+			break;
+		case 64:
+			cfg |= DWC3_GSBUSCFG0_INCR64BRSTENA;
+			break;
+		case 32:
+			cfg |= DWC3_GSBUSCFG0_INCR32BRSTENA;
+			break;
+		case 16:
+			cfg |= DWC3_GSBUSCFG0_INCR16BRSTENA;
+			break;
+		case 8:
+			cfg |= DWC3_GSBUSCFG0_INCR8BRSTENA;
+			break;
+		case 4:
+			cfg |= DWC3_GSBUSCFG0_INCR4BRSTENA;
+			break;
+		case 1:
+			break;
+		default:
+			dev_err(dev, "Invalid property\n");
+			break;
+		}
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -803,6 +884,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc);
 
+	dwc3_set_soc_bus_cfg(dwc);
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 8f97f61..565d7ec 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -806,6 +806,7 @@ struct dwc3_scratchpad_array {
  * @regs: base address for our registers
  * @regs_size: address space size
  * @fladj: frame length adjustment
+ * @incrx_type: INCR burst type adjustment
  * @irq_gadget: peripheral controller's IRQ number
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
@@ -939,6 +940,12 @@ struct dwc3 {
 	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
+	/*
+	 * For INCR burst type.
+	 * First field: for undefined length INCR burst type enable.
+	 * Second field: for INCRx burst type enable
+	 */
+	u32			incrx_type[2];
 	u32			irq_gadget;
 	u32			nr_scratch;
 	u32			u1u2;
-- 
1.7.1
