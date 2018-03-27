Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-195729-1522174456-2-8431440453275170206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174456; b=E51+5gnPTH/Q2wNl3mRIWC4JcZJ0CPJxl7xiqEJk1vJFIGb
    lCJCwVAFJMZbtt+ib52IGkgLaimnjnxt1jkSkbbLZdnOf8cRCqRT2/FI6MntqmB9
    y6NHZDg1TE2EO07eFV+R0lBo0kY498HiIm26N03ZshGQowSj5BnKI8EMqps5XuLR
    hIjNzPFlSZgSeNvMoYsCzYFe93WMx9a8kXEmouYZTSsiwsJ+hvjM1kGDRmG6wZwY
    0qFwM8QtlN6MZyAcFgcSU8nx1JaMDOWKVQfkty28MDu3uaIuOhMIi0++pFl4rAOc
    kd99yl4H/HKOYDVQTYb2uHc1XJhndurBLT8FGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:reply-to:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522174456; bh=o
    jU/1UdivbdMw0S+VBxGMleOHS/xgMmE4QIwHYYCuLs=; b=SXrVPXnjsgmvJ4yub
    5hV9qa6TNtghS0ICl+rMUj1ojXFml4Ycxk1VXjBq3mRCdZmLmFSyuMJLAwCTWT1h
    5V1870cijebmssgEnzEUfHtT5AjwZ6GITwYMwzrbHg4R017lU96cNgPeWSV0gNFm
    0sqmU8BP+B02ADy9pyv2OF2hgexrdbt6+zQ8DPFMdwpExCmEnRjX/oGB5KIiYtfp
    WSEjSTFdWEx8KV6Mzy+TJgyZA9Frao8Q/1lg3+hITZhQdeZL5P1dx1SWTFRSTqhv
    LJhzYl7ibHzlCS9jeOHijLkC5jz5+ehe3juPduaqgVMya1yRxMKm0hKL1BdztCBv
    MGM/g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=HkTK5VEz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=HkTK5VEz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGYxDiSCHDD37NdYZeQPN0mTqpBZw0o7l7w3YKgL1ZWwshxJNd7EqtQH0u4phV41CiYTaJTAU/S9TR1PLg73wL6mkcRsivvDeCDZBEIJJdyoEUzNGLEf
    TfERVESl9qtu2UTu+Q/frKfXOpVCHMd6PdMaiCjt3H1TCtyz7GK4F+UjBAqlM9fV24zXKOvT1d6DvOD8ICMBYKP6U2Zmd+pehq8QQmgGkQP7XH3DqC7CnzD6
    IyhE4ozlHewpDO8ymsSvOg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=8b1vOtsxA_QA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=Ty-5YSMphsux1mckOU4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] drives/soc/fsl: Move DPIO driver out of staging
