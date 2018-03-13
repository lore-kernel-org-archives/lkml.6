Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3262519-1520949144-2-7203730346725087268
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
    t=1520949143; b=nj2cyASTnsLW6yp9kvXHAfRA0XSsiyn7AMEg9g2k5K7xRWH
    CrAv+rk0GbtmKNDqQ5FxAVxO1+0BxFAwMBm0f0Lcka9zHSHdG2BxUTNbbP2MEqXt
    OPoy062Gr//h1Xz9qwIaUPUuOzV4v5YDsemcZKnUbe7NlQtqYUQEFknek/D6G+iw
    i7g4zLJsG4+B+IG37TO9g9G5fnmSC3CTL2EeSJm9xqW6FsNRVp9j3ufvkMxtiBGv
    9nl8rW7fFVH5nKrpx9FEU+/N/cQSUDay2xn+Ea3VwVYIznmi9tVs7E5bYzRMF9hX
    3p93Cm6fqHxf/R4a9IBFSN7eLR577OlSEvhqjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520949143; bh=R
    x9uDl+OpVV/v3plU72UFP8xoODg+icTdKLmkuM/cA0=; b=fhIWI+PKin/DnZuaX
    p4LDi/TYDtuDpp3sutEDf95jjQBNQq3M8V4xuywf3eiA0Nlhhsxhay0pve63SseX
    AExQr+7Wh11y4WZh0HM+H3qcd3bWW0lmOmrlHKrw3Lw8QXuvEKDf1An2puzm/nyF
    LR5Yr9teY3sgM1EewlC+Lm/LRUkQBR79Htoe76kz5w3T+w7U6bvOjZF4P62sjRpw
    YxGoT5+CqiFgythm7h0sUrcuCIfjn6TSwdq/Qs9VUJQZzfUBwiKQ6YZ00egNrQnj
    jy224hmPKL3alQbhXjv29vLStKVRU8+CguaxFsxBqHfhj8Ka0O+JXSCx+YKrzSEG
    c+Tkg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ncNw1pCb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=ncNw1pCb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v5 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Date: Tue, 13 Mar 2018 08:51:50 -0500
Message-Id: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM3PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:0:57::13) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d32936fd-8c96-406e-d5c0-08d588e99d6a
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:bkWYMNMOcReiI8eN+pT0gLDAfhGMs3kWceNCBoTgUvZlzmBVk1145vUJ2Nig/vx+1dY5w2EeNoTiVSYuWVQs7sdyF3b3t8i4gk3ZovedVVwVe7Kx5dFns4QSOZD1sOK3qQ9lQ2svsTW+xap8XhA8wqXZ8w0o7fiv0ta0wjv+oQeKAvHdCQHH+AK61I68aFrLFgbg2h12CDxJBhOB6zMFpRey9ef//e+5tp44kF81jjJb6IHhgjTZUpoViy9d9sqJ;
 25:CQMSWp4RfFI8WapGPeqVZ5JndSm77hRMJ/m/H37wBcrLDLNPKdYce3EtVeyR6J9KeyrRNNsxmKYFYk2AX5TO8hCM8R2sSd+BjPPx1nXCyz/EkL+iyeO20lbWBqFnhJIGh1vjIdnfb2qu7GEXwoO15qG8q8bubO18huj56XYOwU2A5I4Ihijjn+waRaINNz5X1GISj/v4EeVs7DnCFmeypSru3NkdYLhYFwF3gx7L7pcYAqmRnjqlqhBuEGWaGev+YnkdEcgKJGDZuQMgVvd7wqFIyWr8aSYHcA04yLxT6bGjjGWSv0cmjUrzp3y2IO9FFms88Mu6NZRTMJokYV4A1w==;
 31:WIwl/fbUaYdRmx4ist3JYUwRWcKAjbuMFeCv4OiR+TWUi7tEV4zGhJkjkIHKIextVuVOa+uRIdt2SJwtonI+SNTyPX2C0jc10Wgs5rxHl+mt7u7cutZJcCdHDXeuQfY87VEFCR/fcasx9DTPNJHvBc0lHVEOL7EOR2H3cTpMsZyrVsR0qYP3jo7BZRI6GeCcGKPMT26V/1+nkkAqRaA8vG88u7BViDEZTpqp69Ljd80=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:k6hqLRyCRb7K3co1Eyjxfxu+WD3w+SnvBVWAP3d6wjEPJBDkK8+fMQdvAJkQk2U0kvSRvneX9X4xoPL7EtHtS1czfRQ8FpAw9asKfQTQTfQPXIGQ79bH4m7AtaCMwrUGUVVwglFWHyAkpBb2i+NEmdar+Du14Ua/Yhf+VhGgD/kNLVP0VepAIrPosghvCfFSuMSBT4HyrEVCyNoun1pfR836UVXUCRrY4MQXGZsSaJDDN5whKqwf/pD9zOApoxX+7qYQ5urMSxpmTwXHmdETN7zOZSgEMT24zonFGEm4WPWEJ8zdDxiN8Dp/8khZ80Om74/hiu84XkEUJFAgdK5HDZHXaAwOGmUzINVzeTI0dUD2Sz67G7gy4B44sMtw7zY4ukwjd1w4Gho/4+dpw1L7sqg1EQq/SMkLG4idPI3hryS2fJnQAF4lBYO2hpNrO2tmTZZ2XZ60knrSAg0ClGWLxKG1xEQ6c+NYpdsCJsIFkowVlei/aY6xhryNSS6T2F7o;
 4:dJuknfBIRUPB/Dm6Ni11/txqjtKU2BFI2JNJjUmHACazjxvtGfigqay7BhyoYeS4k6pNS8yiCwTi08P8AMjjomlKx8vac7Jc+pA1UXBu7liFp+C90aSlH2ou8lQIw5fmN983oA2+eP5zXUl57gQC4uG4K+gxhQieLf9bJ4WXPyCwjnhvN6lxP4dTrMiosuvTcbDHefL/vM+U87Mve3I59vWWOcfr4SrJehtg7AY8GtXFtNJSdKFJLGu9IQx0snwcWD3r9ELC2VQTA6N0ZWjjdu/dx+YJlsA6NxQOmRijICUxDmBxqH/j3nCipuAZ3pYW
