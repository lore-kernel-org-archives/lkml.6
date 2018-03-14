Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2061918-1521043005-5-6973402532600969174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521043005; b=qKI9vYh2rEjcncBM34kJIRyY1xlHQkz+V/v61aVD+14KRe2
    PbwT1agjBlraOflOjCfsaEve9Zo9JUSxe78nKUjsJSaAkUFH1r4lgDoF4d7sIK/m
    AfxXHzcxybq4QuKVd8I73zrlh5pd3Y9k/gy6ZHuWP7Uo4F7wiQgLtovk+XXIwXey
    hmk8x5P2Xvl+3YlYcYrgBJHRIbklFj3MaC/6AsOGxReB8fmGG+CUBMFnZ2JVYlIp
    Qa6+5GP6dLb1Tzk3MjLqctLpMzAl91SJmcSQEi9C5q2evrgp0s25XRdxRAO/1sOm
    Hh4wGOTCvfsEmejV2n0Uc0EJaZhR/qHgtNb2KpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521043005; bh=5
    OJqL+Q5b21FkypTWYSMn9mauKRiuaiIIu8mT2HaWLQ=; b=Mw3YLbMWcKLroKtWg
    QdN9/GKdZTC2ilzCWGikifc7mbGkbSs3eENNp5g/79pebFmt4nfkM1J2a68Hc9/a
    jS+m6oSyoO/xGjAdU9J1mt+1gCIqcECo+eKW7dcw+nWxJwu2jgoiSNfb7THefzGU
    D366bsVTIN9XjdFl2vayAIGXgEliv0T33/sStRAVLTRyZ5PhopHvqz0baJ4MezUi
    9AA8S2TUlk/HuN2+4UKyP4OHMtDN0FK3AC0lwveNRlDN3EufPqpH/GLCUFkS1A3j
    AUxJpftePUhFHEWYc6zSOYYNrYEac6RWC5wWYULVTNqcAYl8aycJa4dk/vG4Ydk4
    4zr3g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=pr6udMrL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=pr6udMrL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v6 5/6] staging: fsl-dpaa2/ethsw: Add README
Date: Wed, 14 Mar 2018 10:55:57 -0500
Message-Id: <20180314155558.6898-6-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 61b41b4d-51e0-422b-25d9-08d589c428e9
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:tKvQGnmpub26bnGK44UyxgRwnK5IaWwuEzyjw48rlMPRt07C6J8hmj2M5lBGH3zdgXbJiDOIrB/WTlUgZXTtX8PKZ88rbwNcrtWfiyl6H8A6dDckl2pm05sGYNK2jixC7WSARFUpjoqcefEjQzBWmU/WDm1JP8j1DipS7YOI6O8STyRTTH9UXBv3HeOWZGlvw2IwWOK1qG3xI7AUOJ+q0W7DzKt5o0CdS5AQSvH31OMbic1dRyH/s5h2RXEjoTI8;
 25:sO02/VO75BvPsPhMYiTJyIROZ5xa30IRDbZZX3bBm0SkkCuiAy5Lb7A6zIInJLIP6OAG2smRGdlkw5d9dLxf/TrAJeXjbCosM0h6qsbfVcSqTrNeJNTovs+nX4Y/g5yqwUDnweiCI3FD3h5OF9tZICm0d3s1kJ8uuU1GAhnNmnEXSCCvcNhr0ZfWKessCZAZb1P2KXN+GAbbjAAwqYK+IiTTFEt3zjIPAD52GHeV6+0OHQvWL0uZ4GxY1p3dnsMH6b7Zg2jrjVHmUrUJZaXquFPiaIO+rbpHPVR+CBUlyJnUfMeBsI0wzFsVWYT3c9MjO8leUg2TPxByZ7ntgTF1GQ==;
 31:7cQOJRS5FYMVKmtehhA7RKMv5Vp91X/pEcGURjLmqoXsbGFzIw9Pl59nYdx9km9jW87eM5eHA2b4nWfSKdZWXE9zCByoJFzlWBWYDtqCkbqEjeqxVxg+o/FM4OqDGir6Bwizw/FLVUcVW64EW3QkZwXmAkFn0QbKWtDYraz9UAjxxsDpgm4jsbFDHTBapl5HU9kwKEEHQP/G6U4jY+RgpZjhmCMuQdWqzRuxX/Dc5rY=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:L4613DW8hlbhPGuZ1JJqa4Jke39mLeWZq6HWYpBfdrRsKtknEN5r+WH7AUIOaU4qSmOIXs7MCa+2Y4fEQSu5VR5y5qUkcTlyw8oOr3KCwD/ZTrfwZfqrSBUYYx8rqRckG6apxKgHzWp61WY9eknf6gaewV/9DFKqfFhbknlR7Uf2JCvSveBKM+PES+ZXekyjGD2hf4I2880Rvrsj7PbPUfJqZL87e4XAfPJbCgIobWc2fOA1OwcAvrxnKr6+FbNEGEdZCODbaRkMv6FpcYXdqUpznqG7NkSai/YpMIeGW7cVMd+o1qB9lZYTjNhSDCa3BRFEEdldsHU2e4FgZ/dnSu/rOg90dc75NdPRhUKLe4E+WVBGbV5RVLGlkkYttxMvU6NVPfPcuXj4UWdTsDuLZ05tJvXzH0jkHWoPzcki13lFheRTalrwifxtAivBraj9qcQiPxyUOncJAyOlCxT3sNdlcgekM6IOcQTV3y82KD4QjVn4qUw5uZIpJgaNjsc+;
 4:9BrZQVr5fsTbyGjJ9+1dS+dohVdY5fx71uf3RcHHGYVB/vSn7eZISTujg6I+VwoakyTb1vRS6yiL7J+fFivV8DS5BbjLU+eTnojzIFdidRFeNIePl8AeSuBTPWjcfkJpKmZirLUoXnntlhAqwF0xTxI+U+0LI9ohM5x0M3+AAiaxLOvAPE+v+bKCHVU9bFOUj46yCcga1YYEn0bWzCSBUSCmhDJ6ZqnLHvnBQEH3F4LafUBhodPxNiJjpOczxkp+3dd9K9aCZPK9yDx+o36zoppOpAkJOTZ5xeZSrsJg09BZ6Wa1TgRnP9sLjO6V/exeWNLxMdNR8+FhFHxHg/QQCvqjFPrzyzJySZrq/3EcABM=