Date: Tue, 27 Mar 2018 14:13:30 -0400
Message-Id: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: CY4PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:903:98::33) To HE1PR04MB3001.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5583d02-eb67-4e35-1c73-08d5940e8559
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB3001;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 3:3c3FEt7IxjsNgamx8dAPmmHDS1LY1nCvaj052HYIoyoPVVFHdepCIz0StHBdOxuEXoXKoGsiPQaKXL0zE5goICQtpRrOvSUuO3K45qg4BnguJFVS26Af9VvUxWC7YpaNmeM/Cf+aWaiKw7i5f/+ncXh8XvjnKaeOh7oke3peCKTiFlbyOW5FZme2KJaE4ozbOo/ylQwkbt2JW0jP0tc0Rwf750yWqO+03JGd8O3/KBK2h3lbZ3kZeI9YtVF/I6Jy;
 25:Tl5AKX6D2WE6YVdVBuYGbwgCUFeaq0JtyQwjaP5Qp+WaXhjjVT6bk6Da+0lrYDZH/lOlAKZaUPbcLQAI8yQ8KF6v/1nXBveOtYNinZd+ZxUFrFJC3yK9+ESAHpsHsJ/q8nvg63Yr8eO1Q3/AZiJH/i1tbMcyJG5CTJx42+Wi9IOpwRe8Z66SU2q8PWItkGcmnMHwsKG38uZqRtQ28xzSMIt0TQp7L5LeGxOP5/OTuStICRqpc2sWQcgzsmjkUD652KCxVmBlLrzg2Th8C2yMNV3g/xZ4Onw05pYZZSk4Mm6xfZ+lxqwukMc6CwPjnB18wavuVBMbjG7EU3VzCTOIqQ==;
 31:LoSgr9B5tQPMhJqbMwnL8XYujKkCClOSA+Fa9ATUDKQqmlPfogeg7qM/ZIacx65KI683RHUsPQSjJHqYuEPeFE+kA+aV0m9fablruQq+G6410dOuXJYjPGFhpeOZHsu2KDsWZMYDjznM3LGr8WaDVTyjCaBSKNCequZWywVyAf9vJ8fsVaxDaNBdmgmyf2gDmRsXWbmtAqpTIXAaBfHIGzlC09MnKg81rYgOfUSVA/A=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 20:sQwaCpUXQOgq1MATZZV+KaDrrlIw90xhESZpCc7HmkAmbvum2C2iJ5ocB/fFl8q/2AopmyRg7xToQAjrwFO4rl2duxCkE1uRFRcmUUdB7NpmLrui5rldzHmLLOvyKeehzcmJLFl7cNrT1/LhHnWwkcoYXPHiKXQ+0bWRZ+ngd0vziIHOJhK6fiTNomk6cHV/GR8cg+cty4hlkwIE9MQfA88JlyAGQWO1+g8x5Df2VJxy6YIbKVW05yciTa3NZeK8tZ1Ml1eLYMqOGSnOfScOUYAWv/rdAVyBqyp1s9e6wVQJNFU4UMpBLpyiEP79M1umFbKYjwiWQx+3QffYGYAaodB41K0SDKakkFH6TICb/BUg7VLqs6w3WCSNrf1bi917KcjPU4EAX9P1EHYd3pi8FC57jxI/YCT3e7czway4WnkW1/YlUtlz6A533N2eDyabYLo7YLRlqzETyCqcmbnfjPlkqeFwo34/oMW6Tmpw0+7flcgpdjS/sNh0ahRbnyH3;
 4:ws8txIUPGGz/daL8ic6KIRkQOdcBrFXUiw/urz8ymWQ8kxwKS80HzJn5KIIAC6uqK2/oL59gCS8a3N78eb4ma81wz10unQfLfYf+XmWK+mp8We7m4w6cG5ya9EzZIe901e9PethoCmmgEg2aW2dQvblqwAwGBq2873JnPv4RWyJ6DQ/F7+54qewqPa3mJPRCnN5r2wafSwwEuVG74892zO5ML/UzXquMC9cHEM7Wy6BO9u8xguT8FCq08CqlTbvunJkBcBFsTjxP4hbQeabdVg==
