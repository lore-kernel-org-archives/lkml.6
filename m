Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1346284-1521812687-2-14258316348526116579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812686; b=jluCLAi85BBk+/6mV51KZD8VG3aGobDh+5v6XONgnagTN8Z
    d5QryiOZbV9QZSxIITKqg2ZEtD8brjdwPVtrNG/irNqgDAw6Ww1nCoU8JcRZTX8i
    IG6O5XqZa/HUmJUavlU3+omI1DN9+JkgNCeBsELoizJj2zMYZ95N1cKtkJTLLXX9
    67ocHr+9oN4BG5uttu6UQwJeNtMFiRJmkN7LJ8fX+eACmi2Yzbg5PiCp2zjLcFAw
    US4EoR3VxntRO9+6tq2wRu6o6TYa1lhoJALxNgmQd905miz43f+mT0md5wXIA8mO
    pavaKy6weSmU36Oq0axPc6U+AWy98iLC5JH0OEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812686; bh=g
    xyeEH3SP7KZjXMnMuu94NVHPLAAR27xciAcVrBJbvE=; b=WTeRHS0MLQgr0KaNV
    /eqH3Q6hfxdF33AVzca6Z0feiTTdC+/Wre5cgUo15QSv1tsY8m7SvC0zejWbcWd4
    0Q2Yy0wXn1koIbg02dzBkYtxAG+Lb8AGxejt0PQ6gqptpHOiaBnCS4Lyv31SKnhR
    48BAlWb90ZvDS7tmBDywoWoFdvQ7jkoiSX7KZLdXCw4FBsXtjZD+FreMeoeZ/Vx/
    ATP2X1Xq/j6zXdrKXnIdlX3Nw3Yod8+teVEasaYR7hSQiS8mewd4aysncIkWMSR6
    75WLy7o4udjCJ/TLTo91HAEkFeOgYdQLR49JaBzKgE0m/qNeY2v8BJnXeKf6JLE7
    bT0Gg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=yRblaVph x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=yRblaVph x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 5/9] staging: fsl-dpaa2/eth: Add DPNI version check
