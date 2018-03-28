Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1645646-1522219639-2-16670633631336973466
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522219638; b=V5UH3tDNCqfeo3tlgNuA5mny6uwr3StCmWdg6VaCviqhqRw
    C1XWK8NzthxVPu1SUq7wSouej9P4pjXZrSrp6nCQCbXgM6O40KuREqilY/KzqyyP
    nAniZTp3spGuVPUI49ae5zhIgIeVTX+gCxFIRLLy+oRkj2e1tWKqyntCqpbL4f1C
    GBgzff9x550FCXv4TUwWS5b2mjkn6nmNz/pMYkZaCER6BCdYmUUQHLM4K16GiRM5
    h0r5I3bGUPxMGGEL+Wo5j3wqRxXSq0NYTwjFg95R6iGRAyMR7JVKAcY0ujopYykI
    X4smOrBKEsYRNCGe9wrUp78sqLA7S7Tm0cbkktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522219638; bh=2
    E2JmynxvqcG6OVSeVy2T3239hKVfdUCSSHa8V8oeSU=; b=Bk3ithn0rsqXb6sww
    +L4+uYeLrqt876Q32eSKDV880mejVXnhaBZtL00R+tYFCCijnuAd+RJhVZXQFrOb
    27JiO64Zhjn5zQs++VBdp6kGz4mLAZPGtq2jN/mfyheBHbgmSS0JqXDYqbGVkef6
    jqMjGX+V6mnqdT5PtYsXOgjXw1IzZZ4CX55UbazTVrPKuYGLAdNIhs4arUeU36qn
    QxHlBwcfK5T97RjF8XYhoxYsDhvPavW+ddTMaLjNBAm9fOBtDN7/vVgU/XJoqijQ
    fiu4ncHs4nYf/8ydSjMvR6O/BYa+yhwEax3bmqsb6SXxgRAFuiOwR6z1uW3qZFCF
    o8E7A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=U+MHBnZo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=U+MHBnZo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGEjrifv1+6M6c+MjxE4rJJGJ7zoQMRLESfjuwUjsT3k+Qs0zVfwNwEQ/WTD1lSjUhF+qoaeM8ZAUEa7+4nnqvuMCoOya8LAox934o10yD+v8cvTSHwB
    VWJwiIyAl7G38e94kI5yCISuG+cdBeZqa72JLj3YKu1kON0XupblL6gTKE0oWwVc8QxHvltnJ741riA0IUsabJ9ejLjk59m+RfyL2l0qJ//Z2ZBseE46bHkX
    7pd/4KaKlL806SOFd+yVVA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=HDWVoQlkhfgA:10 a=MgAmFuzLjqAA:10 a=stMw5y7y3skA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=dw2S5ISiLjYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=8AirrxEcAAAA:8 a=DDOyTI_5AAAA:8 a=ozcGWWFLlwVRqNTzM5wA:9 a=CjuIK1q_8ugA:10
    a=ST-jHhOKWsTCqRlWije3:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH v2] staging: fsl-dpaa2/ethsw: Fix tag control information
 value overwrite
