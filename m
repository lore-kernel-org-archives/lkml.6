Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2568875-1517839720-2-2481569027941934317
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517839719; b=f4Jftnm+W/hLheRu8WztRz/QACMSBPIhHgXxl4oTaYsgfnk
    kuTYN8PHOQ2SCBGSN6J6qv/1r55/vfFZqVfwJeATzn2gbWWv+DQTTBcmqGgda5b+
    15co7m46mijFJh1/E/nzqayGPChrMzooLCmsJe1OaC/Jcke9x/VkfC92CthN8J8x
    /AKQfxoIoP5nqr+bm6V5EMOHjzgdHHpIDYi74HZv/XwjYfMRDsUJjKjm7X/KCgPX
    uaeaFy8veer698trxvK4PC/13V+CQY+oD40ju0tCOzT4YMJdkDbmkrEwS4pi7YET
    TtQWfvTFuOVlNlFx+ePI9yfHodgbB98IEKZLnEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517839719; bh=A
    A6fgjD3S6S+WGnRJ4Pd/FsyHyKIJgO1LquZHw9emX4=; b=W4CKG3/klXcLnxh3N
    S4ZfIRLznG7Gby9xG7VuL/il3J7/Oivp0QEqBtEOozAy3IyXLPhwejJzuHwtNXB7
    QruLM43EtcG46Wa2XrrtrWvZpB5vOps2OnHQraK1SQhWRbLkCCClfGH1/XfmcisQ
    CUD+l9NZnfan40+7f/7w1i2U4ISujQmixY+bV/QyduYIFNMa8B4P03ttBBkteS05
    VwlCINqTnSEaCY5LB3u5Uhk/1iH+Yc14kol1BBbwnwn6XEvqJnbwYKBaPaqVFW6D
    fuvDUlRhLzcpBmcJCcsbayd9JV2hr+9djG74QXflFXDutxDCFIQuDm1LMa50Xi/+
    AVeBQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=WFfVgis8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=WFfVgis8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH v6 2/2] staging: fsl-mc: Move irqchip code out of staging
