Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3288027-1519662520-2-10194662392123496640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519662520; b=Jb4VBUGKU/+8GTrxwm5zED6uOC8JStabmgTWyxHOM1PrBkO
    8EcY1iC1z/nqQHhDzPCPjU6AFZOA34EOlPlz0ojbSRM0vWZuyjQTLkorwR8t+bk4
    6aTx00kWlCGlTLuUUEddS86McyrE37kfCxWdiJfAUgOFKOX9nfjSh1LV/1gVSycy
    t3tj0DFKS0jWScjqyq+4Xj1DWUZWQ38mFyCX0JZaXfjR+CyFZMCrN301OhdJ0PeT
    APJVbMrletb6pAAYs8ZzomZXrBS7npK2ZP7PpMI7RYdjhmx1+Qpw+Yuk5f5yQvVB
    9xwB9i8SA7b2c6rTFsp792XGQlMRX+JEs6DmYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519662520; bh=P
    ONNGuHa4n1oMI6ztmse6VjSUh01XwCgMy7TOg0WdBc=; b=iI1Yliq11wcuiZSyD
    ywwLQox8vLrgd8z7gNVjMNA/iQsZYaQ3jQXHalWg5Lnb9DhJJkNFcmK91avWz8uw
    9uhJXtnLObzyUCxh8Z7u8Z0f21ELlOb/7mV5pds9ebb9HCa53seN/fAmPk2/7VFc
    LzUmzmdCS3eiUqMc86NezGp/ur9vwrT2vxOg4oYMph9b6AROaUfp5RBZbKw+Niu6
    tS4Yv0pxX5+CgBY6Oz5dkJXGNju50SR10Pn2VNFWojZ2RWUSviU0xrkExJuOVCaO
    YnVk8Loyb+sRXNw1y/k2cksN1JuZBBydEzNvDfQ97uB0eZq62omhE3ZIGFGmXv4o
    +k6FA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=uXaWdwiL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=uXaWdwiL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 2/4] staging: fsl-mc/dpio: allow the driver to compile
 multi-arch
