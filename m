Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1934556-1521830761-2-2451308760980204560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521830760; b=QPneBjSyV3XWT1rH/rC8xLxhboX6UFXHnCVCYXABmVtT1Dq
    ruU2Q9aU3wNE53tHwDNdPJ1Z5ZlwOtziKZNeLKdUXyeX+qbrKNYBMu0aINUGJ4xr
    y5qsV+zTKAEvafyvnDVTEyKAOTwUR9kkhCQNUyBgEgqouSh0pJy/C9CTT2Gj88Jl
    3qk0TB+eUXcUHvU/a982ZZn1/iMFA0TK8Bw1HPIi5YLDy6/uEPOsbn8kN0Uy7ni1
    L90En8UttOWgffrhfbOomz6e68RuwXkmS92GP/jYIceOv6OrqT285Luqc0rmO6xS
    Gub6YBTNX9mkbmd3oTzR8rhrNy0YzoJc6CTPSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:mime-version:sender:list-id; s=arctest; t=
    1521830760; bh=u8pzZ2eKfa34CBk7bF3qezfhA2Q8fFuHEZbBdL80GAg=; b=P
    t5znyUVYF+zAoKV9T0BtjgZJoceO5UBEkl1oiU8/6vkmEROTsrWPca8FWkmJo4lz
    nXtkRUiNGpQgZIgK9wgII5S+bmFsYbTrAJb6w+958imqUbuedfmTcuj4peNiOMil
    eEGQSurqE9Mu6fkf8yBeNjBRawjvacmGLVAyjHYb1iWbhHI9mchcYebal6JcrUNk
    0yRTp8egQ1CmeaOcyYfHL+dzR7LTdCdU/LDYLEsPFNLh3sDLm6T8XkXNn0g6zxIT
    7LVFEvhCYmdhjJ8C72XZCUb19c/cbvcSqzbw2k7rZdt3lQ8zxlII69pvMDPB6v+H
    T5e5/iPIe/1WWbxHeTwrw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCWSp5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 14:45:57 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:14553 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCWSp4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 14:45:56 -0400
Authentication-Results: spf=none (sender IP is 15.219.147.16)
 smtp.mailfrom=linux.intel.com; hpenterprise.mail.onmicrosoft.com; dkim=none
 (message not signed) header.d=none;hpenterprise.mail.onmicrosoft.com;
 dmarc=none action=none header.from=linux.intel.com;
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="25353168"
From: <kan.liang@linux.intel.com>
To: <mingo@redhat.com>, <hpa@zytor.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <andy.shevchenko@gmail.com>
CC: <gary.kroening@hpe.com>, <mike.travis@hpe.com>, <abanman@hpe.com>,
        <dimitri.sivanich@hpe.com>, <russ.anderson@hpe.com>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2] perf/x86/intel/uncore: Querying number of CHAs from CAPID6 register
