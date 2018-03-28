Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3011300-1522263416-2-9084353921657570643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Backscatter: NotFound1
X-Backscatter-Hosts: 
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522263415; b=I6OQqbdMC3tpcke+1TYjF/mb44Adce9gMeTixw+YH7/N9+x
    ieZ65G2vEglEkRqxRp487L9VxSHUM2sNamuAVF5fZPu4ztVFjaYAoucJf261n71L
    /DUVIRwZH8XkIYb9sJ8SZ9VLwCsbmA5hACiVRWUJc96DRLBHdGFybN3Ma9I5JGam
    6tYHGZV35apwVWPEJRavApaM1F89EPutiC1NNttZDT8qkpoQq1y+j0re/L0rm3fc
    iKVTStuq2jui89IzdWI+9Dkgf5nZJrvQUhBS3t+EEnVzRhgb3g1pTtT5cXs1qR9h
    x0fhw3+3QcYrPvUcuFnCirOtqRIgpjwwMYlKoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:message-id:cc:reply-to
    :in-reply-to:references:to:subject:content-transfer-encoding
    :content-type:mime-version:sender:list-id; s=arctest; t=
    1522263415; bh=t3TGwN64bc/O5VTCGrjPGD8cV8sTG2Wjt1bjFm5VJIE=; b=S
    L2CjaIStp4bCeMRpF+wwFIZZmE6fI5YHC1Zk2RAaH+CBAwkQlYFcEE3ezxo5QCUB
    XXjIaUvS+hYfFbCwZzCJtHVUXT5+yFiCMsqe0DQJn3rcwnaUH4RSIXiEtxpJaGi3
    Ag8oxPlQzNvkipRMt+pq+6MnyEkPq5r5Uw3njcM5SuxQcnh1lxUvsrlyiWjjVsz5
    2UYjUSj08FrAG2wF7MJfskbejJ3T5j+Ntuun9ClxwNXNNZZhfGsZpp3k4KwY3ymd
    OuTCUJzLLygxsbjoF4J8JPhI+Jmji5Mqd/6EPra+Ub5g4mtDZOH4E/8ubJtjuMkS
    r7UQy4PvrlPv6MmGs2x5g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=zytor.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=zytor.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCSQtUAKJPaHaJ37zWXSv3BheUboEi9FLFws2PgWBBjhIcFz8J8TzL0qMQqxhVropeV5k3vM7HbnilY6i7mrikCvfEgcOXRCBxGp2Lt2d1x0iuT/1m24
    f0PrZyr7lCgF4y5aAt9s5iYbUyxi1KIfxL20KUozZslphc8aZnJEAF09aPhr743iwpKNf8VT62I6RSjsw0U1G/UcObUt7fzOX6fyt4MVP68Wf7MBmwz4EKAP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=P1TzhKPeupUA:10 a=05akU0lRvykA:10 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
    a=eJfxgxciAAAA:8 a=q6kX46jDutFGQ7mHLQIA:9 a=0hHWq9v1XgEHmaTs:21
    a=CF1ZuFEq596og00L:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=dVHiktpip_riXrfdqayU:22 a=xM9caqqi1sUkTy8OJ5Uh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbeC1S4w (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 14:56:52 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:19234 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeC1S4v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 14:56:51 -0400
Authentication-Results: spf=neutral (sender IP is 15.203.227.20)
 smtp.mailfrom=zytor.com; hpenterprise.mail.onmicrosoft.com; dkim=none
 (message not signed) header.d=none;hpenterprise.mail.onmicrosoft.com;
 dmarc=none action=none header.from=zytor.com;
Date: Wed, 28 Mar 2018 11:25:04 -0700
From: "tip-bot for mike.travis@hpe.com" <tipbot@zytor.com>
Message-ID: <tip-bd47a85acd727e27b7283daff557865ad04c59f6@git.kernel.org>
CC: <dimitri.sivanich@hpe.com>, <mike.travis@hpe.com>,
        <linux-kernel@vger.kernel.org>, <mingo@kernel.org>,
        <hpa@zytor.com>, <tglx@linutronix.de>, <andrew.banman@hpe.com>,
        <russ.anderson@hpe.com>, <travis@sgi.com>
Reply-To: <andrew.banman@hpe.com>, <hpa@zytor.com>, <tglx@linutronix.de>,
          <mingo@kernel.org>, <russ.anderson@hpe.com>, <travis@sgi.com>,
          <linux-kernel@vger.kernel.org>, <mike.travis@hpe.com>,
          <dimitri.sivanich@hpe.com>
In-Reply-To: <20180328174011.041801248@stormcage.americas.sgi.com>
References: <20180328174011.041801248@stormcage.americas.sgi.com>
To: <linux-tip-commits@vger.kernel.org>
Subject: [tip:x86/urgent] x86/platform/UV: Fix critical UV MMR address error
Git-Commit-ID: bd47a85acd727e27b7283daff557865ad04c59f6
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on terminus.zytor.com
X-PMX-Version: 6.3.3.2656215, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2018.3.28.182116, AntiVirus-Engine: 5.49.1, AntiVirus-Data: 2018.3.28.5491002
X-HPE-EXTERNAL: 1
X-PMX-Spam: Gauge=IIIIIIIII, Probability=9%, Report='
 CS_HDR_RND_1 0.1, MULTIPLE_RCPTS 0.1, REPLYTO_FROM_DIFF_ADDY 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_1900_1999 0, BODY_SIZE_2000_LESS 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, CT_TEXT_PLAIN_UTF8_CAPS 0, DATE_TZ_NA 0, FROM_NAME_PHRASE 0, IN_REP_TO 0, LEGITIMATE_SIGNS 0, MSG_THREAD 0, REFERENCES 0, URI_WITH_PATH_ONLY 0, __ANY_URI 0, __CD 0, __CP_URI_IN_BODY 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __FRAUD_SUBJ_A 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_REPLYTO 0, __HAS_X_MAILER 0, __HTTPS_URI 0, __IN_REP_TO 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_VERSION 0, __MULTIPLE_RCPTS_CC_X2 0, __MULTIPLE_URI_TEXT 0, __MULTI_FROM 0, __NO_HTML_TAG_RAW 0, __PHISH_SPEAR_SUBJECT 0, __REFERENCES 0, __SANE_MSGID 0, __STOCK_PHRASE_24 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_IN_BODY 0, __URI_NOT_IMG 0,
 __URI_NO_WWW 0, __URI_NS , __URI_WITH_PATH 0'
X-OrganizationHeadersPreserved: G4W9122.americas.hpqcorp.net
X-MS-Exchange-Organization-Network-Message-Id: fb5b8464-dc72-4108-33d8-08d594d94181
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G9W8456.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: External
X-MS-Exchange-Organization-AuthMechanism: 10
X-CrossPremisesHeadersPromoted: CO1NAM03FT050.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: CO1NAM03FT050.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:15.203.227.20;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(366004)(2980300002)(3190300001)(199004)(189003)(6306002)(116002)(126002)(2870700001)(9686003)(53936002)(486005)(23676004)(5660300001)(42186006)(426003)(486005)(81156014)(476003)(81166006)(87636003)(76176011)(6862004)(7846003)(6392003)(47776003)(33896004)(86362001)(8676002)(54906003)(2351001)(218543002)(118296001)(106466001)(97736004)(50466002)(4326008)(336012)(305945005)(74826001)(156004)(68736007)(1096003)(450100002)(966005)(5820100001)(59450400001)(11346002)(8936002)(43066004)(105586002)(446003)(50226002)(26005)(356003);DIR:INB;SFP:;SCL:1;SRVR:CS1PR8401MB1160;H:G4W9122.americas.hpqcorp.net;FPR:;SPF:Neutral;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT050;1:CP0bIx/3/W8Vne/cEM7zplIQh1qwH58TrIsBllJSVc+hh6f/Pd5K6WqCZNFlbTNWaIPDpASmQMrghdB8kllUSCDAuA5Fi7RX4EbAr4SzCcixF7MRYOZceinP+kmc/u0a
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb5b8464-dc72-4108-33d8-08d594d94181
X-Microsoft-Antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060);SRVR:CS1PR8401MB1160;
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1160;3:Cq8Mgti1OpTTS+DhkxbegvkVxHV774XqfuKfVKcdEM+f+ow9KkYaLuii6GzJgK/inDGarpcZ7cwj3JuwvDObV0Y3ZdQdhicZYy4RC38f/OczTFG/bBOvot2hG2DVxvsosq4ihAIIfK14kFRKNpgde5lyFTJ55YCBxhSOsX0OS8yRa6M0RLc6pP5iFRL7bI//RxabXn3G4OdgQADxzoFKgxtaaXndjd/yyQ+NgG1/AHb6pWc/w8JArC/Q4m6ejZS6inE4HojhbJwdpklI3KgGBqFvNFgJuW8l3b4En45IOSvX7hAdL6GRHZly8dAO6LMk2NpqdN+Dgot3Yb5xMcTDCLjSE76hT0gp26iFm0Ufjj0ncdEdLOPPJqQEKBoXGjyjHGyRdBplbpyM0k8DufuY+Q==;25:J0exYHMGedS71TLKCciUo9GsBl0gYFBT8dmuu9Pv2ZZhBPZ9luxSJ67vMOfo/kGnkZyPWAEpWiZyeBkCbgcSr38On3VlTmv/V7uej5B2kogpKw1kikSsEdRdUGwUqQjqsVqO7GT8WzOItRI52iZ3YmemvFRzAHuJObqJiK/268oXkFn4tWkF5m0iAkH/9NG2/oWrKDSkpqzEZqyckGlV0iZfsMLW2YUvuVvxPtHGPDiEhp4+FABTz5IAhYvmErB621vfls2+gq6oMJXrbwTcWDHwkRahmiylAiPKgOvIcwicDQY9mKpEk3m9SXHeOhcAXsbX4QyBMc4xeDMZarm/BA==
X-MS-TrafficTypeDiagnostic: CS1PR8401MB1160:
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1160;31:iqmbycgIEBMYCyd+G1GPRUEeW5WMRA0YxfHQgvrFowwzop+D6s5JLZ7vGVDfmtsyrflehw4of2XSUyqOMmcBZNHoC9pbOea92Y0wnvbF+vcPuRKuxzcTQu1ZWuSg639CgklqQ+R57YkPhfZdho0YR6wuAtVOt18cP4SHWVRN+7K9XFw12fDqqW3saJvrTL1BKh2FXnITLO1w1JejuL2DAIIPHhuj+++cfDx3vPUC05w=;20:vlYKxpUho/Xe4bt2MWR6msDfjrp14fRPKy2H1gCy6CmFN4wz6qnm5oDjcvFzxy4+LYLGvhtwkTWeV0aj4Tp5Hj8L7gd4NDaLCs4DkbzG2/EjccqMqR2e499mAMOklfqj/eaQImcdOxv+MfPLlmBuxaI4K8DrPUi4B8wlyiwdYXGPOvuis/O0uB7AJKkaLOka3nQOqJnihf53UD3JMDreB3P1ce9HhelEeCgf4pOKZiZ8h5yCZoeitTge9Fz8WaURkdsrlLSX4OGG32tF3hoWo0iPKq+8WQriOBFK/rpszrCUVZYttr7DyI0qxZJTNSyQza7u7vjsuAg+55p8BrcCfEXX/YKtLlhpaTgKNWUh0WuGSwXuHUI0TRj1RDgQw/wWj0CAt83l+g3RxTnT0p/h7x8/eEgkWnBahiXrURy2sqGR3ksGvtyMPlBlUKsQBVXJAu1MZTbyrqV6VgGUCAjmjwv/lFp+h4TYG8pEt0bV5p3OaQksjrdUVnEsNpsvShHn
X-Exchange-Antispam-Report-Test: UriScan:(227479698468861)(42068640409301)(84791874153150)(222181515654134);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(2401047)(8121501046)(823300181)(823350236)(823411253)(93006095)(93003095)(3002001)(10201501046)(3231221)(902075)(913062)(944500087)(944510158)(944921075)(946807170)(946901075)(947906075)(52103095)(52105095)(52106095)(52401095)(52601095)(52606095)(52606095)(52505095)(52406095)(12181506113)(1610001)(8301001075)(8301003183)(201708071742011);SRVR:CS1PR8401MB1160;BCL:0;PCL:0;RULEID:;SRVR:CS1PR8401MB1160;
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1160;4:X1ZcZ5oOjIgAH8seHzy8DBeVf2MUA/buaItteI94wTR/dWZt3o7oBrx/cvezFZAwwuTwa54nIMKAszZajcYHnL6bTLp2xRK59V6FcYy16SwnH4+Hkl/Wip5W/OinUDYrjuVyrmFo/VpAls59PCcPzBMppDNyrH6TykS3T8yKAxOpkH+341sOb7mvL2JsMqcnU425myvBNuxn8S50qSIt9uUc+yyzB+bAZFlWnPTKU0iL0OK7TBpeBCGOynAsIN+yBFA6FB5telhwQJ7Ie6LgiuBI9dGBj8qO2UWhjReR63suVZqPS0VaIT/O8TSSWVmNfyTmWu3Py9HEJsImS+y5Dhj62kIBfeWsosvd49H9+XuIV6Akbtyeji08kDVLKcUo7+RVNjGJeOVmipmCk0UkjZmaGrDaz475qpFG5ufq+Os=
X-MS-Exchange-Organization-SCL: 1
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDUzFQUjg0MDFNQjExNjA7MjM6SWxpd0RGWmVqRjY1aHlnQVJZU1prNFdU?=
 =?utf-8?B?UG5xMVVkV21hYkV6bmpUMHdCVlR6QWNTNnF1OFluVnJualBtQ0JDSEluOE5G?=
 =?utf-8?B?ek9zSmRUR2Q5RmdkdzZQQjdFSkt1bFZhU0RmZlA5eE51NWZUci9hbzd6QTFN?=
 =?utf-8?B?Wm9tY1N0OHVTZFJEaCtic1o1Q3NPdDZCWUhZUDFNM0k4eWsyNUJxbUdsaUV1?=
 =?utf-8?B?bDJrS01jODJxQ25GZVFIYTlPYmN1WHFMNXozb0FVWGIyWXdNbFpWWlFMbVFs?=
 =?utf-8?B?RjZ4YktiY0ZiVlBrNk9UUXZJNXlTTXlNd3lObnpZUDhQNHRzVHQwc2tRdENY?=
 =?utf-8?B?dC83cGNLUzZFdTcvTXZrdFpVMklEdnhwa2ZMM2YxdnE0Z0doMUFmb1R3aTFl?=
 =?utf-8?B?bWR0WVUzb0ozbzlZMWdoSm9vWEttMFRDQWZyMUdhWlRZdFhscGVtSHZnMWhr?=
 =?utf-8?B?QmxjaWlIWTdCRVJHSXJld2pnbng3c05QeTJvWDh2dHBEWkVtMHBqZ1pEM2Rm?=
 =?utf-8?B?OEpvSW5uQmFkMVhaSGZlR2NkN3kwK0ZxT1dvenhrMzR1d2NHKzlCYU5WS200?=
 =?utf-8?B?SXN0eUU0Nm8rMXViZmo4b21Oc0oweEpoeERoYUlhVmhCL2NtT1RQNWtXQk9v?=
 =?utf-8?B?VzJrZjBkUUxyRjNjTVBJMGZZWDMzOG95WHB6U29oenJRSWtJU2NBblhWV25Y?=
 =?utf-8?B?VTdvOVQwenBrQUhvUk1EK0FVQmVabGUvekpOTWsxZTFyemo3cURnOHJrT3d6?=
 =?utf-8?B?NnNFd3p2UGVyRWtUYzNzeGlsc0tvdjZoMnZiZVArcDc0ZCtyamZvQ25LemtU?=
 =?utf-8?B?ek41Rk9TM0I4TU9yeE1mOHdEbUZvTnNCVkVYb1hqNyt0enlrdEVrZGxQZ0ZB?=
 =?utf-8?B?VTRlSWpZM2FkUU40d2Y5K0FObW5Za1RMRmR2dTNscFd5TkhrM1pMM3hhUUFn?=
 =?utf-8?B?MUVpbE9YdUlCNVNUVUF0RnVmcHRlV1lwNWFUMmwwc1hTeUJpZWhWUzBhVVZL?=
 =?utf-8?B?bjNCS3ZoSVI3UWloQUdWS1RYdGRmNEthWHMzbmR3bUlaM2NMeWtMNXJjbjRF?=
 =?utf-8?B?MUlYdklublE5dU0zOEdvekVSL0VlazQzRVZXSUJuRHczUWtRQm5vL1J5NWhz?=
 =?utf-8?B?QUJTRTQwZkRxWi9rWi91MEtvZ2RZU1JkdTYvUHlXTmRXM3dUOWRWbUhpLzI0?=
 =?utf-8?B?Y2ZyOFNoREF0MUF1S3p2QTExM01MaDNRSGVnZndMMlcvdnVQSSttZmFnTWNx?=
 =?utf-8?B?d3ZqbkdsaHBhRGVDUFY5V01EVEQ1RXBwVm4reXJlQkNFaXhoSksvWTVvSlFv?=
 =?utf-8?B?dzJ6SEpFM3dVY0poWExGYzlCUWNGZmFjTWF2ZEwzNU1xWUVNRGhiMEo2anB6?=
 =?utf-8?B?ZmxBQjBkWERwajB4cklEZXNwMFZ2Q1BsamJwZTdrSFpwK1Z5UGdzUmNjYyt3?=
 =?utf-8?B?Y1p6UWdmb3c0VjZBSVMrUEhSb3VJQWRNN1lJa0l2czNRU0lsTkIwcm1qdGdS?=
 =?utf-8?B?bkpnWFozYWpJd2ZmbExXNUM3TUZ2bEF2OHlJaHJQWHZ0enArcEF4U2VCRjE0?=
 =?utf-8?B?V2FjaEluSm5Yc2xNc21KNFBvUGdMQWgwdzFKMCtDRzhGejlNdC9POFV4SU1z?=
 =?utf-8?B?RnBWT2VZaWU3MnQ2UVM3TVI2R0NaTWJ3cVJPcHg5eWUrdG9wc0V4NEpSZ0E9?=
 =?utf-8?Q?=3D?=