Date: Fri, 23 Mar 2018 08:44:09 -0500
Message-Id: <20180323134413.1532-6-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13e1c1e3-eae6-4cba-cae7-08d590c43610
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:cGEAHGnQ3UpbF7si8GoCfDTCvlWaVmG0oNCYdBoWmsmhYPVTDGDpXuU2WzjWrfK//HHboZkmi3VHwzDMkUSj76n+fYMdLDYvk254bEy4jJrGffC8gFwJKxRdvGAQHicq8ZBB4V0m8ul57gUXEuvHLgSBjlY+Wmi6noHIidXySLMadLmcq9X0VcTJhyFc3azKJy8sLy6GeJXuxhzVGmVNBBn9eSelVs0g3guGgDxtt6xzGSHmFtMyFF4mkqSV30pq;
 25:iKR6tBjE8aiPSeqBpvTGTl41Ey4tuNmz23oa1LHi8xMnWll+DPMZVaU6jEWgy2mjkTGlbTJ1SK7dwmtjXb0R300jfh594CRYaOZkJx/rb7QWzID2A6K1juPa42JRTCol8nwxAYuxGh/5a6gSgVLFlSLt6RyDEtsxdknJyfJvQWYy+51cNmQ6+QxOIqprqxNTkr1T1a3G8e+CBnEupPRB6O3ZfCraal1a15Bp4haTte0p1nlVSDznC4ESNmmYc53CPKBRwIDBVI/861vsczSEGQqkq8YHt6vUEXYTLG306d+OQmzwbNjvTGjHEZKZ6x11F812FC/UMFJi1aPzHMQVPA==;
 31:DPqQW0zz1ZHFCsyYUN/9LkgR9V6D6QHMltdP6UA4hoJemMxJI7/aizyMBXcI1YNbQ44ljQlPMtUwMCazKEy6KpAYzr2O7cARlZ789sTxv4Es85xW6R1bE4XgoqT+MNjvIMpiRA6nNh5MKxLd3GzrASrGzwN8HhcjvABj9/tLf/uZSLRdCwtsnm9Fu4iRxLAwgjWN1p65WGG+YIC+o9f52vbfM6R1bEme6MUprerC6u4=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:ryXIpU0guEy1x9TJWUXkWUH0GQ18LYoF/mR9e0RAxPhIfKgZ38bdmr/cZj3BfN2EsrOaw9P1xLDwhWwMb95GCqyZ+5mpKTf3wUV6f6QdfxsLYhmAN1H8wdkDO7Suku500nwA7/26Rukg5YE4pSr/J/ETd5LUC/b/mXUF9LN+k5J84OlxlmhGOFkmGfqm9v4lFjH+5iSL1xdQNL7C5XQJqk3Oe5TjTaOq6BF4CVI5qjHfAdhzCwm/GtfHh96vSnv5xvne7mSt6cJPrNEZnNjEOKDu/n4XT7/XQWwE+ikvw181uDsf4WdsS2J2pb1EeEQ4fbC5eNc/LoLm6R2/4HenBI+d1EYy9JkqNyKkx5omGAVF7WGngv4y7gCK8/6wuONzRMWCDkJBTs7mr4LIayqR8ehV6nWaHob6NSXCxtqM69a2B61d9QM6myipBrjMTCktcTn668yVbw9HHHpTbXKS6MxPXSmIAwDVaCsskR3cHGZf33O5K3T1akHzMM2sLmZy;
 4:iwUm6ctZQeWVtnFuQr1WvwdHHi513gsgttdAWMdcr4JX0hZVYDYTV3q3Q4mMLTxflZnX1fsEPZYC8ckIjRcx4BCCymgD9CGTalFW+Q4UM8yBqEtwzzxdcSJrTiccYrgJhoWwYqAPKOMnujntJDkIoJ0AUFFF/dgQirg3hEZlCEbYY/N2x7Hjz+YUqPYUods+CIQIsOZ6bEphSOdEb/2U2gQ+bZSUgT15xDYoNMxk4KAiXaL2tdQDp5gug49f/x76vc34wGF7f9LEHXu+GEjnO8DyndE59yOtrnVLq2Om5mF7vx5gGg8ozEljIfQg6Bw4
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2690D8EF4C91F146E8BABA7B94A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
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
 23:b2QrrU85lt/FBHxFc5W7WuYNtMZIYO8VDnWIvrq?=
 =?us-ascii?Q?wYYjmbUfV9B2z2I9WR/7XbiwZIgsiJNLKjpvBaTVZiX3pFdBL7D+myrFRCEW?=
 =?us-ascii?Q?wjF2mZv36uPvbZ4ht0wHT9umOEZIBSPOpEIm4/0ZNhSZFV3QW9nmZUu8p7O2?=
 =?us-ascii?Q?XG+nQgiXzhoQKrTUyXDSKKxelUR3aN15biILTF5o+HO5I9lAkFBEqOLnW3Vk?=
 =?us-ascii?Q?K+HfdAkNK9FkhfcNsJ+zxAMkGWnnmyDEQENkneWqjEzrmlkTUNDLQUWl2Im0?=
 =?us-ascii?Q?eHRcBuJ+HBYrY+D2zp7rWykaa9mInYWgGkYJfOxenvkSl1AQ1BRLlcGptQVl?=
 =?us-ascii?Q?hxmtef9tMfGnbjnnGA9cxQeS/FAVHLfMo+n8IYq4JAUDdBGHhkYn2wo2chGO?=
 =?us-ascii?Q?SDjPdkaFIgbI0EusqUeW0MvJYLLgIZUZJrwm0HUbfk4JlTSI1RI6ts4t+rIw?=
 =?us-ascii?Q?5GXyrd0lLxHkMDZgBbWlL71RfOgVOGtx4LA5Xdc703dUbwBgM/VN1eLpxVTe?=
 =?us-ascii?Q?kw553kL8uXNCXYw4QbWl70Aa3iUrB/qZRmmPyUWYaPqZPXFGdQIkvAvjNl31?=
 =?us-ascii?Q?+I6QfzfaAyIyrXCTG7E+/zwAQ01jt5VyY/qZ5KobFlBhYYRSkkcwUdBx/VcR?=
 =?us-ascii?Q?KL+B2UL7jBa7ktMU/5DObsb3TKdu8z4OmgMDcGtbXz6NsVkgJ77ykrxlIQTI?=
 =?us-ascii?Q?GgDhrD8Evt4g4I0aV5R/7zhDsQiL96GpynlfceKUOgumSTc7R7gs4rhYaptK?=
 =?us-ascii?Q?izeqcu7PknGG2VULd+uXxDWnmlvJm67k1jekIrM4bp+0RBRvfC8RnwrIXFcZ?=
 =?us-ascii?Q?TWdImPr76Lsc+X+DMmQ0XDNpGNfPbcP8KneFsd2ZcPsZzZ9iaW3FIoEdRdTG?=
 =?us-ascii?Q?839BVDIEPuwu7dH8dHJ7KfQaG2qMFUWmvVHDV27vmFqCfll4uHb0e2aoTNLl?=
 =?us-ascii?Q?d37XHIOj2kb5va80C8F7N6seoUMxqrAiWA/M5Z/zm410J0Bk4/bX0LEc26Gj?=
 =?us-ascii?Q?GXWSclY1miEGRkUIW4GykyzZ3F25WP7DtQ22lCkJqpguQiJesw9scEc/8WYn?=
 =?us-ascii?Q?/l8s7k6a5BYazbWDB0F/QHZbaqQfwtQVvmvFpUs0G05v6OFUflwza+W7UfAr?=
 =?us-ascii?Q?GlHcuyyJL380zP4TSMuXkBeFqd0gzB+QlV/6r8OK4bg6S/yD+Levhq8hx3YJ?=
 =?us-ascii?Q?3Y5uGMOzJDtf0h3I=3D?=
