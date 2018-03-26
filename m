Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1713507-1522091177-2-15676574088845642029
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
    t=1522091176; b=lzgwolAYCIx75yGSUtP9dHcsjK8X/ul4Z+mCXlxTtWnexwj
    1VI165q1naM4/wqAsCwbcipBvXt5JDNCNLEW8jmpRFD4+84YOCAj1rlTpIIAc7ME
    KVshlIWBmcR7NVooJ7yZLJj76VL3fQGxe3Y82mHBvJ4qmB33zZ9u4SpVRLwrDgKH
    PmEX/HfpY4c50aeXNAXMShSMQTOImTYppmXZVhoANrQ9nIvaBFD/JuWcPQoeETDJ
    egWVv3q2PJHeZyXHAePX6g6Pl+nB+EdgpDCKzzmerpGsFTfWF7vp68ejastajOad
    kICrIWbMtvmv74iTmqqDn14KXNAVJEzz90JtB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522091176; bh=xCyxA+r1KMfETDEOWMgKg2BjEN0NPDn+odM0w+qQ83g=; b=H
    LlbOMujDN7UH+xVqN/PnAYATHfzPPIcDDc9RvwDNI90GSy6rKA+KTzz7PmonBEcN
    kU+QhOl0pgcNBZNhUuuro7zyXC2WUoYzGYpBgOGpj6tEAbt5d/XjNaFbgb/Mlq0J
    q/0/iVuO4kV6Am82JHXPJLK498ZMQKClD99qaRtBQLhsPq1IUkYbtLq4rjk84BuP
    Qnl/tcNgs++TfBuddPSmFLs2bQVmHBWj116YF3i3KKe+sfU/U/kE0WXNCac/ZVxX
    f3zcASIqaoxXaPT/sl6o5GMzfBT89yjz/C575AF2KecaEPg05VTCnu3F3w46PR6W
    cRenWz4W8tKm3VQdQ+teA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=eb3eWdZX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=eb3eWdZX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfI2Av7CdaLLdYGclxQ3d7hg1vwm5AYFvb2BlabF/6Srej39Ux+JbrxblDHKZlcLYmMdDCniCpAYhf/WZfrreeh4lJ4oMdEVcuVhXQR0qO4ugKNcY1AHv
    Zr+zfPG9HELvsEWLf4U1QKUlNT1Kp+AqJV80PkGNr1QUjmj37js1B7Ml/uQLhrxLWte5y/AOMuJmctVokcPIqOCogO41OQhmYW27AqE4zkJyQemr+06hFBtH
    HPkrq0MFZHbXUgQBUFlKgw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=JMP4OFuIcRoA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=XCdsj9khIkKegqgoYiEA:9
    a=WkY67Wxh_9EpWfIZ:21 a=aP2opMIevvYM3u3I:21 a=CjuIK1q_8ugA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] drivers/staging/fsl-mc: Fix DPIO error path issues
