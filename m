Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1258868-1519986272-2-3713679637860446469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519986271; b=KfL/5a/mEMMwPyKBNYaumXMgzntF5N+R5N6Korb/s56Oax1
    sKpMsByUj1nSBpuuQ/0hsC/VeWW0kFDCTpCBfPxT6HaOe+bN7/EWQeTJSndZPExZ
    iaCm1vx/l8y3tTJ1Or0LwE0Lep3m/eRvcQPXYgt6ovxYBBThAegFA4tPqWs2nVrr
    URYP0teJuB10tgcSb0Jl8MQrq5wRePmzx/2VIrF9VVTcr584ASOKjFZzkD1XUiyw
    4u2wCB2DCoHBcLTurqxKMOaFuoH1mUPK3qYIa1EgqwuKWHB2GKPtm8bqATwn1SFb
    j48AlPLo9tTvtV43cPZ7R1qrP8dfXsGH931W7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519986271; bh=L
    MP7JqLxIX6XI5rPVkyvr5wR90OHmDm64iplcWUiu2A=; b=MflUDxLVoXf+Ern4V
    cixSKqDRTIq/OotIlAX/KRTsKom3dD1eREIlmTmSGUsPLH/TScF1U0+AXb4aKnMw
    VrGR8WHcsMyTU5kyT6pg+lMG4L4jlLYaKBTOQgKLObW9sdhALjfL7uE/KEqw9AF/
    UzKgZVfzNjYoqFcMafSEAlJc/+Kq7K1y0bm5zgu9Dzwv15rOHu6nQDASQHKSSopJ
    1pp59VoMNS58c/q9SrXbgShStJWIJElSpE2wijyipcWWgqwbmOM82DxXVEsk7Hsb
    Vy7EdjrMVSR5VnyHSpLADG4ScTHpT0wzCuEKqN69fNPSw/bhekwiFdsqnyjCkD24
    sSohA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=HCjYh4Vz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=HCjYh4Vz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=bogdan.purcareata@nxp.com;
From: Bogdan Purcareata <bogdan.purcareata@nxp.com>
To: gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com,
 ruxandra.radulescu@nxp.com
Subject: [PATCH v2 0/2] staging: fsl-mc: Move DPBP and DPCON out of staging
Date: Fri,  2 Mar 2018 04:23:57 -0600
Message-Id: <20180302102359.16979-1-bogdan.purcareata@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR2201CA0055.namprd22.prod.outlook.com
 (2603:10b6:301:16::29) To AM0PR0402MB3649.eurprd04.prod.outlook.com
 (2603:10a6:208:c::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2815bd3-9185-46b9-dc3d-08d58027c2bb
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);
 SRVR:AM0PR0402MB3649;
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 3:o/fHCNY8pTVnODySBZ9obyBivPJ23NGekjyWyc7g1VG+kR64jvJ42xhU6qAWlU8gGv9TY2yWKRFHlWlTEK2Mtd6nkGnKGdTA6Wj+t0bN8t5FUlkgKK2Elrh468EtUTzaN54bD88JxLxIcfpVTVx/Ehv/ScqOTkRZlTcwP5nwdX+Ujntm86k73StUWBRgJW2S9w/HB3cZwe7jO2XAdjFhYke8vvveOd8wQWk/gB45n1DHLlwMaBdci5oiK+YHDfI7;
 25:4XGpQv7wOprVLhu2lhtdjd2z4TYmSb+yTZiFvJpu6S2+8YhESbez0uaQIBLm+uTwHLBGAHuS1I7itgw4+y/UHguuwD32tE36VksQrtlOJekttDLtjyA8dqel9qVIUdAwitHIs3gcaymiqWusLWQZOf6AqKEowSLzICamMKL8yzN1Jlpzqq9Wru4TAG9rkpo46hsxUSuxKPL7TD4LKo6wrwQt2M+y5qos/cyqsuelzvosMXv6pfjmoA1FtNsB1Qv7ygGR+JjhiUT2CmeSm/4YWXlGcq3kxTzq5JjO8MpKhYp4yvaFCds0JznBLPEDXEbNOzf4xPsRfcVuAXavsvPUAA==;
 31:voHqMkNvB/ood4eWRC+33KuWWjG4axDgh5W1hhrCFWFERxfdK23UQzRX1hVvr3Vi9UzgnMKbhgoHvNbZR+QsNy1k10ZQZQO6Ky2HDMVXTp1UToDb+AMfzmY7by0f9f3LJlq63K/CJC1/Uaitcn4a4C0wXSL77TpYlQEDaPBM62V3sfATITMOs8Dm+IU6TKrEB8U1RS6z46lzQjct7FSQM0VihBh30EsQgQrdyJ6aC5M=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3649:
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 20:ZWT9mTyNffVW83DFg3mbq+AEgGkNiiLqlax1Ia/F1yT6AfUZN5oMpwb7DDgp0Ir7yiDniRjifQNGXI8NUEQCE/heekFH+g55cDUXkJ/oRC+KqiPKVluqoWFi9uxfKpffJecP773IgRvb05rw0sArbwEgM43lmvzWsRlNMUAkLWt/5saceDAjo1awxEuKQBYSBeSp5EgnwAaHBPivtI0tACjV9J2T4eK71/TpbutxFI7Pw7xETCsL3u1sBz6Nr2xBun5W8Fa9KuV6w+9CyQaQ7jcqeYWcYQVtynv1A72r/cdMtnjvIqDaaiwVaPI1sq5Rv+ZQwh/lO4i/4vek61+GJBTDBTBNRkefJaY0ZseXQR77by+8gAY53gKS5EzA0szdZAjcoUIFsMi0n1lWuJdjO3T3Ggy5rX33rNNCfou42uiMsA42KpozbrgdgvCNcIXJaJGKZhZpa/4CeF8sKN3exOy2DQArFbUjKAgqoxtFzIbhYte9lqSnxOVuNrJzHf5/;
 4:pRZOjlnaOiv9knUA8wlPSkh7eh1JeA4/zTDR6plNJxS/2vkn2po3zmbwYVS0Yu3HDWAX7UWIyustRhIIvRAoIi1th61AffaaImOI/vQvLUYEbzs0DS12uNoyrqQsOO282M0dbAbhkLQTj/ikc+nfPgeFhmHavR6awVqjYxHY/LkXYgEx2w3TD1FEde8GBagEanTIlwe06NdDNqb8oOkVrzRTHk1U0s1gcsI5GRjhlaTgiAvSasiQ5cCryNk+95VRzwVWoonAxqIvdYayT4AtYA==