X-Microsoft-Antispam-PRVS: <HE1PR04MB300198FF6A89471DDAA080CF86AC0@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:HE1PR04MB3001; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB3001;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(199004)(189003)(16586007)(16526019)(47776003)(8936002)(43066004)(106356001)(316002)(66066001)(36756003)(53936002)(50226002)(305945005)(2906002)(50466002)(5660300001)(86362001)(4326008)(3450700001)(81156014)(6512007)(81166006)(48376002)(7736002)(956004)(2616005)(6486002)(6666003)(8676002)(25786009)(105586002)(486005)(97736004)(51416003)(3846002)(478600001)(186003)(6116002)(486005)(59450400001)(26005)(68736007)(39060400002)(386003)(6506007)(476003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB3001; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR04MB3001;
 23:keuGbooPUTMsmz4Z1eCKJ9VrDPnv7X6uB3M9ncCXF?=
 =?us-ascii?Q?bdkSPFk/jLyvWyeMIzzeo3SyIpBpEk/xs021LYFIlItqJfMKgWheTOesjWC8?=
 =?us-ascii?Q?nz2Ps1JKAZLQa5WJNhfTCLIddfgmFP3FBVJJzyfB78Ahu11r6Rqw5ini1YKs?=
 =?us-ascii?Q?CoeMFmMsqhFhxdQhwk/t/yIOMX1HW4IBEZaZgsmKTS3HsfCUYB/n+yZ8/kGR?=
 =?us-ascii?Q?wAP34/kd7ROL1OaDwLdq5lIyNdiBtDTSjm0EWe+h9SFlZ33GOyV5KtSIBZvp?=
 =?us-ascii?Q?UIag940r2jgYyMAdpBUsSLDPYeC/dFlBpNxu7ea6endaNE0+zFr3hlkSp6o9?=
 =?us-ascii?Q?Ds3vpD0Xq0WvV2q/S3bjfMPNufxi3wnhg/uaRJ4G/epEkBgS0G1yQ6J24cm9?=
 =?us-ascii?Q?Rzl624x67gwaHG74E48Yp74ybrxuc4dqoIReYTBC5Vk/0GtYbyFQNByD2jfL?=
 =?us-ascii?Q?knI9E4ocGVqnk8jFNU1V0jiU29j+/xvlOxKPteMjLOnYRM5CmRQ0Q0cUTA4K?=
 =?us-ascii?Q?WLelhpSCN5VlGbLCrT1bmqtrcUHNecgaSoUCh+XU6Ss5oYhEttXjiWRwbnYt?=
 =?us-ascii?Q?13XYHPFx17k9WvmJIYmHWKXsjRDu4AFATpUVFFpGA1gNw28zLdM+bHVgFMjb?=
 =?us-ascii?Q?Ju/zz8m7BYRFQMVwsZuARVzqC3B+rBc2KVfYMo1gK1AIvimKJJMkjjkxC+mM?=
 =?us-ascii?Q?iOdSlnN/GUXJL+XdZaPw2Yl4BebyY2XL78lvVuPX6dEAuWnh2jOUgaCDLf5O?=
 =?us-ascii?Q?15Ml/n7igHVdoqQLrhFgyzjwYpvd7TkwBdhyGBWhLIqaCBRIR7lp+sWC2DhZ?=
 =?us-ascii?Q?vHtMC39HE49WsCK5hI492iRp5ciK5hNy9XgYByNEghEtuNNmf0UbxCKveY/z?=
 =?us-ascii?Q?n548teF3ynrG1NrWhx896MGbN5VCL8OmTUv4oSZj4G4BbjDXvm6O0k3JV2On?=
 =?us-ascii?Q?lnu58lmRe33pqlyJ10SPtmnBoV0CZaVH+VE86B3E5cSEh2w754BOnbU2S95C?=
 =?us-ascii?Q?EPB8JftEl2RRWnWcSiGGCmNORSEq/oGQp7CFapjHx6Sv2JBTepkix9zvyckV?=
 =?us-ascii?Q?IcoySMKYLPz9MtDf3/1rv/mQRjOKkjjGgFIUV4Bm0q88UdAfugjKz9Ooxkmj?=
 =?us-ascii?Q?XPY1cr3x/qmSCTzjTb9HgKvU5mkYtyoWItvE5dYnX1hXLuqoZMguWrnZKN27?=
 =?us-ascii?Q?G5iXsZVCvNaSV1xzPXHBs1GSCkbLHi5AN56dIohBUqJflVBw191KRwGzg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: n28YWq3cwxZg6BLVwxS++XXciGul7CWAa9TVVSHKHAkM5xM9Z1SZL2s1HlUK5AyJhPcjrSpA92D0h+x0cTTWsrUg90vT/qnTeKWwSiZzNWx6nqDdMyOPEBPRYs4OIdFD5TZZi8EAppnn9MFD3rYN1ZZYwijUGmCynJEIzZYfz7p7Leeb6XeulZMpqQCCVPkW
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 6:cIj4K2J8VLvaTQjxOagLFwT2bJ1Bgzt4X+vr6mYqJGQR//7CA0DEwIbkmj6K55Isi5sdodTqE5U2kz8eCzAFVmq7rLlmtc5zrpUJ9tTUOQWxKE1R1tuqP2qP0ueNy2wED2MqnGV9iA2j4xjnFEhBGfIlmTcq8owEfam5EcQjL9kEtmBLSRxQxK2PJE+izC8lHZ2UK4jse7aOkrq54IrWbKgReK/j+j6YCGbttEBvk3akvKUUG6raVQPUy8JD2ZyiYb+8jgZDGysPZ5rPDYeRphVfESrlahv/d+CpZ/XSltqo1epQncnXCiipbGSQhl7QDRSopbD2DzIlJ/q2gmwDMd8IcwvhZdDluRwh4lGJu0rWfRsU5Rkg767IjgJ9ZSw/+zZlM+fVdaH9861C0Wd/O3M+pM6yvzTAwAPz3mAx6+P6yZGaVfasqfuWFo8abexviqm8UXZrBLHYw2eqYPkLpw==;
 5:H2nWihqOwKgJj8JrDBapWUdcUOTf7T22Zb8BMoztUbOVfGFrudo64/hZbpf1HJNeAquyvMK+qH/CYpByy42Tt2CVtcdzlyRgkUEKjaCQQIe+TP6Eze7djkVFhZb11jDCfylnn+Y+sOYn1xz18m12eybK/zPRdUwhQ3GfrSaiCMg=;
 24:In33vFWIEQmt+WZHAQv0baqTyRZTb2LQVK5a71IyNX3B9P9rFx+Bnd3DyAmHIbdCcrYAuII+virNFm/ywaxaTw8vn/cuaKwLtUbvkinFC7o=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 7:glsXwdZXSl52+J79pfRSujyK/RQ4Nw2mC/EkUt0+UzwtE78CuOikrG8udU0c2LnMMPYw4E1QfYBcNKbsU7o/PDSZW600oI7cHNJgIKrfbgZ9IPvPldZy2nA5Nbr19N51JlGBk6W/duhM4qAmd+1ItgylAse9kEQGgp+Im7bB6Bp+QKwDkgqewvyhgL60734ndWUG5xYJy7axTS0uHe5Z0tO3EstoazWgriYkZmtiV7YgayMvbI5A4A2dc+QVBqoy
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 18:13:59.1083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5583d02-eb67-4e35-1c73-08d5940e8559
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3001
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
Reply-To: roy.pledge@nxp.com
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, horia.geanta@nxp.com,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, stuyoder@gmail.com,
 catalin.marinas@arm.com, robin.murphy@arm.com, Roy Pledge <roy.pledge@nxp.com>,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset moves the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequisite to moving the
DPAA2 Ethernet driver out of staging.

Changes in v4:
	- Remove unneeded dev_kfree() and dev_set_drvdata()
	- Use devm_memremap() and devm_ioremap() for device mappings

Changes in v3:
	- Update caam files that use dpaa2 frame header files
	- Fix sparse errors and memory leak
	- Remove empty staging/drivers/fsl-mc directory

Changes in v2:
	- Fix minor conflict in latest linux-next branch
	- Generate patch using -M


Roy Pledge (4):
  drivers/staging/fsl-mc: Use devm_memremap/devm_ioremap for DPIO
  drivers/staging/fsl-mc: Fix DPIO error path issue
  staging:fsl-mc: Move DPIO from staging to drivers/soc/fsl
  drivers/staging: Remove fsl-mc driver from staging

 MAINTAINERS                                        |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                    |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                   |  2 +-
 drivers/soc/fsl/Kconfig                            | 10 ++++++++
 drivers/soc/fsl/Makefile                           |  1 +
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile  |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h         |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c      | 27 ++++++++++++++--------
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/dpio-service.c     |  2 +-
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c    |  0
 .../{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h    |  0
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c     |  2 +-
 .../fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h     |  6 ++---
 drivers/staging/Kconfig                            |  2 --
 drivers/staging/Makefile                           |  1 -
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     |  4 ++--
 drivers/staging/fsl-mc/Kconfig                     |  2 --
 drivers/staging/fsl-mc/Makefile                    |  3 ---
 drivers/staging/fsl-mc/bus/Kconfig                 | 16 -------------
 drivers/staging/fsl-mc/bus/Makefile                |  9 --------
 .../fsl-mc/include => include/soc/fsl}/dpaa2-fd.h  |  0
 .../include => include/soc/fsl}/dpaa2-global.h     |  0
 .../fsl-mc/include => include/soc/fsl}/dpaa2-io.h  |  2 +-
 24 files changed, 39 insertions(+), 54 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (92%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (99%)

--
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
