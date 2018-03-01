Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3507392-1519926506-2-11362978770571359798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519926505; b=AqC5vm4QSdzmP//x5e0laHOCDDmerlAyA+von88AlP7ohKA
    MEbbAcs+/s4SaSH0b9cOXaSUADfLOUvKwfdwdwIOiC2iZvnx+1UqC0WzzQe0YaJQ
    08K0jZ0O0LOGTVRtE2HxhSdjn0217pTqvxrfam6mkiXgn+f5zZ5bQmTUjIShUxhK
    ZnyowYDeyFbxda9lZfzPgsXK6qwKVKNaI4EZvcbWY9CmewE5UDGvAc9tx0gd+M83
    FmDoRWwevdFqomGst47SpjmxrAsAqMw6sgOh/pxnkdAeDxxa1ZVhgKMkGiUI06VY
    oRGR/Mfym5f5d05S8UdXF6XzIM+FVxClkjjJtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519926505; bh=O
    Qn4klWyVTASoZY3Q1vOjqDZGOmzZF/rbgw1PKwTSDc=; b=KPweCZIoUhf7gDqZq
    hsNuxi7XUWHLS9/4ZKCkIQyI9bf63BWhh/1pWUNxkg7C5nXbVCi4wRpduacAk9QA
    +CWuzAap9acRrfWQEqktCsecghm8rpIGPHDzfPQxcaO3u1OkmE7ttuyGDaccmYm5
    WN3Q8GdEEBbnPCSsW+ZP2k9K/+42zGzTzLc+1D6KTmFcPI0DcYPq7n0v6utIqrVp
    zFiUVqz26JCZS7vOWLWNtZUoXx6djnflySYjPkmHP+TxpuDQc8BvaRdAnmvDQnmm
    RWVSQ5Nt8AcwpCwBUtR0+MRaMvWnCdeRNlr7X5iL8B4EliQ1LmqCNfQ2Rk58YjAO
    JnmBg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=mgYUVIQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=mgYUVIQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
