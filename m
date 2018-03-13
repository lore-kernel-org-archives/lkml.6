Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3223528-1520949150-2-9494360316348066174
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
    t=1520949149; b=mR8RNsS62zz+vYbZcs6HeGPgJ1QGQpM1WtCWpJJTBxIkqky
    2mDRSls26jG+27ZYRd471jOS1GLqQAQBrZhgQuwouzBPuBWmdklZnDajfT49GAML
    qNIYNpCOpCGa+zLewG3u2X5LRm58FPS/nL/gW57M/agR3/SMl9ncIp+oeZSimi0N
    TOEJDn2DFe4TvLgciC0Vjm/V0ITfHMWIoaFuawA+GQfwr/YRKtrf1HT+FUjmw9Tf
    PZzn2VaCloSALU8vPsVZkDcss3RbxcrIboZG+NkG9HXRQAc7AMgRE9Qqi/8Aw0se
    rhQAWV6ZXJImQMFPGHIhwZ7vM5dt/jk6GwH1//Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520949149; bh=G
    J2Z7MTliPvraJqzqGs9tZtYUuOmC3l3zUA+SSVyHEg=; b=FL2y1jE9BjFvMGdAI
    eCXDgReZ6dnyodfx3evDO4SBnASmfDTaXt3n/elE/0E6aOC4TC48GCw3nkbEr/Zm
    l8GyMEGdn3kbvTahMIq2j6j1y0sGAb0soMcj0NHfK0zLYfVFyjgXwzrIpjvZy3cL
    W9VH/qQHtOjkMPLOW1icygBSFe3cnewj1mEzxPqZmxBAYM+Mwy4Rx4xzUEKqQBzI
    rrcieT0eBFv7AIhTi+SBHljv9QaS9zTaDxkWZ/ZMs3G4pXz5Y8N98rnLyOzEf/dP
    M/t/YCrKB7twlFShmTDUW/QdisSopKm/4CSyhD3f5S/5z3PjT4VjI21EyhpsIKKJ
    eV9ng==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=m9CXfpL1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=m9CXfpL1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH v5 4/6] staging: fsl-dpaa2/ethsw: Add maintainer for Ethernet
 Switch driver
