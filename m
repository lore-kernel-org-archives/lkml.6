Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1378361-1521812680-2-4351124514016390824
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521812679; b=R06CPouH8yMKcs8eLFOIhabMyqPG09aBHKv096x8EDf3e8a
    TUjMvTkRzUM3B6oaFHjcE6iHlE8bf9AYqaAjn4qdgMCRyPxuK+WvO+LUvvJEmk1N
    VmlOLRgw0gptryquwFKVN18g5r+NjPrP++iU99yrIMYLfArLMuczJt7yeH4OMEEq
    GHFng9jJCpKtXX7Fjog1lNG/QGxfs9edVS6mI7bk1Ya2Q4PsxFLG27mFKx/vEN9S
    zdkNdDi79PkAvHxu1WGV07djaKUyfozq6FZEhjYXHDP1thLxbmB4zNMF1guGgBP/
    4jZ2HlXuHKZb0hkxMPw6udTdcO3jJb3kWyXhY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521812679; bh=1
    O5dl3YlGPEjmwVq6iMFB9Mi2RbpHG8yyS7SbsvOizU=; b=bqAqIRlfNLvig5Ywk
    ZdGUA+43xlI+Wcy95OianetmZ67S20RuUHY65H56zbFNT+B2ysLOe09unoeirY/j
    gRc6Jm+nLxuLV8/kF/YzwCKzVbUFNdB0VP7jZ5Fm4LhvApJLPsxAzsZJsQvi6vvK
    wy4dIQ5e77aj2EJqVHafmWIi+gaD8SOzMziqhOaP1j4/TspYxViPzLYCYurcaWyj
    vYKvnJ9bP/9YXoR9Pm88RsGmoWUJY2Npj7v2ZA2DNZySc0EUrpA6KLN3/67QTkUJ
    1TwCCUFBouWoddn6/DW2xfao60XB0PKWXIxB6INlgQ5Ig5SmM9gnE6St1kJs7xtT
    pS83w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=F4h/Gexw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=F4h/Gexw x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH 3/9] staging: fsl-dpaa2/eth: Remove unused field
Date: Fri, 23 Mar 2018 08:44:07 -0500
Message-Id: <20180323134413.1532-4-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 99a7c10a-c2eb-445d-a443-08d590c43465
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR0402MB2690;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 3:2D1OIzP+GWmolt8gMfJ1SUknRHLpoIkyUGzTBmMvy+0hmNJt5Jm/cQsoqMCiu/+od9QyM+6SpkXsnwzZq5qsDbQBI1DhFZdqHRTQp+UKTT5+tQMFbJFAF9shlMHU568aJHcLU95rN+ft4m9brdKV3DL5+EGwoZ41ZpF3Su7ooq+8W+vsd0jv1UFH2dGSdcS7K+APxyYmQhu29JgsAPZ1NfznQrpz03Ud9S3wDZ3XJW2H7mKs1gynfisNLxe9Gu9z;
 25:5GHRlWtYVw5G2u3M2RnG69u0NoQlf7JHPqd3ulFCbpZSLNqfa39fCDz7bZcO3XlAVZzA+3CPZT3EgnY489IhLWXBfM1DpY0RBzHls3j58M8Gr3HaeMQGRXkzfr7AjrlzwbDOKhIux2kCcnr5GTh8lKKSXj4AePO+dKULpxFLzvP3lpfKPUcdjq4WiIy9giUKPWvasy4yItAtGHntjCXV7LBmNsa/xi16ppHjhi479niNZA1fVfKbhPM1N971YjKK3gRKZ/sKYnOiv6xNmi8ErDL9QBIP//mEtAOFfml2W9cOpixC59KP+3zbfIWkzvhvgNnxDcwpayEhqIq4Yj5KMQ==;
 31:mtL+NNZ9JnG5kpFR6mAAZ+sVVEkutyfIiHHfthtz4bV/bMyzrnR+7l/gp0nRpd1Ze2J3HWKZxNugto7EpddfrJ8tyqfceB3kXxFaOCzUgD/AFkBzQRJZRNKF8UuRZrQzUF/3OMZRyh9O9mqLhYZ26fD1MNYjEMmCmhuOpxexM6dBxu1ZibcIuMKVxe9m0d+gm13kmS6ZpQL11D6lNRCl7Eyee5wUwK/wObeifI0YbFc=
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2690:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 20:/UWNSdDuAC6dPm70cPjiPZ5v11Q2Y5PtvfSls41/3swoMmO0H541HvxjGXuud7crkbP4YYk34a+5CKK21gY8Ro/4rlDDwg3oy0vD9k7VSpjwPCnc9WFsjJVXd9j8OuLKOEPZUY+2dEfu6gkdM1W+ExLN5tLK+4i6Jq6Z8EuYEhYjn7RjklQQnpAj1WS0NehFNkPGXSMAdV63GqFB/RdTKldIo2zXRTETxmloJ+R9l0P7fc37u4C2LxebvKbuEHRf3Isq3JqFE0Kor3ZTvq+GbAQc3T8ytFJGwwCVZZdt+tJp1Xh5MLqv3DOrDANzTXrxHQogUo2Y6q/hTLK8ZYiWF0dOaDFvEUi91zfLNPSwCmv3Qa8KbudS8zLIil70Kc5ZF2JaxDZUprPR6T+J+WG89iMQV9Xtp3osYVW5VenFTsEUMBzXeeggLZxGFI/E0L7M0JBT49nI2KXumDRP7kpzEXnM76e9WaNfY5/I0LTRPUA/OlMTpUmLOjhphymfemDA;
 4:S/+nxHHeU2Sjq5tY3Hg/B87GIUVfIN1g2FX9kEObpht0FSlCys4lRskik/KzJnILxgYAiC3KEJND6kP7V4gQ2D23/m0nhE3carCM27oBE6kLbvHy7jaRVLsMjOoxpf6xWlxOoSz8/wMSUwYAHkZ+90zzCKHUjxTVhlDSnFXeVMbQkGHwKpdrmuFFSNTYrgt+EcNvD6sDCiQAOekxNAdG3PCRZMdybJ2p0MlNztRWsKjiD8IW+e/qBNEeHLps9xpu90xP4QqJD2x0SZ2YA3W8r4lEhgLZ1pbWlnBfvCLRLAmCZSNtf4w0wMOLiJ1KRdoH