Date: Mon,  5 Feb 2018 08:07:43 -0600
Message-Id: <20180205140743.29974-3-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
References: <20180205140743.29974-1-bogdan.purcareata@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR21CA0059.namprd21.prod.outlook.com
 (2603:10b6:300:db::21) To VI1PR0402MB3664.eurprd04.prod.outlook.com
 (2603:10a6:803:1e::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acad7dd0-23a9-466d-699c-08d56ca1edbf
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:VI1PR0402MB3664;
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 3:b6OE+E1TqC7AX4BtJmYFseHwdSWSqVl1+FpLn1D+x5DyTDr1+1XRBolsiGKsPP14AUQbM8ajfvJ2uE/w+/8kbqqJTz/KoYMtb47sf0XA8segYHDeGYDkUR1TtaPUs+FwV1TcKYnbH48yUOnT7pQK6Ry/grSC9vVzp77FYGNSt60hwfpx8R1pDGxPW0i2RK3r9rCDYdlFPB5HShOiJmzInB+7bUnU7lmx6YQJ6TGpWhTQihKVbS72CQxoxeE+Umbs;
 25:bC+LxeOp0Va3A5U2M2qwzHnTeElv+5GFJ6TI62Ubd7Pt+q+XL3bDfBr926zLeSTJdFWLfvl3t4nUVqxF5KyLraIe+U3TCncF0/UumL8jsjZs7VIcU8PJEEfx7QxvG+nMhbMvKGRyT/g9FVw3uLYVSlO3LrC5i7WsV3iHo81TiGsCwIA7fXmMzfhEeeTZcCa6oy+sLbprWpNYuqGYv9u4g4tmGlHnX75FJb9p9hFlvEBrwVk6gg15voxkaIQ/cSZp7gLutTqSCtQcTVnlwmi3PZvDT2jrBsyMSd78wNkyO6FQnU1DN6Wa3OHt56SUCFWiVL+gMULlaiReiPkyioT2Yg==;
 31:0BC6jMCjB6bQ9ji2BpQZiWYjnFjh/SrwzEMndjPArB7X63t9DnIafypMwPuj1tYWfOhFP1iqOU6ft6olQ4piSaBMxf8xpP+XqsZKJbhMFN7Xe5fFbMq2RtT865buAs1kV69R31eZUFb5LnohnhNJlhXsSQzhoA/x5SvA1uid5GJ9/vzrkBmHvtx5+OpRaemBpv/7GgPK1BKlfMtlcn27gsmvLcELodluQLLqrWN8B4c=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3664:
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 20:jV2207wOWYzO8n1nDm7MVJhowJkitK93mAB9zAcNxwXcJ2p6D+iZ32PUM0nxCWpa3Hx1TQWl5OFQ8FPgZ2anFX7jHZXWgli8Jo/rAEDQ3ps73WSdVoWoBH2tiURleBjP2DElcPpmIVCxLQkC3lJaL7cPiuiGCZR0ovYXTZs1J9r375BnbZiHflEZIFEcbuOeL5HxT1fMJLobPfx6MgFqOu74H2cOP7sWNbXn07yY3lr0XwdR0QRsCxq2xIHPgsHzzIH9iZW5SXK1Jc/BRCjPQXodGe7uNlZcZkycGJDDMUUpFv90mnM9mv5/N2NB/RdrckBcVNtMuazYvOVPmJNvlFUTxZokUl5e7DalXgRcNvmhswMCP3syD5Pu9EuNXalYc9tL6o5Lok9nN70TXKTMv2GCf9n/RN8+6Kl4Q/765oZiPOpG0K1Sw4zwO9mUcEAQxJRBjDzBOyhFkYp3fQRiPFwg3YnzpD6B7jalPu7bcPugRWSMFPpewdSQUYxT8s2L;
 4:juzXDfHvw534yZq+oTr0oIyropDMlyZsQzIOwj2gIFLMzV08cGzYte2R4Jw1c35HevJGd8T0Ts3ZKRShKCstr1bHvUNFDj2+OQfHCDkAuFkr9WzOJLdWUEJjUcniWoFQtWMryUM4Z2Vjh9xuqnEybQ4h9DBhrrR8w8I3/uk1DPhsIZJc59YoYrdfh80RZuinWO+e54piRqOtnhWn1dmbhqV0YYGJTW8H2YQaO5cn7we5TGTOv1Oc1RIRBZkbxCHjI8q3d+/YYxllKOU3kyNmlrJYrpzxLTq/lauR8FQejdqJiS58Qmwo6G6d/9lBpbQvhqiByg4unChGDGh01e4Y/o407IOYFBJFFmNIOJiMQPmGIbeczi2w6lU2UcjFOyMJ
X-Microsoft-Antispam-PRVS: <VI1PR0402MB366465A987A5A5E845940683EAFE0@VI1PR0402MB3664.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197)(85827821059158); 
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);
 SRVR:VI1PR0402MB3664; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0402MB3664;