X-Microsoft-Antispam-PRVS: <DB3PR04MB074764C3A722B61D03096066E6D20@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(54534003)(189003)(199004)(1076002)(16526019)(186003)(6916009)(5660300001)(478600001)(50466002)(48376002)(3846002)(6116002)(8676002)(47776003)(6666003)(26005)(2906002)(7736002)(81156014)(66066001)(81166006)(6506007)(59450400001)(305945005)(386003)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(36756003)(51416003)(106356001)(68736007)(6486002)(53936002)(2351001)(2361001)(4326008)(6512007)(97736004)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:gPXo/b8BAch2OaEdapqOWFc5xiHj3S2D36HxUBxOi?=
 =?us-ascii?Q?O2UuhUFHnTJ/9WCjtE71ob2FrY9C9Bma9t8HVMAadZV3CSqrLRBJ7wCqonVc?=
 =?us-ascii?Q?IpuyyK7rsizw19y1yAGkV4BUVEQwFJxWTaQH+VEe0Lxu/G+c0V8nVoOLB1rr?=
 =?us-ascii?Q?FCYQF0jIFmrmND0GZt3mvmY9vJTLZClWFG5A4QJINlV9AYZj3VtD8juj2Kzv?=
 =?us-ascii?Q?NyCDoAbfm8VrcP0JcTQyVJT52Rs/KA4BgEmPJJm0lDBIz/Bb7z1PA6m4LLoQ?=
 =?us-ascii?Q?W/WRNlDqVa5eBT7QDaCKLBtUySstkd/M7WNYxvd6kotCOStTOOFrSHnUZaIW?=
 =?us-ascii?Q?gxAWx5LsslNQOhgUQuQkcMwFeYVG8uCrxBzSY8vDdVXFtEFP6Rl07CHdI2Wp?=
 =?us-ascii?Q?DIQtn5fR1TZ48YJbjUr26yIwxG0pz8kLQlPFjep1qc338+2zZ/nZbisRsjeL?=
 =?us-ascii?Q?vrINIs+ACSbf6UjNaaVvNsTUTQZivcjd1CfFBFnnVJtI6yHAit60FOvzoEH8?=
 =?us-ascii?Q?IGsPxI+lYQb1mDB4a+WwgwF4gankRZzrN6hIiXUueLsybeor8C0FFG4752qU?=
 =?us-ascii?Q?pKiArhv234jlPta2JhjDGxKdn8BovHir1KP245KXAN+b8W7LE1/69GRadzbn?=
 =?us-ascii?Q?LGRMe2wodcqIk09VlFMDRkbREA7tq4jt0w+4KYYHQgKcD+u+CsWQ+A/103GE?=
 =?us-ascii?Q?29x6x583oibTJfhBLNRLPyXaQQkYAhlRdtPobKGt/O4R8kyGhf+A77XB7e7q?=
 =?us-ascii?Q?e8fSOVRO3RD0rKJNANMg9yHIPWoEnwg06icl6l8bHFthTpLbEpb6e1fliwjO?=
 =?us-ascii?Q?9fGm+H3QfRqwb78QmwCavNSJltvjmgULVIltuFBoI9r5pEvbMRzlV9uFQBnr?=
 =?us-ascii?Q?AzNLji2TPyAHm+GfKR7kxWrgkfCqCR6Pzn7i3c8UzNvwI7yJ2EEIlkaffC6r?=
 =?us-ascii?Q?oAWs411vp7gwif0wOv1UHtazoO/pRC3HHJTxj3x90hWMRdKGFZvXEGpGyU1v?=
 =?us-ascii?Q?JEqTMsk3nChiiud6EyEt65hLZCD62TfGEgr1aaQPI3PAnOxZwvFIiiWbbH8k?=
 =?us-ascii?Q?9Nk/QyKJU83pjmWze9WDjqhMf+YqDDzc5yjLEKAD1dEMBVh/N0CphU+RvOPH?=
 =?us-ascii?Q?IkmIUOAImILXf5wvNXWDjUr0aMoBMzvKC/UU3Hdtpm39+MIEOMVCv7VhBq87?=
 =?us-ascii?Q?GiUFPIA9sFm2Gc=3D?=
