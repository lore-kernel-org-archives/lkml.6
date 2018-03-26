Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1702535-1522091185-2-12502228387164335195
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
    t=1522091184; b=DIIvJI5vkvxZVptOqapkyRUswNdKoJGBgNgDYHKWx0VLDkr
    3s8WI6NYSyQcGaq4cTv3avYZrRzcMY/ZaVey7DGgNdjPoFUU2H0UnBKNcFeUSMYh
    OjUkcLCccQz8nCcr0i5Uv3QX/yHJzVnQoGxEXbrvuYnpXKQiqnJwH2O6a1aIy9ob
    rvQWM1USU8tvDrJzF3XCb2sgAybiw7lia/SSHhd5TDdiF3hWRvd1zw9gfAO5fY9p
    6NzRmALA0REJvTsTSqkZMF4hPBKTCbnkytfW+TYd/i6XbHz6FIpYqpugor6CtyPH
    Zkb7LTB6kbKK1M7g+fuC/eNnqR1ae5xFgW1Qq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522091184; bh=G+Spvp74v78fpO7zvLhCdMc/QGsr4kvy50un/uX9jm0=; b=e
    qlZZ9F2mEpxUK2f3zQQrCjciU7wwv+zti5hvj2O6ZL7suzdrhijiPx+lnmRozbo2
    Wprgv2P2J2cXb4oroPexV5imgoFR7v3R58TsVRdC+ZXIz9sNIoB+9H5NPRMWdY0s
    tQTXfevOg3qgrfpPDIuClhw0tfLTZTCtdEn4IJrHilppkoSXw8Dad1eHsUZR3N3j
    IZaN1/9/MBnrPpuJLdH/f78bwSlo+//iHcP+yzVEtXYElMFqlOzOTnSRwtuubSuP
    tFuJQSe/AbPMflBMFP3NF1ewXAX1UtkTjyBXj0JzceJT1W6DSyGZs+s/TmXPmX8q
    ch0BYsWqDov+mhqwqljmw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=vgyKdu7L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=vgyKdu7L x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
X-CM-Envelope: MS4wfLl2ed5yMeb6lq7MoN7e/3ChWQLGOlz1mk8oJDz8LheNqbEWbez4l3QQfYWjR17psNYbcL6cEAKXarnCivsForxc3nS6pS1mM1Ov6a/YZlC8UmbdP1ff
    ySHvZFGjM5SXbxNg5A/L7uP6y9s12ZaJXTbwD/FgsEYZCZ7dl6KDkZ/6+I1FY56Q4GifOYyZSsbdJbQtX+lACqe2zbUZ01JSTEZLSmQftMsy1E1W5soUiVN4
    tJ79OR6eWEKqSX4Up0ndeA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=TRjyw0CnJloA:10 a=P4uAHAV8DOQA:10 a=JMP4OFuIcRoA:10 a=SJl39FfINJoA:10
    a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=U2NixeQyNuVAiBXHB4UA:9
    a=CjuIK1q_8ugA:10 a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=roy.pledge@nxp.com;
From: Roy Pledge <roy.pledge@nxp.com>
To: devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] drivers/staging: Remove fsl-mc driver from staging
Date: Mon, 26 Mar 2018 15:05:34 -0400
Message-Id: <1522091134-24646-5-git-send-email-roy.pledge@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ec5dc26-06fc-4e47-7e17-08d5934ca11d
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB2993;
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 3:HPMZk3pLwKfTXFK3g8E8z/sIjXz9xfrg2TEvPyN3fF69TRkofuqWUbunyfZ6KL78o2CBZ0MM78Nw6unkhqO4+5X0zaCWjSBFY8XGeHDOudbtfNvdu0M8rdLUDc/CcwdxK1zaxssaD4KQsBbPE+X6mlsBhs83SHDceS3PQTR1cJajeGwA7xbk+TsIIqw0Ko300OVBhXF6z5ds6mBkRLNF+odSZ6rTL+HspIsxjXerRBG/EPxUbxCXDOnsg+CrKE7G;
 25:K4Oe3AUDLqk4BDJ+gc+YtTHVT/38psr8E3O0vuJF2Czvyc+AAT6XbG9033z6WM+6MIju8xVWD98WY6ausL72SDprkRPpVSUrT2abFhvRoJRQ+E2obCSIsob1YWK+I0m9Pvb83FKZcu25lXiBgu3/Xx8WKJg9g6GTjMK0ydgKj+W1ZP/nhsHi2BK2n8jLahjM9gxr5fGD0H4tPpUboi1CwIsJYDsFSlJbf0kIAunKhSsMLZXPHrGWx7ei7VlZjLIw6MMeIC42BPXiQVSppJ8eS1eSG9tbfHTKOD5+/egDB1cxJ1ZKfaYRCcE7+1UcRNXjO547NIQpTQgaaHDzauSKyQ==;
 31:jajodTTG6mbkhcy4gRpAUCnt79PxXWK/Fb+ezg6YhPAZJ0DJQXejavqFkcBypcSHLSmcH2+5V+S4XFuFju/4+BI3NZlWK5F5IIj+FOAst8yPt/SCiQo53pPmubN8tiXHF2rNHi8Q2EomedDQX9RSujSrKiDrzA9Hpk8IjE7v1OHXQnsZ0yCuv7rV4uw81SNX9o2gC9pQMZ/K7155Ai3X34v68KuWhOHbenURnhzdPXE=