X-Microsoft-Antispam-Message-Info: H6qXzS8ihHlVSWa47lRspR3yxLkoRCMJ6n3ouG2AWRXfAVUeAnLRoSqjjrxKZkAw7Y29nsxUmCQbXZ7chbAF0n/klnAsqh44tvdcALSHvf8sXGUQxo5IIHrzBQhM7T6hVMm+QW2DcUzT6y8wdreNQjq5+ZcXZacs/JELPXbBV23JrHRkQ9hxnyqsnS1qgRHG
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:2MzhP2JAi2jcH19b0Onn8O9L6LwKTwXYN+SkwaGBF1XuQxp337WgiEzBr61Gw3oYsBDvi0hvDhENeFcw2q6aT96vLn20Y37Eofx9pWas8QdFf6Xb5DfFCCOINJ5l4de13eoq/NjVQGGC+0+lc/aPSsAMY03yEUYJAZii76VhvFSK+MsN5N2AKuSH0YYompw1A/PAejfZEttzm5iOFqNhCiXjJsrQ0QnIByVUy2pmkrhCaKcaxzs4fcwe5G15o/LvdcQFH73oj+7Q/5ab5FGInM3lfhZzDbuWwD/zST0igGZKEkC4s5WGkHjaSg91WwA2LCcxLZ/0QD9vqOcRn2KRv6l+29y6J5tru9LQ1bwDnoJY11HrlEoEeUkCBFgDx4TYHN7Z5L8R3ABtOvDDO1dZ/Ms2hHgxkfIct2QCWjByDDLgnnJf2pX0Q/tIMofarWOxO2T3eoM26KDOtPcxw8zSEA==;
 5:o6xOqA+SILDJBhakoW8fyml+sjonW5GzzG/QNvnIcNUPe1zWLZWj1gIfBO2E5hD/UNB4T4YJK1j3CFxCvfqFVEdzbMTpVIIlya73pPeeRFSa1qeWsbCKxfEsG20okBKyzXBQ41ScQBBGQiZvtleePFEZSZ9sotWPpdlLM+u1j1Q=;
 24:9qazbRFQPuBPVChl/kn84XBKy4Fe0k2UkjeCiqu44iwZvTBbA+WJGyzYNQvrs5FKOd5URS5oyktg4o+AYaW/ExIbxJq3q6Y0ZLMVBq0xA4Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:DQivQQNYDlBAV8cpeKPXieYWBX1YSMt3Uk7hWy3OTGL9xrTSL44kYUAvLIEntJzBKfTJFQZAZUtJ7dlmNhKtC7tqugfb/unsIhFT8o8io+itxuNpThZxIrJMDwdJop32NtANlvXgx0sOBWWFTYkOgQRNrD01jg0jr+bWXqKDKeE3ePFR+DYicvntiDBw09+Qynx/5CPmWFTgaoOA295K1gaoAgewPb5lMrViY5zdfoJ1mlxmxiFxFi3fcvBZG8Un
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:32.8565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e1c1e3-eae6-4cba-cae7-08d590c43610
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

