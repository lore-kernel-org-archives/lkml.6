Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174462-2-11394803086655433668
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
    t=1522174461; b=Q2hXgWtvONmxof6WaIW+yxDoOLMWAM5mca+gOHifbScezwf
    roPKka3Q9i0FDMoIjc2SacxEJrQq1HiCcEjSAGsx38foW0aUNvmCDn8HzGZL9OaW
    5tbFl34WHbog51onrGVxvIXI/j8qdBlqoGDv8rHaCt/Fkccj0NMJK7cmNKfsRU+I
    LcT9fos8b1kqU7u1lh+EQM6iQrrKzv0C8vhS7VwZN+sqI7098gp8DJwmUwJu6+Cb
    HRfiwfMuhEqklBv43MehYv5goV1cjpudyUClL2Jehp28bk7XSCpsATn45vP22MBA
    2fZF1Yo+CvBMxoHmq94Nth1k7SnSjZn0F5Ov5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522174461; bh=pAtwxhP+DhwP17tsQdlZ1oCdWqh6JEY2sjbFp7sD0pM=; b=W
    7GH8rGuvGceERg0to/91wxR8dBB45VJ6nTx4WmnMK6Inik7yFECYSEO6d51FoJcM
    8bULK6qa/ssWU39JsuWpRSJYJbwqEhqILz5vPpF3SwnDORwQiO30P49Gzr0hI+Vf
    kq/12zmA768Kj+WMUr0gb+w56YBWbxKhLGRnAGzcW2MN9KbOyy2KHqEgNMiZloAA
    P7TRrW1X2wGInG0Qnctra28eMc+/m2mCKkvR4FUIyJ1U1Vh15DPeS1GMTr+oWsEy
    8frzjqyKLBMcv4Yex2jSj51jJvjekIhCSi0xB+Cf6e7x+2jNXKH7nCe/KTgDgWfz
    tUTqZtAwddAvRdlucRsAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=CuHA5gYt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=CuHA5gYt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfEOHS5QGNLTxWKN+JcR4zusAlShi68ipcpM128G9omcb0HuhuRpC/TA8bepWAnps3kRGDzG5qJQZQKNwfksBj/LuuRcG0gZbkCuN8djGpF7Ccz8hMv/M
    nXjVdsadoev9ugF6vaKVOvSBOqo75bmyZdftkqy3I1iK2k1VcZuV4UPuX1xnOLwEUSvyCvoYtddgZQ0LTMHC9woETli/aHVsybhZu6OzFjKwEgnpdYnHdf7H
    hl7GucMsMKJB1o3tQL9XsA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=JMP4OFuIcRoA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=9B3auvIfBfaVWBGAtckA:9
    a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/4] drivers/staging/fsl-mc: Fix DPIO error path issue
