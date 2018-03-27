Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-196919-1522174472-2-16176609341800520723
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522174470; b=rfrwWOInZGCBi0u8TNgsNpCEeqF9HXXfM5v5KrTJ0rTb+cn
    pnEyK3bZZmrIxoNN281eQA56FaHTX4OUVKPbb9CByhO7XnmpxkjuIKuHZ4Etdi05
    DTG1542xwr4HYdgniFeg4PsQig5oGTtObgprNhTcdWotd4Zj6KJcewdFR3pVl3x0
    EDlKuqiICKUwi10oSl47Dkm+8kGmpRvRPfT5z+XII1pIkgp0jSkMCOOpg8rCrZQT
    0GPr7E2qX0pBxGS1FbGnpfMju3pP3DM9ZcXSAelrlQ55WfjSJbm7DfR1DwfnTJ/S
    nJz9AWrDtw0/bq+qwCDh7f/JRQJk7tJ6TXc4HUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522174470; bh=hIOfdVp/I9TAagUcKBoL7QXR+NZQXquyu+KPTX/T4ts=; b=X
    vDe40oQBkVzO+M6BX7DWdOdByJUyZYFP8KJRPSe1eStCCrfDd9V+Avp78ssktKIl
    ToIHoJw2j0cs872bWFpOp8KjNqnujmyC5Yh4eyyqorPQ8TFY48lBam1O6H9sQGBL
    4BPMueQyXdiLlj+7qzjDx4gIeNqCpZu0NqLpKozEImY5BAKMVICy8utodC3EYmgr
    d8VkAMpdXGgWGLenVpsniVdk4L+UDxKIDHRW+RPE7A5gA/Su1tfX+lTpg7pW6z8S
    Oyd3XFKBD1XrQl5sPXB9NIYJO7THiK8yY30xPWU+1t4d3vjJ3WwMc/Shc2E6Er0L
    lX+2gC2H0RgTfJ1SXcWMg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=cYML2+r/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=cYML2+r/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfvje/O2+gM5ORC4BKRSO+Oa66ZKEU1lnQZragR7nFOBEaosEtbChEd0T6zO0apTYYC+L9smJboeqEFJ+h+jFK5P09p6xVOIZ+QwtPR+kAZ5cwCcjnT
    fFtPNbgLT925mF5lN14wqitKlOOBIjaSlQmdyQDfId43bdr7N28ooAHJNaLc1z89mTbMcpQTq/b5cOdYfRIRaxiJ/O5QQHg97dRg07LaQ8Srj37N9i+L/TJF
    yDkGJ0ByAipybSKnRYza6Q==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=stMw5y7y3skA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8
    a=HT4eDYJ9hZskxm61YhUA:9 a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/4] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Date: Tue, 27 Mar 2018 14:13:33 -0400
Message-Id: <1522174414-30380-4-git-send-email-roy.pledge@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcca7f3c-45cd-46c9-d7eb-08d5940e8d32
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB3001;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 3:JYIIsjls70KsDa1kCSMB8hUyZ3I5g+CjdGQqfNiwwhBIjwTcYkbUtfGJL1iBkdu90NrTwRiAvx7A6vYc8t8JwzITdkW/RuDCj6OsTKFe0eUdi2fEDEzh4daAopiTYvI3P/f/S498ujAUBZUMv08MWM137Pk4eCIMTnviMYw+rO6PbYP7pqn+4gwX4c5dUUQlxvyagBDPmDNGTvra5TY27wu7/wJdL374Uav1BMHcZcH9nPNgSkszSK6h/8AQskqV;
 25:Guwia79yha1dpoEIvX4IQCgRU+8w7JlQCps84i5WAM1oVjqvg6ilZW2G+lnLT84M7ynXXN7swIvX1Z3ThJnyZeF8i0Ub6tnmwcBZ2y17RoKANNyD/+j5xVsqQDU5EVS7+SLum5Caw4zHBfgzUHZC2pztKhM2N/iRjnKnurxdAKkXnKIfuQmTBS4H7KyednvKOpWb31XhrkzKORfM3XLzMBOMvUIii8RR5JUuSbxj6GWP1DJ2Cx1BZUFM4J6CUdr1xHYWdbNCE+nOVLhRhlfyBuCHKtGYs/OhincSXbAfcEXG1Ik8FFjb5Id95kQ+oA1KP+GmIqmLaYpz3x8xTwvmvg==;
 31:w1HdeNmMGhjgj2am1yv7xwHGcJCHEZ4nvQPgIvfCqPGXhG503XLnMhXN0f0iEKYZmo+jM3YDYVsCGc1NXPjj+g1DNcrqd/gIj4HywdPlVBNM1XppSQmSr0bRoVhoTw62ev29cdwRV6tDCqHPrBaL4jBPE+Hqf5o0LI0ihrJC1jeVBdZ6pQGhvquVznVJ+K2nbP8Cfwr9C9BRWvYIVYmnab7+CoWbaJP73iZaZHFo/+s=
