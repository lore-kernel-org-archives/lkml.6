Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3507392-1519926483-2-4145193708767686266
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519926482; b=H+sJFo7mPCOfJVzj8z18khzoZmPLeXiptWSDVFODs8MAsF6
    6PdLQaJ1Zu+1G6lcxf09yNJ/PltK1oe8fI5ue+HtGmhXjGokbqM6HQQmW5GMiFf3
    2AiXTb+4kPncZ3vOR/Mk0faO/SazP9vPASj73zOclm+78NtywH81nP5Be24Q8FzA
    80uv5lvqyA1FGakyCLpUr86BSypc0daVAaIZo4rntOBSyfxBtWxyxPfTAYTSFNWG
    osAMZQ6/KyWWVd1UuWR7nIZsH8hAiJbdhKyAQgrNlPRsD7ce8AMZD2fiOIBvdePX
    FW1FCKoZewB/8y3H02iTbecF0jKNGqI8RmlFRbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519926482; bh=H
    +aHTQOrwf3jBpnXzG1isHSPWv8CUSMSctoY0eHhCl4=; b=uISkgAG49FbbUQMlG
    rn38OlclqZ1SF3l5h9vQ4zRePDCBEcz2O2/uekRr7DKHZrZrh40TdMLSJ0Uy1bCM
    FHV9TLIfADkqoDQt19BimkSnpvqthBjoh8W7M20Iyhiw+ttUoX2og4Zz1TI7M/dw
    E6doR0tq35ntH1eQz0xKYoFrrP8w9bwV1/m4xF6/uCli8F+9s7NSePXApMJ+p8x2
    faex6YDJhmZug72sQ6RnezlurjxbbQdpeFKRh1qqRsEO/0dy9ZeJec2Fb5ZFpACD
    SSXUeQjEtySsbGbtCefUqxpTkgwA3L9sa7G4XHuXg3VR1q0+zhJxsHKF/PePR+f4
    ZyQZA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=EujIakcl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=EujIakcl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH 1/3] staging: fsl-mc: Cleanup dpbp and dpcon API
