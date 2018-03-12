Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4009665-1520844648-2-15891234374916958362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520844647; b=pKhn9AK8+wb+P3atIKGe+nD3nn83k29ij6HwhH+5lufE1bD
    Uz8exDn7d4Z9YRc+cQyulhssbzK9xmhhUZaBfwWo4v93dpOz1yGFkLUCWd/7GoXH
    z3LT+25HKjQB3Ec+7w7+9uzUMDxEI3/e8CnIv9HHbctxX/Um4a8AkoUU3QQenFhN
    dk0by8nT1aXAl5FAkkOPBTQUM08rPZAQ6KNaf+QK3ljb3OW7LkOvzx2o7EEJ8H2e
    +Fj4o9BFblgLQuS+zrbs5m0DjixFA1BL0NYMtiWmpLn1FoqRWlxxi2MfpGGXEKMT
    vH/gYejbPXkA0+auHk3rRo0og4LWGNoNE1Y01Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520844647; bh=8
    n/f3SukrC477Yhxtgk8CyEeENAeLnJCUxFCkD5YPLo=; b=j4+txY5gqibXIW/tt
    OXydPnq+yi8LaiwXcBopr3wDG1IjpoHAoHb1e6R4Th7BzpY45YF2iCHEOdot8x7o
    m3NLcSkE+nWa6m6hkXgSKJTqWWLZef9cBAsu2cZvFT8UZi3qSZBaeghogD5HzOyV
    w/2F1i4uVDI4yDw/+fB2H4kr0ct0u16tkyiF/+ayn5ubAy5Mf9r4jyhZd7/9kuF1
    2nGjEOS6wJReondeD5QirgjdZjUv0cfLgByIuXKu7KYhL7BY5b4x5ZJ98+kLWhKy
    kFs1xMYxl7rnDv9W/fnwmZWNKEX7/f5ypxNG6XbPXEd6q0g9qusUqKYT6ACTj8lT
    eVvfA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=jEq+NPU4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=jEq+NPU4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v4 5/6] staging: fsl-dpaa2/ethsw: Add README