X-Microsoft-Antispam-PRVS: <AM5PR0402MB2690499A844F4C521128AE0194A80@AM5PR0402MB2690.eurprd04.prod.outlook.com>
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
 23:6qArpG7CDu9WmmpKyk3gHdPOJx97npOXkmKDOi5?=
 =?us-ascii?Q?tSFTt6mSQpgBcKZrBhnhOoOSK49pU7U4e6edMtvjsuSeT1dZ4Ht9Jg6PaDZ3?=
 =?us-ascii?Q?pNm4Cc/BniVkP6E9odqR7kdogd/DtJnJfBfPAcVcRfhkebQfbcjkQYLWPdiJ?=
 =?us-ascii?Q?mt4JATbqPV6TMZO9dOdd8e2371c0J5IpdRYQZlIwkfHtPBvwMCBEbozmnquw?=
 =?us-ascii?Q?lubEROLI6f0zvYD7aeyBEIpPCIZG312+OT8e7mnQKB4M8WCUJmMpP5pLcgSb?=
 =?us-ascii?Q?xgxMEtiVLIB8pQ4enGOoFd3FDmPEhRIHp71zSGSCJQWeMioAso6xUe7iXqb8?=
 =?us-ascii?Q?gCRbtdIhUzXHJ8BqkLl1W2Esnzp3bswKE4XZMBHcZUL6ljE822lNq8jvJxl6?=
 =?us-ascii?Q?dYOZUI7dBcmL+jNx71C2pRd+ZYZcMBdMuOucI7SHGTu4Tw91Plo6SGtw41p3?=
 =?us-ascii?Q?GrJBx4JwoAlntkQc+37jwOROVoeDmyvnl7nQakJ+Mrr8AnTwU1KS+2SAfJfo?=
 =?us-ascii?Q?JcB8AkCmlJnKXTRP1nySIkbBVcCJlFyDlpKyjzWMg8XA8+a3PJQyC7uhbxF0?=
 =?us-ascii?Q?1Y6A3YcP64cN2YiOw2V4VX4umO2GiqTgwIqjskzXQdrp1Sq7DMvxEeYVMogm?=
 =?us-ascii?Q?m/iqW8gpUgmc+f8jpNtnjfgxnmi2w2+y2VUn50Cgi/YpFY/rehJXRSKgdHdW?=
 =?us-ascii?Q?RliTbtjI0EuShCvH5n9N0TI4CuKQDIRAIgUdqKak0mcRWBS42mfHq66Nh6+r?=
 =?us-ascii?Q?qBUY2dJKouPbVQGOdWOQTti7ovoiVLFIw0JQEiaEaxyhDFjWPmjDPQzbn625?=
 =?us-ascii?Q?uPSGTwNK1ppBAQ67mIGksBWGOS73RMDKDffVgmNa8JXd8ZegVfcPKRpFL8pF?=
 =?us-ascii?Q?nmGnLlfvZh7CnIDL5/wc6hIGiXXgXxNl6RdJOs5pV+8g9YRYokNleAABxCsu?=
 =?us-ascii?Q?SaJei53o5BeHlkPTgGMeEjMwnHthJAqD2G70VG49ZZ5yEQVNxfWv4itJLuTN?=
 =?us-ascii?Q?RNSDHz6Q0hOlZBJ3BQFcBiHWyRiPASgJx/1DpN6jH3vziPLlFMW2ylYbGAAG?=
 =?us-ascii?Q?T/SNgFY4FP6ZDSn08if5ErQrq9tWpk0nBF50h0zX/5JJstjH25a/+Svs4N6v?=
 =?us-ascii?Q?UORhx0JYWX2TlaNlUEtEDtvNv5pt6RDJPzSbxvk/OOgkS5XC1cJtpk5pevqz?=
 =?us-ascii?Q?C/4kKR9pVeN1ECcI=3D?=
