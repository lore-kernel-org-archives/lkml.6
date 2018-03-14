Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2061918-1521042988-2-5358341158083803356
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
    t=1521042987; b=ANU0DiHzU27hsbh8AwLak33PFwB3Dp8M7duDMVA60cJAO4f
    +VI5/6ehFwqEKOwC+ub68Eyi5OUFbsAcNFxDrdiwlmykS6AgSEiZi+P6QXkRWm14
    F++HWoqojSN20mpbNBtam7RANYJy6uro3/ZzsSh+N1KNCRIijzmbsVkft/0BlqYI
    4HDkL+8YJ9r8rYxvtzpX715XYnCNIRxB3WDn1lRkIA4bOj0hPFq6v6NeAqmhosi1
    DbLD+/FLrjEJKirMN/vp8Vp6TBZf9CJ+IXd+gi+2GMt8JVakIls+ebQYS7WGeG9i
    vDoNsDbh1E90nttOZa+i+JF5+19TyWx6ZeMiXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521042987; bh=9
    ekoUavLuTovIqBUglUKw9qJqv2t+beQULmUCa/ofxA=; b=ph4G1vAC/wIW5QSwc
    wuXIRtNgqSNdcPJbjhcabQrdQk00hSwdIp8M8d2LOmgVDXISh+GBguBR6AYyAtiY
    9ZuTPtnXzKx1GHvjdnyMFjk4lu+pNIg41pQ6RKF1fV7sBfrcHyQVOjsMnzTOG6B0
    EQvggNSgYOqkcXFSiNlluG+9+MUwfYOUYr3FvtMp/eVABzhpooqXeladxahpAVi2
    z1oHDC65EQM2GqLUUr9/LBfuhfy4O4WsV1cJ8LzIDyGgb+Ki5bMQNnnkbnRilTkY
    BP9HYrqQDW93nvM7z0bQ+k36OsnHLcul7vgz3mDufFUXtQuSIS0jNfXc8Ovkf+S5
    n8i8g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=J4URyQaU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=J4URyQaU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Date: Wed, 14 Mar 2018 10:55:52 -0500
Message-Id: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e90c7455-43e5-4c5d-7ec9-08d589c41e2e
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:G1jSchA+DpZbUcw3mlVXfNHfdwxRRGe0AKkJV4pL+gkmzm8P+YW/ONoId6EW+PZeUvxfz47sNW5g9Mtki36zoL6zylaVDb7qNeTGV6MzKnA1w+zppDV8jI6OAmaETsBFpijq5x3sRrkbSZhI7f8OAQJzWc14jo/Yt4aukCDGEM3Mx4dgIe8vtU7m7ot3I6BNhJ/o0DMZrZMkwnFhkI9aPYdfA7+C7aJT/NyxIIpiXA9vow0lSH9XLzjvlkgxepYJ;
 25:Y7oxEhfS0GQ2cRNS2SElr/rX/bPCYOmhlq7tKw58fSQv0QTAkvc10e6GHYTKioNa90rLGaLYMMB9y9bY6Og4LwQKOe85A9XcxsafqZRiI2o1do0yUrKo7/zx289SWTuh+DGyNMf/a7Hqm/d+AFUsooOBSLfd8opZ+fmkzPMYjxJ79UMGyVYnYXXfc2pmBYg96i2zSe/TdcurCNOeBwKMrqVTpDkQxcHoOJUY8Y6jmWZ9CgEAvtuLc72+AEsB3LE/tAhdm7MSCDlHIQzJkexxPM9ke0X8Td0HL8YCYW7Thr6EwwvRW2V/dF2V1AO09Fr039LqdMpfgx+JNzLRUjJEMw==;
 31:ZCKkjMb7T+MiAbAdLf+zOysdMwuZV4jmZbr3CXjH7oMnKGjs4L1/rKcQ4osgHKVTIZ+emlR6BbsmTFu0A6WR8ubQJK4G38RJiNcEqo9ICwJxf/8MeqOiAdvdT45vV7U9Z28mK88Vl19l9SVkEc0i0AXTfMON+7XyZS6c327B5Apy6zW26SLJiSI3/eHTkrXIt+zMgvQo1Ntd60lpFvYMLlm7yLs6XcD63XOvh+K4qyY=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:Tv5F6XL+m6uZEOh+VE6tXGT8F/4srJkvcQhxywhpWN95WAi6EHPLETgXFHX9xdWMvj80MHTmu2IZzteGQpAf69aPWJnzZYB/P84LQkAJy/ocWBbLrc4jkv1QljQdg6b/M3D8aIgbvlpUNljZmPqb9EXjA5yiuFzsOx3HLljNwDJkkEsepYWVblZsU6UwZX87LQzfazX5Sl9LBWoQOSad/ra9oXpWkhGnhPsnHC9U4Tz0yKTWSUJm7qKPkU2JAmRWwfjOWBX1edqZRMadJN8ZDPh0zARMopE53qYLPBg0JtEKCnoLuh2EBg01coTdecg32fLyp+os/6vmUgMCFFnBvJEmdA/e2YBitYwoIQpAcKW1NC4rd6EcJB6f9Z4YEdMsEOcCRTDKTzjce21TzzhVXSntfpF/xdSE26b0RlcPIIU5SnFAxf1G6D+oi8SOetVhfK89D5VQSQXx9skmlMH2XmUm5/q1EzfPBPejY6HBruqnthKI9Qulx3w5gydUvUye;
 4:+bDnwplcG5IQlKW40gxc18x+J25JBZGzrJ1GL1s8jyTQCei0xVf7dJixMWALn5Sn44/bsJaLK76WbJSslgyZZC7rddIk6TUzRBS0ZXarveYILSpvht873uuZeamO0HY7Me+t+9HsbQO+RvfEx6BrAg+tD8LNX4KvgsrENwuwoTGzbZ+HTeCIZ/BqgaUTKm1YhTbBHF5W2cFhH/pKou3r6h4qMJPrMTvHZYHLPsrP915bCP+/7mqmev1NfNLkryvXzCHtDLZRhMkkWCP5FpRYNjiFW1CPHvKMqQZ85tq2KA84b/aal+GPQXi1duGbAM55