X-Forefront-PRVS: 0574D4712B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(39860400002)(376002)(366004)(396003)(346002)(199004)(189003)(316002)(39060400002)(16586007)(16526019)(7736002)(305945005)(36756003)(6506007)(6346003)(76176011)(105586002)(52116002)(51416003)(6486002)(66066001)(47776003)(7416002)(68736007)(186003)(386003)(4326008)(6116002)(3846002)(1076002)(26005)(478600001)(2906002)(50226002)(6666003)(6636002)(106356001)(2950100002)(25786009)(53936002)(86362001)(81156014)(6512007)(5660300001)(8936002)(50466002)(81166006)(8676002)(97736004)(48376002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3664; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; VI1PR0402MB3664;
 23:h9VGErN12sNBhmHY2KFDZUvoW17A2GBoeKe/el3?=
 =?us-ascii?Q?4NLgFMBG17xKoh+Ao530l3acvwGPTFuwZWF551Sz7Ggy/oaiIwtrmFK2RpFi?=
 =?us-ascii?Q?BGvqJMo4I/GLVcm6gyp0e7j7glLTFF3NPvaij8ExWrW02VW8SvP/i5IbQiUR?=
 =?us-ascii?Q?VEzHBI4Ftylsh3woHiPf4f8hdOLmJvHV2dEc86Z2QTk60fqowLNWfekzkRLI?=
 =?us-ascii?Q?vVTKKC8w9rSXO7fMR5uRDVrfDxyaKTaOAvntZQXb2xh/JMji71ToUwzfCBSE?=
 =?us-ascii?Q?+jH6Ub0NkQUmAW/ttpmL6gRD4DKQn2g6mDj18CE+TJ7uxVpEW51++16k1/Ql?=
 =?us-ascii?Q?ujmY1nCyNoNoBKk3zD6Snti3VIMelExSoOZ28GVcJ6vMfrA478JbwhSygLtu?=
 =?us-ascii?Q?sgvz7ha3b/yhaIUTVdafAjtAjRae/RrYlbl/GJeuKgmskGyHKSVe1K0EzQTo?=
 =?us-ascii?Q?pnXMAdy2YZ1rthz2LOCDRkkXmpOzvCHPgU2ntwiaJkHWHC6HmMzwJza8ZNSs?=
 =?us-ascii?Q?Ldw/K7fpTkodthVTkwQyWbz9M6Ua22nAGztoWyOdH39A1qrSqU0Ea+5iSmOR?=
 =?us-ascii?Q?2WTriPBFcZru01IQP0AHQ1hRTkCE0DVsO04kuyD86jr/czFJmFFrUDu8N0/G?=
 =?us-ascii?Q?kA3akCG8ltzD/MXbSb1TfvFmP4h5N4D5C0mbV2B89XW/riEWZjUa/hElYD5r?=
 =?us-ascii?Q?gPN/7dT2ih4gW6rf+TxnyQX9hecs0BcpC98edUC/o+tHFEvEla+7JMysl1qB?=
 =?us-ascii?Q?DEthjZk0p3dX7yK7qUZcF6UQwcj/KoI3A7wowwQ0tqIt28HoQ1BzW4EtBKy5?=
 =?us-ascii?Q?E0Idd7i6qujwrsy4GqMFjx++TFXhCp+MFHQ9EAyjE96NlVQ9MD+rzc4v9yEb?=
 =?us-ascii?Q?tcWENheRnMCZQ25krGLw0mHewP85fFBGyNlledcvFAcx63Em/03Z3h3RTAr3?=
 =?us-ascii?Q?8uXHE9T9grkGBEQT1XVvqUqAdcdD4LDrIc2/FFSNy2elQzSejQzZmuZn7zeg?=
 =?us-ascii?Q?2vWQj4vf5BrJFbiyBxPEPQh/4Jt2ffdfk04GoWZfat33BYttIPMBhEzP/lfC?=
 =?us-ascii?Q?uCGetWPEkCY0ibkPHem0P5NNdyuGpqTa3hvcHIDK1fRoEigsktlnfF6JdslA?=
 =?us-ascii?Q?8D08uMrma4XcaLbkEisBP1vgp6WWzMfKWxMTwrSF3d+r7dUpIwuDxyskhjI/?=
 =?us-ascii?Q?9iQJqooJPBQ7Mfew=3D?=
X-Microsoft-Exchange-Diagnostics: 1; VI1PR0402MB3664;
 6:+zaLK4vGRZz3jFg4tdYgscS9zwO8ho1WexK4fGiSHTWFGJVwqbunG9BlUseJl3pYYv3eUnF4mWw3PHQjw/N72LbnB9Y/5RvwRKXFB4Y0wVtmyAFb6j8AJGxDuYxAbVezk6qoItMEQqdINJ98IU+eKNPbzMOVipb8WZiDbbUJ9RltsWoi+OvQ1YUA4NnVrlJ4hMSF06f8nYE8XoVxHIML79Qc+xSYyIUxnGpqkFCSMEnDedbNVBgjMDo7n6gjd+axCIM+aaZJw6++5uwXAcSgYH1Ib2mI21ICq4GOE+CKfgZtKN2heNGcrCHrY2uZDHDoviiUOeHlk9EuA0UZY0MqR4QyO5EO8B6rjtKyHQYybL8=;
 5:1N+1Tymth0fR3af13L2kYytpp1MGkF8kC3klo0NjqPbXl7FJ9fhXtQivjirwZFw08UdHCaDQ7+I0RYXyuH459rjRvU5//e2fC3+rW8ahlLL36AeAFEoV1ZRoHGFtf/gyGVIxZKvmsrHrKDdluMjzFOWKOJIgXVDJgqsmMDf4wJw=;
 24:digDUF1+VlFgL/1psMyUh2qwi3SKp4IaXU2OBzSCyglBjDRO6Obwmqoj7VHdHNHsWXBTWGXRSVwgpCw8+497scURxWPUXSWhsIxDD+LTK1I=;
 7:Ulcd4//NIK8CUNIQkZ12kkHIOJTtj8RlSQ0/SjoS29c1QQSVhPMbwHIhTNACRgkXn5bm7EKlRWdr3cmRSuSrsPVLl8U0chsqLIZWFDl+HB22QjrufIx9U7OB80+A8SFs0h2IAQOsGmTzZtqjWEblZsfSAzRNSYXR8gbzUrZGVtp8jykY0pNeFQg1MNnQHYO9P89b/KRxU2qYX60XQdwl/4YPxHTb9AC6FhO0GAanHKExa0TaU/1n8lMrdAuAztjO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2018 14:08:23.1446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acad7dd0-23a9-466d-699c-08d56ca1edbf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
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
Cc: devel@driverdev.osuosl.org, robh@kernel.org, stuyoder@gmail.com,
 arnd@arndb.de, marc.zyngier@arm.com, roy.pledge@nxp.com, ioana.ciornei@nxp.com,
 linux-kernel@vger.kernel.org, razvan.stefanescu@nxp.com, horia.geanta@nxp.com,
 nipun.gupta@nxp.com, tglx@linutronix.de, bogdan.purcareata@nxp.com,
 linux-arm-kernel@lists.infradead.org, jason@lakedaemon.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that the fsl-mc bus core infrastructure is out of staging, the
remaining irqchip glue code used (irq-gic-v3-its-fsl-mc-msi.c) goes
to drivers/irqchip.

Create new Kconfig option for irqchip code that depends on
FSL_MC_BUS and ARM_GIC_V3_ITS. This ensures irqchip code only
gets built on ARM64 platforms. We can now remove #ifdef
GENERIC_MSI_DOMAIN_OPS as it was only needed for x86.

Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
[rebased, add dpaa2_eth and dpio #include updates]
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
[rebased, split irqchip to separate patch]
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
[add Kconfig dependency on ARM_GIC_V3_ITS]
Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
Notes:
    -v6:
      - generate patch with rename detection enabled (GregKH)
      - add Kconfig dependecy on ARM_GIC_V3_ITS (Mark Zyngier)
    -v5:
      - split irqchip glue code to separate patch (GregKH)
    -v4 - v1:
      - no change

 drivers/irqchip/Kconfig                                             | 6 ++++++
 drivers/irqchip/Makefile                                            | 1 +
 drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c | 2 --
 drivers/staging/fsl-mc/bus/Makefile                                 | 3 +--
 4 files changed, 8 insertions(+), 4 deletions(-)
 rename drivers/{staging/fsl-mc/bus => irqchip}/irq-gic-v3-its-fsl-mc-msi.c (98%)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d913aec..f2ace51 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -51,6 +51,12 @@ config ARM_GIC_V3_ITS_PCI
 	depends on PCI_MSI
 	default ARM_GIC_V3_ITS
 
+config ARM_GIC_V3_ITS_FSL_MC
+	bool
+	depends on ARM_GIC_V3_ITS
+	depends on FSL_MC_BUS
+	default ARM_GIC_V3_ITS
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d27e3e3..1ba4390 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
+obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
rename to drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index b365fbb..13a5d9a 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -43,9 +43,7 @@ static int its_fsl_mc_msi_prepare(struct irq_domain *msi_domain,
 	 * NOTE: This device id corresponds to the IOMMU stream ID
 	 * associated with the DPRC object (ICID).
 	 */
-#ifdef GENERIC_MSI_DOMAIN_OPS
 	info->scratchpad[0].ul = mc_bus_dev->icid;
-#endif
 	msi_info = msi_get_domain_info(msi_domain->parent);
 	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
 }
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 18b1b5f..b67889e 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,8 +4,7 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += irq-gic-v3-its-fsl-mc-msi.o \
-			    dpbp.o \
+obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
 			    dpcon.o
 
 # MC DPIO driver
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