Date: Mon, 26 Mar 2018 15:05:32 -0400
Message-Id: <1522091134-24646-3-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
References: <1522091134-24646-1-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR1501CA0025.namprd15.prod.outlook.com
 (2603:10b6:4:9d::38) To AM5PR04MB2993.eurprd04.prod.outlook.com
 (2603:10a6:206:a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da6638e5-42fe-4f3d-3fd5-08d5934c9d60
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 3:fXyMqSJr86d9GU5iPom5bHKYHpx8pQGKvx96ERleZGHMvCbYYIFKsT/ohnFSExTMtbWz+al27iuYI23A5FeO/WAH/FGCVm75vTfYyOPpqu9jrMuXRTf2/ASVGMHrecNUmmCWJ/6BJIel4XN9FNlPzsarQDmxERS0CQccKHgzhuYHODQRRjSmmZ/NN+BVjqt9qK75HXeqzKUP3My7scLmPn6RiNEZuss59wuXol+v4gm9oGgMXgX1gZXVq3+tVnCv;
 25:0J0JIxcnq+Ry2uCUkbxzBhZ7b5U1UCilM4lviyWh2ti7WcqltQbWX+SHQsxz+h5RcYIlwPg8/2l75OBmvcwFRknrFniM/OtkU/6xKV13+i6WgM0e0F9e6pNQkapmGO1NvRSxm/gwvJvjhH5YtLmLHFjkuUGnv6/mMBrlPq8E/UIIX22CwCJQofGYsnPMdoiQinb+ni96Xo2s1PclYAOFjWkzWuCCgixkPCuedCo5sf3AfluGebVSBTZsJhsZ3tOL71SPncnrANu4bSjeZpH5+JbCqfukGx2Wsiq8QH1w2Ei9FUljSzfTALtEa4493NEvGUdKlc879eIdUmJV+OF90Q==;
 31:Y7ZbDIxlhxUIYrr8rI5iTHDo8tleomFwkNqoI4pLNU8Hwy6GsK1EoqAwAVu2ruIn4xfjn7yVYuA8q/XHN9mULV375HEmPiZrJgRQasaY0IzSqwXHk9hzzulY4yXuferY/wf1EvJKoGBFDXq7koP6p9/F3azknA4JUNnL7djIlTNrJ/dBxDBPqiDhEUa3VXHEba9vAEryGUPkKFztmQVRodQs1GKcoO8enK0fhyM6mc4=
X-MS-TrafficTypeDiagnostic: AM5PR04MB2993:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 20:3t6FeeiPiPn4AVyAr0Qh0E3u5wANif5hfsqEIf3j16AnfZTIS8AOzq+o2bYuoQ1OZtmilflp0WOTP5Qq6xZ7aKf7O695jSA0m4yGlE55ohMe69xeJhKbcB6LgctLa2BA1IAeH5UgaL0X0v2tFNveauFomP0hG+Vm8hN8t3ovCv3WnNQKmXXb7/xZ36fUiMo/J5Qy37AZqUvw0Da2T3w5D2zksKiYY5HrJHqMYXbRa0ymiUpDPnZqfAGo8eAS4Y6mYQ9swLQHL8i4BvoCQtYUKHHOyFkh8uPvNIQLeBf81GhBJisWaAB/yfc9hCCXQnbToWnTTaU0yn5XFvCVveJxbNIRYXHabCadE9dg+rT0Xd4Sx6YLLyS2dVgUi667IsrUl+AwqSO4mAE5a+HgftoIXTf1dBZ7xL2eIIousgEu23KnqKfwiVQG/Uq93BO8oYZxFLmSLFhTUZTLoQS/lpT7MITMEqptnix4oPtUG9K3i9g451rc7TDQy4Z1NBH2Rro7;
 4:ESlfU6Nq3uKGnQ65mz2qLOywF4yl+PSNkz0QyTkTh03Yj4rNAKGfjDkS3MzYkeXL1kZQf7gL6OqUrtoS07f1gbKhhS7Ga0oxoVHjFObpu4bHqTJaVsHtRcrvNw+B7kHppTjv0QSxpjg2hphYwZ6ZeoCKrgskDvwI99FXyapof6S4l8rA3Lgc3DujoX0YKYSJ5882Gxz0KlvdUDbxRMfr+fBgQBZ1fflnElx3MwFhyz6mMsrkvhlceJrd3psx0uS+jCq+akAQsJjl85RJiJHjl0I5HK3OqqBoM/klvFS9wD0tABNqJj/TqsckzmcN1aGhuDjsGDoMqfYNkc+mKn0QFDbGrLrtyEqLUCAHyoxD0uE=
X-Microsoft-Antispam-PRVS: <AM5PR04MB2993CC1322CA61A274F9249886AD0@AM5PR04MB2993.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:AM5PR04MB2993; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB2993;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(106356001)(66066001)(478600001)(47776003)(6116002)(3846002)(2906002)(186003)(16526019)(26005)(68736007)(51416003)(59450400001)(76176011)(86362001)(6666003)(36756003)(43066004)(25786009)(6506007)(305945005)(386003)(7736002)(316002)(50466002)(16586007)(105586002)(39060400002)(5660300001)(97736004)(6512007)(3450700001)(956004)(8936002)(8676002)(53936002)(2616005)(11346002)(446003)(4326008)(48376002)(6486002)(81156014)(81166006)(52116002)(50226002)(476003)(486005)(486005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2993; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB2993;
 23:wLAIn8NGWKhHFT7koGdMBVXpUN+fIh1Gcz1KM1cDh?=
 =?us-ascii?Q?suglOcZAAGmb9F3g8uxlHwbrk8ef/NKqkyD4GCXfqi4sOobDVKAbtV8H6oUz?=
 =?us-ascii?Q?SU47mvL7ls7pN97X4Tx71N3Phtp7VV2uMvjEGORClLD27b4sozn/mpARfTGh?=
 =?us-ascii?Q?q3jitlZX42vRfuEQUJsF74I3Z8hDgJu4+kRV4SWsiGK9KQXzXuPtESwQPbV+?=
 =?us-ascii?Q?VD6/CZGift13dxC2zR98dZu3smIH19t7qUihhSZAAXsCnEJFTJjJC/HPYXXo?=
 =?us-ascii?Q?HbiqQ/x/Hu43xKZdQNXrNq3YTVQ17LrkMDauFyqo/kdLH2HjJDBEpO8uP2qt?=
 =?us-ascii?Q?GCkjkeX4WZgYGO0I85cH/HiuvXviFwdcLSAJueLxT5Sg2SJJOua1NpirDDwO?=
 =?us-ascii?Q?BObQLklIzoS6r+shq7SPj8H4G6LOLau5yhuC3HoVqzzuYAW/2VaKT9nraSf+?=
 =?us-ascii?Q?DO6byDbL3EU5rc/+eA33o7yP8gT/QNM2sLdQsUIuju869oYHYJp7N3RDYYRk?=
 =?us-ascii?Q?0B5xgdcbitaKx0NM3affMNe00JaOQJj9Cj5RZLHWQgyk+Xc4y+0Fo27mASiE?=
 =?us-ascii?Q?Yw90J4jX0moPZ6t2+yZhFcsFebuy56tcvXfgP2oSs/TPXPW5zMScyogxbbcj?=
 =?us-ascii?Q?8ZKUamc3j+nkrx7Bgn6+tANVeZn5knsrYSvLobb5F/3unjEOfFcSP7l4g1OG?=
 =?us-ascii?Q?jVzksBAxSWbFKs1jimG5HfkPd1TvUauHqXQARHisaP5uadAL3HSqWrY+8tY4?=
 =?us-ascii?Q?cAdxaFhzXS955OM41Vw1ZpRhFNLCp4Qk42wIJMGy9o1xGEXsMJQTnek/qQL6?=
 =?us-ascii?Q?yjj7A2LugI1X9v3rH+tOaaCP514FZGsmjyBwhnY3wPUzc+mnSwdMRUuaGlVC?=
 =?us-ascii?Q?P1U4U22qcwYXKxAxGCYRVXxM9izmZcYrKsNyYYPYhQYFUNmMMcDb6AIWrmSw?=
 =?us-ascii?Q?IGYUb67uhVEHBPys/Vt7AI2Yo5cGSsHYeEjF2hLkt1EJLjxuiATfrZoNhdlJ?=
 =?us-ascii?Q?OYtxeOehdP3Umq/+flQ5L7l0McpapXGqu5YRYRdTI8a+yMKfNofcLF+VJQFw?=
 =?us-ascii?Q?tF5fnuUmQftfhYI/oKIGhDlBmxQe09/CIwBOHsV5yqIlDhXzA0C2IPIH78BE?=
 =?us-ascii?Q?ny2e+D9Q/StJC5ab2dpqXjvrSk/v8lv5Fddypgm1mMSLjh0rnSkAybICBwc3?=
 =?us-ascii?Q?eJGUOw88XTrMX9DPQe7SAB6POy5bLKo5dv1BAvHJnfc0fIJCsZmpKiTl8Wa1?=
 =?us-ascii?Q?CYkkT8r9AR+MabxwyNKcakWIs2W2CUr0Qg4/rcG?=
X-Microsoft-Antispam-Message-Info: WD0vYiUYGNn2+mAlLROuVxFU8fCUh3iopb/nDBS8OJnDPVCnJ9GLD5URzMOCrCMfGBPtF+TPmUdQVYJDYwZaueNRPPmTn8thmdKskcykFs1mhI1LAZ1I8dpaRVWZHd1aeKWUIlE2rFlbSKn08iHoXIz6Kwnz6MPjxeSU+UZPd7ieage8/iJpXmRUcn4MUQLg
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 6:0Fljb7h5zakAOoe7UHhOL2zqTnKag1kgbGSQsV3d+DR53HrRPcXHJbPQRFD0C0T5xzdHdUlxKuHeBbTQ0nVEnLPqH4suVsulkT3BMTCKSIry+2/G02amdtwG4Al7x83oUYWLsmYgZBe+a4dT5guVObl897+0zeD9EVdqQn5LFGuxsIJTuvdDlRnPGBch/AzM5YZe1IwaBvcHd2DORwyEOpt1YscsQco719yw4q4QetDktj7RpGvklaSyVwxefYMZQi6dl7WAT92Fr4HXUblI4orx2FnS8oXxH5zuxRfFS2+R1dE7dl4r9Nvb98uI5fXKEwvXkyEk6y1Yt6qLWbGY8nO8XRWwTqYyyCdchIh5h3KQ9p5r5YxVI/gUFDjcYYGEYoRM3sA4iKDO20o6WvNpUp5Zud0XJcDXinr6UmiqCsuoR4z/F3AVxmZtfQNvmntXjHYbrSI+htAYv8cmyEbuEw==;
 5:4OeeXCjoZhD98wzQiP+C0w7/8fZYdUQgMeL1nWnPlVfe475HtnXFUuyoKDj5h7wCxcwOj+1Y9s7PF7QlQ8Lm/uQKQxW6kwNK3Ev6z9kP0S1nySElyyGlPfxwIw/k1MoxcetyzfI9RCRLzzG3Wps19DUxfDTDni2Osf8m/LdhWl8=;
 24:aQkry5f1LUgbv2ZRrESqhJB0tyiFYExuaiKB5I2CmA/lnTY7/YdnOu10M9rXLJ4diXFAA0GkaXGbVvB7ppsiwCCgTzmHG7djT2Aw/GnasG4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 7:Vr9shMoCY9i0bRtrb3wOog2RZrcrwewOajDP02+XqpKl9PpN5sbgLNospbUyNoCrX2Jz8znqlkK9QkX8PTIQThG+plmua1TrNyXHE9Mup63BO6clSSvRWZL6gPfnDHJ+2aXe8CEK3wHJ3RtVBT9rLxieLsjZCtzPjazTzeK34HNOVgqZPFbLwCRSSNO8p4lsPMFm9BlhLbjrVeCQFyCdXlWDDMwsnMAZ2aQbm+NnHkze7vhp/qO6XOgfHNpnbup3
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:05:58.3763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6638e5-42fe-4f3d-3fd5-08d5934c9d60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2993
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
 catalin.marinas@arm.com, Roy Pledge <roy.pledge@nxp.com>,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The error path in the dpaa2_dpio_probe() function was not properly
unmapping the QBMan device memory on the error path. This was also
missing from the dpaa2_dpio_release() function.

Also addresses a memory leak of the device private data structure.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c | 49 +++++++++++++++++++--------
 1 file changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
index e00f473..e7a0009 100644
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
@@ -28,6 +28,7 @@ MODULE_DESCRIPTION("DPIO Driver");
 
 struct dpio_priv {
 	struct dpaa2_io *io;
+	struct dpaa2_io_desc desc;
 };
 
 static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
@@ -85,7 +86,6 @@ static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
 static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 {
 	struct dpio_attr dpio_attrs;
-	struct dpaa2_io_desc desc;
 	struct dpio_priv *priv;
 	int err = -ENOMEM;
 	struct device *dev = &dpio_dev->dev;
@@ -117,7 +117,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 		dev_err(dev, "dpio_get_attributes() failed %d\n", err);
 		goto err_get_attr;
 	}
-	desc.qman_version = dpio_attrs.qbman_version;
+	priv->desc.qman_version = dpio_attrs.qbman_version;
 
 	err = dpio_enable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 	if (err) {
@@ -126,9 +126,9 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	}
 
 	/* initialize DPIO descriptor */
-	desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
-	desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
-	desc.dpio_id = dpio_dev->obj_desc.id;
+	priv->desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
+	priv->desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
+	priv->desc.dpio_id = dpio_dev->obj_desc.id;
 
 	/* get the cpu to use for the affinity hint */
 	if (next_cpu == -1)
@@ -139,19 +139,28 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	if (!cpu_possible(next_cpu)) {
 		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
 		err = -ERANGE;
-		goto err_allocate_irqs;
+		goto err_too_many_cpu;
 	}
-	desc.cpu = next_cpu;
+	priv->desc.cpu = next_cpu;
 
 	/*
 	 * Set the CENA regs to be the cache inhibited area of the portal to
 	 * avoid coherency issues if a user migrates to another core.
 	 */
-	desc.regs_cena = memremap(dpio_dev->regions[1].start,
-				  resource_size(&dpio_dev->regions[1]),
-				  MEMREMAP_WC);
-	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
-				 resource_size(&dpio_dev->regions[1]));
+	priv->desc.regs_cena = memremap(dpio_dev->regions[1].start,
+					resource_size(&dpio_dev->regions[1]),
+					MEMREMAP_WC);
+	if (!priv->desc.regs_cena) {
+		dev_err(dev, "memremap failed\n");
+		goto err_too_many_cpu;
+	}
+
+	priv->desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
+				       resource_size(&dpio_dev->regions[1]));
+	if (!priv->desc.regs_cinh) {
+		dev_err(dev, "ioremap failed\n");
+		goto err_ioremap_failed;
+	}
 
 	err = fsl_mc_allocate_irqs(dpio_dev);
 	if (err) {
@@ -159,11 +168,11 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 		goto err_allocate_irqs;
 	}
 