Date: Thu,  1 Mar 2018 11:47:11 -0600
Message-Id: <20180301174712.2660-3-bogdan.purcareata@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e1ecf3a-e5e2-4538-9226-08d57f9c8f6a
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3650;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 3:ipj9NXL3TsGnkRFMkercZO8aT3/VcSYJgEsDLcDJ5nkMi+Rxi/s3tAq//5jbcJqE5vmn04HCiNHC5xQQGiwY6h4nXdYBA4zoinge/jCO2jsnSDcNzmD4lKc7lxH7GBXKU7bsmPrIwYhqmz94BQjzmsCUb62cN98KKgaS5EODWTZ67nVFMRmZc0L7+P0MFlFJvZD9WEyRI6UaNikOx3UBnDqMTzEff2VGVHcpzhoIHxR08SJJ5t9TFzX8stfNoqRw;
 25:BAC3wphypY33lJDrGof6IVN5TJap4Bj1rODEUEazDTzoYm70FGudkjfWwH5f/XJDVQ3Ns4nPwcXnRxX80GwLR1aEv1f8v39RZ0R0rpU8KvjeYq1QZAZ6atJr9XljFVZ1o9m1c3vj223/VlFkUEs2pKHcvqAxRnN7910QOyVa4f1lDZU2YRgm6An0P2ykqB7BOQD0SJpQDufwRePU5FgEwXBTHvjAeLiX33PzrLbvjFkGo9yknJjgGFaDVWDw7gvk4rsiWjQ1jaMeMLVWX8WVd9v617VMlYuR97b5iUAnADcazPxg0eF7ds+q6LB/p2pKv1GLgXm+QXpiQwUWE8Kl5A==;
 31:VCGCDkl1jV5VG/WbtVEjjKUjwtJMuEEKQxLPKIZlDBeCWkGn883/hhjT2ScceOfuT9zGhzvZ6M2wOThnhqDgs1TZPwYj54G7adBBfWYRTdwmo5+hHpxO5WrLowJ/RCAZhj4C7wISrVCVh6E6j8/Tyu1IR16lZW/I6ff4eQfbfwBh0s9CzJvRNOq/U8mgQgy3kk5CflyuzaUIyT1SXozfGSu+QLUlf/GA93Y8LvNnf50=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3650:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 20:C4vBXx8k7djKPOFbRBaEbSDCc+0qEi6P7R9VDOlHxjYXwy5XW0cyp/NitpfveDC8CVa0nbSHE8BA6FMKnoOjf1OqJAenqRUj33ncXvpNLsWGbXIkQgHYbtVlKz78lD1zj72m7Ye0FTO5cJVVek1qtCqbcSp/37i4ubGwM4PVn2joDqJfbYGl5KNr7mLHyK14bixfRUQBy8Qu18/66UNtq1RRBkl9/Q+gHSR8/bWqXTK4yQ//WmWDgJytmFohdvhOD4fRG2FetzO6z0WS2sk3UyH80DfOaKmS4TEC03tQE+R+xyEFFBaLKbUzU1jbVHd32bWy4L6qCUE2zA/4iL18nvPXBdoWiYHrosKlkB8l+8/iaU8mQrr5CK2fvWmx4oVlZVFgAfOi2tJh336iSfxbKEza3k6YiMZiy7mxMZSO6aPChjN1rxuJrfMdxghEP/ie7Dije7XpRjcxkUMmUeG96KCRh8k03JjhOW8JvRKzfg5x7ltD9u58Dl0du2TQwCXG;
 4:+J2UF7Yzj8WLFQeUzIz2C6Pd4uBsYde90cP/ls13oXgdFmN40OcWdNM7ZZviS3RfPmBG1Ek48dR56cWM66+HdvUd8f09dRPeR1QW95p8crVRN9jAMW7/88A1jg9XNiMN0kmJmV1uiW2CU+hpqyb8jtg32gFSj8wSo5z5dtNXNG798QkMt5cG5o1piv6eIzI73TLgo+tlnLbWQ4qMwMBFzfxxwZccwmWQomQxf0TlpvyF1WklN5c/SqV+D75Ys75YRiz+Dhi1OGeHt82lIErJZ+D07ebIORzNbYoiDVu/Arjv64hgC0uBvvAce9AeHQYm
