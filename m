Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2426127-1521055689-2-9980768142712549349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, FUZZY_XPILL 2.799,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521055682; b=QmX351ObWbW52hmeFaNGokvOv4B1dAq5xGmiXHi/PLLnDyH
    sF7z3Gn8AZzezm+a73VwhJxq93yBaMgZvaNiFNLxQ07Xaek0qOiHaqiEG9QqwXO9
    jQq9CmZpz24eaFKokyaWfBswZhzLoRW/q9w0OEMqh7sXH4mc+kxZ5Cfm0VccuBrA
    G14JdGG+9ZNohTFLAncHkxpvVw6lf8S2fsYR6+OoRRcEO/GKo0f6tbf2sBAVoR2G
    V/QemgtP0V2yKezsCmjmp0qW4kLkU1VDzQERt3sEaRpfV2tmuTFlCi6g/D1HiWBj
    MYuIbX7QK/+7kBHmMXF28Z6rIQjixW8CiNIvLLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:reply-to:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521055682; bh=S
    v+2hLo7vn86zlirBcaXVtVbzMWKGmjFRMsczjift54=; b=Mq20vR2QCsMO2tSZO
    B8dHSbXPB5O4b0oLkkg/zyZDCZq7GQjU6g19u7ZAMzOg2e9aYyPkV2IHgN5YoN9O
    xv34pQKRtrJgsSIGXjdr59iIz7Gg25fnfSYaLPqMid8+l5ToMM7syubHMg1YxwxJ
    GvV0dv6uPW0+Hw2B0+IVgjGAkEDp9ghBChCUDlMNijZIeE9ETd9n5MBJCulEllMF
    hN48lDmWdXHS2yUd0WABH3suq+ynfvfXXudrdg5L1QfcAbCrdmq/oloi2S1qoAGE
    qLDSkiBKNs0VQ14HEaZnOimvoXxZ6NgjpIDsxi17cziA4qUu1QWUry8985Nm0ZQY
    JF2jg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=JuCmljkk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=JuCmljkk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] staging:fsl-mc: Move DPIO out of staging
Date: Wed, 14 Mar 2018 15:26:39 -0400
Message-Id: <1521055599-18672-1-git-send-email-roy.pledge@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: DM5PR19CA0047.namprd19.prod.outlook.com
 (2603:10b6:3:9a::33) To AM5PR04MB2993.eurprd04.prod.outlook.com
 (2603:10a6:206:a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e757e2f4-379e-40f9-f57d-08d589e18f4a
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 3:iJL92CsEPcT+bVbMuhasuRoDlQGb6d0fKsAVW1QyTXf1PWwWP7LRJ0lyYTVpCSzYTPCP0FNhL1xouLZvrEKoG5cOODxS1DXNy30YD0cnsf7/sze/VmxIrO5EdDa6ht7PHKirTU38DDTNc5ZBBkJ4gU7B49I+HJvhHtv4pBWMd6PV/I0o4/VgDcAnx1TD+LoS5jxQ24vLVy7G2hA+5Nrq0cgcVCMyO4nebLFcxne6pwcvZA1HCCX8fdlWzNKpfSJC;
 25:hENkloBu22TWJMn4zncFDjZ36G4BK1Sge18IRn2iQx84jt0nRcbIN+yri4+1W173t2lIx+mbwztvr3mOZrkToOE9KdY9//Ic0+NwYHvi7CULNfLFV+8mq7NlKYVy3LIOG5bNIakuunX8dkdU2urI3JY+m1RELcOBay4qBRPX4urFaeMW1pGzGrCwyUogrgpG48GySIcWfYY65YSwV14LBJVK10ltxZI2abMqQb1g7JTViM4AwY3hGsusQ/s3/uISXdL4OAKxeiuM7x5et2a80IzRfypQdzatQrFWfdQuaHriUkmFl/oAZHxpyLOXGy53v5+mjTnEwf3xlBm24y+tQA==;
 31:yrRl8pqdgtAALv9GiITUJrbfxDdXsgSIE7C02a5jqJ60q6aOOGidDMel5uxa8zxGwfe7ETWWcYZzJS9JUp4FT+UfizTNDGNRX6QTSb2YFz3JMexyUDwWneDNgo5tUGVlWSjSZr7N2mfyWP7/FDr2gKVqD0VvBXBOGIKk7g5Si8+U+PYtJex5itppRnCVUG1s438aoTu/sWV0T67LzA34vmDTB6avLKen9NDnQg2NXZk=
X-MS-TrafficTypeDiagnostic: AM5PR04MB2993:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 20:iXvJeCHlhiFb4FIOO0Rf1VTL22MtlJKlaY0SBiJiDg8QcqdTELVHweayfmSLbEijjMlLODwFojBjnjci0+Lf11lShBXSTg+75Rq+8y/km3o4c8IgjH8ccHC1AO2WUxp1qAUiFWv9B+1l1hrVejY/X+xZaCScDBZfPII4gj1GoLgZmE78ubgwRiRMWQ527ivl495v9pbpmFaIn/SqgeE0PnjPlI7rWDjpcDvkEjqjZ8nQdi3jFTPhwP6Tlm3Y7Tpt+dJm8N3l7PmxPpaa1M/g6RoO7dxBxIRu+HzKyDEmbwStAhpkh4TPBei4mTN55sntmnN4ktcJ9BaitLe/k6nB5862hdiQ23lwlJ9LiWmcXTc5xdnXntbMBlV6wFdIO+ifJDHodeNB8AMmFTQ9yoeDgSmaBoQd4XT5/yqvN2e82IcXFJCrOJYxengwQHAoOtCheZNwjvnWWXoZoB1Ej4ZVdRhSW4ntpnTDCOHDIksV2/az7VPIffk1TDE9tK2uC/2E
X-Microsoft-Antispam-PRVS: <AM5PR04MB2993AC08F3790C2E5512E7A886D10@AM5PR04MB2993.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(35073007944872)(185117386973197)(227817650892897)(788757137089)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);
 SRVR:AM5PR04MB2993; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 4:R+X7HDawVrp7Xfzn/hw8mCkPqrkjf2cjzURi67E04ALgKs8+BoDpe6u+F06A2SkXWtRESPkv+w8KunPgRjK+0SfLXbzwf3LU+eOoWxGqu/jpuXnV2LhM5dMcmVY3DEH58blPSqE4BVtelC0IN2Fkt1np2hagiLp7Wkn1tMUtj1WpkuoE+4Nh27Q7pIOGY+uPaS6qN/DtXClJOWPKivYitbL/RBB8DZes7QqRo4PBAk2+7OuIzOInk8HkpLKWSvR6dy5qGO8y24k4fdDaM88UOF2Sw4FhUNd+mR8Cb2JOJDjvD8BZJq2uu1ZvYmhEvLAtlWx8qn43XTF/lJo/GPWq4DZZPrf+J17WV+VuX0Cw1AVBKnmqqtx+yAcJBoCpTM1oIMZlUgeir+V3uCTgIot5iiofgYQlRLj+bxSyeXmPorNw+VVH4Owoxl6rfz/vfXAyDYFwivOSy6ne0t5wi9dZ6hx2U18WSp/228yrFf9dl4c=
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(39380400002)(376002)(396003)(39860400002)(346002)(189003)(199004)(53936002)(51416003)(53946003)(6486002)(16200700003)(48376002)(97736004)(3846002)(105586002)(575784001)(3450700001)(6116002)(16586007)(6512007)(316002)(52116002)(4326008)(86362001)(2906002)(50466002)(39060400002)(5660300001)(186003)(16526019)(66066001)(1857600001)(36756003)(6666003)(386003)(68736007)(59450400001)(6506007)(5890100001)(47776003)(305945005)(25786009)(26005)(7736002)(50226002)(478600001)(81156014)(8676002)(43066004)(8936002)(81166006)(106356001)(579004)(559001)(569006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2993; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB2993;
 23:LkqZMOrXEFuuev9RjYpNHYuZhzFAUf1jm9RHFESSc?=
 =?us-ascii?Q?wirQSQmEtE5TyAmhowRWJ6AwGmZCQ0+di+pzi5fbNU/7FrkqYvIqoBSamzUn?=
 =?us-ascii?Q?Z2iCHvJ1E+kDNe5F7L0Mmm28n95aJfGmNcKxLEtoIjnh7HWpP/LGuHbgjd3Y?=
 =?us-ascii?Q?f77huezBALTRBY5jKX1db9L47aOm4FunKn0LVXp6lKvphjDOSYHZUAjY6rs8?=
 =?us-ascii?Q?Swh1Lrj5aHS4opA2HNrcFc87xv9+YsjBJe4oWnTQM4oH4derimu5vS261Gta?=
 =?us-ascii?Q?hJzD4PXQG0Wn0IhDZPtZQ4W+sOhK+ofXJsDXCtpcS06VrZ6lPsNhOB5377tT?=
 =?us-ascii?Q?yjA/GjrCwOtf4Dx1wrno5EkNtS5HMt82+E2rRhkYevxyzWpU2kyBmmWbFaX1?=
 =?us-ascii?Q?cBzvjU5xRlml3V+0tRy8vfmrb84rAwyFkoYyjvyAP4thO9waxKn/MOAGKv48?=
 =?us-ascii?Q?wevk5t/30i/Oqmhx9/GNbodiHJ060XZ3/m/+lb+7jorHwT+zOhqOZ3vKodu5?=
 =?us-ascii?Q?z3JOMJCQKv61cFR5gJLgf4apDhDxqlET/05Zz2bDvNIl48K2XTET+CaTy+CK?=
 =?us-ascii?Q?7UNdzxdosDi2JTbtDCOc2EkI6dOTGllqfOrgw6V8PxMduO47vMB4xIdP5VQx?=
 =?us-ascii?Q?xo0BcLWdFw16PNI7JuPC/+zyADrQc8EgmxURdEJ/ZMOtDnruWgHqCDZI6p/p?=
 =?us-ascii?Q?Q7FJH8o2OQHLMzFwTvEKjowZ8KO1h1meQAGsNvRTUpJhfgAqQLcaMobnlKhP?=
 =?us-ascii?Q?NE13cr649teHy2M8CCSO+RaAuF3kb5YfYQ9Uaq1LGefPlCLUTTgsV4fLY/Yo?=
 =?us-ascii?Q?OMTxY38xQlVrHDBumpNdey8zUerRmAgtQ5iDqFNWeJiKci/DStllbNPtxHBc?=
 =?us-ascii?Q?QdOsVbJ36MUNJa1AUSGdEHDxkiteEePRCZ7Q4+K6+LcaVl36O41Fv2mMwKds?=
 =?us-ascii?Q?VSU90ntMEk2uO8OWZe6U8ADTEVYFn+eZxEmuHAFlAIRdwAoF1KY2EXAavyAm?=
 =?us-ascii?Q?MBH+rkScx8LezeGV39X/M5nFMXFeG23x+lCVvosmldBKZFkcqSg72rvstN/K?=
 =?us-ascii?Q?dTMmSA7meEKqtM4+YfFReeqydWWrAWsRoU5jM5F6s2Xjoq4Cf9fdN+RzG5R5?=
 =?us-ascii?Q?uCXOhgfxhhRTnn7Fm0lDBTIpURCCaOCH1YW7bEQB8VLMmoAS2F5eUeHyksIg?=
 =?us-ascii?Q?500+3WYi3GqQvcKJcfPS3ET6/Wv3c0piiAdnhStamQ0doLiN1W9Qoj1T6/cG?=
 =?us-ascii?Q?v/Nn4d5eHb2Xc0+i4SHBKhs4ftq3AZbz+KXVIwwsLZr4NnmS/tRm70z+9HsJ?=
 =?us-ascii?Q?ZIUHGUxytHn3A0s+0qPBbI=3D?=
X-Microsoft-Antispam-Message-Info: Pali8Ok0kYikrRnmME1bepKUiierRj2fV/mxt259xXsujMdwVq9eFn5aMjd8ew6bkvYuGb2EQtSkVEnyCm9vgjoDKn0jXYyjegm7iLS1Q59LVeITJ3J+p44RI4NEG/pYE5mcHANav8Fb6v4q9MRAyeeX/m0gEMxDB7c+qrsyZ3d0ke03TUd7TxzY1IPEBqZt
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 6:ifZUSbVLmIvrZfABvesTl+9dNxkiWti5igc1uuHtBYk7qFyc7RlmbNJwAu97OQL8/RDugaREVP5Kxm9sBaERPtqsLvXf+YF+VmTgsS72NnnHLl67rbGr/yvKhtvSHnAw7k9xXggfUGAsL4njTcF0+sN39fndGuYiKx8oSTpOHmt5uYe+zmwrV9LziuwaH/d7dD4TentMsCW6gw/jenJKItaogE0+EOzsYiueoSMLW9i/M4YQxNVvHKis7dZcyuqnR6m1bsRqTaVs/GcAsIFRj4X3SEj+4G20zJrNkADCBK9K8Ab6hH441L78TEsHXZ7pMbRQx87aOh+EHJmtofPPwKYJLiJBk5prhIZwjPYhpj8=;
 5:YC849W9BJ3f6MLXk6Rp0HCo9VP++RsIH5NXYFb8L+wEW8q3mkZGRPFgKLh3yNU5pI1GCThJWNTanRxcVjmFf9xnHgmcXJZE7J35ChSy0s6Sy84M+yuEzm+k+LRFJXSN6s0DDktoIZ35tHwRacgvF0DqIprBq3myXrXcRHSeSr5I=;
 24:GNrG/FVAMH3BT7zp+8DgBadd7gaRgM5z0jKTSxf1Y6wvxaIGu0hhlJ/fxjnw66PY5VccUHqw3AH5tIVsnxV56OPWZAVEnZStykw1it5mFek=;
 7:teXZEhkIqTWfgA+Da5jo4MenpXwk4a5Sgm5963XNrLJmoJmTEO5W0XEV1FkySVp7Ln2BHloHTO7CS5mZ7Acifh4UizN4Puv+O+eWbItfhs2vV4RDuXcIoSsgRezkjaB5T8/jJtD2IpVQOjBpjlLmTy6nLwxSJ6xECNmbDlBbFR5IBakilNRCpndK3hZ/c3MhuejR39ipTlzg78WiWtunzedEMoD8NMiSUWDgFDIR5cJvW/TryMPDOXUED3fLeC1r
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 19:26:57.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e757e2f4-379e-40f9-f57d-08d589e18f4a
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
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, Roy Pledge <roy.pledge@nxp.com>,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com, stuyoder@gmail.com,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Move the DPIO driver out of the staging directory and into drivers/soc/fsl

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 MAINTAINERS                                     |    2 +-
 drivers/soc/fsl/Makefile                        |    1 +
 drivers/soc/fsl/dpio/Makefile                   |    8 +
 drivers/soc/fsl/dpio/dpio-cmd.h                 |   49 ++
 drivers/soc/fsl/dpio/dpio-driver.c              |  271 ++++++
 drivers/soc/fsl/dpio/dpio-driver.txt            |  135 +++
 drivers/soc/fsl/dpio/dpio-service.c             |  545 ++++++++++++
 drivers/soc/fsl/dpio/dpio.c                     |  198 +++++
 drivers/soc/fsl/dpio/dpio.h                     |   83 ++
 drivers/soc/fsl/dpio/qbman-portal.c             | 1005 +++++++++++++++++++++++
 drivers/soc/fsl/dpio/qbman-portal.h             |  444 ++++++++++
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h  |    4 +-
 drivers/staging/fsl-mc/bus/Makefile             |    2 -
 drivers/staging/fsl-mc/bus/dpio/Makefile        |    8 -
 drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h      |   49 --
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c   |  271 ------
 drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt |  135 ---
 drivers/staging/fsl-mc/bus/dpio/dpio-service.c  |  545 ------------
 drivers/staging/fsl-mc/bus/dpio/dpio.c          |  198 -----
 drivers/staging/fsl-mc/bus/dpio/dpio.h          |   83 --
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c  | 1005 -----------------------
 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h  |  444 ----------
 drivers/staging/fsl-mc/include/dpaa2-fd.h       |  426 ----------
 drivers/staging/fsl-mc/include/dpaa2-global.h   |  177 ----
 drivers/staging/fsl-mc/include/dpaa2-io.h       |  115 ---
 include/soc/fsl/dpaa2-fd.h                      |  426 ++++++++++
 include/soc/fsl/dpaa2-global.h                  |  177 ++++
 include/soc/fsl/dpaa2-io.h                      |  115 +++
 28 files changed, 3460 insertions(+), 3461 deletions(-)
 create mode 100644 drivers/soc/fsl/dpio/Makefile
 create mode 100644 drivers/soc/fsl/dpio/dpio-cmd.h
 create mode 100644 drivers/soc/fsl/dpio/dpio-driver.c
 create mode 100644 drivers/soc/fsl/dpio/dpio-driver.txt
 create mode 100644 drivers/soc/fsl/dpio/dpio-service.c
 create mode 100644 drivers/soc/fsl/dpio/dpio.c
 create mode 100644 drivers/soc/fsl/dpio/dpio.h
 create mode 100644 drivers/soc/fsl/dpio/qbman-portal.c
 create mode 100644 drivers/soc/fsl/dpio/qbman-portal.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/dpio-service.c
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/dpio.c
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/dpio.h
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
 delete mode 100644 drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpaa2-fd.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpaa2-global.h
 delete mode 100644 drivers/staging/fsl-mc/include/dpaa2-io.h
 create mode 100644 include/soc/fsl/dpaa2-fd.h
 create mode 100644 include/soc/fsl/dpaa2-global.h
 create mode 100644 include/soc/fsl/dpaa2-io.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3057761..3fdaade 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4436,7 +4436,7 @@ DPAA2 DATAPATH I/O (DPIO) DRIVER
 M:	Roy Pledge <Roy.Pledge@nxp.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-mc/bus/dpio
+F:	drivers/soc/fsl/dpio
 
 DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..803ef1b 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_MC_DPIO) 		+= dpio/
