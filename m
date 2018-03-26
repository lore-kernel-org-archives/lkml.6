Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1713507-1522091181-2-6499092385276424987
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
    t=1522091180; b=QgfOGJziD+eOjMFu84xc7qxB17eTfxSKRHL9qRrCtbx6qp7
    zPZM8e6oSxndB415qN4Oeo4OoG0ERPCuKITYBaMplj9anH1O/3I2rpEVvKn9C1jY
    5xckBbdpDmS8YmyW48ebtFGzs4enbNwKAvL0wXQ1hxoi7c4XBvlyhGIdTP7liBVx
    M1c/twzgobY1OpkZd+69iorjcb2wjtteMDVGkB+X2/ZKH0x4era1OKySq2E5bZZ4
    ZIrWEKCcvABWlP3+gRsh5c1ACVqtjAgRODqd4VukuT4QcV5T1+uWROFVvppNo9ln
    ulq6ZRI8NLrQtZ9WhyVB/ZJO8D0ZRxpCdBbHyjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522091180; bh=8uKWw9otARhhWrwaKNJ7EBa3aNoCoh1c92WaRRhbvzo=; b=R
    VWmOy1P0/McMYIB/xo1E/oiFcNvB3YgsSBF+bQjXOGiWTxk08HjAPqolh5/qTUT+
    qKsHPSLCzAs9U832kQECRwfQu8AUDqdMV6Zy/6gYMI6ljQnPS1e0pZ4OegtWNpdt
    m+ylqHDOu4uDoZfhOQ2cFRg2KG4q6GtPDrrrCpqTktz7eq3598qufcP5AzqkUCbl
    sTkeyVJ4r3peyng+/SIbUFtnoeHpAxN2GiIVdFTZagiVeCxYxHYt0g98FrMGVoEi
    0eaJbvX1p3+dfhLKkIRT7xpZkPPEKeXFWoGFD+t95eMiPf0gadq5auYR7kkANfii
    6u6N0TR4zl/EkrSrM6T6Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=uMKrNbNS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=uMKrNbNS x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOdtwzbOt36vYfekhIFmUFD1ha9soEqWStg3k1Byns89dylfVUsfg9pDTR0TpqTTy3ujpOgPM3KKgkUsMxPv4yYFuELVufA5Rw0oBl0Sel3hBJtZMHmi
    dtrsEh3fT/s1GU/7eRYh5bZybbH2bxFdGlFp7uHrJSzIhvVs77unmAvqKSlsa31ccYV7PKZ1OVAqzzxU9aqUbd1/FUhs0s4CdQbsV6h2xbE4iz1icXobngvZ
    WpszpqWLE3OQB3+rFcJiiw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
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
Subject: [PATCH v3 3/4] staging:fsl-mc: Move DPIO from staging to
 drivers/soc/fsl
Date: Mon, 26 Mar 2018 15:05:33 -0400
Message-Id: <1522091134-24646-4-git-send-email-roy.pledge@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e3b69e98-6ac1-4f08-67be-08d5934c9f3f
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 3:uqP8SAygJTr9P+IUm3YxTjTCDXX0Tgyyo3tI6hfcRkACaNMKS8wDu1AmwDRIwb8p+Uccac3pbaTe9Fir+QP5ijCcf+8S5ZJHoTjGp+eDDNwshLBC7qmMFXXW6vohW89zgqOPTkYhh2ftMLSnFQEEOhvF0HX+S8HUp4GoX9TE3pbterkqmhQAwOFOOIvLK0It2auJgXd9FFBhSaDA9u2j5LxobNNC0efDI3agg27azTdTWDe74texx+LExAWsssTC;
 25:SodqYpuHc5DSrpC2Mz+eLH+mWJWNvnzV0pA+8uldM/1VID+oar32M6ZT08gnzaqcS1pvplzUuqsCniTIKjKgoaztA4IgqPfxm2aGMjnDpVSKTbRPehAg8OlPxvXO2qnYccHRCj0V/gMZARXapv70DxK8VRKZolnlb1y0CLKpbA8O9XF6klzzcsCxMqE+lAHx7BWTpHOH25ikG96onwAIRxLyUcoCC6BQcR1m3f9m1cuVIviJ7oj6WqzpLbJIYdzy54+ZpmuZ/dmWqemJWD7KvUAPyz/zLbPHSujJd+i/qytY+xO10ctILOsV9pCPbRgG4XfgPDp5LhEn5Q2idEHV1Q==;
 31:vz1u5cjzPW/UUg4d0KcggSzmOgNjbGqe5v/WDU+VGlxdHIINFpWcRLyjmQDuheKW/WVLIyOLGD0FpjDcygR0fwXJdWhUJ5/WI+yu3mmSy048SlvmbQJK/mR85+5v7HpWNNV6/hTxo7Ie7XD+tYl8F4U6drneyc9LoEHxuSFr9bh1Eu5wSVPHd1hleRJV2P+apavaPeKufgkiZByENaBaSTSz+EAPRc9WaYbFJCOIN74=