X-Microsoft-Antispam-PRVS: <AM0PR0402MB364953F7F61EB31DB190F961EAC50@AM0PR0402MB3649.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501238)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:AM0PR0402MB3649; BCL:0; PCL:0; RULEID:; SRVR:AM0PR0402MB3649;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(39860400002)(376002)(396003)(366004)(346002)(189003)(199004)(81166006)(16586007)(86362001)(50466002)(48376002)(6306002)(53936002)(106356001)(6512007)(5660300001)(51416003)(25786009)(966005)(186003)(16526019)(68736007)(50226002)(36756003)(97736004)(478600001)(59450400001)(52116002)(66066001)(39060400002)(6116002)(3846002)(1076002)(386003)(105586002)(8676002)(81156014)(26005)(47776003)(4326008)(8936002)(2906002)(316002)(6636002)(6666003)(6486002)(6506007)(7736002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR0402MB3649; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR0402MB3649;
 23:oTrs2H8Tw5jwcBz/v/i7S0tE7n59E4hpCKy9udj?=
 =?us-ascii?Q?1xPFqoxB1vMs0J8SJueaEK752FqVCRxWQNFX6jcCfKEt+bzKBt8ZL0omJFEA?=
 =?us-ascii?Q?dpPL2d86rAGchZG9TylX5BnZgsCelVnq++wZAA/5NHlNtHeLzZ2Jaygqe3y4?=
 =?us-ascii?Q?pG0TpnlKMQfQPi+rIuoT9K0FLl5nZWnjNxOn3V4qH6Ch/+gR0LRcdZ9NFMXK?=
 =?us-ascii?Q?n33yoZZMX3cWY1DyI/EYsXyEwYV4Va9rV2pqp8bMsRiEgMc+oB7WvVgGFCBV?=
 =?us-ascii?Q?ewfb/RDjgzs0lLZ69su9/lHWm8+hBDAIHNbcbkKF9dpSj1J+Sh0fB2HqF745?=
 =?us-ascii?Q?GuI0q15eoAIWotAhT/NiVJoOzUGw94JW46mg2aYZ27n28adWvwO+nVipyo9G?=
 =?us-ascii?Q?OyFkaZ+PKr3sGzJFFKfE8YbozgfnWLXH98wIfto4/oy3ogxyEPHyhycGM8vu?=
 =?us-ascii?Q?sVCjZoqm5ZldqgCaTf3nnrvASAZTCvNTRz6NPIFPgzXbTNI5Sa6Ibh6p2QJ4?=
 =?us-ascii?Q?uuastRHI7QthOvTpY5a8FxaKB8y+phE0LTGUbKpXvxF35q7v5gbOlJmkI9Bn?=
 =?us-ascii?Q?H0zavG2tcH2BhUBNepqh8Ei6PW3bmRHpVmqJQc2wOQAqPO8SGGxfzNRgNhpG?=
 =?us-ascii?Q?ejRT2P5A3nsacxu4BuVgJzQ10r3oXuCyCltnu9Qc54tUOaqtLtEGsXXCV1al?=
 =?us-ascii?Q?RkfoRac6cyjPz8k/BSOUQx7j4im3Ac/4QOELzhbZME8/iqmkkS+awCoHDIYp?=
 =?us-ascii?Q?rtItdod/3ybuE5pCtETmTKePz/wt7lfWiOrRrRLszmLzdt/7dUw7Zskx4gAD?=
 =?us-ascii?Q?gW6zM2wz5z/udIQW+iHpKhaREcMIRByH0LrKZuvQ1MN4BprY3cCBopZZOcI7?=
 =?us-ascii?Q?tLunvTDjxrZCiyKAvwIMWxyxXKR05vHA41Qokz//nCjAAMb+vL7ukiv3t4KR?=
 =?us-ascii?Q?yQxl0SrN57/nx8KKjAjMmTWLcl06yUkwfTZ2oWvlxvnjkQjod2ERLvrKnZ9R?=
 =?us-ascii?Q?QeM3eSFhm3BJBaK/2z9dSIyLn8SJfs5+PE60FHUrQlZPjQwO4NC0Bu42ER77?=
 =?us-ascii?Q?gBn0O386EBwXZQ/gG/0hsTTtbljCmy4viF/ptDPHipyx36nKanVQCNExAtwo?=
 =?us-ascii?Q?+P5iKwmMvGnrBiYmFimgWvD6hu1Wpioy1fD6lFDeaEkGNA+lbdOOVpg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR0402MB3649;
 6:/hOEdvijD/CBHFj92o3gWOvdiuLUmPHfnpuEyU2A2RdwKQRPKKV2OtQF/QxxUABQPYxRUS9j64Butt7Wksfg2jsCCTpD4JiP6sL0tA5am78Y8DlxKu+H0ZMf98XvY4sExtk+y+qOxsnNGqHn2MMWJwUkyzTAV9a0JljsuveKKHkQZztfxQ+AA2WKklHCGQwQYP77DKWHbsTUrDVqRnax+PrsaHYhKOFtW1k9jAwlXUqTB6HerDpPN/yBtSto2DBR5ccRgoVwNanNnIjrTBUMvtXK3UIOck8QMhmZWlJhA8obBGIBm2SPq9WdKjb+wrR739fGBDiu0iQ6x9K4EDqs8s3hJ4GUxFMiGrQSTsHO/Cg=;
 5:t5AejppiambgQzdsV+C3BM4QhM9VNN75ScaHp2OTyutJ/45F/95UC4pqA8TGuCpk1fgTN4Hl4SF9TD22mW9w0H3nHbLhGwtBVC6Et3AEbMYtql17MjyIhyZlywn3BnRSgZW/nYghA75qZT7inCLc1xUeMSPC8x9aG3UdEhSN5Lc=;
 24:Qie0BlruYEZW0g4568sVOIFn/pIx/5Xnys805WQrzFVbxVZYeUkRp+b/73pc56w4ZGnRgGQtTE5iSHC8lTcqNGk2lJEb0A6wsAwUoQ8g2SM=;
 7:hqC8NSwJW54QI5BcAjZKyzLjllUDxUMhAynayk+f4eyxIcF8tsihlWJFJJKQtkuQV0WqhallOdOviNGH/eAvsAnpf/7UcUMetTqr2RqrXMZQ505Snj/ceFG6U0aHgKoOPmtyKFS9vArKobA4V2l/qC76c2y3KDQHRmpo1eWhp0rOgo+0hHUMSEEhL+fu5btK+BB8UD0wvxBNbhxAxN7P6NPu1GWGfKp6Wi/yy5xQucoIsbjLjakzb29fbfkXJEYe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 10:24:17.3058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2815bd3-9185-46b9-dc3d-08d58027c2bb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3649
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

Previous submission: https://lkml.org/lkml/2018/3/1/733

Commit 6bd067c48ef ("staging: fsl-mc: Move core bus out of staging")
moves the fsl-mc bus driver infrastructure out of staging to
drivers/bus/fsl-mc. The next step is moving a couple of tightly
connected DPAA2 objects - DPBP (Data Path Buffer Pool) and DPCON
(Data Path Concentrator).

The patches handle moving out the mentioned objects, one at a time.

v1 -> v2:
- previous cleanup patch already applied, so removed from patchset
- properly refactor #include line (Laurentiu)

Bogdan Purcareata (2):
  staging: fsl-mc: Move DPBP out of staging
  staging: fsl-mc: Move DPCON out of staging

 drivers/bus/fsl-mc/Makefile                        |   2 +
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c  |   4 +-
 drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c |   4 +-
 drivers/bus/fsl-mc/fsl-mc-private.h                |  87 +++++++++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |   3 +-
 drivers/staging/fsl-mc/bus/Makefile                |   2 -
 drivers/staging/fsl-mc/bus/dpbp-cmd.h              |  44 ---------
 drivers/staging/fsl-mc/bus/dpcon-cmd.h             |  53 ----------
 drivers/staging/fsl-mc/include/dpbp.h              |  53 ----------
 drivers/staging/fsl-mc/include/dpcon.h             |  79 ---------------
 include/linux/fsl/mc.h                             | 108 +++++++++++++++++++++
 11 files changed, 202 insertions(+), 237 deletions(-)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
 rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpcon.c (99%)
 delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpcon-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpcon.h

-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