-	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
+	err = register_dpio_irq_handlers(dpio_dev, priv->desc.cpu);
 	if (err)
 		goto err_register_dpio_irq;
 
-	priv->io = dpaa2_io_create(&desc);
+	priv->io = dpaa2_io_create(&priv->desc);
 	if (!priv->io) {
 		dev_err(dev, "dpaa2_io_create failed\n");
 		goto err_dpaa2_io_create;
@@ -171,7 +180,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 
 	dev_info(dev, "probed\n");
 	dev_dbg(dev, "   receives_notifications = %d\n",
-		desc.receives_notifications);
+		priv->desc.receives_notifications);
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 	fsl_mc_portal_free(dpio_dev->mc_io);
 
@@ -182,6 +191,10 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 err_register_dpio_irq:
 	fsl_mc_free_irqs(dpio_dev);
 err_allocate_irqs:
+	iounmap(priv->desc.regs_cinh);
+err_ioremap_failed:
+	memunmap(priv->desc.regs_cena);
+err_too_many_cpu:
 	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 err_get_attr:
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
@@ -189,6 +202,7 @@ static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
 	fsl_mc_portal_free(dpio_dev->mc_io);
 err_mcportal:
 	dev_set_drvdata(dev, NULL);
+	devm_kfree(dev, priv);
 err_priv_alloc:
 	return err;
 }
@@ -230,8 +244,13 @@ static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
 
 	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
 
+	iounmap(priv->desc.regs_cinh);
+	memunmap(priv->desc.regs_cena);
+
 	fsl_mc_portal_free(dpio_dev->mc_io);
 
+	devm_kfree(dev, priv);
+
 	dev_set_drvdata(dev, NULL);
 
 	return 0;
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
