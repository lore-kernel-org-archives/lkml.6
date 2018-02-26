Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3286258-1519662517-2-5714797182210031503
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519662517; b=cPLp4EvyYRPG1Q/00qSMjEEXHZDydrk9Pq8+WPKuoKTr5Xw
    OYaLFL9QYvY7MqNZhj7z+hpHQupcDaPX9hzVDDqpYkfBkD7sD7lfkQImDciFjYav
    L7zP1HbsY5ySAdYS9wK50Q/6uMxUxukJsg9CRSPvKOzzSVny5eQjgZzNOaSQReLP
    jmiOHop2vDw7a8ED8EwMHscI3L6Tin5p1q+UHcHMu8Mf7+YfdbaDQ2CWtl2PHYXy
    GTon3SqCIuhe/jSmGXxf2vZW9TM6I2dhJ3a5yYN4+iZ96djAVWG9xBBV1PfRReGh
    yyr3UqHya83xlz6XGiqMIp04P2Lu+GT8iNIMNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519662517; bh=G
    xsB3i1Jja5bsK+w2xqyrKnDY44VIYtzyjQILh3b5zA=; b=MJUZIE4IK3HdjlOSq
    v9XWFLLH2uR0YEp7ZZJW0qEWs5oHoABTApkEhMDewKcxs4uE/LyGQWTX3/lyg+N5
    keIqLgmz6lGS3VIax72hmNUxsEZKe9HGYLKyTOIVcAqEG3yj8N5KQROzSAiS+Mi5
    WpYNa0qdbn5izEcibYH2xXefm54bL565IS8V5VuJHolP1INPc4u2xmiPdJ2W8r3d
    ZqyHJwzoUnQ03f+Y+w+xrgF5C6JWraiFypKmZWR65lzpAMWWOkLokwPDeNiGdrWj
    1fSDLuLjaZST2/0VOsX8x1XRtXvp5vjFmArJ0eIiAxI4AHs10M/ULI30ERRXOmBq
    T6U4Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=Vflltvu5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=Vflltvu5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
Subject: [PATCH 0/4] staging: fsl-mc/dpio,
 fsl-dpaa2/eth: Enable multi-arch compile