X-Microsoft-Antispam-PRVS: <AM0PR0402MB365020C8E67F50027E8B0280EAC60@AM0PR0402MB3650.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231220)(944501230)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3650; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3650;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(36756003)(16586007)(2906002)(6666003)(2950100002)(106356001)(316002)(6636002)(26005)(186003)(6116002)(16526019)(59450400001)(3846002)(25786009)(76176011)(51416003)(52116002)(6506007)(386003)(50466002)(48376002)(53936002)(5660300001)(478600001)(47776003)(6486002)(8936002)(1076002)(6512007)(86362001)(4326008)(305945005)(97736004)(68736007)(81156014)(50226002)(7736002)(105586002)(8676002)(81166006)(66066001)(39060400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3650; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3650;
 23:bS0HGkY8o6X1uwwvdTtxswclUFOOlK55IPXPE66?=
 =?us-ascii?Q?zEjiTsZV4zYTxp4IqTMig7JX0jhxvVbec/YCQPmLuyqHvHkGSxXM93a5BSgo?=
 =?us-ascii?Q?+qbv9tU6LpfAde1RMjDNGM6u/Mf6vBH0ghHoLm3vBi8tcVP63XbYwcR3e7jb?=
 =?us-ascii?Q?BDlmPGpsMpDqTmJnfvvtRh68lxYd/O6TnnnbZ5ZlI617zGZWNGn78u5DPRMf?=
 =?us-ascii?Q?fztDVWRjipIEUn/TTVeE2IKKJkm5dSH1cZ64OS1uQzFaHOA8vqr0+l0qr0a1?=
 =?us-ascii?Q?BWhfqM2DT3CiUShmU7neUCfXheAHBVR0iDd7rh01EuWudrsB0QSRaGLbJZCn?=
 =?us-ascii?Q?ZpnkczJ4MaBQnFth3ZpAhcfB3OBTPdchMgTpI0zLAOINVen8FVhPoMESaFTK?=
 =?us-ascii?Q?ewRcRxIFnrHvUb81CMOYfUKTnVuepgvULkQD+UX4iLTr01KcpHCqhGzgE2LT?=
 =?us-ascii?Q?pq1cKHTWNFwuC2CnP2oJ95+BUkYjRY5aD6OyFMeGA73hFjBruNKGEL3VCtbs?=
 =?us-ascii?Q?o9roEzXk5JF4gR3oDzkpIIYAs6+yCULca9PDRdZp/c+AVs8GW0OhvZLFY1D9?=
 =?us-ascii?Q?qVR071Ot7zoM17ccS14M37xsocZJDzdaeyPrU+6Z9xcazihNbd9gaw+fUZZg?=
 =?us-ascii?Q?qVL0mMU0SCWHn5YBAHqlSJ5qCvRIJpWRdKJVtqnmeKZA1i+TC+U4BqJQoav+?=
 =?us-ascii?Q?q7/uyIrUkphmPZv1IE0GhuXQmhWMJ9MeAGiEWS4vQYSAU6jg8k6MTUusdoE3?=
 =?us-ascii?Q?cVAK6wQlY0PJ5qhhZpalH8oDZ4mp9Axj4uJOHaf/4/pJiAVf//br24dYaGwq?=
 =?us-ascii?Q?/jrLvaCKVmNZut+oGA8MWiyVWJO0uoIqTWJpkqvEk/DXt+8m62f+oGAezBhM?=
 =?us-ascii?Q?ADmSxn182Z7xwoGIkHN4QC9B2WD0S3DmsiCTSbvj+Xhi5frY//1URTfeBgIV?=
 =?us-ascii?Q?UQvb7w+xCFqkoGV1DyCs8a4FdQSsS9ypUs7t8mj/7TmyfrWf3y8xGXJUsnBq?=
 =?us-ascii?Q?S44YDSIfd5CD52AisjI2ALtJDnqY/HbdRjrSu5uXCbwQhkTNCIov1A5sllOL?=
 =?us-ascii?Q?59cKuelBuRv9cbQd/3wBJ4Ysfmwoadf82n3ACdKq8RlBCRzfeP2pZhjegtjz?=
 =?us-ascii?Q?MUfBEekiC7BqLBftJckc8bWOSmKD6r0VjuxOhH+gXFIPYXWw541QN3g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3650;
 6:wt6eJO2Gqmh6HZ5o+3P786Ay+zRRPhBwgVSQUgUbFZ29oyqhfjaQ7Y9D0CT6QIm03hu4tRYSrS/wpP821E8fMTuItaoUk3TJeefEYr6UGYZxFQxMvenfm6v4b4XEV95V9/VD9sRFGNgjDSOZvQM972D+3O8ClQF+MytvSSP5mcUupkwEVYxRfA222LStdIaHhuGvuTrUn+PKkrjoKIIbsawtwZC+bspJgLjx1bxEXHcoLA5mHG98uomIGszFgRx7UaeoNa+N/hU2gVgvf6jL/iG3PkG5kSEOCJYfZXvJM3HZi1ZTHNupWTtzLGK74+et9WKdnsGsC2Pp219ojnXv5uKzu8Teie8PMJoVVdsRbe8=;
 5:g38V9nT7It5L44ZGBaI9zaNWi6q0I6cp2pDe/BUaoM4oCsIPvNVIEqqy7GYJT4x7Xq/V2RDTnF/accCMI6b/JcbEIEDlxuwsoaDZxN+FcDE4ojoF+Fvz2BZKrm4oq4Xlu7mU5iBk1T+wkHuzgONfgYDTFmqeSq7s6Y1zMlb4cxw=;
 24:2nsxTDhzk+NaScmennlqr17w/RWlBzvXM3QmhCNKbryxRgiJ8/94BujlxcpFjuHFg8vdSKXOmcMBkTY4wLwkia7YCtv+oE1BsCo+VLBY3Ww=;
 7:gwPL5DPjuZISh+uz4ehFCe+Q0mXYgSbC1BDu22JLsk/Dppg9sGk5v6uZBFfKCN00VklL+UNqiGdqBVW3kIUh+adeHueoT//xqIHG92WkBvp9Pu5UEYsTXD15ajY+dZNpd9ugrav/IxOr+I6O7hEvF/D+wDNYWlbtz9G/Nu/N3VRBv/MPUZCJKCLBFikgCJ8MuRPpIHufzcYgkwsABuFEbJeCe48dTTrHmIN/w7OxUJkXc7NbjeyNu0+MD7JeDYOc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 17:47:52.1326 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1ecf3a-e5e2-4538-9226-08d57f9c8f6a
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

Move the source files out of staging into their final locations:
- dpbp.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
- dpbp-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
  to the other internally used APIs
- dpbp.h gets merged into include/linux/fsl/mc.h, exposing the public
  API

Update references in the dpaa2-eth staging driver.

DPBP stands for Data Path Buffer Pool - you can read more about the
object in Documentation/networking/dpaa2/overview.rst

Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
---
 drivers/bus/fsl-mc/Makefile                       |  1 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c |  4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h               | 39 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h    |  2 +-
 drivers/staging/fsl-mc/bus/Makefile               |  3 +-
 drivers/staging/fsl-mc/bus/dpbp-cmd.h             | 44 -------------------
 drivers/staging/fsl-mc/include/dpbp.h             | 53 -----------------------
 include/linux/fsl/mc.h                            | 42 ++++++++++++++++++
 8 files changed, 86 insertions(+), 102 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h

diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 6a97f2c..da26e52 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
 mc-bus-driver-objs := fsl-mc-bus.o \
 		      mc-sys.o \
 		      mc-io.o \
+		      dpbp.o \
 		      dprc.o \
 		      dprc-driver.o \
 		      fsl-mc-allocator.o \
diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
similarity index 98%
rename from drivers/staging/fsl-mc/bus/dpbp.c
rename to drivers/bus/fsl-mc/dpbp.c
index 85735bb..31a360b 100644
--- a/drivers/staging/fsl-mc/bus/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -5,9 +5,9 @@
  */
 #include <linux/kernel.h>
 #include <linux/fsl/mc.h>
-#include "../include/dpbp.h"
+#include "linux/fsl/mc.h"
 
-#include "dpbp-cmd.h"
+#include "fsl-mc-private.h"
 
 /**
  * dpbp_open() - Open a control session for the specified object.
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index bed990c..4ef8d7e 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -379,6 +379,45 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  int *container_id);
 
+/*
+ * Data Path Buffer Pool (DPBP) API
+ */
+
+/* DPBP Version */
+#define DPBP_VER_MAJOR				3
+#define DPBP_VER_MINOR				2
+
+/* Command versioning */
+#define DPBP_CMD_BASE_VERSION			1
+#define DPBP_CMD_ID_OFFSET			4
+
+#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
+#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
+
+#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
+#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
+#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
+#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
+
+struct dpbp_cmd_open {
+	__le32 dpbp_id;
+};
+
+#define DPBP_ENABLE			0x1
+
+struct dpbp_rsp_get_attributes {
+	/* response word 0 */
+	__le16 pad;
+	__le16 bpid;
+	__le32 id;
+	/* response word 1 */
+	__le16 version_major;
+	__le16 version_minor;
+};
+
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index e577410..ce864ee 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -35,10 +35,10 @@
 
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/fsl/mc.h>
 
 #include "../../fsl-mc/include/dpaa2-io.h"
 #include "../../fsl-mc/include/dpaa2-fd.h"
-#include "../../fsl-mc/include/dpbp.h"
 #include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
 #include "dpni-cmd.h"
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index b67889e..ea6479f 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -4,8 +4,7 @@
 #
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
-obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
-			    dpcon.o
+obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
 
 # MC DPIO driver
 obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
deleted file mode 100644
index 3340021..0000000
--- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef _FSL_DPBP_CMD_H
-#define _FSL_DPBP_CMD_H
-
-/* DPBP Version */
-#define DPBP_VER_MAJOR				3
-#define DPBP_VER_MINOR				2
-
-/* Command versioning */
-#define DPBP_CMD_BASE_VERSION			1
-#define DPBP_CMD_ID_OFFSET			4
-
-#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
-#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
-
-#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
-#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
-#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
-#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
-
-struct dpbp_cmd_open {
-	__le32 dpbp_id;
-};
-
-#define DPBP_ENABLE			0x1
-
-struct dpbp_rsp_get_attributes {
-	/* response word 0 */
-	__le16 pad;
-	__le16 bpid;
-	__le32 id;
-	/* response word 1 */
-	__le16 version_major;
-	__le16 version_minor;
-};
-
-#endif /* _FSL_DPBP_CMD_H */
diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
deleted file mode 100644
index 7b9f7ad..0000000
--- a/drivers/staging/fsl-mc/include/dpbp.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- *
- */
-#ifndef __FSL_DPBP_H
-#define __FSL_DPBP_H
-
-/*
- * Data Path Buffer Pool API
- * Contains initialization APIs and runtime control APIs for DPBP
- */
-
-struct fsl_mc_io;
-
-int dpbp_open(struct fsl_mc_io *mc_io,
-	      u32 cmd_flags,
-	      int dpbp_id,
-	      u16 *token);
-
-int dpbp_close(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token);
-
-int dpbp_enable(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token);
-
-int dpbp_disable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token);
-
-int dpbp_reset(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token);
-
-/**
- * struct dpbp_attr - Structure representing DPBP attributes
- * @id:		DPBP object ID
- * @bpid:	Hardware buffer pool ID; should be used as an argument in
- *		acquire/release operations on buffers
- */
-struct dpbp_attr {
-	int id;
-	u16 bpid;
-};
-
-int dpbp_get_attributes(struct fsl_mc_io *mc_io,
-			u32 cmd_flags,
-			u16 token,
-			struct dpbp_attr *attr);
-
-#endif /* __FSL_DPBP_H */
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index 765ba41..66118e1 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -451,4 +451,46 @@ static inline bool is_fsl_mc_bus_dprtc(const struct fsl_mc_device *mc_dev)
 	return mc_dev->dev.type == &fsl_mc_bus_dprtc_type;
 }
 
+/*
+ * Data Path Buffer Pool (DPBP) API
+ * Contains initialization APIs and runtime control APIs for DPBP
+ */
+
+int dpbp_open(struct fsl_mc_io *mc_io,
+	      u32 cmd_flags,
+	      int dpbp_id,
+	      u16 *token);
+
+int dpbp_close(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+int dpbp_enable(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token);
+
+int dpbp_disable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token);
+
+int dpbp_reset(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token);
+
+/**
+ * struct dpbp_attr - Structure representing DPBP attributes
+ * @id:		DPBP object ID
+ * @bpid:	Hardware buffer pool ID; should be used as an argument in
+ *		acquire/release operations on buffers
+ */
+struct dpbp_attr {
+	int id;
+	u16 bpid;
+};
+
+int dpbp_get_attributes(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			struct dpbp_attr *attr);
+
 #endif /* _FSL_MC_H_ */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