diff --git a/drivers/soc/fsl/dpio/Makefile b/drivers/soc/fsl/dpio/Makefile
new file mode 100644
index 0000000..b9ff24c
--- /dev/null
+++ b/drivers/soc/fsl/dpio/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# QorIQ DPAA2 DPIO driver
+#
+
+obj-$(CONFIG_FSL_MC_DPIO) += fsl-mc-dpio.o
+
+fsl-mc-dpio-objs := dpio.o qbman-portal.o dpio-service.o dpio-driver.o
diff --git a/drivers/soc/fsl/dpio/dpio-cmd.h b/drivers/soc/fsl/dpio/dpio-cmd.h
new file mode 100644
index 0000000..ab8f82e
--- /dev/null
+++ b/drivers/soc/fsl/dpio/dpio-cmd.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#ifndef _FSL_DPIO_CMD_H
+#define _FSL_DPIO_CMD_H
+
+/* DPIO Version */
+#define DPIO_VER_MAJOR			4
+#define DPIO_VER_MINOR			2
+
+/* Command Versioning */
+
+#define DPIO_CMD_ID_OFFSET		4
+#define DPIO_CMD_BASE_VERSION		1
+
+#define DPIO_CMD(id)	(((id) << DPIO_CMD_ID_OFFSET) | DPIO_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPIO_CMDID_CLOSE				DPIO_CMD(0x800)
+#define DPIO_CMDID_OPEN					DPIO_CMD(0x803)
+#define DPIO_CMDID_GET_API_VERSION			DPIO_CMD(0xa03)
+#define DPIO_CMDID_ENABLE				DPIO_CMD(0x002)
+#define DPIO_CMDID_DISABLE				DPIO_CMD(0x003)
+#define DPIO_CMDID_GET_ATTR				DPIO_CMD(0x004)
+
+struct dpio_cmd_open {
+	__le32 dpio_id;
+};
+
+#define DPIO_CHANNEL_MODE_MASK		0x3
+
+struct dpio_rsp_get_attr {
+	/* cmd word 0 */
+	__le32 id;
+	__le16 qbman_portal_id;
+	u8 num_priorities;
+	u8 channel_mode;
+	/* cmd word 1 */
+	__le64 qbman_portal_ce_addr;
+	/* cmd word 2 */
+	__le64 qbman_portal_ci_addr;
+	/* cmd word 3 */
+	__le32 qbman_version;
+};
+
+#endif /* _FSL_DPIO_CMD_H */
diff --git a/drivers/soc/fsl/dpio/dpio-driver.c b/drivers/soc/fsl/dpio/dpio-driver.c
new file mode 100644
index 0000000..732f025
--- /dev/null
+++ b/drivers/soc/fsl/dpio/dpio-driver.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright NXP 2016
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/msi.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include <linux/fsl/mc.h>
+#include <soc/fsl/dpaa2-io.h>
+
+#include "qbman-portal.h"
+#include "dpio.h"
+#include "dpio-cmd.h"
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Freescale Semiconductor, Inc");
+MODULE_DESCRIPTION("DPIO Driver");
+
+struct dpio_priv {
+	struct dpaa2_io *io;
+};
+
+static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
+{
+	struct device *dev = (struct device *)arg;
+	struct dpio_priv *priv = dev_get_drvdata(dev);
+
+	return dpaa2_io_irq(priv->io);
+}
+
+static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
+{
+	struct fsl_mc_device_irq *irq;
+
+	irq = dpio_dev->irqs[0];
+
+	/* clear the affinity hint */
+	irq_set_affinity_hint(irq->msi_desc->irq, NULL);
+}
+
+static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
+{
+	struct dpio_priv *priv;
+	int error;
+	struct fsl_mc_device_irq *irq;
+	cpumask_t mask;
+
+	priv = dev_get_drvdata(&dpio_dev->dev);
+
+	irq = dpio_dev->irqs[0];
+	error = devm_request_irq(&dpio_dev->dev,
+				 irq->msi_desc->irq,
+				 dpio_irq_handler,
+				 0,
+				 dev_name(&dpio_dev->dev),
+				 &dpio_dev->dev);
+	if (error < 0) {
+		dev_err(&dpio_dev->dev,
+			"devm_request_irq() failed: %d\n",
+			error);
+		return error;
+	}
+
+	/* set the affinity hint */
+	cpumask_clear(&mask);
+	cpumask_set_cpu(cpu, &mask);
+	if (irq_set_affinity_hint(irq->msi_desc->irq, &mask))
+		dev_err(&dpio_dev->dev,
+			"irq_set_affinity failed irq %d cpu %d\n",
+			irq->msi_desc->irq, cpu);
+
+	return 0;
+}
+
+static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
+{
+	struct dpio_attr dpio_attrs;
+	struct dpaa2_io_desc desc;
+	struct dpio_priv *priv;
+	int err = -ENOMEM;
+	struct device *dev = &dpio_dev->dev;
+	static int next_cpu = -1;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		goto err_priv_alloc;
+
+	dev_set_drvdata(dev, priv);
+
+	err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
+	if (err) {
+		dev_dbg(dev, "MC portal allocation failed\n");
+		err = -EPROBE_DEFER;
+		goto err_mcportal;
+	}
+
+	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
+			&dpio_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpio_open() failed\n");
+		goto err_open;
+	}
+
+	err = dpio_get_attributes(dpio_dev->mc_io, 0, dpio_dev->mc_handle,
+				  &dpio_attrs);
+	if (err) {
+		dev_err(dev, "dpio_get_attributes() failed %d\n", err);
+		goto err_get_attr;
+	}
+	desc.qman_version = dpio_attrs.qbman_version;
+
+	err = dpio_enable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpio_enable() failed %d\n", err);
+		goto err_get_attr;
+	}
+
+	/* initialize DPIO descriptor */
+	desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
+	desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
+	desc.dpio_id = dpio_dev->obj_desc.id;
+
+	/* get the cpu to use for the affinity hint */
+	if (next_cpu == -1)
+		next_cpu = cpumask_first(cpu_online_mask);
+	else
+		next_cpu = cpumask_next(next_cpu, cpu_online_mask);
+
+	if (!cpu_possible(next_cpu)) {
+		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
+		err = -ERANGE;
+		goto err_allocate_irqs;
+	}
+	desc.cpu = next_cpu;
+
+	/*
+	 * Set the CENA regs to be the cache inhibited area of the portal to
+	 * avoid coherency issues if a user migrates to another core.
+	 */
+	desc.regs_cena = ioremap_wc(dpio_dev->regions[1].start,
+		resource_size(&dpio_dev->regions[1]));
+	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
+		resource_size(&dpio_dev->regions[1]));
+
+	err = fsl_mc_allocate_irqs(dpio_dev);
+	if (err) {
+		dev_err(dev, "fsl_mc_allocate_irqs failed. err=%d\n", err);
+		goto err_allocate_irqs;
+	}
+
+	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
+	if (err)
+		goto err_register_dpio_irq;
+
+	priv->io = dpaa2_io_create(&desc);
+	if (!priv->io) {
+		dev_err(dev, "dpaa2_io_create failed\n");
+		goto err_dpaa2_io_create;
+	}
+
+	dev_info(dev, "probed\n");
+	dev_dbg(dev, "   receives_notifications = %d\n",
+		desc.receives_notifications);
+	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+	fsl_mc_portal_free(dpio_dev->mc_io);
+
+	return 0;
+
+err_dpaa2_io_create:
+	unregister_dpio_irq_handlers(dpio_dev);
+err_register_dpio_irq:
+	fsl_mc_free_irqs(dpio_dev);
+err_allocate_irqs:
+	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+err_get_attr:
+	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+err_open:
+	fsl_mc_portal_free(dpio_dev->mc_io);
+err_mcportal:
+	dev_set_drvdata(dev, NULL);
+err_priv_alloc:
+	return err;
+}
+
+/* Tear down interrupts for a given DPIO object */
+static void dpio_teardown_irqs(struct fsl_mc_device *dpio_dev)
+{
+	unregister_dpio_irq_handlers(dpio_dev);
+	fsl_mc_free_irqs(dpio_dev);
+}
+
+static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
+{
+	struct device *dev;
+	struct dpio_priv *priv;
+	int err;
+
+	dev = &dpio_dev->dev;
+	priv = dev_get_drvdata(dev);
+
+	dpaa2_io_down(priv->io);
+
+	dpio_teardown_irqs(dpio_dev);
+
+	err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
+	if (err) {
+		dev_err(dev, "MC portal allocation failed\n");
+		goto err_mcportal;
+	}
+
+	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
+			&dpio_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpio_open() failed\n");
+		goto err_open;
+	}
+
+	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+
+	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
+
+	fsl_mc_portal_free(dpio_dev->mc_io);
+
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+
+err_open:
+	fsl_mc_portal_free(dpio_dev->mc_io);
+err_mcportal:
+	return err;
+}
+
+static const struct fsl_mc_device_id dpaa2_dpio_match_id_table[] = {
+	{
+		.vendor = FSL_MC_VENDOR_FREESCALE,
+		.obj_type = "dpio",
+	},
+	{ .vendor = 0x0 }
+};
+
+static struct fsl_mc_driver dpaa2_dpio_driver = {
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.owner		= THIS_MODULE,
+	},
+	.probe		= dpaa2_dpio_probe,
+	.remove		= dpaa2_dpio_remove,
+	.match_id_table = dpaa2_dpio_match_id_table
+};
+
+static int dpio_driver_init(void)
+{
+	return fsl_mc_driver_register(&dpaa2_dpio_driver);
+}
+
+static void dpio_driver_exit(void)
+{
+	fsl_mc_driver_unregister(&dpaa2_dpio_driver);
+}
+module_init(dpio_driver_init);
+module_exit(dpio_driver_exit);
diff --git a/drivers/soc/fsl/dpio/dpio-driver.txt b/drivers/soc/fsl/dpio/dpio-driver.txt
new file mode 100644
index 0000000..0ba6771
--- /dev/null
+++ b/drivers/soc/fsl/dpio/dpio-driver.txt
@@ -0,0 +1,135 @@
+Copyright 2016 NXP
+
+Introduction
+------------
+
+A DPAA2 DPIO (Data Path I/O) is a hardware object that provides
+interfaces to enqueue and dequeue frames to/from network interfaces
+and other accelerators.  A DPIO also provides hardware buffer
+pool management for network interfaces.
+
+This document provides an overview the Linux DPIO driver, its
+subcomponents, and its APIs.
+
+See Documentation/dpaa2/overview.txt for a general overview of DPAA2
+and the general DPAA2 driver architecture in Linux.
+
+Driver Overview
+---------------
+
+The DPIO driver is bound to DPIO objects discovered on the fsl-mc bus and
+provides services that:
+  A) allow other drivers, such as the Ethernet driver, to enqueue and dequeue
+     frames for their respective objects
+  B) allow drivers to register callbacks for data availability notifications
+     when data becomes available on a queue or channel
+  C) allow drivers to manage hardware buffer pools
+
+The Linux DPIO driver consists of 3 primary components--
+   DPIO object driver-- fsl-mc driver that manages the DPIO object
+   DPIO service-- provides APIs to other Linux drivers for services
+   QBman portal interface-- sends portal commands, gets responses
+
+          fsl-mc          other
+           bus           drivers
+            |               |
+        +---+----+   +------+-----+
+        |DPIO obj|   |DPIO service|
+        | driver |---|  (DPIO)    |
+        +--------+   +------+-----+
+                            |
+                     +------+-----+
+                     |    QBman   |
+                     | portal i/f |
+                     +------------+
+                            |
+                         hardware
+
+The diagram below shows how the DPIO driver components fit with the other
+DPAA2 Linux driver components:
+                                                   +------------+
+                                                   | OS Network |
+                                                   |   Stack    |
+                 +------------+                    +------------+
+                 | Allocator  |. . . . . . .       |  Ethernet  |
+                 |(DPMCP,DPBP)|                    |   (DPNI)   |
+                 +-.----------+                    +---+---+----+
+                  .          .                         ^   |
+                 .            .           <data avail, |   |<enqueue,
+                .              .           tx confirm> |   | dequeue>
+    +-------------+             .                      |   |
+    | DPRC driver |              .    +--------+ +------------+
+    |   (DPRC)    |               . . |DPIO obj| |DPIO service|
+    +----------+--+                   | driver |-|  (DPIO)    |
+               |                      +--------+ +------+-----+
+               |<dev add/remove>                 +------|-----+
+               |                                 |   QBman    |
+          +----+--------------+                  | portal i/f |
+          |   MC-bus driver   |                  +------------+
+          |                   |                     |
+          | /soc/fsl-mc       |                     |
+          +-------------------+                     |
+                                                    |
+ =========================================|=========|========================
+                                        +-+--DPIO---|-----------+
+                                        |           |           |
+                                        |        QBman Portal   |
+                                        +-----------------------+
+
+ ============================================================================
+
+
+DPIO Object Driver (dpio-driver.c)
+----------------------------------
+
+   The dpio-driver component registers with the fsl-mc bus to handle objects of
+   type "dpio".  The implementation of probe() handles basic initialization
+   of the DPIO including mapping of the DPIO regions (the QBman SW portal)
+   and initializing interrupts and registering irq handlers.  The dpio-driver
+   registers the probed DPIO with dpio-service.
+
+DPIO service  (dpio-service.c, dpaa2-io.h)
+------------------------------------------
+
+   The dpio service component provides queuing, notification, and buffers
+   management services to DPAA2 drivers, such as the Ethernet driver.  A system
+   will typically allocate 1 DPIO object per CPU to allow queuing operations
+   to happen simultaneously across all CPUs.
+
+   Notification handling
+      dpaa2_io_service_register()
+      dpaa2_io_service_deregister()
+      dpaa2_io_service_rearm()
+
+   Queuing
+      dpaa2_io_service_pull_fq()
+      dpaa2_io_service_pull_channel()
+      dpaa2_io_service_enqueue_fq()
+      dpaa2_io_service_enqueue_qd()
+      dpaa2_io_store_create()
+      dpaa2_io_store_destroy()
+      dpaa2_io_store_next()
+
+   Buffer pool management
+      dpaa2_io_service_release()
+      dpaa2_io_service_acquire()
+
+QBman portal interface (qbman-portal.c)
+---------------------------------------
+
+   The qbman-portal component provides APIs to do the low level hardware
+   bit twiddling for operations such as:
+      -initializing Qman software portals
+      -building and sending portal commands
+      -portal interrupt configuration and processing
+
+   The qbman-portal APIs are not public to other drivers, and are
+   only used by dpio-service.
+
+Other (dpaa2-fd.h, dpaa2-global.h)
+----------------------------------
+
+   Frame descriptor and scatter-gather definitions and the APIs used to
+   manipulate them are defined in dpaa2-fd.h.
+
+   Dequeue result struct and parsing APIs are defined in dpaa2-global.h.
diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
new file mode 100644
index 0000000..9b17f72
--- /dev/null
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -0,0 +1,545 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#include <linux/types.h>
+#include <linux/fsl/mc.h>
+#include <soc/fsl/dpaa2-io.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/slab.h>
+
+#include "dpio.h"
+#include "qbman-portal.h"
+
+struct dpaa2_io {
+	struct dpaa2_io_desc dpio_desc;
+	struct qbman_swp_desc swp_desc;
+	struct qbman_swp *swp;
+	struct list_head node;
+	/* protect against multiple management commands */
+	spinlock_t lock_mgmt_cmd;
+	/* protect notifications list */
+	spinlock_t lock_notifications;
+	struct list_head notifications;
+};
+
+struct dpaa2_io_store {
+	unsigned int max;
+	dma_addr_t paddr;
+	struct dpaa2_dq *vaddr;
+	void *alloced_addr;    /* unaligned value from kmalloc() */
+	unsigned int idx;      /* position of the next-to-be-returned entry */
+	struct qbman_swp *swp; /* portal used to issue VDQCR */
+	struct device *dev;    /* device used for DMA mapping */
+};
+
+/* keep a per cpu array of DPIOs for fast access */
+static struct dpaa2_io *dpio_by_cpu[NR_CPUS];
+static struct list_head dpio_list = LIST_HEAD_INIT(dpio_list);
+static DEFINE_SPINLOCK(dpio_list_lock);
+
+static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,
+						     int cpu)
+{
+	if (d)
+		return d;
+
+	if (cpu != DPAA2_IO_ANY_CPU && cpu >= num_possible_cpus())
+		return NULL;
+
+	/*
+	 * If cpu == -1, choose the current cpu, with no guarantees about
+	 * potentially being migrated away.
+	 */
+	if (unlikely(cpu < 0))
+		cpu = smp_processor_id();
+
+	/* If a specific cpu was requested, pick it up immediately */
+	return dpio_by_cpu[cpu];
+}
+
+static inline struct dpaa2_io *service_select(struct dpaa2_io *d)
+{
+	if (d)
+		return d;
+
+	spin_lock(&dpio_list_lock);
+	d = list_entry(dpio_list.next, struct dpaa2_io, node);
+	list_del(&d->node);
+	list_add_tail(&d->node, &dpio_list);
+	spin_unlock(&dpio_list_lock);
+
+	return d;
+}
+
+/**
+ * dpaa2_io_service_select() - return a dpaa2_io service affined to this cpu
+ * @cpu: the cpu id
+ *
+ * Return the affine dpaa2_io service, or NULL if there is no service affined
+ * to the specified cpu. If DPAA2_IO_ANY_CPU is used, return the next available
+ * service.
+ */
+struct dpaa2_io *dpaa2_io_service_select(int cpu)
+{
+	if (cpu == DPAA2_IO_ANY_CPU)
+		return service_select(NULL);
+
+	return service_select_by_cpu(NULL, cpu);
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_select);
+
+/**
+ * dpaa2_io_create() - create a dpaa2_io object.
+ * @desc: the dpaa2_io descriptor
+ *
+ * Activates a "struct dpaa2_io" corresponding to the given config of an actual
+ * DPIO object.
+ *
+ * Return a valid dpaa2_io object for success, or NULL for failure.
+ */
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
+{
+	struct dpaa2_io *obj = kmalloc(sizeof(*obj), GFP_KERNEL);
+
+	if (!obj)
+		return NULL;
+
+	/* check if CPU is out of range (-1 means any cpu) */
+	if (desc->cpu != DPAA2_IO_ANY_CPU && desc->cpu >= num_possible_cpus()) {
+		kfree(obj);
+		return NULL;
+	}
+
+	obj->dpio_desc = *desc;
+	obj->swp_desc.cena_bar = obj->dpio_desc.regs_cena;
+	obj->swp_desc.cinh_bar = obj->dpio_desc.regs_cinh;
+	obj->swp_desc.qman_version = obj->dpio_desc.qman_version;
+	obj->swp = qbman_swp_init(&obj->swp_desc);
+
+	if (!obj->swp) {
+		kfree(obj);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&obj->node);
+	spin_lock_init(&obj->lock_mgmt_cmd);
+	spin_lock_init(&obj->lock_notifications);
+	INIT_LIST_HEAD(&obj->notifications);
+
+	/* For now only enable DQRR interrupts */
+	qbman_swp_interrupt_set_trigger(obj->swp,
+					QBMAN_SWP_INTERRUPT_DQRI);
+	qbman_swp_interrupt_clear_status(obj->swp, 0xffffffff);
+	if (obj->dpio_desc.receives_notifications)
+		qbman_swp_push_set(obj->swp, 0, 1);
+
+	spin_lock(&dpio_list_lock);
+	list_add_tail(&obj->node, &dpio_list);
+	if (desc->cpu >= 0 && !dpio_by_cpu[desc->cpu])
+		dpio_by_cpu[desc->cpu] = obj;
+	spin_unlock(&dpio_list_lock);
+
+	return obj;
+}
+
+/**
+ * dpaa2_io_down() - release the dpaa2_io object.
+ * @d: the dpaa2_io object to be released.
+ *
+ * The "struct dpaa2_io" type can represent an individual DPIO object (as
+ * described by "struct dpaa2_io_desc") or an instance of a "DPIO service",
+ * which can be used to group/encapsulate multiple DPIO objects. In all cases,
+ * each handle obtained should be released using this function.
+ */
+void dpaa2_io_down(struct dpaa2_io *d)
+{
+	kfree(d);
+}
+
+#define DPAA_POLL_MAX 32
+
+/**
+ * dpaa2_io_irq() - ISR for DPIO interrupts
+ *
+ * @obj: the given DPIO object.
+ *
+ * Return IRQ_HANDLED for success or IRQ_NONE if there
+ * were no pending interrupts.
+ */
+irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
+{
+	const struct dpaa2_dq *dq;
+	int max = 0;
+	struct qbman_swp *swp;
+	u32 status;
+
+	swp = obj->swp;
+	status = qbman_swp_interrupt_read_status(swp);
+	if (!status)
+		return IRQ_NONE;
+
+	dq = qbman_swp_dqrr_next(swp);
+	while (dq) {
+		if (qbman_result_is_SCN(dq)) {
+			struct dpaa2_io_notification_ctx *ctx;
+			u64 q64;
+
+			q64 = qbman_result_SCN_ctx(dq);
+			ctx = (void *)(uintptr_t)q64;
+			ctx->cb(ctx);
+		} else {
+			pr_crit("fsl-mc-dpio: Unrecognised/ignored DQRR entry\n");
+		}
+		qbman_swp_dqrr_consume(swp, dq);
+		++max;
+		if (max > DPAA_POLL_MAX)
+			goto done;
+		dq = qbman_swp_dqrr_next(swp);
+	}
+done:
+	qbman_swp_interrupt_clear_status(swp, status);
+	qbman_swp_interrupt_set_inhibit(swp, 0);
+	return IRQ_HANDLED;
+}
+
+/**
+ * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
+ *                               notifications on the given DPIO service.
+ * @d:   the given DPIO service.
+ * @ctx: the notification context.
+ *
+ * The caller should make the MC command to attach a DPAA2 object to
+ * a DPIO after this function completes successfully.  In that way:
+ *    (a) The DPIO service is "ready" to handle a notification arrival
+ *        (which might happen before the "attach" command to MC has
+ *        returned control of execution back to the caller)
+ *    (b) The DPIO service can provide back to the caller the 'dpio_id' and
+ *        'qman64' parameters that it should pass along in the MC command
+ *        in order for the object to be configured to produce the right
+ *        notification fields to the DPIO service.
+ *
+ * Return 0 for success, or -ENODEV for failure.
+ */
+int dpaa2_io_service_register(struct dpaa2_io *d,
+			      struct dpaa2_io_notification_ctx *ctx)
+{
+	unsigned long irqflags;
+
+	d = service_select_by_cpu(d, ctx->desired_cpu);
+	if (!d)
+		return -ENODEV;
+
+	ctx->dpio_id = d->dpio_desc.dpio_id;
+	ctx->qman64 = (u64)(uintptr_t)ctx;
+	ctx->dpio_private = d;
+	spin_lock_irqsave(&d->lock_notifications, irqflags);
+	list_add(&ctx->node, &d->notifications);
+	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
+
+	/* Enable the generation of CDAN notifications */
+	if (ctx->is_cdan)
+		return qbman_swp_CDAN_set_context_enable(d->swp,
+							 (u16)ctx->id,
+							 ctx->qman64);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_register);
+
+/**
+ * dpaa2_io_service_deregister - The opposite of 'register'.
+ * @service: the given DPIO service.
+ * @ctx: the notification context.
+ *
+ * This function should be called only after sending the MC command to
+ * to detach the notification-producing device from the DPIO.
+ */
+void dpaa2_io_service_deregister(struct dpaa2_io *service,
+				 struct dpaa2_io_notification_ctx *ctx)
+{
+	struct dpaa2_io *d = ctx->dpio_private;
+	unsigned long irqflags;
+
+	if (ctx->is_cdan)
+		qbman_swp_CDAN_disable(d->swp, (u16)ctx->id);
+
+	spin_lock_irqsave(&d->lock_notifications, irqflags);
+	list_del(&ctx->node);
+	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_deregister);
+
+/**
+ * dpaa2_io_service_rearm() - Rearm the notification for the given DPIO service.
+ * @d: the given DPIO service.
+ * @ctx: the notification context.
+ *
+ * Once a FQDAN/CDAN has been produced, the corresponding FQ/channel is
+ * considered "disarmed". Ie. the user can issue pull dequeue operations on that
+ * traffic source for as long as it likes. Eventually it may wish to "rearm"
+ * that source to allow it to produce another FQDAN/CDAN, that's what this
+ * function achieves.
+ *
+ * Return 0 for success.
+ */
+int dpaa2_io_service_rearm(struct dpaa2_io *d,
+			   struct dpaa2_io_notification_ctx *ctx)
+{
+	unsigned long irqflags;
+	int err;
+
+	d = service_select_by_cpu(d, ctx->desired_cpu);
+	if (!unlikely(d))
+		return -ENODEV;
+
+	spin_lock_irqsave(&d->lock_mgmt_cmd, irqflags);
+	if (ctx->is_cdan)
+		err = qbman_swp_CDAN_enable(d->swp, (u16)ctx->id);
+	else
+		err = qbman_swp_fq_schedule(d->swp, ctx->id);
+	spin_unlock_irqrestore(&d->lock_mgmt_cmd, irqflags);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_rearm);
+
+/**
+ * dpaa2_io_service_pull_channel() - pull dequeue functions from a channel.
+ * @d: the given DPIO service.
+ * @channelid: the given channel id.
+ * @s: the dpaa2_io_store object for the result.
+ *
+ * Return 0 for success, or error code for failure.
+ */
+int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
+				  struct dpaa2_io_store *s)
+{
+	struct qbman_pull_desc pd;
+	int err;
+
+	qbman_pull_desc_clear(&pd);
+	qbman_pull_desc_set_storage(&pd, s->vaddr, s->paddr, 1);
+	qbman_pull_desc_set_numframes(&pd, (u8)s->max);
+	qbman_pull_desc_set_channel(&pd, channelid, qbman_pull_type_prio);
+
+	d = service_select(d);
+	if (!d)
+		return -ENODEV;
+
+	s->swp = d->swp;
+	err = qbman_swp_pull(d->swp, &pd);
+	if (err)
+		s->swp = NULL;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_pull_channel);
+
+/**
+ * dpaa2_io_service_enqueue_qd() - Enqueue a frame to a QD.
+ * @d: the given DPIO service.
+ * @qdid: the given queuing destination id.
+ * @prio: the given queuing priority.
+ * @qdbin: the given queuing destination bin.
+ * @fd: the frame descriptor which is enqueued.
+ *
+ * Return 0 for successful enqueue, or -EBUSY if the enqueue ring is not ready,
+ * or -ENODEV if there is no dpio service.
+ */
+int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d,
+				u32 qdid, u8 prio, u16 qdbin,
+				const struct dpaa2_fd *fd)
+{
+	struct qbman_eq_desc ed;
+
+	d = service_select(d);
+	if (!d)
+		return -ENODEV;
+
+	qbman_eq_desc_clear(&ed);
+	qbman_eq_desc_set_no_orp(&ed, 0);
+	qbman_eq_desc_set_qd(&ed, qdid, qdbin, prio);
+
+	return qbman_swp_enqueue(d->swp, &ed, fd);
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_enqueue_qd);
+
+/**
+ * dpaa2_io_service_release() - Release buffers to a buffer pool.
+ * @d: the given DPIO object.
+ * @bpid: the buffer pool id.
+ * @buffers: the buffers to be released.
+ * @num_buffers: the number of the buffers to be released.
+ *
+ * Return 0 for success, and negative error code for failure.
+ */
+int dpaa2_io_service_release(struct dpaa2_io *d,
+			     u32 bpid,
+			     const u64 *buffers,
+			     unsigned int num_buffers)
+{
+	struct qbman_release_desc rd;
+
+	d = service_select(d);
+	if (!d)
+		return -ENODEV;
+
+	qbman_release_desc_clear(&rd);
+	qbman_release_desc_set_bpid(&rd, bpid);
+
+	return qbman_swp_release(d->swp, &rd, buffers, num_buffers);
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_release);
+
+/**
+ * dpaa2_io_service_acquire() - Acquire buffers from a buffer pool.
+ * @d: the given DPIO object.
+ * @bpid: the buffer pool id.
+ * @buffers: the buffer addresses for acquired buffers.
+ * @num_buffers: the expected number of the buffers to acquire.
+ *
+ * Return a negative error code if the command failed, otherwise it returns
+ * the number of buffers acquired, which may be less than the number requested.
+ * Eg. if the buffer pool is empty, this will return zero.
+ */
+int dpaa2_io_service_acquire(struct dpaa2_io *d,
+			     u32 bpid,
+			     u64 *buffers,
+			     unsigned int num_buffers)
+{
+	unsigned long irqflags;
+	int err;
+
+	d = service_select(d);
+	if (!d)
+		return -ENODEV;
+
+	spin_lock_irqsave(&d->lock_mgmt_cmd, irqflags);
+	err = qbman_swp_acquire(d->swp, bpid, buffers, num_buffers);
+	spin_unlock_irqrestore(&d->lock_mgmt_cmd, irqflags);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_service_acquire);
+
+/*
+ * 'Stores' are reusable memory blocks for holding dequeue results, and to
+ * assist with parsing those results.
+ */
+
+/**
+ * dpaa2_io_store_create() - Create the dma memory storage for dequeue result.
+ * @max_frames: the maximum number of dequeued result for frames, must be <= 16.
+ * @dev:        the device to allow mapping/unmapping the DMAable region.
+ *
+ * The size of the storage is "max_frames*sizeof(struct dpaa2_dq)".
+ * The 'dpaa2_io_store' returned is a DPIO service managed object.
+ *
+ * Return pointer to dpaa2_io_store struct for successfully created storage
+ * memory, or NULL on error.
+ */
+struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
+					     struct device *dev)
+{
+	struct dpaa2_io_store *ret;
+	size_t size;
+
+	if (!max_frames || (max_frames > 16))
+		return NULL;
+
+	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
+	if (!ret)
+		return NULL;
+
+	ret->max = max_frames;
+	size = max_frames * sizeof(struct dpaa2_dq) + 64;
+	ret->alloced_addr = kzalloc(size, GFP_KERNEL);
+	if (!ret->alloced_addr) {
+		kfree(ret);
+		return NULL;
+	}
+
+	ret->vaddr = PTR_ALIGN(ret->alloced_addr, 64);
+	ret->paddr = dma_map_single(dev, ret->vaddr,
+				    sizeof(struct dpaa2_dq) * max_frames,
+				    DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, ret->paddr)) {
+		kfree(ret->alloced_addr);
+		kfree(ret);
+		return NULL;
+	}
+
+	ret->idx = 0;
+	ret->dev = dev;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
+
+/**
+ * dpaa2_io_store_destroy() - Frees the dma memory storage for dequeue
+ *                            result.
+ * @s: the storage memory to be destroyed.
+ */
+void dpaa2_io_store_destroy(struct dpaa2_io_store *s)
+{
+	dma_unmap_single(s->dev, s->paddr, sizeof(struct dpaa2_dq) * s->max,
+			 DMA_FROM_DEVICE);
+	kfree(s->alloced_addr);
+	kfree(s);
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_store_destroy);
+
+/**
+ * dpaa2_io_store_next() - Determine when the next dequeue result is available.
+ * @s: the dpaa2_io_store object.
+ * @is_last: indicate whether this is the last frame in the pull command.
+ *
+ * When an object driver performs dequeues to a dpaa2_io_store, this function
+ * can be used to determine when the next frame result is available. Once
+ * this function returns non-NULL, a subsequent call to it will try to find
+ * the next dequeue result.
+ *
+ * Note that if a pull-dequeue has a NULL result because the target FQ/channel
+ * was empty, then this function will also return NULL (rather than expecting
+ * the caller to always check for this. As such, "is_last" can be used to
+ * differentiate between "end-of-empty-dequeue" and "still-waiting".
+ *
+ * Return dequeue result for a valid dequeue result, or NULL for empty dequeue.
+ */
+struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_store *s, int *is_last)
+{
+	int match;
+	struct dpaa2_dq *ret = &s->vaddr[s->idx];
+
+	match = qbman_result_has_new_result(s->swp, ret);
+	if (!match) {
+		*is_last = 0;
+		return NULL;
+	}
+
+	s->idx++;
+
+	if (dpaa2_dq_is_pull_complete(ret)) {
+		*is_last = 1;
+		s->idx = 0;
+		/*
+		 * If we get an empty dequeue result to terminate a zero-results
+		 * vdqcr, return NULL to the caller rather than expecting him to
+		 * check non-NULL results every time.
+		 */
+		if (!(dpaa2_dq_flags(ret) & DPAA2_DQ_STAT_VALIDFRAME))
+			ret = NULL;
+	} else {
+		*is_last = 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dpaa2_io_store_next);
diff --git a/drivers/soc/fsl/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
new file mode 100644
index 0000000..3175057
--- /dev/null
+++ b/drivers/soc/fsl/dpio/dpio.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/fsl/mc.h>
+
+#include "dpio.h"
+#include "dpio-cmd.h"
+
+/*
+ * Data Path I/O Portal API
+ * Contains initialization APIs and runtime control APIs for DPIO
+ */
+
+/**
+ * dpio_open() - Open a control session for the specified object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @dpio_id:	DPIO unique ID
+ * @token:	Returned token; use in subsequent API calls
+ *
+ * This function can be used to open a control session for an
+ * already created object; an object may have been declared in
+ * the DPL or by calling the dpio_create() function.
+ * This function returns a unique authentication token,
+ * associated with the specific object ID and the specific MC
+ * portal; this token must be used in all subsequent commands for
+ * this specific object.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpio_open(struct fsl_mc_io *mc_io,
+	      u32 cmd_flags,
+	      int dpio_id,
+	      u16 *token)
+{
+	struct mc_command cmd = { 0 };
+	struct dpio_cmd_open *dpio_cmd;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPIO_CMDID_OPEN,
+					  cmd_flags,
+					  0);
+	dpio_cmd = (struct dpio_cmd_open *)cmd.params;
+	dpio_cmd->dpio_id = cpu_to_le32(dpio_id);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	*token = mc_cmd_hdr_read_token(&cmd);
+
+	return 0;
+}
+
+/**
+ * dpio_close() - Close the control session of the object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPIO object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpio_close(struct fsl_mc_io *mc_io,
+	       u32 cmd_flags,
+	       u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPIO_CMDID_CLOSE,
+					  cmd_flags,
+					  token);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpio_enable() - Enable the DPIO, allow I/O portal operations.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPIO object
+ *
+ * Return:	'0' on Success; Error code otherwise
+ */
+int dpio_enable(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPIO_CMDID_ENABLE,
+					  cmd_flags,
+					  token);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpio_disable() - Disable the DPIO, stop any I/O portal operation.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPIO object
+ *
+ * Return:	'0' on Success; Error code otherwise
+ */
+int dpio_disable(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token)
+{
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPIO_CMDID_DISABLE,
+					  cmd_flags,
+					  token);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpio_get_attributes() - Retrieve DPIO attributes
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPIO object
+ * @attr:	Returned object's attributes
+ *
+ * Return:	'0' on Success; Error code otherwise
+ */
+int dpio_get_attributes(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			struct dpio_attr *attr)
+{
+	struct mc_command cmd = { 0 };
+	struct dpio_rsp_get_attr *dpio_rsp;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPIO_CMDID_GET_ATTR,
+					  cmd_flags,
+					  token);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	dpio_rsp = (struct dpio_rsp_get_attr *)cmd.params;
+	attr->id = le32_to_cpu(dpio_rsp->id);
+	attr->qbman_portal_id = le16_to_cpu(dpio_rsp->qbman_portal_id);
+	attr->num_priorities = dpio_rsp->num_priorities;
+	attr->channel_mode = dpio_rsp->channel_mode & DPIO_CHANNEL_MODE_MASK;
+	attr->qbman_portal_ce_offset =
+		le64_to_cpu(dpio_rsp->qbman_portal_ce_addr);
+	attr->qbman_portal_ci_offset =
+		le64_to_cpu(dpio_rsp->qbman_portal_ci_addr);
+	attr->qbman_version = le32_to_cpu(dpio_rsp->qbman_version);
+
+	return 0;
+}
+
+/**
+ * dpio_get_api_version - Get Data Path I/O API version
+ * @mc_io:	Pointer to MC portal's DPIO object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @major_ver:	Major version of DPIO API
+ * @minor_ver:	Minor version of DPIO API
+ *
+ * Return:	'0' on Success; Error code otherwise
+ */
+int dpio_get_api_version(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 *major_ver,
+			 u16 *minor_ver)
+{
+	struct mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPIO_CMDID_GET_API_VERSION,
+					  cmd_flags, 0);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	mc_cmd_read_api_version(&cmd, major_ver, minor_ver);
+
+	return 0;
+}
diff --git a/drivers/soc/fsl/dpio/dpio.h b/drivers/soc/fsl/dpio/dpio.h
new file mode 100644
index 0000000..49194c8
--- /dev/null
+++ b/drivers/soc/fsl/dpio/dpio.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#ifndef __FSL_DPIO_H
+#define __FSL_DPIO_H
+
+struct fsl_mc_io;
+
+int dpio_open(struct fsl_mc_io	*mc_io,
+	      u32		cmd_flags,
+	      int		dpio_id,
+	      u16		*token);
+
+int dpio_close(struct fsl_mc_io	*mc_io,
+	       u32		cmd_flags,
+	       u16		token);
+
+/**
+ * enum dpio_channel_mode - DPIO notification channel mode
+ * @DPIO_NO_CHANNEL: No support for notification channel
+ * @DPIO_LOCAL_CHANNEL: Notifications on data availability can be received by a
+ *	dedicated channel in the DPIO; user should point the queue's
+ *	destination in the relevant interface to this DPIO
+ */
+enum dpio_channel_mode {
+	DPIO_NO_CHANNEL = 0,
+	DPIO_LOCAL_CHANNEL = 1,
+};
+
+/**
+ * struct dpio_cfg - Structure representing DPIO configuration
+ * @channel_mode: Notification channel mode
+ * @num_priorities: Number of priorities for the notification channel (1-8);
+ *			relevant only if 'channel_mode = DPIO_LOCAL_CHANNEL'
+ */
+struct dpio_cfg {
+	enum dpio_channel_mode	channel_mode;
+	u8		num_priorities;
+};
+
+int dpio_enable(struct fsl_mc_io	*mc_io,
+		u32		cmd_flags,
+		u16		token);
+
+int dpio_disable(struct fsl_mc_io	*mc_io,
+		 u32		cmd_flags,
+		 u16		token);
+
+/**
+ * struct dpio_attr - Structure representing DPIO attributes
+ * @id: DPIO object ID
+ * @qbman_portal_ce_offset: offset of the software portal cache-enabled area
+ * @qbman_portal_ci_offset: offset of the software portal cache-inhibited area
+ * @qbman_portal_id: Software portal ID
+ * @channel_mode: Notification channel mode
+ * @num_priorities: Number of priorities for the notification channel (1-8);
+ *			relevant only if 'channel_mode = DPIO_LOCAL_CHANNEL'
+ * @qbman_version: QBMAN version
+ */
+struct dpio_attr {
+	int			id;
+	u64		qbman_portal_ce_offset;
+	u64		qbman_portal_ci_offset;
+	u16		qbman_portal_id;
+	enum dpio_channel_mode	channel_mode;
+	u8			num_priorities;
+	u32		qbman_version;
+};
+
+int dpio_get_attributes(struct fsl_mc_io	*mc_io,
+			u32		cmd_flags,
+			u16		token,
+			struct dpio_attr	*attr);
+
+int dpio_get_api_version(struct fsl_mc_io *mc_io,
+			 u32 cmd_flags,
+			 u16 *major_ver,
+			 u16 *minor_ver);
+
+#endif /* __FSL_DPIO_H */
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
new file mode 100644
index 0000000..cf1d448
--- /dev/null
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -0,0 +1,1005 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016 NXP
+ *
+ */
+
+#include <asm/cacheflush.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <soc/fsl/dpaa2-global.h>
+
+#include "qbman-portal.h"
+
+#define QMAN_REV_4000   0x04000000
+#define QMAN_REV_4100   0x04010000
+#define QMAN_REV_4101   0x04010001
+#define QMAN_REV_MASK   0xffff0000
+
+/* All QBMan command and result structures use this "valid bit" encoding */
+#define QB_VALID_BIT ((u32)0x80)
+
+/* QBMan portal management command codes */
+#define QBMAN_MC_ACQUIRE       0x30
+#define QBMAN_WQCHAN_CONFIGURE 0x46
+
+/* CINH register offsets */
+#define QBMAN_CINH_SWP_EQAR    0x8c0
+#define QBMAN_CINH_SWP_DQPI    0xa00
+#define QBMAN_CINH_SWP_DCAP    0xac0
+#define QBMAN_CINH_SWP_SDQCR   0xb00
+#define QBMAN_CINH_SWP_RAR     0xcc0
+#define QBMAN_CINH_SWP_ISR     0xe00
+#define QBMAN_CINH_SWP_IER     0xe40
+#define QBMAN_CINH_SWP_ISDR    0xe80
+#define QBMAN_CINH_SWP_IIR     0xec0
+
+/* CENA register offsets */
+#define QBMAN_CENA_SWP_EQCR(n) (0x000 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_DQRR(n) (0x200 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_RCR(n)  (0x400 + ((u32)(n) << 6))
+#define QBMAN_CENA_SWP_CR      0x600
+#define QBMAN_CENA_SWP_RR(vb)  (0x700 + ((u32)(vb) >> 1))
+#define QBMAN_CENA_SWP_VDQCR   0x780
+
+/* Reverse mapping of QBMAN_CENA_SWP_DQRR() */
+#define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)(p) & 0x1ff) >> 6)
+
+/* Define token used to determine if response written to memory is valid */
+#define QMAN_DQ_TOKEN_VALID 1
+
+/* SDQCR attribute codes */
+#define QB_SDQCR_FC_SHIFT   29
+#define QB_SDQCR_FC_MASK    0x1
+#define QB_SDQCR_DCT_SHIFT  24
+#define QB_SDQCR_DCT_MASK   0x3
+#define QB_SDQCR_TOK_SHIFT  16
+#define QB_SDQCR_TOK_MASK   0xff
+#define QB_SDQCR_SRC_SHIFT  0
+#define QB_SDQCR_SRC_MASK   0xffff
+
+/* opaque token for static dequeues */
+#define QMAN_SDQCR_TOKEN    0xbb
+
+enum qbman_sdqcr_dct {
+	qbman_sdqcr_dct_null = 0,
+	qbman_sdqcr_dct_prio_ics,
+	qbman_sdqcr_dct_active_ics,
+	qbman_sdqcr_dct_active
+};
+
+enum qbman_sdqcr_fc {
+	qbman_sdqcr_fc_one = 0,
+	qbman_sdqcr_fc_up_to_3 = 1
+};
+
+/* Portal Access */
+
+static inline u32 qbman_read_register(struct qbman_swp *p, u32 offset)
+{
+	return readl_relaxed(p->addr_cinh + offset);
+}
+
+static inline void qbman_write_register(struct qbman_swp *p, u32 offset,
+					u32 value)
+{
+	writel_relaxed(value, p->addr_cinh + offset);
+}
+
+static inline void *qbman_get_cmd(struct qbman_swp *p, u32 offset)
+{
+	return p->addr_cena + offset;
+}
+
+#define QBMAN_CINH_SWP_CFG   0xd00
+
+#define SWP_CFG_DQRR_MF_SHIFT 20
+#define SWP_CFG_EST_SHIFT     16
+#define SWP_CFG_WN_SHIFT      14
+#define SWP_CFG_RPM_SHIFT     12
+#define SWP_CFG_DCM_SHIFT     10
+#define SWP_CFG_EPM_SHIFT     8
+#define SWP_CFG_SD_SHIFT      5
+#define SWP_CFG_SP_SHIFT      4
+#define SWP_CFG_SE_SHIFT      3
+#define SWP_CFG_DP_SHIFT      2
+#define SWP_CFG_DE_SHIFT      1
+#define SWP_CFG_EP_SHIFT      0
+
+static inline u32 qbman_set_swp_cfg(u8 max_fill, u8 wn,	u8 est, u8 rpm, u8 dcm,
+				    u8 epm, int sd, int sp, int se,
+				    int dp, int de, int ep)
+{
+	return (max_fill << SWP_CFG_DQRR_MF_SHIFT |
+		est << SWP_CFG_EST_SHIFT |
+		wn << SWP_CFG_WN_SHIFT |
+		rpm << SWP_CFG_RPM_SHIFT |
+		dcm << SWP_CFG_DCM_SHIFT |
+		epm << SWP_CFG_EPM_SHIFT |
+		sd << SWP_CFG_SD_SHIFT |
+		sp << SWP_CFG_SP_SHIFT |
+		se << SWP_CFG_SE_SHIFT |
+		dp << SWP_CFG_DP_SHIFT |
+		de << SWP_CFG_DE_SHIFT |
+		ep << SWP_CFG_EP_SHIFT);
+}
+
+/**
+ * qbman_swp_init() - Create a functional object representing the given
+ *                    QBMan portal descriptor.
+ * @d: the given qbman swp descriptor
+ *
+ * Return qbman_swp portal for success, NULL if the object cannot
+ * be created.
+ */
+struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
+{
+	struct qbman_swp *p = kmalloc(sizeof(*p), GFP_KERNEL);
+	u32 reg;
+
+	if (!p)
+		return NULL;
+	p->desc = d;
+	p->mc.valid_bit = QB_VALID_BIT;
+	p->sdq = 0;
+	p->sdq |= qbman_sdqcr_dct_prio_ics << QB_SDQCR_DCT_SHIFT;
+	p->sdq |= qbman_sdqcr_fc_up_to_3 << QB_SDQCR_FC_SHIFT;
+	p->sdq |= QMAN_SDQCR_TOKEN << QB_SDQCR_TOK_SHIFT;
+
+	atomic_set(&p->vdq.available, 1);
+	p->vdq.valid_bit = QB_VALID_BIT;
+	p->dqrr.next_idx = 0;
+	p->dqrr.valid_bit = QB_VALID_BIT;
+
+	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_4100) {
+		p->dqrr.dqrr_size = 4;
+		p->dqrr.reset_bug = 1;
+	} else {
+		p->dqrr.dqrr_size = 8;
+		p->dqrr.reset_bug = 0;
+	}
+
+	p->addr_cena = d->cena_bar;
+	p->addr_cinh = d->cinh_bar;
+
+	reg = qbman_set_swp_cfg(p->dqrr.dqrr_size,
+				1, /* Writes Non-cacheable */
+				0, /* EQCR_CI stashing threshold */
+				3, /* RPM: Valid bit mode, RCR in array mode */
+				2, /* DCM: Discrete consumption ack mode */
+				3, /* EPM: Valid bit mode, EQCR in array mode */
+				0, /* mem stashing drop enable == FALSE */
+				1, /* mem stashing priority == TRUE */
+				0, /* mem stashing enable == FALSE */
+				1, /* dequeue stashing priority == TRUE */
+				0, /* dequeue stashing enable == FALSE */
+				0); /* EQCR_CI stashing priority == FALSE */
+
+	qbman_write_register(p, QBMAN_CINH_SWP_CFG, reg);
+	reg = qbman_read_register(p, QBMAN_CINH_SWP_CFG);
+	if (!reg) {
+		pr_err("qbman: the portal is not enabled!\n");
+		return NULL;
+	}
+
+	/*
+	 * SDQCR needs to be initialized to 0 when no channels are
+	 * being dequeued from or else the QMan HW will indicate an
+	 * error.  The values that were calculated above will be
+	 * applied when dequeues from a specific channel are enabled.
+	 */
+	qbman_write_register(p, QBMAN_CINH_SWP_SDQCR, 0);
+	return p;
+}
+
+/**
+ * qbman_swp_finish() - Create and destroy a functional object representing
+ *                      the given QBMan portal descriptor.
+ * @p: the qbman_swp object to be destroyed
+ */
+void qbman_swp_finish(struct qbman_swp *p)
+{
+	kfree(p);
+}
+
+/**
+ * qbman_swp_interrupt_read_status()
+ * @p: the given software portal
+ *
+ * Return the value in the SWP_ISR register.
+ */
+u32 qbman_swp_interrupt_read_status(struct qbman_swp *p)
+{
+	return qbman_read_register(p, QBMAN_CINH_SWP_ISR);
+}
+
+/**
+ * qbman_swp_interrupt_clear_status()
+ * @p: the given software portal
+ * @mask: The mask to clear in SWP_ISR register
+ */
+void qbman_swp_interrupt_clear_status(struct qbman_swp *p, u32 mask)
+{
+	qbman_write_register(p, QBMAN_CINH_SWP_ISR, mask);
+}
+
+/**
+ * qbman_swp_interrupt_get_trigger() - read interrupt enable register
+ * @p: the given software portal
+ *
+ * Return the value in the SWP_IER register.
+ */
+u32 qbman_swp_interrupt_get_trigger(struct qbman_swp *p)
+{
+	return qbman_read_register(p, QBMAN_CINH_SWP_IER);
+}
+
+/**
+ * qbman_swp_interrupt_set_trigger() - enable interrupts for a swp
+ * @p: the given software portal
+ * @mask: The mask of bits to enable in SWP_IER
+ */
+void qbman_swp_interrupt_set_trigger(struct qbman_swp *p, u32 mask)
+{
+	qbman_write_register(p, QBMAN_CINH_SWP_IER, mask);
+}
+
+/**
+ * qbman_swp_interrupt_get_inhibit() - read interrupt mask register
+ * @p: the given software portal object
+ *
+ * Return the value in the SWP_IIR register.
+ */
+int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
+{
+	return qbman_read_register(p, QBMAN_CINH_SWP_IIR);
+}
+
+/**
+ * qbman_swp_interrupt_set_inhibit() - write interrupt mask register
+ * @p: the given software portal object
+ * @mask: The mask to set in SWP_IIR register
+ */
+void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
+{
+	qbman_write_register(p, QBMAN_CINH_SWP_IIR, inhibit ? 0xffffffff : 0);
+}
+
+/*
+ * Different management commands all use this common base layer of code to issue
+ * commands and poll for results.
+ */
+
+/*
+ * Returns a pointer to where the caller should fill in their management command
+ * (caller should ignore the verb byte)
+ */
+void *qbman_swp_mc_start(struct qbman_swp *p)
+{
+	return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
+}
+
+/*
+ * Commits merges in the caller-supplied command verb (which should not include
+ * the valid-bit) and submits the command to hardware
+ */
+void qbman_swp_mc_submit(struct qbman_swp *p, void *cmd, u8 cmd_verb)
+{
+	u8 *v = cmd;
+
+	dma_wmb();
+	*v = cmd_verb | p->mc.valid_bit;
+}
+
+/*
+ * Checks for a completed response (returns non-NULL if only if the response
+ * is complete).
+ */
+void *qbman_swp_mc_result(struct qbman_swp *p)
+{
+	u32 *ret, verb;
+
+	ret = qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
+
+	/* Remove the valid-bit - command completed if the rest is non-zero */
+	verb = ret[0] & ~QB_VALID_BIT;
+	if (!verb)
+		return NULL;
+	p->mc.valid_bit ^= QB_VALID_BIT;
+	return ret;
+}
+
+#define QB_ENQUEUE_CMD_OPTIONS_SHIFT    0
+enum qb_enqueue_commands {
+	enqueue_empty = 0,
+	enqueue_response_always = 1,
+	enqueue_rejects_to_fq = 2
+};
+
+#define QB_ENQUEUE_CMD_ORP_ENABLE_SHIFT      2
+#define QB_ENQUEUE_CMD_IRQ_ON_DISPATCH_SHIFT 3
+#define QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT     4
+
+/**
+ * qbman_eq_desc_clear() - Clear the contents of a descriptor to
+ *                         default/starting state.
+ */
+void qbman_eq_desc_clear(struct qbman_eq_desc *d)
+{
+	memset(d, 0, sizeof(*d));
+}
+
+/**
+ * qbman_eq_desc_set_no_orp() - Set enqueue descriptor without orp
+ * @d:                the enqueue descriptor.
+ * @response_success: 1 = enqueue with response always; 0 = enqueue with
+ *                    rejections returned on a FQ.
+ */
+void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
+{
+	d->verb &= ~(1 << QB_ENQUEUE_CMD_ORP_ENABLE_SHIFT);
+	if (respond_success)
+		d->verb |= enqueue_response_always;
+	else
+		d->verb |= enqueue_rejects_to_fq;
+}
+
+/*
+ * Exactly one of the following descriptor "targets" should be set. (Calling any
+ * one of these will replace the effect of any prior call to one of these.)
+ *   -enqueue to a frame queue
+ *   -enqueue to a queuing destination
+ */
+
+/**
+ * qbman_eq_desc_set_fq() - set the FQ for the enqueue command
+ * @d:    the enqueue descriptor
+ * @fqid: the id of the frame queue to be enqueued
+ */
+void qbman_eq_desc_set_fq(struct qbman_eq_desc *d, u32 fqid)
+{
+	d->verb &= ~(1 << QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT);
+	d->tgtid = cpu_to_le32(fqid);
+}
+
+/**
+ * qbman_eq_desc_set_qd() - Set Queuing Destination for the enqueue command
+ * @d:       the enqueue descriptor
+ * @qdid:    the id of the queuing destination to be enqueued
+ * @qd_bin:  the queuing destination bin
+ * @qd_prio: the queuing destination priority
+ */
+void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
+			  u32 qd_bin, u32 qd_prio)
+{
+	d->verb |= 1 << QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT;
+	d->tgtid = cpu_to_le32(qdid);
+	d->qdbin = cpu_to_le16(qd_bin);
+	d->qpri = qd_prio;
+}
+
+#define EQAR_IDX(eqar)     ((eqar) & 0x7)
+#define EQAR_VB(eqar)      ((eqar) & 0x80)
+#define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
+
+/**
+ * qbman_swp_enqueue() - Issue an enqueue command
+ * @s:  the software portal used for enqueue
+ * @d:  the enqueue descriptor
+ * @fd: the frame descriptor to be enqueued
+ *
+ * Please note that 'fd' should only be NULL if the "action" of the
+ * descriptor is "orp_hole" or "orp_nesn".
+ *
+ * Return 0 for successful enqueue, -EBUSY if the EQCR is not ready.
+ */
+int qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
+		      const struct dpaa2_fd *fd)
+{
+	struct qbman_eq_desc *p;
+	u32 eqar = qbman_read_register(s, QBMAN_CINH_SWP_EQAR);
+
+	if (!EQAR_SUCCESS(eqar))
+		return -EBUSY;
+
+	p = qbman_get_cmd(s, QBMAN_CENA_SWP_EQCR(EQAR_IDX(eqar)));
+	memcpy(&p->dca, &d->dca, 31);
+	memcpy(&p->fd, fd, sizeof(*fd));
+
+	/* Set the verb byte, have to substitute in the valid-bit */
+	dma_wmb();
+	p->verb = d->verb | EQAR_VB(eqar);
+
+	return 0;
+}
+
+/* Static (push) dequeue */
+
+/**
+ * qbman_swp_push_get() - Get the push dequeue setup
+ * @p:           the software portal object
+ * @channel_idx: the channel index to query
+ * @enabled:     returned boolean to show whether the push dequeue is enabled
+ *               for the given channel
+ */
+void qbman_swp_push_get(struct qbman_swp *s, u8 channel_idx, int *enabled)
+{
+	u16 src = (s->sdq >> QB_SDQCR_SRC_SHIFT) & QB_SDQCR_SRC_MASK;
+
+	WARN_ON(channel_idx > 15);
+	*enabled = src | (1 << channel_idx);
+}
+
+/**
+ * qbman_swp_push_set() - Enable or disable push dequeue
+ * @p:           the software portal object
+ * @channel_idx: the channel index (0 to 15)
+ * @enable:      enable or disable push dequeue
+ */
+void qbman_swp_push_set(struct qbman_swp *s, u8 channel_idx, int enable)
+{
+	u16 dqsrc;
+
+	WARN_ON(channel_idx > 15);
+	if (enable)
+		s->sdq |= 1 << channel_idx;
+	else
+		s->sdq &= ~(1 << channel_idx);
+
+	/* Read make the complete src map.  If no channels are enabled
+	 * the SDQCR must be 0 or else QMan will assert errors
+	 */
+	dqsrc = (s->sdq >> QB_SDQCR_SRC_SHIFT) & QB_SDQCR_SRC_MASK;
+	if (dqsrc != 0)
+		qbman_write_register(s, QBMAN_CINH_SWP_SDQCR, s->sdq);
+	else
+		qbman_write_register(s, QBMAN_CINH_SWP_SDQCR, 0);
+}
+
+#define QB_VDQCR_VERB_DCT_SHIFT    0
+#define QB_VDQCR_VERB_DT_SHIFT     2
+#define QB_VDQCR_VERB_RLS_SHIFT    4
+#define QB_VDQCR_VERB_WAE_SHIFT    5
+
+enum qb_pull_dt_e {
+	qb_pull_dt_channel,
+	qb_pull_dt_workqueue,
+	qb_pull_dt_framequeue
+};
+
+/**
+ * qbman_pull_desc_clear() - Clear the contents of a descriptor to
+ *                           default/starting state
+ * @d: the pull dequeue descriptor to be cleared
+ */
+void qbman_pull_desc_clear(struct qbman_pull_desc *d)
+{
+	memset(d, 0, sizeof(*d));
+}
+
+/**
+ * qbman_pull_desc_set_storage()- Set the pull dequeue storage
+ * @d:            the pull dequeue descriptor to be set
+ * @storage:      the pointer of the memory to store the dequeue result
+ * @storage_phys: the physical address of the storage memory
+ * @stash:        to indicate whether write allocate is enabled
+ *
+ * If not called, or if called with 'storage' as NULL, the result pull dequeues
+ * will produce results to DQRR. If 'storage' is non-NULL, then results are
+ * produced to the given memory location (using the DMA address which
+ * the caller provides in 'storage_phys'), and 'stash' controls whether or not
+ * those writes to main-memory express a cache-warming attribute.
+ */
+void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
+				 struct dpaa2_dq *storage,
+				 dma_addr_t storage_phys,
+				 int stash)
+{
+	/* save the virtual address */
+	d->rsp_addr_virt = (u64)(uintptr_t)storage;
+
+	if (!storage) {
+		d->verb &= ~(1 << QB_VDQCR_VERB_RLS_SHIFT);
+		return;
+	}
+	d->verb |= 1 << QB_VDQCR_VERB_RLS_SHIFT;
+	if (stash)
+		d->verb |= 1 << QB_VDQCR_VERB_WAE_SHIFT;
+	else
+		d->verb &= ~(1 << QB_VDQCR_VERB_WAE_SHIFT);
+
+	d->rsp_addr = cpu_to_le64(storage_phys);
+}
+
+/**
+ * qbman_pull_desc_set_numframes() - Set the number of frames to be dequeued
+ * @d:         the pull dequeue descriptor to be set
+ * @numframes: number of frames to be set, must be between 1 and 16, inclusive
+ */
+void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes)
+{
+	d->numf = numframes - 1;
+}
+
+/*
+ * Exactly one of the following descriptor "actions" should be set. (Calling any
+ * one of these will replace the effect of any prior call to one of these.)
+ * - pull dequeue from the given frame queue (FQ)
+ * - pull dequeue from any FQ in the given work queue (WQ)
+ * - pull dequeue from any FQ in any WQ in the given channel
+ */
+
+/**
+ * qbman_pull_desc_set_fq() - Set fqid from which the dequeue command dequeues
+ * @fqid: the frame queue index of the given FQ
+ */
+void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, u32 fqid)
+{
+	d->verb |= 1 << QB_VDQCR_VERB_DCT_SHIFT;
+	d->verb |= qb_pull_dt_framequeue << QB_VDQCR_VERB_DT_SHIFT;
+	d->dq_src = cpu_to_le32(fqid);
+}
+
+/**
+ * qbman_pull_desc_set_wq() - Set wqid from which the dequeue command dequeues
+ * @wqid: composed of channel id and wqid within the channel
+ * @dct:  the dequeue command type
+ */
+void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, u32 wqid,
+			    enum qbman_pull_type_e dct)
+{
+	d->verb |= dct << QB_VDQCR_VERB_DCT_SHIFT;
+	d->verb |= qb_pull_dt_workqueue << QB_VDQCR_VERB_DT_SHIFT;
+	d->dq_src = cpu_to_le32(wqid);
+}
+
+/**
+ * qbman_pull_desc_set_channel() - Set channelid from which the dequeue command
+ *                                 dequeues
+ * @chid: the channel id to be dequeued
+ * @dct:  the dequeue command type
+ */
+void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, u32 chid,
+				 enum qbman_pull_type_e dct)
+{
+	d->verb |= dct << QB_VDQCR_VERB_DCT_SHIFT;
+	d->verb |= qb_pull_dt_channel << QB_VDQCR_VERB_DT_SHIFT;
+	d->dq_src = cpu_to_le32(chid);
+}
+
+/**
+ * qbman_swp_pull() - Issue the pull dequeue command
+ * @s: the software portal object
+ * @d: the software portal descriptor which has been configured with
+ *     the set of qbman_pull_desc_set_*() calls
+ *
+ * Return 0 for success, and -EBUSY if the software portal is not ready
+ * to do pull dequeue.
+ */
+int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
+{
+	struct qbman_pull_desc *p;
+
+	if (!atomic_dec_and_test(&s->vdq.available)) {
+		atomic_inc(&s->vdq.available);
+		return -EBUSY;
+	}
+	s->vdq.storage = (void *)(uintptr_t)d->rsp_addr_virt;
+	p = qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
+	p->numf = d->numf;
+	p->tok = QMAN_DQ_TOKEN_VALID;
+	p->dq_src = d->dq_src;
+	p->rsp_addr = d->rsp_addr;
+	p->rsp_addr_virt = d->rsp_addr_virt;
+	dma_wmb();
+
+	/* Set the verb byte, have to substitute in the valid-bit */
+	p->verb = d->verb | s->vdq.valid_bit;
+	s->vdq.valid_bit ^= QB_VALID_BIT;
+
+	return 0;
+}
+
+#define QMAN_DQRR_PI_MASK   0xf
+
+/**
+ * qbman_swp_dqrr_next() - Get an valid DQRR entry
+ * @s: the software portal object
+ *
+ * Return NULL if there are no unconsumed DQRR entries. Return a DQRR entry
+ * only once, so repeated calls can return a sequence of DQRR entries, without
+ * requiring they be consumed immediately or in any particular order.
+ */
+const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s)
+{
+	u32 verb;
+	u32 response_verb;
+	u32 flags;
+	struct dpaa2_dq *p;
+
+	/* Before using valid-bit to detect if something is there, we have to
+	 * handle the case of the DQRR reset bug...
+	 */
+	if (unlikely(s->dqrr.reset_bug)) {
+		/*
+		 * We pick up new entries by cache-inhibited producer index,
+		 * which means that a non-coherent mapping would require us to
+		 * invalidate and read *only* once that PI has indicated that
+		 * there's an entry here. The first trip around the DQRR ring
+		 * will be much less efficient than all subsequent trips around
+		 * it...
+		 */
+		u8 pi = qbman_read_register(s, QBMAN_CINH_SWP_DQPI) &
+			QMAN_DQRR_PI_MASK;
+
+		/* there are new entries if pi != next_idx */
+		if (pi == s->dqrr.next_idx)
+			return NULL;
+
+		/*
+		 * if next_idx is/was the last ring index, and 'pi' is
+		 * different, we can disable the workaround as all the ring
+		 * entries have now been DMA'd to so valid-bit checking is
+		 * repaired. Note: this logic needs to be based on next_idx
+		 * (which increments one at a time), rather than on pi (which
+		 * can burst and wrap-around between our snapshots of it).
+		 */
+		if (s->dqrr.next_idx == (s->dqrr.dqrr_size - 1)) {
+			pr_debug("next_idx=%d, pi=%d, clear reset bug\n",
+				 s->dqrr.next_idx, pi);
+			s->dqrr.reset_bug = 0;
+		}
+		prefetch(qbman_get_cmd(s,
+				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
+	}
+
+	p = qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
+	verb = p->dq.verb;
+
+	/*
+	 * If the valid-bit isn't of the expected polarity, nothing there. Note,
+	 * in the DQRR reset bug workaround, we shouldn't need to skip these
+	 * check, because we've already determined that a new entry is available
+	 * and we've invalidated the cacheline before reading it, so the
+	 * valid-bit behaviour is repaired and should tell us what we already
+	 * knew from reading PI.
+	 */
+	if ((verb & QB_VALID_BIT) != s->dqrr.valid_bit) {
+		prefetch(qbman_get_cmd(s,
+				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
+		return NULL;
+	}
+	/*
+	 * There's something there. Move "next_idx" attention to the next ring
+	 * entry (and prefetch it) before returning what we found.
+	 */
+	s->dqrr.next_idx++;
+	s->dqrr.next_idx &= s->dqrr.dqrr_size - 1; /* Wrap around */
+	if (!s->dqrr.next_idx)
+		s->dqrr.valid_bit ^= QB_VALID_BIT;
+
+	/*
+	 * If this is the final response to a volatile dequeue command
+	 * indicate that the vdq is available
+	 */
+	flags = p->dq.stat;
+	response_verb = verb & QBMAN_RESULT_MASK;
+	if ((response_verb == QBMAN_RESULT_DQ) &&
+	    (flags & DPAA2_DQ_STAT_VOLATILE) &&
+	    (flags & DPAA2_DQ_STAT_EXPIRED))
+		atomic_inc(&s->vdq.available);
+
+	prefetch(qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
+
+	return p;
+}
+
+/**
+ * qbman_swp_dqrr_consume() -  Consume DQRR entries previously returned from
+ *                             qbman_swp_dqrr_next().
+ * @s: the software portal object
+ * @dq: the DQRR entry to be consumed
+ */
+void qbman_swp_dqrr_consume(struct qbman_swp *s, const struct dpaa2_dq *dq)
+{
+	qbman_write_register(s, QBMAN_CINH_SWP_DCAP, QBMAN_IDX_FROM_DQRR(dq));
+}
+
+/**
+ * qbman_result_has_new_result() - Check and get the dequeue response from the
+ *                                 dq storage memory set in pull dequeue command
+ * @s: the software portal object
+ * @dq: the dequeue result read from the memory
+ *
+ * Return 1 for getting a valid dequeue result, or 0 for not getting a valid
+ * dequeue result.
+ *
+ * Only used for user-provided storage of dequeue results, not DQRR. For
+ * efficiency purposes, the driver will perform any required endianness
+ * conversion to ensure that the user's dequeue result storage is in host-endian
+ * format. As such, once the user has called qbman_result_has_new_result() and
+ * been returned a valid dequeue result, they should not call it again on
+ * the same memory location (except of course if another dequeue command has
+ * been executed to produce a new result to that location).
+ */
+int qbman_result_has_new_result(struct qbman_swp *s, const struct dpaa2_dq *dq)
+{
+	if (dq->dq.tok != QMAN_DQ_TOKEN_VALID)
+		return 0;
+
+	/*
+	 * Set token to be 0 so we will detect change back to 1
+	 * next time the looping is traversed. Const is cast away here
+	 * as we want users to treat the dequeue responses as read only.
+	 */
+	((struct dpaa2_dq *)dq)->dq.tok = 0;
+
+	/*
+	 * Determine whether VDQCR is available based on whether the
+	 * current result is sitting in the first storage location of
+	 * the busy command.
+	 */
+	if (s->vdq.storage == dq) {
+		s->vdq.storage = NULL;
+		atomic_inc(&s->vdq.available);
+	}
+
+	return 1;
+}
+
+/**
+ * qbman_release_desc_clear() - Clear the contents of a descriptor to
+ *                              default/starting state.
+ */
+void qbman_release_desc_clear(struct qbman_release_desc *d)
+{
+	memset(d, 0, sizeof(*d));
+	d->verb = 1 << 5; /* Release Command Valid */
+}
+
+/**
+ * qbman_release_desc_set_bpid() - Set the ID of the buffer pool to release to
+ */
+void qbman_release_desc_set_bpid(struct qbman_release_desc *d, u16 bpid)
+{
+	d->bpid = cpu_to_le16(bpid);
+}
+
+/**
+ * qbman_release_desc_set_rcdi() - Determines whether or not the portal's RCDI
+ * interrupt source should be asserted after the release command is completed.
+ */
+void qbman_release_desc_set_rcdi(struct qbman_release_desc *d, int enable)
+{
+	if (enable)
+		d->verb |= 1 << 6;
+	else
+		d->verb &= ~(1 << 6);
+}
+
+#define RAR_IDX(rar)     ((rar) & 0x7)
+#define RAR_VB(rar)      ((rar) & 0x80)
+#define RAR_SUCCESS(rar) ((rar) & 0x100)
+
+/**
+ * qbman_swp_release() - Issue a buffer release command
+ * @s:           the software portal object
+ * @d:           the release descriptor
+ * @buffers:     a pointer pointing to the buffer address to be released
+ * @num_buffers: number of buffers to be released,  must be less than 8
+ *
+ * Return 0 for success, -EBUSY if the release command ring is not ready.
+ */
+int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
+		      const u64 *buffers, unsigned int num_buffers)
+{
+	int i;
+	struct qbman_release_desc *p;
+	u32 rar;
+
+	if (!num_buffers || (num_buffers > 7))
+		return -EINVAL;
+
+	rar = qbman_read_register(s, QBMAN_CINH_SWP_RAR);
+	if (!RAR_SUCCESS(rar))
+		return -EBUSY;
+
+	/* Start the release command */
+	p = qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
+	/* Copy the caller's buffer pointers to the command */
+	for (i = 0; i < num_buffers; i++)
+		p->buf[i] = cpu_to_le64(buffers[i]);
+	p->bpid = d->bpid;
+
+	/*
+	 * Set the verb byte, have to substitute in the valid-bit and the number
+	 * of buffers.
+	 */
+	dma_wmb();
+	p->verb = d->verb | RAR_VB(rar) | num_buffers;
+
+	return 0;
+}
+
+struct qbman_acquire_desc {
+	u8 verb;
+	u8 reserved;
+	__le16 bpid;
+	u8 num;
+	u8 reserved2[59];
+};
+
+struct qbman_acquire_rslt {
+	u8 verb;
+	u8 rslt;
+	__le16 reserved;
+	u8 num;
+	u8 reserved2[3];
+	__le64 buf[7];
+};
+
+/**
+ * qbman_swp_acquire() - Issue a buffer acquire command
+ * @s:           the software portal object
+ * @bpid:        the buffer pool index
+ * @buffers:     a pointer pointing to the acquired buffer addresses
+ * @num_buffers: number of buffers to be acquired, must be less than 8
+ *
+ * Return 0 for success, or negative error code if the acquire command
+ * fails.
+ */
+int qbman_swp_acquire(struct qbman_swp *s, u16 bpid, u64 *buffers,
+		      unsigned int num_buffers)
+{
+	struct qbman_acquire_desc *p;
+	struct qbman_acquire_rslt *r;
+	int i;
+
+	if (!num_buffers || (num_buffers > 7))
+		return -EINVAL;
+
+	/* Start the management command */
+	p = qbman_swp_mc_start(s);
+
+	if (!p)
+		return -EBUSY;
+
+	/* Encode the caller-provided attributes */
+	p->bpid = cpu_to_le16(bpid);
+	p->num = num_buffers;
+
+	/* Complete the management command */
+	r = qbman_swp_mc_complete(s, p, QBMAN_MC_ACQUIRE);
+	if (unlikely(!r)) {
+		pr_err("qbman: acquire from BPID %d failed, no response\n",
+		       bpid);
+		return -EIO;
+	}
+
+	/* Decode the outcome */
+	WARN_ON((r->verb & 0x7f) != QBMAN_MC_ACQUIRE);
+
+	/* Determine success or failure */
+	if (unlikely(r->rslt != QBMAN_MC_RSLT_OK)) {
+		pr_err("qbman: acquire from BPID 0x%x failed, code=0x%02x\n",
+		       bpid, r->rslt);
+		return -EIO;
+	}
+
+	WARN_ON(r->num > num_buffers);
+
+	/* Copy the acquired buffers to the caller's array */
+	for (i = 0; i < r->num; i++)
+		buffers[i] = le64_to_cpu(r->buf[i]);
+
+	return (int)r->num;
+}
+
+struct qbman_alt_fq_state_desc {
+	u8 verb;
+	u8 reserved[3];
+	__le32 fqid;
+	u8 reserved2[56];
+};
+
+struct qbman_alt_fq_state_rslt {
+	u8 verb;
+	u8 rslt;
+	u8 reserved[62];
+};
+
+#define ALT_FQ_FQID_MASK 0x00FFFFFF
+
+int qbman_swp_alt_fq_state(struct qbman_swp *s, u32 fqid,
+			   u8 alt_fq_verb)
+{
+	struct qbman_alt_fq_state_desc *p;
+	struct qbman_alt_fq_state_rslt *r;
+
+	/* Start the management command */
+	p = qbman_swp_mc_start(s);
+	if (!p)
+		return -EBUSY;
+
+	p->fqid = cpu_to_le32(fqid & ALT_FQ_FQID_MASK);
+
+	/* Complete the management command */
+	r = qbman_swp_mc_complete(s, p, alt_fq_verb);
+	if (unlikely(!r)) {
+		pr_err("qbman: mgmt cmd failed, no response (verb=0x%x)\n",
+		       alt_fq_verb);
+		return -EIO;
+	}
+
+	/* Decode the outcome */
+	WARN_ON((r->verb & QBMAN_RESULT_MASK) != alt_fq_verb);
+
+	/* Determine success or failure */
+	if (unlikely(r->rslt != QBMAN_MC_RSLT_OK)) {
+		pr_err("qbman: ALT FQID %d failed: verb = 0x%08x code = 0x%02x\n",
+		       fqid, r->verb, r->rslt);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+struct qbman_cdan_ctrl_desc {
+	u8 verb;
+	u8 reserved;
+	__le16 ch;
+	u8 we;
+	u8 ctrl;
+	__le16 reserved2;
+	__le64 cdan_ctx;
+	u8 reserved3[48];
+
+};
+
+struct qbman_cdan_ctrl_rslt {
+	u8 verb;
+	u8 rslt;
+	__le16 ch;
+	u8 reserved[60];
+};
+
+int qbman_swp_CDAN_set(struct qbman_swp *s, u16 channelid,
+		       u8 we_mask, u8 cdan_en,
+		       u64 ctx)
+{
+	struct qbman_cdan_ctrl_desc *p = NULL;
+	struct qbman_cdan_ctrl_rslt *r = NULL;
+
+	/* Start the management command */
+	p = qbman_swp_mc_start(s);
+	if (!p)
+		return -EBUSY;
+
+	/* Encode the caller-provided attributes */
+	p->ch = cpu_to_le16(channelid);
+	p->we = we_mask;
+	if (cdan_en)
+		p->ctrl = 1;
+	else
+		p->ctrl = 0;
+	p->cdan_ctx = cpu_to_le64(ctx);
+
+	/* Complete the management command */
+	r = qbman_swp_mc_complete(s, p, QBMAN_WQCHAN_CONFIGURE);
+	if (unlikely(!r)) {
+		pr_err("qbman: wqchan config failed, no response\n");
+		return -EIO;
+	}
+
+	WARN_ON((r->verb & 0x7f) != QBMAN_WQCHAN_CONFIGURE);
+
+	/* Determine success or failure */
+	if (unlikely(r->rslt != QBMAN_MC_RSLT_OK)) {
+		pr_err("qbman: CDAN cQID %d failed: code = 0x%02x\n",
+		       channelid, r->rslt);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/soc/fsl/dpio/qbman-portal.h b/drivers/soc/fsl/dpio/qbman-portal.h
new file mode 100644
index 0000000..b2eed20
--- /dev/null
+++ b/drivers/soc/fsl/dpio/qbman-portal.h
@@ -0,0 +1,444 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#ifndef __FSL_QBMAN_PORTAL_H
+#define __FSL_QBMAN_PORTAL_H
+
+#include <soc/fsl/dpaa2-fd.h>
+
+struct dpaa2_dq;
+struct qbman_swp;
+
+/* qbman software portal descriptor structure */
+struct qbman_swp_desc {
+	void *cena_bar; /* Cache-enabled portal base address */
+	void *cinh_bar; /* Cache-inhibited portal base address */
+	u32 qman_version;
+};
+
+#define QBMAN_SWP_INTERRUPT_EQRI 0x01
+#define QBMAN_SWP_INTERRUPT_EQDI 0x02
+#define QBMAN_SWP_INTERRUPT_DQRI 0x04
+#define QBMAN_SWP_INTERRUPT_RCRI 0x08
+#define QBMAN_SWP_INTERRUPT_RCDI 0x10
+#define QBMAN_SWP_INTERRUPT_VDCI 0x20
+
+/* the structure for pull dequeue descriptor */
+struct qbman_pull_desc {
+	u8 verb;
+	u8 numf;
+	u8 tok;
+	u8 reserved;
+	__le32 dq_src;
+	__le64 rsp_addr;
+	u64 rsp_addr_virt;
+	u8 padding[40];
+};
+
+enum qbman_pull_type_e {
+	/* dequeue with priority precedence, respect intra-class scheduling */
+	qbman_pull_type_prio = 1,
+	/* dequeue with active FQ precedence, respect ICS */
+	qbman_pull_type_active,
+	/* dequeue with active FQ precedence, no ICS */
+	qbman_pull_type_active_noics
+};
+
+/* Definitions for parsing dequeue entries */
+#define QBMAN_RESULT_MASK      0x7f
+#define QBMAN_RESULT_DQ        0x60
+#define QBMAN_RESULT_FQRN      0x21
+#define QBMAN_RESULT_FQRNI     0x22
+#define QBMAN_RESULT_FQPN      0x24
+#define QBMAN_RESULT_FQDAN     0x25
+#define QBMAN_RESULT_CDAN      0x26
+#define QBMAN_RESULT_CSCN_MEM  0x27
+#define QBMAN_RESULT_CGCU      0x28
+#define QBMAN_RESULT_BPSCN     0x29
+#define QBMAN_RESULT_CSCN_WQ   0x2a
+
+/* QBMan FQ management command codes */
+#define QBMAN_FQ_SCHEDULE	0x48
+#define QBMAN_FQ_FORCE		0x49
+#define QBMAN_FQ_XON		0x4d
+#define QBMAN_FQ_XOFF		0x4e
+
+/* structure of enqueue descriptor */
+struct qbman_eq_desc {
+	u8 verb;
+	u8 dca;
+	__le16 seqnum;
+	__le16 orpid;
+	__le16 reserved1;
+	__le32 tgtid;
+	__le32 tag;
+	__le16 qdbin;
+	u8 qpri;
+	u8 reserved[3];
+	u8 wae;
+	u8 rspid;
+	__le64 rsp_addr;
+	u8 fd[32];
+};
+
+/* buffer release descriptor */
+struct qbman_release_desc {
+	u8 verb;
+	u8 reserved;
+	__le16 bpid;
+	__le32 reserved2;
+	__le64 buf[7];
+};
+
+/* Management command result codes */
+#define QBMAN_MC_RSLT_OK      0xf0
+
+#define CODE_CDAN_WE_EN    0x1
+#define CODE_CDAN_WE_CTX   0x4
+
+/* portal data structure */
+struct qbman_swp {
+	const struct qbman_swp_desc *desc;
+	void __iomem *addr_cena;
+	void __iomem *addr_cinh;
+
+	/* Management commands */
+	struct {
+		u32 valid_bit; /* 0x00 or 0x80 */
+	} mc;
+
+	/* Push dequeues */
+	u32 sdq;
+
+	/* Volatile dequeues */
+	struct {
+		atomic_t available; /* indicates if a command can be sent */
+		u32 valid_bit; /* 0x00 or 0x80 */
+		struct dpaa2_dq *storage; /* NULL if DQRR */
+	} vdq;
+
+	/* DQRR */
+	struct {
+		u32 next_idx;
+		u32 valid_bit;
+		u8 dqrr_size;
+		int reset_bug; /* indicates dqrr reset workaround is needed */
+	} dqrr;
+};
+
+struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d);
+void qbman_swp_finish(struct qbman_swp *p);
+u32 qbman_swp_interrupt_read_status(struct qbman_swp *p);
+void qbman_swp_interrupt_clear_status(struct qbman_swp *p, u32 mask);
+u32 qbman_swp_interrupt_get_trigger(struct qbman_swp *p);
+void qbman_swp_interrupt_set_trigger(struct qbman_swp *p, u32 mask);
+int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p);
+void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit);
+
+void qbman_swp_push_get(struct qbman_swp *p, u8 channel_idx, int *enabled);
+void qbman_swp_push_set(struct qbman_swp *p, u8 channel_idx, int enable);
+
+void qbman_pull_desc_clear(struct qbman_pull_desc *d);
+void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
+				 struct dpaa2_dq *storage,
+				 dma_addr_t storage_phys,
+				 int stash);
+void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes);
+void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, u32 fqid);
+void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, u32 wqid,
+			    enum qbman_pull_type_e dct);
+void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, u32 chid,
+				 enum qbman_pull_type_e dct);
+
+int qbman_swp_pull(struct qbman_swp *p, struct qbman_pull_desc *d);
+
+const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s);
+void qbman_swp_dqrr_consume(struct qbman_swp *s, const struct dpaa2_dq *dq);
+
+int qbman_result_has_new_result(struct qbman_swp *p, const struct dpaa2_dq *dq);
+
+void qbman_eq_desc_clear(struct qbman_eq_desc *d);
+void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success);
+void qbman_eq_desc_set_token(struct qbman_eq_desc *d, u8 token);
+void qbman_eq_desc_set_fq(struct qbman_eq_desc *d, u32 fqid);
+void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
+			  u32 qd_bin, u32 qd_prio);
+
+int qbman_swp_enqueue(struct qbman_swp *p, const struct qbman_eq_desc *d,
+		      const struct dpaa2_fd *fd);
+
+void qbman_release_desc_clear(struct qbman_release_desc *d);
+void qbman_release_desc_set_bpid(struct qbman_release_desc *d, u16 bpid);
+void qbman_release_desc_set_rcdi(struct qbman_release_desc *d, int enable);
+
+int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
+		      const u64 *buffers, unsigned int num_buffers);
+int qbman_swp_acquire(struct qbman_swp *s, u16 bpid, u64 *buffers,
+		      unsigned int num_buffers);
+int qbman_swp_alt_fq_state(struct qbman_swp *s, u32 fqid,
+			   u8 alt_fq_verb);
+int qbman_swp_CDAN_set(struct qbman_swp *s, u16 channelid,
+		       u8 we_mask, u8 cdan_en,
+		       u64 ctx);
+
+void *qbman_swp_mc_start(struct qbman_swp *p);
+void qbman_swp_mc_submit(struct qbman_swp *p, void *cmd, u8 cmd_verb);
+void *qbman_swp_mc_result(struct qbman_swp *p);
+
+/**
+ * qbman_result_is_DQ() - check if the dequeue result is a dequeue response
+ * @dq: the dequeue result to be checked
+ *
+ * DQRR entries may contain non-dequeue results, ie. notifications
+ */
+static inline int qbman_result_is_DQ(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_DQ);
+}
+
+/**
+ * qbman_result_is_SCN() - Check the dequeue result is notification or not
+ * @dq: the dequeue result to be checked
+ *
+ */
+static inline int qbman_result_is_SCN(const struct dpaa2_dq *dq)
+{
+	return !qbman_result_is_DQ(dq);
+}
+
+/* FQ Data Availability */
+static inline int qbman_result_is_FQDAN(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQDAN);
+}
+
+/* Channel Data Availability */
+static inline int qbman_result_is_CDAN(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_CDAN);
+}
+
+/* Congestion State Change */
+static inline int qbman_result_is_CSCN(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_CSCN_WQ);
+}
+
+/* Buffer Pool State Change */
+static inline int qbman_result_is_BPSCN(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_BPSCN);
+}
+
+/* Congestion Group Count Update */
+static inline int qbman_result_is_CGCU(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_CGCU);
+}
+
+/* Retirement */
+static inline int qbman_result_is_FQRN(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQRN);
+}
+
+/* Retirement Immediate */
+static inline int qbman_result_is_FQRNI(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQRNI);
+}
+
+ /* Park */
+static inline int qbman_result_is_FQPN(const struct dpaa2_dq *dq)
+{
+	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQPN);
+}
+
+/**
+ * qbman_result_SCN_state() - Get the state field in State-change notification
+ */
+static inline u8 qbman_result_SCN_state(const struct dpaa2_dq *scn)
+{
+	return scn->scn.state;
+}
+
+#define SCN_RID_MASK 0x00FFFFFF
+
+/**
+ * qbman_result_SCN_rid() - Get the resource id in State-change notification
+ */
+static inline u32 qbman_result_SCN_rid(const struct dpaa2_dq *scn)
+{
+	return le32_to_cpu(scn->scn.rid_tok) & SCN_RID_MASK;
+}
+
+/**
+ * qbman_result_SCN_ctx() - Get the context data in State-change notification
+ */
+static inline u64 qbman_result_SCN_ctx(const struct dpaa2_dq *scn)
+{
+	return le64_to_cpu(scn->scn.ctx);
+}
+
+/**
+ * qbman_swp_fq_schedule() - Move the fq to the scheduled state
+ * @s:    the software portal object
+ * @fqid: the index of frame queue to be scheduled
+ *
+ * There are a couple of different ways that a FQ can end up parked state,
+ * This schedules it.
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_fq_schedule(struct qbman_swp *s, u32 fqid)
+{
+	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_SCHEDULE);
+}
+
+/**
+ * qbman_swp_fq_force() - Force the FQ to fully scheduled state
+ * @s:    the software portal object
+ * @fqid: the index of frame queue to be forced
+ *
+ * Force eligible will force a tentatively-scheduled FQ to be fully-scheduled
+ * and thus be available for selection by any channel-dequeuing behaviour (push
+ * or pull). If the FQ is subsequently "dequeued" from the channel and is still
+ * empty at the time this happens, the resulting dq_entry will have no FD.
+ * (qbman_result_DQ_fd() will return NULL.)
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_fq_force(struct qbman_swp *s, u32 fqid)
+{
+	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_FORCE);
+}
+
+/**
+ * qbman_swp_fq_xon() - sets FQ flow-control to XON
+ * @s:    the software portal object
+ * @fqid: the index of frame queue
+ *
+ * This setting doesn't affect enqueues to the FQ, just dequeues.
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_fq_xon(struct qbman_swp *s, u32 fqid)
+{
+	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_XON);
+}
+
+/**
+ * qbman_swp_fq_xoff() - sets FQ flow-control to XOFF
+ * @s:    the software portal object
+ * @fqid: the index of frame queue
+ *
+ * This setting doesn't affect enqueues to the FQ, just dequeues.
+ * XOFF FQs will remain in the tenatively-scheduled state, even when
+ * non-empty, meaning they won't be selected for scheduled dequeuing.
+ * If a FQ is changed to XOFF after it had already become truly-scheduled
+ * to a channel, and a pull dequeue of that channel occurs that selects
+ * that FQ for dequeuing, then the resulting dq_entry will have no FD.
+ * (qbman_result_DQ_fd() will return NULL.)
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_fq_xoff(struct qbman_swp *s, u32 fqid)
+{
+	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_XOFF);
+}
+
+/* If the user has been allocated a channel object that is going to generate
+ * CDANs to another channel, then the qbman_swp_CDAN* functions will be
+ * necessary.
+ *
+ * CDAN-enabled channels only generate a single CDAN notification, after which
+ * they need to be reenabled before they'll generate another. The idea is
+ * that pull dequeuing will occur in reaction to the CDAN, followed by a
+ * reenable step. Each function generates a distinct command to hardware, so a
+ * combination function is provided if the user wishes to modify the "context"
+ * (which shows up in each CDAN message) each time they reenable, as a single
+ * command to hardware.
+ */
+
+/**
+ * qbman_swp_CDAN_set_context() - Set CDAN context
+ * @s:         the software portal object
+ * @channelid: the channel index
+ * @ctx:       the context to be set in CDAN
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_CDAN_set_context(struct qbman_swp *s, u16 channelid,
+					     u64 ctx)
+{
+	return qbman_swp_CDAN_set(s, channelid,
+				  CODE_CDAN_WE_CTX,
+				  0, ctx);
+}
+
+/**
+ * qbman_swp_CDAN_enable() - Enable CDAN for the channel
+ * @s:         the software portal object
+ * @channelid: the index of the channel to generate CDAN
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_CDAN_enable(struct qbman_swp *s, u16 channelid)
+{
+	return qbman_swp_CDAN_set(s, channelid,
+				  CODE_CDAN_WE_EN,
+				  1, 0);
+}
+
+/**
+ * qbman_swp_CDAN_disable() - disable CDAN for the channel
+ * @s:         the software portal object
+ * @channelid: the index of the channel to generate CDAN
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_CDAN_disable(struct qbman_swp *s, u16 channelid)
+{
+	return qbman_swp_CDAN_set(s, channelid,
+				  CODE_CDAN_WE_EN,
+				  0, 0);
+}
+
+/**
+ * qbman_swp_CDAN_set_context_enable() - Set CDAN contest and enable CDAN
+ * @s:         the software portal object
+ * @channelid: the index of the channel to generate CDAN
+ * @ctx:i      the context set in CDAN
+ *
+ * Return 0 for success, or negative error code for failure.
+ */
+static inline int qbman_swp_CDAN_set_context_enable(struct qbman_swp *s,
+						    u16 channelid,
+						    u64 ctx)
+{
+	return qbman_swp_CDAN_set(s, channelid,
+				  CODE_CDAN_WE_EN | CODE_CDAN_WE_CTX,
+				  1, ctx);
+}
+
+/* Wraps up submit + poll-for-result */
+static inline void *qbman_swp_mc_complete(struct qbman_swp *swp, void *cmd,
+					  u8 cmd_verb)
+{
+	int loopvar = 1000;
+
+	qbman_swp_mc_submit(swp, cmd, cmd_verb);
+
+	do {
+		cmd = qbman_swp_mc_result(swp);
+	} while (!cmd && loopvar--);
+
+	WARN_ON(!loopvar);
+
+	return cmd;
+}
+
+#endif /* __FSL_QBMAN_PORTAL_H */
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index e577410..c421733 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -36,8 +36,8 @@
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
 