X-MS-TrafficTypeDiagnostic: AM5PR04MB2993:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 20:nvRgoNkd8a/qfxCpjUfkwoYri7vuqgMLyeb3eubHMJPNcDi88OtB05qeuj3VloQznJrMDbhgJbtuHPtdlHTdXBdHOrqeDOzg8XTmszsLFF1y7awE2xNPzrjCUNVe+Cy0mwlgG+4kCAo76E0QtPjHqVxxDca1phaqdcGKcoLOYym2c/T7pu4R1B/erefdlfEcYeRKHNAnE0rZRpLg0jJ18zbfrHF4x+MOThf7HmnjDBSAy0WnAqSckfpFaSmyGBi39+LT5UwkR82r3OOi2uRwQX7fueFPlJc+UTc1ct7aXvqtyAxCRwwHh7cyhMmejQWlupl/v7ULHqo20dk8HG1Co8H9BY9n+FR+KhzKgJUGGtvBWvVpMkJzFvQ9zUEJW5ZU0yGH91CvSQ8sRd/LCMPMgljrQAtj7reOqkl//s3MjTEVbf4VobyyfXFYOQiyQxKlrURjQ7E2h5Cw2eXQI4YYSdZgp/x9HlQVgYayj+RiGtxM3jZGbS40jwvYOI3CyKPx;
 4:QYs2pcATFLLgYBp0xJrajwUvYKQgxZoj9bod8rYjqN0eWqpua53JN0hGM/tGh8a/Az94KzRuoD0TQV+Rr5edMWNc2RyXESUWdPsFn6H1I3NLmAsklufV9OkfEXRy8+nQPfEm88rXvz5zzMEkaKhHKakLOvLboYa88GDT9Qf9J9BnoNuSSnWGd7iHTdjmWK2wX7iP5KD1hUSkFin50uI1MM4mfvtAi7xTy2dMjXOBJE09V1LgypXOj7Zsc4uGEe9Tv7BpW5pbQNsp9CZ6XWwGFBB1tTov+pmNTUpKTk5wkIW+q3tp4mQx/5NHpqV0kLcWaos2kZXCsAuK9fsbNt6YBP5bF6bygYiggGMugDtR0qmO4RVPRt404nVo+LyyYYEf