X-Microsoft-Antispam-PRVS: <DB3PR04MB0747717BD5AB4D9E74EBBC72E6D10@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(54534003)(199004)(189003)(6116002)(3846002)(16526019)(386003)(6916009)(186003)(76176011)(48376002)(1076002)(50466002)(478600001)(47776003)(6666003)(5660300001)(2906002)(26005)(305945005)(81156014)(66066001)(7736002)(8676002)(6506007)(81166006)(2950100002)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(6512007)(36756003)(68736007)(6486002)(106356001)(53936002)(51416003)(105586002)(97736004)(2361001)(4326008)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:wH0GML3s7Uh9TJNoJP71sghvz566dnhlXeq9qZ2Gs?=
 =?us-ascii?Q?5U7EpFAAv2cmY4cPQUyS12fumab/LN2GN0xpo54PFcRiVgi0ub9YG4CEkBQ8?=
 =?us-ascii?Q?5qUSjD71T0YWuhjX6cg59j7HZUxws2uDjmieueLy/SrPWAzDxpyKb5TgXfVG?=
 =?us-ascii?Q?UWbHHZMZLqlICFP59YgfecrKFzMD+2aY32SvjaQJ0+8hyE2nkCJFjQV7qfh/?=
 =?us-ascii?Q?78xnSewJi4afAn4CMgJhXjWUfFbVpiKvY3Ep7u+eRs90IcJdw305FW6ctmWw?=
 =?us-ascii?Q?MtHJn+DVnUBdDpdE2fNfI+MGfo+SoTr9BHy9vXUad1jrRyMFgi973fit6Hty?=
 =?us-ascii?Q?nOnMC1hEi3TQDrxq922xTgwSoArmoKJgpMFHTYyGUBswpl2St1ZiETW0hcLg?=
 =?us-ascii?Q?+JhH3JnUQhEHCre0A7zKMuVOV0Ig2lHN1E63bNYkL7c9EK6a8f7rIEZrpdWz?=
 =?us-ascii?Q?xiDUd48TocyX6TMmF8rWQeWFAsmVqfzvRKvZkzsDm9bGWVS7aS/3kXOGGOZb?=
 =?us-ascii?Q?WV5noSLrcKMuz7GMjhwuv9DjjRuG52rIqUD02FPLd4zQ4nGHh+Tc/Ym8OObp?=
 =?us-ascii?Q?y0OFCyAEDzWaGCjKGdqtZqH+X0Zcts0nhTtaIKy8ISrosj7fb2Y5VPGWXuk1?=
 =?us-ascii?Q?svID2/GFAk5+AypbwK+pyS4J5mFwghKcFhL/r1X8ebEPfqMXcHnf5u7I+gj7?=
 =?us-ascii?Q?MaqoWLEP6takvTTG5uKDE8U4YRgWZE+OQRlAcjqmomSf5TuHd97iBPpDpFKF?=
 =?us-ascii?Q?EtuIgfW20PmKI8EhPFfojEee0ZaQE5ODLhPUcZY1TORsJXEQ2qyTTKOZ+1Eq?=
 =?us-ascii?Q?N4K8K3Ugo1sNVBFPFJRa5aZczDaaDlvL2+Z7f/sBa3QmSlBkfIgkaiBNXT2Y?=
 =?us-ascii?Q?I0Vc0Yim7t/NDEsjU/qWAqBafDGNWeD9qO6PamQhqdqr8l52KUvdJGicEa/l?=
 =?us-ascii?Q?9W5Xm/U+fR7dOFLrDT+/VsU5hb8hJ0kCAkJG41p8ZuBnbBVrk+OtTL6pqQ7Z?=
 =?us-ascii?Q?gavM4naAW2ALOrUiVexA3GyZoXF8QPc/PyWFeO+ZcayrVFMKIYt/xPSCFzQO?=
 =?us-ascii?Q?ybzrGnw3pFvYtoLPlVSJRcZ7uljstAVKSgsRhlhS0E+dKxfl+1zgaDJM24Cp?=
 =?us-ascii?Q?s/qC3FGBPOMM/ATP5r1HI94fn7g27frxHr8FEZ47LjIkm0EcXR+tvpTO9sdz?=
 =?us-ascii?Q?ARFB30YR1mJwJe/aOCtgtolk94ioarPY7T6?=