The DPAA2 Ethernet driver assumes the DPNI objects that it
uses to build network interfaces have a minimum supported
API version, but until now it did nothing to enforce this
requirement.

Add a check at probe time to make sure the DPNI object is
compatible with the set of MC commands we intend to use
on it.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 15 +++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 10 ++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 11 ++---------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 9fb88f2..f58c85a 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1846,6 +1846,21 @@ static int setup_dpni(struct fsl_mc_device *ls_dev)
 		return err;
 	}
 
+	/* Check if we can work with this DPNI object */
+	err = dpni_get_api_version(priv->mc_io, 0, &priv->dpni_ver_major,
+				   &priv->dpni_ver_minor);
+	if (err) {
+		dev_err(dev, "dpni_get_api_version() failed\n");
+		goto close;
+	}
+	if (dpaa2_eth_cmp_dpni_ver(priv, DPNI_VER_MAJOR, DPNI_VER_MINOR) < 0) {
+		dev_err(dev, "DPNI version %u.%u not supported, need >= %u.%u\n",
+			priv->dpni_ver_major, priv->dpni_ver_minor,
+			DPNI_VER_MAJOR, DPNI_VER_MINOR);
+		err = -ENOTSUPP;
+		goto close;
+	}
+
 	ls_dev->mc_io = priv->mc_io;
 	ls_dev->mc_handle = priv->mc_token;
 
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index c4816e6..5ac014f 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -311,6 +311,8 @@ struct dpaa2_eth_priv {
 	struct dpaa2_eth_channel *channel[DPAA2_ETH_MAX_DPCONS];
 
 	struct dpni_attr dpni_attrs;
+	u16 dpni_ver_major;
+	u16 dpni_ver_minor;
 	u16 tx_data_offset;
 
 	struct fsl_mc_device *dpbp_dev;
@@ -354,6 +356,14 @@ struct dpaa2_eth_priv {
 extern const struct ethtool_ops dpaa2_ethtool_ops;
 extern const char dpaa2_eth_drv_version[];
 
+static inline int dpaa2_eth_cmp_dpni_ver(struct dpaa2_eth_priv *priv,
+					 u16 ver_major, u16 ver_minor)
+{
+	if (priv->dpni_ver_major == ver_major)
+		return priv->dpni_ver_minor - ver_minor;
+	return priv->dpni_ver_major - ver_major;
+}
+
 /* Hardware only sees DPAA2_ETH_RX_BUF_SIZE, but the skb built around
  * the buffer also needs space for its shared info struct, and we need
  * to allocate enough to accommodate hardware alignment restrictions
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index 070a3f2..dfbfa94 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -78,20 +78,13 @@ static void dpaa2_eth_get_drvinfo(struct net_device *net_dev,
 				  struct ethtool_drvinfo *drvinfo)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
-	u16 fw_major, fw_minor;
-	int err;
 
 	strlcpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
 	strlcpy(drvinfo->version, dpaa2_eth_drv_version,
 		sizeof(drvinfo->version));
 
-	err =  dpni_get_api_version(priv->mc_io, 0, &fw_major, &fw_minor);
-	if (!err)
-		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-			 "%u.%u", fw_major, fw_minor);
-	else
-		strlcpy(drvinfo->fw_version, "N/A",
-			sizeof(drvinfo->fw_version));
+	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+		 "%u.%u", priv->dpni_ver_major, priv->dpni_ver_minor);
 
 	strlcpy(drvinfo->bus_info, dev_name(net_dev->dev.parent->parent),
 		sizeof(drvinfo->bus_info));
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
