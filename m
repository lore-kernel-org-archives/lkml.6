Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1346284-1521812689-2-5301259705708409716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812689; b=n2v61Uszym+3Hn4ki8mb5u0Ei9AKAays0laqbLUifAIu3ol
    qa/VksSsMxgMALX5WpQxPbIxHjOq0OYL1/naoaXi7dpPnkFsF9ikNm3eE6T9mJ95
    H7dZrGsjMDWowkaSHHwWrIv2PRsi+9/y3HmU4DwAWm6n+bfKOSlLi8yDdnf7u+mt
    QGdGA0IojtfQnKSbKBctxpjnUOYmKfMzkI4ESZQlx6LcMV6TGcBCHovPlxL4fgLX
    O4CUVzV84oEP7lyU7pJkLXrBoj8vdQapqPSMKPT4IJRx+7ADEOhRX0cVt40Sv8NN
    iz5l/TQtMeBIf/0nlWQ01oK6RgINMegmDYKGCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812689; bh=w
    0Si9ajhpOHRwAMD7O+eVsDvh3dh7VkaCT/2hsJ5BSU=; b=DTXv+/xqltJn4TX0e
    es8u/4EybPAl7YHgZmSYPBXmU2wVFi4p1rkCq4m5Cc5+KH6jtwAaCkXTJB0rKFCH
    y851Z4qk+vOKqZG+HU0c8Ecw/nzCal9SRk/vlB76WnCsJNtFTAKXvvmJYp4W0aIA
    8zQHqK5yIw0MqwCPRAEj8F7Ruwu1JoaD2MPnNUh/yp+dNYjipoFAZR0miO4+fzpM
    aOogV2Ua5VphRDuVEWn+MrtY6Oh5Js2Z2Epefl1F16BQhf8muVan3sZK87imSApL
    rgn2hu9Fpga1cJM+5c+vuWdXhs/ksTnKKtSQoWGfw/00ShBQot8Y9JDRQOX2SDkU
    U9/Fw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=G/amd9E1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=G/amd9E1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 6/9] staging: fsl-dpaa2/eth: Change link settings on the fly