X-Microsoft-Antispam-Message-Info: ysaobolP14OZwRsrL8yGMx7zz7enHbTaD14Ox+1fmX8UiEyd831+aLltHQI4kHSTFpQIo1/+fsIV7AJFXPsZnuMM55lDbCW2QSINk1XtBGhcnSmDtV75z7K6zlGIzgZrgIXcX7oHwE/DFb44vlbxmRQO7h3TcItlLopld61mWl0idp1lJwDbAbbB008jZrbmDs1XZW2M9ZY2zK1AntHEmTyMCBtV7jpKw3jGkZgkYJRA5/7LyVKqn34ADF9iaBEXIx1fOlE8p7qZRyCDtBvjywToBLiwgHxBfNqR3/7TChXbKKYAI8vx484Xl+Y6Bg3WXhQwyJ9Ktdh7RgYDfb/1jcR2JmdhOjd0JCNiQp5yMKqEw2qUOLI1sPOCHBi38f9+at9U31+IV85V5AnilTecnLmnlvlV0mnqR+cw9fe8RECKt5weM9IIazBYnNRUlFlHf20O9GjND6/8yewnErwdGJQqjREomUP8nZdcrSOIdwADD6bf/87qDuyZiS+QRifv/fOlCp2/8Vi3tlVIQO8+UFKq6/LqHBH1XDa2TkQEfDU=
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1160;6:t20YR6+iKummHorgMfekaAsKB0Qke+z07qW9gY7Jur539Gx276mUGgo/9p9h2054jcZa78685L6lo4iEmK51Ju3iH4ZJF1DzOyP3muS9nx316rkhs16vwf8ek5EYAWMxq1XsRGDpuhbHMDOjpRhZrsPcB5Ie2tsg+ptMq96zaJlNMXB5h42NgfTTU75FxYrsUYe66sg3YoiNIYT0RXwgIYqhrpfBKGtvemPd4z1ez5peJuku+kTG6m25HJ8fN5jo0Lu0/wrhUw7bigz1Okjwjwkkj6RMdvhW438x1DyZlFu/pLQbWczKxzo9hzOPgJKTHH9nux3j8SLzIvPEu+40DHdmC/oNjmBvzJsV5TBR7LAF5vk2lIF/mD7dJdNo4gmS2BWFgqYmhCSXganSJyfv8F2lobIr0nxCKs44rBNhofOn34XeMeoPDPgyGYvcBHNAyc162dJEn0ozADGxi4xYrw==;5:VUyolZAdEc1hkMdUPOlUjUyt4kHTDLhRnC567fph5c6mxnuacv3zEF7wV9sng/sMTiRP2NOtdvDSPQdu78ThwNcPTWCCGdr8k6u/HQ5rljv6xdh8iu8A+fqU6a1h45HdBq6IDlrxm5EwBPKqHtIvEwTjaOKGm17CdDFyAQzJBHA=;24:SDoHs8g7btmXeuMWYgjazHMtyGu5Ab/u8YPy/pEhRPEu4ckvG/0QC70Y56Y5EdA/io4Qk8VxbHxF41w0YrlagwF/Y+idS3lt5sYEl6pEfa4=
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CS1PR8401MB1160;7:Bagmxdco+V6w9mMt0LUgOS7Ip8BzEf4JUNG78jcl2w1dks4pWBPnDuaMS1J1rwdg71qJCgpAxgxwrypUzCOpXPTk4E5ndK9/xhJXO6e0w1M5LCdIYUq6yZEkmewLxfMjNndWQutQOdwFjg1ZW+OE7x2NUUpEMM+1KdkLRJixabm+H97aWT48YpzL4vkl5X76mwafmrr6VE6WPUk2Sy3P6Qm/sf23/0AbmBNx67NXdYKBVRfNYl4A9CMImJnNr+OZ
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 18:25:16.8093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb5b8464-dc72-4108-33d8-08d594d94181
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.203.227.20];Helo=[G4W9122.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB1160
X-MS-Exchange-Transport-EndToEndLatency: 00:00:01.6325101
X-MS-Exchange-Processed-By-BccFoldering: 15.20.0609.000
X-Microsoft-Exchange-Diagnostics: 1;DF4PR8401MB1161;27:TUqD8HEBl7dQmBdw3I291twNwjfKETECctyLWZUMf0AHNQ2xF62g2b5E+FFdcUKRKr57ohwtkE2zWOLcUJBtzoU1xDlx9eFHgnLOJEqCGf+SEvEx51qtlmnPhsTZQwA9
X-Microsoft-Antispam-Message-Info: UreEgFHLxXRfsxMVzpArcozDNqd+aTeMKHopxYXCn1psWzBe2hqSTrRRpLt9NRFWn5cLwAFiv+pMmgfNpjcwCgq+MbGdHCjbHPgIEY7g9k2or0T7Q5+KQrS/JTXrFLaCppE/VuRc/cQnGifokgkxaauw1FYfqM490Ma2pRVF7m0efsu2rO0qV5BtRAHNT8CIQ4+bus5ae9NEv5evH8zp16I7VEoAV+fUXAMBoOcpRPACAY7G1c8nr2qFpCbdBfADi+fVA5xIxqv4eUEEzmDeKyv8xdycLOMeds25gbk4c40QQownPxV3mibhZmbuJHSkLKPJc4xXVnnf539w8pa7jIMvNEWnC370m3w2M9Vqz2pIdZhFKxK5UeofD/SfQXZx6itubkNtBLhIUTmXz5LKqhq3HL+Pq4IsLD2Qp89HsdHLeWbeIGegvK+WLvUz+sB0tyO4z8Ufa3gXdWaGAmGrz6u/4fgZn6gyTcak1Wshjw1ZLshChj/l9TjNRYSjxmLr61nLT4vVGuJjDcFhSfa2qrwQIG/wQlQZBbGpD76+gvo=
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  bd47a85acd727e27b7283daff557865ad04c59f6
Gitweb:     https://git.kernel.org/tip/bd47a85acd727e27b7283daff557865ad04c59f6
Author:     mike.travis@hpe.com <mike.travis@hpe.com>
AuthorDate: Wed, 28 Mar 2018 12:40:11 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Mar 2018 20:19:45 +0200

x86/platform/UV: Fix critical UV MMR address error

A critical error was found testing the fixed UV4 HUB in that an MMR address
was found to be incorrect.  This causes the virtual address space for
accessing the MMIOH1 region to be allocated with the incorrect size.

Fixes: 673aa20c55a1 ("x86/platform/UV: Update uv_mmrs.h to prepare for UV4A fixes")
Signed-off-by: Mike Travis <travis@sgi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Cc: Russ Anderson <russ.anderson@hpe.com>
Cc: Andrew Banman <andrew.banman@hpe.com>
Link: https://lkml.kernel.org/r/20180328174011.041801248@stormcage.americas.sgi.com

---
 arch/x86/include/asm/uv/uv_mmrs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uv/uv_mmrs.h b/arch/x86/include/asm/uv/uv_mmrs.h
index ecb9ddef128f..62c79e26a59a 100644
--- a/arch/x86/include/asm/uv/uv_mmrs.h
+++ b/arch/x86/include/asm/uv/uv_mmrs.h
@@ -3833,7 +3833,7 @@ union uvh_rh_gam_mmioh_overlay_config0_mmr_u {
 #define UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR uv_undefined("UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR")
 #define UV3H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x1603000UL
-#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x483000UL
+#define UV4H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR 0x484000UL
 #define UVH_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR (				\
 	is_uv1_hub() ? UV1H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
 	is_uv2_hub() ? UV2H_RH_GAM_MMIOH_OVERLAY_CONFIG1_MMR :		\