Date: Mon, 26 Feb 2018 10:28:03 -0600
Message-Id: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28)
 To DB6PR0402MB2696.eurprd04.prod.outlook.com
 (2603:10a6:4:94::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44124485-e905-4b3b-0f11-08d57d35f54e
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:DB6PR0402MB2696;
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 3:6PIv5uWa5KON5X9Tvh4UDNcQ7DWn1k1Dogx35h5WaNX3rxKV9YRMvJxBwxDzHCZcNk48keyddKBZMsM1I4PGWwP2pzX+6am/PSTNpW7E59dHNHYfRhMD0irAECMpcsGOYnTnRDUdNw6G3M9IR1mOMUvDCSpWvPbRw7cZU0vlLv7ALYA3Em7eeDKtgDyPK7zsHM7TrAqfioc5XMF9JojGkSFKTX/q+QV630MFCux+wC6lBFCCcmaPHzTRKX10YnmV;
 25:J1DIQI1zRLeQbodq8jTHdzIbfpL1nImVhGpBWfr1MkSNEoQBBfAbkryvFATNyM+zYHCT+LyuRUR37QUB0VwVkutJDgsk9MejFDQHv6JLZoK1LQlu/OpQHy6V21VTJEfzSQ/4RLO0wESzhHInoC7NGjivddDD9762AcAKtdWgONXST4Y4jzstFVJvivm0cF2mZuK5JgLvSI9+9YMlWSlVcJ0JEB9woPFVcR6EOPrWl2tX5Z39oiDC0ZI9A6xvx4qzbzTnGj/315CRhtumkjvw+NA/99nD0xKA+Za/sdrQzlLj0u91SS6venSykWGoO5KVvwKjs+bUp9a3J66r0vsSdg==;
 31:oSZR9hw4C16o4LEbvJSljdlvzneA5qMXIRKX8qSuxHvYp5RajGX18nmATwFQKjslcZd5I6QyUbnDtO3LIA3AyH/N3ZdeADAaYW0ATVKgS/lQdP1yFVAvaWLz8FFgfrw1mNkC5xxh9Q49agn7o0d5bJgF881RGmubEly2HdSlYpVNkCVr2/667aXYYisUk4KgZLTYD7ZU37knjZUVrQ8fFAF4QvchZum0ITxxRqUH4WY=
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2696:
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 20:VzNHsz0XnjbgwaNa35VjgjO025j38mvm500Nx/RTTGVjZNeEnNA/P3x8GAb06R6U3GC0OThdlj4EKLfv7woHM7RNODuEZL4aBw5bnqdqRaDw8cneBaQXGhW9FXBJQgRYD0mXWQ6WWmxeAchc4B4efrYxDiZxthcRz5H4anzCeaqlmPQyLizQtB42rB5nNoxOZGkFXp5h8UUCCM+uA95ONlHO6wdIRVLwzA1LTOFiLUyD/zJOdYjQDy3fUJLd+vlZl4cwRBnKz0V/6rgXv575lKYxGcBCCeJb/m3zzhJOpfhAAMIAK8wBVrs3sRsos+TrlTfcLfaFDdNTeiutQfJm1Qw0D+5/bU849fdfW0NgFyFzxhLH/WsKy3rblYLCwuK2S6ttvHpeg+HR1w4C8vdPrtqItn5W12IWiJ525PctnFCrcU9zM38MQoGbDxIkGNXbes0iDBl8paD2pr92N0Mb4LldauNgdPI8RzfdmiI8ns53xQac6GjNI/NJAyJRrINr;
 4:/sg9gkc/HDhYf2az1sJ1jsLiVUMKaL+Qtjbqz7FJKROZGXy1gtU+OAnx/Fb5ZR8o5ZjRU3ynoBLflPFpVYXIvaJnDks3yABjxYiir4lVB2rPUMddLO2wQAZi+03WnEl4YnYz7N3YdYYCb4PBtpkmHOqnN1UavYFm/OyeFEF2445a1IRn2+ewmXgQzFg0w01iqb0nBIJTNZiUoyFIcZOhXoPDSTqa1MCOkf09toH9nsGPZC/7kOqT8yesrr9zdT1cqrbVtabTNNfD2k5ORA7F6g==
X-Microsoft-Antispam-PRVS: <DB6PR0402MB269659E6EB3B4152E3BE546194C10@DB6PR0402MB2696.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(6055026)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:DB6PR0402MB2696; BCL:0; PCL:0; RULEID:; SRVR:DB6PR0402MB2696;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(396003)(39860400002)(346002)(366004)(39380400002)(376002)(199004)(189003)(2361001)(51416003)(106356001)(50466002)(26005)(16526019)(478600001)(316002)(186003)(105586002)(52116002)(305945005)(7736002)(16586007)(81166006)(25786009)(97736004)(5660300001)(2351001)(86362001)(2906002)(8676002)(6666003)(66066001)(36756003)(4326008)(6486002)(47776003)(6916009)(53936002)(48376002)(81156014)(59450400001)(68736007)(6512007)(8936002)(386003)(6506007)(50226002)(1076002)(6116002)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB6PR0402MB2696; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB6PR0402MB2696;
 23:Gh7ly/R9Kv75/XCezZ2fn72dV5/UYFQdvL0icDi?=
 =?us-ascii?Q?DKU7bxTJCveHn6sgBfL/temrCbrI9pgUu5usJOIUDlwthONvR5rPpcwc3exu?=
 =?us-ascii?Q?DkrwhsRs/Ir2hY/h/EO04wEtnIYx6lQkMCsA+LiCltQY2RokIC0SgPpgJ0rj?=
 =?us-ascii?Q?vhY6kMqDSWVvb60TDTXwu1QwNNMORZ2kfUR22oFt5EuDHOFGC+Bb+PWpMXOy?=
 =?us-ascii?Q?a0l6zBoYhzbrM2Jd6AiRn1EPyhCQwl9y2z/KNnIqUsRDGUwLLDilfgLNOHeH?=
 =?us-ascii?Q?HcTqcokKh6V8cOS+W0ForiOy0nFuLctFaOcbE7rgOKiY3xlkxINjEJ7SaJEs?=
 =?us-ascii?Q?wTA2M4JrM381Vz5HYp6gV3dskDCs3E0plAYVUywQ4JQ1HIB96MmtDM6b09mZ?=
 =?us-ascii?Q?pKtKr0UIDHoF0mUdAm7ePJpY0ST3KfyZTq7yQ3CNFgkPujrT8G6CwdnsoNl/?=
 =?us-ascii?Q?c8PK0EgI6su9baYIWfV4WjLcYcYHPko6Cxy5mDqMaB8vHRhc0rOxZYYHvvae?=
 =?us-ascii?Q?FAN/EKz/B9qBrzMROQP3C4bimjiNLnFn86NoJ+W9xyBO5L/hwUWMZ5FYnh00?=
 =?us-ascii?Q?nZ/No5qLVdoBz6djW2QokNDCsPtKM3jz0C/Nyd+fHW8ZIHC7LdJpMaFmGEBV?=
 =?us-ascii?Q?Ds8SLBPmp94uOlhnbmyrwmUJd/rOYV5igP5cjMj7CezS9y17DNLd3Vsy5EXW?=
 =?us-ascii?Q?xBYICdzF1O6yiOtIXAwfG2TBh0D5WiFX3iLwGpXoPf3TY7tr7B1/AhoO8UpD?=
 =?us-ascii?Q?+cvOdTqniOX42eYB5hm6fyvyWqgaeCrAe7iaqvmD7rj+e0xNvrMcgoPO2Nvm?=
 =?us-ascii?Q?kc/1VxvgSQlNW+4CVV0mKEuQSkWagO95hDJ28aNUNhBh7au4wNjMTtEsoQq9?=
 =?us-ascii?Q?XH7nWisqw7k2be9K4MkffL86eTnRD7kGGoGP/w1cwdZZqMFhaZHvrfUUCyfL?=
 =?us-ascii?Q?vKj24h4gPhI8aSoW3sPNu7P4f2NcfPw5KtJLY5k459nB3+vdZszA8ly8deoi?=
 =?us-ascii?Q?g/lnGnFXBPZeAu2NGbSmavF9HWMlmismqXak8EpkPzRzbM1w2L0f954VCVuZ?=
 =?us-ascii?Q?UysJBQYGPxfkuxrQ8nkiV+lOiKhEllZajTL9EMT+rVnNXszhVti33pc4T2l3?=
 =?us-ascii?Q?LakilvO99NfiTPwC5dZHTSAzClHeIzVet?=
X-Microsoft-Exchange-Diagnostics: 1; DB6PR0402MB2696;
 6:a+7svTXVkm4b02goLwdGbx9svk7nnjgD7YdR2AyyzE9u+ToaQJS71jw20M3juuwwNlAsQhICxobITS7otLtWoRvS/cS1N8vYPyygp6qlu3fvBT58lOV9VIi37K/E2AfmWQRC/zTU3cb2z0qOPz3ZQqpUGLm72MSMjzP3yvVNCMs30aBa7OgrjStdoQ36YsVIjkC6gZzC6f0sdMr3j286jpZ/iYnucxmHV8ZmRPYTI1pfnJW43q+lRrwPTeXkQeIElvbYhpYzge0tuKnwVcgcH5zs/bDmyEFd0BE7pIr+JtfUzv+GpMdfnYyIS0DhME7PDcPcohNWMxoxcrm6Vvp11w63AYILHoYDRyRc3iKsfv4=;
 5:8VIXFsSgKhvlZfmxqezkST2gvW6zrP0ovRXvvkUD2VYuSqeG5f+8c+KexpWwiz3MCyszqes3DRHRG34GhFzZ6gOLDw+B2J/Ztva3D/5Ux3bbGSJYx7eqHnUu30KKqDYhTHufBVtchISc6JRwZz1V9O3VO+QvhCO9U4g25YbPUUg=;
 24:YY8sbJDUKdxbBIlISJzpyDxPrZUsdnQV+4dAiaD4v/3Dj4JC+4XvXI7iyJVUtj8ySyzpCx4w8Zq+8Rg/hqiP6Z86H16tqPOLGjunUAv2sTo=;
 7:yUszswxzQmCWWDQpBeJiYrNSGeL0pGBkr0P3zFRNU8YGfUqAAPKP2tSVLFnz0P/tYIIjurEpJW6JYTur8jKL/V2tpQS6prfvzpzq0BnIKS7UpnLUNxxvFfJMBuioHKNR1nSHWIi1k/Dsf7lDvZY8TSJCIZEjqTSORCxn4MXtoCSRzO0m1LRBALyhQ0M/DfDk6kSQD6DfHnHYukQ6acW+e5zrAjt0OIFvSuj/tM1k9KtMnkMwe5+P+0YnOF1fPppM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:28:23.2877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44124485-e905-4b3b-0f11-08d57d35f54e
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

The DPAA2 DPIO and Ethernet drivers need only a couple of small
fixes in order to compile correctly for 32b platforms.

Update the drivers and remove ARCH_LAYERSCAPE from their Kconfig
dependencies.

Ioana Radulescu (4):
  staging: fsl-mc/dpio: Fix incorrect casts
  staging: fsl-mc/dpio: allow the driver to compile multi-arch
  staging: fsl-dpaa2/eth: Fix incorrect casts
  staging: fsl-dpaa2/eth: allow the driver to compile multi-arch

 drivers/staging/fsl-dpaa2/Kconfig              | 2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 6 +++---
 drivers/staging/fsl-mc/bus/Kconfig             | 2 +-
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c | 4 ++--
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