X-Microsoft-Antispam-Message-Info: osFve/DBeSKkUwanD8R+hYENmX8XCr7+jFWU1EvrrsaVdQtlmFPZYkPnN2UqH9j1fHDb5HQfocHbgI3hZHlsnC7F/0sJmOOPOdxn9ULi741Owc+b9dL9HtZvVKWAn/dpVmqm5BsBH7CX34Flf3Uf04oWCZ66fUvwhfD12sZ8uY4YgMfGKFWkbImmEtnqXrO0
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:zu8Y7Gis2s13ypQENsWMi/Ih8mb7Y4KO9j/dtzk7Z5Kn36RZspO1mmj/RaGi2uPr1zbKIWpY+l1KO46Nj/MaE7JNS2zDMepVL1Cl115JI0r+q+OZ0RhgY7EisP9mDBex7c8f/sAaZ68d1zYDQCguvP1bfyvIRsOVCO3ATp1xUtXcNOHQ4H5PoQkPx1A17GpzyISzxNk1H3EVJgjKyP9Y7KCzs2Sr+EHOMkUq1YGkrrP80X2f24x8iLzkAiS9aro/S8Xtt1YKqIQW8TBDC6pp6RXblA+t5jhpsZGH6A5VpvknfOjVL8WpH9Id7h2tcYTAkMvNAbhr+b6hdNpPmCV0N5MtTjSl/QjMMHNk+Z9vfcQ=;
 5:py0OMRPfnklH1jZPRfuKvsrdY1P5TGVfRRjwo95+AVqYiZNlBjXpRXl4CZ7I/0kzLeNaxOLKPb1tsfpVsXu7JO8vqOVfdvRDSbnjW6obVflFl1GkntLlNE9oVjxc2UfQ/GK76HZGKvPSg5VBfmoK962qZyNgDKesY9exS0nQdDg=;
 24:Qhuu5qMWGmwh7B+eGqzC4NbgwIKBnfKqEcUWMorUgNE5lZaB2L/rmwEAoQEjR/wSr/LbhGZ0kvsQh1RtuvMsqFXglLynUeeRMcDaEvm5EyY=;
 7:AfbvWhy/1WIK0xontWzqwWgQygTUMStlK9LHI6DMoWkThV0GOYiWbXW+H4pXAcEQlLlVMd5RxTKN+5cIK3d4rilxeBd3VDYsttTRHjPTBsZeHOqRYrrKd4ut+uHRfI9t/Hr3Ex6RAQH01j8+km2M6maIFsi5W3FxQK3QCfRHN7LQc8nDfkjc+8vl6zo/hIe8FczlJiQHT5zAdsSjeSTvBM+EHDp/Xq1OhSrEWNltuQBprs7/jXoWLH2W1lzgn5wB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:56:30.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b41b4d-51e0-422b-25d9-08d589c428e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR04MB0747
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
Cc: devel@driverdev.osuosl.org, arnd@arndb.de, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org, agraf@suse.de,
 stuyoder@gmail.com, ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a README file describing the driver architecture, components and