X-Microsoft-Antispam-Message-Info: XWJY5ANrfFf8GogKhkktXMM19O3dFnV+n7l8SZ6wTlgg4ChY8AU9EzkBpbTIisvSgo2QRrp728wVNP7yF2qituEez68qp9q/ZxJu1r94UT8KGFSPvsZO4yEGjjcgxQlS+QUj+KqlEafTMFtqtx9YyTzA+eeNVB7pXxHAVpoeGKyz0QciwCIfX/ixINIu/onK
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 6:viP8/oRKa13ktnD2vxz4yf+I7RvNssTVRjV7chDf2UrTwhTlZbekknwbNUmydTl480CYYxglvMopUTAqPThg3uxBXaHMeUWo12dcQYGUGlXpjyc8ApP3LrH5937SGMf6OIXozxWAEgRrS3RdE9K9fLKq2MpAip66VDIVw+0VqfSxOKfdIkVkrx97mPFmkn3GoBRUe6NDNrHBU8jWxs1dHk0tPKYmXwFEuqtfgmEOw+oZZaNekDGXDfqGuZ5jY/w/ZvO9fVt1SklUl51LPG7JufNmYSXVrt8PM/4RJOS2jfVRjfiRIIgpAzrtzkB6hlQTalKJc5YTVKksADHTJ3krIzOU2xcM0PwXXgO5BncLzVXzXPz5D7wKEstYm/r67xa9RaX4TrUev5LbavWQe4J40WebJ8dX66VY/iXL5+eFuqW7/SHZZRs0f9XA6Y20EMiF3oF5FO9KOU1fEK5GoWeD9Q==;
 5:SA8pBy3Y6hLidUR9A3PuCKkytf7Pql/Q+WKQe7AQJwj/5vKH3D/5dSolEhcN8e5Jbt0+10wp+MQUyKjOi391ENV7K6y5gYWZojki91kZjVbeUr7cvIGI46JeSBVvAaoReiQAe5OqrjVyGjbLpPmwNFG0zh6bektzouQrOVU4q8M=;
 24:vygaB1076AgYVsf7YmJuCoErwMMTzEQ4xKfkw78w02woRFkt7cGQSxHWv6NodmgXYC1u4zZBGtmyV9cxLZGLXAtcFLni1BtdcUpwKvIhDT8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR0402MB2690;
 7:+Y7zWh2L36/t+LRhZAPBwezknzAB+TY4q7BaqJvOTAIRai2NhVVf3HcSO/j8Zd4iFmb4D1sesO1kQwZJ+WmSDuBFhuPa6XWzvBqHcru5SE6MtRDdUc7aHNFTjlaPQDHm9RjKzm5YBINjDUqiE+fam3PBDtWSscMoQD6+PT4LScQgvfvzfFwjYOfgcBhvkXGWIitf4K5Ao7Gjvw6NaFNoSrGKcUHDHQTbljnKSWG/9tCvmFSsF/hg6UyCQhVro9f7
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 13:44:30.0551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a7c10a-c2eb-445d-a443-08d590c43465
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

Remove dpio_id field in struct dpaa2_eth_channel, which wasn't
used anywhere in the code.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index b8990cf..63ea64b 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -285,7 +285,6 @@ struct dpaa2_eth_channel {
 	struct fsl_mc_device *dpcon;
 	int dpcon_id;
 	int ch_id;
-	int dpio_id;
 	struct napi_struct napi;
 	struct dpaa2_io *dpio;
 	struct dpaa2_io_store *store;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