X-Microsoft-Antispam-PRVS: <AM5PR04MB29933A6ECC2117F97E5B051A86AD0@AM5PR04MB2993.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(35073007944872)(185117386973197); 
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:AM5PR04MB2993; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB2993;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(106356001)(66066001)(478600001)(47776003)(6116002)(3846002)(2906002)(186003)(16526019)(26005)(68736007)(51416003)(59450400001)(76176011)(86362001)(6666003)(36756003)(43066004)(25786009)(6506007)(305945005)(386003)(7736002)(316002)(50466002)(16586007)(105586002)(39060400002)(5660300001)(97736004)(6512007)(3450700001)(956004)(8936002)(8676002)(53936002)(2616005)(11346002)(446003)(4326008)(48376002)(6486002)(81156014)(81166006)(52116002)(50226002)(476003)(486005)(486005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2993; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB2993;
 23:HSK1B6e1PfVIdR2LIcdishoOqVQ3wUGxX4mZ1SqAA?=
 =?us-ascii?Q?9jBgHvK5PE2CWRruhj8SmoC9U1SHEnkhR66QL7i7BFUorUXnttJgEu7KpjTl?=
 =?us-ascii?Q?hDzzMERm03ajP5RqwKORB4XBh8JxFiaJkpXTl2MAw1peE7/xIhJhAsapCq7b?=
 =?us-ascii?Q?dVoKDPTjD9dlM/rr0Yv1YYTQBG5fHV1Ufz/O1vhFqpjMMtSn0WzENSE1WKcO?=
 =?us-ascii?Q?iT+GehweRF08DoS1zMYJ8BE+ICdcagwN+dfXHAT7COXlaMw4MlBxSGIOcR9S?=
 =?us-ascii?Q?0XI4RxDulSFo+ZJ/k/OuG+qx68ZQh0UmgNBmZxZv2WeVIgNLTslHm9LKE/BI?=
 =?us-ascii?Q?lgCEYytV5Dqv0FA5GXyDT+mMbLvyDncDbKSzVp1a0w+bVMJWbXZErfoxR5R4?=
 =?us-ascii?Q?CT+myM4NFpQVF8Dlahyd3ICww1yVoI3FdPDmaVKjFvZZTXnhT7vP6oQXHATG?=
 =?us-ascii?Q?DTbys0cPZtyincdWZYQmvUV8elJP17gA3ZlbMKWWQd5vVggYunhybVb7HdCA?=
 =?us-ascii?Q?4NwbUEXrCkdBrFFkSUkqTTWKGaxbqvReJLGSp8bg5OQpJPRqEkk3mhK18u2X?=
 =?us-ascii?Q?4K06AUAvCY1q7XXQ11Vz8MroCHdjfTk/Oi58L/24IhtxgYqwGu/HDSGjUXDK?=
 =?us-ascii?Q?WKT+crUngwVMzAv3SMwWycH20DXdjwL+YKsZmVs2YGqx4TXVIRUiTjZlVEjh?=
 =?us-ascii?Q?Hb5KwV5HLV8XhjtZyHSrF3WCpUqQAeD8mzGPbrfjqIj4LpVObyC2eAD0L9r0?=
 =?us-ascii?Q?LQgduu4RfPnYm1EytIP69iXiy8X/5k0OBDefgIms2h0kdO+TiRuLS1B26Ddz?=
 =?us-ascii?Q?SHN+vFPoRTUkZQ9OpEl3wDOX+0NsFyr78RXnAdYGRGhUcWLBWTCplbbcgXqS?=
 =?us-ascii?Q?gfeQn4fJFkxMmX4PidwWpQlC/0W/BZDTuk+ot71fSNPo32Y4kf6nWZ/yii/d?=
 =?us-ascii?Q?la2jxNOLmET6uD+OwGR9zYmx7HqrQsY/eCiDfuGWvu2aXYIi+i05tMzHWSDP?=
 =?us-ascii?Q?SoXHwzhpSvDvyltreKoYCCSRHx3z2+D/g9iI4fEnzHian+fCIj8vtp+l0cIJ?=
 =?us-ascii?Q?FH2Fa3SSTtfBhitWdxPR6Mu/ABqLz8KzAh5BL42+bWp78iPAeDtXJg6JSWK7?=
 =?us-ascii?Q?GGopTAM8ZnTqwOWaESMrIyXky57LMfaSAeGfLdYSC12HJiE0txP/QBJQ+Kym?=
 =?us-ascii?Q?p0Lh+cEH8HEMCT2ou5EzNJEHVdSDQsXDCJ2jn414QOOGQo/DrTu2c20k6rZ9?=
 =?us-ascii?Q?khlz1DOCR0Mxk9CE/Shb5Ndi5tM7D5EQPVk2vS2?=
X-Microsoft-Antispam-Message-Info: 5tg1oUJUNGoPC5hLHvw7VX/1VmbAcpN2f9P/0HmdaaJSxUSNepUwdbvAKFhMWRI9cWOmAcz4nUwQNXQQD3GS1jFU1VCeallo/6oWxzgVWhnmVOL+V/oNs4tPxt20k1U/HQ1dvZH7vjA8AtcYj+d7tjVWqk403muUuTRONJnT3wCGbYjJN/NTJXpGjavOT8BO
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 6:/fd7piUTNL1l7V0khHhhiITessyUpG3fC1fsNcTQ3GYenqmcC8oY73anOAr7Z+vqtQzmpk3z7ObiyMAY0LivlvGLceOWLXnZK2liPgWV9pCEaXeoYfr5e+wn+SyTkcHlLTIIC4FL9SU86nzCX85NqW6DCV5WRyCFQH1/b7quFzH9iqsC01woo0vm5HemWVX29ZH9uI591RYzL+YsrSZ9sNRBhLJh8n1k9nKxuhHQo+gVDm9ug3YbuoMHAqlCgboa/RwBGnJYiVhaY9Z3t7wlAcmTqueR26v3k4NDT3yKGmgInKRXJjgpVjUq31lhdwYfDV1SfdNnvzpE/N+x+/qOu2/1gq3QDUrRln/xoaI0Qf2rWIaU06iEOWuNW5Ms2sI2Mx8GgkIsfFWHBTF/xX/n9m3Nxtd5oU+Ow+CtRAp3izsHUS6gkzu6APRnNSVTRI2L/C7QGLrLkx28WbzVb5b6HQ==;
 5:UeaEFJG3cAxqQlCdk0SzJNOvHFCcvY8Myl5sZe3XGhqKsbNQ+HC77sLtYyQllANtrijrXaBEhucCy4QrkBnrWt21CjYh1bBjKNL4zB3JXeQyXm4QNT8Z6fbZQSGBgSLWeOhNqvUco5BfMbKmrhYJV7KAL/N2jfP5IEDvrZd/GAQ=;
 24:al+dh6z65nMUB5Ct603bn7lpwrhAbDz6pURJa3AZm3nZUM2fL9IJzeS1WyxOlOcQs6cl/wMGlHJ87HK0Od7ZHbqCZtgYC3/q7c8kOE8syn8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 7:IZfXAEC1vSY5J80DpVFlQ8CPf/Bs/m6iTdsgkWt4vj3NeAPGv6KME95hlzOGcutK6pLKWOwdwe+ddHcWeHZ1mIEHpRkdoi72uew0PieHu9v0WwqUm0OCTAY6pbZL0xnOKYfq/YLHClPdd9vvl5F9UdHi4NM6bgR7T4vZ80WXy0C7S3hB4j+1f1U9zKOmFuJUVVmR+BjAZ0yUVnidKDzjGpCYIlCfpjNoDUjxq50Fxx1fiScPuUhgyrdw55FuwqAB
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:06:01.4514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b69e98-6ac1-4f08-67be-08d5934c9f3f
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
index e7a0009..3fd34e9 100644
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