X-MS-TrafficTypeDiagnostic: AM5PR04MB2993:
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 20:H+eWeUD6cs9ruD5DRJ1Oz/ob3ANUOHT1neB9xTIEtscy5ydiI8VI+nDp1sW0PSSJs1GbRUyxlkSIgfCsz+UxYCDbdtW3Xme0Pu/OTOCUEG6tMnRu1AyMFENi+v/sXsWJ9UG7mrBCOKs9DesmPM2MbVnN7CzkzGaN6pEw2LhjLDvq1CKD9DAyBcQjIZpf+zWiTYBK8pc06mUwVvucRkg/HApSkCY/UsNYEyorWRLaIHq7L3ujC9dOf6hkMcyQG5A6e2oeLTRZrcJ8ytivNYH3Ql9QNyTmQe+8JF8pFJUpROjhb2RwiP9KwvPgd07CUxaAU5Wn+lMDh73/FtbfIPQW8Ch1oFSjHsgHfLsoLos8KPgo++FbKQKE4atcRqtIcDoIATLDN7XQdRbIUSCEMQb7ZbvHdML0U1dhDbXh1ja4jmm+gTjDpUl2N3hOgN1Lz1PAhVH/+yeKKlHOi1YCWKcI+wbqaMB28i4jF7Cz4nxktctAfvPgwLRYltRM/1b9KhT/;
 4:sc7AcvYKfj0WMy2M2ZEEjUcJ1xBljP3FvwgrYteT2lND0ZrQYAkPghwmn1KSgE8eMx0HQ32H/g5YUux/p1+ScVoReSKj3dyulXDLX3p0n8AloTGWMQA1CvPJNviKa1RdiP23jIVtenjCsSMxEbmDU8x+LYAETexB7K7WMufWs+AtFgoScwdy340OOQBpdTY/jE6WBOHDdUsEpAQqKFZXeskMs73bd5SMLJPF0XefnpMTHM4vdNLIsQtzl2KHafhwOdtisbtsoYXQK4yQLmzHtis4npqq0aJ3VXp9ZY8Pz0ZWn/my9jG6pmjgvoFgLi0M