X-Microsoft-Antispam-Message-Info: IcbxiMk1Gh5J12/AAdDhfT6tc8H70zuJGvUbBFmGN/ShwHQyT+lmVR9nWbMKtn1lxK0tEgECsCqTaZXRfxZIO30Uw7Op47PQHzYelny4JoNPXn7X9GjVE8AfpDvu+nI9uJ6kVgR8qf8odgluZbTHsnHJ98g8LoJ2B82cnGPZ2U4z8cCAEiF4PYFn9z1SAmcJ
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:RGZwwCEGgW1HjK6BWiN7qdsTniW/nT80vfg32QbTzs+AjjTJRgF8UoMfp9Glpkau1h90XaqnqY+wdcjT/aXIubeJR3wVjq4XETzQ+lG7dfFAUDF2ftYRKmw57OsLJAm7AS7tpXJ1GvvMBaDQmGxh8qPje8tg4eebP86tNj1v9pIupNA0sPmUQUJyEJuJgPU0gKYhCjcKaVKYjgOn80zF1O5+xYCsWHKByGRFM/bA9dRunS3mDvY5TLJq24KzpEkQPzfD97bLS85C/t8w1MG6VSNXWTl7iLB4ijyZOUGMUSTwdRfo/r1PKK2lJBEiAupOAo7ykNUH6/JUCl3dgA58OuryscjdMkOa2qmsl9NAmzk=;
 5:amyAHBIQIcq5ZxrkptcXAf0hpciwYbodr+KthZCV6xo9VrreXcmFlQbAHdIsUFTQZz35fQZI8tHKDNQevn1cJF5tygMrXek4iLg4852udWXAwFk7nwt4ZI+uWKshBhPLk7wOj9dqQnS17cm1iWRn994ti80Y9IbE5A/EN0UczJ8=;
 24:ZfieQ2/uWHxOHME7lRdDEO29CndbNyos+/9/UjElP40sPiX2vTkkD/sEtbSuiHNCL3CqJ6myhBtgmD2c0GcZQFDBwImrrlc1UMOZW1MrAr8=;
 7:P71B5s7uH4nPtF4YuY4M99oosKTu54EJ5YYsA5w4C6JrOkAYi03CxdgGzeNwRrJIknpvm2feokunUgPCW+sgMV6RmL00xfWEdiXMNZGXzb1JmEm9eNshNHPA1bn8CrjgPBMIESlXhMS+2e/xy9yQFFTJYkgVRrIEN65NHR5EsvaSmhf5S0/E271vxbiGYC56yaODn5X0oLR+uEBH1QMSHXibWdBICtjw7xEG9zWXqU/kdstDXPUnATnFM3QjauWu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:52:07.2574 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32936fd-8c96-406e-d5c0-08d588e99d6a
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

This patchset introduces the Ethernet Switch Driver for Freescale/NXP SoCs
with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
switch objects discovered on the fsl-mc bus. A description of the driver
can be found in the associated README file.

The patchset consists of:
* A set of libraries containing APIs for configuring and controlling
  Management Complex (MC) switch objects
* The DPAA2 Ethernet Switch driver
* Patch adding ethtool support

Limitations:
* no support for control traffic to/from CPU
* only DPSW ports can be added to a bridge

Changelog:
 v2: addressed comments from Bogdan P.

 v3: addressed comments from Andrew L. (patch 3/6 updated)

 v4: adjust to moving MC-bus out of staging
     support adding/deleting multicast entries to/from FDB
     avoid triggering console stack traces due to benign MC errors
     refactor TCI setting code to avoid code duplication
     fix sparse warning

 v5: addresed comments from Andrew L. (patch 2/6 updated)
     replace ethsw_irq0_handler() with NULL
     do not allow adding ports of the same switch to multiple bridges

Razvan Stefanescu (6):
  staging: fsl-dpaa2/ethsw: Add APIs for DPSW object
  staging: fsl-dpaa2/ethsw: Add Freescale DPAA2 Ethernet Switch driver
  staging: fsl-dpaa2/ethsw: Add ethtool support
  staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet Switch driver
  staging: fsl-dpaa2/ethsw: Add README
  staging: fsl-dpaa2/ethsw: Add TODO

 MAINTAINERS                                     |    6 +
 drivers/staging/fsl-dpaa2/Kconfig               |    8 +
 drivers/staging/fsl-dpaa2/Makefile              |    1 +
 drivers/staging/fsl-dpaa2/ethsw/Makefile        |    7 +
 drivers/staging/fsl-dpaa2/ethsw/README          |  106 ++
 drivers/staging/fsl-dpaa2/ethsw/TODO            |   13 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      |  371 ++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c          | 1148 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  611 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  206 +++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 1532 +++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h         |   91 ++
 12 files changed, 4100 insertions(+)
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/Makefile
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/README
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/TODO
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.h
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.c
 create mode 100644 drivers/staging/fsl-dpaa2/ethsw/ethsw.h

-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