Date: Mon, 12 Mar 2018 03:49:54 -0500
Message-Id: <20180312084955.12686-6-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
References: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR19CA0022.namprd19.prod.outlook.com
 (2603:10b6:3:151::32) To AM3PR04MB0743.eurprd04.prod.outlook.com
 (2a01:111:e400:8839::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c573e49-f286-4fb7-e0e9-08d587f6496f
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0743;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 3:sCVrvnthp/ty+F7FYKZezhvu23FjWtAkqgSYR+ZQFnJKaq3HLJA112aY9J4fbob+hSkppDqWQkZ32dJMXaUTFBoUD04hDmaR2Hgett0CccAXvtOnJ1FF0+iU11ff1oVYliWDlucrfeOkGGQzo+St7ej8Vg5PH66x98LL/E3u9XFHwk2I363YNxJ9P3jt0v9uT+pjWGby/iRAoZRwhEv//uIz1dqI/9bTd4FDx74qde7l7Lhl9AWQF1O/47ovBx2/;
 25:5ivn5DfZfjTIpt8IJEOF7FKFWC0ilG/aqnAT6+8M3amcuEZxEPONfpnotYB/+8GnyZ+H0QS/J7hgNjJQXaL6fSkwnTj+vUhxIfC7yznbV1X3IkvcikCC//ORRjjfHgaA+iuJ6coDPJWHGXqH2J66J5qV+Flo8bSFsJMsj4crTGMhkAWTE30cRoJFw4cQK1W7Wt4c9F9mlepnl1GHht1qDZCggttTcZwsLpw/iyack9b7f+WtNtF7HOvYQvUjLtgwXLkapCvuYNq0B316SJeQie1iOP3P4WtN8PCAt6KRhyvVPz29PW4M5QurHWAcht2G+hiTsq0aDYIs5KQugcDXZQ==;
 31:UDWskqZbFczvHLYAWw6f91TDxMrzbmnSMA28wh7lFNu8nRnSABLvchSKDpG325gAk6TzXYj+a2cs+v/9Tsxe/LriIwEgfMFsYo7FSrEWxsDD4AqzB/jkqqz7HWCHtTfi60Q5C2LPsBJMD4QfTWu4Zx0rOuSTNSYMsIatbNve9nKfcnwUiPBq9nkkAgab9xuKv7DoxVs26DePxlRNOuvY/Gib2bKznzi509ixXmDTV+g=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0743:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 20:5sXA3Gh81/pw1dVqUPSHX10lsqYL9x3m37JzlG5RljMOneOK3KBAAUU+6hu+ARODrY1QTF6ZBGK+GfKmhZepSB9qgiMCkWyfcFIJMvfKUdqPtZW6b8duY8da08OIE84dL5+MMLxndoAxyoshN3Tgi0CcFER/JPo8msPkiVTfxXHmOwl5yJlbhm04V5q2oymdU4gRpXqB+HwoF1JHsF1nUcYEB6QBxhuq6T9BgmpC8YH9eUu3/3kqvKBP9N9wZv6sJBuKoRAzVRUiEdPPyTWPDvzWkrxEX1xrSP+qPOEs32aXWiDn2ZTM8JYQVyISmLBcQclxgRVTktB9gJs53pYUV5y9EgK7OT9lgmXf0Qw3Dkcf3DrmK8AQRO2YTtRaoP2MYXHwQkUs53BMxX5+ZrxHZ7i6SiJ/iI8O3U7ECFSeuSPmq+pXHUvOC0LTbNqepB3yZZ6sQUHZhMo0JlgeG+dVJRoOKJuWOlyuP3l/EF1AguCtROO98M1OgxbX6Cv6kHh1;
 4:9r8mjgZ7/UwHcdIAALFEe0KLd9V7ljN1cfrR+cEyFEn4LDExlrIX7imE3nFyOZYbCUlmymOD+qkuFAw+hXvyddSB/FWjunjKLkR2+fphRCsfVedbKOdTm4S/e+WzrtRLmWs9+8fcoRpysGO9vRVeep3KJuOMyDkTrhg+BrlsBsg13RAentYk0Vz//C5Y4XND669LmznMEv26MATdOPwNgIpGPeejs5Qbs1rZLraGbUdf5roNuZUPdojTnN323ANfLz6jo+jwH2X6/GmHxe+eQCSNphy2vL1kADX27/4ZXbffXktHzvVDqtre/p4wTfh9v/SF2qwx7mvc1/b7HcEDrw+SjVGyBbSG3mFFQ278AdU=
X-Microsoft-Antispam-PRVS: <AM3PR04MB0743E1D240D6D264011654C6E6D30@AM3PR04MB0743.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(227817650892897);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0743; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0743;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(346002)(39860400002)(366004)(39380400002)(376002)(199004)(189003)(54534003)(1076002)(47776003)(76176011)(52116002)(6512007)(36756003)(6486002)(39060400002)(66066001)(51416003)(386003)(6506007)(5660300001)(478600001)(26005)(4326008)(53936002)(48376002)(6116002)(3846002)(16586007)(2950100002)(6916009)(6666003)(105586002)(2361001)(2351001)(25786009)(8936002)(97736004)(106356001)(2906002)(81156014)(316002)(50226002)(81166006)(16526019)(50466002)(86362001)(68736007)(186003)(305945005)(7736002)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0743; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0743;
 23:HE2ZJuB56wttRIgd1xEwUcyQGkt+sWtgAeBL1iNSL?=
 =?us-ascii?Q?fIRucKyy6oEcTm7KhgXQ5vqPhlV8iNZec4PZIZa8wtaby29OpGrWm4qDda42?=
 =?us-ascii?Q?JvmEUx1NbLlQXrQh0+z0JIWHS1L+S9SXo4g4T6y6MtuUIPssObW0EwzLyXFi?=
 =?us-ascii?Q?DGMfEbkXjd8T/94NeFke9ZH2uahkKPj4TUV6+3prDtlp8kDBy8wwfrvxbWQO?=
 =?us-ascii?Q?cdMC/sdWc+A0UlOQjWBmKUSk/8/Lp+JXE6k3QFj3L1/bpoWPZ2Ola1PSEofZ?=
 =?us-ascii?Q?hyphT06fLRsNx8f57eA0/8yW9JJSH6Bzwk5PAYSzaRyFTRnWpkSNsHD0sm4p?=
 =?us-ascii?Q?+EshvCQ16YOWT9miU9jd277xUrcA5HFW73dHMDneL4Rx1Kt4oB78VSKsXzUB?=
 =?us-ascii?Q?//DfpLL7GJo37LqSK+5/dsC44OTEL4fcw6zQm8NH2nKwLqkh/QZ0lvSwvkYM?=
 =?us-ascii?Q?O8QTWOPEfZTHzsn7v5soIqMxapCTf9SsFRvH/inH8IpKXa812Su3c0my5Dgs?=
 =?us-ascii?Q?Y59VfpKHN1frFDdGydnZjNRpnVciOxUyppPZrMy78DrvvxVykw/wgU4a3mUx?=
 =?us-ascii?Q?B7Ox5CIBNeHMBU/55LYSpFwNKh4sWqPQSZ8X7WXnoNjUvakRrbI6X+VxOpVl?=
 =?us-ascii?Q?DvfXv7fi3NLLfU1gzXE9YNVcAY3pkXeouqb9jjyXmJRt7I7ecPDCIxD2bEfi?=
 =?us-ascii?Q?SZEwaTuPAR8WuS9QlvabJ7DsRUw9jzstt3GZH8AOA+mFVj9spKpKhzEVz0k1?=
 =?us-ascii?Q?hrTa+Nyu0ltivPerlmc9h2B/wPDOBfDdLs66Ce4aXRPvHWqIaQ6QlvlhN0zw?=
 =?us-ascii?Q?UQt9oZAEod7ohwf3jWnvKO27PvIOZZbhRzqvUXr6c2zOr+QUlG7Uy/jV2XfK?=
 =?us-ascii?Q?t6W6+ZWKwA4uE6XOWSmwQST/nc9Q9DKI4rmSc4BQCjWQHRLJY5vmYTSvztKf?=
 =?us-ascii?Q?k5uIPwK4Aix+FdNbA3wOfU+pgEmIhvwdPfxbBeEOS8/q7J0GnHd1EmmXbZ2S?=
 =?us-ascii?Q?qHtcJhXaA1fSKu3WGdqDb4KZ6vAB2mWATaVKELsjDAIAXSkKMd/HfCxBu9Oa?=
 =?us-ascii?Q?DRBc/j30kKYRQDfzroKa3wNTJEoyRfkdbE2PcrIKlDaL7OGWP71zIs1cENR7?=
 =?us-ascii?Q?2VfFWj+5FkqopNzjfI0VQ6yPkwx5FEptqID16HE2VQ1/SVecqSDmAu+HGnIn?=
 =?us-ascii?Q?LtRpBhPgsE0ZQ7Jh7e1fTyDn8SqiJnzXNxP?=
X-Microsoft-Antispam-Message-Info: EoTgrx7iJnduyf66tM3oKW7g4FJzEm38+luunoVb27MgYuLdeheRlrPi+GBaOx6Wbi2fSOhUdXCupTFgI/4laAs4muNEKh2iE7Ujxi89mg15VS/pSYRZu1IBqprW75nNq2Nzm9MAWlzy5PIQlRl07CYWMpEUwufOWhFiIfuLtgxD2uErCU5TmOd77fXCC6rP
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0743;
 6:iNrobngxkfQYXe+11655D7cj/tm7Ajxj+pRdOlmmdpvwhBxDmbsEwq/hcatiq8j08HdGe8pYIVFT8ozOIh4I/zRiPPD3kB2Mvd2o3GXJz//6HR9f3Vt3cZ3RWWgIG22EZT7yRps8Un8aoDmGuPqz8Uvv40bMObmus63crPLOQZHlkjgilyX9UHD8DVNXJYDRnhn9FahAeeKVIELKWxJkhttsvRAl60www68dvqtrKKsK01WU4uKf2u0DmOrEIq6uIq+v6OKGVlipRH7LPhgXqVqzvANx45c81+W3EK7yeJ9idWcpM1o5N7/KsPx7HQDY8jiH5hfHSlFQN5qMgCx1zSpfvRtucgFbCvqUW9GYb0o=;
 5:hsNrZtCTCLx9rMxEFlCgYzWq7IflSFyjELMrKZPRgPaCHnHWkWS4nz34GN1+dsFJ7873rXbM6dzc+A3DeT1aPA9II0yMi7ftzK0s8hkZE6uO0Y0whc3gqlbtEw742TAco9oFlO69d5wiiGyVomPDefihU1oLho4emM8+3CDCkzk=;
 24:MpD5uHlByO3asvt3W/tdLNxH0Mbbyw/YWjoiKWyG3aS17zdi/555vgoBaIZIVJKynm9psc6n1xs9V/YCvJRy29bY3HMAqF9iDO6iOXoc3YM=;
 7:tCnGMZMVHP/oWEL8KIDCrADfbnUpOfhzR/z/Tc/WLoMs6uC/n+k1hBiecqrSSbr+7B2qWyKShMG6pRqqwjn6rkXbCd46DRylKQd2+07CDKmI/bBNbyulHHWsNSeuRTnMmACQaUKK3GI2WnhYmX9m+oRxbVOxyOQD/+JHM7/HDxqY1kAstqSOhOFxrTdG50JoNRxGUf5K+ih+7dB7nogNAE322TagpNKcZ1Ds30fQ8StlmaL0SCqvclLaWBMpHj6V
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 08:50:18.4535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c573e49-f286-4fb7-e0e9-08d587f6496f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0743
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