Date: Mon, 26 Feb 2018 10:28:05 -0600
Message-Id: <20180226162807.20649-3-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
References: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28)
 To DB6PR0402MB2696.eurprd04.prod.outlook.com
 (2603:10a6:4:94::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ffd03b6-1e8d-4e32-96a1-08d57d35f73b
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:DB6PR0402MB2696;
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 3:CJzFhcTNQT2XJ6n7TCboH6gDrO+/HOMWYYO+yLVu1n8FRBnocacnX/2+GSW23t5022aPwaaQUkmqW2UxdGNZFO6VAuc0m+/NW34Ay61Exw8Il8jdG/NH7ClboTyfZ6nT+WpeToVK/UmXatSnNs4Cr0wEm/L0X+nQ/noCF+chrsuEcTEV8iBNqg9uxBtw+GxdkuIxRTIWFm0AJo6xsrLrRX3564Ggk+hSOMiNqCBv/CoAFM4Z3jhXC1kVGZc1XOLT;
 25:YbCVOhxQfr3s12t5zXcJKWKw6ThgW3m/3DRsvyopZcGqxiQHqQYqniEECVeLPkLnjHcpgHd2ZtFRMgNLdqAyn/luS7yT1JDmj+UBUXTojpvpwuZYcizap8rMBwOBF+GZNmc/JgYMEf/B+9KfC/g29IfKMzM2rfDG2UBT8RaoR9ja1OHz4OT8BtGb4W7vSc2+eAZ/cCwG8OQ9tWJbHYKz1x6lGeN4QYpX6ig1iYgYafOUexhSs55+83EzyGUYH7sNUs2EYCof8GWbQlYdx9NlSGm36g03I7zSGFktiFsIJg1fkp46NxX3Jnks7/xFvNnm/AfwlTZOt/AjqdlpjsiwEQ==;
 31:jpLsrvxMX6q/1ptpyT64LoyH4Aa0fO8jrFy5zHkV1f8mzakySr3eTIW0laCt1xG5mytkNohupw/IV6+FKe3zjvEHMx7xurLqQL00w4B6uy01uDR04WqlwFogC6/2EGlgP+A9nbq5vWDii76IbDmk4pQ4MSRLOZgLv6Yobq84KcYJvMs0K/+RU3vxG5B3hexgFw2WdxnR64q0ZgS212aViDCu9sMGuNr77tU2ih8NnA4=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 20:5LJ97mP7A8oIDndR6QvXIUz3Ey3uJ2aP/RVthLzVBS4ZEO+trJY5e7B8iBgXPuGyVbzyaF2jORQWnNpSyNwnXJmo4OcDiEOxaZa8w1XAstCm1dhACaXYSNuVAUenVOQXCi1Kcsj6KYgQsssAUZ4Ao3MoFKhpingyP7kuA5qWU9v2f2OEUKN14+LDc5noT1S5LW5FepFxFVBuIvLhH4JbyWott66dRtkqLxh8h5dhOH5Si5M3gvAE3DESG4K/6WMWUqn2sal51qn43Ovvz5dNxoJd9IS54LymvsgiL+mCbxJEHdOv0WmHVyJ+gjLCmuCKtx82V+5TM/ZF8ECVNsnueKB6L5X2eLaLiBKTHQ0FMqHQEwheufWIVcKi9J5VPz/7aB5dcdOqZnhQq6ijIjbf+Ko+GqTTV3mkIS2B44XCWfnZDyw36Uuu699XvxdXA1vIfmD9zwmKtryfikjCdVPWhLqOdf85WW6ONc/pVsS3AQpOI5Vs79Rjw9r59oK4hq2I;
 4:Vs8Aqe1sy+qGA6mlOJpXrNZQBlVeNf0VhLvz+uKMtEPYQ3V2gKVYYguJXPW+DpME7C7EjcqI7QoQc9qTx/cFbJ3oa6lIwBX6hclwlcc4JtIdCaVKkJTT8zcD5ChkjHIPbiCCbLLvXakuUTa85asZppwD4aSuOc6LaLs3lZlRu9/h6KkXHujAEmBX8C7TdCyer12BT3DSvsEPUDDTSTRR6BMX4lsAfAp66LgeW3FrdB3zadtUbDD1OEF5pipPutXJuTtHiG9nrBpkfBCe7iE/+TAUZc6rJsxZ/2COpV2iak9p5vewT281LQpVZi3IyOcT+O2mo9euRFArPa69KiN+nkbVHzTowufC4BewPW5qKxg=
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2696C0F92D03371202AEFA9194C10@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:DB6PR0402MB2696; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0402MB2696;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(39380400002)(376002)(199004)(189003)(2361001)(51416003)(106356001)(50466002)(26005)(16526019)(478600001)(316002)(186003)(105586002)(52116002)(305945005)(7736002)(16586007)(81166006)(25786009)(97736004)(5660300001)(2351001)(86362001)(2906002)(8676002)(2950100002)(6666003)(66066001)(36756003)(4326008)(6486002)(47776003)(6916009)(53936002)(48376002)(81156014)(59450400001)(76176011)(68736007)(6512007)(8936002)(386003)(6506007)(50226002)(1076002)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2696; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB6PR0402MB2696;
 23:yI83WLSdzjAwsp/HHg/bhOuqc2b72CmB1J2CQr5?=
 =?us-ascii?Q?Wcg5D7fAorJ3/wOqEzvoKy8gl9PUK2y0Tjlsa3V3aZzXE9pp/QikuecZhHdt?=
 =?us-ascii?Q?fyKdx61siwlGDVleX31Yje7QGmV7XM4LfhvCa9USRlG+q2UXnvfcyOEKHsxG?=
 =?us-ascii?Q?FttF2Pn26am6NJeq+kMz4y1DrvarbMCXFLelJnlDEef8VWzUBgs9JyBs/xRs?=
 =?us-ascii?Q?KHrFo7igZT2uLxdu8t5o4ratuyEvVFd1NfTzLz9FIUz9SERkoRlDN+a5bWxQ?=
 =?us-ascii?Q?h8pj8zJp87tflyXOJGgY/QOYpsusYznNZx1NTyKwNeGVyNdBx7MUGwtCj0N6?=
 =?us-ascii?Q?j37P5itnOJ5L28BU9Pv+mEHXPEQLEDIoYfEedJOSI9VMNclfg8yGtbTnuald?=
 =?us-ascii?Q?0qhaGmCVLKJfiTt23MQs4lA7pQUC17i3yTq9GhaPMr7AvcxHXypdBTCz85OK?=
 =?us-ascii?Q?Po1bpsWOhyVWOC81dEX/buy4JXxEDZJl3Dn3vJIC3vM/Iq9EmmB0YFBtr4Mm?=
 =?us-ascii?Q?cLtK44oVNOMKngcyc0QRLCZ3vNukWshPNjEZCrvzZrCto8QsdBrmbAts4m5M?=
 =?us-ascii?Q?O75aMR8q0y6kgcLauxq8iPcxcqzDfCPlNgZFJF8Mx+XfK+VcFCuX+ELthBPY?=
 =?us-ascii?Q?FJMNLCo/T/AFg2W7+heNlQTV8+B/16UXuiP26u/EjJjhwW/g1wD+YlvhULMj?=
 =?us-ascii?Q?Gj8tIeEfvADE7Yzyir9QQq7otvoWBP3z5kt416g9YbAaimiXPsp2hTt5Q7Mf?=
 =?us-ascii?Q?I8UOMeUs5tDUS9REkz5q/bxP23x1tK4SYSrCcZolrvOU6FgnGNFDBbQKolPk?=
 =?us-ascii?Q?DesXxV1LLw+Uns0vjO6n/mJBMePugBwkzDcojIp4gvPy0Duyyw9D0EFbtekO?=
 =?us-ascii?Q?ToL7A/MGL7NUjXkYzp65653RBs0ZK3jhAjCKspRqXz7zHXAtgZwwB1MqNO+t?=
 =?us-ascii?Q?Me93kmdENLOWDFncZ96R/lPCAMpyxCHMUD3Pha1byU6pWerhi6uJWhPt1pvL?=
 =?us-ascii?Q?sxYTCN5+twwy7aYXYjXfrYdZOBCLzDZvhptEVIm4flGqwaYPVK5LmlFDT2E9?=
 =?us-ascii?Q?CutUmWhOjw1Pqk8cH5ET9RK3Ulw02PG99VPcEyFtyMylsRDfeS2sNj5YB3QR?=
 =?us-ascii?Q?Vf6mD80cfihER24K54qarnp3JZK98wUk9NxrSeskQEAHBbfr5jMxFg5GBplJ?=
 =?us-ascii?Q?fLz5mW7zq9cnML5s=3D?=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 6:+enYQdVg9G6gUKXa/7D10cU7U4rPDR7rA+F2YZGgLhym4SnWA6rgfZPMr1xUiqBRM5E8M7PqCz0R8nfvnTYnPu/FuH+8zyXJVl2qF3K6PnDUK75cM9BLP2BPBASR8fnTguviEsdtiXtiE2tTSw8NMo1+WyzB4R5jBpGV3A5eTc/EW0/n9R410ZFjf8rUYogjqCPHl43UX/2DMAUFx9L180NgXAayngjYRiAoivLsz2EiBe7ZHiChLy6W6RYza5dZ3RuhZSFCtt5zRkbT/GrM9fM6J9MqSZr8UoYS6g2r5FCPuBk/bFOugCnDKrWf7lUTfy7TxEaAuZ9YRUy1LGGD3B4dvPuRg2G3lAWv7LAL2JM=;
 5:JMvAEpSAgxyZh+nmLAP4kN/EZmh8U9s5UaTT/aLzujBY9RD9iuJTOcfyq8dRy6z6zbDWDtdj6P4JdKivoCIY+1v4B4PGcR7zuSw+FowXxDvhT0pzO6nTz9AUTQ5iH7pQqEG7vxUfA3Pnt7bmEici5K/b9k91VcxcdN2La6GAqM0=;
 24:TFMCwp4Lyq9whpQviFlrOVwSCRQ893Kyyo2DR81cK6BvnfAZk6EYqBr7c5cAiUGbScenKWGp7weKn0WaLUXRYJ+Y8BZhjxK7cQTufrcsPFk=;
 7:o19fJQbJSegFnjN2NcbejYLXhOO9snaKGkkKp23Mb1u9A4IbYKez8bqrAfW3nmF4b3q2EltOeMzRA77/MhDOlrzzqx17WIE4sf0XduQtRydivG4nnWU1mSCMTrSMOONawlDJQKYohj0yy/cHku2qPuD8kPmxAXbSokVWNPzoDJHMQ0L6dwAhwoj5a8lFXG0PEeu8KUw7xo9EY8d2N4oqADmqCyp+A4HZkeAAgSNmbDojg6CByixC9dbAHLm45LBY
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:28:26.5221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffd03b6-1e8d-4e32-96a1-08d57d35f73b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2696
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
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com, bogdan.purcareata@nxp.com,
 linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Drop dependency on ARCH_LAYERSCAPE (which in turn depends on ARM64),
thus allowing this driver to compile on all architectures supported
by the fsl-mc bus driver.

This was compile tested on:
 - powerpc (corenet_basic_defconfig, ppc64_defconfig)
 - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
 - arm64 (defconfig)

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-mc/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 5f4115d..3424530 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -7,7 +7,7 @@
 
 config FSL_MC_DPIO
         tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS && ARCH_LAYERSCAPE
+        depends on FSL_MC_BUS
         help
 	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
 	  buffer management facilities for software to interact with
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