Date: Tue, 13 Mar 2018 08:51:54 -0500
Message-Id: <20180313135156.3322-5-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM3PR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:0:57::13) To DB3PR04MB0747.eurprd04.prod.outlook.com
 (2a01:111:e400:9440::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3483b2d-c516-493e-bf90-08d588e9a37f
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:DB3PR04MB0747;
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 3:cX4AWBleOoK+ybeZ7hcbES9WAMgBPEjEM8CJ6ZjBIFMgsIC2uqHsfbFXf5nAjVH+GMGnW+2U0VOPSl73PLoYUTboe6NPZiqa58swEbpgAPLopxI8wHgMSracol6tVHHZ9J4UGUHtwk4bc94GP3yUE41smifma1kYCBdNgy4WCc+7ulVy6w+KirmKjr6G7N77Jsopn2TbPTbPFvKZie3QO3jK5lrHyTRvrLkgn4k/+X5q1OnVj/sbc/297d3+7MIB;
 25:0tpk0qrzy3ftbEG6zq4xjzpw5gd1P0LwSxxbrf1t4qAvYIqc/hIEBpSRZkXvTj5dBhLZBZW4VKBEe0Wr7dE8/88deHtWO+C9er+0/We9nYq4CEqNqPkhoLQcQQobjigpEX/TqSM++xpnTTkdSpUhmmp7qZB4CHxYfkIRvWHLHqoiU0LCtqtBAf9rCeDglreQqs/3rrFJrvvpaYqEEadpY4H0Zrcb6dCIrLYhSw8cuvowe44sV/5vCy2CLZSHJmbUftlRz0lisEnC7xHpv1EkRABMGBvh5+EvcGJzVBS/1VplToWfWgpo0NIwAKM09ohDlP49Q27A3hxxYta98c+fvA==;
 31:vT0PYGTX6IexzovNRfR2pzhTJf1lbcpyYUqT49bnMY0DGV9TORt0BoQycg1aTkYkdq1J3JBLmUYwfZMv5vJLowync3uurgm5sl5jEcjEqW5itNWMTXmvR+QJ6PvdezXlzj3MST5B6QNeTP45+7ohRDFWSJGZMHh7t//C1V0jAIw7at1r+sILOEn2pPZYvYh7DIKbmUflx5CUgKq5RJDiMqBzlpndYpHsbYu7sUajJ6c=
X-MS-TrafficTypeDiagnostic: DB3PR04MB0747:
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 20:5KizSNovSrvKXpYY1wOGV0KlkKY4Njm76TRj2a1+HEeYCsGlmrJCRou67AbLZFYoQxrVr2fWYIjZUJxNFpzsPj459jfy3Msbelf3Mmq5ZDYO4QkF2edr8BbC59HSGIBSXJs2Akt2FpPFW2Vrj4Aljv7joWKjhDmEQpZWKJ4oPDLoe3bJsH/xlG0JfflaAriWQ/O4d9Oidymf7rO446Vi++0gZH2/KqQt3ghFM42i/nDUIj50mg/TxCQf9JIGjFLB/h5fVEk8OMyM78+NC09ANXQkTMsWFgMhmu9gOQCJA7DQGmKkAvL8y7efUGI0r7Wkp636JUeBnyVVous6//Q26WAcCXysIzwzn+7d++sjA9KSDXV9VCMITkkz1+Nmdt/gFqoj5YNPuWKf4+DMz3fB8snwzn6AUgu3qugCgxpkNAwZFtJP5Sx4cgtis1RY+8klkDpZWFt2Qi+jmgGoFHmUrrgNQzfj2hVml9dtoorT1hlAYGgg6BPSLJE1rT/pJ3Vy;
 4:1982e+lRJJLQ1pCaS6Ql5U6M8msevxyhnX/xtYmoEmcRM1odkLW1khwy7Q4zjMlZSIvJCKTcl8U9sxjGNli3WL20x9FIObdpejDSZmWOwX+H5D0Hyn0P7/AcAbDgz9OPjC2JNzcgZoVm/HEJLUYrjcyVGHkf/IcBgyvkOo5JHDhlo3lbHLNdCs+7Oc1tCTWufCnIq8m4O9GxMTw2s9nzyu6kBeJvj+wkQvEaOq4vh5ibTUW+iIJjXN1JKXW9dwCgASLz7q+DoRBehJ5gtmavY3aEzcTyQkwy/dCzljuYag/qUs/6keeMnQYQEOtErJ8jV+6bEtVQS6rSWnlO16aOUw6YFPZcC6IQVMCkPXPM+wY=
X-Microsoft-Antispam-PRVS: <DB3PR04MB0747511D5EBA4207B479D4ACE6D20@DB3PR04MB0747.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:DB3PR04MB0747; BCL:0; PCL:0; RULEID:; SRVR:DB3PR04MB0747;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(54534003)(189003)(199004)(1076002)(16526019)(186003)(6916009)(5660300001)(478600001)(50466002)(48376002)(3846002)(6116002)(8676002)(47776003)(6666003)(26005)(2906002)(7736002)(81156014)(2950100002)(66066001)(81166006)(6506007)(305945005)(76176011)(386003)(25786009)(50226002)(52116002)(86362001)(8936002)(316002)(16586007)(39060400002)(36756003)(51416003)(106356001)(68736007)(6486002)(53936002)(2351001)(2361001)(4326008)(6512007)(97736004)(105586002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB3PR04MB0747; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR04MB0747;
 23:n/2PTwBjSVZsmcS2hoCagmS52IIxDoWJTRfM1bTi6?=
 =?us-ascii?Q?xBjvcpbhgAqX6nzYcRg60xKdvi/k0ko/bGi/2SCQR/xrLmPDKSdJUR7miGRK?=
 =?us-ascii?Q?WWI0YB9o+zY1wqw9O6PjQ/ej8F/fTAnQGZ57iWeLH1eLiViPgeJM6t0V4NE2?=
 =?us-ascii?Q?YqUWs3Xi9k2CJGyUqjfw3Lxhuq6T3w7qqV34Db4fxaYKPO6lSXINrU83Ify4?=
 =?us-ascii?Q?zCe4/oLH2hEqNJaldTvLT2pZH8uMywokmE3zDocOjVnV0flh6n5POJ1ZY3NM?=
 =?us-ascii?Q?m0yfHQ7VIXeOrnMv6oexrAVcHalyU8P6l2KnrsNeGx8IDpT/ChjssOIllqhY?=
 =?us-ascii?Q?BQWunVS1SONwwztELRJf/u+hstVPDywwd3x8SZRmvnb/3DlVVyU2MFqZm44L?=
 =?us-ascii?Q?aXBGqvvPz2jNEL3aG3DnZvOXMTReCbyk0cz//bllui5hc3V6tJcow3bLpS6L?=
 =?us-ascii?Q?VTqqAFHIoW5IVDozmFikzS0wu1FZscwSQM1qD0CRPdYg2O2lJfIHLhv273Q6?=
 =?us-ascii?Q?0nTf4txNUtbzIeW4X9vdbSapsz+EozMrZQxY0tFe0MjKYknEFIuYy2CT/agS?=
 =?us-ascii?Q?2O1LYU3MLhkl5ZNii4qI87mYyTPYDsV6fYuwX47NgMSpP4Zd/7NEs0IQdq+Z?=
 =?us-ascii?Q?kC68RHiC/jH08668rBI5lQEMMjUUTnSjey9A+CbqoHv94IkGvCdOCHyh/c/A?=
 =?us-ascii?Q?Hj2HH778Jp3hnB972n255pxJ/OA9X4Zb7QaQhWQU0zHttPLp8rZBH8uqecJL?=
 =?us-ascii?Q?cAaES3Mq/sRV7S0lzz5tQQysm6cSEk4znfN+PcQ761aYWXJup39VpiuXbBl2?=
 =?us-ascii?Q?xuclibBm3bEcAVQviBP6qC0GYZO2ctTwJTZCsnQ9NryCqWUTZMp2HNJiiFRv?=
 =?us-ascii?Q?0fHxUiHDnZZDW0TyEzpcnvYmVyp/GR2u0+D/wVYrCnxv+LL4Nd8nN/wFMLnq?=
 =?us-ascii?Q?QpkZySoDHLElXZOq3BmWa+Oh78mh5YWOW6fn8Bb03b1qOvdYL3ttknHd5+BK?=
 =?us-ascii?Q?UUbsLdrYUwCeGp0n3WylEObqOPCpO1dkJyCZyjaNp7dD9ryadyIgRBMBlJ59?=
 =?us-ascii?Q?VbzUxNedhKbGrVSTzlv/xXh43cN6J3wbeRxInkOl+2JkmAQXlsv0EC0qdOCV?=
 =?us-ascii?Q?QL0qYPlZ0W9imY+4MuAhTUknDKX1pkPPt+jhHkbCFrsMNJ8WCBGCtg+wXi1q?=
 =?us-ascii?Q?LTOb1JYNBs1H5Jkcyt7MQOtfATo5Ggv4jPT?=
X-Microsoft-Antispam-Message-Info: dVas/wJyJV3rUgjljCjgTchefvmzLCbNU1uDNXpDuGrFeuduwYBzOvifhmLhovBONg605F0C7a7Pe/Su7+A0Dkjb8iXzOa49QAkGhrIThxTXEbzWJw0YJcxKXV5rT+laUFRaTPDJsafq61KMA442tNgActAaK4XJswlku7onlpoHuUwRU7RnAWDRigHFMNnm
X-Microsoft-Exchange-Diagnostics: 1; DB3PR04MB0747;
 6:6k4xBGxLJEmF06CeVGAAgd4eBJnM4eTGFbL9kMQKphMWX3lEWl/9HARSY3DKIVUBKI0XgCbqo+zeYA39rry0hcs+/mfNG604NrliSJ7mzFG7Sze7QPiQIpmXcwRQdy5fLpc8VFNGOidFRnSg0G8fc20FV94z2E0315NQKqECXV9jMmDikG5MOA3CtXGZDVFpVaQocB0xHBQ/BKL7z2/G8p0PsNUi+obRCV7I3JHIfLkvLToyt6+K1s1F2Gc0joKfmBVbWmuDLax25KEgh/TuLyDmW4mOmC2L/GzCyv37zqeVDObosK/G47dQ4q5jzCnjjRfbMsoUzumwc0pEuqZj4TT0otzxfWvKQaUjZuLDjVo=;
 5:+NFxRGM6gpViwb3B9vUiLAkYQ2VzcjbtCTMPAOoBwJQuIUcpxyJzz2t8y1zbGkWsNMr5Frru1CdlObK36Nk/oNALGwYurZYjoF7fcSpikR8yrPYtUNVF9stGICPnTx5UTRXquakBBJMBE7/iNvnWWcIt2uGdXTBmTrJHZxbHRr8=;
 24:pi3tltCtK0mO2A1w/CFrPqo9ZBhhK2fu0v8k5LcDnjSMRhrYBulkf4lL2jqsQYRIzkSwxK7RgSzzRDlLhOeCeZct8+YfHRU4uuJYllpLDf0=;
 7:XBdYER4D0oOWc+x/1Z2N/ODyo1jPzzhWIkJ5BC8URIAL/cU80FZrVuyuTsyV9T2lAY9/arFQDhwXH8peCJ2T9+J28niqDgsYvqMi40rf6h5+VS2RsrSEk6gkTJujkNyyqJ3S9wfzE0PfFQ37ruZn4h6EloVQemiqRxIPz2v9NhJnFtrxfByGzM6agHNkRXCDzhIb25N662EKwWMaPnIYc/O41ccYmJmCHizcshskLv0OVXlgzR4BclDep2FhjTpw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 13:52:17.4764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3483b2d-c516-493e-bf90-08d588e9a37f
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

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog:
 v2:
    - no changes
 v3:
    - no changes
 v4:
    - no changes
 v55555:
    - no changes

 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3c2b75..20d7bf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4410,6 +4410,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/fsl-dpaa2/ethernet
 
+DPAA2 ETHERNET SWITCH DRIVER
+M:	Razvan Stefanescu <razvan.stefanescu@nxp.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/staging/fsl-dpaa2/ethsw
+
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@adaptec.com>
 L:	linux-scsi@vger.kernel.org
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
