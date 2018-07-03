Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39968C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD11521F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="ES+mKYF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD11521F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeGCT6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:58:49 -0400
Received: from mail-eopbgr690083.outbound.protection.outlook.com ([40.107.69.83]:50012
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753103AbeGCT6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzbzS0L9sr8D2GZzkHu0LHTm/TZ2q275UdifsOVfhQw=;
 b=ES+mKYF1gxSgQribSMwMNCbPzJ4Akuw2Wvig1HlZhTGfKy+gcICVj31dIHQqoFcBBLkdwSxVNksCbwX/wMCukL2PKVWBgzAJxYaKqOIW6edZwd3Tqvpg+SsM4PeA/Z3MFfy94w9Dm9pomX95fWjIC0oigP9p+bbzkP2ybT94/d0=
Received: from BYAPR07CA0029.namprd07.prod.outlook.com (2603:10b6:a02:bc::42)
 by BN7PR07MB4705.namprd07.prod.outlook.com (2603:10b6:406:f1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.26; Tue, 3 Jul
 2018 19:58:31 +0000
Received: from DM3NAM05FT013.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::203) by BYAPR07CA0029.outlook.office365.com
 (2603:10b6:a02:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.25 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:31 +0000
Authentication-Results: spf=softfail (sender IP is 199.43.4.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT013.mail.protection.outlook.com (10.152.98.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwMs9006991
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 15:58:29 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:41 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:41 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwOSB012333;
        Tue, 3 Jul 2018 20:58:24 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwOpM012331;
        Tue, 3 Jul 2018 20:58:24 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 11/15] Introduce Cadence USBSSP DRD driver - added gadget-dbg.c file
Date:   Tue, 3 Jul 2018 20:57:55 +0100
Message-ID: <1530647879-10007-12-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(199004)(189003)(36092001)(5660300001)(87636003)(478600001)(110136005)(26826003)(53936002)(54906003)(446003)(426003)(8936002)(126002)(476003)(2906002)(68736007)(486006)(11346002)(2616005)(47776003)(6666003)(16586007)(42186006)(4720700003)(316002)(81166006)(81156014)(50466002)(69596002)(186003)(48376002)(76176011)(51416003)(106466001)(105596002)(356003)(97736004)(8676002)(26005)(50226002)(305945005)(336012)(36756003)(14444005)(107886003)(4326008)(86362001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4705;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT013;1:2jiTf+/chOhZo8f6m4e+/QvQqk3J+cmumdx4Q/pdKXBSpxKWRpVrGlVHQIxzz6KWiAmss37j+ZSDMdLsKxPBN+xUF/yx9Sr48A0mmVtEi+2neW/WPdArBr4v8iHL7QAo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5801a065-bd50-45fa-2307-08d5e11f59e3
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4705;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;3:NKcLBPOfbNkp/2tzpRU+htO4Oy+GtHyWc2WnaT3GtpXW/qBngoQqTcrpCxNxl6rwidxaZzZ8wZeSGVvNSiJTLZsm14JChJsxKD7bJS+zJpFjQOUFM6OPZ3AbE0IfWWf0K4E/q6p1x6P0TdbyOSYqtRXt6CuK1w4vCu4AxvIIsJ7YCuCvri28cR1wl0oG4SuLHtjIOzRNIhNXa64lYI2rIDj2pYCxu0UqqzDIoDiC7giwKI+hW5MYXLHAASvPB5aVwwLaBzRGq7YxZdaqGOHb5iPaHHN3LzJTvU1opdPfw48qt8/+7PGmjSBPWgo51iJ9OHiYzj7kQB9wglg4Px6mNQ==;25:GzWuscInZGXqtOEnGNySJ2TxbmJNcFahNURGASSTIbLRtZV0eCLe1gdDb2MYykl/MW+2n7FTdApXCkdxpKUBsYD2Gs8dulr8TOAfuWHOsjBfKazP30IIvAHUOV5/7J3pgtOjbX2sHyxghaPdhSzEVFBdxptidRM79nUhQw3/Sqdtf+XHLSJPUOejMX0xVKOnrzza4MYRaTMTUM+srs00APENJPX3rIDt7SIIdDL46YQpQH7mCTKFOBwU+1yknzPXdUOvcnTPY/ZqpEB7sVbLLgm1bduKRVTerio7la6JPOJZTsM4ImAoXTfJl6qnDRDzR3BNJSLNa4d/QmiJzH84BQ==;31:huU4pyKsLiTs904WqKriK8tDyBoc74qkh1jDBffV6X/SZ0OutaS5Bb+dsoieiRh6BPPaWOIP1b2GfpwebRFtlRl/jsMXnhFGc3snWkBkg7MOC0ZXE8JUUd83DgWEnj2McYhnfHffGoCvTlwJs9hiUgItks9YCLfprtdvzx1uKEtlOMi7EoHgiq5t04WE7NRh+/vRae53jCb8ssTVCfBr1zeK3iHG+TzLVfTycmUYsbo=
X-MS-TrafficTypeDiagnostic: BN7PR07MB4705:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;20:4YdnNuiFMjQ1c9vbjSru1MED7r2CNFJzjaWt3jpGkhZM7IPMfUBx+8uiXg5evVh/stkIp8SRJXuWWnv/Zl7BaDF3iLlQWFIvg+RNyl2Aq8dTvHCH5PjmWmqe5O32fGy4mSHvoTCbuJ/Y4Jyn8+YrhHbo+2FkRkWcL4shx/XSE8ITlGL0F//skF3cuL/Xlz1O4xLhKqw+xmstjnU/miGTr/lkeH6RxcbuUtQy6rk0BIsA2mMMxbKLh+9RUm2JSAgDj335EHpO+GvWITyQLzw8risu4bhjriZFxH9lvUvzBB3YPnhREvMiBWEBkX2WCcSLj3XZQkF33rLYqIrzenw8ynZVQ2mmjROgApmmzmppltsY6XCqjcC16rZBqwJQ9m4UMmjg8cw7BOwHsdq2t04TBtJTDv7BPzf8Nr3YA/3qrKwMMssg1rPG+usatEkKjqOtLaFecZOGmF92VsB1QF8/Z5bzYkhMGAQl+ZfBHzkAjjh5MSe9vTiJ5qTVcJg3D2na;4:Y6GBAGVL4k6aqV+O19hfLB2M+XwF9DBTEa5JRupTL0dwfoWf9IKaWUNTtJsyJf049++5Zsxbx3FRJe6T3xqS63U6hxpKOKzWb/VD0oSeHOuFsvwdLZe7Ne2SUOnvZTwuXtqWUs3uTN6rpPkk4XYwcyzYQbR8PMEqev2cDOnPaJ2xi/R6eys/uEbixCUiupPF8CNjGTU4Ci02j8bxsT1DUAcqMLg+cyjA+noPkwdJg/Z1CuZfmppTYfkT3kmA27Tu3H0sZpipKrjOIY+nszRPf2bkR1V+LItZjuGv2kn4LqqmNtsnXM5FDfAQDjdaOcyq
X-Microsoft-Antispam-PRVS: <BN7PR07MB470505E3278CC6A7CACE8445DD420@BN7PR07MB4705.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93003095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4705;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4705;
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4705;23:0tSvvLrl5L2asQhsy9rYIZX5CjODfSDxa7QVB5VF1?=
 =?us-ascii?Q?tPCmydKE30X6TNAM3FJ/9L/aQ8q3FAjV3nxVXPN/5szj9JfK08TOYFCANxhV?=
 =?us-ascii?Q?WKPbgudx7AzXj84fYbdKJrFGCoXNsA7rZ0GwGdQsQHDPVMM7FM/oD4h1LGeu?=
 =?us-ascii?Q?8qCrqgxT1xYQwr/gV4eRuuZDvVZIfwV8lF9iQrAMWT4Q9HV0mx3cbfV324OR?=
 =?us-ascii?Q?o4P7jtQ2BXX9/1p2T6C9Ot3ZAunAtP0O9e9+yiGWsPchII/T9s9pDuU5oENW?=
 =?us-ascii?Q?hVbJQC1i/Ml7YZQ7qoDYJs18Ft4/DLq/xoGncUTnl6cu57niHtnpIenetgDy?=
 =?us-ascii?Q?jZ2uUrM8k6zDXbIcAa02kE8ugOPMsH2fVgRYf8n0MXJjqFMD2R87byS80R+w?=
 =?us-ascii?Q?GSQGawGYSEP28GUSmc+CoRlUW+TuwSmCQvwanMLedPUt7zLTepg1KgWNrNK+?=
 =?us-ascii?Q?evFyhcUGOBENc12qQkm3g0T+WPanj4wTsUOQOprrgLVpzLI7+qem6D6CbH4f?=
 =?us-ascii?Q?hRmUohHQDwr0rm9eV62y+Rwg0dIate4E84lrkdF+cMEMHupTdQdtPA4PdHCj?=
 =?us-ascii?Q?7G03O+P3G572PLA7ZS9Jqta94EOa+ryt7hL6rdjiqs9pxeWxAM5HUgFuxNK7?=
 =?us-ascii?Q?cT6V7xPwe8GTaoP2Ff8JiCck/l8r22Vjcjx6BtsEBJaaOd1zUR6GvlFkLC90?=
 =?us-ascii?Q?iObyQxPUjo6bUOv+Q99HemezPhHbLjMtwt5sWl0ESagp3BZUepqMXEuZiK28?=
 =?us-ascii?Q?aIHXgOO0altPsSC5+ev4RUT3aDlxFoTf4QV47/wAiA7r8ZC/GKUNx9PfUPEN?=
 =?us-ascii?Q?hQclUiKKDR3QPVO+y7CuntUyoUqoD99F/92e6lBPlHQE2VNnmVCRC0gFa6Wg?=
 =?us-ascii?Q?XBs1+6l4QRORqag55ah38lDa5ziJQ62wG0vJFww+5Fq1rVvxittYbqRZ5bxn?=
 =?us-ascii?Q?PyBcVGW7PYxjitmPGLXIWB2cZn8vn2dWd+cIhLzHJ1cg0xTGWjMycjMLGG+9?=
 =?us-ascii?Q?DeMwMD59ovqXVYnRrSEbfwHrGSn8tbHz/cFtGi84J3M0w1zeuTDEYIsYi/+b?=
 =?us-ascii?Q?6Zt6H+MtDP++lYms3lmqHbBg2o++QuMBOAnabOiT0OcN0o8cw87qj2sJDJEb?=
 =?us-ascii?Q?PUaDQ0NRdlNqfwbaZXNW/c02ww06v420AVQVHg0d6J0dfs8WrKBgUagWFP26?=
 =?us-ascii?Q?fULZvILO21qVFNGEBNUkde4ivmhRj/HlcWxi3JRbtqD6Wcl9YnZjPsSpw=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ecncGAtkCVK9xwACS8R21RL197LTxDEwU+cAV11F8SBlRAvNJpD20o4E0yGU+o4H9mbbjBAty5M4gli7k3g10XJ7z7EpgtDKsIXz+2HF/r+yMgAAAeYU0OU2V++4Wee/tnJGKXO40CaXdRit3KFeqdeRU1sBUQDc/3Z9ItuGVSer5tkR9AwAYKmcZCqm5KQK+v+QPHcgWLd86PusSwEvTgUih9yGelMRyAxxONjJW5AqqqB33L1dNvpju4YoKqb8sxbC3SJ4xLRJEnA1s98q3pOo/asEGFb6LquPAOCB52Ikx6CvRNbtlqyOy2sEMugref/ZI3OJJU7y+ZZx6orq194XfNYk4F2Z+qu+slTeRmoVK0Y3rregWxqb4TGAIdpNAzE/j6OffOiLkSnm73M+LA==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;6:zKB3nRVsl1CcM+h/x2ZO56iNsvUWWGeblhVi5qEL4dZbvWCxzz3rslP2TfT9PJZ5bmWq6W47lcehO7858vP3aX5VeSV3T1v2pM5VsJUTO1uREdj6mA+lyW1g2HUVdt2uod6QBZrqiF3H4iiLmcLNAmeUXAv0jeaD5wbeME1ZgIcSV7u8BMas0iq9QF2E/IHTMeoQO11w9F1OfUlhP/sSPKmr2i7jEu9DZX2NXSJBKKslpC8mLAc4K9hJJW9kzoE7r8WTM+/sY6SpJK/IKsH/OACllXFmSrlbyLhtddDJ1/kDS4KHYao54WyboPsr2pKpaCl2OQfpH+kjvW2OPFKZMZ0WNzChefoJEGXc+5QN+YJmCGv6iPa1BoCLegC4dZLjbRkNtKPcOb29guzVkBx0otQ4rRwQ7R0v186OVDn2pRL9YEin6PrGNmjnwmSoNPOBkiTKrCeFCbVFYHrhp8lbOQ==;5:LICZJqQ+Iws+w2aRqxOTFmoPFA+7oPvkhwCvkwq+tZYOr7sjBkD+l92yWXNcJ+i2ckxe8IMyZBmCcuG6IWFwP6Vd0VEUd1hSzFwh80fipIZV4ZqNKyWnAxYRbcBZigaWz7h+veyYhxcH6CMJ1Ml0OLvgg1ZR0XBuo5RrZ0D0x6U=;24:8YBzqSxx5GatEXsfFtzuzZ2WPpW9WUv1Odc78QxqiA4VOM91KPwVKmbmXNaQUFtRR1y4b41ItBj0qow7cCAnZwqe5WZ72b8A/wApRXtTWEg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4705;7:EFV+P50hgUhIAuE4JVXyJi6P0j9nao1NDoFMRHtR7hl3CSYpbiQ4ZYo04UHQ0TV0u9krO0ToFVZ5K8yHSxWQTLSDaWbbCO6Xt5bpvHRYqjfgLAB0uoovCNjasUf5SOGjCav/5kODwgaPl65913/qh2EUZfhDckw1bPPSUI5U4Ki5QAQA41myDINrSHwPQlu0pcNtk3mADugkcEA3EGrh6fo/vpvqZw4BzLmxq1s9z0dI7bmgerCnBsdQgzs/9Rin;20:Oif4XRmdu1rkJnh7Y5T17dbaj03IEUYhbbLt837dOD1v1GF997a5XhR2KIP40XF+TE36d2HO6R3vmShtVPSQCJkM2u7fWrrX0Kkdzz1wTB3h7xyJ7ZW0Vnf/4pJXX0P/o9ZOSWvMfKAs00QZpjcO//lJhhsb+JtvWVe6gJtoaIuOqPX9+IQqc7IzJi3mIgP5gqWV79zMQNeJgiwx8xZq2j/RXjBQgmRxhawYNyBbtWYb8himmQiUHSwcmoSLc2/f
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:30.8118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5801a065-bd50-45fa-2307-08d5e11f59e3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4705
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-dbg.c | 613 ++++++++++++++++++++++++++++++++
 1 file changed, 613 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-dbg.c

diff --git a/drivers/usb/usbssp/gadget-dbg.c b/drivers/usb/usbssp/gadget-dbg.c
new file mode 100644
index 000000000000..0115abd643a1
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-dbg.c
@@ -0,0 +1,613 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Some code borrowed from the Linux XHCI driver.
+ */
+
+
+#include "gadget.h"
+
+#define usb_endpoint_out(ep_dir)	(!((ep_dir) & USB_DIR_IN))
+#define USBSSP_INIT_VALUE 0x0
+
+/* Add verbose debugging later, just print everything for now */
+
+void usbssp_dbg_regs(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+
+	usbssp_dbg(usbssp_data, "// USBSSP capability registers at %p:\n",
+		usbssp_data->cap_regs);
+	temp = readl(&usbssp_data->cap_regs->hc_capbase);
+	usbssp_dbg(usbssp_data, "// @%p = 0x%x (CAPLENGTH AND HCIVERSION)\n",
+		&usbssp_data->cap_regs->hc_capbase, temp);
+	usbssp_dbg(usbssp_data, "//   CAPLENGTH: 0x%x\n",
+		(unsigned int) HC_LENGTH(temp));
+	usbssp_dbg(usbssp_data, "//   HCIVERSION: 0x%x\n",
+		(unsigned int) HC_VERSION(temp));
+
+	usbssp_dbg(usbssp_data, "// USBSSP operational registers at %p:\n",
+		usbssp_data->op_regs);
+
+	temp = readl(&usbssp_data->cap_regs->run_regs_off);
+	usbssp_dbg(usbssp_data, "// @%p = 0x%x RTSOFF\n",
+		&usbssp_data->cap_regs->run_regs_off,
+		(unsigned int) temp & RTSOFF_MASK);
+	usbssp_dbg(usbssp_data, "// USBSSP runtime registers at %p:\n",
+		usbssp_data->run_regs);
+
+	temp = readl(&usbssp_data->cap_regs->db_off);
+	usbssp_dbg(usbssp_data, "// @%p = 0x%x DBOFF\n",
+		&usbssp_data->cap_regs->db_off, temp);
+	usbssp_dbg(usbssp_data, "// Doorbell array at %p:\n", usbssp_data->dba);
+}
+
+static void usbssp_print_cap_regs(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+	u32 hci_version;
+
+	usbssp_dbg(usbssp_data, "USBSSP capability registers at %p:\n",
+		usbssp_data->cap_regs);
+
+	temp = readl(&usbssp_data->cap_regs->hc_capbase);
+	hci_version = HC_VERSION(temp);
+	usbssp_dbg(usbssp_data, "CAPLENGTH AND HCIVERSION 0x%x:\n",
+		(unsigned int) temp);
+	usbssp_dbg(usbssp_data, "CAPLENGTH: 0x%x\n",
+		(unsigned int) HC_LENGTH(temp));
+	usbssp_dbg(usbssp_data, "HCIVERSION: 0x%x\n", hci_version);
+
+	temp = readl(&usbssp_data->cap_regs->hcs_params1);
+	usbssp_dbg(usbssp_data, "HCSPARAMS 1: 0x%x\n",
+		(unsigned int) temp);
+	usbssp_dbg(usbssp_data, "  Max device slots: %u\n",
+		(unsigned int) HCS_MAX_SLOTS(temp));
+	usbssp_dbg(usbssp_data, "  Max interrupters: %u\n",
+		(unsigned int) HCS_MAX_INTRS(temp));
+	usbssp_dbg(usbssp_data, "  Max ports: %u\n",
+		(unsigned int) HCS_MAX_PORTS(temp));
+
+	temp = readl(&usbssp_data->cap_regs->hcs_params2);
+	usbssp_dbg(usbssp_data, "HCSPARAMS 2: 0x%x\n",
+		(unsigned int) temp);
+	usbssp_dbg(usbssp_data, " Isoc scheduling threshold: %u\n",
+		(unsigned int) HCS_IST(temp));
+	usbssp_dbg(usbssp_data, " Maximum allowed segments in event ring: %u\n",
+		(unsigned int) HCS_ERST_MAX(temp));
+
+	temp = readl(&usbssp_data->cap_regs->hcs_params3);
+	usbssp_dbg(usbssp_data, "HCSPARAMS 3 0x%x:\n",
+		(unsigned int) temp);
+	usbssp_dbg(usbssp_data, "  Worst case U1 device exit latency: %u\n",
+		(unsigned int) HCS_U1_LATENCY(temp));
+	usbssp_dbg(usbssp_data, "  Worst case U2 device exit latency: %u\n",
+		(unsigned int) HCS_U2_LATENCY(temp));
+
+	temp = readl(&usbssp_data->cap_regs->hcc_params);
+	usbssp_dbg(usbssp_data, "HCC PARAMS 0x%x:\n", (unsigned int) temp);
+	usbssp_dbg(usbssp_data, "  HC generates %s bit addresses\n",
+		HCC_64BIT_ADDR(temp) ? "64" : "32");
+	usbssp_dbg(usbssp_data, "  HC %s Contiguous Frame ID Capability\n",
+		HCC_CFC(temp) ? "has" : "hasn't");
+	usbssp_dbg(usbssp_data,
+		"  HC %s generate Stopped - Short Package event\n",
+		HCC_SPC(temp) ? "can" : "can't");
+
+	temp = readl(&usbssp_data->cap_regs->run_regs_off);
+	usbssp_dbg(usbssp_data, "RTSOFF 0x%x:\n", temp & RTSOFF_MASK);
+
+	temp = readl(&usbssp_data->cap_regs->hcc_params2);
+	usbssp_dbg(usbssp_data, "HCC PARAMS2 0x%x:\n", (unsigned int) temp);
+	usbssp_dbg(usbssp_data, "  HC %s Force save context capability",
+		HCC2_FSC(temp) ? "supports" : "doesn't support");
+	usbssp_dbg(usbssp_data, "  HC %s Large ESIT Payload Capability",
+		HCC2_LEC(temp) ? "supports" : "doesn't support");
+	usbssp_dbg(usbssp_data, "  HC %s Extended TBC capability",
+		HCC2_ETC(temp) ? "supports" : "doesn't support");
+
+}
+
+static void usbssp_print_command_reg(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+
+	temp = readl(&usbssp_data->op_regs->command);
+	usbssp_dbg(usbssp_data, "USBCMD 0x%x:\n", temp);
+	usbssp_dbg(usbssp_data, "  HC is %s\n",
+		(temp & CMD_RUN) ? "running" : "being stopped");
+	usbssp_dbg(usbssp_data, "  HC has %sfinished hard reset\n",
+		(temp & CMD_RESET) ? "not " : "");
+	usbssp_dbg(usbssp_data, "  Event Interrupts %s\n",
+		(temp & CMD_EIE) ? "enabled " : "disabled");
+	usbssp_dbg(usbssp_data, "  Host System Error Interrupts %s\n",
+		(temp & CMD_HSEIE) ? "enabled " : "disabled");
+}
+
+static void usbssp_print_status(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+
+	temp = readl(&usbssp_data->op_regs->status);
+	usbssp_dbg(usbssp_data, "USBSTS 0x%x:\n", temp);
+	usbssp_dbg(usbssp_data, "  Event ring is %sempty\n",
+		(temp & STS_EINT) ? "not " : "");
+	usbssp_dbg(usbssp_data, "  %sHost System Error\n",
+		(temp & STS_FATAL) ? "WARNING: " : "No ");
+	usbssp_dbg(usbssp_data, "  HC is %s\n",
+		(temp & STS_HALT) ? "halted" : "running");
+}
+
+static void usbssp_print_op_regs(struct usbssp_udc *usbssp_data)
+{
+	usbssp_dbg(usbssp_data, "USBSSP operational registers at %p:\n",
+		usbssp_data->op_regs);
+	usbssp_print_command_reg(usbssp_data);
+	usbssp_print_status(usbssp_data);
+}
+
+/*Device has only one port*/
+static void usbssp_print_ports(struct usbssp_udc *usbssp_data)
+{
+	__le32 __iomem *addr;
+	int i, j;
+	int ports;
+	char *names[NUM_PORT_REGS] = {
+		"status",
+		"power",
+		"link",
+		"reserved",
+	};
+
+	ports = HCS_MAX_PORTS(usbssp_data->hcs_params1);
+	addr = &usbssp_data->op_regs->port_status_base;
+	for (i = 0; i < ports; i++) {
+		for (j = 0; j < NUM_PORT_REGS; ++j) {
+			usbssp_dbg(usbssp_data, "%p port %s reg = 0x%x\n",
+					addr, names[j],
+					(unsigned int) readl(addr));
+			addr++;
+		}
+	}
+}
+
+void usbssp_print_ir_set(struct usbssp_udc *usbssp_data, int set_num)
+{
+	struct usbssp_intr_reg __iomem *ir_set =
+				&usbssp_data->run_regs->ir_set[set_num];
+	void __iomem *addr;
+	u32 temp;
+	u64 temp_64;
+
+	addr = &ir_set->irq_pending;
+	temp = readl(addr);
+	if (temp == USBSSP_INIT_VALUE)
+		return;
+
+	usbssp_dbg(usbssp_data, "  %p: ir_set[%i]\n", ir_set, set_num);
+
+	usbssp_dbg(usbssp_data, "  %p: ir_set.pending = 0x%x\n", addr,
+		  (unsigned int)temp);
+
+	addr = &ir_set->irq_control;
+	temp = readl(addr);
+	usbssp_dbg(usbssp_data, "  %p: ir_set.control = 0x%x\n", addr,
+		(unsigned int)temp);
+
+	addr = &ir_set->erst_size;
+	temp = readl(addr);
+	usbssp_dbg(usbssp_data, "  %p: ir_set.erst_size = 0x%x\n", addr,
+		(unsigned int)temp);
+
+	addr = &ir_set->rsvd;
+	temp = readl(addr);
+	if (temp != USBSSP_INIT_VALUE)
+		usbssp_dbg(usbssp_data, "  WARN: %p: ir_set.rsvd = 0x%x\n",
+			addr, (unsigned int)temp);
+
+	addr = &ir_set->erst_base;
+	temp_64 = usbssp_read_64(usbssp_data, addr);
+	usbssp_dbg(usbssp_data, "  %p: ir_set.erst_base = @%08llx\n",
+		addr, temp_64);
+
+	addr = &ir_set->erst_dequeue;
+	temp_64 = usbssp_read_64(usbssp_data, addr);
+	usbssp_dbg(usbssp_data, "  %p: ir_set.erst_dequeue = @%08llx\n",
+		addr, temp_64);
+}
+
+void usbssp_print_run_regs(struct usbssp_udc *usbssp_data)
+{
+	u32 temp;
+	int i;
+
+	usbssp_dbg(usbssp_data, "USBSSP runtime registers at %p:\n",
+		usbssp_data->run_regs);
+	temp = readl(&usbssp_data->run_regs->microframe_index);
+	usbssp_dbg(usbssp_data, "  %p: Microframe index = 0x%x\n",
+		&usbssp_data->run_regs->microframe_index,
+		(unsigned int) temp);
+	for (i = 0; i < 7; ++i) {
+		temp = readl(&usbssp_data->run_regs->rsvd[i]);
+		if (temp != USBSSP_INIT_VALUE)
+			usbssp_dbg(usbssp_data, "  WARN: %p: Rsvd[%i] = 0x%x\n",
+				&usbssp_data->run_regs->rsvd[i],
+				i, (unsigned int) temp);
+	}
+}
+
+void usbssp_print_registers(struct usbssp_udc *usbssp_data)
+{
+	usbssp_print_cap_regs(usbssp_data);
+	usbssp_print_op_regs(usbssp_data);
+	usbssp_print_ports(usbssp_data);
+}
+
+void usbssp_print_trb_offsets(struct usbssp_udc *usbssp_data,
+			      union usbssp_trb *trb)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		usbssp_dbg(usbssp_data, "Offset 0x%x = 0x%x\n",
+			i*4, trb->generic.field[i]);
+}
+
+/**
+ * Debug a transfer request block (TRB).
+ */
+void usbssp_debug_trb(struct usbssp_udc *usbssp_data, union usbssp_trb *trb)
+{
+	u64	address;
+	u32	type = le32_to_cpu(trb->link.control) & TRB_TYPE_BITMASK;
+
+	switch (type) {
+	case TRB_TYPE(TRB_LINK):
+		usbssp_dbg(usbssp_data, "Link TRB:\n");
+		usbssp_print_trb_offsets(usbssp_data, trb);
+
+		address = le64_to_cpu(trb->link.segment_ptr);
+		usbssp_dbg(usbssp_data,
+			"Next ring segment DMA address = 0x%llx\n", address);
+
+		usbssp_dbg(usbssp_data, "Interrupter target = 0x%x\n",
+			GET_INTR_TARGET(le32_to_cpu(trb->link.intr_target)));
+		usbssp_dbg(usbssp_data, "Cycle bit = %u\n",
+			le32_to_cpu(trb->link.control) & TRB_CYCLE);
+		usbssp_dbg(usbssp_data, "Toggle cycle bit = %u\n",
+			le32_to_cpu(trb->link.control) & LINK_TOGGLE);
+		usbssp_dbg(usbssp_data, "No Snoop bit = %u\n",
+			le32_to_cpu(trb->link.control) & TRB_NO_SNOOP);
+		break;
+	case TRB_TYPE(TRB_TRANSFER):
+		address = le64_to_cpu(trb->trans_event.buffer);
+		usbssp_dbg(usbssp_data,
+			"DMA address or buffer contents= %llu\n", address);
+		break;
+	case TRB_TYPE(TRB_COMPLETION):
+		address = le64_to_cpu(trb->event_cmd.cmd_trb);
+		usbssp_dbg(usbssp_data, "Command TRB pointer = %llu\n",
+			address);
+		usbssp_dbg(usbssp_data, "Completion status = %u\n",
+			GET_COMP_CODE(le32_to_cpu(trb->event_cmd.status)));
+		usbssp_dbg(usbssp_data, "Flags = 0x%x\n",
+			le32_to_cpu(trb->event_cmd.flags));
+		break;
+	default:
+		usbssp_dbg(usbssp_data, "Unknown TRB with TRB type ID %u\n",
+				(unsigned int) type>>10);
+		usbssp_print_trb_offsets(usbssp_data, trb);
+		break;
+	}
+}
+
+/**
+ * Debug a segment with an ring.
+ *
+ * @return The Link TRB of the segment, or NULL if there is no Link TRB
+ * (which is a bug, since all segments must have a Link TRB).
+ *
+ * Prints out all TRBs in the segment, even those after the Link TRB.
+ *
+ */
+void usbssp_debug_segment(struct usbssp_udc *usbssp_data,
+			  struct usbssp_segment *seg)
+{
+	int i;
+	u64 addr = seg->dma;
+	union usbssp_trb *trb = seg->trbs;
+
+	for (i = 0; i < TRBS_PER_SEGMENT; ++i) {
+		trb = &seg->trbs[i];
+		usbssp_dbg(usbssp_data, "@%016llx %08x %08x %08x %08x\n", addr,
+			lower_32_bits(le64_to_cpu(trb->link.segment_ptr)),
+			upper_32_bits(le64_to_cpu(trb->link.segment_ptr)),
+			le32_to_cpu(trb->link.intr_target),
+			le32_to_cpu(trb->link.control));
+		addr += sizeof(*trb);
+	}
+}
+
+void usbssp_dbg_ring_ptrs(struct usbssp_udc *usbssp_data,
+			  struct usbssp_ring *ring)
+{
+	usbssp_dbg(usbssp_data, "Ring deq = %p (virt), 0x%llx (dma)\n",
+		ring->dequeue,
+		(unsigned long long)usbssp_trb_virt_to_dma(ring->deq_seg,
+		ring->dequeue));
+	usbssp_dbg(usbssp_data, "Ring enq = %p (virt), 0x%llx (dma)\n",
+		ring->enqueue,
+		(unsigned long long)usbssp_trb_virt_to_dma(ring->enq_seg,
+		ring->enqueue));
+}
+
+/**
+ * Debugging for an USBSSP ring, which is a queue broken into multiple segments.
+ *
+ * Print out each segment in the ring.  Check that the DMA address in
+ * each link segment actually matches the segment's stored DMA address.
+ * Check that the link end bit is only set at the end of the ring.
+ * Check that the dequeue and enqueue pointers point to real data in this ring
+ * (not some other ring).
+ */
+void usbssp_debug_ring(struct usbssp_udc *usbssp_data, struct usbssp_ring *ring)
+{
+	struct usbssp_segment *seg;
+	struct usbssp_segment *first_seg = ring->first_seg;
+
+	usbssp_debug_segment(usbssp_data, first_seg);
+
+	for (seg = first_seg->next; seg != first_seg; seg = seg->next)
+		usbssp_debug_segment(usbssp_data, seg);
+}
+
+void usbssp_dbg_ep_rings(struct usbssp_udc *usbssp_data,
+			 unsigned int ep_index, struct usbssp_ep *ep)
+{
+	int i;
+	struct usbssp_ring *ring;
+
+	if (ep->ep_state & EP_HAS_STREAMS) {
+		for (i = 1; i < ep->stream_info->num_streams; i++) {
+			ring = ep->stream_info->stream_rings[i];
+			usbssp_dbg(usbssp_data,
+				"Dev %d endpoint %d stream ID %d:\n",
+				usbssp_data->slot_id, ep_index, i);
+			usbssp_debug_segment(usbssp_data, ring->deq_seg);
+		}
+	} else {
+		ring = ep->ring;
+		if (!ring)
+			return;
+		usbssp_dbg(usbssp_data, "Dev %d endpoint ring %d:\n",
+			usbssp_data->slot_id, ep_index);
+		usbssp_debug_segment(usbssp_data, ring->deq_seg);
+	}
+}
+
+void usbssp_dbg_erst(struct usbssp_udc *usbssp_data, struct usbssp_erst *erst)
+{
+	u64 addr = erst->erst_dma_addr;
+	int i;
+	struct usbssp_erst_entry *entry;
+
+	for (i = 0; i < erst->num_entries; ++i) {
+		entry = &erst->entries[i];
+		usbssp_dbg(usbssp_data, "@%016llx %08x %08x %08x %08x\n",
+			addr, lower_32_bits(le64_to_cpu(entry->seg_addr)),
+			upper_32_bits(le64_to_cpu(entry->seg_addr)),
+			le32_to_cpu(entry->seg_size), le32_to_cpu(entry->rsvd));
+		addr += sizeof(*entry);
+	}
+}
+
+void usbssp_dbg_cmd_ptrs(struct usbssp_udc *usbssp_data)
+{
+	u64 val;
+
+	val = usbssp_read_64(usbssp_data, &usbssp_data->op_regs->cmd_ring);
+	usbssp_dbg(usbssp_data,
+		"// USBSSP command ring deq ptr low bits + flags = @%08x\n",
+		lower_32_bits(val));
+	usbssp_dbg(usbssp_data,
+		"// USBSSP command ring deq ptr high bits = @%08x\n",
+		upper_32_bits(val));
+}
+
+/* Print the last 32 bytes for 64-byte contexts */
+static void dbg_rsvd64(struct usbssp_udc *usbssp_data, u64 *ctx, dma_addr_t dma)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i) {
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08llx - rsvd64[%d]\n",
+			&ctx[4 + i], (unsigned long long)dma,
+			ctx[4 + i], i);
+		dma += 8;
+	}
+}
+
+char *usbssp_get_slot_state(struct usbssp_udc *usbssp_data,
+		struct usbssp_container_ctx *ctx)
+{
+	struct usbssp_slot_ctx *slot_ctx =
+			usbssp_get_slot_ctx(usbssp_data, ctx);
+
+	switch (GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state))) {
+	case SLOT_STATE_ENABLED:
+		return "enabled/disabled";
+	case SLOT_STATE_DEFAULT:
+		return "default";
+	case SLOT_STATE_ADDRESSED:
+		return "addressed";
+	case SLOT_STATE_CONFIGURED:
+		return "configured";
+	default:
+		return "reserved";
+	}
+}
+
+static void usbssp_dbg_slot_ctx(struct usbssp_udc *usbssp_data,
+				struct usbssp_container_ctx *ctx)
+{
+	/* Fields are 32 bits wide, DMA addresses are in bytes */
+	int field_size = 32 / 8;
+	int i;
+
+	struct usbssp_slot_ctx *slot_ctx =
+			usbssp_get_slot_ctx(usbssp_data, ctx);
+	dma_addr_t dma = ctx->dma +
+		((unsigned long)slot_ctx - (unsigned long)ctx->bytes);
+	int csz = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params);
+
+	usbssp_dbg(usbssp_data, "Slot Context:\n");
+	usbssp_dbg(usbssp_data, "@%p (virt) @%08llx (dma) %#08x - dev_info\n",
+		&slot_ctx->dev_info,
+		(unsigned long long)dma, slot_ctx->dev_info);
+	dma += field_size;
+	usbssp_dbg(usbssp_data, "@%p (virt) @%08llx (dma) %#08x - dev_info2\n",
+		&slot_ctx->dev_info2,
+		(unsigned long long)dma, slot_ctx->dev_info2);
+	dma += field_size;
+	usbssp_dbg(usbssp_data, "@%p (virt) @%08llx (dma) %#08x - int_target\n",
+		&slot_ctx->int_target,
+		(unsigned long long)dma, slot_ctx->int_target);
+	dma += field_size;
+	usbssp_dbg(usbssp_data, "@%p (virt) @%08llx (dma) %#08x - dev_state\n",
+		&slot_ctx->dev_state,
+		(unsigned long long)dma, slot_ctx->dev_state);
+	dma += field_size;
+	for (i = 0; i < 4; ++i) {
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08x - rsvd[%d]\n",
+			&slot_ctx->reserved[i], (unsigned long long)dma,
+			slot_ctx->reserved[i], i);
+		dma += field_size;
+	}
+
+	if (csz)
+		dbg_rsvd64(usbssp_data, (u64 *)slot_ctx, dma);
+}
+
+static void usbssp_dbg_ep_ctx(struct usbssp_udc *usbssp_data,
+		     struct usbssp_container_ctx *ctx,
+		     unsigned int last_ep)
+{
+	int i, j;
+	int last_ep_ctx = 31;
+	/* Fields are 32 bits wide, DMA addresses are in bytes */
+	int field_size = 32 / 8;
+	int csz = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params);
+
+	if (last_ep < 31)
+		last_ep_ctx = last_ep + 1;
+	for (i = 0; i < last_ep_ctx; ++i) {
+		unsigned int epaddr = usbssp_get_endpoint_address(i);
+		struct usbssp_ep_ctx *ep_ctx = usbssp_get_ep_ctx(usbssp_data,
+								 ctx, i);
+		dma_addr_t dma = ctx->dma +
+			((unsigned long)ep_ctx - (unsigned long)ctx->bytes);
+
+		usbssp_dbg(usbssp_data,
+			"%s Endpoint %02d Context (ep_index %02d):\n",
+			usb_endpoint_out(epaddr) ? "OUT" : "IN",
+			epaddr & USB_ENDPOINT_NUMBER_MASK, i);
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08x - ep_info\n",
+			&ep_ctx->ep_info,
+			(unsigned long long)dma, ep_ctx->ep_info);
+		dma += field_size;
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08x - ep_info2\n",
+			&ep_ctx->ep_info2,
+			(unsigned long long)dma, ep_ctx->ep_info2);
+		dma += field_size;
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08llx - deq\n",
+			&ep_ctx->deq,
+			(unsigned long long)dma, ep_ctx->deq);
+		dma += 2*field_size;
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08x - tx_info\n",
+			&ep_ctx->tx_info,
+			(unsigned long long)dma, ep_ctx->tx_info);
+		dma += field_size;
+		for (j = 0; j < 3; ++j) {
+			usbssp_dbg(usbssp_data,
+				"@%p (virt) @%08llx (dma) %#08x - rsvd[%d]\n",
+				&ep_ctx->reserved[j],
+				(unsigned long long)dma,
+				ep_ctx->reserved[j], j);
+			dma += field_size;
+		}
+
+		if (csz)
+			dbg_rsvd64(usbssp_data, (u64 *)ep_ctx, dma);
+	}
+}
+
+void usbssp_dbg_ctx(struct usbssp_udc *usbssp_data,
+		  struct usbssp_container_ctx *ctx,
+		  unsigned int last_ep)
+{
+	int i;
+	/* Fields are 32 bits wide, DMA addresses are in bytes */
+	int field_size = 32 / 8;
+	dma_addr_t dma = ctx->dma;
+	int csz = HCC_64BYTE_CONTEXT(usbssp_data->hcc_params);
+
+	if (ctx->type == USBSSP_CTX_TYPE_INPUT) {
+		struct usbssp_input_control_ctx *ctrl_ctx =
+			usbssp_get_input_control_ctx(ctx);
+		if (!ctrl_ctx) {
+			usbssp_warn(usbssp_data,
+				"Could not get input context, bad type.\n");
+			return;
+		}
+
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08x - drop flags\n",
+			&ctrl_ctx->drop_flags, (unsigned long long)dma,
+			ctrl_ctx->drop_flags);
+		dma += field_size;
+		usbssp_dbg(usbssp_data,
+			"@%p (virt) @%08llx (dma) %#08x - add flags\n",
+			&ctrl_ctx->add_flags, (unsigned long long)dma,
+			ctrl_ctx->add_flags);
+		dma += field_size;
+		for (i = 0; i < 6; ++i) {
+			usbssp_dbg(usbssp_data,
+				"@%p (virt) @%08llx (dma) %#08x - rsvd2[%d]\n",
+				&ctrl_ctx->rsvd2[i], (unsigned long long)dma,
+				ctrl_ctx->rsvd2[i], i);
+			dma += field_size;
+		}
+
+		if (csz)
+			dbg_rsvd64(usbssp_data, (u64 *)ctrl_ctx, dma);
+	}
+
+	usbssp_dbg_slot_ctx(usbssp_data, ctx);
+	usbssp_dbg_ep_ctx(usbssp_data, ctx, last_ep);
+}
+
+void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
+		      void (*trace)(struct va_format *),
+		      const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	usbssp_dbg(usbssp_data, "%pV\n", &vaf);
+	trace(&vaf);
+	va_end(args);
+}
+EXPORT_SYMBOL_GPL(usbssp_dbg_trace);
-- 
2.17.1