X-MS-TrafficTypeDiagnostic: HE1PR04MB3001:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 20:oDRCGhRn9rtMTA6El/WEt4jIFWsbQQ8JAuKPpSujq2rzy1V7lGdymhoT0//rmxzJeV4BnybOFEG0Hj9ewpxsAGlhdv6pfpItJoCsxYVCk6jpE6ATV9/nX3DCMQ2Ws3x/L8idoFZ14LCS0stUIP+ybJK0Ce3M0kRaPeTtpya2uu/1FjTZkRCsczrd2/DzMwnHILWj2VO+QI677p/SL/sIlE94lCQC7qx07UABrEuLV8o3v9tvYQvwvA0L3kEycK8Ied62WS9n7FtOntOiVPMe8O199NM4o/fuC+S3xhFAtECLFl43zTD4SEk4zFAqj58zTHi5TOX/MbTjvbTGFqg9vfs6kU6/yxQncL3xxodpAgGB79DlQDo67xWar+u8Aql+i+9NcgZwI72OviVKZDaAlZkOqtgyl97qSArvY5icGTfONOnwCTXkwEz5wKUMy9dF/F+m2o3/2FHwnH99XDESq4Me7XJCshZjNqWesaXMoYVcl9/KHlXhYqAsZwSEZXGg;
 4:I8HTrwWguNNQ5r3+z4Z7CSm+isD4tuqrWdG5iD9+HRl6u+zwS5ihKp9Yyep13Uo1ZIUoyyDgu0Pb3zEQEjq3g8HHyG0I6nxCh0HfTZAAKuicaPhng5KntQ1O2rOh5/i+m71TZp7lhqfEall/gqsNMN5t7u2Pf6yFc5yBpG6har0ntE4UaNWyGzQMbjv9nIWiqX1alnF6y2YEHg4Eax9v6IL0j3kyFVj8JNcBTrgeNa9V9XsxgRIlMRH3nmiOnzouVS/sQKWiPCjT+zflw2Jo30MovJE2UeE3qAE+CXlOK3Wtx4OvMzuzLOYHz81OqIRCCymVng2cdgqBMH54rV0H0saGg5wEPLvzFvs5fqs3lrTTOEBBDHEwCFeOfaRVvjr6