Date: Tue, 27 Mar 2018 14:13:32 -0400
Message-Id: <1522174414-30380-3-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
References: <1522174414-30380-1-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: CY4PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:903:98::33) To HE1PR04MB3001.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29e7115f-28e2-47b1-6787-08d5940e8a6c
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB3001;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 3:a5d8PNmxciqIyTuamCGbt2uatY+F8P3hW3x3Cl7D3HfWkUzN1uraCPs67A0pkvvl4C3xZT9BQ4JuvWZlGruUgJsblpsOgz1kV+mgnleJc1EIML54ReB13PwEAeyluY6/+1g2PI6TvoUzfp3LZO1XnMrGzplObClFL2YFrVRX7oMgkjRXrvlM+JLMcaVfXBEJbkcqoWyqOcO1JBKV/pLWjoh+sDnQUrnxcNBvrTLIvPo5xYN9gVm6Qpzjs/0sTuIl;
 25:RxF/jVbx/E7BA3g19DVqQOsoyAVeAIgQUT4rLm7XMCK38Q3BhebPi5zgx3MzRvvloazyHaVUauVlYuVYxo2oLm9h4vk+hCgp9eAZueJOHtWuVcuymE9leUE/inkey+r0n4DRXUWsMVO3uXziTgF/BjkKBjyhZC3ZXrUfbjGD8B1r3kbFBtLc0x1y4/ZnmirP5GKQ7Pum1Q5A7Ryr4IHlgRu334OHVMD4NL7+ksH6/d2ZbWL0Fqpd0cjYs2Jst9B1zP3WzjmZkYs8o9vqqT+WdOgvpDP0aCiZBBb0MDFtyV0fDzQVwvH4WINUXOIvXsNzqAzV2v+ZCMldcrPqGP2ZfA==;
 31:Dl4UxprlamENrolviqVZzQ6Sqjv1Kzl6MKY2U+vYd9w3RCWk+iNaOAFKcVIk+OtgCaNLdx3ljgXTHrZRfWlZ8i3VfOzobBWySTcMQDG66Rkz0ondVMpI6yoL5bwSLC1LQGLqGtv7XTGkKLd2/gNkUlaOLPnsLkKEatsjQIIhLa0vpVSp0KXUhwRpUldARI5IuFnkdXUA8McWO1qMwOr2yjmtRPS2uOJYnTw9wS6gLnM=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 20:sf5SwllxKL6mOdbqUnItULH17emdDdUNwsKANfqarTUHHGQiePqu4iaqvG/Ez5GKJMh2Wgp4wIha7aE2Tkkr5tHSCN8LmzQv7hcaq6NwatgHLafBBB4plS1E0d9lzE6LJzrGJX3JVSix4uQu+LrmyW4EkHneyaHZMwmHoGpnPbL7mz8nbaFFVEfbmNIWyq1ab/hA13XEK49t3a85u1gYmxI8et0pYCBbUy4MDO/FOxhs6L1IwVEbORr2V6rqF8hCHOckkZNZRweLw37QHOiaNVnFvlLCczeVVd1jSyfeE7bbZ9qFdOvd8yCugNEdd8xpJRHTooc76ztX7a8vB4Vz1gW1fTIPHzzeeHYt10yM8ElRRYzgNM0uqKF/rXcCLR2veO+OH3P5i+7Th5GLOJQ2yVDEQgommIipRVcEcLPDMMeM8fw88APv9hLJU2e/cUheXUiRfMsgk5pAMHX7ukX+/O3BR2bdzJ4ZEFqm/RMUKYvxjk9ABR3yv6w0EC/Iwg/u;
 4:0XyJhb9tSLYfnsEF0GafUjfSeIVeyfvHGZG4Wkp/BETQ7LjSeSdCLztV4ppufIy4PVmiKZH/afgpKrgjdNn7HEhdJdds9nSyToHMkhTYuULQogwwtaXQ94CjO7shAGr9cbXkJOlP1lrNar2T4jStFtSpZtJL3mWjJVrtFsd+Y+7VOSoy1Bsp26Rv4tBJ0Opayw5fi09QdDd8Ncm56G+FWOnC5ZOz5S8UlCJBwOP+KkTrCM0yETKHBg4yUFqVC33OOKD64HnL1G9cybzKZCCe4SE6nsBO4KloTOuvJs4WRZYH5cU1uYliW9El1LCNczINpHO2sd1RIp4rRPJK/dImL+zoEdYYClJE1pDdhp0IpsQ=