Date: Wed, 28 Mar 2018 01:46:51 -0500
Message-Id: <20180328064651.16052-1-razvan.stefanescu@nxp.com>
X-Mailer: git-send-email 2.8.3
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR2001CA0020.namprd20.prod.outlook.com
 (2603:10b6:4:16::30) To AM3PR04MB0744.eurprd04.prod.outlook.com
 (2a01:111:e400:8839::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2cf4719a-b120-46e1-21d1-08d59477b7a9
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB0744;
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0744;
 3:Vbc673k0mlq5YqUjBowVeJRs3w9nUUFJ2QdCZ3dWYPye3CYFhLFh7S8nYyfNZ6mtnfJMHQfBonWpS9CeETxTyApf+rI1mZbMNwFgRYm0cAE9VRmru79taMJzJ1s5ifpokXKjMxdeYe6GIQuiZnyEayTX7b9KNX2rQqvw6zlYTkpD2DLg1mnQvTfCLz1AtU09rL90tZhCcDLLy9UxqSOyEA8FU7OhWj4x2SL84wjdXPsmeiu4HT/QXWrrV1KgnIqy;
 25:tk2Aw7sbUeADtIQvBG/RzqBfEFGHoChWiY9aCOcay1efq4VW1tBNuin+k7RVHkNsEpdtkxZmy0emSMW19YGOn5pjtnvYYpYEwST8bRa53/hQqubs355rrujz9QxDYG28MxUy4Mf+6jtzkHLD6jAsbXVnvIiL0N6M2g+24EJEytDLMfpmhqOXv5km3AvXWuqXrPJd3J1rVG//lTQLv7y3KK4HZQrZMJ4c5vNv/ke1YL/CCOOEhcwpm26hi4ZQR3w01yzaVEda9PJuxiaLvVKOTR8YnshZigOK8QtyO5pKf5CM6X5JqjRw5/I38mqpA6o5a3t2K04myg9SOBSDECkO6Q==;
 31:13lRHBQmjWXpVsbZlqxV/9+t2oh3g09Lw8M032GRIHao/yDAtFS8h0eYrtWz2BIE1qwF4M8Zb8B6ITRF2GQ7t5L7YfwEKyM+DH6UMTcFfQak5OhkjXpAIC/Zg4zkxECIQjnTQUgBZndquYxzTDPIHrET+JSjIzS95T+4IBBGRiGZ/jMC5gexLWMSfmdu+UUNF2EIFnEp5H1Z/IxkwJECJNf0Z5Ea4QgC17k87R334w0=
X-MS-TrafficTypeDiagnostic: AM3PR04MB0744:
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0744;
 20:orMoTixqtqZCCknY4yueCz6WVoUHiq2V8Tbz+IYvN6ZgzksLJ2v0HCDeiqZtNwprg7Jbp5kck7hJtRh7q7olr4lbjgJWt24VjKnA0iVEynNJBVVDOJBWIr3BcNK8KHaXLLOX2zpruBufSbHCnw5PYICIrRU5JxOfcOcDdRX6QRp32OkHEeFDfjdLMNXkM7h07TGWMIPfHGeqoUt5PJbS+4nJhGEIn1FfIp7xCeskebX1BVkIof2My3HT2zg+juiwyd9nDmNmKQYDghclxbhyafYoAkZN27U1PaCcOXPv/hzWPxsYUtv+/31FIRsCleU+XEFxhTbX6laoEU18dNPMzL0ql2HUCBpntFY5vraIyxgTYGF4bLuVPmdhzlRPdhJZWuvQSKc2EiSj0lBI2UFGpm4LQ5JxF7TqqUFgRIZUt6daflJdjuCC76JKLDm6eni1K7sv75gBbDnvFQEYwmhbPK7wykrigMRoyQhogD1kGMW3zwricE1Gwl8ujsStgxyu;
 4:tDRCr+IbqhQPp8iHbyxfeRfWrwYp83Jp3ufvQfVf0K8woDz1CQfFUtb1MBmFNbyfHxbiAB7aDk6M6dwv8KP00lz9NlJCnjBI5H16KR75nTHqHpGku1kwV7zpbaSymd36TogsZoQuQ6c28e1vEUw7AO+n1aUatj8iKyBv7imG/J88zyuQs9WmuZfPjes2LGt4QDTXaF4R7LlcuWBX+RiVtuqRjV/Tqe3WjXIpwr/eU2GOr/fs7kpKvq2JHU6tlpQktMLYxNpaC6QNhHtkNVvzcgu4H/Y0mze/2BB2TOGUAcMAusqFSR+InU5/3CSt6QUCVp5ymzu4JW2Rp53f+Df7/uvQaPFG8ckoP7JEgeebnmA=
X-Microsoft-Antispam-PRVS: <AM3PR04MB0744BF15FC560EED1F39446EE6A30@AM3PR04MB0744.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);
 SRVR:AM3PR04MB0744; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB0744;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(54534003)(50466002)(5660300001)(81156014)(1076002)(39060400002)(59450400001)(6666003)(86362001)(51416003)(6916009)(66066001)(16526019)(316002)(186003)(48376002)(386003)(6506007)(6486002)(2616005)(52116002)(36756003)(2906002)(8936002)(4326008)(47776003)(81166006)(476003)(956004)(106356001)(68736007)(16586007)(50226002)(26005)(6116002)(7736002)(478600001)(8676002)(3846002)(305945005)(2361001)(25786009)(97736004)(53936002)(2351001)(105586002)(486005)(6512007)(486005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB0744; H:rhuath.am.freescale.net; FPR:;
 SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM3PR04MB0744;
 23:E6LQ1uI7Iq48Sg+TxXwHcmBN51aJ83q9497+77N+j?=
 =?us-ascii?Q?s+u6GlIa6RpzInfmN7h4PTxm+Dr8oxDvgmOcQ13rJPTr4rwROTK5TCB5ZdNT?=
 =?us-ascii?Q?tOB2xTCnwnpFfTkffbWsokbQGtBnS86fyNMYFNhY7jFXhk7OywU6JcDdEwqO?=
 =?us-ascii?Q?uFGuP+uOf2MDKwTH87JVCshHoMh5QAyCHHtf6o6tB1Xs0s2c81QtLBZ8f/Bg?=
 =?us-ascii?Q?Bv5uzbfjai6eXiGPqlY0ZaDoDB1Iv2HH6uHOyFFxq8nLg5IDylTt8JfYsUNS?=
 =?us-ascii?Q?/85eH86+XxQknr5RhgaLbwsHXTgfsqCb45PfQ+LYvk2XWqCN9I2PTIhtNoii?=
 =?us-ascii?Q?IOAEigqKUsKJMz0ezDZJZNJXD+qy5GshoiUhupuBYgB2y2BjHWhs45E92MG1?=
 =?us-ascii?Q?eTRh97i6vag8Y/nyjhHW5LEo1U4ikMbZGydVbw/zefDSbI3xoiPeW+qDIu8i?=
 =?us-ascii?Q?/Ffnv+H7vhRXegwqDVIpomXfeNN2yNQVG4EFK3LR5x0M/zgBpOwFo6cHU6V/?=
 =?us-ascii?Q?VbeBE4F0dBeMbTfDFLTBrmMJ54LcEA/5DpdIEtlBgIeTSCqkVXb+p2U5jEto?=
 =?us-ascii?Q?3vmhLN0+1lKf0GnA2sSfENGnroi00YXJrcgY1IXW9tyIOlYPVenXWItra3KR?=
 =?us-ascii?Q?us9qhaU0lr1wWynQHv03jBtPEHA+H87h9vAoJuFgOV0EoxjfJq64ud8LWUwA?=
 =?us-ascii?Q?hXwIB9NrdjiLGdbkntTdlBTJdklfF43fE2W8W4Jo8ZNqUsp02GA5ZScCBXqF?=
 =?us-ascii?Q?RcDNX1+Z3oPXFRkygqWpUMurgo4YC+GMf+1KIVcRr0OrqyKF/nJzywLGENrL?=
 =?us-ascii?Q?/jVZcKBP2/JLHOMzKKPo9qpXiluMaZlkLG07DkLw90Ch473PIlCkrvLmYPEd?=
 =?us-ascii?Q?QjVv5sRqZgDNGM+0t0tVFK4Y+ZCPfiHwpi8DuzB9bhdkZy2xdxeMutxJ+m9k?=
 =?us-ascii?Q?9WshEz/Hl5jLZ7qi1yWZfd+punqOP8928n4s8a1jDeUI/lB3wKFjJzpQw935?=
 =?us-ascii?Q?YlzX/jsloX6nZ59dGlfT3YBheWeQx6wEchCsXcrk83AZh36syADwXLelDGeB?=
 =?us-ascii?Q?E/Tp1gWfOQUYroYWmJ7DgLeUkKEFjV/Tcp/KhCQB7XovFjwyFGWo14+unhQ8?=
 =?us-ascii?Q?HHGz65dV5B9skeY3I0+gOMzzac/xhvFIPuOb41unrY5TlCtqxmUcPdJlsAQx?=
 =?us-ascii?Q?fL/44UaFwYfxbI9HLOIYdHDYNg5GGdnc6iYTJstwYlxoPMkrWFseSW9GvAON?=
 =?us-ascii?Q?UrIR9K5x66Hfgb2BrNtIZPqhmozUr6jOSzryKMg?=
X-Microsoft-Antispam-Message-Info: oqmGc1kLxBG2tOT2v1h9hCFqxwZMRxvM7EF7tXlZVj61Y5hFaklCxF5Qn6zekbti7PlsF9IiUFxTp4QqlLMN52dqS92uYM2sle/VB39dJ+REY5koJQawPaBZ2AdsYhc1B4rOSCyBq2c7dg1x2eC5OsmSWHynuvZgeYRCw51CcXtP9zuDfxmiFfqRpdvcFjkn
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0744;
 6:TWDSDvGkEVCkD4P6zNh9k2AT/q4If3nBd4v//gqf5LeCvYEv7lYE/W1gucuR88ZiJtRPR/JXNZgSxHHmRMF5FZSdjVcWQ30WpZyYuZvUJ3QfLsNQsypLML95afGB3shAuZxnR6F1BvCQUPktLGm9DprMUIOKbnSsarOYcyLA4z1Uf5aDv183p9GklKvwUMBHmXj5FmyXekYJtx/LUPl4GmyT5Mpqx2eHxH+Gub/Bg/pFGMZTeExIZTBbXecuTLxY64fb3p+iL9//umLTPu5Drz+Xc9hhlXujto0ds9ZafmyBtGzWr31H9tU8eaKDBMtZ2AydnaOg35YEzu/i93fl92BAhh9WnDUUElOvnHX0HBh+0Cxsgb6FmY04UyIuXZNSjeDCkkgH1o3RzvY9Ys0LtLPUZbb1Zc+e+xVmCP+La6DiJFJjnEsdPWt7t0acjeZgdOLQ4wvgR0lGU1e4inmxJQ==;
 5:3O3BqZtJbNonJvJLLWD3rrxHLC+LQI7KIzLC7xCg1adFpb+SPH2aRs+B/eidqh4S4hPgWw5crK4bDM8hpwxChEaoelh4WMAyS64MyghNRczxuIxy3yGfV0mp/4MnQFqA9G7AIZT1Ddt5otoK9CWkaE6wAHlevwxviPINe3v4Mds=;
 24:2r0M0UwM63yBi04TtVdksdbTJkjBvt1B+SROvt3H9AVW0RmztHCaIF2Gvqq2/x1SgB7URVN8tVvM+1Ag3mw/aNucfi6ke7cHmHNck3VNO0g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1; AM3PR04MB0744;
 7:9vmTlUTMzpPbyn7CcmBF8I8affZBiuxvXNKei4ngVzKtFczsicK9f2NXQJPLbhqxNbXzWRaOr684wXk5eM/S9E2Mny2azWU2Vy7yB3p9qJapQm45DSGiSpZuron9QD7IwQQkUxZI4gUR94js+1ei78uvR1I7j5eT4I50C25EiQ4iPQE7EkCjPGxXYN6yusi3yNrwaCWZq0zAr/x2Ee/HiExqvO+11m2Suzl10h16whsT02UWxIBvetCKvMb5CFwk
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 06:47:02.5814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf4719a-b120-46e1-21d1-08d59477b7a9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB0744
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
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, netdev@vger.kernel.org,
 alexandru.marginean@nxp.com, linux-kernel@vger.kernel.org,
 ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The tag control information (TCI) part of the VLAN header contains several
fields, including PCP (priority code point) and PVID (port VLAN id).

Current implementation uses function ethsw_port_set_tci() to set the PVID
value and mistakenly overwrites the rest of the TCI fields with 0,
including PCP which by default has a value of 7.

Fix this by adding support to retrieve TCI set in hardware. Read existing
value and only updated the PVID fields, leaving others unchanged.

Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
---
Changelog
 v2: improve patch description

 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 13 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 42 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  6 +++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 37 +++++++++++++-------------
 4 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 1c203e6..da744f2 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -49,6 +49,8 @@
 #define DPSW_CMDID_IF_SET_FLOODING          DPSW_CMD_ID(0x047)
 #define DPSW_CMDID_IF_SET_BROADCAST         DPSW_CMD_ID(0x048)
 
+#define DPSW_CMDID_IF_GET_TCI               DPSW_CMD_ID(0x04A)
+
 #define DPSW_CMDID_IF_SET_LINK_CFG          DPSW_CMD_ID(0x04C)
 
 #define DPSW_CMDID_VLAN_ADD                 DPSW_CMD_ID(0x060)
@@ -206,6 +208,17 @@ struct dpsw_cmd_if_set_tci {
 	__le16 conf;
 };
 
+struct dpsw_cmd_if_get_tci {
+	__le16 if_id;
+};
+
+struct dpsw_rsp_if_get_tci {
+	__le16 pad;
+	__le16 vlan_id;
+	u8 dei;
+	u8 pcp;
+};
+
 #define DPSW_STATE_SHIFT	0
 #define DPSW_STATE_SIZE		4
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 9b9bc60..3ea957c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -529,6 +529,48 @@ int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
 }
 
 /**
+ * dpsw_if_get_tci() - Get default VLAN Tag Control Information (TCI)
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @cfg:	Tag Control Information Configuration
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_get_tci(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    struct dpsw_tci_cfg *cfg)
+{
+	struct mc_command cmd = { 0 };
+	struct dpsw_cmd_if_get_tci *cmd_params;
+	struct dpsw_rsp_if_get_tci *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_GET_TCI,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if_get_tci *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpsw_rsp_if_get_tci *)cmd.params;
+	cfg->pcp = rsp_params->pcp;
+	cfg->dei = rsp_params->dei;
+	cfg->vlan_id = le16_to_cpu(rsp_params->vlan_id);
+
+	return 0;
+}
+
+/**
  * dpsw_if_set_stp() - Function sets Spanning Tree Protocol (STP) state.
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 3335add..82f80c40 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -306,6 +306,12 @@ int dpsw_if_set_tci(struct fsl_mc_io *mc_io,
 		    u16 if_id,
 		    const struct dpsw_tci_cfg *cfg);
 
+int dpsw_if_get_tci(struct fsl_mc_io *mc_io,
+		    u32 cmd_flags,
+		    u16 token,
+		    u16 if_id,
+		    struct dpsw_tci_cfg *cfg);
+
 /**
  * enum dpsw_stp_state - Spanning Tree Protocol (STP) states
  * @DPSW_STP_STATE_BLOCKING: Blocking state
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index c723a04..ab81a6c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -50,14 +50,23 @@ static int ethsw_add_vlan(struct ethsw_core *ethsw, u16 vid)
 	return 0;
 }
 
-static int ethsw_port_set_tci(struct ethsw_port_priv *port_priv,
-			      struct dpsw_tci_cfg *tci_cfg)
+static int ethsw_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_tci_cfg tci_cfg = { 0 };
 	bool is_oper;
 	int err, ret;
 
+	err = dpsw_if_get_tci(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			      port_priv->idx, &tci_cfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_get_tci err %d\n", err);
+		return err;
+	}
+
+	tci_cfg.vlan_id = pvid;
+
 	/* Interface needs to be down to change PVID */
 	is_oper = netif_oper_up(netdev);
 	if (is_oper) {
@@ -71,17 +80,16 @@ static int ethsw_port_set_tci(struct ethsw_port_priv *port_priv,
 	}
 
 	err = dpsw_if_set_tci(ethsw->mc_io, 0, ethsw->dpsw_handle,
-			      port_priv->idx, tci_cfg);
+			      port_priv->idx, &tci_cfg);
 	if (err) {
 		netdev_err(netdev, "dpsw_if_set_tci err %d\n", err);
 		goto set_tci_error;
 	}
 
 	/* Delete previous PVID info and mark the new one */