X-Microsoft-Antispam-PRVS: <HE1PR04MB3001B3C7A0A03A2C5FE7D5B686AC0@HE1PR04MB3001.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(35073007944872)(185117386973197); 
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);
 SRVR:HE1PR04MB3001; BCL:0; PCL:0; RULEID:; SRVR:HE1PR04MB3001;
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39380400002)(376002)(39860400002)(396003)(199004)(189003)(16586007)(16526019)(47776003)(8936002)(43066004)(106356001)(316002)(66066001)(36756003)(53936002)(50226002)(305945005)(2906002)(50466002)(5660300001)(86362001)(4326008)(3450700001)(81156014)(6512007)(81166006)(446003)(48376002)(7736002)(956004)(2616005)(6486002)(11346002)(6666003)(76176011)(8676002)(25786009)(105586002)(486005)(97736004)(51416003)(3846002)(478600001)(186003)(6116002)(486005)(59450400001)(26005)(68736007)(39060400002)(386003)(6506007)(476003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB3001; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR04MB3001;
 23:QhgHDZ1M2lPhGJTFgT1CLC6smgH2fenIotX71wWf7?=
 =?us-ascii?Q?/Ws4q90/JimMy5aIDA8F4du/0dxFIKP1bul7J7JQpQsX5esglXFVvs6ZN6Ov?=
 =?us-ascii?Q?8TZ9opBKXtChv2cHyDaWZo2eCSyOEICaJ0QeOVpCgg7fPEZ7NA7lb+7p1+Uf?=
 =?us-ascii?Q?rGfQ325oOTysty032nxpqot8DIwpp6m1nGarjqk1Hovxjhj8xRamEyxVY7v5?=
 =?us-ascii?Q?GBt6dgvLtoQ6MQ6T4MadOAGDY2Pd4a+5fKrpBowZ0A/vfvlFy/0CUz7a1iKK?=
 =?us-ascii?Q?QFn1aA+e9C4lYH8chqbHGu7W+wmfpOsxgi923gSXdc/22fvwFKhqF1g+lHQv?=
 =?us-ascii?Q?o1sNVh3KjXLEmruIFcWKplCKOoWowESkH14Ba7MqZU73xjGCGt6IVhdT9sSb?=
 =?us-ascii?Q?Ijq8t3iIBnXr36ALH4w0gSlaPEtq4Z6wX1Cb2dh0Nw3/e7CB63/QXGhy/BMN?=
 =?us-ascii?Q?XsrLQ2JyoTIDI+5RVhCmxTCLjBV5UMD+oODMDgamScYyLDGgk+RI6eA7czwC?=
 =?us-ascii?Q?o9Wjo6HcwgDQGbSTT+jFRQ/nNnEj868VBfjrFpVLZZjJ4Y1yrYWDpa6HJCiu?=
 =?us-ascii?Q?fyDLpX4wPQ8d9mSfIDUA32b1rfYemD2JHDZpTrsihFjb6ehzE2R3iBdlRJS6?=
 =?us-ascii?Q?AHXHtEajxkvo2vwUcAs0uULoG9+yME46k7Q4Fll8cK2Bru34JqpnSqEX5B8G?=
 =?us-ascii?Q?EwpIxeIMJoBEFxZH3YsIblHt7n7GHgAm5TGEbl6ECrqgLJ6jXF4Zlb4CiCjJ?=
 =?us-ascii?Q?C5p69JEy/nHa4zTfm2CLFSFjzNlx7SgIToGd0PagRkWMZuxLtJqMyawJ/U6l?=
 =?us-ascii?Q?AS4DMF46W9zZdka4fp+PcneJx90YU8FGCJWyhVXK/35M/xnnxAeMmaqrZcse?=
 =?us-ascii?Q?eMbjhh4vfyT8Yn4aG4Vs3PYqkUFEeRZgWvTdO6bygT9Ag6/onvsorRR/uUsY?=
 =?us-ascii?Q?wPm2At6rp0N3juq1YgJuZCwjrWdRriL4xQ9rKqP5IXIs/IUcl4Im9OVKpQC/?=
 =?us-ascii?Q?pOXYyfrcBU+WeNnCv7jDumeB2SvcO0rGufnFftqe3BnDAVnyI72uNkeqGvzr?=
 =?us-ascii?Q?p1u5PMU2WADP00NI5e5gsqWC8SD0HzQbc3PWzb73xYKfIpDASG+YpUduZrSQ?=
 =?us-ascii?Q?2BS0zJdBCdrkKrGeknTNWWcq5RUZoUa4y7zwRuMJEVgQqQS+kiNNWWqbIN8w?=
 =?us-ascii?Q?5mLABFymRJdfjqeDMbUIo98IPdHnFq1x6kMlTkWx7+QwAlL2Cnc+Fn1vk2FD?=
 =?us-ascii?Q?BBAPxTJWJjNJUn7AWtOX4XNlmGNL1C8R6tHDnGu?=
X-Microsoft-Antispam-Message-Info: w20vMSNt7z9u+3Jzwp5TjLvuFraxRIQMIcJqXt8HlGp3Jtdzi88b++cRPySnBvoFIYPAJ0zVIrWoBF+EQrxK6dk/iXCuJOIUjn/BtcywJRtRe66JiJmmNpzFkxSobG5j3A9TcfkdiFdZO9/AVvnFrOZnwmBg4u+W/DqQtmEUwknMdlQcUm3t12HB4GYjvUL9
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 6:y+6MIz6PzZpuhkOema/q3gyHhnajU5D7oAzRjT5Tw/xySCcRf5Tm/fUljD0vJHdC9k/pKZoU1p2Nbi5CtcCKZ+hLoZBD9rUKq58lgRXLUufk8fUwI00XHVQG6xnx0O/qoPKOVkexeT3Bp0ft1ot3VK+hHalSPcS//Fe1J4CvbD12yw404NrCCcbtcBTe0WZrO4gHsvORvf9G6rR1nnWF+bVa4bq6j8ZUDaSuxDdj3fwJ6+UY9QDQCjb18rcLwVlaqxU5N20yWrOASJNCYVK6GplkCTggnuh95HyhCcJDLsnf+Rie8y/UHPJyEr9Rv7ELXv+UVrxMAkBuIlnD2ziEKv/CoQ9bjlXRJlQBCpq4X/rhHawH0xbGweYpB3moYqxaHutM/saXhyU//nIXT0fSOkiVIXWuncTJQBmrSwnw5QEUBRJErV9Ki+iU9prPCcm6AoHijlC0t2Fw11MT+cSfIw==;
 5:9Kme6OYnhe06lMCN+xYn3uancBzZ+eD7ZywmMNc83RvnP1GLj7QpP4tfo//Rr8dArm0HXSdQgB4C2qlpd66b6h8Vyk59gzNO0h+E8M5QRbh1Uy2EVWX06dLcnYQBzljyhBMTFQWaqzvikDVtygO4uUaGjwJYfYWHQ890DMvTj8s=;
 24:r+k0XwTDHERPX6GwMExu2WHv04CcgxuDIheALhOCAaaWQFO1EEh0MiRt4Cg1XTDzgSPVYwMgsGsMkXM5yrfL4qzAWubwVb9Rrw2aeTkIF0I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; HE1PR04MB3001;
 7:j1KkplxfXvvYu/MqdXH1KxSWuuEaVBQ9rO8xn0M0ZHF8/pgPAYtwgPB95BiwiIStbig6PAiGJB8QjnMocgb7dj8U7SEUevNe1AQjyQKvH7IK7P6OTIgkOZMdw1czx7xW6KxJLKSuwh2J3rK10QrV3ltuQPdQnYKqA5YJmxA0NXSj57aft/kKIFlT+HQJllc/Y79PpI8J20MjzPHLBhbQtRnRHzq7b171/Gd+FroY6KIhMrJZ7Em9fUVAFivZGOK+
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 18:14:12.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcca7f3c-45cd-46c9-d7eb-08d5940e8d32
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

Move the NXP DPIO (Datapath I/O Driver) out of the
drivers/staging directory and into the drivers/soc/fsl directory.

The DPIO driver enables access to Queue and Buffer Manager (QBMAN)
hardware on NXP DPAA2 devices. This is a prerequisite to moving the
DPAA2 Ethernet driver out of staging.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 MAINTAINERS                                                    |  2 +-
 drivers/crypto/caam/sg_sw_qm2.h                                |  2 +-
 drivers/crypto/caam/sg_sw_sec4.h                               |  2 +-
 drivers/soc/fsl/Kconfig                                        | 10 ++++++++++
 drivers/soc/fsl/Makefile                                       |  1 +
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile          |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h        |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c     |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt   |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h            |  0
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c    |  2 +-
 drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h    |  2 +-
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h                 |  4 ++--
 drivers/staging/fsl-mc/bus/Kconfig                             |  9 ---------
 drivers/staging/fsl-mc/bus/Makefile                            |  2 --
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h |  0
 .../staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h  |  0
 {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h |  0
 20 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/Makefile (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-cmd.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-driver.txt (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio-service.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.c (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/dpio.h (100%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.c (99%)
 rename drivers/{staging/fsl-mc/bus => soc/fsl}/dpio/qbman-portal.h (99%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-fd.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-global.h (100%)
 rename {drivers/staging/fsl-mc/include => include/soc/fsl}/dpaa2-io.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc74106..e2f234c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4375,7 +4375,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/bus/dpio
+F:	drivers/soc/fsl/dpio
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
diff --git a/drivers/crypto/caam/sg_sw_qm2.h b/drivers/crypto/caam/sg_sw_qm2.h
index 31b4407..b5b4c12 100644
--- a/drivers/crypto/caam/sg_sw_qm2.h
+++ b/drivers/crypto/caam/sg_sw_qm2.h
@@ -35,7 +35,7 @@
 #ifndef _SG_SW_QM2_H_
 #define _SG_SW_QM2_H_
 
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 static inline void dma_to_qm_sg_one(struct dpaa2_sg_entry *qm_sg_ptr,
 				    dma_addr_t dma, u32 len, u16 offset)
diff --git a/drivers/crypto/caam/sg_sw_sec4.h b/drivers/crypto/caam/sg_sw_sec4.h
index e586ffa..dbfa9fc 100644
--- a/drivers/crypto/caam/sg_sw_sec4.h
+++ b/drivers/crypto/caam/sg_sw_sec4.h
@@ -12,7 +12,7 @@
 #include "ctrl.h"
 #include "regs.h"
 #include "sg_sw_qm2.h"
-#include "../../../drivers/staging/fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct sec4_sg_entry {
 	u64 ptr;
diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..c17bf38 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,13 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_MC_DPIO
+        tristate "QorIQ DPAA2 DPIO driver"
+        depends on FSL_MC_BUS
+        help
+	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
+	  buffer management facilities for software to interact with
+	  other DPAA2 objects. This driver does not expose the DPIO
+	  objects individually, but groups them under a service layer
+	  API.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..803ef1b 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/soc/fsl/dpio/Makefile
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/Makefile
rename to drivers/soc/fsl/dpio/Makefile
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cmd.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
rename to drivers/soc/fsl/dpio/dpio-cmd.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
rename to drivers/soc/fsl/dpio/dpio-driver.c
index 9e12576..758682f 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -16,7 +16,7 @@
 #include <linux/io.h>
 
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 
 #include "qbman-portal.h"
 #include "dpio.h"
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/soc/fsl/dpio/dpio-driver.txt
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
rename to drivers/soc/fsl/dpio/dpio-driver.txt
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/dpio-service.c
rename to drivers/soc/fsl/dpio/dpio-service.c
index 14ed2be..9b17f72 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -6,7 +6,7 @@
  */
 #include <linux/types.h>
 #include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
+#include <soc/fsl/dpaa2-io.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.c
rename to drivers/soc/fsl/dpio/dpio.c
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
similarity index 100%
rename from drivers/staging/fsl-mc/bus/dpio/dpio.h
rename to drivers/soc/fsl/dpio/dpio.h
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
rename to drivers/soc/fsl/dpio/qbman-portal.c
index 116fafb..cf1d448 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -8,7 +8,7 @@
 #include <asm/cacheflush.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include "../../include/dpaa2-global.h"
+#include <soc/fsl/dpaa2-global.h>
 
 #include "qbman-portal.h"
 
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
similarity index 99%
rename from drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
rename to drivers/soc/fsl/dpio/qbman-portal.h
index 69db3c8..89d1dd9 100644
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -7,7 +7,7 @@
 #ifndef __FSL_QBMAN_PORTAL_H
 #define __FSL_QBMAN_PORTAL_H
 
-#include "../../include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-fd.h>
 
 struct dpaa2_dq;
 struct qbman_swp;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index b8990cf..24ae387 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -37,8 +37,8 @@
 #include <linux/if_vlan.h>
 #include <linux/fsl/mc.h>
 
-#include "../../fsl-mc/include/dpaa2-io.h"
-#include "../../fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-io.h>
+#include <soc/fsl/dpaa2-fd.h>
 #include "dpni.h"
 #include "dpni-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
index 3424530..90f234d 100644
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ b/drivers/staging/fsl-mc/bus/Kconfig
@@ -5,12 +5,3 @@
 # Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
 #
 
-config FSL_MC_DPIO
-        tristate "QorIQ DPAA2 DPIO driver"
-        depends on FSL_MC_BUS
-        help
-	  Driver for the DPAA2 DPIO object.  A DPIO provides queue and
-	  buffer management facilities for software to interact with
-	  other DPAA2 objects. This driver does not expose the DPIO
-	  objects individually, but groups them under a service layer
-	  API.
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index 21d8ebc..2141e4b 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -5,5 +5,3 @@
 # Copyright (C) 2014 Freescale Semiconductor, Inc.
 #
 
-# MC DPIO driver
-obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-fd.h
rename to include/soc/fsl/dpaa2-fd.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-global.h
rename to include/soc/fsl/dpaa2-global.h
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dpaa2-io.h
rename to include/soc/fsl/dpaa2-io.h
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