Date: Thu,  1 Mar 2018 11:47:10 -0600
Message-Id: <20180301174712.2660-2-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
References: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: SN6PR0102CA0030.prod.exchangelabs.com (2603:10b6:805:1::43)
 To AM0PR0402MB3650.eurprd04.prod.outlook.com
 (2603:10a6:208:d::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97c7ae1d-26e5-435e-e7e5-08d57f9c8cf9
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3650;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 3:DtdCHA5MVPrK6gl29wU5fdu6a+ACiiopz5konbyjvXsIzpOzprEVzLCHs/7xkTmUc1arK7QcZPNj2hcpon5O+M5d/vQvc8UGFXFcK9iDcvvKNJErVvihtUDc3QwqBA1yroucnpAhiLdaEKnY8BOs1cLnhIq9n+HuV/Qp8De7VX1jglJWNUzP+Y8A3ExsoUwqSsR73XULaTDM/I6ZuSPQLTKbFbmw7b0SalKzIkQIVOYYmFTcdbrKrhmF79mubQlI;
 25:Pg2LRaVwdsXdioLdwIRYG80cUoEMPwc5EOhavBrGQHls+B3QWCv0QqLXJal39BFiZQHrEIVM5OOkLmhe6zox1Vm5CzgSpUR7vPYT12bqvtgaHPZoZsdz2PrYESgpgsQvsIQYJTX4rXZ9LaDWanX4CnPA5qfCXPdLcTPiKvD2D6/k/LnKfmNWg1tYzSdeU6iuZebSJmqbPcVi++r/MzMph7uVli5XcIxsCoS6Uxw/C7/Es8+ymmDe5oVlKfwpIYUggPUGoPjR4g1lroYUHIYfKK9kkjRhqsYYIqrsmjnD3LGaMxNq3oMH2DkOyPz4xdVLvCO+CYtT0iUAb7iFlzYxCQ==;
 31:bt0GndQGUJ+4aCG3xA5zc4xPAOoQ4Xj4Fpnr57cvsFaJA6/vP/zmuuTt6qAzLGTeXV2zdw/BHX79PsRTZjTTyJBiiJfu2bulCkzMKTb2Thx/8KcwQKCTLxpgqjsM56VgPDcpf1U17GjOvmegci4Xs41uME/UIT7lU5WdAj7ZaEIilZOQLNg/5wTPzsbTgaeoV608ZnNVK9MAVNnb5IVqDGfpVzUaPTuk1B/vDgpUuUw=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3650:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 20:k5TnID3FzxL8RZsPwCJhXNL1km2j3ynxOwz3XzojYm8hCrJWYTQY6PWTAYzHKLdm+bIDftD5vHKW5TfCgrHSco4kJJSpPneHrhiT//wst5VKOkQHN00ofB5tlHFcdEWJQFHYK23htQf0sQkQNgaOIinhk919277LioqhkBTtpQgQGujcXg5n3O2XcvrFY+84lDM19Om5EZQAF+r6vsEHCaspMYxvUnk9WBPI9ROQiB2NUqe7ps3DtquYu6+0fRO7EHTkPNxrGpJYiye+TPNUjLjjOUJjs3iIz9dD212zsKXjR39yXrUGBVgHQ5txTH3vcpoZCPOXka/6kHzNOJXfDUclx19OvD2fPuZjknjJuEGeYPJDBaIWJ4nT/fJgVSYOXHrHgc3nx+3ex4eioRiUmOuHXZlW2+amqKB9XhnhBGqkAbEjbEwXopugqrHPFUC+0/m96mFtd0L2CtDRppLR6i7n0w+Zb+mVuHC1cXIgXywk9Yogf+e1B7nMkFPkVZ+d;
 4:zUvwb1IL0WcWLIDvxnF8iZyIyWfPzhYuv8QiTiW7vaEOKUE2eGsBsCqVsENY92PQZXUGyJ+ST5nt27UTCdHQPf9JlOlgxOc8IbZAlY1/+CsoePoJls3V/kFyLpaXbMoqe9RfY43hZCeYBoJHDsWSbuK8RIgNJfWMcTwXnlPNJ2H/Aj9jIcaHltk7sywsHXRuSztkSkPmi5SegJpHpytEnaZHjiMbXruVm7Ed/Koh6aYjDGCRb+hVvDFOdW205z+K3V95lQ0H7S6TtyMJm5rfCMGxuVVHjFP2Smm1gdgcImcLL3eTnd52qiXOzACI2LxDhD/46CRbaiHpdU0pMwlDwtqsVeHiTFJmG0ATFiLk8lQ=
X-Microsoft-Antispam-PRVS: <AM0PR0402MB36507C02FAC5E8686F18C071EAC60@AM0PR0402MB3650.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501230)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3650; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3650;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(36756003)(16586007)(2906002)(6666003)(2950100002)(106356001)(316002)(6636002)(26005)(186003)(6116002)(16526019)(59450400001)(3846002)(25786009)(76176011)(51416003)(52116002)(6506007)(386003)(50466002)(48376002)(53936002)(5660300001)(478600001)(47776003)(6486002)(8936002)(1076002)(575784001)(6512007)(86362001)(4326008)(305945005)(97736004)(68736007)(81156014)(50226002)(7736002)(105586002)(8676002)(81166006)(66066001)(39060400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3650; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3650;
 23:a1D5IA0CUGeLSk+vIHyVyuDORGPzmwJVDogLUVv?=
 =?us-ascii?Q?Tlwwjicrd0gGWAKE5OuA6sjaoiICXBbYUb7RChKP41aZhpBAidxGrBCRw/zr?=
 =?us-ascii?Q?C87739CUGpd8zRAiVP0fBzXhNZMogTEEH/tsfOek9oeZtKn0C4oIHQojhsCe?=
 =?us-ascii?Q?6OLOZUv0TFa+nHApkXCuuJx8Uj6qwQT5tyfhlbs3y0FAUD7c6D1NOcN5+3oE?=
 =?us-ascii?Q?P3HBK4b8sv6R/5w+OWCvcKqxrAd/7OR76/4G2ZYwWrbsE0BFKFtNkIexa9hq?=
 =?us-ascii?Q?aH1170Wm8TQH/NJncY+1BJQyXyME5S6yltC3DOAuacVZXJFb2wW//SwkiQEJ?=
 =?us-ascii?Q?w/OeESyXlocP1i4GP/hWJi+fwehAGbSE6B272kfK5MF83dfGWOFJZzEe/VBz?=
 =?us-ascii?Q?sBG/OjKD8uaOhRWcPxRQc2Y/sVDGKEhCZrnP1Y1YcpNvq8BRrd+XoxfCIgrp?=
 =?us-ascii?Q?B+WiCmyAXTAtLmbw5anLxQY0AxiZtIeCEwDRVc5bFuXeOr9yGe3T9y8ZLVww?=
 =?us-ascii?Q?xNLCaIbelcA4T3qwU0wg6edv93WhIok5cEZ+TidJuTq+v229mO9DLI65NFwQ?=
 =?us-ascii?Q?b2IKUo0UUdqiNXGmKeUQ0RYf2Zw9Ev+Ut7Eg/OPA2VNJ1NGFaPxgXFME/U+t?=
 =?us-ascii?Q?UXHaimf0dxqmTPt0ld3XdV5rkbXKnprJUf0AviQE+HpAOHcXoNxN2Upi+PRc?=
 =?us-ascii?Q?1GXMVdc2Kei6XuFjh+yUuTMUvbs2mBd0tldDFwaMNUrWBEFlt+sYMQBM4bmi?=
 =?us-ascii?Q?7JJvijyJZdh4nA+V4Rn3QCmuRpexMOm+xvgR6YljNE4joJSG5QfyClafLLRy?=
 =?us-ascii?Q?gvC5FrE6iXgGALtT+fODkg6/9XEis3Q7YZ60Udgs3eGpXIzPM3JP7Tj4IXMF?=
 =?us-ascii?Q?HE3qbVzrLDbpV7OPwhG6anG8xnddqDu1tp4DXaJUke/1a6A1XYMtHQHhAjzj?=
 =?us-ascii?Q?gBaMLYwh0xdRAao4TMot2CNRMz7qa6PHlEoN2oubkl85nybAkzuN6jLM7PTq?=
 =?us-ascii?Q?sllHdNX2nloLu99OB27Ol3l5+t7gnUGMzgMF9atcC7NDl7FYPkjmct4mcDH0?=
 =?us-ascii?Q?7rC9aSif9nA2l8GdbmjVw5wGMAugbSRe04KH0/mowB1LsINLoLoSa/ckFUCh?=
 =?us-ascii?Q?Eq6ocKLZNg5cfsC9Iv4EZkNvEXZ3xGDm7eiZf46RBIzSkirLzT6/JmqXTEJk?=
 =?us-ascii?Q?L59gdKTDbuYmdJPeWtTNMLzuxTjttktmf250a?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 6:1uO8t43TWOfyBJ8/Hrrwiy/UhXcjCTodjl1LXTI47s1nUBzW8TsLbs4TUJZlsj1IpFfqtIAZbppl/vAi+K5iPARoIV3jL2o3VEDVg2uXHXLErECOBaGsYIsu/32K32aLhQUzscIRfyuQOQaZjLEQV5+MvUcIV4p5KgvW5zemceewm9l6euwdrjUbe8uX27mjh2iQiahgAmvN1iy1Db81yWorKb8Ox6v8c028fqeTiEZlmGwcUjqXEMei3uXo/POT5JAUdtUySQbu+NKIiz3Xasav8HqeSOX7uHpv82vbdDzhaVOba3MhXtg3sAD3PI21atVwyqBEtvVTOS5+YCFZEgwNrwGkGnmSIeCGFsJD+Gk=;
 5:cTKe86BhmBW+Ts4iZ0CPNeWN+nh9R0WmeCgZp/wY/2g25tAKzDcvfqsJRLHy1t61ZLJRN/mh/ecuo/oKdtClCnGNOLzYSfY9yK0COpICaTixXsI0T51v+XNepPkWFqI+r4sZ9iVfSCA8yNtbUQAGInNVQEed/D4v6iTJjJ4F95o=;
 24:rSCoA4rx2SyVp8eKZ37hmN08dFhMsX6F/OjAVVEUHdQeNzyK6f9JCTJrc2rxzYeBj6vBAMm3J4q0XygZVMTMQtOaJO7f6/UtJZC6pf+xl4g=;
 7:EBqgtCLgZpTa55NcxoxWgCeGgqer+IiWgvutfxgSh0rJtOrPlZnkqxbAxhucg1xk22TxbZIuWJQev8Or+L5BAj/qoUhNDmuOTKRatroPjqwVHkcqT8QGNMU5hJsqU6ku7BZZqP2PaIe6DIEJmCu9JACBo+Gd6qLHcPKWl1ynOFIL8bZ7Hfxkf5tnN7ANULgTi9myuxq8Nk898jVR4PBDREl+1JlEAUlurHw8rU41k5tljq/PP/DEJB4R9o6DZLr2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 17:47:48.0544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c7ae1d-26e5-435e-e7e5-08d57f9c8cf9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3650
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
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, horia.geanta@nxp.com,
 roy.pledge@nxp.com, ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org,
 nipun.gupta@nxp.com, Bogdan Purcareata <bogdan.purcareata@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Some functions and associated structures are not used by current code,
so remove them.

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpbp-cmd.h | 10 ------
 drivers/staging/fsl-mc/bus/dpbp.c     | 67 -----------------------------------
 drivers/staging/fsl-mc/include/dpbp.h | 10 ------
 3 files changed, 87 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
index 0b7f5c0..3340021 100644
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
@@ -19,28 +19,18 @@
 /* Command IDs */
 #define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
 #define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
-#define DPBP_CMDID_GET_API_VERSION	DPBP_CMD(0xa04)
 
 #define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
 #define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
 #define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
 #define DPBP_CMDID_RESET		DPBP_CMD(0x005)
-#define DPBP_CMDID_IS_ENABLED		DPBP_CMD(0x006)
 
 struct dpbp_cmd_open {
 	__le32 dpbp_id;
 };
 
-struct dpbp_cmd_destroy {
-	__le32 object_id;
-};
-
 #define DPBP_ENABLE			0x1
 
-struct dpbp_rsp_is_enabled {
-	u8 enabled;
-};
-
 struct dpbp_rsp_get_attributes {
 	/* response word 0 */
 	__le16 pad;
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/staging/fsl-mc/bus/dpbp.c
index c0addaa..85735bb 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/staging/fsl-mc/bus/dpbp.c
@@ -126,40 +126,6 @@ int dpbp_disable(struct fsl_mc_io *mc_io,
 EXPORT_SYMBOL_GPL(dpbp_disable);
 
 /**
- * dpbp_is_enabled() - Check if the DPBP is enabled.
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPBP object
- * @en:		Returns '1' if object is enabled; '0' otherwise
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpbp_is_enabled(struct fsl_mc_io *mc_io,
-		    u32 cmd_flags,
-		    u16 token,
-		    int *en)
-{
-	struct mc_command cmd = { 0 };
-	struct dpbp_rsp_is_enabled *rsp_params;
-	int err;
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPBP_CMDID_IS_ENABLED, cmd_flags,
-					  token);
-
-	/* send command to mc*/
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	rsp_params = (struct dpbp_rsp_is_enabled *)cmd.params;
-	*en = rsp_params->enabled & DPBP_ENABLE;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dpbp_is_enabled);
-
-/**
  * dpbp_reset() - Reset the DPBP, returns the object to initial state.
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
@@ -218,36 +184,3 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dpbp_get_attributes);
-
-/**
- * dpbp_get_api_version - Get Data Path Buffer Pool API version
- * @mc_io:	Pointer to Mc portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @major_ver:	Major version of Buffer Pool API
- * @minor_ver:	Minor version of Buffer Pool API
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpbp_get_api_version(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 *major_ver,
-			 u16 *minor_ver)
-{
-	struct mc_command cmd = { 0 };
-	int err;
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPBP_CMDID_GET_API_VERSION,
-					  cmd_flags, 0);
-
-	/* send command to mc */
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	mc_cmd_read_api_version(&cmd, major_ver, minor_ver);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dpbp_get_api_version);
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
index 4a18096..7b9f7ad 100644
--- a/drivers/staging/fsl-mc/include/dpbp.h
+++ b/drivers/staging/fsl-mc/include/dpbp.h
@@ -30,11 +30,6 @@ int dpbp_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token);
 
-int dpbp_is_enabled(struct fsl_mc_io *mc_io,
-		    u32 cmd_flags,
-		    u16 token,
-		    int *en);
-
 int dpbp_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token);
@@ -55,9 +50,4 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr);
 
-int dpbp_get_api_version(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 *major_ver,
-			 u16 *minor_ver);
-
 #endif /* __FSL_DPBP_H */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