-	if (port_priv->pvid)
-		port_priv->vlans[port_priv->pvid] &= ~ETHSW_VLAN_PVID;
-	port_priv->vlans[tci_cfg->vlan_id] |= ETHSW_VLAN_PVID;
-	port_priv->pvid = tci_cfg->vlan_id;
+	port_priv->vlans[port_priv->pvid] &= ~ETHSW_VLAN_PVID;
+	port_priv->vlans[pvid] |= ETHSW_VLAN_PVID;
+	port_priv->pvid = pvid;
 
 set_tci_error:
 	if (is_oper) {
@@ -133,13 +141,7 @@ static int ethsw_port_add_vlan(struct ethsw_port_priv *port_priv,
 	}
 
 	if (flags & BRIDGE_VLAN_INFO_PVID) {
-		struct dpsw_tci_cfg tci_cfg = {
-			.pcp = 0,
-			.dei = 0,
-			.vlan_id = vid,
-		};
-
-		err = ethsw_port_set_tci(port_priv, &tci_cfg);
+		err = ethsw_port_set_pvid(port_priv, vid);
 		if (err)
 			return err;
 	}
@@ -819,9 +821,7 @@ static int ethsw_port_del_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 		return -ENOENT;
 
 	if (port_priv->vlans[vid] & ETHSW_VLAN_PVID) {
-		struct dpsw_tci_cfg tci_cfg = { 0 };
-
-		err = ethsw_port_set_tci(port_priv, &tci_cfg);
+		err = ethsw_port_set_pvid(port_priv, 0);
 		if (err)
 			return err;
 	}
@@ -1254,7 +1254,6 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	const char def_mcast[ETH_ALEN] = {0x01, 0x00, 0x5e, 0x00, 0x00, 0x01};
 	struct net_device *netdev = port_priv->netdev;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct dpsw_tci_cfg tci_cfg = {0};
 	struct dpsw_vlan_if_cfg vcfg;
 	int err;
 
@@ -1272,7 +1271,7 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 		return err;
 	}
 
-	err = ethsw_port_set_tci(port_priv, &tci_cfg);
+	err = ethsw_port_set_pvid(port_priv, 0);
 	if (err)
 		return err;
 
-- 
1.9.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