X-Microsoft-Antispam-PRVS: <AM5PR04MB2993625E15D56CB9892BE0F186AD0@AM5PR04MB2993.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);
 SRVR:AM5PR04MB2993; BCL:0; PCL:0; RULEID:; SRVR:AM5PR04MB2993;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(396003)(346002)(189003)(199004)(106356001)(66066001)(478600001)(47776003)(6116002)(3846002)(2906002)(186003)(16526019)(26005)(68736007)(51416003)(59450400001)(76176011)(86362001)(575784001)(6666003)(36756003)(43066004)(25786009)(6506007)(305945005)(386003)(7736002)(316002)(50466002)(16586007)(105586002)(39060400002)(5660300001)(97736004)(6512007)(3450700001)(956004)(8936002)(8676002)(53936002)(2616005)(11346002)(446003)(4326008)(48376002)(6486002)(81156014)(81166006)(52116002)(50226002)(476003)(486005)(486005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB2993; H:otc-sw1.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM5PR04MB2993;
 23:uWoHIwEF/8bSyzOb9OvwVS3e2FwOSXrwCu5QC/wcI?=
 =?us-ascii?Q?EyyUMoF0MJI0COG4+jqOpRSydJXazY3wwlSlT23Nl1LkAvMpeGuItzXlXBP1?=
 =?us-ascii?Q?Xu8Sp5bZm8L6vpRt7GKCsdxLSTNLfqs49flJt2+kScP5njp7ehb1gsKgIKie?=
 =?us-ascii?Q?TOFZ3AmL2tCrjZABW/VrCvpQoCPfQjof2ihLCON2kho6UCCj3NyC8GmcovAW?=
 =?us-ascii?Q?/jRBQYUYmhMLuEBz+cweDTqc/0or4z39RcxCi2HN1mXnSnBU1+o57rL0KZjQ?=
 =?us-ascii?Q?s9gNmIPe4eKxYb0ki7trErIkll8LdeE44hNu9sOkufaLFE5bbJy34Hkd6b/6?=
 =?us-ascii?Q?D7KSUN4U6wdl/3LklCF2FaaECurVQS95RPimxmGThzO2svPO1ckEcD5GA56E?=
 =?us-ascii?Q?YcsVzXy/8UptV/dU3m1U9A0yEyKU0fkFB9P2H6KwfL6Ry71cHgMGyIZGyVlh?=
 =?us-ascii?Q?kTY05QiDlXyPfHJBI04s5oQvu4O/zAGlSFhQTgh+ms3mzDDoMH6xElopTnMF?=
 =?us-ascii?Q?zc9M3YnLZyZWstgDpXnkU1Onc+kLrdcNGWAwz6bnCybyJ0MQBarQ1U9Wcxj6?=
 =?us-ascii?Q?uPIdvPGBtxOQxsvCrUEmyVSlcsboe/GiIx95npw3OQhV6wDdldO4EtYT0ZRo?=
 =?us-ascii?Q?Uv70zJAcevVpAKzQ5Q9yzb1Y5HINv6RbB3Alfd7yykxm2yXZkp9E3XiwNftN?=
 =?us-ascii?Q?WHlsM4zWIATiyXCzyphNGt9uWhZ+S+V2ZgxB3Qum2nmmR+mt+NAfUDlu93UT?=
 =?us-ascii?Q?I679vxDpmLFrlSPyYAUAp4mqLBuvLnIR1GPEhLcXRMuvC6YPaUdjeZmyiXse?=
 =?us-ascii?Q?w+/2RAmRjyCs+syaYT08lFbYXZHg36FrXtiRSkJxY5FEBbxvqrbUMlexFBcy?=
 =?us-ascii?Q?wTMiEAqYdlGF4qjqOqSmFqLCAfbwaQXdMs0fKBWHGAEHSxshgpdiM1+vxFUe?=
 =?us-ascii?Q?knJqOBBK/EYuXXGqZf738Mh4pni1tzt0sWzfulcebvz5YHlvczAVddIDSGap?=
 =?us-ascii?Q?57IAye+qCDvRvNAYVgwGfAt3O4fewOHLdj3qVVzyQ2tFMp8Wtdc7ySQ+Ia8P?=
 =?us-ascii?Q?GU8qQNeIZzD8xR4D5x4xFCKcWM2mgwDF8n+oLO5bq+iDvARyAqpLJ0UVeeUc?=
 =?us-ascii?Q?NQOMP9W7lpK9ctR2n2tYIDLU+EjcnhSkj76oidXY0PgJrf0EFTDP1L4Td+FF?=
 =?us-ascii?Q?HnZArkaO1KdXdhPPN4o+EVOZz+agzrWjc1u/4K6CcVCp5ARAtbrWjUXA5ZCA?=
 =?us-ascii?Q?xWjiMFcN8iK9+vWhJxN2QUkScFatwDhGbfNGAu6IWPQDaJDfl0upvPGez0CH?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: ElV5QW8IPRtUNl9zmBvDM8SbeSpldnvDpcmekkcCs0RSqK6jFXIxDapxkCC697qAIntdK0mXM4ZvtIO5MB4ukMV1S8RNG9kMqpFf4fxdbXttl6qeaMjASD/mepG4La15Pv0xWYLXgxhwBtKoiLAXDLCSoh4EtMU3jj7gS3RzbfOpEeCnS6apiJAfY7Ryt2uV
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 6:mqf6pvPZnJ0jO3FTdZlHRZ4FN9ZH2ea3ZSVEtROup0B8MJqYEvLcIBL/oI3s32ItFpReKww+uMOLZzP60mYOEhWginGAAG4XuTFl9emHkfqGU/rrxjajh7jj1Bn/tBncNsBGYGsKE0typuuSLmOkjE4NoOvr0bnzZ/SFtMV3Gp2mwCL/UFDFibMD/8y/ccqe0qJfqPV3rFFf9C0+QhQtPqB+YuThHzwzCj0NTBVYm5P50k8cRDGcCTXNfMfsMsWkTNOqK49XneKiPRZRQBQ7qCjE+9z3enmr/S8BHQTw5sDNLeKIGI6W7ZqY5g8EpezxLTRGb5oafXG8SkbDJ44aKciL7GSx3cyRcESaH5pITz6csCPJ0HEBeKzXiJBom6uef/2uYXE9Jrhugg823YnoL9X2U8e/RsyuaCePdQknJTJz7EtynidPwHfTtBnS5dKmAY5h+mJJ4wmMCauPTWDQxg==;
 5:KAsF0D212RM50JEOiHHpHA0BbFzgzeACQZ2rGt/W0B0ybqsAb0TiJIXLjuX3zL6CidC33gyv4ZDBZQstkV0d/+qQo6rkQUbVrdVNIEQnDvFJ4jMIG6D5qt1Y1Vs1apAdpLTXdQeSRlLh840OLHdfff7dpfEf+DpfocbNFNmvlfg=;
 24:gFTRDOyAPeBWDXzTQhKfjKViB7SMctaf3kDsKGYUopJbZWBVGWjF9Co4GrE9aDxT4bRskwGG1qG+RIw+XmwDGEsIxlyoHh1lHX29wzoOh0s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM5PR04MB2993;
 7:66bgDLTL2QBlpLyX23nrDwEjzUFWzhAiyBLHh3ElvRgzcZvBkRtzN6OmeEVA4Wj/+Jrf6UPzaVpAtgILYq0fOgLfAgusAptghKAo+Ays5JGHSlC0Xgy5BZKxJZ5qCdefXeup1BT4osl0HIYJRgrwI1BqZTczxdefEo+FG+oUyjfdBAxfop6rlP99XXHb1PyOd1t8UNhwAm4Rh84pV+VUrAkEd/K91z2shSDeC32VOWG1xAxCPvxTFxDpNR16/HnK
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 19:06:04.6617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec5dc26-06fc-4e47-7e17-08d5934ca11d
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

Remove the staging/drivers/fsl-mc directory from the staging
area now that all the components have been moved to the main
kernel areas.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/staging/Kconfig             | 2 --
 drivers/staging/Makefile            | 1 -
 drivers/staging/fsl-mc/Kconfig      | 2 --
 drivers/staging/fsl-mc/Makefile     | 3 ---
 drivers/staging/fsl-mc/bus/Kconfig  | 7 -------
 drivers/staging/fsl-mc/bus/Makefile | 7 -------
 6 files changed, 22 deletions(-)
 delete mode 100644 drivers/staging/fsl-mc/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/Makefile
 delete mode 100644 drivers/staging/fsl-mc/bus/Kconfig
 delete mode 100644 drivers/staging/fsl-mc/bus/Makefile

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index d5926f0..a0f262a 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -98,8 +98,6 @@ source "drivers/staging/clocking-wizard/Kconfig"
 
 source "drivers/staging/fbtft/Kconfig"
 
-source "drivers/staging/fsl-mc/Kconfig"
-
 source "drivers/staging/fsl-dpaa2/Kconfig"
 
 source "drivers/staging/wilc1000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 919753c..326a1e8 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -40,7 +40,6 @@ obj-$(CONFIG_CRYPTO_SKEIN)	+= skein/
 obj-$(CONFIG_UNISYSSPAR)	+= unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+= clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+= fbtft/
-obj-$(CONFIG_FSL_MC_BUS)	+= fsl-mc/
 obj-$(CONFIG_FSL_DPAA2)		+= fsl-dpaa2/
 obj-$(CONFIG_WILC1000)		+= wilc1000/
 obj-$(CONFIG_MOST)		+= most/
diff --git a/drivers/staging/fsl-mc/Kconfig b/drivers/staging/fsl-mc/Kconfig
deleted file mode 100644
index 3002229..0000000
--- a/drivers/staging/fsl-mc/Kconfig
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-source "drivers/staging/fsl-mc/bus/Kconfig"
diff --git a/drivers/staging/fsl-mc/Makefile b/drivers/staging/fsl-mc/Makefile
deleted file mode 100644
index 1468388..0000000
--- a/drivers/staging/fsl-mc/Makefile
+++ /dev/null
@@ -1,3 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Freescale Management Complex (MC) bus drivers
-obj-$(CONFIG_FSL_MC_BUS)	+= bus/
diff --git a/drivers/staging/fsl-mc/bus/Kconfig b/drivers/staging/fsl-mc/bus/Kconfig
deleted file mode 100644
index 90f234d..0000000
--- a/drivers/staging/fsl-mc/bus/Kconfig
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# DPAA2 fsl-mc bus
-#
-# Copyright (C) 2014-2016 Freescale Semiconductor, Inc.
-#
-
diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
deleted file mode 100644
index 2141e4b..0000000
--- a/drivers/staging/fsl-mc/bus/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Freescale Management Complex (MC) bus drivers
-#
-# Copyright (C) 2014 Freescale Semiconductor, Inc.
-#
-
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