Date: Tue, 13 Mar 2018 11:51:34 -0700
Message-ID: <1520967094-13219-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
X-PMX-Version: 6.3.3.2656215, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2018.3.13.184516, AntiVirus-Engine: 5.46.1.0, AntiVirus-Data: 2018.3.13.5461002
X-HPE-EXTERNAL: 1
X-HPE-SCL-REASON: TLS
X-HP-SCL: -1
X-HPE-SCL: -1
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 MULTIPLE_RCPTS 0.1, HTML_00_01 0.05, HTML_00_10 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_2000_2999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DATE_TZ_NA 0, LEGITIMATE_SIGNS 0, MULTIPLE_REAL_RCPTS 0, NO_REAL_NAME 0, NO_URI_HTTPS 0, __ANY_URI 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __FROM_DOMAIN_IN_ANY_CC1 0, __FROM_DOMAIN_IN_RCPT 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MULTIPLE_RCPTS_CC_X2 0, __MULTIPLE_RCPTS_TO_X5 0, __NO_HTML_TAG_RAW 0, __SANE_MSGID 0, __SUBJ_ALPHA_END 0, __TO_MALFORMED_2 0, __TO_NO_NAME 0, __URI_NO_WWW 0, __URI_NS '
Content-Type: text/plain
X-OrganizationHeadersPreserved: G1W8108.americas.hpqcorp.net
X-MS-Exchange-Organization-Network-Message-Id: c49be7c6-9aa1-4aa3-a926-08d58913ac78
X-EOPAttributedMessage: 0
X-MS-Exchange-Organization-MessageDirectionality: Originating
X-MS-Exchange-Organization-AuthSource: G9W8456.americas.hpqcorp.net
X-MS-Exchange-Organization-AuthAs: External
X-MS-Exchange-Organization-AuthMechanism: 10
X-MS-Exchange-Organization-SCL: -1
X-CrossPremisesHeadersPromoted: CO1NAM03FT010.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: CO1NAM03FT010.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:15.219.147.16;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:DF4PR84MB0121;H:G1W8108.americas.hpqcorp.net;FPR:;SPF:None;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT010;1:vo5wUOd1JxVO6BTFnkyKEIiiQZoDyJmKQZ1x75HoG8ZjTqwmKV+1HvInxu8DiJPjG6QyROgH5SY2sa7lDEYtBy3derelqRl8J8oN9idun4RScPsFZHoTYJds+y9sk2r4
X-OriginatorOrg: hpe.onmicrosoft.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c49be7c6-9aa1-4aa3-a926-08d58913ac78
X-Microsoft-Antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(2017052603328)(7153060);SRVR:DF4PR84MB0121;
X-Microsoft-Exchange-Diagnostics: 1;DF4PR84MB0121;3:ew6W9QwrfCr9eRt8yMWhEcyCB7cMbAZ6P3S+1buWMjIMA9rXMt16gaerh+mhYnSnltEYYC3ECjdPL32Rs2vrRgUpYrEZLmw7xLWoMpV2Yc2aCxF0jtc4q2cb6+zgytyu4Q89GOz0HkRbVvu3HepH8PzlKAQ3i3KIrE3BA1D/NN4OPQmHWiGvwo7ubysc5NY1Aex/vKDhAhxj0kMDyIqsMW/FDHIMsUdroVnYaqFSUP7sz1RduFa3XJoZVxdbk+JiYHs41IY6u5M9FmNENU/FTQJOEDDOJaPLWNyPxeFajhPepXZ8iitaZXg0desIb4agJjYFJU3UxESlcyyjPVcUXqCOnAV+saY2BIHUm1sZTKbxktR5HH71fCgZpQX7pYiYCrKH2aQYi0cSDfabjuOV7g==;25:8YHW18H17jdO/oudqMvB/RCZVjMZkcHcQkx5JCXe/uFIVRZNSHkQ02AvNByzJLXv03Vr/E73GhBzAMg7bEwaVUiIX+gsqlJHMQeaVZAINw9A/xfHyEIt5cAVMvx5sGUAm4Wq0ImgBA9MQidZDBHFXDLxYDKmFa81V/sDcbiuIhx/+xzKPwKInu6c+til9EOQdzPAU7uELVm8NLxq4P9b0QgVbc9qRUits2NEHeeOX1HvB9mePp+2n8Zq9xZw+w6xtKVT0hNtHZIWW1dPvbC7oOpMl5dZVvoqwH0fcWvzGC8cgYkDyUQjtDdLLp4mMab35Js3nmYswDCz8eSgV8GETw==
X-MS-TrafficTypeDiagnostic: DF4PR84MB0121:
X-Microsoft-Exchange-Diagnostics: 1;DF4PR84MB0121;31:89tpvhpTVkP/W+SQ5kVxYcpp0S9fy5kGGw1hCYVc+H8vq3UIgzQxVSrzGXaY0G+yS93aH3k+XBCLnTM9my4ugTvaW+zTAgi/VKZ+Rlhe4zdH6FuWyLBZIxQLNu2S4Cvz5P9lIlNuSWBV2PUse6r3BxVuinkblrkWNe3bvcj89IPWlhslWIKx5Ep8ESn6e4AGygyujlXOVia1/+p9ssd2UxwFuFXUTeAZyuQe883IXWc=;20:cCGH+htdUimSegeUBICc+wWc4NPw6CMSxefzWy2rchiVxtt+Ffev5ebwLhiFNgcUlecCVTyGpXaDb4uglzVnUEZKXNddTzJd8WrzI7Cde/oGzELxrpmmDfDJlVFaq7BWHyiWbw3ODGcI8SgNjEwRxvw07RnUVdKLO1AVloz2khJCvWanr5f8UzZw5IjD9IJd0cHZP006uyJr5sHBrlQONJPA7tm86uYyW/rDd5EJxqXyUqA9KiwhJoPL3GsiMrod3mtFURLGcvfH0JF0C/Y+5vyOphEWQ4mOhALhC3IVDdBCJS942rgjWDFp2dFQ7FPpOdtqdFHI5ENRLhPcJWmCwIQymT9ONJSKnBrwan8d5uGzxM0PJUTXM/6utrlwx5F8Er2CUKX8yxGMflp3Kx9fs1lPU+kbGL3AgSLBKshQNCWcEABWMUsheCjX+s5AbEs8Un6ykkKcfZ1PFsKDjZwR/pWUDf1X8f1oMz1ibBMp7/gjzeh1BZF4Ab9FLRIoQiXJu/d6pMZmoBmJ9MzjPPrHsnFx4131Y5oOWBxV+t2mc/ICDHnBoJ3X959xhnIC6fkjLWRISb9+CNgb5t2KDa2K2Pld2k6bTiPHHdWzextzRJI=
X-MS-Exchange-Organization-BypassClutter: true
X-Exchange-Antispam-Report-Test: UriScan:(227479698468861)(158342451672863)(222181515654134)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(2401047)(8121501046)(823300181)(823350193)(823411253)(10201501046)(93006095)(93003095)(3002001)(3231221)(902075)(903095)(944500087)(944510158)(944921075)(946803086)(946901075)(52103095)(52102095)(52105095)(52106095)(52401095)(52601095)(52505095)(52406095)(12181506113)(1610001)(8301001075)(8301003183)(201708071742011);SRVR:DF4PR84MB0121;BCL:0;PCL:0;RULEID:;SRVR:DF4PR84MB0121;
X-Microsoft-Exchange-Diagnostics: 1;DF4PR84MB0121;4:tvjH1ot6DuAocBeqUDz2Pmk9UbLLa2AQJubOSr1hYGqyEAuyxPeKSD2sBeterF+lZnuP6aje4AvaImc/93ZVRr45zRTXDDbCxXn2/tltF1vesdiqBLOCNYLoQCZUJUtZtG+w5pW4mtazv9K1NLoVG2X5cL9PsHN2hF/9SzLU/ODfoY5sHwai15Nr4Ld9DfjanHBuDQRhTA/yrJFaWd8RU7KvX4xIPG3ksgI4JszVxbotnTOo+vK9qwrodQRWqobX2/F/C5qZCnQaWpU+/mmFcRDxlUqu56Td61CYb5QUuw6AgA3D6+cGWqklEz8hdYEFkYU6NHIy1yiTNf3nZk91hre/WNw7SoD1ceI4EcUJ9QNx0hKIb8sKbKfHk+TsRy7J1zjlD/KrwXkS/RTU07Ph6p/jOLqq29Y1F92UzsrMqP8=;23:SucJuM5xf3i+nrnog4h0s9pybRGTlt3uGD/FPL8ZGE0Vtqxi78z2WDutCMWgjYdx7etHzNbYIsh6quG+9ijur1CGhPzgUriMSz2KfayO4GK1BSa2337HhejPVyUZxRKb8D9VyTUdQZ5aNBb8lHsm0sgn6ixpgbHmqWmYNHXf7eFv58s2hLGvZtBzgc8yua9k
X-Microsoft-Antispam-Message-Info: On9Djvc7f8j8to2BZcHxGfk90K8lunYCmo21B0ojubTCA/jUZw2YURDWwqBzQGLfutpEFF11IQjBe+8fvGpxMn0z45jj/7aC9Db/hnDk1R0IUEI4qCe2R9ma7tBge6mXmE1JhZnaBxUwkEZ/se7HqyJN9hx+YZ3ta/4MZz9XrRNnfQ7UtH7z+4LOO0eqDead9/Ez8S6IXTGF22OoOWI+GqU3Tv9yF/Ka1/Q7srGdpUiZfZQYFJILtMHBFFeKU5MzhaO/ZjXJ+xgId4J/5bVijuKHu9/HQKM5f1cMNSQQfjpZYLGPQtmsDhNT34mWJf+DAJtmAiq9k4IGM285gVsGgqfo1xyq801Fg3+b375+Ca86JPY12qn7luJxdZeB6okX1nbGVFqVDARI1BhGds164JvL/oEXBf5U+H5Poxpjdy7fYeC5/xFN8qLLw7wZw+3DgrQG3WqIZn/7avbTf2EqpyG2wcYfdWOJC/7pwQZvgAJJwSAjVJP+sxOG1rZ2U1vp7UKLEFdUCT5RlZ4uOS4BH79552n9X16FwkNOW93J9GvzMEbj6RBitqH+98yTjsi2
X-Microsoft-Exchange-Diagnostics: 1;DF4PR84MB0121;6:s5PwJ7DiAcUVQ+r6jv4Xw6+c99KuVuJFh9zvQ1UgaVIL9L8ql7zy5eItb6zflhGGk7aADb9i30+UhQKy9Np3nzRjXDoge4xjUTi006OGZ6hSTAvpLmoKDcpm3PuE2cbdOK3Xb+EFNn6cFzXrQdLzb+F8fSn/jCQj0h7XcZIV5HP4PIVYqzUPVO0ay4zINIcl66RYNw6qHh6j2chGiBnmdw6BCnDimAeQePnfVun9XtNUQp+eNbrWGWFK3fVj2p9taUr2gQWaU4CXD/BfKi76xtLzSPngOt3Y37XGPIvCo5eJx++j39HEndGzrfO6Kinx0f7Qzjezo6b3TjsrntUTZn59vKl48NkKAtt3cv8xWjH6GxtEs/4Hb2PyOFseEUwVbpQLtVmJ3Zoo3/tlKvnLkw==;5:tglq7PMdRKMWPxXvEb4g10VbLUVL1vDWJ4I5MHq7vlS+1xtdqEpgUVBK+xxM6qXTAZq7tPYIDdb3TmXEQ/0ujwQKFAg2HgQlu/y9yKBCt78NKrtANGrSP+qiZHLjAQE/J6cpUJdvbniuivBQW2425Pzj7EXkg+JDhTL2H9ucHL0=;24:3A5hLDrXbl4NKFOIXWHcuO3csMQl9G/crde1aYzGuhVjVz7ClE2r1SaStVHAyhuBpeLrIXgIA0CRCDrdoPvlJYVgBtZVId16fr7yWzBnnds=
X-MS-Exchange-ABP-GUID: 02950aeb-3c14-4da5-8c60-ccbcc3967284
SpamDiagnosticOutput: 1:2
SpamDiagnosticMetadata: d433c49e73c64c569d5100d97eeb600d
X-Microsoft-Exchange-Diagnostics: 1;DF4PR84MB0121;7:oqCNF4500JaeMBhCn4Cf9fKmvUWeGccr9bD2s04JOvx4pqbuVs0zxy1NjK+A7fjRQ3fxgYKLJxnfcqioZzBcdlFQpafDjN+xxiKVh+fZuJBuU4cUYqEKhvmyddGOyShItFitB2OkVWTziSR0e9QLBIi727tqsGZNcw8Cia3PVJLIOphIX4bWPyF+XGGNZd/HZucO4hNMMICYhDAiixen8mtqXmQxZZki2L9G2lrgHMNMSFjJOCb/rnSiH88n+Mxs
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 18:53:13.0953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c49be7c6-9aa1-4aa3-a926-08d58913ac78
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=105b2061-b669-4b31-92ac-24d304d195dc;Ip=[15.219.147.16];Helo=[G1W8108.americas.hpqcorp.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DF4PR84MB0121
X-MS-Exchange-Transport-EndToEndLatency: 00:00:06.9076279
X-MS-Exchange-Processed-By-BccFoldering: 15.20.0567.002
X-Microsoft-Exchange-Diagnostics: 1;DF4PR8401MB1161;27:+gy4D8YiWLOWhZI8Xwq3FaZlzI95TevIWYN9FCE2ZIBP1VgM8ttzFIW70eHa94ev40YvHBWaoxF8r8gEJrUMkix+b24poKXbY82sfq7vGKUYNhuaFx36HR70YgGeKzZl
X-Microsoft-Antispam-Message-Info: CmL7542Bd1nEktfBTrgIVGkr9nzmWVCVqjCwHdz/OEkzSboW4oOk60H6vdAlh8e1QOJORJNRJRCRlo6hf9A70AD7Xnp8jyNQT/l/zgEc69QFiJUSicDDQuAeFD67aaaiVsrbRDd9DO9vxdlyCXqOFg3KMg9TrCsPZpHVGDBO7PgQOdzT9xjZFRi58UkR2eXi4VYNf/w8sLdhsyi/5Rk1OS0E17+LEt2Wmz/59BQ+Ei54pPUYDnNX36ixcBLLZpV9aWw+YABQdPpEEmX6wHhZPBMSKqhHvFnDYjrC1neqf2K9wIgCEx10DSaaSMPRBfv6tEBaDLja4Oj+z7vlGezFp1lbR9M7sY2LQX0v3brjPTujxogXUQzlOh4gjvNPHO/U6pWJ1ljeujJ/0XRGnJaQYZ3MWUnUZrzTFY54Ba68ZJPAZp4Oh2Crcpg0eaBAtRGrQByWxMYzmBXgly4TZg9VcNHRpq5aml3EVIDzRIy/F8qJB554KT77BRdzYbVHiLyw9YA/kuPRO8QCAhNMjzqlzjmm3M2HkyRdgpB+OEGT2bM5I3/5vCgpG1Y1SbdLj4hP
MIME-Version: 1.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kan Liang <kan.liang@linux.intel.com>

The number of CHAs is miscalculated on multi PCI domain systems on
Skylake server.

(From Kroening, Gary:

For systems with a single PCI segment, it is sufficient to look for the
bus number to change in order to determine that all of the CHa's have
been counted for a single socket.
However, for multi PCI segment systems, each socket is given a new
segment and the bus number does NOT change.  So looking only for the
bus number to change ends up counting all of the CHa's on all sockets
in the system.  This leads to writing CPU MSRs beyond a valid range and
causes an error in ivbep_uncore_msr_init_box().)

To determine the number of CHAs, it should read bits 27:0 in the CAPID6
register located at Device 30, Function 3, Offset 0x9C. These 28 bits
form a bit vector of available LLC slices and the CHAs that manage those
slices.

Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore
support")
Reported-by: Kroening, Gary <gary.kroening@hpe.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
 - add missed pci_dev_put()
 - Drop ugly casting by using hweight32()
 - Add comments for macros.

 arch/x86/events/intel/uncore_snbep.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 6d8044a..8970f71 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3562,24 +3562,27 @@ static struct intel_uncore_type *skx_msr_uncores[] = {
 	NULL,
 };
 
+/*
+ * To determine the number of CHAs, it should read bits 27:0 in the CAPID6
+ * register which located at Device 30, Function 3, Offset 0x9C. PCI ID 0x2083.
+ */
+#define SKX_CAPID6		0x9c
+#define SKX_CHA_BIT_MASK	GENMASK(27, 0)
+
 static int skx_count_chabox(void)
 {
-	struct pci_dev *chabox_dev = NULL;
-	int bus, count = 0;
+	struct pci_dev *dev = NULL;
+	u32 val = 0;
 
-	while (1) {
-		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d, chabox_dev);
-		if (!chabox_dev)
-			break;
-		if (count == 0)
-			bus = chabox_dev->bus->number;
-		if (bus != chabox_dev->bus->number)
-			break;
-		count++;
-	}
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x2083, dev);
+	if (!dev)
+		goto out;
 
-	pci_dev_put(chabox_dev);
-	return count;
+	pci_read_config_dword(dev, SKX_CAPID6, &val);
+	val &= SKX_CHA_BIT_MASK;
+out:
+	pci_dev_put(dev);
+	return hweight32(val);
 }
 
 void skx_uncore_cpu_init(void)
-- 
2.7.4