interfaces.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - no changes
 v5:
    - no changes
 v6:
    - no changes

 drivers/staging/fsl-dpaa2/ethsw/README | 106 +++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/README

diff --git a/drivers/staging/fsl-dpaa2/ethsw/README b/drivers/staging/fsl-dpaa2/ethsw/README
new file mode 100644
index 0000000..f6fc07f
--- /dev/null
+++ b/drivers/staging/fsl-dpaa2/ethsw/README
@@ -0,0 +1,106 @@
+DPAA2 Ethernet Switch driver
+============================
+
+This file provides documentation for the DPAA2 Ethernet Switch driver
+
+
+Contents
+========
+	Supported Platforms
+	Architecture Overview
+	Creating an Ethernet Switch
+	Features
+
+
+	Supported Platforms
+===================
+This driver provides networking support for Freescale LS2085A, LS2088A
+DPAA2 SoCs.
+
+
+Architecture Overview
+=====================
+The Ethernet Switch in the DPAA2 architecture consists of several hardware
+resources that provide the functionality. These are allocated and
+configured via the Management Complex (MC) portals. MC abstracts most of
+these resources as DPAA2 objects and exposes ABIs through which they can
+be configured and controlled.
+
+For a more detailed description of the DPAA2 architecture and its object
+abstractions see:
+	drivers/staging/fsl-mc/README.txt
+
+The Ethernet Switch is built on top of a Datapath Switch (DPSW) object.
+
+Configuration interface:
+
+          ---------------------
+         | DPAA2 Switch driver |
+          ---------------------
+                   .
+                   .
+              ----------
+             | DPSW API |
+              ----------
+                   .           software
+ ================= . ==============
+                   .           hardware
+          ---------------------
+         | MC hardware portals |
+          ---------------------
+                   .
+                   .
+                 ------
+                | DPSW |
+                 ------
+
+Driver uses the switch device driver model and exposes each switch port as
+a network interface, which can be included in a bridge. Traffic switched
+between ports is offloaded into the hardware. Exposed network interfaces
+are not used for I/O, they are used just for configuration. This
+limitation is going to be addressed in the future.
+
+The DPSW can have ports connected to DPNIs or to PHYs via DPMACs.
+
+
+ [ethA]     [ethB]     [ethC]     [ethD]     [ethE]     [ethF]
+    :          :          :          :          :          :
+    :          :          :          :          :          :
+[eth drv]  [eth drv]  [                ethsw drv              ]
+    :          :          :          :          :          :        kernel
+========================================================================
+    :          :          :          :          :          :        hardware
+ [DPNI]      [DPNI]     [============= DPSW =================]
+    |          |          |          |          |          |
+    |           ----------           |       [DPMAC]    [DPMAC]
+     -------------------------------            |          |
+                                                |          |
+                                              [PHY]      [PHY]
+
+For a more detailed description of the Ethernet switch device driver model
+see:
+	Documentation/networking/switchdev.txt
+
+Creating an Ethernet Switch
+===========================
+A device is created for the switch objects probed on the MC bus. Each DPSW
+has a number of properties which determine the configuration options and
+associated hardware resources.
+
+A DPSW object (and the other DPAA2 objects needed for a DPAA2 switch) can
+be added to a container on the MC bus in one of two ways: statically,
+through a Datapath Layout Binary file (DPL) that is parsed by MC at boot
+time; or created dynamically at runtime, via the DPAA2 objects APIs.
+
+Features
+========
+Driver configures DPSW to perform hardware switching offload of
+unicast/multicast/broadcast (VLAN tagged or untagged) traffic between its
+ports.
+
+It allows configuration of hardware learning, flooding, multicast groups,
+port VLAN configuration and STP state.
+
+Static entries can be added/removed from the FDB.
+
+Hardware statistics for each port are provided through ethtool -S option.
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