X-Microsoft-Antispam-PRVS: <HE1PR04MB30014679F4E49FE39CBF4A4986AC0@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:HE1PR04MB3001; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB3001;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(199004)(189003)(16586007)(16526019)(47776003)(8936002)(43066004)(106356001)(316002)(66066001)(36756003)(53936002)(50226002)(305945005)(2906002)(50466002)(5660300001)(86362001)(4326008)(3450700001)(81156014)(6512007)(81166006)(446003)(48376002)(7736002)(956004)(2616005)(6486002)(11346002)(6666003)(76176011)(8676002)(25786009)(105586002)(486005)(97736004)(51416003)(3846002)(478600001)(186003)(6116002)(486005)(59450400001)(26005)(68736007)(39060400002)(386003)(6506007)(476003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB3001; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR04MB3001;
 23:pAKWnFws2mSBEO8d+OzjcLlus7m/DxXVx7QFGd/rS?=
 =?us-ascii?Q?T5W7UdRj5f9sAN2MEZJoqhIPvBI4NGB4GrWGPL1AyefYVj5W/AWrqtcWXIsa?=
 =?us-ascii?Q?PKLsVVp4ZFiPtgy8pCpN3rCKW7XikNmMqCkol4gR6tQLjeBNMRzFqQGEEWqM?=
 =?us-ascii?Q?mnGSMHWnTlIYFZrTij9m+Il2hOHh1drxVff2EzzztkbshMHha7WpsgdWyrPp?=
 =?us-ascii?Q?pFuiAEMsdGwcFybmBCh4GlNeYp2eZba2yvK4BCp0wk78ohFq7O2naKPcxhxh?=
 =?us-ascii?Q?R69hHG7qUEIpBd5Wk3H4zD55N4d/8k16kBNtTFCSMZE87eqKPYU/9922coD6?=
 =?us-ascii?Q?NvIftycZjZtI5SmT60xt4LhgT9Hq/S+VLO4cJM4cUYcF0xUXrA+SujzLQRRo?=
 =?us-ascii?Q?ZLv097errSbSjT4QK90qdo/d9q7c3d99PcAV7wfPMPFypfipEUSqJvXpcug4?=
 =?us-ascii?Q?k/eMSg2LwTA0C8CNcSDjkknGVNyQbKBJFFwiG+zdECpMJEGLacUVJDLL5jlM?=
 =?us-ascii?Q?d8iu3YGWR4rOkzTY7qgOUW7sP8cKRLyW0JxdS0n3O2dL3p910pGfTMqM/SL0?=
 =?us-ascii?Q?0JEGvsMIXapMIT/oW85+i62D7k5lZ6QzI80IchIilNblsIEUotbxxu2I9pvK?=
 =?us-ascii?Q?3LurOz3TnKZAC8HKPokLJt8RakQTqWiSJdZncK4yPXx5nbAYE+8hibopZKrc?=
 =?us-ascii?Q?7cX7dsKq1gbA0UO2EbufwFw5A/uftBX4bARL44goa3JmRh2Sb0i+ecv2Bdsg?=
 =?us-ascii?Q?D4/ZQFckvP8cluuz90UUXunTJAEebR0l1d6QsWKH01fMszh9HgVCL1L/5g0b?=
 =?us-ascii?Q?Aw8XcQISk9bztuynYM0Iz4BYqs9OA3Jf4W5nKSuH4aoQvy2XydtQb0kzso7f?=
 =?us-ascii?Q?4pBLzK+GZ6gs/1Ho3KO/9IYTzLH/Qwi0FOjOJMI545AAljcA5PYH/IZCtRY6?=
 =?us-ascii?Q?WEsFKifZdYk+M7oS3XX7OIe2BwEhcCg+opemG/0XbRLtALRgS48Skrn8Hjtb?=
 =?us-ascii?Q?VEhziQHMBHyLAqUIKw+f7J0prt8VF+KUNEo35PUP6MTtvtxl9eqXLtRQ4Lwv?=
 =?us-ascii?Q?/prWHFrwbAvk/saKsrw/tqHt+UJ8OhD4K/8EiRPaDtRAfC0pKPiji73DPBIo?=
 =?us-ascii?Q?9FOXG+YfSkWUZ4XxlbqTe3XPUwwGyLrsse4/pHOIe1Yk3XRkI7aFhNZdunlW?=
 =?us-ascii?Q?MarGMP9ufXTv09smxZuAgXAkjqfVYC5Pc+72m0oCssUXkBseP+T36h2i7FV/?=
 =?us-ascii?Q?rEVfH1U8PaQLh+0MshkdrH6YLuav+KJUh/vazzA?=
X-Microsoft-Antispam-Message-Info: 4dhlgpfaJaA8Ju+57kJpAWxdoNucg36t2x2IyJShPyTDfTqaWGTZ/jHF5UUKzA5/JfN2QovK8BW3If7cZJ9Hco3B44CcWcU1zaW7UBgJ97dCdxdegqVVXF/2Ld8qDzyDFwAjDTepoi9/2YCiTH6tpkikvnkhAjcZfjq5uqDPLGJMHW2vfyY9qB/dOn/cmf+6
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 6:/6R1ZE66ZimV20juvmBVIkyoRp/NjveOgMpLD8f/PXXpeV4FXk2VyS/o2eD3nerBRDaB/B6Y3GlCpm6zsrgbmxbdI18V9/rqCijoQk8pxP6THYlZAdo6vi+GUWtKYeMmXl0Mu3Eb7YklHi/k0/WVzNmJD1zWNisV3IMA1p7RV8TcsdKXaf2jYlZkQcDDppJXXJp04XY9D+1TePNgnExPWDabS3a52fbRT3hpAtXHL1j+I2gVGPVO8Wg0mTF9yms0KOlwylqMBini/+7XbVm1ApyYiPTyd4uWlmMxBxfXtpJ+SPs2Uzkq93/Ss9BYr2v5jLQoUU+/jkilSiU5Pp9sQeqvLK6ik2Udw5aul5tVvTvp/qyLNJL+awjGJCxvOca+vOX6MlLqCMslQPvOCN5Ut/mNr9b3QWKI+GhnNfEN+Zl+CtlHbG7VEeFR8vAFiu2lpbAJGMZ5LQsKFIbDntDIYQ==;
 5:QobkF8ITHyVrA/26qHILggKqlww30IfBFoxy5wAK8x5kwtPHbun7y86YwDqiB+zPz/YJOi/F5rwK7W1W4TyJqvfeXaUpqJrs5tzuu/teSLI0JQlcE3iiGpHwc5ITYPoihZKTAP9N1QZ+r1zAe5rdowi6ZPFh8OYleaQ089Lf3EA=;
 24:xESRKrRhZZof151Syo6wxQT7k7nPojWjQWSgxqi1xh4lKM/VdRz/dk6NstvWQ2532QmZtZ22ejnvHf2oZTyg9XgwpAjgRRuDvl0Yys8kodI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 7:esfoSdVJ4o2+GrKHfS5BATFDLDinC+jkeh9yI0Zdm7lBJ7ZkYZI+tM6AFCIFnulUwQyx5TOEXYpDysnkgsXk8sBf/zXXDpFzK6je/21UdZoGtd+075bWQOqKVsbpL/ljH2xf3bQFAnW25Hwyrh6jYM2tCkTXGriIt+zHva7hYX1FzcmDy0HGCFr7hIKpBuZvbh89zGUo8gQOmsWo1gvOXrhsx3cgjEbjAo3QB/9Rr8uCh8VV2vaDFWU/Su5r1Kxc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 18:14:08.0140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e7115f-28e2-47b1-6787-08d5940e8a6c
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

Remove unneeded call to dev_set_drvdata(dev, NULL) since the device
will be deallocated in any case.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index ffcbd5a..9e12576 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -101,7 +101,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	if (err) {
 		dev_dbg(dev, "MC portal allocation failed\n");
 		err = -EPROBE_DEFER;
-		goto err_mcportal;
+		goto err_priv_alloc;
 	}
 
 	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
@@ -196,8 +196,6 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 err_open:
 	fsl_mc_portal_free(dpio_dev->mc_io);
-err_mcportal:
-	dev_set_drvdata(dev, NULL);
 err_priv_alloc:
 	return err;
 }
@@ -241,8 +239,6 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	fsl_mc_portal_free(dpio_dev->mc_io);
 
-	dev_set_drvdata(dev, NULL);
-
 	return 0;
 
 err_open:
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