X-Microsoft-Antispam-PRVS: <DB3PR04MB0747725813C1E8F8E9527A6DE6D10@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231221)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(54534003)(199004)(189003)(6116002)(3846002)(16526019)(386003)(6916009)(186003)(48376002)(1076002)(50466002)(478600001)(47776003)(6666003)(5660300001)(2906002)(26005)(305945005)(81156014)(66066001)(7736002)(8676002)(6506007)(59450400001)(81166006)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(6512007)(36756003)(68736007)(6486002)(106356001)(53936002)(51416003)(105586002)(97736004)(2361001)(4326008)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:0tx+y4EEv0t4dJBd806a1em4Ns15cALKGBOEQIza1?=
 =?us-ascii?Q?CRrf8EL8QikHe/2jLsjLR83z55ABSLjUfbNEJmxYt7gYyl6QeZDdv807IkIb?=
 =?us-ascii?Q?kuiT82/nlhHH1nn4zBnSvJoZ0w9+E7fqSMWcytJ2sJnNJBH1pnsE0ki5dZny?=
 =?us-ascii?Q?SDSGAFL+3q49U4ovu4IY3aM8z/MpuF72PzRo46rhOMe0yptbpfAIQZ3D9scZ?=
 =?us-ascii?Q?cPyNxVHdco5Y57MK16uxjsMAWbMX1nHK7dj5hcpW0FStJ3NguPKKUEdY2fN7?=
 =?us-ascii?Q?xNjYpMEe+47RVecQf1/ViBzCHxDPFzGiPlaRh226uV++WeGQWTBbsrDSllrP?=
 =?us-ascii?Q?82OCoU0vwDhQ4bOpc0HMFru87PhjEQyKr3XeCw8iRxE2ZKXrPBJqPoUF06xP?=
 =?us-ascii?Q?iPHBV54j6WtKwYiHdCDJNflmNKA4MqhkrL1Df5T8sdsmgxsOXKWMoLaLuutC?=
 =?us-ascii?Q?h6jIbV0SYVgL4VwKvL6GXXpYjl0y5eaxb4N20WvKC9M73UvG8wDECu2Cb+dl?=
 =?us-ascii?Q?voVQYa9xYGLsbilNQZbpDm3N0L8sss5ICsyntqto9x2d1wYV9u2o4NLzluvZ?=
 =?us-ascii?Q?a/ae2J422uVpuBw0D6TYSSs0/Da/SAU6t+dLt5/DvW9ViiEkz5xwsornT487?=
 =?us-ascii?Q?8IUQRUc3RAEvWbqtnS/cbRvr0fb5vEkI47MLc7P3/MnhntR6yVzS27l+RfQO?=
 =?us-ascii?Q?gNrniZugY43Hqu7Cub+NNYSxwMC5pQHExWANIXvIhgs9UaHbwwimtSFcJVMa?=
 =?us-ascii?Q?B7scxp6ejR2m9tHucU9eYT/whX6JaaCKsOvr3QX5VXQTfuA6g3aEmhOir2PW?=
 =?us-ascii?Q?E/8h+zssYqs2IPk2jYLYT4PgGC/96gbNGX/eLMmUBWEKaz60tUEjwNxBD29D?=
 =?us-ascii?Q?ydNJ5KlAWQy+sdpCv0PTm46fmP7SzdmOzGrA4SgC7h2dkmlSF7p+TekQwsNq?=
 =?us-ascii?Q?XYViMMsdXfXLlLpTPYaEy7z3AFFW171X/PRYXM1eCNCPtCNdpDMw1S9tDpmI?=
 =?us-ascii?Q?YEsORshhwh8Iv29e8d0ILPzLxdRKjybC2OqVvWOBUqonWPvIUyEdpyZs3Iog?=
 =?us-ascii?Q?A+Z1BKRV9D4/QzZkur6HaZ1TSxTvoBtp9BLo+17mYzpuGDGoXb5y6GLq41FC?=
 =?us-ascii?Q?8BpIrhEMocQYZFinOtH9zIzevcRtWEl4FJqjaPYRRf4HkXVgiwE9eBLCf+Fw?=
 =?us-ascii?Q?D0vogAZiZEiDoY=3D?=