-#include "../../fsl-mc/include/dpaa2-io.h"
-#include "../../fsl-mc/include/dpaa2-fd.h"
+#include <soc/fsl/dpaa2-io.h>
+#include <soc/fsl/dpaa2-fd.h>
 #include "../../fsl-mc/include/dpbp.h"
 #include "../../fsl-mc/include/dpcon.h"
 #include "dpni.h"
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
index b67889e..4a3cb8b 100644
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ b/drivers/staging/fsl-mc/bus/Makefile
@@ -7,5 +7,3 @@
 obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
 			    dpcon.o
 
-# MC DPIO driver
-obj-$(CONFIG_FSL_MC_DPIO) += dpio/
diff --git a/drivers/staging/fsl-mc/bus/dpio/Makefile b/drivers/staging/fsl-mc/bus/dpio/Makefile
deleted file mode 100644
index b9ff24c..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# QorIQ DPAA2 DPIO driver
-#
-
-obj-$(CONFIG_FSL_MC_DPIO) += fsl-mc-dpio.o
-
-fsl-mc-dpio-objs := dpio.o qbman-portal.o dpio-service.o dpio-driver.o
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h b/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
deleted file mode 100644
index ab8f82e..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-cmd.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016 NXP
- *
- */
-#ifndef _FSL_DPIO_CMD_H
-#define _FSL_DPIO_CMD_H
-
-/* DPIO Version */
-#define DPIO_VER_MAJOR			4
-#define DPIO_VER_MINOR			2
-
-/* Command Versioning */
-
-#define DPIO_CMD_ID_OFFSET		4
-#define DPIO_CMD_BASE_VERSION		1
-
-#define DPIO_CMD(id)	(((id) << DPIO_CMD_ID_OFFSET) | DPIO_CMD_BASE_VERSION)
-
-/* Command IDs */
-#define DPIO_CMDID_CLOSE				DPIO_CMD(0x800)
-#define DPIO_CMDID_OPEN					DPIO_CMD(0x803)
-#define DPIO_CMDID_GET_API_VERSION			DPIO_CMD(0xa03)
-#define DPIO_CMDID_ENABLE				DPIO_CMD(0x002)
-#define DPIO_CMDID_DISABLE				DPIO_CMD(0x003)
-#define DPIO_CMDID_GET_ATTR				DPIO_CMD(0x004)
-
-struct dpio_cmd_open {
-	__le32 dpio_id;
-};
-
-#define DPIO_CHANNEL_MODE_MASK		0x3
-
-struct dpio_rsp_get_attr {
-	/* cmd word 0 */
-	__le32 id;
-	__le16 qbman_portal_id;
-	u8 num_priorities;
-	u8 channel_mode;
-	/* cmd word 1 */
-	__le64 qbman_portal_ce_addr;
-	/* cmd word 2 */
-	__le64 qbman_portal_ci_addr;
-	/* cmd word 3 */
-	__le32 qbman_version;
-};
-
-#endif /* _FSL_DPIO_CMD_H */
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
deleted file mode 100644
index 182b384..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.c
+++ /dev/null
@@ -1,271 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright NXP 2016
- *
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/msi.h>
-#include <linux/dma-mapping.h>
-#include <linux/delay.h>
-
-#include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
-
-#include "qbman-portal.h"
-#include "dpio.h"
-#include "dpio-cmd.h"
-
-MODULE_LICENSE("Dual BSD/GPL");
-MODULE_AUTHOR("Freescale Semiconductor, Inc");
-MODULE_DESCRIPTION("DPIO Driver");
-
-struct dpio_priv {
-	struct dpaa2_io *io;
-};
-
-static irqreturn_t dpio_irq_handler(int irq_num, void *arg)
-{
-	struct device *dev = (struct device *)arg;
-	struct dpio_priv *priv = dev_get_drvdata(dev);
-
-	return dpaa2_io_irq(priv->io);
-}
-
-static void unregister_dpio_irq_handlers(struct fsl_mc_device *dpio_dev)
-{
-	struct fsl_mc_device_irq *irq;
-
-	irq = dpio_dev->irqs[0];
-
-	/* clear the affinity hint */
-	irq_set_affinity_hint(irq->msi_desc->irq, NULL);
-}
-
-static int register_dpio_irq_handlers(struct fsl_mc_device *dpio_dev, int cpu)
-{
-	struct dpio_priv *priv;
-	int error;
-	struct fsl_mc_device_irq *irq;
-	cpumask_t mask;
-
-	priv = dev_get_drvdata(&dpio_dev->dev);
-
-	irq = dpio_dev->irqs[0];
-	error = devm_request_irq(&dpio_dev->dev,
-				 irq->msi_desc->irq,
-				 dpio_irq_handler,
-				 0,
-				 dev_name(&dpio_dev->dev),
-				 &dpio_dev->dev);
-	if (error < 0) {
-		dev_err(&dpio_dev->dev,
-			"devm_request_irq() failed: %d\n",
-			error);
-		return error;
-	}
-
-	/* set the affinity hint */
-	cpumask_clear(&mask);
-	cpumask_set_cpu(cpu, &mask);
-	if (irq_set_affinity_hint(irq->msi_desc->irq, &mask))
-		dev_err(&dpio_dev->dev,
-			"irq_set_affinity failed irq %d cpu %d\n",
-			irq->msi_desc->irq, cpu);
-
-	return 0;
-}
-
-static int dpaa2_dpio_probe(struct fsl_mc_device *dpio_dev)
-{
-	struct dpio_attr dpio_attrs;
-	struct dpaa2_io_desc desc;
-	struct dpio_priv *priv;
-	int err = -ENOMEM;
-	struct device *dev = &dpio_dev->dev;
-	static int next_cpu = -1;
-
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		goto err_priv_alloc;
-
-	dev_set_drvdata(dev, priv);
-
-	err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
-	if (err) {
-		dev_dbg(dev, "MC portal allocation failed\n");
-		err = -EPROBE_DEFER;
-		goto err_mcportal;
-	}
-
-	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-			&dpio_dev->mc_handle);
-	if (err) {
-		dev_err(dev, "dpio_open() failed\n");
-		goto err_open;
-	}
-
-	err = dpio_get_attributes(dpio_dev->mc_io, 0, dpio_dev->mc_handle,
-				  &dpio_attrs);
-	if (err) {
-		dev_err(dev, "dpio_get_attributes() failed %d\n", err);
-		goto err_get_attr;
-	}
-	desc.qman_version = dpio_attrs.qbman_version;
-
-	err = dpio_enable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-	if (err) {
-		dev_err(dev, "dpio_enable() failed %d\n", err);
-		goto err_get_attr;
-	}
-
-	/* initialize DPIO descriptor */
-	desc.receives_notifications = dpio_attrs.num_priorities ? 1 : 0;
-	desc.has_8prio = dpio_attrs.num_priorities == 8 ? 1 : 0;
-	desc.dpio_id = dpio_dev->obj_desc.id;
-
-	/* get the cpu to use for the affinity hint */
-	if (next_cpu == -1)
-		next_cpu = cpumask_first(cpu_online_mask);
-	else
-		next_cpu = cpumask_next(next_cpu, cpu_online_mask);
-
-	if (!cpu_possible(next_cpu)) {
-		dev_err(dev, "probe failed. Number of DPIOs exceeds NR_CPUS.\n");
-		err = -ERANGE;
-		goto err_allocate_irqs;
-	}
-	desc.cpu = next_cpu;
-
-	/*
-	 * Set the CENA regs to be the cache inhibited area of the portal to
-	 * avoid coherency issues if a user migrates to another core.
-	 */
-	desc.regs_cena = ioremap_wc(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
-	desc.regs_cinh = ioremap(dpio_dev->regions[1].start,
-		resource_size(&dpio_dev->regions[1]));
-
-	err = fsl_mc_allocate_irqs(dpio_dev);
-	if (err) {
-		dev_err(dev, "fsl_mc_allocate_irqs failed. err=%d\n", err);
-		goto err_allocate_irqs;
-	}
-
-	err = register_dpio_irq_handlers(dpio_dev, desc.cpu);
-	if (err)
-		goto err_register_dpio_irq;
-
-	priv->io = dpaa2_io_create(&desc);
-	if (!priv->io) {
-		dev_err(dev, "dpaa2_io_create failed\n");
-		goto err_dpaa2_io_create;
-	}
-
-	dev_info(dev, "probed\n");
-	dev_dbg(dev, "   receives_notifications = %d\n",
-		desc.receives_notifications);
-	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-	fsl_mc_portal_free(dpio_dev->mc_io);
-
-	return 0;
-
-err_dpaa2_io_create:
-	unregister_dpio_irq_handlers(dpio_dev);
-err_register_dpio_irq:
-	fsl_mc_free_irqs(dpio_dev);
-err_allocate_irqs:
-	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-err_get_attr:
-	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-err_open:
-	fsl_mc_portal_free(dpio_dev->mc_io);
-err_mcportal:
-	dev_set_drvdata(dev, NULL);
-err_priv_alloc:
-	return err;
-}
-
-/* Tear down interrupts for a given DPIO object */
-static void dpio_teardown_irqs(struct fsl_mc_device *dpio_dev)
-{
-	unregister_dpio_irq_handlers(dpio_dev);
-	fsl_mc_free_irqs(dpio_dev);
-}
-
-static int dpaa2_dpio_remove(struct fsl_mc_device *dpio_dev)
-{
-	struct device *dev;
-	struct dpio_priv *priv;
-	int err;
-
-	dev = &dpio_dev->dev;
-	priv = dev_get_drvdata(dev);
-
-	dpaa2_io_down(priv->io);
-
-	dpio_teardown_irqs(dpio_dev);
-
-	err = fsl_mc_portal_allocate(dpio_dev, 0, &dpio_dev->mc_io);
-	if (err) {
-		dev_err(dev, "MC portal allocation failed\n");
-		goto err_mcportal;
-	}
-
-	err = dpio_open(dpio_dev->mc_io, 0, dpio_dev->obj_desc.id,
-			&dpio_dev->mc_handle);
-	if (err) {
-		dev_err(dev, "dpio_open() failed\n");
-		goto err_open;
-	}
-
-	dpio_disable(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-
-	dpio_close(dpio_dev->mc_io, 0, dpio_dev->mc_handle);
-
-	fsl_mc_portal_free(dpio_dev->mc_io);
-
-	dev_set_drvdata(dev, NULL);
-
-	return 0;
-
-err_open:
-	fsl_mc_portal_free(dpio_dev->mc_io);
-err_mcportal:
-	return err;
-}
-
-static const struct fsl_mc_device_id dpaa2_dpio_match_id_table[] = {
-	{
-		.vendor = FSL_MC_VENDOR_FREESCALE,
-		.obj_type = "dpio",
-	},
-	{ .vendor = 0x0 }
-};
-
-static struct fsl_mc_driver dpaa2_dpio_driver = {
-	.driver = {
-		.name		= KBUILD_MODNAME,
-		.owner		= THIS_MODULE,
-	},
-	.probe		= dpaa2_dpio_probe,
-	.remove		= dpaa2_dpio_remove,
-	.match_id_table = dpaa2_dpio_match_id_table
-};
-
-static int dpio_driver_init(void)
-{
-	return fsl_mc_driver_register(&dpaa2_dpio_driver);
-}
-
-static void dpio_driver_exit(void)
-{
-	fsl_mc_driver_unregister(&dpaa2_dpio_driver);
-}
-module_init(dpio_driver_init);
-module_exit(dpio_driver_exit);
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt b/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
deleted file mode 100644
index 0ba6771..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-driver.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-Copyright 2016 NXP
-
-Introduction
-------------
-
-A DPAA2 DPIO (Data Path I/O) is a hardware object that provides
-interfaces to enqueue and dequeue frames to/from network interfaces
-and other accelerators.  A DPIO also provides hardware buffer
-pool management for network interfaces.
-
-This document provides an overview the Linux DPIO driver, its
-subcomponents, and its APIs.
-
-See Documentation/dpaa2/overview.txt for a general overview of DPAA2
-and the general DPAA2 driver architecture in Linux.
-
-Driver Overview
----------------
-
-The DPIO driver is bound to DPIO objects discovered on the fsl-mc bus and
-provides services that:
-  A) allow other drivers, such as the Ethernet driver, to enqueue and dequeue
-     frames for their respective objects
-  B) allow drivers to register callbacks for data availability notifications
-     when data becomes available on a queue or channel
-  C) allow drivers to manage hardware buffer pools
-
-The Linux DPIO driver consists of 3 primary components--
-   DPIO object driver-- fsl-mc driver that manages the DPIO object
-   DPIO service-- provides APIs to other Linux drivers for services
-   QBman portal interface-- sends portal commands, gets responses
-
-          fsl-mc          other
-           bus           drivers
-            |               |
-        +---+----+   +------+-----+
-        |DPIO obj|   |DPIO service|
-        | driver |---|  (DPIO)    |
-        +--------+   +------+-----+
-                            |
-                     +------+-----+
-                     |    QBman   |
-                     | portal i/f |
-                     +------------+
-                            |
-                         hardware
-
-The diagram below shows how the DPIO driver components fit with the other
-DPAA2 Linux driver components:
-                                                   +------------+
-                                                   | OS Network |
-                                                   |   Stack    |
-                 +------------+                    +------------+
-                 | Allocator  |. . . . . . .       |  Ethernet  |
-                 |(DPMCP,DPBP)|                    |   (DPNI)   |
-                 +-.----------+                    +---+---+----+
-                  .          .                         ^   |
-                 .            .           <data avail, |   |<enqueue,
-                .              .           tx confirm> |   | dequeue>
-    +-------------+             .                      |   |
-    | DPRC driver |              .    +--------+ +------------+
-    |   (DPRC)    |               . . |DPIO obj| |DPIO service|
-    +----------+--+                   | driver |-|  (DPIO)    |
-               |                      +--------+ +------+-----+
-               |<dev add/remove>                 +------|-----+
-               |                                 |   QBman    |
-          +----+--------------+                  | portal i/f |
-          |   MC-bus driver   |                  +------------+
-          |                   |                     |
-          | /soc/fsl-mc       |                     |
-          +-------------------+                     |
-                                                    |
- =========================================|=========|========================
-                                        +-+--DPIO---|-----------+
-                                        |           |           |
-                                        |        QBman Portal   |
-                                        +-----------------------+
-
- ============================================================================
-
-
-DPIO Object Driver (dpio-driver.c)
-----------------------------------
-
-   The dpio-driver component registers with the fsl-mc bus to handle objects of
-   type "dpio".  The implementation of probe() handles basic initialization
-   of the DPIO including mapping of the DPIO regions (the QBman SW portal)
-   and initializing interrupts and registering irq handlers.  The dpio-driver
-   registers the probed DPIO with dpio-service.
-
-DPIO service  (dpio-service.c, dpaa2-io.h)
-------------------------------------------
-
-   The dpio service component provides queuing, notification, and buffers
-   management services to DPAA2 drivers, such as the Ethernet driver.  A system
-   will typically allocate 1 DPIO object per CPU to allow queuing operations
-   to happen simultaneously across all CPUs.
-
-   Notification handling
-      dpaa2_io_service_register()
-      dpaa2_io_service_deregister()
-      dpaa2_io_service_rearm()
-
-   Queuing
-      dpaa2_io_service_pull_fq()
-      dpaa2_io_service_pull_channel()
-      dpaa2_io_service_enqueue_fq()
-      dpaa2_io_service_enqueue_qd()
-      dpaa2_io_store_create()
-      dpaa2_io_store_destroy()
-      dpaa2_io_store_next()
-
-   Buffer pool management
-      dpaa2_io_service_release()
-      dpaa2_io_service_acquire()
-
-QBman portal interface (qbman-portal.c)
----------------------------------------
-
-   The qbman-portal component provides APIs to do the low level hardware
-   bit twiddling for operations such as:
-      -initializing Qman software portals
-      -building and sending portal commands
-      -portal interrupt configuration and processing
-
-   The qbman-portal APIs are not public to other drivers, and are
-   only used by dpio-service.
-
-Other (dpaa2-fd.h, dpaa2-global.h)
-----------------------------------
-
-   Frame descriptor and scatter-gather definitions and the APIs used to
-   manipulate them are defined in dpaa2-fd.h.
-
-   Dequeue result struct and parsing APIs are defined in dpaa2-global.h.
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c b/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
deleted file mode 100644
index 14ed2be..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/dpio-service.c
+++ /dev/null
@@ -1,545 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016 NXP
- *
- */
-#include <linux/types.h>
-#include <linux/fsl/mc.h>
-#include "../../include/dpaa2-io.h"
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/slab.h>
-
-#include "dpio.h"
-#include "qbman-portal.h"
-
-struct dpaa2_io {
-	struct dpaa2_io_desc dpio_desc;
-	struct qbman_swp_desc swp_desc;
-	struct qbman_swp *swp;
-	struct list_head node;
-	/* protect against multiple management commands */
-	spinlock_t lock_mgmt_cmd;
-	/* protect notifications list */
-	spinlock_t lock_notifications;
-	struct list_head notifications;
-};
-
-struct dpaa2_io_store {
-	unsigned int max;
-	dma_addr_t paddr;
-	struct dpaa2_dq *vaddr;
-	void *alloced_addr;    /* unaligned value from kmalloc() */
-	unsigned int idx;      /* position of the next-to-be-returned entry */
-	struct qbman_swp *swp; /* portal used to issue VDQCR */
-	struct device *dev;    /* device used for DMA mapping */
-};
-
-/* keep a per cpu array of DPIOs for fast access */
-static struct dpaa2_io *dpio_by_cpu[NR_CPUS];
-static struct list_head dpio_list = LIST_HEAD_INIT(dpio_list);
-static DEFINE_SPINLOCK(dpio_list_lock);
-
-static inline struct dpaa2_io *service_select_by_cpu(struct dpaa2_io *d,
-						     int cpu)
-{
-	if (d)
-		return d;
-
-	if (cpu != DPAA2_IO_ANY_CPU && cpu >= num_possible_cpus())
-		return NULL;
-
-	/*
-	 * If cpu == -1, choose the current cpu, with no guarantees about
-	 * potentially being migrated away.
-	 */
-	if (unlikely(cpu < 0))
-		cpu = smp_processor_id();
-
-	/* If a specific cpu was requested, pick it up immediately */
-	return dpio_by_cpu[cpu];
-}
-
-static inline struct dpaa2_io *service_select(struct dpaa2_io *d)
-{
-	if (d)
-		return d;
-
-	spin_lock(&dpio_list_lock);
-	d = list_entry(dpio_list.next, struct dpaa2_io, node);
-	list_del(&d->node);
-	list_add_tail(&d->node, &dpio_list);
-	spin_unlock(&dpio_list_lock);
-
-	return d;
-}
-
-/**
- * dpaa2_io_service_select() - return a dpaa2_io service affined to this cpu
- * @cpu: the cpu id
- *
- * Return the affine dpaa2_io service, or NULL if there is no service affined
- * to the specified cpu. If DPAA2_IO_ANY_CPU is used, return the next available
- * service.
- */
-struct dpaa2_io *dpaa2_io_service_select(int cpu)
-{
-	if (cpu == DPAA2_IO_ANY_CPU)
-		return service_select(NULL);
-
-	return service_select_by_cpu(NULL, cpu);
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_select);
-
-/**
- * dpaa2_io_create() - create a dpaa2_io object.
- * @desc: the dpaa2_io descriptor
- *
- * Activates a "struct dpaa2_io" corresponding to the given config of an actual
- * DPIO object.
- *
- * Return a valid dpaa2_io object for success, or NULL for failure.
- */
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc)
-{
-	struct dpaa2_io *obj = kmalloc(sizeof(*obj), GFP_KERNEL);
-
-	if (!obj)
-		return NULL;
-
-	/* check if CPU is out of range (-1 means any cpu) */
-	if (desc->cpu != DPAA2_IO_ANY_CPU && desc->cpu >= num_possible_cpus()) {
-		kfree(obj);
-		return NULL;
-	}
-
-	obj->dpio_desc = *desc;
-	obj->swp_desc.cena_bar = obj->dpio_desc.regs_cena;
-	obj->swp_desc.cinh_bar = obj->dpio_desc.regs_cinh;
-	obj->swp_desc.qman_version = obj->dpio_desc.qman_version;
-	obj->swp = qbman_swp_init(&obj->swp_desc);
-
-	if (!obj->swp) {
-		kfree(obj);
-		return NULL;
-	}
-
-	INIT_LIST_HEAD(&obj->node);
-	spin_lock_init(&obj->lock_mgmt_cmd);
-	spin_lock_init(&obj->lock_notifications);
-	INIT_LIST_HEAD(&obj->notifications);
-
-	/* For now only enable DQRR interrupts */
-	qbman_swp_interrupt_set_trigger(obj->swp,
-					QBMAN_SWP_INTERRUPT_DQRI);
-	qbman_swp_interrupt_clear_status(obj->swp, 0xffffffff);
-	if (obj->dpio_desc.receives_notifications)
-		qbman_swp_push_set(obj->swp, 0, 1);
-
-	spin_lock(&dpio_list_lock);
-	list_add_tail(&obj->node, &dpio_list);
-	if (desc->cpu >= 0 && !dpio_by_cpu[desc->cpu])
-		dpio_by_cpu[desc->cpu] = obj;
-	spin_unlock(&dpio_list_lock);
-
-	return obj;
-}
-
-/**
- * dpaa2_io_down() - release the dpaa2_io object.
- * @d: the dpaa2_io object to be released.
- *
- * The "struct dpaa2_io" type can represent an individual DPIO object (as
- * described by "struct dpaa2_io_desc") or an instance of a "DPIO service",
- * which can be used to group/encapsulate multiple DPIO objects. In all cases,
- * each handle obtained should be released using this function.
- */
-void dpaa2_io_down(struct dpaa2_io *d)
-{
-	kfree(d);
-}
-
-#define DPAA_POLL_MAX 32
-
-/**
- * dpaa2_io_irq() - ISR for DPIO interrupts
- *
- * @obj: the given DPIO object.
- *
- * Return IRQ_HANDLED for success or IRQ_NONE if there
- * were no pending interrupts.
- */
-irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj)
-{
-	const struct dpaa2_dq *dq;
-	int max = 0;
-	struct qbman_swp *swp;
-	u32 status;
-
-	swp = obj->swp;
-	status = qbman_swp_interrupt_read_status(swp);
-	if (!status)
-		return IRQ_NONE;
-
-	dq = qbman_swp_dqrr_next(swp);
-	while (dq) {
-		if (qbman_result_is_SCN(dq)) {
-			struct dpaa2_io_notification_ctx *ctx;
-			u64 q64;
-
-			q64 = qbman_result_SCN_ctx(dq);
-			ctx = (void *)(uintptr_t)q64;
-			ctx->cb(ctx);
-		} else {
-			pr_crit("fsl-mc-dpio: Unrecognised/ignored DQRR entry\n");
-		}
-		qbman_swp_dqrr_consume(swp, dq);
-		++max;
-		if (max > DPAA_POLL_MAX)
-			goto done;
-		dq = qbman_swp_dqrr_next(swp);
-	}
-done:
-	qbman_swp_interrupt_clear_status(swp, status);
-	qbman_swp_interrupt_set_inhibit(swp, 0);
-	return IRQ_HANDLED;
-}
-
-/**
- * dpaa2_io_service_register() - Prepare for servicing of FQDAN or CDAN
- *                               notifications on the given DPIO service.
- * @d:   the given DPIO service.
- * @ctx: the notification context.
- *
- * The caller should make the MC command to attach a DPAA2 object to
- * a DPIO after this function completes successfully.  In that way:
- *    (a) The DPIO service is "ready" to handle a notification arrival
- *        (which might happen before the "attach" command to MC has
- *        returned control of execution back to the caller)
- *    (b) The DPIO service can provide back to the caller the 'dpio_id' and
- *        'qman64' parameters that it should pass along in the MC command
- *        in order for the object to be configured to produce the right
- *        notification fields to the DPIO service.
- *
- * Return 0 for success, or -ENODEV for failure.
- */
-int dpaa2_io_service_register(struct dpaa2_io *d,
-			      struct dpaa2_io_notification_ctx *ctx)
-{
-	unsigned long irqflags;
-
-	d = service_select_by_cpu(d, ctx->desired_cpu);
-	if (!d)
-		return -ENODEV;
-
-	ctx->dpio_id = d->dpio_desc.dpio_id;
-	ctx->qman64 = (u64)(uintptr_t)ctx;
-	ctx->dpio_private = d;
-	spin_lock_irqsave(&d->lock_notifications, irqflags);
-	list_add(&ctx->node, &d->notifications);
-	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
-
-	/* Enable the generation of CDAN notifications */
-	if (ctx->is_cdan)
-		return qbman_swp_CDAN_set_context_enable(d->swp,
-							 (u16)ctx->id,
-							 ctx->qman64);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_register);
-
-/**
- * dpaa2_io_service_deregister - The opposite of 'register'.
- * @service: the given DPIO service.
- * @ctx: the notification context.
- *
- * This function should be called only after sending the MC command to
- * to detach the notification-producing device from the DPIO.
- */
-void dpaa2_io_service_deregister(struct dpaa2_io *service,
-				 struct dpaa2_io_notification_ctx *ctx)
-{
-	struct dpaa2_io *d = ctx->dpio_private;
-	unsigned long irqflags;
-
-	if (ctx->is_cdan)
-		qbman_swp_CDAN_disable(d->swp, (u16)ctx->id);
-
-	spin_lock_irqsave(&d->lock_notifications, irqflags);
-	list_del(&ctx->node);
-	spin_unlock_irqrestore(&d->lock_notifications, irqflags);
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_deregister);
-
-/**
- * dpaa2_io_service_rearm() - Rearm the notification for the given DPIO service.
- * @d: the given DPIO service.
- * @ctx: the notification context.
- *
- * Once a FQDAN/CDAN has been produced, the corresponding FQ/channel is
- * considered "disarmed". Ie. the user can issue pull dequeue operations on that
- * traffic source for as long as it likes. Eventually it may wish to "rearm"
- * that source to allow it to produce another FQDAN/CDAN, that's what this
- * function achieves.
- *
- * Return 0 for success.
- */
-int dpaa2_io_service_rearm(struct dpaa2_io *d,
-			   struct dpaa2_io_notification_ctx *ctx)
-{
-	unsigned long irqflags;
-	int err;
-
-	d = service_select_by_cpu(d, ctx->desired_cpu);
-	if (!unlikely(d))
-		return -ENODEV;
-
-	spin_lock_irqsave(&d->lock_mgmt_cmd, irqflags);
-	if (ctx->is_cdan)
-		err = qbman_swp_CDAN_enable(d->swp, (u16)ctx->id);
-	else
-		err = qbman_swp_fq_schedule(d->swp, ctx->id);
-	spin_unlock_irqrestore(&d->lock_mgmt_cmd, irqflags);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_rearm);
-
-/**
- * dpaa2_io_service_pull_channel() - pull dequeue functions from a channel.
- * @d: the given DPIO service.
- * @channelid: the given channel id.
- * @s: the dpaa2_io_store object for the result.
- *
- * Return 0 for success, or error code for failure.
- */
-int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
-				  struct dpaa2_io_store *s)
-{
-	struct qbman_pull_desc pd;
-	int err;
-
-	qbman_pull_desc_clear(&pd);
-	qbman_pull_desc_set_storage(&pd, s->vaddr, s->paddr, 1);
-	qbman_pull_desc_set_numframes(&pd, (u8)s->max);
-	qbman_pull_desc_set_channel(&pd, channelid, qbman_pull_type_prio);
-
-	d = service_select(d);
-	if (!d)
-		return -ENODEV;
-
-	s->swp = d->swp;
-	err = qbman_swp_pull(d->swp, &pd);
-	if (err)
-		s->swp = NULL;
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_pull_channel);
-
-/**
- * dpaa2_io_service_enqueue_qd() - Enqueue a frame to a QD.
- * @d: the given DPIO service.
- * @qdid: the given queuing destination id.
- * @prio: the given queuing priority.
- * @qdbin: the given queuing destination bin.
- * @fd: the frame descriptor which is enqueued.
- *
- * Return 0 for successful enqueue, or -EBUSY if the enqueue ring is not ready,
- * or -ENODEV if there is no dpio service.
- */
-int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d,
-				u32 qdid, u8 prio, u16 qdbin,
-				const struct dpaa2_fd *fd)
-{
-	struct qbman_eq_desc ed;
-
-	d = service_select(d);
-	if (!d)
-		return -ENODEV;
-
-	qbman_eq_desc_clear(&ed);
-	qbman_eq_desc_set_no_orp(&ed, 0);
-	qbman_eq_desc_set_qd(&ed, qdid, qdbin, prio);
-
-	return qbman_swp_enqueue(d->swp, &ed, fd);
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_enqueue_qd);
-
-/**
- * dpaa2_io_service_release() - Release buffers to a buffer pool.
- * @d: the given DPIO object.
- * @bpid: the buffer pool id.
- * @buffers: the buffers to be released.
- * @num_buffers: the number of the buffers to be released.
- *
- * Return 0 for success, and negative error code for failure.
- */
-int dpaa2_io_service_release(struct dpaa2_io *d,
-			     u32 bpid,
-			     const u64 *buffers,
-			     unsigned int num_buffers)
-{
-	struct qbman_release_desc rd;
-
-	d = service_select(d);
-	if (!d)
-		return -ENODEV;
-
-	qbman_release_desc_clear(&rd);
-	qbman_release_desc_set_bpid(&rd, bpid);
-
-	return qbman_swp_release(d->swp, &rd, buffers, num_buffers);
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_release);
-
-/**
- * dpaa2_io_service_acquire() - Acquire buffers from a buffer pool.
- * @d: the given DPIO object.
- * @bpid: the buffer pool id.
- * @buffers: the buffer addresses for acquired buffers.
- * @num_buffers: the expected number of the buffers to acquire.
- *
- * Return a negative error code if the command failed, otherwise it returns
- * the number of buffers acquired, which may be less than the number requested.
- * Eg. if the buffer pool is empty, this will return zero.
- */
-int dpaa2_io_service_acquire(struct dpaa2_io *d,
-			     u32 bpid,
-			     u64 *buffers,
-			     unsigned int num_buffers)
-{
-	unsigned long irqflags;
-	int err;
-
-	d = service_select(d);
-	if (!d)
-		return -ENODEV;
-
-	spin_lock_irqsave(&d->lock_mgmt_cmd, irqflags);
-	err = qbman_swp_acquire(d->swp, bpid, buffers, num_buffers);
-	spin_unlock_irqrestore(&d->lock_mgmt_cmd, irqflags);
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_service_acquire);
-
-/*
- * 'Stores' are reusable memory blocks for holding dequeue results, and to
- * assist with parsing those results.
- */
-
-/**
- * dpaa2_io_store_create() - Create the dma memory storage for dequeue result.
- * @max_frames: the maximum number of dequeued result for frames, must be <= 16.
- * @dev:        the device to allow mapping/unmapping the DMAable region.
- *
- * The size of the storage is "max_frames*sizeof(struct dpaa2_dq)".
- * The 'dpaa2_io_store' returned is a DPIO service managed object.
- *
- * Return pointer to dpaa2_io_store struct for successfully created storage
- * memory, or NULL on error.
- */
-struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
-					     struct device *dev)
-{
-	struct dpaa2_io_store *ret;
-	size_t size;
-
-	if (!max_frames || (max_frames > 16))
-		return NULL;
-
-	ret = kmalloc(sizeof(*ret), GFP_KERNEL);
-	if (!ret)
-		return NULL;
-
-	ret->max = max_frames;
-	size = max_frames * sizeof(struct dpaa2_dq) + 64;
-	ret->alloced_addr = kzalloc(size, GFP_KERNEL);
-	if (!ret->alloced_addr) {
-		kfree(ret);
-		return NULL;
-	}
-
-	ret->vaddr = PTR_ALIGN(ret->alloced_addr, 64);
-	ret->paddr = dma_map_single(dev, ret->vaddr,
-				    sizeof(struct dpaa2_dq) * max_frames,
-				    DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, ret->paddr)) {
-		kfree(ret->alloced_addr);
-		kfree(ret);
-		return NULL;
-	}
-
-	ret->idx = 0;
-	ret->dev = dev;
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_store_create);
-
-/**
- * dpaa2_io_store_destroy() - Frees the dma memory storage for dequeue
- *                            result.
- * @s: the storage memory to be destroyed.
- */
-void dpaa2_io_store_destroy(struct dpaa2_io_store *s)
-{
-	dma_unmap_single(s->dev, s->paddr, sizeof(struct dpaa2_dq) * s->max,
-			 DMA_FROM_DEVICE);
-	kfree(s->alloced_addr);
-	kfree(s);
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_store_destroy);
-
-/**
- * dpaa2_io_store_next() - Determine when the next dequeue result is available.
- * @s: the dpaa2_io_store object.
- * @is_last: indicate whether this is the last frame in the pull command.
- *
- * When an object driver performs dequeues to a dpaa2_io_store, this function
- * can be used to determine when the next frame result is available. Once
- * this function returns non-NULL, a subsequent call to it will try to find
- * the next dequeue result.
- *
- * Note that if a pull-dequeue has a NULL result because the target FQ/channel
- * was empty, then this function will also return NULL (rather than expecting
- * the caller to always check for this. As such, "is_last" can be used to
- * differentiate between "end-of-empty-dequeue" and "still-waiting".
- *
- * Return dequeue result for a valid dequeue result, or NULL for empty dequeue.
- */
-struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_store *s, int *is_last)
-{
-	int match;
-	struct dpaa2_dq *ret = &s->vaddr[s->idx];
-
-	match = qbman_result_has_new_result(s->swp, ret);
-	if (!match) {
-		*is_last = 0;
-		return NULL;
-	}
-
-	s->idx++;
-
-	if (dpaa2_dq_is_pull_complete(ret)) {
-		*is_last = 1;
-		s->idx = 0;
-		/*
-		 * If we get an empty dequeue result to terminate a zero-results
-		 * vdqcr, return NULL to the caller rather than expecting him to
-		 * check non-NULL results every time.
-		 */
-		if (!(dpaa2_dq_flags(ret) & DPAA2_DQ_STAT_VALIDFRAME))
-			ret = NULL;
-	} else {
-		*is_last = 0;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(dpaa2_io_store_next);
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.c b/drivers/staging/fsl-mc/bus/dpio/dpio.c
deleted file mode 100644
index 3175057..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.c
+++ /dev/null
@@ -1,198 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016 NXP
- *
- */
-#include <linux/kernel.h>
-#include <linux/fsl/mc.h>
-
-#include "dpio.h"
-#include "dpio-cmd.h"
-
-/*
- * Data Path I/O Portal API
- * Contains initialization APIs and runtime control APIs for DPIO
- */
-
-/**
- * dpio_open() - Open a control session for the specified object
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @dpio_id:	DPIO unique ID
- * @token:	Returned token; use in subsequent API calls
- *
- * This function can be used to open a control session for an
- * already created object; an object may have been declared in
- * the DPL or by calling the dpio_create() function.
- * This function returns a unique authentication token,
- * associated with the specific object ID and the specific MC
- * portal; this token must be used in all subsequent commands for
- * this specific object.
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpio_open(struct fsl_mc_io *mc_io,
-	      u32 cmd_flags,
-	      int dpio_id,
-	      u16 *token)
-{
-	struct mc_command cmd = { 0 };
-	struct dpio_cmd_open *dpio_cmd;
-	int err;
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPIO_CMDID_OPEN,
-					  cmd_flags,
-					  0);
-	dpio_cmd = (struct dpio_cmd_open *)cmd.params;
-	dpio_cmd->dpio_id = cpu_to_le32(dpio_id);
-
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	*token = mc_cmd_hdr_read_token(&cmd);
-
-	return 0;
-}
-
-/**
- * dpio_close() - Close the control session of the object
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPIO object
- *
- * Return:	'0' on Success; Error code otherwise.
- */
-int dpio_close(struct fsl_mc_io *mc_io,
-	       u32 cmd_flags,
-	       u16 token)
-{
-	struct mc_command cmd = { 0 };
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPIO_CMDID_CLOSE,
-					  cmd_flags,
-					  token);
-
-	return mc_send_command(mc_io, &cmd);
-}
-
-/**
- * dpio_enable() - Enable the DPIO, allow I/O portal operations.
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPIO object
- *
- * Return:	'0' on Success; Error code otherwise
- */
-int dpio_enable(struct fsl_mc_io *mc_io,
-		u32 cmd_flags,
-		u16 token)
-{
-	struct mc_command cmd = { 0 };
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPIO_CMDID_ENABLE,
-					  cmd_flags,
-					  token);
-
-	return mc_send_command(mc_io, &cmd);
-}
-
-/**
- * dpio_disable() - Disable the DPIO, stop any I/O portal operation.
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPIO object
- *
- * Return:	'0' on Success; Error code otherwise
- */
-int dpio_disable(struct fsl_mc_io *mc_io,
-		 u32 cmd_flags,
-		 u16 token)
-{
-	struct mc_command cmd = { 0 };
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPIO_CMDID_DISABLE,
-					  cmd_flags,
-					  token);
-
-	return mc_send_command(mc_io, &cmd);
-}
-
-/**
- * dpio_get_attributes() - Retrieve DPIO attributes
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPIO object
- * @attr:	Returned object's attributes
- *
- * Return:	'0' on Success; Error code otherwise
- */
-int dpio_get_attributes(struct fsl_mc_io *mc_io,
-			u32 cmd_flags,
-			u16 token,
-			struct dpio_attr *attr)
-{
-	struct mc_command cmd = { 0 };
-	struct dpio_rsp_get_attr *dpio_rsp;
-	int err;
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPIO_CMDID_GET_ATTR,
-					  cmd_flags,
-					  token);
-
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	dpio_rsp = (struct dpio_rsp_get_attr *)cmd.params;
-	attr->id = le32_to_cpu(dpio_rsp->id);
-	attr->qbman_portal_id = le16_to_cpu(dpio_rsp->qbman_portal_id);
-	attr->num_priorities = dpio_rsp->num_priorities;
-	attr->channel_mode = dpio_rsp->channel_mode & DPIO_CHANNEL_MODE_MASK;
-	attr->qbman_portal_ce_offset =
-		le64_to_cpu(dpio_rsp->qbman_portal_ce_addr);
-	attr->qbman_portal_ci_offset =
-		le64_to_cpu(dpio_rsp->qbman_portal_ci_addr);
-	attr->qbman_version = le32_to_cpu(dpio_rsp->qbman_version);
-
-	return 0;
-}
-
-/**
- * dpio_get_api_version - Get Data Path I/O API version
- * @mc_io:	Pointer to MC portal's DPIO object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @major_ver:	Major version of DPIO API
- * @minor_ver:	Minor version of DPIO API
- *
- * Return:	'0' on Success; Error code otherwise
- */
-int dpio_get_api_version(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 *major_ver,
-			 u16 *minor_ver)
-{
-	struct mc_command cmd = { 0 };
-	int err;
-
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPIO_CMDID_GET_API_VERSION,
-					  cmd_flags, 0);
-
-	err = mc_send_command(mc_io, &cmd);
-	if (err)
-		return err;
-
-	/* retrieve response parameters */
-	mc_cmd_read_api_version(&cmd, major_ver, minor_ver);
-
-	return 0;
-}
diff --git a/drivers/staging/fsl-mc/bus/dpio/dpio.h b/drivers/staging/fsl-mc/bus/dpio/dpio.h
deleted file mode 100644
index 49194c8..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/dpio.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016 NXP
- *
- */
-#ifndef __FSL_DPIO_H
-#define __FSL_DPIO_H
-
-struct fsl_mc_io;
-
-int dpio_open(struct fsl_mc_io	*mc_io,
-	      u32		cmd_flags,
-	      int		dpio_id,
-	      u16		*token);
-
-int dpio_close(struct fsl_mc_io	*mc_io,
-	       u32		cmd_flags,
-	       u16		token);
-
-/**
- * enum dpio_channel_mode - DPIO notification channel mode
- * @DPIO_NO_CHANNEL: No support for notification channel
- * @DPIO_LOCAL_CHANNEL: Notifications on data availability can be received by a
- *	dedicated channel in the DPIO; user should point the queue's
- *	destination in the relevant interface to this DPIO
- */
-enum dpio_channel_mode {
-	DPIO_NO_CHANNEL = 0,
-	DPIO_LOCAL_CHANNEL = 1,
-};
-
-/**
- * struct dpio_cfg - Structure representing DPIO configuration
- * @channel_mode: Notification channel mode
- * @num_priorities: Number of priorities for the notification channel (1-8);
- *			relevant only if 'channel_mode = DPIO_LOCAL_CHANNEL'
- */
-struct dpio_cfg {
-	enum dpio_channel_mode	channel_mode;
-	u8		num_priorities;
-};
-
-int dpio_enable(struct fsl_mc_io	*mc_io,
-		u32		cmd_flags,
-		u16		token);
-
-int dpio_disable(struct fsl_mc_io	*mc_io,
-		 u32		cmd_flags,
-		 u16		token);
-
-/**
- * struct dpio_attr - Structure representing DPIO attributes
- * @id: DPIO object ID
- * @qbman_portal_ce_offset: offset of the software portal cache-enabled area
- * @qbman_portal_ci_offset: offset of the software portal cache-inhibited area
- * @qbman_portal_id: Software portal ID
- * @channel_mode: Notification channel mode
- * @num_priorities: Number of priorities for the notification channel (1-8);
- *			relevant only if 'channel_mode = DPIO_LOCAL_CHANNEL'
- * @qbman_version: QBMAN version
- */
-struct dpio_attr {
-	int			id;
-	u64		qbman_portal_ce_offset;
-	u64		qbman_portal_ci_offset;
-	u16		qbman_portal_id;
-	enum dpio_channel_mode	channel_mode;
-	u8			num_priorities;
-	u32		qbman_version;
-};
-
-int dpio_get_attributes(struct fsl_mc_io	*mc_io,
-			u32		cmd_flags,
-			u16		token,
-			struct dpio_attr	*attr);
-
-int dpio_get_api_version(struct fsl_mc_io *mc_io,
-			 u32 cmd_flags,
-			 u16 *major_ver,
-			 u16 *minor_ver);
-
-#endif /* __FSL_DPIO_H */
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
deleted file mode 100644
index 116fafb..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.c
+++ /dev/null
@@ -1,1005 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/*
- * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Copyright 2016 NXP
- *
- */
-
-#include <asm/cacheflush.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-#include "../../include/dpaa2-global.h"
-
-#include "qbman-portal.h"
-
-#define QMAN_REV_4000   0x04000000
-#define QMAN_REV_4100   0x04010000
-#define QMAN_REV_4101   0x04010001
-#define QMAN_REV_MASK   0xffff0000
-
-/* All QBMan command and result structures use this "valid bit" encoding */
-#define QB_VALID_BIT ((u32)0x80)
-
-/* QBMan portal management command codes */
-#define QBMAN_MC_ACQUIRE       0x30
-#define QBMAN_WQCHAN_CONFIGURE 0x46
-
-/* CINH register offsets */
-#define QBMAN_CINH_SWP_EQAR    0x8c0
-#define QBMAN_CINH_SWP_DQPI    0xa00
-#define QBMAN_CINH_SWP_DCAP    0xac0
-#define QBMAN_CINH_SWP_SDQCR   0xb00
-#define QBMAN_CINH_SWP_RAR     0xcc0
-#define QBMAN_CINH_SWP_ISR     0xe00
-#define QBMAN_CINH_SWP_IER     0xe40
-#define QBMAN_CINH_SWP_ISDR    0xe80
-#define QBMAN_CINH_SWP_IIR     0xec0
-
-/* CENA register offsets */
-#define QBMAN_CENA_SWP_EQCR(n) (0x000 + ((u32)(n) << 6))
-#define QBMAN_CENA_SWP_DQRR(n) (0x200 + ((u32)(n) << 6))
-#define QBMAN_CENA_SWP_RCR(n)  (0x400 + ((u32)(n) << 6))
-#define QBMAN_CENA_SWP_CR      0x600
-#define QBMAN_CENA_SWP_RR(vb)  (0x700 + ((u32)(vb) >> 1))
-#define QBMAN_CENA_SWP_VDQCR   0x780
-
-/* Reverse mapping of QBMAN_CENA_SWP_DQRR() */
-#define QBMAN_IDX_FROM_DQRR(p) (((unsigned long)(p) & 0x1ff) >> 6)
-
-/* Define token used to determine if response written to memory is valid */
-#define QMAN_DQ_TOKEN_VALID 1
-
-/* SDQCR attribute codes */
-#define QB_SDQCR_FC_SHIFT   29
-#define QB_SDQCR_FC_MASK    0x1
-#define QB_SDQCR_DCT_SHIFT  24
-#define QB_SDQCR_DCT_MASK   0x3
-#define QB_SDQCR_TOK_SHIFT  16
-#define QB_SDQCR_TOK_MASK   0xff
-#define QB_SDQCR_SRC_SHIFT  0
-#define QB_SDQCR_SRC_MASK   0xffff
-
-/* opaque token for static dequeues */
-#define QMAN_SDQCR_TOKEN    0xbb
-
-enum qbman_sdqcr_dct {
-	qbman_sdqcr_dct_null = 0,
-	qbman_sdqcr_dct_prio_ics,
-	qbman_sdqcr_dct_active_ics,
-	qbman_sdqcr_dct_active
-};
-
-enum qbman_sdqcr_fc {
-	qbman_sdqcr_fc_one = 0,
-	qbman_sdqcr_fc_up_to_3 = 1
-};
-
-/* Portal Access */
-
-static inline u32 qbman_read_register(struct qbman_swp *p, u32 offset)
-{
-	return readl_relaxed(p->addr_cinh + offset);
-}
-
-static inline void qbman_write_register(struct qbman_swp *p, u32 offset,
-					u32 value)
-{
-	writel_relaxed(value, p->addr_cinh + offset);
-}
-
-static inline void *qbman_get_cmd(struct qbman_swp *p, u32 offset)
-{
-	return p->addr_cena + offset;
-}
-
-#define QBMAN_CINH_SWP_CFG   0xd00
-
-#define SWP_CFG_DQRR_MF_SHIFT 20
-#define SWP_CFG_EST_SHIFT     16
-#define SWP_CFG_WN_SHIFT      14
-#define SWP_CFG_RPM_SHIFT     12
-#define SWP_CFG_DCM_SHIFT     10
-#define SWP_CFG_EPM_SHIFT     8
-#define SWP_CFG_SD_SHIFT      5
-#define SWP_CFG_SP_SHIFT      4
-#define SWP_CFG_SE_SHIFT      3
-#define SWP_CFG_DP_SHIFT      2
-#define SWP_CFG_DE_SHIFT      1
-#define SWP_CFG_EP_SHIFT      0
-
-static inline u32 qbman_set_swp_cfg(u8 max_fill, u8 wn,	u8 est, u8 rpm, u8 dcm,
-				    u8 epm, int sd, int sp, int se,
-				    int dp, int de, int ep)
-{
-	return (max_fill << SWP_CFG_DQRR_MF_SHIFT |
-		est << SWP_CFG_EST_SHIFT |
-		wn << SWP_CFG_WN_SHIFT |
-		rpm << SWP_CFG_RPM_SHIFT |
-		dcm << SWP_CFG_DCM_SHIFT |
-		epm << SWP_CFG_EPM_SHIFT |
-		sd << SWP_CFG_SD_SHIFT |
-		sp << SWP_CFG_SP_SHIFT |
-		se << SWP_CFG_SE_SHIFT |
-		dp << SWP_CFG_DP_SHIFT |
-		de << SWP_CFG_DE_SHIFT |
-		ep << SWP_CFG_EP_SHIFT);
-}
-
-/**
- * qbman_swp_init() - Create a functional object representing the given
- *                    QBMan portal descriptor.
- * @d: the given qbman swp descriptor
- *
- * Return qbman_swp portal for success, NULL if the object cannot
- * be created.
- */
-struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d)
-{
-	struct qbman_swp *p = kmalloc(sizeof(*p), GFP_KERNEL);
-	u32 reg;
-
-	if (!p)
-		return NULL;
-	p->desc = d;
-	p->mc.valid_bit = QB_VALID_BIT;
-	p->sdq = 0;
-	p->sdq |= qbman_sdqcr_dct_prio_ics << QB_SDQCR_DCT_SHIFT;
-	p->sdq |= qbman_sdqcr_fc_up_to_3 << QB_SDQCR_FC_SHIFT;
-	p->sdq |= QMAN_SDQCR_TOKEN << QB_SDQCR_TOK_SHIFT;
-
-	atomic_set(&p->vdq.available, 1);
-	p->vdq.valid_bit = QB_VALID_BIT;
-	p->dqrr.next_idx = 0;
-	p->dqrr.valid_bit = QB_VALID_BIT;
-
-	if ((p->desc->qman_version & QMAN_REV_MASK) < QMAN_REV_4100) {
-		p->dqrr.dqrr_size = 4;
-		p->dqrr.reset_bug = 1;
-	} else {
-		p->dqrr.dqrr_size = 8;
-		p->dqrr.reset_bug = 0;
-	}
-
-	p->addr_cena = d->cena_bar;
-	p->addr_cinh = d->cinh_bar;
-
-	reg = qbman_set_swp_cfg(p->dqrr.dqrr_size,
-				1, /* Writes Non-cacheable */
-				0, /* EQCR_CI stashing threshold */
-				3, /* RPM: Valid bit mode, RCR in array mode */
-				2, /* DCM: Discrete consumption ack mode */
-				3, /* EPM: Valid bit mode, EQCR in array mode */
-				0, /* mem stashing drop enable == FALSE */
-				1, /* mem stashing priority == TRUE */
-				0, /* mem stashing enable == FALSE */
-				1, /* dequeue stashing priority == TRUE */
-				0, /* dequeue stashing enable == FALSE */
-				0); /* EQCR_CI stashing priority == FALSE */
-
-	qbman_write_register(p, QBMAN_CINH_SWP_CFG, reg);
-	reg = qbman_read_register(p, QBMAN_CINH_SWP_CFG);
-	if (!reg) {
-		pr_err("qbman: the portal is not enabled!\n");
-		return NULL;
-	}
-
-	/*
-	 * SDQCR needs to be initialized to 0 when no channels are
-	 * being dequeued from or else the QMan HW will indicate an
-	 * error.  The values that were calculated above will be
-	 * applied when dequeues from a specific channel are enabled.
-	 */
-	qbman_write_register(p, QBMAN_CINH_SWP_SDQCR, 0);
-	return p;
-}
-
-/**
- * qbman_swp_finish() - Create and destroy a functional object representing
- *                      the given QBMan portal descriptor.
- * @p: the qbman_swp object to be destroyed
- */
-void qbman_swp_finish(struct qbman_swp *p)
-{
-	kfree(p);
-}
-
-/**
- * qbman_swp_interrupt_read_status()
- * @p: the given software portal
- *
- * Return the value in the SWP_ISR register.
- */
-u32 qbman_swp_interrupt_read_status(struct qbman_swp *p)
-{
-	return qbman_read_register(p, QBMAN_CINH_SWP_ISR);
-}
-
-/**
- * qbman_swp_interrupt_clear_status()
- * @p: the given software portal
- * @mask: The mask to clear in SWP_ISR register
- */
-void qbman_swp_interrupt_clear_status(struct qbman_swp *p, u32 mask)
-{
-	qbman_write_register(p, QBMAN_CINH_SWP_ISR, mask);
-}
-
-/**
- * qbman_swp_interrupt_get_trigger() - read interrupt enable register
- * @p: the given software portal
- *
- * Return the value in the SWP_IER register.
- */
-u32 qbman_swp_interrupt_get_trigger(struct qbman_swp *p)
-{
-	return qbman_read_register(p, QBMAN_CINH_SWP_IER);
-}
-
-/**
- * qbman_swp_interrupt_set_trigger() - enable interrupts for a swp
- * @p: the given software portal
- * @mask: The mask of bits to enable in SWP_IER
- */
-void qbman_swp_interrupt_set_trigger(struct qbman_swp *p, u32 mask)
-{
-	qbman_write_register(p, QBMAN_CINH_SWP_IER, mask);
-}
-
-/**
- * qbman_swp_interrupt_get_inhibit() - read interrupt mask register
- * @p: the given software portal object
- *
- * Return the value in the SWP_IIR register.
- */
-int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p)
-{
-	return qbman_read_register(p, QBMAN_CINH_SWP_IIR);
-}
-
-/**
- * qbman_swp_interrupt_set_inhibit() - write interrupt mask register
- * @p: the given software portal object
- * @mask: The mask to set in SWP_IIR register
- */
-void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit)
-{
-	qbman_write_register(p, QBMAN_CINH_SWP_IIR, inhibit ? 0xffffffff : 0);
-}
-
-/*
- * Different management commands all use this common base layer of code to issue
- * commands and poll for results.
- */
-
-/*
- * Returns a pointer to where the caller should fill in their management command
- * (caller should ignore the verb byte)
- */
-void *qbman_swp_mc_start(struct qbman_swp *p)
-{
-	return qbman_get_cmd(p, QBMAN_CENA_SWP_CR);
-}
-
-/*
- * Commits merges in the caller-supplied command verb (which should not include
- * the valid-bit) and submits the command to hardware
- */
-void qbman_swp_mc_submit(struct qbman_swp *p, void *cmd, u8 cmd_verb)
-{
-	u8 *v = cmd;
-
-	dma_wmb();
-	*v = cmd_verb | p->mc.valid_bit;
-}
-
-/*
- * Checks for a completed response (returns non-NULL if only if the response
- * is complete).
- */
-void *qbman_swp_mc_result(struct qbman_swp *p)
-{
-	u32 *ret, verb;
-
-	ret = qbman_get_cmd(p, QBMAN_CENA_SWP_RR(p->mc.valid_bit));
-
-	/* Remove the valid-bit - command completed if the rest is non-zero */
-	verb = ret[0] & ~QB_VALID_BIT;
-	if (!verb)
-		return NULL;
-	p->mc.valid_bit ^= QB_VALID_BIT;
-	return ret;
-}
-
-#define QB_ENQUEUE_CMD_OPTIONS_SHIFT    0
-enum qb_enqueue_commands {
-	enqueue_empty = 0,
-	enqueue_response_always = 1,
-	enqueue_rejects_to_fq = 2
-};
-
-#define QB_ENQUEUE_CMD_ORP_ENABLE_SHIFT      2
-#define QB_ENQUEUE_CMD_IRQ_ON_DISPATCH_SHIFT 3
-#define QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT     4
-
-/**
- * qbman_eq_desc_clear() - Clear the contents of a descriptor to
- *                         default/starting state.
- */
-void qbman_eq_desc_clear(struct qbman_eq_desc *d)
-{
-	memset(d, 0, sizeof(*d));
-}
-
-/**
- * qbman_eq_desc_set_no_orp() - Set enqueue descriptor without orp
- * @d:                the enqueue descriptor.
- * @response_success: 1 = enqueue with response always; 0 = enqueue with
- *                    rejections returned on a FQ.
- */
-void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
-{
-	d->verb &= ~(1 << QB_ENQUEUE_CMD_ORP_ENABLE_SHIFT);
-	if (respond_success)
-		d->verb |= enqueue_response_always;
-	else
-		d->verb |= enqueue_rejects_to_fq;
-}
-
-/*
- * Exactly one of the following descriptor "targets" should be set. (Calling any
- * one of these will replace the effect of any prior call to one of these.)
- *   -enqueue to a frame queue
- *   -enqueue to a queuing destination
- */
-
-/**
- * qbman_eq_desc_set_fq() - set the FQ for the enqueue command
- * @d:    the enqueue descriptor
- * @fqid: the id of the frame queue to be enqueued
- */
-void qbman_eq_desc_set_fq(struct qbman_eq_desc *d, u32 fqid)
-{
-	d->verb &= ~(1 << QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT);
-	d->tgtid = cpu_to_le32(fqid);
-}
-
-/**
- * qbman_eq_desc_set_qd() - Set Queuing Destination for the enqueue command
- * @d:       the enqueue descriptor
- * @qdid:    the id of the queuing destination to be enqueued
- * @qd_bin:  the queuing destination bin
- * @qd_prio: the queuing destination priority
- */
-void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
-			  u32 qd_bin, u32 qd_prio)
-{
-	d->verb |= 1 << QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT;
-	d->tgtid = cpu_to_le32(qdid);
-	d->qdbin = cpu_to_le16(qd_bin);
-	d->qpri = qd_prio;
-}
-
-#define EQAR_IDX(eqar)     ((eqar) & 0x7)
-#define EQAR_VB(eqar)      ((eqar) & 0x80)
-#define EQAR_SUCCESS(eqar) ((eqar) & 0x100)
-
-/**
- * qbman_swp_enqueue() - Issue an enqueue command
- * @s:  the software portal used for enqueue
- * @d:  the enqueue descriptor
- * @fd: the frame descriptor to be enqueued
- *
- * Please note that 'fd' should only be NULL if the "action" of the
- * descriptor is "orp_hole" or "orp_nesn".
- *
- * Return 0 for successful enqueue, -EBUSY if the EQCR is not ready.
- */
-int qbman_swp_enqueue(struct qbman_swp *s, const struct qbman_eq_desc *d,
-		      const struct dpaa2_fd *fd)
-{
-	struct qbman_eq_desc *p;
-	u32 eqar = qbman_read_register(s, QBMAN_CINH_SWP_EQAR);
-
-	if (!EQAR_SUCCESS(eqar))
-		return -EBUSY;
-
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_EQCR(EQAR_IDX(eqar)));
-	memcpy(&p->dca, &d->dca, 31);
-	memcpy(&p->fd, fd, sizeof(*fd));
-
-	/* Set the verb byte, have to substitute in the valid-bit */
-	dma_wmb();
-	p->verb = d->verb | EQAR_VB(eqar);
-
-	return 0;
-}
-
-/* Static (push) dequeue */
-
-/**
- * qbman_swp_push_get() - Get the push dequeue setup
- * @p:           the software portal object
- * @channel_idx: the channel index to query
- * @enabled:     returned boolean to show whether the push dequeue is enabled
- *               for the given channel
- */
-void qbman_swp_push_get(struct qbman_swp *s, u8 channel_idx, int *enabled)
-{
-	u16 src = (s->sdq >> QB_SDQCR_SRC_SHIFT) & QB_SDQCR_SRC_MASK;
-
-	WARN_ON(channel_idx > 15);
-	*enabled = src | (1 << channel_idx);
-}
-
-/**
- * qbman_swp_push_set() - Enable or disable push dequeue
- * @p:           the software portal object
- * @channel_idx: the channel index (0 to 15)
- * @enable:      enable or disable push dequeue
- */
-void qbman_swp_push_set(struct qbman_swp *s, u8 channel_idx, int enable)
-{
-	u16 dqsrc;
-
-	WARN_ON(channel_idx > 15);
-	if (enable)
-		s->sdq |= 1 << channel_idx;
-	else
-		s->sdq &= ~(1 << channel_idx);
-
-	/* Read make the complete src map.  If no channels are enabled
-	 * the SDQCR must be 0 or else QMan will assert errors
-	 */
-	dqsrc = (s->sdq >> QB_SDQCR_SRC_SHIFT) & QB_SDQCR_SRC_MASK;
-	if (dqsrc != 0)
-		qbman_write_register(s, QBMAN_CINH_SWP_SDQCR, s->sdq);
-	else
-		qbman_write_register(s, QBMAN_CINH_SWP_SDQCR, 0);
-}
-
-#define QB_VDQCR_VERB_DCT_SHIFT    0
-#define QB_VDQCR_VERB_DT_SHIFT     2
-#define QB_VDQCR_VERB_RLS_SHIFT    4
-#define QB_VDQCR_VERB_WAE_SHIFT    5
-
-enum qb_pull_dt_e {
-	qb_pull_dt_channel,
-	qb_pull_dt_workqueue,
-	qb_pull_dt_framequeue
-};
-
-/**
- * qbman_pull_desc_clear() - Clear the contents of a descriptor to
- *                           default/starting state
- * @d: the pull dequeue descriptor to be cleared
- */
-void qbman_pull_desc_clear(struct qbman_pull_desc *d)
-{
-	memset(d, 0, sizeof(*d));
-}
-
-/**
- * qbman_pull_desc_set_storage()- Set the pull dequeue storage
- * @d:            the pull dequeue descriptor to be set
- * @storage:      the pointer of the memory to store the dequeue result
- * @storage_phys: the physical address of the storage memory
- * @stash:        to indicate whether write allocate is enabled
- *
- * If not called, or if called with 'storage' as NULL, the result pull dequeues
- * will produce results to DQRR. If 'storage' is non-NULL, then results are
- * produced to the given memory location (using the DMA address which
- * the caller provides in 'storage_phys'), and 'stash' controls whether or not
- * those writes to main-memory express a cache-warming attribute.
- */
-void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
-				 struct dpaa2_dq *storage,
-				 dma_addr_t storage_phys,
-				 int stash)
-{
-	/* save the virtual address */
-	d->rsp_addr_virt = (u64)(uintptr_t)storage;
-
-	if (!storage) {
-		d->verb &= ~(1 << QB_VDQCR_VERB_RLS_SHIFT);
-		return;
-	}
-	d->verb |= 1 << QB_VDQCR_VERB_RLS_SHIFT;
-	if (stash)
-		d->verb |= 1 << QB_VDQCR_VERB_WAE_SHIFT;
-	else
-		d->verb &= ~(1 << QB_VDQCR_VERB_WAE_SHIFT);
-
-	d->rsp_addr = cpu_to_le64(storage_phys);
-}
-
-/**
- * qbman_pull_desc_set_numframes() - Set the number of frames to be dequeued
- * @d:         the pull dequeue descriptor to be set
- * @numframes: number of frames to be set, must be between 1 and 16, inclusive
- */
-void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes)
-{
-	d->numf = numframes - 1;
-}
-
-/*
- * Exactly one of the following descriptor "actions" should be set. (Calling any
- * one of these will replace the effect of any prior call to one of these.)
- * - pull dequeue from the given frame queue (FQ)
- * - pull dequeue from any FQ in the given work queue (WQ)
- * - pull dequeue from any FQ in any WQ in the given channel
- */
-
-/**
- * qbman_pull_desc_set_fq() - Set fqid from which the dequeue command dequeues
- * @fqid: the frame queue index of the given FQ
- */
-void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, u32 fqid)
-{
-	d->verb |= 1 << QB_VDQCR_VERB_DCT_SHIFT;
-	d->verb |= qb_pull_dt_framequeue << QB_VDQCR_VERB_DT_SHIFT;
-	d->dq_src = cpu_to_le32(fqid);
-}
-
-/**
- * qbman_pull_desc_set_wq() - Set wqid from which the dequeue command dequeues
- * @wqid: composed of channel id and wqid within the channel
- * @dct:  the dequeue command type
- */
-void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, u32 wqid,
-			    enum qbman_pull_type_e dct)
-{
-	d->verb |= dct << QB_VDQCR_VERB_DCT_SHIFT;
-	d->verb |= qb_pull_dt_workqueue << QB_VDQCR_VERB_DT_SHIFT;
-	d->dq_src = cpu_to_le32(wqid);
-}
-
-/**
- * qbman_pull_desc_set_channel() - Set channelid from which the dequeue command
- *                                 dequeues
- * @chid: the channel id to be dequeued
- * @dct:  the dequeue command type
- */
-void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, u32 chid,
-				 enum qbman_pull_type_e dct)
-{
-	d->verb |= dct << QB_VDQCR_VERB_DCT_SHIFT;
-	d->verb |= qb_pull_dt_channel << QB_VDQCR_VERB_DT_SHIFT;
-	d->dq_src = cpu_to_le32(chid);
-}
-
-/**
- * qbman_swp_pull() - Issue the pull dequeue command
- * @s: the software portal object
- * @d: the software portal descriptor which has been configured with
- *     the set of qbman_pull_desc_set_*() calls
- *
- * Return 0 for success, and -EBUSY if the software portal is not ready
- * to do pull dequeue.
- */
-int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
-{
-	struct qbman_pull_desc *p;
-
-	if (!atomic_dec_and_test(&s->vdq.available)) {
-		atomic_inc(&s->vdq.available);
-		return -EBUSY;
-	}
-	s->vdq.storage = (void *)(uintptr_t)d->rsp_addr_virt;
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_VDQCR);
-	p->numf = d->numf;
-	p->tok = QMAN_DQ_TOKEN_VALID;
-	p->dq_src = d->dq_src;
-	p->rsp_addr = d->rsp_addr;
-	p->rsp_addr_virt = d->rsp_addr_virt;
-	dma_wmb();
-
-	/* Set the verb byte, have to substitute in the valid-bit */
-	p->verb = d->verb | s->vdq.valid_bit;
-	s->vdq.valid_bit ^= QB_VALID_BIT;
-
-	return 0;
-}
-
-#define QMAN_DQRR_PI_MASK   0xf
-
-/**
- * qbman_swp_dqrr_next() - Get an valid DQRR entry
- * @s: the software portal object
- *
- * Return NULL if there are no unconsumed DQRR entries. Return a DQRR entry
- * only once, so repeated calls can return a sequence of DQRR entries, without
- * requiring they be consumed immediately or in any particular order.
- */
-const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s)
-{
-	u32 verb;
-	u32 response_verb;
-	u32 flags;
-	struct dpaa2_dq *p;
-
-	/* Before using valid-bit to detect if something is there, we have to
-	 * handle the case of the DQRR reset bug...
-	 */
-	if (unlikely(s->dqrr.reset_bug)) {
-		/*
-		 * We pick up new entries by cache-inhibited producer index,
-		 * which means that a non-coherent mapping would require us to
-		 * invalidate and read *only* once that PI has indicated that
-		 * there's an entry here. The first trip around the DQRR ring
-		 * will be much less efficient than all subsequent trips around
-		 * it...
-		 */
-		u8 pi = qbman_read_register(s, QBMAN_CINH_SWP_DQPI) &
-			QMAN_DQRR_PI_MASK;
-
-		/* there are new entries if pi != next_idx */
-		if (pi == s->dqrr.next_idx)
-			return NULL;
-
-		/*
-		 * if next_idx is/was the last ring index, and 'pi' is
-		 * different, we can disable the workaround as all the ring
-		 * entries have now been DMA'd to so valid-bit checking is
-		 * repaired. Note: this logic needs to be based on next_idx
-		 * (which increments one at a time), rather than on pi (which
-		 * can burst and wrap-around between our snapshots of it).
-		 */
-		if (s->dqrr.next_idx == (s->dqrr.dqrr_size - 1)) {
-			pr_debug("next_idx=%d, pi=%d, clear reset bug\n",
-				 s->dqrr.next_idx, pi);
-			s->dqrr.reset_bug = 0;
-		}
-		prefetch(qbman_get_cmd(s,
-				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
-	}
-
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx));
-	verb = p->dq.verb;
-
-	/*
-	 * If the valid-bit isn't of the expected polarity, nothing there. Note,
-	 * in the DQRR reset bug workaround, we shouldn't need to skip these
-	 * check, because we've already determined that a new entry is available
-	 * and we've invalidated the cacheline before reading it, so the
-	 * valid-bit behaviour is repaired and should tell us what we already
-	 * knew from reading PI.
-	 */
-	if ((verb & QB_VALID_BIT) != s->dqrr.valid_bit) {
-		prefetch(qbman_get_cmd(s,
-				       QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
-		return NULL;
-	}
-	/*
-	 * There's something there. Move "next_idx" attention to the next ring
-	 * entry (and prefetch it) before returning what we found.
-	 */
-	s->dqrr.next_idx++;
-	s->dqrr.next_idx &= s->dqrr.dqrr_size - 1; /* Wrap around */
-	if (!s->dqrr.next_idx)
-		s->dqrr.valid_bit ^= QB_VALID_BIT;
-
-	/*
-	 * If this is the final response to a volatile dequeue command
-	 * indicate that the vdq is available
-	 */
-	flags = p->dq.stat;
-	response_verb = verb & QBMAN_RESULT_MASK;
-	if ((response_verb == QBMAN_RESULT_DQ) &&
-	    (flags & DPAA2_DQ_STAT_VOLATILE) &&
-	    (flags & DPAA2_DQ_STAT_EXPIRED))
-		atomic_inc(&s->vdq.available);
-
-	prefetch(qbman_get_cmd(s, QBMAN_CENA_SWP_DQRR(s->dqrr.next_idx)));
-
-	return p;
-}
-
-/**
- * qbman_swp_dqrr_consume() -  Consume DQRR entries previously returned from
- *                             qbman_swp_dqrr_next().
- * @s: the software portal object
- * @dq: the DQRR entry to be consumed
- */
-void qbman_swp_dqrr_consume(struct qbman_swp *s, const struct dpaa2_dq *dq)
-{
-	qbman_write_register(s, QBMAN_CINH_SWP_DCAP, QBMAN_IDX_FROM_DQRR(dq));
-}
-
-/**
- * qbman_result_has_new_result() - Check and get the dequeue response from the
- *                                 dq storage memory set in pull dequeue command
- * @s: the software portal object
- * @dq: the dequeue result read from the memory
- *
- * Return 1 for getting a valid dequeue result, or 0 for not getting a valid
- * dequeue result.
- *
- * Only used for user-provided storage of dequeue results, not DQRR. For
- * efficiency purposes, the driver will perform any required endianness
- * conversion to ensure that the user's dequeue result storage is in host-endian
- * format. As such, once the user has called qbman_result_has_new_result() and
- * been returned a valid dequeue result, they should not call it again on
- * the same memory location (except of course if another dequeue command has
- * been executed to produce a new result to that location).
- */
-int qbman_result_has_new_result(struct qbman_swp *s, const struct dpaa2_dq *dq)
-{
-	if (dq->dq.tok != QMAN_DQ_TOKEN_VALID)
-		return 0;
-
-	/*
-	 * Set token to be 0 so we will detect change back to 1
-	 * next time the looping is traversed. Const is cast away here
-	 * as we want users to treat the dequeue responses as read only.
-	 */
-	((struct dpaa2_dq *)dq)->dq.tok = 0;
-
-	/*
-	 * Determine whether VDQCR is available based on whether the
-	 * current result is sitting in the first storage location of
-	 * the busy command.
-	 */
-	if (s->vdq.storage == dq) {
-		s->vdq.storage = NULL;
-		atomic_inc(&s->vdq.available);
-	}
-
-	return 1;
-}
-
-/**
- * qbman_release_desc_clear() - Clear the contents of a descriptor to
- *                              default/starting state.
- */
-void qbman_release_desc_clear(struct qbman_release_desc *d)
-{
-	memset(d, 0, sizeof(*d));
-	d->verb = 1 << 5; /* Release Command Valid */
-}
-
-/**
- * qbman_release_desc_set_bpid() - Set the ID of the buffer pool to release to
- */
-void qbman_release_desc_set_bpid(struct qbman_release_desc *d, u16 bpid)
-{
-	d->bpid = cpu_to_le16(bpid);
-}
-
-/**
- * qbman_release_desc_set_rcdi() - Determines whether or not the portal's RCDI
- * interrupt source should be asserted after the release command is completed.
- */
-void qbman_release_desc_set_rcdi(struct qbman_release_desc *d, int enable)
-{
-	if (enable)
-		d->verb |= 1 << 6;
-	else
-		d->verb &= ~(1 << 6);
-}
-
-#define RAR_IDX(rar)     ((rar) & 0x7)
-#define RAR_VB(rar)      ((rar) & 0x80)
-#define RAR_SUCCESS(rar) ((rar) & 0x100)
-
-/**
- * qbman_swp_release() - Issue a buffer release command
- * @s:           the software portal object
- * @d:           the release descriptor
- * @buffers:     a pointer pointing to the buffer address to be released
- * @num_buffers: number of buffers to be released,  must be less than 8
- *
- * Return 0 for success, -EBUSY if the release command ring is not ready.
- */
-int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
-		      const u64 *buffers, unsigned int num_buffers)
-{
-	int i;
-	struct qbman_release_desc *p;
-	u32 rar;
-
-	if (!num_buffers || (num_buffers > 7))
-		return -EINVAL;
-
-	rar = qbman_read_register(s, QBMAN_CINH_SWP_RAR);
-	if (!RAR_SUCCESS(rar))
-		return -EBUSY;
-
-	/* Start the release command */
-	p = qbman_get_cmd(s, QBMAN_CENA_SWP_RCR(RAR_IDX(rar)));
-	/* Copy the caller's buffer pointers to the command */
-	for (i = 0; i < num_buffers; i++)
-		p->buf[i] = cpu_to_le64(buffers[i]);
-	p->bpid = d->bpid;
-
-	/*
-	 * Set the verb byte, have to substitute in the valid-bit and the number
-	 * of buffers.
-	 */
-	dma_wmb();
-	p->verb = d->verb | RAR_VB(rar) | num_buffers;
-
-	return 0;
-}
-
-struct qbman_acquire_desc {
-	u8 verb;
-	u8 reserved;
-	__le16 bpid;
-	u8 num;
-	u8 reserved2[59];
-};
-
-struct qbman_acquire_rslt {
-	u8 verb;
-	u8 rslt;
-	__le16 reserved;
-	u8 num;
-	u8 reserved2[3];
-	__le64 buf[7];
-};
-
-/**
- * qbman_swp_acquire() - Issue a buffer acquire command
- * @s:           the software portal object
- * @bpid:        the buffer pool index
- * @buffers:     a pointer pointing to the acquired buffer addresses
- * @num_buffers: number of buffers to be acquired, must be less than 8
- *
- * Return 0 for success, or negative error code if the acquire command
- * fails.
- */
-int qbman_swp_acquire(struct qbman_swp *s, u16 bpid, u64 *buffers,
-		      unsigned int num_buffers)
-{
-	struct qbman_acquire_desc *p;
-	struct qbman_acquire_rslt *r;
-	int i;
-
-	if (!num_buffers || (num_buffers > 7))
-		return -EINVAL;
-
-	/* Start the management command */
-	p = qbman_swp_mc_start(s);
-
-	if (!p)
-		return -EBUSY;
-
-	/* Encode the caller-provided attributes */
-	p->bpid = cpu_to_le16(bpid);
-	p->num = num_buffers;
-
-	/* Complete the management command */
-	r = qbman_swp_mc_complete(s, p, QBMAN_MC_ACQUIRE);
-	if (unlikely(!r)) {
-		pr_err("qbman: acquire from BPID %d failed, no response\n",
-		       bpid);
-		return -EIO;
-	}
-
-	/* Decode the outcome */
-	WARN_ON((r->verb & 0x7f) != QBMAN_MC_ACQUIRE);
-
-	/* Determine success or failure */
-	if (unlikely(r->rslt != QBMAN_MC_RSLT_OK)) {
-		pr_err("qbman: acquire from BPID 0x%x failed, code=0x%02x\n",
-		       bpid, r->rslt);
-		return -EIO;
-	}
-
-	WARN_ON(r->num > num_buffers);
-
-	/* Copy the acquired buffers to the caller's array */
-	for (i = 0; i < r->num; i++)
-		buffers[i] = le64_to_cpu(r->buf[i]);
-
-	return (int)r->num;
-}
-
-struct qbman_alt_fq_state_desc {
-	u8 verb;
-	u8 reserved[3];
-	__le32 fqid;
-	u8 reserved2[56];
-};
-
-struct qbman_alt_fq_state_rslt {
-	u8 verb;
-	u8 rslt;
-	u8 reserved[62];
-};
-
-#define ALT_FQ_FQID_MASK 0x00FFFFFF
-
-int qbman_swp_alt_fq_state(struct qbman_swp *s, u32 fqid,
-			   u8 alt_fq_verb)
-{
-	struct qbman_alt_fq_state_desc *p;
-	struct qbman_alt_fq_state_rslt *r;
-
-	/* Start the management command */
-	p = qbman_swp_mc_start(s);
-	if (!p)
-		return -EBUSY;
-
-	p->fqid = cpu_to_le32(fqid & ALT_FQ_FQID_MASK);
-
-	/* Complete the management command */
-	r = qbman_swp_mc_complete(s, p, alt_fq_verb);
-	if (unlikely(!r)) {
-		pr_err("qbman: mgmt cmd failed, no response (verb=0x%x)\n",
-		       alt_fq_verb);
-		return -EIO;
-	}
-
-	/* Decode the outcome */
-	WARN_ON((r->verb & QBMAN_RESULT_MASK) != alt_fq_verb);
-
-	/* Determine success or failure */
-	if (unlikely(r->rslt != QBMAN_MC_RSLT_OK)) {
-		pr_err("qbman: ALT FQID %d failed: verb = 0x%08x code = 0x%02x\n",
-		       fqid, r->verb, r->rslt);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-struct qbman_cdan_ctrl_desc {
-	u8 verb;
-	u8 reserved;
-	__le16 ch;
-	u8 we;
-	u8 ctrl;
-	__le16 reserved2;
-	__le64 cdan_ctx;
-	u8 reserved3[48];
-
-};
-
-struct qbman_cdan_ctrl_rslt {
-	u8 verb;
-	u8 rslt;
-	__le16 ch;
-	u8 reserved[60];
-};
-
-int qbman_swp_CDAN_set(struct qbman_swp *s, u16 channelid,
-		       u8 we_mask, u8 cdan_en,
-		       u64 ctx)
-{
-	struct qbman_cdan_ctrl_desc *p = NULL;
-	struct qbman_cdan_ctrl_rslt *r = NULL;
-
-	/* Start the management command */
-	p = qbman_swp_mc_start(s);
-	if (!p)
-		return -EBUSY;
-
-	/* Encode the caller-provided attributes */
-	p->ch = cpu_to_le16(channelid);
-	p->we = we_mask;
-	if (cdan_en)
-		p->ctrl = 1;
-	else
-		p->ctrl = 0;
-	p->cdan_ctx = cpu_to_le64(ctx);
-
-	/* Complete the management command */
-	r = qbman_swp_mc_complete(s, p, QBMAN_WQCHAN_CONFIGURE);
-	if (unlikely(!r)) {
-		pr_err("qbman: wqchan config failed, no response\n");
-		return -EIO;
-	}
-
-	WARN_ON((r->verb & 0x7f) != QBMAN_WQCHAN_CONFIGURE);
-
-	/* Determine success or failure */
-	if (unlikely(r->rslt != QBMAN_MC_RSLT_OK)) {
-		pr_err("qbman: CDAN cQID %d failed: code = 0x%02x\n",
-		       channelid, r->rslt);
-		return -EIO;
-	}
-
-	return 0;
-}
diff --git a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h b/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
deleted file mode 100644
index 4488a44..0000000
--- a/drivers/staging/fsl-mc/bus/dpio/qbman-portal.h
+++ /dev/null
@@ -1,444 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
- * Copyright 2016 NXP
- *
- */
-#ifndef __FSL_QBMAN_PORTAL_H
-#define __FSL_QBMAN_PORTAL_H
-
-#include "../../include/dpaa2-fd.h"
-
-struct dpaa2_dq;
-struct qbman_swp;
-
-/* qbman software portal descriptor structure */
-struct qbman_swp_desc {
-	void *cena_bar; /* Cache-enabled portal base address */
-	void *cinh_bar; /* Cache-inhibited portal base address */
-	u32 qman_version;
-};
-
-#define QBMAN_SWP_INTERRUPT_EQRI 0x01
-#define QBMAN_SWP_INTERRUPT_EQDI 0x02
-#define QBMAN_SWP_INTERRUPT_DQRI 0x04
-#define QBMAN_SWP_INTERRUPT_RCRI 0x08
-#define QBMAN_SWP_INTERRUPT_RCDI 0x10
-#define QBMAN_SWP_INTERRUPT_VDCI 0x20
-
-/* the structure for pull dequeue descriptor */
-struct qbman_pull_desc {
-	u8 verb;
-	u8 numf;
-	u8 tok;
-	u8 reserved;
-	__le32 dq_src;
-	__le64 rsp_addr;
-	u64 rsp_addr_virt;
-	u8 padding[40];
-};
-
-enum qbman_pull_type_e {
-	/* dequeue with priority precedence, respect intra-class scheduling */
-	qbman_pull_type_prio = 1,
-	/* dequeue with active FQ precedence, respect ICS */
-	qbman_pull_type_active,
-	/* dequeue with active FQ precedence, no ICS */
-	qbman_pull_type_active_noics
-};
-
-/* Definitions for parsing dequeue entries */
-#define QBMAN_RESULT_MASK      0x7f
-#define QBMAN_RESULT_DQ        0x60
-#define QBMAN_RESULT_FQRN      0x21
-#define QBMAN_RESULT_FQRNI     0x22
-#define QBMAN_RESULT_FQPN      0x24
-#define QBMAN_RESULT_FQDAN     0x25
-#define QBMAN_RESULT_CDAN      0x26
-#define QBMAN_RESULT_CSCN_MEM  0x27
-#define QBMAN_RESULT_CGCU      0x28
-#define QBMAN_RESULT_BPSCN     0x29
-#define QBMAN_RESULT_CSCN_WQ   0x2a
-
-/* QBMan FQ management command codes */
-#define QBMAN_FQ_SCHEDULE	0x48
-#define QBMAN_FQ_FORCE		0x49
-#define QBMAN_FQ_XON		0x4d
-#define QBMAN_FQ_XOFF		0x4e
-
-/* structure of enqueue descriptor */
-struct qbman_eq_desc {
-	u8 verb;
-	u8 dca;
-	__le16 seqnum;
-	__le16 orpid;
-	__le16 reserved1;
-	__le32 tgtid;
-	__le32 tag;
-	__le16 qdbin;
-	u8 qpri;
-	u8 reserved[3];
-	u8 wae;
-	u8 rspid;
-	__le64 rsp_addr;
-	u8 fd[32];
-};
-
-/* buffer release descriptor */
-struct qbman_release_desc {
-	u8 verb;
-	u8 reserved;
-	__le16 bpid;
-	__le32 reserved2;
-	__le64 buf[7];
-};
-
-/* Management command result codes */
-#define QBMAN_MC_RSLT_OK      0xf0
-
-#define CODE_CDAN_WE_EN    0x1
-#define CODE_CDAN_WE_CTX   0x4
-
-/* portal data structure */
-struct qbman_swp {
-	const struct qbman_swp_desc *desc;
-	void __iomem *addr_cena;
-	void __iomem *addr_cinh;
-
-	/* Management commands */
-	struct {
-		u32 valid_bit; /* 0x00 or 0x80 */
-	} mc;
-
-	/* Push dequeues */
-	u32 sdq;
-
-	/* Volatile dequeues */
-	struct {
-		atomic_t available; /* indicates if a command can be sent */
-		u32 valid_bit; /* 0x00 or 0x80 */
-		struct dpaa2_dq *storage; /* NULL if DQRR */
-	} vdq;
-
-	/* DQRR */
-	struct {
-		u32 next_idx;
-		u32 valid_bit;
-		u8 dqrr_size;
-		int reset_bug; /* indicates dqrr reset workaround is needed */
-	} dqrr;
-};
-
-struct qbman_swp *qbman_swp_init(const struct qbman_swp_desc *d);
-void qbman_swp_finish(struct qbman_swp *p);
-u32 qbman_swp_interrupt_read_status(struct qbman_swp *p);
-void qbman_swp_interrupt_clear_status(struct qbman_swp *p, u32 mask);
-u32 qbman_swp_interrupt_get_trigger(struct qbman_swp *p);
-void qbman_swp_interrupt_set_trigger(struct qbman_swp *p, u32 mask);
-int qbman_swp_interrupt_get_inhibit(struct qbman_swp *p);
-void qbman_swp_interrupt_set_inhibit(struct qbman_swp *p, int inhibit);
-
-void qbman_swp_push_get(struct qbman_swp *p, u8 channel_idx, int *enabled);
-void qbman_swp_push_set(struct qbman_swp *p, u8 channel_idx, int enable);
-
-void qbman_pull_desc_clear(struct qbman_pull_desc *d);
-void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
-				 struct dpaa2_dq *storage,
-				 dma_addr_t storage_phys,
-				 int stash);
-void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d, u8 numframes);
-void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, u32 fqid);
-void qbman_pull_desc_set_wq(struct qbman_pull_desc *d, u32 wqid,
-			    enum qbman_pull_type_e dct);
-void qbman_pull_desc_set_channel(struct qbman_pull_desc *d, u32 chid,
-				 enum qbman_pull_type_e dct);
-
-int qbman_swp_pull(struct qbman_swp *p, struct qbman_pull_desc *d);
-
-const struct dpaa2_dq *qbman_swp_dqrr_next(struct qbman_swp *s);
-void qbman_swp_dqrr_consume(struct qbman_swp *s, const struct dpaa2_dq *dq);
-
-int qbman_result_has_new_result(struct qbman_swp *p, const struct dpaa2_dq *dq);
-
-void qbman_eq_desc_clear(struct qbman_eq_desc *d);
-void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success);
-void qbman_eq_desc_set_token(struct qbman_eq_desc *d, u8 token);
-void qbman_eq_desc_set_fq(struct qbman_eq_desc *d, u32 fqid);
-void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, u32 qdid,
-			  u32 qd_bin, u32 qd_prio);
-
-int qbman_swp_enqueue(struct qbman_swp *p, const struct qbman_eq_desc *d,
-		      const struct dpaa2_fd *fd);
-
-void qbman_release_desc_clear(struct qbman_release_desc *d);
-void qbman_release_desc_set_bpid(struct qbman_release_desc *d, u16 bpid);
-void qbman_release_desc_set_rcdi(struct qbman_release_desc *d, int enable);
-
-int qbman_swp_release(struct qbman_swp *s, const struct qbman_release_desc *d,
-		      const u64 *buffers, unsigned int num_buffers);
-int qbman_swp_acquire(struct qbman_swp *s, u16 bpid, u64 *buffers,
-		      unsigned int num_buffers);
-int qbman_swp_alt_fq_state(struct qbman_swp *s, u32 fqid,
-			   u8 alt_fq_verb);
-int qbman_swp_CDAN_set(struct qbman_swp *s, u16 channelid,
-		       u8 we_mask, u8 cdan_en,
-		       u64 ctx);
-
-void *qbman_swp_mc_start(struct qbman_swp *p);
-void qbman_swp_mc_submit(struct qbman_swp *p, void *cmd, u8 cmd_verb);
-void *qbman_swp_mc_result(struct qbman_swp *p);
-
-/**
- * qbman_result_is_DQ() - check if the dequeue result is a dequeue response
- * @dq: the dequeue result to be checked
- *
- * DQRR entries may contain non-dequeue results, ie. notifications
- */
-static inline int qbman_result_is_DQ(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_DQ);
-}
-
-/**
- * qbman_result_is_SCN() - Check the dequeue result is notification or not
- * @dq: the dequeue result to be checked
- *
- */
-static inline int qbman_result_is_SCN(const struct dpaa2_dq *dq)
-{
-	return !qbman_result_is_DQ(dq);
-}
-
-/* FQ Data Availability */
-static inline int qbman_result_is_FQDAN(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQDAN);
-}
-
-/* Channel Data Availability */
-static inline int qbman_result_is_CDAN(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_CDAN);
-}
-
-/* Congestion State Change */
-static inline int qbman_result_is_CSCN(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_CSCN_WQ);
-}
-
-/* Buffer Pool State Change */
-static inline int qbman_result_is_BPSCN(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_BPSCN);
-}
-
-/* Congestion Group Count Update */
-static inline int qbman_result_is_CGCU(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_CGCU);
-}
-
-/* Retirement */
-static inline int qbman_result_is_FQRN(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQRN);
-}
-
-/* Retirement Immediate */
-static inline int qbman_result_is_FQRNI(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQRNI);
-}
-
- /* Park */
-static inline int qbman_result_is_FQPN(const struct dpaa2_dq *dq)
-{
-	return ((dq->dq.verb & QBMAN_RESULT_MASK) == QBMAN_RESULT_FQPN);
-}
-
-/**
- * qbman_result_SCN_state() - Get the state field in State-change notification
- */
-static inline u8 qbman_result_SCN_state(const struct dpaa2_dq *scn)
-{
-	return scn->scn.state;
-}
-
-#define SCN_RID_MASK 0x00FFFFFF
-
-/**
- * qbman_result_SCN_rid() - Get the resource id in State-change notification
- */
-static inline u32 qbman_result_SCN_rid(const struct dpaa2_dq *scn)
-{
-	return le32_to_cpu(scn->scn.rid_tok) & SCN_RID_MASK;
-}
-
-/**
- * qbman_result_SCN_ctx() - Get the context data in State-change notification
- */
-static inline u64 qbman_result_SCN_ctx(const struct dpaa2_dq *scn)
-{
-	return le64_to_cpu(scn->scn.ctx);
-}
-
-/**
- * qbman_swp_fq_schedule() - Move the fq to the scheduled state
- * @s:    the software portal object
- * @fqid: the index of frame queue to be scheduled
- *
- * There are a couple of different ways that a FQ can end up parked state,
- * This schedules it.
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_fq_schedule(struct qbman_swp *s, u32 fqid)
-{
-	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_SCHEDULE);
-}
-
-/**
- * qbman_swp_fq_force() - Force the FQ to fully scheduled state
- * @s:    the software portal object
- * @fqid: the index of frame queue to be forced
- *
- * Force eligible will force a tentatively-scheduled FQ to be fully-scheduled
- * and thus be available for selection by any channel-dequeuing behaviour (push
- * or pull). If the FQ is subsequently "dequeued" from the channel and is still
- * empty at the time this happens, the resulting dq_entry will have no FD.
- * (qbman_result_DQ_fd() will return NULL.)
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_fq_force(struct qbman_swp *s, u32 fqid)
-{
-	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_FORCE);
-}
-
-/**
- * qbman_swp_fq_xon() - sets FQ flow-control to XON
- * @s:    the software portal object
- * @fqid: the index of frame queue
- *
- * This setting doesn't affect enqueues to the FQ, just dequeues.
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_fq_xon(struct qbman_swp *s, u32 fqid)
-{
-	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_XON);
-}
-
-/**
- * qbman_swp_fq_xoff() - sets FQ flow-control to XOFF
- * @s:    the software portal object
- * @fqid: the index of frame queue
- *
- * This setting doesn't affect enqueues to the FQ, just dequeues.
- * XOFF FQs will remain in the tenatively-scheduled state, even when
- * non-empty, meaning they won't be selected for scheduled dequeuing.
- * If a FQ is changed to XOFF after it had already become truly-scheduled
- * to a channel, and a pull dequeue of that channel occurs that selects
- * that FQ for dequeuing, then the resulting dq_entry will have no FD.
- * (qbman_result_DQ_fd() will return NULL.)
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_fq_xoff(struct qbman_swp *s, u32 fqid)
-{
-	return qbman_swp_alt_fq_state(s, fqid, QBMAN_FQ_XOFF);
-}
-
-/* If the user has been allocated a channel object that is going to generate
- * CDANs to another channel, then the qbman_swp_CDAN* functions will be
- * necessary.
- *
- * CDAN-enabled channels only generate a single CDAN notification, after which
- * they need to be reenabled before they'll generate another. The idea is
- * that pull dequeuing will occur in reaction to the CDAN, followed by a
- * reenable step. Each function generates a distinct command to hardware, so a
- * combination function is provided if the user wishes to modify the "context"
- * (which shows up in each CDAN message) each time they reenable, as a single
- * command to hardware.
- */
-
-/**
- * qbman_swp_CDAN_set_context() - Set CDAN context
- * @s:         the software portal object
- * @channelid: the channel index
- * @ctx:       the context to be set in CDAN
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_CDAN_set_context(struct qbman_swp *s, u16 channelid,
-					     u64 ctx)
-{
-	return qbman_swp_CDAN_set(s, channelid,
-				  CODE_CDAN_WE_CTX,
-				  0, ctx);
-}
-
-/**
- * qbman_swp_CDAN_enable() - Enable CDAN for the channel
- * @s:         the software portal object
- * @channelid: the index of the channel to generate CDAN
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_CDAN_enable(struct qbman_swp *s, u16 channelid)
-{
-	return qbman_swp_CDAN_set(s, channelid,
-				  CODE_CDAN_WE_EN,
-				  1, 0);
-}
-
-/**
- * qbman_swp_CDAN_disable() - disable CDAN for the channel
- * @s:         the software portal object
- * @channelid: the index of the channel to generate CDAN
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_CDAN_disable(struct qbman_swp *s, u16 channelid)
-{
-	return qbman_swp_CDAN_set(s, channelid,
-				  CODE_CDAN_WE_EN,
-				  0, 0);
-}
-
-/**
- * qbman_swp_CDAN_set_context_enable() - Set CDAN contest and enable CDAN
- * @s:         the software portal object
- * @channelid: the index of the channel to generate CDAN
- * @ctx:i      the context set in CDAN
- *
- * Return 0 for success, or negative error code for failure.
- */
-static inline int qbman_swp_CDAN_set_context_enable(struct qbman_swp *s,
-						    u16 channelid,
-						    u64 ctx)
-{
-	return qbman_swp_CDAN_set(s, channelid,
-				  CODE_CDAN_WE_EN | CODE_CDAN_WE_CTX,
-				  1, ctx);
-}
-
-/* Wraps up submit + poll-for-result */
-static inline void *qbman_swp_mc_complete(struct qbman_swp *swp, void *cmd,
-					  u8 cmd_verb)
-{
-	int loopvar = 1000;
-
-	qbman_swp_mc_submit(swp, cmd, cmd_verb);
-
-	do {
-		cmd = qbman_swp_mc_result(swp);
-	} while (!cmd && loopvar--);
-
-	WARN_ON(!loopvar);
-
-	return cmd;
-}
-
-#endif /* __FSL_QBMAN_PORTAL_H */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-fd.h b/drivers/staging/fsl-mc/include/dpaa2-fd.h
deleted file mode 100644
index b55b89b..0000000
--- a/drivers/staging/fsl-mc/include/dpaa2-fd.h
+++ /dev/null
@@ -1,426 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016 NXP
- *
- */
-#ifndef __FSL_DPAA2_FD_H
-#define __FSL_DPAA2_FD_H
-
-#include <linux/kernel.h>
-
-/**
- * DOC: DPAA2 FD - Frame Descriptor APIs for DPAA2
- *
- * Frame Descriptors (FDs) are used to describe frame data in the DPAA2.
- * Frames can be enqueued and dequeued to Frame Queues (FQs) which are consumed
- * by the various DPAA accelerators (WRIOP, SEC, PME, DCE)
- *
- * There are three types of frames: single, scatter gather, and frame lists.
- *
- * The set of APIs in this file must be used to create, manipulate and
- * query Frame Descriptors.
- */
-
-/**
- * struct dpaa2_fd - Struct describing FDs
- * @words:         for easier/faster copying the whole FD structure
- * @addr:          address in the FD
- * @len:           length in the FD
- * @bpid:          buffer pool ID
- * @format_offset: format, offset, and short-length fields
- * @frc:           frame context
- * @ctrl:          control bits...including dd, sc, va, err, etc
- * @flc:           flow context address
- *
- * This structure represents the basic Frame Descriptor used in the system.
- */
-struct dpaa2_fd {
-	union {
-		u32 words[8];
-		struct dpaa2_fd_simple {
-			__le64 addr;
-			__le32 len;
-			__le16 bpid;
-			__le16 format_offset;
-			__le32 frc;
-			__le32 ctrl;
-			__le64 flc;
-		} simple;
-	};
-};
-
-#define FD_SHORT_LEN_FLAG_MASK	0x1
-#define FD_SHORT_LEN_FLAG_SHIFT	14
-#define FD_SHORT_LEN_MASK	0x3FFFF
-#define FD_OFFSET_MASK		0x0FFF
-#define FD_FORMAT_MASK		0x3
-#define FD_FORMAT_SHIFT		12
-#define FD_BPID_MASK		0x3FFF
-#define SG_SHORT_LEN_FLAG_MASK	0x1
-#define SG_SHORT_LEN_FLAG_SHIFT	14
-#define SG_SHORT_LEN_MASK	0x1FFFF
-#define SG_OFFSET_MASK		0x0FFF
-#define SG_FORMAT_MASK		0x3
-#define SG_FORMAT_SHIFT		12
-#define SG_BPID_MASK		0x3FFF
-#define SG_FINAL_FLAG_MASK	0x1
-#define SG_FINAL_FLAG_SHIFT	15
-
-enum dpaa2_fd_format {
-	dpaa2_fd_single = 0,
-	dpaa2_fd_list,
-	dpaa2_fd_sg
-};
-
-/**
- * dpaa2_fd_get_addr() - get the addr field of frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the address in the frame descriptor.
- */
-static inline dma_addr_t dpaa2_fd_get_addr(const struct dpaa2_fd *fd)
-{
-	return (dma_addr_t)le64_to_cpu(fd->simple.addr);
-}
-
-/**
- * dpaa2_fd_set_addr() - Set the addr field of frame descriptor
- * @fd: the given frame descriptor
- * @addr: the address needs to be set in frame descriptor
- */
-static inline void dpaa2_fd_set_addr(struct dpaa2_fd *fd, dma_addr_t addr)
-{
-	fd->simple.addr = cpu_to_le64(addr);
-}
-
-/**
- * dpaa2_fd_get_frc() - Get the frame context in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the frame context field in the frame descriptor.
- */
-static inline u32 dpaa2_fd_get_frc(const struct dpaa2_fd *fd)
-{
-	return le32_to_cpu(fd->simple.frc);
-}
-
-/**
- * dpaa2_fd_set_frc() - Set the frame context in the frame descriptor
- * @fd: the given frame descriptor
- * @frc: the frame context needs to be set in frame descriptor
- */
-static inline void dpaa2_fd_set_frc(struct dpaa2_fd *fd, u32 frc)
-{
-	fd->simple.frc = cpu_to_le32(frc);
-}
-
-/**
- * dpaa2_fd_get_ctrl() - Get the control bits in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the control bits field in the frame descriptor.
- */
-static inline u32 dpaa2_fd_get_ctrl(const struct dpaa2_fd *fd)
-{
-	return le32_to_cpu(fd->simple.ctrl);
-}
-
-/**
- * dpaa2_fd_set_ctrl() - Set the control bits in the frame descriptor
- * @fd: the given frame descriptor
- * @ctrl: the control bits to be set in the frame descriptor
- */
-static inline void dpaa2_fd_set_ctrl(struct dpaa2_fd *fd, u32 ctrl)
-{
-	fd->simple.ctrl = cpu_to_le32(ctrl);
-}
-
-/**
- * dpaa2_fd_get_flc() - Get the flow context in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the flow context in the frame descriptor.
- */
-static inline dma_addr_t dpaa2_fd_get_flc(const struct dpaa2_fd *fd)
-{
-	return (dma_addr_t)le64_to_cpu(fd->simple.flc);
-}
-
-/**
- * dpaa2_fd_set_flc() - Set the flow context field of frame descriptor
- * @fd: the given frame descriptor
- * @flc_addr: the flow context needs to be set in frame descriptor
- */
-static inline void dpaa2_fd_set_flc(struct dpaa2_fd *fd,  dma_addr_t flc_addr)
-{
-	fd->simple.flc = cpu_to_le64(flc_addr);
-}
-
-static inline bool dpaa2_fd_short_len(const struct dpaa2_fd *fd)
-{
-	return !!((le16_to_cpu(fd->simple.format_offset) >>
-		  FD_SHORT_LEN_FLAG_SHIFT) & FD_SHORT_LEN_FLAG_MASK);
-}
-
-/**
- * dpaa2_fd_get_len() - Get the length in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the length field in the frame descriptor.
- */
-static inline u32 dpaa2_fd_get_len(const struct dpaa2_fd *fd)
-{
-	if (dpaa2_fd_short_len(fd))
-		return le32_to_cpu(fd->simple.len) & FD_SHORT_LEN_MASK;
-
-	return le32_to_cpu(fd->simple.len);
-}
-
-/**
- * dpaa2_fd_set_len() - Set the length field of frame descriptor
- * @fd: the given frame descriptor
- * @len: the length needs to be set in frame descriptor
- */
-static inline void dpaa2_fd_set_len(struct dpaa2_fd *fd, u32 len)
-{
-	fd->simple.len = cpu_to_le32(len);
-}
-
-/**
- * dpaa2_fd_get_offset() - Get the offset field in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the offset.
- */
-static inline uint16_t dpaa2_fd_get_offset(const struct dpaa2_fd *fd)
-{
-	return le16_to_cpu(fd->simple.format_offset) & FD_OFFSET_MASK;
-}
-
-/**
- * dpaa2_fd_set_offset() - Set the offset field of frame descriptor
- * @fd: the given frame descriptor
- * @offset: the offset needs to be set in frame descriptor
- */
-static inline void dpaa2_fd_set_offset(struct dpaa2_fd *fd, uint16_t offset)
-{
-	fd->simple.format_offset &= cpu_to_le16(~FD_OFFSET_MASK);
-	fd->simple.format_offset |= cpu_to_le16(offset);
-}
-
-/**
- * dpaa2_fd_get_format() - Get the format field in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the format.
- */
-static inline enum dpaa2_fd_format dpaa2_fd_get_format(
-						const struct dpaa2_fd *fd)
-{
-	return (enum dpaa2_fd_format)((le16_to_cpu(fd->simple.format_offset)
-				      >> FD_FORMAT_SHIFT) & FD_FORMAT_MASK);
-}
-
-/**
- * dpaa2_fd_set_format() - Set the format field of frame descriptor
- * @fd: the given frame descriptor
- * @format: the format needs to be set in frame descriptor
- */
-static inline void dpaa2_fd_set_format(struct dpaa2_fd *fd,
-				       enum dpaa2_fd_format format)
-{
-	fd->simple.format_offset &=
-		cpu_to_le16(~(FD_FORMAT_MASK << FD_FORMAT_SHIFT));
-	fd->simple.format_offset |= cpu_to_le16(format << FD_FORMAT_SHIFT);
-}
-
-/**
- * dpaa2_fd_get_bpid() - Get the bpid field in the frame descriptor
- * @fd: the given frame descriptor
- *
- * Return the buffer pool id.
- */
-static inline uint16_t dpaa2_fd_get_bpid(const struct dpaa2_fd *fd)
-{
-	return le16_to_cpu(fd->simple.bpid) & FD_BPID_MASK;
-}
-
-/**
- * dpaa2_fd_set_bpid() - Set the bpid field of frame descriptor
- * @fd: the given frame descriptor
- * @bpid: buffer pool id to be set
- */
-static inline void dpaa2_fd_set_bpid(struct dpaa2_fd *fd, uint16_t bpid)
-{
-	fd->simple.bpid &= cpu_to_le16(~(FD_BPID_MASK));
-	fd->simple.bpid |= cpu_to_le16(bpid);
-}
-
-/**
- * struct dpaa2_sg_entry - the scatter-gathering structure
- * @addr: address of the sg entry
- * @len: length in this sg entry
- * @bpid: buffer pool id
- * @format_offset: format and offset fields
- */
-struct dpaa2_sg_entry {
-	__le64 addr;
-	__le32 len;
-	__le16 bpid;
-	__le16 format_offset;
-};
-
-enum dpaa2_sg_format {
-	dpaa2_sg_single = 0,
-	dpaa2_sg_frame_data,
-	dpaa2_sg_sgt_ext
-};
-
-/* Accessors for SG entry fields */
-
-/**
- * dpaa2_sg_get_addr() - Get the address from SG entry
- * @sg: the given scatter-gathering object
- *
- * Return the address.
- */
-static inline dma_addr_t dpaa2_sg_get_addr(const struct dpaa2_sg_entry *sg)
-{
-	return (dma_addr_t)le64_to_cpu(sg->addr);
-}
-
-/**
- * dpaa2_sg_set_addr() - Set the address in SG entry
- * @sg: the given scatter-gathering object
- * @addr: the address to be set
- */
-static inline void dpaa2_sg_set_addr(struct dpaa2_sg_entry *sg, dma_addr_t addr)
-{
-	sg->addr = cpu_to_le64(addr);
-}
-
-static inline bool dpaa2_sg_short_len(const struct dpaa2_sg_entry *sg)
-{
-	return !!((le16_to_cpu(sg->format_offset) >> SG_SHORT_LEN_FLAG_SHIFT)
-		& SG_SHORT_LEN_FLAG_MASK);
-}
-
-/**
- * dpaa2_sg_get_len() - Get the length in SG entry
- * @sg: the given scatter-gathering object
- *
- * Return the length.
- */
-static inline u32 dpaa2_sg_get_len(const struct dpaa2_sg_entry *sg)
-{
-	if (dpaa2_sg_short_len(sg))
-		return le32_to_cpu(sg->len) & SG_SHORT_LEN_MASK;
-
-	return le32_to_cpu(sg->len);
-}
-
-/**
- * dpaa2_sg_set_len() - Set the length in SG entry
- * @sg: the given scatter-gathering object
- * @len: the length to be set
- */
-static inline void dpaa2_sg_set_len(struct dpaa2_sg_entry *sg, u32 len)
-{
-	sg->len = cpu_to_le32(len);
-}
-
-/**
- * dpaa2_sg_get_offset() - Get the offset in SG entry
- * @sg: the given scatter-gathering object
- *
- * Return the offset.
- */
-static inline u16 dpaa2_sg_get_offset(const struct dpaa2_sg_entry *sg)
-{
-	return le16_to_cpu(sg->format_offset) & SG_OFFSET_MASK;
-}
-
-/**
- * dpaa2_sg_set_offset() - Set the offset in SG entry
- * @sg: the given scatter-gathering object
- * @offset: the offset to be set
- */
-static inline void dpaa2_sg_set_offset(struct dpaa2_sg_entry *sg,
-				       u16 offset)
-{
-	sg->format_offset &= cpu_to_le16(~SG_OFFSET_MASK);
-	sg->format_offset |= cpu_to_le16(offset);
-}
-
-/**
- * dpaa2_sg_get_format() - Get the SG format in SG entry
- * @sg: the given scatter-gathering object
- *
- * Return the format.
- */
-static inline enum dpaa2_sg_format
-	dpaa2_sg_get_format(const struct dpaa2_sg_entry *sg)
-{
-	return (enum dpaa2_sg_format)((le16_to_cpu(sg->format_offset)
-				       >> SG_FORMAT_SHIFT) & SG_FORMAT_MASK);
-}
-
-/**
- * dpaa2_sg_set_format() - Set the SG format in SG entry
- * @sg: the given scatter-gathering object
- * @format: the format to be set
- */
-static inline void dpaa2_sg_set_format(struct dpaa2_sg_entry *sg,
-				       enum dpaa2_sg_format format)
-{
-	sg->format_offset &= cpu_to_le16(~(SG_FORMAT_MASK << SG_FORMAT_SHIFT));
-	sg->format_offset |= cpu_to_le16(format << SG_FORMAT_SHIFT);
-}
-
-/**
- * dpaa2_sg_get_bpid() - Get the buffer pool id in SG entry
- * @sg: the given scatter-gathering object
- *
- * Return the bpid.
- */
-static inline u16 dpaa2_sg_get_bpid(const struct dpaa2_sg_entry *sg)
-{
-	return le16_to_cpu(sg->bpid) & SG_BPID_MASK;
-}
-
-/**
- * dpaa2_sg_set_bpid() - Set the buffer pool id in SG entry
- * @sg: the given scatter-gathering object
- * @bpid: the bpid to be set
- */
-static inline void dpaa2_sg_set_bpid(struct dpaa2_sg_entry *sg, u16 bpid)
-{
-	sg->bpid &= cpu_to_le16(~(SG_BPID_MASK));
-	sg->bpid |= cpu_to_le16(bpid);
-}
-
-/**
- * dpaa2_sg_is_final() - Check final bit in SG entry
- * @sg: the given scatter-gathering object
- *
- * Return bool.
- */
-static inline bool dpaa2_sg_is_final(const struct dpaa2_sg_entry *sg)
-{
-	return !!(le16_to_cpu(sg->format_offset) >> SG_FINAL_FLAG_SHIFT);
-}
-
-/**
- * dpaa2_sg_set_final() - Set the final bit in SG entry
- * @sg: the given scatter-gathering object
- * @final: the final boolean to be set
- */
-static inline void dpaa2_sg_set_final(struct dpaa2_sg_entry *sg, bool final)
-{
-	sg->format_offset &= cpu_to_le16((~(SG_FINAL_FLAG_MASK
-					 << SG_FINAL_FLAG_SHIFT)) & 0xFFFF);
-	sg->format_offset |= cpu_to_le16(final << SG_FINAL_FLAG_SHIFT);
-}
-
-#endif /* __FSL_DPAA2_FD_H */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-global.h b/drivers/staging/fsl-mc/include/dpaa2-global.h
deleted file mode 100644
index 9bc0713..0000000
--- a/drivers/staging/fsl-mc/include/dpaa2-global.h
+++ /dev/null
@@ -1,177 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright 2016 NXP
- *
- */
-#ifndef __FSL_DPAA2_GLOBAL_H
-#define __FSL_DPAA2_GLOBAL_H
-
-#include <linux/types.h>
-#include <linux/cpumask.h>
-#include "dpaa2-fd.h"
-
-struct dpaa2_dq {
-	union {
-		struct common {
-			u8 verb;
-			u8 reserved[63];
-		} common;
-		struct dq {
-			u8 verb;
-			u8 stat;
-			__le16 seqnum;
-			__le16 oprid;
-			u8 reserved;
-			u8 tok;
-			__le32 fqid;
-			u32 reserved2;
-			__le32 fq_byte_cnt;
-			__le32 fq_frm_cnt;
-			__le64 fqd_ctx;
-			u8 fd[32];
-		} dq;
-		struct scn {
-			u8 verb;
-			u8 stat;
-			u8 state;
-			u8 reserved;
-			__le32 rid_tok;
-			__le64 ctx;
-		} scn;
-	};
-};
-
-/* Parsing frame dequeue results */
-/* FQ empty */
-#define DPAA2_DQ_STAT_FQEMPTY       0x80
-/* FQ held active */
-#define DPAA2_DQ_STAT_HELDACTIVE    0x40
-/* FQ force eligible */
-#define DPAA2_DQ_STAT_FORCEELIGIBLE 0x20
-/* valid frame */
-#define DPAA2_DQ_STAT_VALIDFRAME    0x10
-/* FQ ODP enable */
-#define DPAA2_DQ_STAT_ODPVALID      0x04
-/* volatile dequeue */
-#define DPAA2_DQ_STAT_VOLATILE      0x02
-/* volatile dequeue command is expired */
-#define DPAA2_DQ_STAT_EXPIRED       0x01
-
-#define DQ_FQID_MASK		0x00FFFFFF
-#define DQ_FRAME_COUNT_MASK	0x00FFFFFF
-
-/**
- * dpaa2_dq_flags() - Get the stat field of dequeue response
- * @dq: the dequeue result.
- */
-static inline u32 dpaa2_dq_flags(const struct dpaa2_dq *dq)
-{
-	return dq->dq.stat;
-}
-
-/**
- * dpaa2_dq_is_pull() - Check whether the dq response is from a pull
- *                      command.
- * @dq: the dequeue result
- *
- * Return 1 for volatile(pull) dequeue, 0 for static dequeue.
- */
-static inline int dpaa2_dq_is_pull(const struct dpaa2_dq *dq)
-{
-	return (int)(dpaa2_dq_flags(dq) & DPAA2_DQ_STAT_VOLATILE);
-}
-
-/**
- * dpaa2_dq_is_pull_complete() - Check whether the pull command is completed.
- * @dq: the dequeue result
- *
- * Return boolean.
- */
-static inline bool dpaa2_dq_is_pull_complete(const struct dpaa2_dq *dq)
-{
-	return !!(dpaa2_dq_flags(dq) & DPAA2_DQ_STAT_EXPIRED);
-}
-
-/**
- * dpaa2_dq_seqnum() - Get the seqnum field in dequeue response
- * @dq: the dequeue result
- *
- * seqnum is valid only if VALIDFRAME flag is TRUE
- *
- * Return seqnum.
- */
-static inline u16 dpaa2_dq_seqnum(const struct dpaa2_dq *dq)
-{
-	return le16_to_cpu(dq->dq.seqnum);
-}
-
-/**
- * dpaa2_dq_odpid() - Get the odpid field in dequeue response
- * @dq: the dequeue result
- *
- * odpid is valid only if ODPVALID flag is TRUE.
- *
- * Return odpid.
- */
-static inline u16 dpaa2_dq_odpid(const struct dpaa2_dq *dq)
-{
-	return le16_to_cpu(dq->dq.oprid);
-}
-
-/**
- * dpaa2_dq_fqid() - Get the fqid in dequeue response
- * @dq: the dequeue result
- *
- * Return fqid.
- */
-static inline u32 dpaa2_dq_fqid(const struct dpaa2_dq *dq)
-{
-	return le32_to_cpu(dq->dq.fqid) & DQ_FQID_MASK;
-}
-
-/**
- * dpaa2_dq_byte_count() - Get the byte count in dequeue response
- * @dq: the dequeue result
- *
- * Return the byte count remaining in the FQ.
- */
-static inline u32 dpaa2_dq_byte_count(const struct dpaa2_dq *dq)
-{
-	return le32_to_cpu(dq->dq.fq_byte_cnt);
-}
-
-/**
- * dpaa2_dq_frame_count() - Get the frame count in dequeue response
- * @dq: the dequeue result
- *
- * Return the frame count remaining in the FQ.
- */
-static inline u32 dpaa2_dq_frame_count(const struct dpaa2_dq *dq)
-{
-	return le32_to_cpu(dq->dq.fq_frm_cnt) & DQ_FRAME_COUNT_MASK;
-}
-
-/**
- * dpaa2_dq_fd_ctx() - Get the frame queue context in dequeue response
- * @dq: the dequeue result
- *
- * Return the frame queue context.
- */
-static inline u64 dpaa2_dq_fqd_ctx(const struct dpaa2_dq *dq)
-{
-	return le64_to_cpu(dq->dq.fqd_ctx);
-}
-
-/**
- * dpaa2_dq_fd() - Get the frame descriptor in dequeue response
- * @dq: the dequeue result
- *
- * Return the frame descriptor.
- */
-static inline const struct dpaa2_fd *dpaa2_dq_fd(const struct dpaa2_dq *dq)
-{
-	return (const struct dpaa2_fd *)&dq->dq.fd[0];
-}
-
-#endif /* __FSL_DPAA2_GLOBAL_H */
diff --git a/drivers/staging/fsl-mc/include/dpaa2-io.h b/drivers/staging/fsl-mc/include/dpaa2-io.h
deleted file mode 100644
index f71227d..0000000
--- a/drivers/staging/fsl-mc/include/dpaa2-io.h
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
-/*
- * Copyright 2014-2016 Freescale Semiconductor Inc.
- * Copyright NXP
- *
- */
-#ifndef __FSL_DPAA2_IO_H
-#define __FSL_DPAA2_IO_H
-
-#include <linux/types.h>
-#include <linux/cpumask.h>
-#include <linux/irqreturn.h>
-
-#include "dpaa2-fd.h"
-#include "dpaa2-global.h"
-
-struct dpaa2_io;
-struct dpaa2_io_store;
-struct device;
-
-/**
- * DOC: DPIO Service
- *
- * The DPIO service provides APIs for users to interact with the datapath
- * by enqueueing and dequeing frame descriptors.
- *
- * The following set of APIs can be used to enqueue and dequeue frames
- * as well as producing notification callbacks when data is available
- * for dequeue.
- */
-
-#define DPAA2_IO_ANY_CPU	-1
-
-/**
- * struct dpaa2_io_desc - The DPIO descriptor
- * @receives_notifications: Use notificaton mode. Non-zero if the DPIO
- *                  has a channel.
- * @has_8prio:      Set to non-zero for channel with 8 priority WQs.  Ignored
- *                  unless receives_notification is TRUE.
- * @cpu:            The cpu index that at least interrupt handlers will
- *                  execute on.
- * @stash_affinity: The stash affinity for this portal favour 'cpu'
- * @regs_cena:      The cache enabled regs.
- * @regs_cinh:      The cache inhibited regs
- * @dpio_id:        The dpio index
- * @qman_version:   The qman version
- *
- * Describes the attributes and features of the DPIO object.
- */
-struct dpaa2_io_desc {
-	int receives_notifications;
-	int has_8prio;
-	int cpu;
-	void *regs_cena;
-	void *regs_cinh;
-	int dpio_id;
-	u32 qman_version;
-};
-
-struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc);
-
-void dpaa2_io_down(struct dpaa2_io *d);
-
-irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj);
-
-struct dpaa2_io *dpaa2_io_service_select(int cpu);
-
-/**
- * struct dpaa2_io_notification_ctx - The DPIO notification context structure
- * @cb:           The callback to be invoked when the notification arrives
- * @is_cdan:      Zero for FQDAN, non-zero for CDAN
- * @id:           FQID or channel ID, needed for rearm
- * @desired_cpu:  The cpu on which the notifications will show up. Use
- *                DPAA2_IO_ANY_CPU if don't care
- * @dpio_id:      The dpio index
- * @qman64:       The 64-bit context value shows up in the FQDAN/CDAN.
- * @node:         The list node
- * @dpio_private: The dpio object internal to dpio_service
- *
- * Used when a FQDAN/CDAN registration is made by drivers.
- */
-struct dpaa2_io_notification_ctx {
-	void (*cb)(struct dpaa2_io_notification_ctx *ctx);
-	int is_cdan;
-	u32 id;
-	int desired_cpu;
-	int dpio_id;
-	u64 qman64;
-	struct list_head node;
-	void *dpio_private;
-};
-
-int dpaa2_io_service_register(struct dpaa2_io *service,
-			      struct dpaa2_io_notification_ctx *ctx);
-void dpaa2_io_service_deregister(struct dpaa2_io *service,
-				 struct dpaa2_io_notification_ctx *ctx);
-int dpaa2_io_service_rearm(struct dpaa2_io *service,
-			   struct dpaa2_io_notification_ctx *ctx);
-
-int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
-				  struct dpaa2_io_store *s);
-
-int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d, u32 qdid, u8 prio,
-				u16 qdbin, const struct dpaa2_fd *fd);
-int dpaa2_io_service_release(struct dpaa2_io *d, u32 bpid,
-			     const u64 *buffers, unsigned int num_buffers);
-int dpaa2_io_service_acquire(struct dpaa2_io *d, u32 bpid,
-			     u64 *buffers, unsigned int num_buffers);
-
-struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
-					     struct device *dev);
-void dpaa2_io_store_destroy(struct dpaa2_io_store *s);
-struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_store *s, int *is_last);
-
-#endif /* __FSL_DPAA2_IO_H */
diff --git a/include/soc/fsl/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
new file mode 100644
index 0000000..b55b89b
--- /dev/null
+++ b/include/soc/fsl/dpaa2-fd.h
@@ -0,0 +1,426 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#ifndef __FSL_DPAA2_FD_H
+#define __FSL_DPAA2_FD_H
+
+#include <linux/kernel.h>
+
+/**
+ * DOC: DPAA2 FD - Frame Descriptor APIs for DPAA2
+ *
+ * Frame Descriptors (FDs) are used to describe frame data in the DPAA2.
+ * Frames can be enqueued and dequeued to Frame Queues (FQs) which are consumed
+ * by the various DPAA accelerators (WRIOP, SEC, PME, DCE)
+ *
+ * There are three types of frames: single, scatter gather, and frame lists.
+ *
+ * The set of APIs in this file must be used to create, manipulate and
+ * query Frame Descriptors.
+ */
+
+/**
+ * struct dpaa2_fd - Struct describing FDs
+ * @words:         for easier/faster copying the whole FD structure
+ * @addr:          address in the FD
+ * @len:           length in the FD
+ * @bpid:          buffer pool ID
+ * @format_offset: format, offset, and short-length fields
+ * @frc:           frame context
+ * @ctrl:          control bits...including dd, sc, va, err, etc
+ * @flc:           flow context address
+ *
+ * This structure represents the basic Frame Descriptor used in the system.
+ */
+struct dpaa2_fd {
+	union {
+		u32 words[8];
+		struct dpaa2_fd_simple {
+			__le64 addr;
+			__le32 len;
+			__le16 bpid;
+			__le16 format_offset;
+			__le32 frc;
+			__le32 ctrl;
+			__le64 flc;
+		} simple;
+	};
+};
+
+#define FD_SHORT_LEN_FLAG_MASK	0x1
+#define FD_SHORT_LEN_FLAG_SHIFT	14
+#define FD_SHORT_LEN_MASK	0x3FFFF
+#define FD_OFFSET_MASK		0x0FFF
+#define FD_FORMAT_MASK		0x3
+#define FD_FORMAT_SHIFT		12
+#define FD_BPID_MASK		0x3FFF
+#define SG_SHORT_LEN_FLAG_MASK	0x1
+#define SG_SHORT_LEN_FLAG_SHIFT	14
+#define SG_SHORT_LEN_MASK	0x1FFFF
+#define SG_OFFSET_MASK		0x0FFF
+#define SG_FORMAT_MASK		0x3
+#define SG_FORMAT_SHIFT		12
+#define SG_BPID_MASK		0x3FFF
+#define SG_FINAL_FLAG_MASK	0x1
+#define SG_FINAL_FLAG_SHIFT	15
+
+enum dpaa2_fd_format {
+	dpaa2_fd_single = 0,
+	dpaa2_fd_list,
+	dpaa2_fd_sg
+};
+
+/**
+ * dpaa2_fd_get_addr() - get the addr field of frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the address in the frame descriptor.
+ */
+static inline dma_addr_t dpaa2_fd_get_addr(const struct dpaa2_fd *fd)
+{
+	return (dma_addr_t)le64_to_cpu(fd->simple.addr);
+}
+
+/**
+ * dpaa2_fd_set_addr() - Set the addr field of frame descriptor
+ * @fd: the given frame descriptor
+ * @addr: the address needs to be set in frame descriptor
+ */
+static inline void dpaa2_fd_set_addr(struct dpaa2_fd *fd, dma_addr_t addr)
+{
+	fd->simple.addr = cpu_to_le64(addr);
+}
+
+/**
+ * dpaa2_fd_get_frc() - Get the frame context in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the frame context field in the frame descriptor.
+ */
+static inline u32 dpaa2_fd_get_frc(const struct dpaa2_fd *fd)
+{
+	return le32_to_cpu(fd->simple.frc);
+}
+
+/**
+ * dpaa2_fd_set_frc() - Set the frame context in the frame descriptor
+ * @fd: the given frame descriptor
+ * @frc: the frame context needs to be set in frame descriptor
+ */
+static inline void dpaa2_fd_set_frc(struct dpaa2_fd *fd, u32 frc)
+{
+	fd->simple.frc = cpu_to_le32(frc);
+}
+
+/**
+ * dpaa2_fd_get_ctrl() - Get the control bits in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the control bits field in the frame descriptor.
+ */
+static inline u32 dpaa2_fd_get_ctrl(const struct dpaa2_fd *fd)
+{
+	return le32_to_cpu(fd->simple.ctrl);
+}
+
+/**
+ * dpaa2_fd_set_ctrl() - Set the control bits in the frame descriptor
+ * @fd: the given frame descriptor
+ * @ctrl: the control bits to be set in the frame descriptor
+ */
+static inline void dpaa2_fd_set_ctrl(struct dpaa2_fd *fd, u32 ctrl)
+{
+	fd->simple.ctrl = cpu_to_le32(ctrl);
+}
+
+/**
+ * dpaa2_fd_get_flc() - Get the flow context in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the flow context in the frame descriptor.
+ */
+static inline dma_addr_t dpaa2_fd_get_flc(const struct dpaa2_fd *fd)
+{
+	return (dma_addr_t)le64_to_cpu(fd->simple.flc);
+}
+
+/**
+ * dpaa2_fd_set_flc() - Set the flow context field of frame descriptor
+ * @fd: the given frame descriptor
+ * @flc_addr: the flow context needs to be set in frame descriptor
+ */
+static inline void dpaa2_fd_set_flc(struct dpaa2_fd *fd,  dma_addr_t flc_addr)
+{
+	fd->simple.flc = cpu_to_le64(flc_addr);
+}
+
+static inline bool dpaa2_fd_short_len(const struct dpaa2_fd *fd)
+{
+	return !!((le16_to_cpu(fd->simple.format_offset) >>
+		  FD_SHORT_LEN_FLAG_SHIFT) & FD_SHORT_LEN_FLAG_MASK);
+}
+
+/**
+ * dpaa2_fd_get_len() - Get the length in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the length field in the frame descriptor.
+ */
+static inline u32 dpaa2_fd_get_len(const struct dpaa2_fd *fd)
+{
+	if (dpaa2_fd_short_len(fd))
+		return le32_to_cpu(fd->simple.len) & FD_SHORT_LEN_MASK;
+
+	return le32_to_cpu(fd->simple.len);
+}
+
+/**
+ * dpaa2_fd_set_len() - Set the length field of frame descriptor
+ * @fd: the given frame descriptor
+ * @len: the length needs to be set in frame descriptor
+ */
+static inline void dpaa2_fd_set_len(struct dpaa2_fd *fd, u32 len)
+{
+	fd->simple.len = cpu_to_le32(len);
+}
+
+/**
+ * dpaa2_fd_get_offset() - Get the offset field in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the offset.
+ */
+static inline uint16_t dpaa2_fd_get_offset(const struct dpaa2_fd *fd)
+{
+	return le16_to_cpu(fd->simple.format_offset) & FD_OFFSET_MASK;
+}
+
+/**
+ * dpaa2_fd_set_offset() - Set the offset field of frame descriptor
+ * @fd: the given frame descriptor
+ * @offset: the offset needs to be set in frame descriptor
+ */
+static inline void dpaa2_fd_set_offset(struct dpaa2_fd *fd, uint16_t offset)
+{
+	fd->simple.format_offset &= cpu_to_le16(~FD_OFFSET_MASK);
+	fd->simple.format_offset |= cpu_to_le16(offset);
+}
+
+/**
+ * dpaa2_fd_get_format() - Get the format field in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the format.
+ */
+static inline enum dpaa2_fd_format dpaa2_fd_get_format(
+						const struct dpaa2_fd *fd)
+{
+	return (enum dpaa2_fd_format)((le16_to_cpu(fd->simple.format_offset)
+				      >> FD_FORMAT_SHIFT) & FD_FORMAT_MASK);
+}
+
+/**
+ * dpaa2_fd_set_format() - Set the format field of frame descriptor
+ * @fd: the given frame descriptor
+ * @format: the format needs to be set in frame descriptor
+ */
+static inline void dpaa2_fd_set_format(struct dpaa2_fd *fd,
+				       enum dpaa2_fd_format format)
+{
+	fd->simple.format_offset &=
+		cpu_to_le16(~(FD_FORMAT_MASK << FD_FORMAT_SHIFT));
+	fd->simple.format_offset |= cpu_to_le16(format << FD_FORMAT_SHIFT);
+}
+
+/**
+ * dpaa2_fd_get_bpid() - Get the bpid field in the frame descriptor
+ * @fd: the given frame descriptor
+ *
+ * Return the buffer pool id.
+ */
+static inline uint16_t dpaa2_fd_get_bpid(const struct dpaa2_fd *fd)
+{
+	return le16_to_cpu(fd->simple.bpid) & FD_BPID_MASK;
+}
+
+/**
+ * dpaa2_fd_set_bpid() - Set the bpid field of frame descriptor
+ * @fd: the given frame descriptor
+ * @bpid: buffer pool id to be set
+ */
+static inline void dpaa2_fd_set_bpid(struct dpaa2_fd *fd, uint16_t bpid)
+{
+	fd->simple.bpid &= cpu_to_le16(~(FD_BPID_MASK));
+	fd->simple.bpid |= cpu_to_le16(bpid);
+}
+
+/**
+ * struct dpaa2_sg_entry - the scatter-gathering structure
+ * @addr: address of the sg entry
+ * @len: length in this sg entry
+ * @bpid: buffer pool id
+ * @format_offset: format and offset fields
+ */
+struct dpaa2_sg_entry {
+	__le64 addr;
+	__le32 len;
+	__le16 bpid;
+	__le16 format_offset;
+};
+
+enum dpaa2_sg_format {
+	dpaa2_sg_single = 0,
+	dpaa2_sg_frame_data,
+	dpaa2_sg_sgt_ext
+};
+
+/* Accessors for SG entry fields */
+
+/**
+ * dpaa2_sg_get_addr() - Get the address from SG entry
+ * @sg: the given scatter-gathering object
+ *
+ * Return the address.
+ */
+static inline dma_addr_t dpaa2_sg_get_addr(const struct dpaa2_sg_entry *sg)
+{
+	return (dma_addr_t)le64_to_cpu(sg->addr);
+}
+
+/**
+ * dpaa2_sg_set_addr() - Set the address in SG entry
+ * @sg: the given scatter-gathering object
+ * @addr: the address to be set
+ */
+static inline void dpaa2_sg_set_addr(struct dpaa2_sg_entry *sg, dma_addr_t addr)
+{
+	sg->addr = cpu_to_le64(addr);
+}
+
+static inline bool dpaa2_sg_short_len(const struct dpaa2_sg_entry *sg)
+{
+	return !!((le16_to_cpu(sg->format_offset) >> SG_SHORT_LEN_FLAG_SHIFT)
+		& SG_SHORT_LEN_FLAG_MASK);
+}
+
+/**
+ * dpaa2_sg_get_len() - Get the length in SG entry
+ * @sg: the given scatter-gathering object
+ *
+ * Return the length.
+ */
+static inline u32 dpaa2_sg_get_len(const struct dpaa2_sg_entry *sg)
+{
+	if (dpaa2_sg_short_len(sg))
+		return le32_to_cpu(sg->len) & SG_SHORT_LEN_MASK;
+
+	return le32_to_cpu(sg->len);
+}
+
+/**
+ * dpaa2_sg_set_len() - Set the length in SG entry
+ * @sg: the given scatter-gathering object
+ * @len: the length to be set
+ */
+static inline void dpaa2_sg_set_len(struct dpaa2_sg_entry *sg, u32 len)
+{
+	sg->len = cpu_to_le32(len);
+}
+
+/**
+ * dpaa2_sg_get_offset() - Get the offset in SG entry
+ * @sg: the given scatter-gathering object
+ *
+ * Return the offset.
+ */
+static inline u16 dpaa2_sg_get_offset(const struct dpaa2_sg_entry *sg)
+{
+	return le16_to_cpu(sg->format_offset) & SG_OFFSET_MASK;
+}
+
+/**
+ * dpaa2_sg_set_offset() - Set the offset in SG entry
+ * @sg: the given scatter-gathering object
+ * @offset: the offset to be set
+ */
+static inline void dpaa2_sg_set_offset(struct dpaa2_sg_entry *sg,
+				       u16 offset)
+{
+	sg->format_offset &= cpu_to_le16(~SG_OFFSET_MASK);
+	sg->format_offset |= cpu_to_le16(offset);
+}
+
+/**
+ * dpaa2_sg_get_format() - Get the SG format in SG entry
+ * @sg: the given scatter-gathering object
+ *
+ * Return the format.
+ */
+static inline enum dpaa2_sg_format
+	dpaa2_sg_get_format(const struct dpaa2_sg_entry *sg)
+{
+	return (enum dpaa2_sg_format)((le16_to_cpu(sg->format_offset)
+				       >> SG_FORMAT_SHIFT) & SG_FORMAT_MASK);
+}
+
+/**
+ * dpaa2_sg_set_format() - Set the SG format in SG entry
+ * @sg: the given scatter-gathering object
+ * @format: the format to be set
+ */
+static inline void dpaa2_sg_set_format(struct dpaa2_sg_entry *sg,
+				       enum dpaa2_sg_format format)
+{
+	sg->format_offset &= cpu_to_le16(~(SG_FORMAT_MASK << SG_FORMAT_SHIFT));
+	sg->format_offset |= cpu_to_le16(format << SG_FORMAT_SHIFT);
+}
+
+/**
+ * dpaa2_sg_get_bpid() - Get the buffer pool id in SG entry
+ * @sg: the given scatter-gathering object
+ *
+ * Return the bpid.
+ */
+static inline u16 dpaa2_sg_get_bpid(const struct dpaa2_sg_entry *sg)
+{
+	return le16_to_cpu(sg->bpid) & SG_BPID_MASK;
+}
+
+/**
+ * dpaa2_sg_set_bpid() - Set the buffer pool id in SG entry
+ * @sg: the given scatter-gathering object
+ * @bpid: the bpid to be set
+ */
+static inline void dpaa2_sg_set_bpid(struct dpaa2_sg_entry *sg, u16 bpid)
+{
+	sg->bpid &= cpu_to_le16(~(SG_BPID_MASK));
+	sg->bpid |= cpu_to_le16(bpid);
+}
+
+/**
+ * dpaa2_sg_is_final() - Check final bit in SG entry
+ * @sg: the given scatter-gathering object
+ *
+ * Return bool.
+ */
+static inline bool dpaa2_sg_is_final(const struct dpaa2_sg_entry *sg)
+{
+	return !!(le16_to_cpu(sg->format_offset) >> SG_FINAL_FLAG_SHIFT);
+}
+
+/**
+ * dpaa2_sg_set_final() - Set the final bit in SG entry
+ * @sg: the given scatter-gathering object
+ * @final: the final boolean to be set
+ */
+static inline void dpaa2_sg_set_final(struct dpaa2_sg_entry *sg, bool final)
+{
+	sg->format_offset &= cpu_to_le16((~(SG_FINAL_FLAG_MASK
+					 << SG_FINAL_FLAG_SHIFT)) & 0xFFFF);
+	sg->format_offset |= cpu_to_le16(final << SG_FINAL_FLAG_SHIFT);
+}
+
+#endif /* __FSL_DPAA2_FD_H */
diff --git a/include/soc/fsl/dpaa2-global.h b/include/soc/fsl/dpaa2-global.h
new file mode 100644
index 0000000..9bc0713
--- /dev/null
+++ b/include/soc/fsl/dpaa2-global.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright 2016 NXP
+ *
+ */
+#ifndef __FSL_DPAA2_GLOBAL_H
+#define __FSL_DPAA2_GLOBAL_H
+
+#include <linux/types.h>
+#include <linux/cpumask.h>
+#include "dpaa2-fd.h"
+
+struct dpaa2_dq {
+	union {
+		struct common {
+			u8 verb;
+			u8 reserved[63];
+		} common;
+		struct dq {
+			u8 verb;
+			u8 stat;
+			__le16 seqnum;
+			__le16 oprid;
+			u8 reserved;
+			u8 tok;
+			__le32 fqid;
+			u32 reserved2;
+			__le32 fq_byte_cnt;
+			__le32 fq_frm_cnt;
+			__le64 fqd_ctx;
+			u8 fd[32];
+		} dq;
+		struct scn {
+			u8 verb;
+			u8 stat;
+			u8 state;
+			u8 reserved;
+			__le32 rid_tok;
+			__le64 ctx;
+		} scn;
+	};
+};
+
+/* Parsing frame dequeue results */
+/* FQ empty */
+#define DPAA2_DQ_STAT_FQEMPTY       0x80
+/* FQ held active */
+#define DPAA2_DQ_STAT_HELDACTIVE    0x40
+/* FQ force eligible */
+#define DPAA2_DQ_STAT_FORCEELIGIBLE 0x20
+/* valid frame */
+#define DPAA2_DQ_STAT_VALIDFRAME    0x10
+/* FQ ODP enable */
+#define DPAA2_DQ_STAT_ODPVALID      0x04
+/* volatile dequeue */
+#define DPAA2_DQ_STAT_VOLATILE      0x02
+/* volatile dequeue command is expired */
+#define DPAA2_DQ_STAT_EXPIRED       0x01
+
+#define DQ_FQID_MASK		0x00FFFFFF
+#define DQ_FRAME_COUNT_MASK	0x00FFFFFF
+
+/**
+ * dpaa2_dq_flags() - Get the stat field of dequeue response
+ * @dq: the dequeue result.
+ */
+static inline u32 dpaa2_dq_flags(const struct dpaa2_dq *dq)
+{
+	return dq->dq.stat;
+}
+
+/**
+ * dpaa2_dq_is_pull() - Check whether the dq response is from a pull
+ *                      command.
+ * @dq: the dequeue result
+ *
+ * Return 1 for volatile(pull) dequeue, 0 for static dequeue.
+ */
+static inline int dpaa2_dq_is_pull(const struct dpaa2_dq *dq)
+{
+	return (int)(dpaa2_dq_flags(dq) & DPAA2_DQ_STAT_VOLATILE);
+}
+
+/**
+ * dpaa2_dq_is_pull_complete() - Check whether the pull command is completed.
+ * @dq: the dequeue result
+ *
+ * Return boolean.
+ */
+static inline bool dpaa2_dq_is_pull_complete(const struct dpaa2_dq *dq)
+{
+	return !!(dpaa2_dq_flags(dq) & DPAA2_DQ_STAT_EXPIRED);
+}
+
+/**
+ * dpaa2_dq_seqnum() - Get the seqnum field in dequeue response
+ * @dq: the dequeue result
+ *
+ * seqnum is valid only if VALIDFRAME flag is TRUE
+ *
+ * Return seqnum.
+ */
+static inline u16 dpaa2_dq_seqnum(const struct dpaa2_dq *dq)
+{
+	return le16_to_cpu(dq->dq.seqnum);
+}
+
+/**
+ * dpaa2_dq_odpid() - Get the odpid field in dequeue response
+ * @dq: the dequeue result
+ *
+ * odpid is valid only if ODPVALID flag is TRUE.
+ *
+ * Return odpid.
+ */
+static inline u16 dpaa2_dq_odpid(const struct dpaa2_dq *dq)
+{
+	return le16_to_cpu(dq->dq.oprid);
+}
+
+/**
+ * dpaa2_dq_fqid() - Get the fqid in dequeue response
+ * @dq: the dequeue result
+ *
+ * Return fqid.
+ */
+static inline u32 dpaa2_dq_fqid(const struct dpaa2_dq *dq)
+{
+	return le32_to_cpu(dq->dq.fqid) & DQ_FQID_MASK;
+}
+
+/**
+ * dpaa2_dq_byte_count() - Get the byte count in dequeue response
+ * @dq: the dequeue result
+ *
+ * Return the byte count remaining in the FQ.
+ */
+static inline u32 dpaa2_dq_byte_count(const struct dpaa2_dq *dq)
+{
+	return le32_to_cpu(dq->dq.fq_byte_cnt);
+}
+
+/**
+ * dpaa2_dq_frame_count() - Get the frame count in dequeue response
+ * @dq: the dequeue result
+ *
+ * Return the frame count remaining in the FQ.
+ */
+static inline u32 dpaa2_dq_frame_count(const struct dpaa2_dq *dq)
+{
+	return le32_to_cpu(dq->dq.fq_frm_cnt) & DQ_FRAME_COUNT_MASK;
+}
+
+/**
+ * dpaa2_dq_fd_ctx() - Get the frame queue context in dequeue response
+ * @dq: the dequeue result
+ *
+ * Return the frame queue context.
+ */
+static inline u64 dpaa2_dq_fqd_ctx(const struct dpaa2_dq *dq)
+{
+	return le64_to_cpu(dq->dq.fqd_ctx);
+}
+
+/**
+ * dpaa2_dq_fd() - Get the frame descriptor in dequeue response
+ * @dq: the dequeue result
+ *
+ * Return the frame descriptor.
+ */
+static inline const struct dpaa2_fd *dpaa2_dq_fd(const struct dpaa2_dq *dq)
+{
+	return (const struct dpaa2_fd *)&dq->dq.fd[0];
+}
+
+#endif /* __FSL_DPAA2_GLOBAL_H */
diff --git a/include/soc/fsl/dpaa2-io.h b/include/soc/fsl/dpaa2-io.h
new file mode 100644
index 0000000..f71227d
--- /dev/null
+++ b/include/soc/fsl/dpaa2-io.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/*
+ * Copyright 2014-2016 Freescale Semiconductor Inc.
+ * Copyright NXP
+ *
+ */
+#ifndef __FSL_DPAA2_IO_H
+#define __FSL_DPAA2_IO_H
+
+#include <linux/types.h>
+#include <linux/cpumask.h>
+#include <linux/irqreturn.h>
+
+#include "dpaa2-fd.h"
+#include "dpaa2-global.h"
+
+struct dpaa2_io;
+struct dpaa2_io_store;
+struct device;
+
+/**
+ * DOC: DPIO Service
+ *
+ * The DPIO service provides APIs for users to interact with the datapath
+ * by enqueueing and dequeing frame descriptors.
+ *
+ * The following set of APIs can be used to enqueue and dequeue frames
+ * as well as producing notification callbacks when data is available
+ * for dequeue.
+ */
+
+#define DPAA2_IO_ANY_CPU	-1
+
+/**
+ * struct dpaa2_io_desc - The DPIO descriptor
+ * @receives_notifications: Use notificaton mode. Non-zero if the DPIO
+ *                  has a channel.
+ * @has_8prio:      Set to non-zero for channel with 8 priority WQs.  Ignored
+ *                  unless receives_notification is TRUE.
+ * @cpu:            The cpu index that at least interrupt handlers will
+ *                  execute on.
+ * @stash_affinity: The stash affinity for this portal favour 'cpu'
+ * @regs_cena:      The cache enabled regs.
+ * @regs_cinh:      The cache inhibited regs
+ * @dpio_id:        The dpio index
+ * @qman_version:   The qman version
+ *
+ * Describes the attributes and features of the DPIO object.
+ */
+struct dpaa2_io_desc {
+	int receives_notifications;
+	int has_8prio;
+	int cpu;
+	void *regs_cena;
+	void *regs_cinh;
+	int dpio_id;
+	u32 qman_version;
+};
+
+struct dpaa2_io *dpaa2_io_create(const struct dpaa2_io_desc *desc);
+
+void dpaa2_io_down(struct dpaa2_io *d);
+
+irqreturn_t dpaa2_io_irq(struct dpaa2_io *obj);
+
+struct dpaa2_io *dpaa2_io_service_select(int cpu);
+
+/**
+ * struct dpaa2_io_notification_ctx - The DPIO notification context structure
+ * @cb:           The callback to be invoked when the notification arrives
+ * @is_cdan:      Zero for FQDAN, non-zero for CDAN
+ * @id:           FQID or channel ID, needed for rearm
+ * @desired_cpu:  The cpu on which the notifications will show up. Use
+ *                DPAA2_IO_ANY_CPU if don't care
+ * @dpio_id:      The dpio index
+ * @qman64:       The 64-bit context value shows up in the FQDAN/CDAN.
+ * @node:         The list node
+ * @dpio_private: The dpio object internal to dpio_service
+ *
+ * Used when a FQDAN/CDAN registration is made by drivers.
+ */
+struct dpaa2_io_notification_ctx {
+	void (*cb)(struct dpaa2_io_notification_ctx *ctx);
+	int is_cdan;
+	u32 id;
+	int desired_cpu;
+	int dpio_id;
+	u64 qman64;
+	struct list_head node;
+	void *dpio_private;
+};
+
+int dpaa2_io_service_register(struct dpaa2_io *service,
+			      struct dpaa2_io_notification_ctx *ctx);
+void dpaa2_io_service_deregister(struct dpaa2_io *service,
+				 struct dpaa2_io_notification_ctx *ctx);
+int dpaa2_io_service_rearm(struct dpaa2_io *service,
+			   struct dpaa2_io_notification_ctx *ctx);
+
+int dpaa2_io_service_pull_channel(struct dpaa2_io *d, u32 channelid,
+				  struct dpaa2_io_store *s);
+
+int dpaa2_io_service_enqueue_qd(struct dpaa2_io *d, u32 qdid, u8 prio,
+				u16 qdbin, const struct dpaa2_fd *fd);
+int dpaa2_io_service_release(struct dpaa2_io *d, u32 bpid,
+			     const u64 *buffers, unsigned int num_buffers);
+int dpaa2_io_service_acquire(struct dpaa2_io *d, u32 bpid,
+			     u64 *buffers, unsigned int num_buffers);
+
+struct dpaa2_io_store *dpaa2_io_store_create(unsigned int max_frames,
+					     struct device *dev);
+void dpaa2_io_store_destroy(struct dpaa2_io_store *s);
+struct dpaa2_dq *dpaa2_io_store_next(struct dpaa2_io_store *s, int *is_last);
+
+#endif /* __FSL_DPAA2_IO_H */
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