Date: Fri, 23 Mar 2018 08:44:10 -0500
Message-Id: <20180323134413.1532-7-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
References: <20180323134413.1532-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: BN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:405:39::27) To AM5PR0402MB2690.eurprd04.prod.outlook.com
 (2603:10a6:203:97::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fd8bcd1-a1ef-43ae-faf7-08d590c436d1
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:IOyhY7a/xWEKWjdALGYUp5ahB3njOL5/XTGkvb7DJv28o/nJuQkihdpfDnKGDQVg3xrwoThqP3/xPdB0KDl7YbQj6SpGKgpt4AKgL5EZxegOK6Wb54K58c7PsAcHQED2Agw629a5cXIJdbgrQTG6fzn2jk8USotUJIKy2FFYVt14DHz6u6SQiQqR57pP6cDRkkWs3AAeNd2EKVYvD7kW+S07FrUhvUILgdBZilG2T9t/0QwGB0mdE1mGchFNknHP;
 25:4e2GFadYh3JwJy5MC88GjlK4L0XsrIKytOp3bEnw+gJ4SyKn7f9K5cqE5sw0bLP0DRLPvx6iZfSYRMS2HLBNAgpgii9ebUYbjXQrEBtqMcl3F7Pi+72aNSuHmPnpX6+kYWnqkeTCX6RrQC/C9Bkg1+P1+vibwo9LI0NMHffMtjndfA0zWNJdy8eflm+0gUcKgqmdW/s/uQqWn5YntWRPE9vcAcqjBcfHDi+W4h7FYEbXxBGrXAurGF3Key8mvOxYjqJS4tU+rJknEDSdLzhJ6che+ThuPVOy+JZGfyzWj1fMoI1Lji5/F7g5tnsKhILPRyM82yckS1pgToT4aSjWnA==;
 31:jwIpJWhjDTTfe4zm5cl0FowsRePnANDuutbU+7A2ha+mV9KnzxQQriGiuRsTri19AVJlX1I+Wn4YjLv/P6dzUTorEeOxPd4BVeJDl/vUu76OQlcYeVSPq4aimuxVXwJQ+1Ipv2RQ0v7JJ34GeIGWX2UASJmhNghpDzbod6bxEYwgZMnG4ABcUrmRHC61bNFCexYEkqdxuhGSEAMFeCtIUoOuRXojrlXkF85ThGj6s1Y=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:flDZRaL9xuKREIbYF9wczsHXVZlEOGCNxwSewy8pgdbnQ5ZOpvl9eC409+2kjH3IvHAYKyNo+KTttGJiG6jB0m53Sc2giP3pi6Iw4pivbsT8NarY1yrC0UXgIxRJ5b22zVMUFBpF6HN+hmvXB6KSiNhK75XVknp01iHiLgmsUNqFPpknBWmz71l6kI6q+WJvyOlqt/MisC3Ssr0dNbu3YBe/g/5SAXxs/N/ZZcGHnTk/8Y/eroTVEp847ot89D5gViZ3Es4EDhXh2n4Zr2Zemn+hGog5GMQdMnLWXQ4LtVzKUQ0IsDhgkR4Uqew+2HRij6uhPvtaXyR9p/XBdQ3d1PjoCRV8/8yfGjj5xXMtM+jFOJfGH3GCGvUlj5wbyEJrzswzepqktNw3CHkpN9b346SjsU0W6Mi9wFD6a+WeyUgwq/+bz3KwXm9ewtpmHKjAPxD3TVy6ipF6qFjhWMyvHzvGRd7RRiA2NGpza6xND5GaAlC9WV2pp1v25A1EW4Ts;
 4:oMM2IISzun5TcmigNKKQNo21V4VGa8/HeitWR5JOAXMtpNtw9uqbDyyyzTcDmmTYnjOINVKVwUfkxcoilK4msqdpv2i9eCILmwL6VWdZH64LYzBpgvVp8tM5bv6gPHPfCM8M5xOy0n/mxp0HN51gpmwpXZlfceVh+7HBgLyjlfjNvH+4zcuCY+hrxLRDIodCfALCUWcMDxrbulSBLDdR5H1vOVpzzjObVs457+0sReMmsfC3p/eer9wJy2FuKOGE9JoZi1HIUcwvOmEQ/IjqCoO/yvoMGWZxgCp4N06TRSOgJxQcjlbxy8I1BdzQ2PR4
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2690740DA669F7AC35194B9294A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM5PR0402MB2690; BCL:0; PCL:0; RULEID:; SRVR:AM5PR0402MB2690;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(376002)(346002)(366004)(39380400002)(39860400002)(199004)(189003)(50466002)(25786009)(6512007)(6916009)(59450400001)(6666003)(7736002)(305945005)(5660300001)(386003)(6506007)(81156014)(6116002)(3846002)(8676002)(16526019)(51416003)(50226002)(1076002)(446003)(2906002)(36756003)(81166006)(76176011)(186003)(66066001)(86362001)(8936002)(52116002)(4326008)(316002)(53936002)(68736007)(47776003)(26005)(48376002)(2361001)(478600001)(6486002)(105586002)(2351001)(106356001)(97736004)(16586007)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR0402MB2690; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR0402MB2690;
 23:kNmoho5ElCIZf5aqlNEUf8SJnnbqXaddoElCwae?=
 =?us-ascii?Q?IWu7yM9U2Z0uXnv1/uEqnwd3GBZMu3pCPMwFdL8RShKq/y4faPwdjsJFNNlR?=
 =?us-ascii?Q?wVUUNOLlSll2RERb1V74vPbKPAMkEAfbZLu9MzBmoqmInT4ZnfMvwpYf6Evi?=
 =?us-ascii?Q?aViAFXMsnsKDZ/Ga7JxkYCJAmQBmoO17lT03JLuNWsaqODN0jE1MjPkEuWjd?=
 =?us-ascii?Q?OgGShNjYc3RaApW5c4hB9xWDuDY6OboB/XQVKWjXXgcaaJHnZNO7cpgg7Auw?=
 =?us-ascii?Q?5/rcEXwjfmuRCfqhHD+XD0tGStAI+VLIY1fogDIAktFjUu+zHK3gH7hprbgY?=
 =?us-ascii?Q?bo46bCD7nLwgELoHjUSJrpg3FUfDrY3NGbp5pNKR6eZAzXx9dsHcP7IqFmc1?=
 =?us-ascii?Q?5rbydERDQDr46MCRLg3TRSP12hqBWrDEXBzXpoagOliZ13UkDBlsWJ1+eYJd?=
 =?us-ascii?Q?XrdfOO5F53Ovf7M+ksxEMJcx1Mz2DQ9hdqdjw2v//LCKdGj95ZqHkmA70FHB?=
 =?us-ascii?Q?LQSA5oo1hqT4JXmW/GGr2cF3oZvdpVvjQLU8OaCcpn80W5NOy52qY165rO3I?=
 =?us-ascii?Q?xyHvBo6O+R92/daJ6Jsc7ZhHvzEmOkryGcA6L/CCYfG+/clT2LJe2nPbkpk9?=
 =?us-ascii?Q?fXpXerIHv3qBt1CKD9qcG1Lg4Z7w3fKgMnWdmD6dBF5LkOtHQ5NCETlsZgjY?=
 =?us-ascii?Q?L/EGSS/sj9CpTHnd2XVKE/DrHfrO7Sj4NBgm0NQF6lHa7Ytd+lk7HPtt4xXb?=
 =?us-ascii?Q?YOvswbmB6pezaXKvrPIrEcPjjsTEwokhy99ocwUO8S+jRAV3/HIJR8jai2q7?=
 =?us-ascii?Q?40TXIpGUnNca8AK/Y48INRMRaHjNCtlcZbGP+N2zAtD0nZVwbYVu9DhN/l40?=
 =?us-ascii?Q?xrr+bPJhOdy7tZXjGXgpSrgl7SMWi99l40+ugXXRhCRfnN8Zs6VwjUAnjw1b?=
 =?us-ascii?Q?4Hh1amPiwppl2THgOYzpA7F81T1dhnnDzga9PBUBPMNjh9eDAyglHlbywsSu?=
 =?us-ascii?Q?LgPZ//Kw6zuySnnhhA6XqLZHnCqf6AAxtQ6ulaQn21DzAdHbxFSv8rd79P/Y?=
 =?us-ascii?Q?NvzIUY3V7rXqslFONvsCL3dWVv0yw+o1AIOQ4tQ6O9xcW5VisvjbJqMmaNcI?=
 =?us-ascii?Q?s8PwSUAb1QvlL/WFrRC/XhPGDSVY+QMVhyuqo3sqdYec6GeUXDOz5/t1Rdf3?=
 =?us-ascii?Q?UcJX3eknkeeMNjQE=3D?=
X-Microsoft-Antispam-Message-Info: pDBC+3fMJjrl5kjddXSySAHYHBBlSDHhKupBO0wU5sJ2yc/GJxEjghPOkXS95kQa8HdrA7WKaVrscx74iD2rl2GgHprDCgCHOBQOJ7s637H/0IElPWtf73K+Vll7P7HaX5XPBcUz9cxIHrMSi1cIRj0U525UfCPX2zL1o+I6c+sS4k9lpoWi27Zm4p5nLuap
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:nCPb/doiFCAYgVM/3hw3vA/wvnM6TEvkFOZ5FNw6kwBiPMyiT0TmNRW72FCdpEnaKybUB7OIrPklsBlWHVjo2sg5xBDHUps0699wEH/raGS4tlx6YLRQJW4AaZevzopAXjzk6m90ch+MfVleN5fTaGeeKNprlJTtkIkRyL8txMWwRa3If362MAGQQRpBm7+57fUhZsbuKuye7WSY14RJ7vp2w9PyHkd9FBAnqx6blftQAk6VFpDySR2nTIFZsQOxuLA2hdxuP5XVtN6lSnE0lJIqq/nvrei+nk2ocZn7zdReTDVsAGwr7ZdVqLTEJ3tNf4l+3u75gHCwHIliGDCbBlld+XhZCr92Eh69QWziZeEdWs8iggVHNtP4ALUZVxKlSVoeRAWfBAp4ZTwGGMvA0IdNMoIKKbKy+oIluGW8Zi77zZfIrWcEEyH0aIbvLBCmpg1G6NouUAJWec5nFDDmdw==;
 5:gobvEJ6QDTrmb93t768wRSbb/pronSn2I0zIylfZ8DCN9z0tF1tLRiimn6CFBkLjHEA9uT68/72ICF5MGwYUwZ4EkxBUQ8RQqRGHFfO28dM/i8Fo/6RS5JS9gSls//MlO1QJ+MT4Uw1l8y9oq7Ren2KJy0Iiy3oKwMRTUNToKbs=;
 24:sk36XI3ZxUgIoTYF0Wfek8WtOlcbemr+c5dhehAagpLkr1ynaB9EWkwRd6+GHLTG8aKkSKZbQWBrHcqp9GZn9pMcEnsuGmcVlkDqDwOnIXY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:zoMBNZGuKK590c5mNuOJJGUcQ3V60RIYoudhyZCF1ebpSvNrLhYD5yFVSHOjryuPuUGYa9Z9iOc5D3MKU0SKB5HvfQDEBm+UdbpdHa05ep7fEZbJ6yziOn3Vk1QzsZyJBV3tJc07a7gv05YrEQFJ2bIa7Dh9qhhVsK1JVevwibxUbCC9TwsHrZ6mmBeNnH2CKYGvovdg0QzdrhsQ1mIAK4oLCPpN7Vir27MmMX2LFCZVvfSWf1At/0rGU+ybGgTy
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:34.1236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd8bcd1-a1ef-43ae-faf7-08d590c436d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2690
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Newer MC versions allow us to change link settings while the
interface is up. Only check interface status if we are using
an old version.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index dfbfa94..bfc8b64 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -119,6 +119,8 @@ dpaa2_eth_get_link_ksettings(struct net_device *net_dev,
 	return err;
 }
 
+#define DPNI_DYNAMIC_LINK_SET_VER_MAJOR		7
+#define DPNI_DYNAMIC_LINK_SET_VER_MINOR		1
 static int
 dpaa2_eth_set_link_ksettings(struct net_device *net_dev,
 			     const struct ethtool_link_ksettings *link_settings)
@@ -127,15 +129,16 @@ dpaa2_eth_set_link_ksettings(struct net_device *net_dev,
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	int err = 0;
 
-	netdev_dbg(net_dev, "Setting link parameters...");
-
-	/* Due to a temporary MC limitation, the DPNI must be down
+	/* If using an older MC version, the DPNI must be down
 	 * in order to be able to change link settings. Taking steps to let
 	 * the user know that.
 	 */
-	if (netif_running(net_dev)) {
-		netdev_info(net_dev, "Sorry, interface must be brought down first.\n");
-		return -EACCES;
+	if (dpaa2_eth_cmp_dpni_ver(priv, DPNI_DYNAMIC_LINK_SET_VER_MAJOR,
+				   DPNI_DYNAMIC_LINK_SET_VER_MINOR) < 0) {
+		if (netif_running(net_dev)) {
+			netdev_info(net_dev, "Interface must be brought down first.\n");
+			return -EACCES;
+		}
 	}
 
 	cfg.rate = link_settings->base.speed;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