X-Microsoft-Antispam-Message-Info: pdhKkxVni1TUvIDhn8zrzoLQ+hstmkpq62pjn7pQRIndyx6jptMtzOq+dXb6hMGuCbc4Uzn49IagC6/QXxwc2oWjav2LQdjUuzWgioYdpoHyrwLn+acNdtV372opW2036SEMJHxIPSYOzaKZ1d0f+EUBBv9/SoybFpe6y1mbXmmru1GxZTKAfS0vuhlBsIw/
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:A/mPvuYozr6Dn/rRUHwTLmWQJxw/b1qgnRLRKkoUxNTnCXUhyyQArELEuCsx7owpdVO6HxRSsrOxYMS3nPypMsHLaFOdiYWfE9rCNR3JsBg3ETDKr84+LRoFJx75Z0i+ibyjD/IaGCs44uyNnINgdZxcsZBNweNMc3essL/0V/x2pJuXxe8uIazoo9G9ry+jcGZZWYIM0yjFJYI+ywiRxjioA9ZERnSyBJiYEBlJ20Gy3NM7luL/uwuoKdGefTPm9zxGHALWC8qm3zi3TVvCbezoV3TO2YIj2cooGCOYchBiDg2EIa4MxdEhv4RxbA6mWRK5zNQTaqq6MuSFhz45TzjEOcjPCueSCUqBUsqYzgw=;
 5:yx9yHhV7Wl/BtDvIbMU7RENllLCcnNbLdCytPjO/OiGjVB8Z3EiiovU49PbyWceyceFLQG2fErOs8qGnzFKf7Sedq5J1T2Ea4dSiHmmxzLSRIyM8ddXC4e6hBeTIp27rze4DBkBy9npuLM99ZaxAeOVKSzwpY2e3O4rVWFM2UI8=;
 24:QIu/LM9itMQ3oxu3hfO39exWC/4vm7K1kUFvnI4RM93H0TCbbcGQiDBpmc69VZ79S4HZSJoPjs5Rs2tV+wSU7ZWK7qDI7GfpvjFTIdse+XU=;
 7:tZVkVnQJZmB6MXSS9kIe1mVZ7G2h9ygmVeN6yt0jPnjoev3PQ4GQAzG4w3//AhAP7DkU8ojHnuFGZ7ob9LCHhu/aaJDxi6GTkzMSkOMrY5ZvhT5UgFtkjXLi0ohQ5mv0QWwIbrn6yQmhjSkpA+8/LOTIOJefkMn8iW6UdtexZXr8NSqAowwypiyam4jNCBByckDkJ9YomtZCkwO2URnXvWUs4PQdMZUcVmtATSQrjXUkwLpSuz0pyESfrcwm9s/W
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 15:56:12.5126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e90c7455-43e5-4c5d-7ec9-08d589c41e2e
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

 v6: addressed comment from Andrew L. and Greg KH.
     add port partitioning in the TODO file
     replace licensing text with SPDX identifier

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
 drivers/staging/fsl-dpaa2/ethsw/Makefile        |   10 +
 drivers/staging/fsl-dpaa2/ethsw/README          |  106 ++
 drivers/staging/fsl-dpaa2/ethsw/TODO            |   14 +
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      |  346 ++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c          | 1123 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  586 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  182 +++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         | 1508 +++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h         |   67 +
 12 files changed, 3957 insertions(+)
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
