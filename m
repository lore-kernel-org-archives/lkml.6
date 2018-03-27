Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3595698-1522148764-2-1413482291140341492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522148763; b=gHdYx9983H7yaQq0HoVs7lUlHmK52JXZZIXGgX5finewyIg
    xZYL+wCGw3Na5BQhYmpuWB7hkUXXgQRx3kCfSQmpXmt5kJ+wGWgrtl2wiFCSB5/U
    j53ilSLgnNIhGmEjh7aoAKZNsKbAWtNyhBXUkXzGnPlcV7lCDZwbnuQF8lKSY3qe
    VukDpTrwv0pJixRGF1llTL7D4473Wx04F70G0ZzQmHlMYOsAfNt6hrQQU5S56ywd
    LcQLvtk9BOAZnzVrtGju8DjtejFM3hrf6J/bU4f1YswEKK7w+y/dsd+BZgVyt7pX
    ukQvpouBwWG7NXP/XjT9TaQgLQLEeM0rwAnEgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522148763; bh=gzX42JjLwX5GGXJnAuLYx0tT4J
    ASB2N3nAkcQL1RbY0=; b=kzH6/+fqazBPSWE+PRJfWS2fdGMoxgIPQG6CwsliuU
    6GrMgtT4rNjGbDh4qBFSqvoA4Bub8eIFZv0NQU47NnpuTI0FEVv2EDhs7qLMyoGV
    31F/f3bFgZfOxvBoieoeAfM8SrD/WQ9/XKyYukWzfyMIN1Do0M1uhEcwVv4bshPw
    nYb5lDIHnlUFwODTxf1TmVUuF5Xd8YiLQUERlEwP2NTW3Q6g6Yyzqkx3rK5jfW9e
    hZzCwT/2JPnK8yXkEcLNsQ1JYpR+fJs78wSLDwRhY6kEr6TE/WgvDNR7UUsbiARa
    kLMEvOhnEjP1w7jddp0sLLonz4WRWqGDyjEjh7UA+78A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=EN3+i2St x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=EN3+i2St x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMtV/ZQpcJbixfEx81TJHzgSfpCT+7JrvNjkCInBIeXc92Edmod8czFH6jNoGHw0W15ZOd5hPJps3U5HXU2f3lC2+P7VZ3wB6w3H/tSX3XvjNl9NY14Q
    4k46prbYO6E4YsLwn/R4XfWwaxImm2YUgM63hGlKgH6HTbbjdZ2pnG81/Nn2BJt9VgYYtEVvZSkAXnAooHYr3J/S6uAqpi5kIE6KAp1CHxbimEDJFQVEfR9Y
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=Kl8uKyrRPpMA:10
    a=v2DPQv5-lfwA:10 a=Am4ss40yAAAA:8 a=VwQbUJbxAAAA:8 a=zskknbnjzHmXHE5TJV4A:9
    a=ygnNOpWpCnc35Uyw:21 a=HkFuPzNKp5e22ams:21 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752053AbeC0LFr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 07:05:47 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:55463
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751246AbeC0LFo (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Mar 2018 07:05:44 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <v.anuragkumar@gmail.com>
To: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <APANDEY@xilinx.com>, <v.anuragkumar@gmail.com>,
        <anuragku@xilinx.com>
Subject: [PATCH v2 2/2] usb: dwc3: gadget: Correct the logic for queuing sgs
Date: Tue, 27 Mar 2018 16:35:21 +0530
Message-ID: <1522148721-5744-2-git-send-email-v.anuragkumar@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1522148721-5744-1-git-send-email-v.anuragkumar@gmail.com>
References: <1522148721-5744-1-git-send-email-v.anuragkumar@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(396003)(376002)(2980300002)(438002)(199004)(189003)(73392003)(106466001)(4326008)(186003)(76176011)(63266004)(6250500002)(26005)(82202002)(51416003)(356003)(59450400001)(76482006)(8676002)(305945005)(81156014)(2876002)(5660300001)(48376002)(50466002)(81166006)(36756003)(336012)(42882007)(50226002)(8936002)(103686004)(90966002)(2906002)(316002)(36386004)(86152003)(110136005)(106002)(55446002)(54906003)(42186006)(478600001)(16586007)(87572001)(52956003)(39060400002)(107886003)(2616005)(6266002)(11346002)(406003)(486005)(476003)(486005)(47776003)(446003)(61266001)(45356006)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2257;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT045;1:So1XqO8lmK7mLgvhLz7eOaL5JtTqIy5o9zu9Xp5M9QpUCIfho1gkjo8AYPgtFNyJnRLHSKfqPNNT6TJkrymGz6yZ/eVs7NR+zDCGrXQwgo2ASh8v6yxCVxXDUXrMryMx
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c2bcd9-4a17-400f-2744-08d593d2adbb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BN6PR02MB2257;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2257;3:PmwQRWray9Ool/5LkAYHNIe7AP2jt2W76rsw2WwVoSMU88mG5B1GqOjbBLTBu5oUBrYqaTXQLF4Wlmc1XSQSKPpMesn7QNgf+BpDUci8koRuX77PkSda23sH1GInD+iJWQDMIECJ5PTPcEQlGq5YecWYDpcLDTkEq6hrG4zWtIXHNKTeFVOT8+oim4ZdBGPiQ3FnoOy8mND4gJYLSwJSwnYTmWG7evMhcJXAqQYzRfnfVCzpnfCncgIVE7TThY8u7gvDGKnFo7By7tg0TCxNpZ+bTn/Hcfc6K7QXYOrkwkVIW5mPzFR7sRIuGtBkvQJbxsccu4NiLJBXjxbJfoeD3kYPhm7U+CxcBxPtEUS3cBU=;25:1qm9YSnjy1T1dr9f2+UNUiOBcmGuUOrR+XmLR3GPskAAJKHL8ZFzO9g/VTaiJ1tizf+CqLA2MVpfJo/pX2h+KISLqX+FrZHRUQ2+hwwpZCSANCZfECRGm/9PJI1quBLHbVlTXtG6PIojZx7YbdgKyCBZ+IUqRbeVM0hACvGDkFS3JtX6dlSMTnwqdVPNqVkQO1BdtLEqW5sAPtnKOWxrLv4m0DQVADJ/GgXZcF4yE1Bcw4OR6CHRCYjGwuuimZZuVsYcV2rhkUYitrsFTWs87t5PYbAFct3J756ZHguDeLiIgBPj7QGiye5A84W6ko2qQip0OSjZI575Y7+j9oqMLg==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2257:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2257;31:/6ciNTRJSfN4/1yUso7qPUHUujpeMmwfiVJAmFbdYa7QfaRQnuVY0OvbRQOesuB50JQ12c4taYq+vHwCN4MV3FYeBWXrgPAxW5GxtTXxZkWfIysa9nj5LMoSdzFRSozI4Zx+CqXKKzPYmxFfqhWMOdtJ92Hpxz71L+U4uSi2KPcz0rTS4hQ8K4LtPc8tX5DKbIYoqllwyto8/vCR2PskBWVNztLQ65FlrWJMuMwVPMs=;20:lkO9uOQV0+YtQGASAOCmPwWSzDcsCWruPrFF8AzoGQH+lwlURa4lf97+qkJvNtGGuG/cv5Vz0wyx5f63k5GJ0J5Nmzc+6BlEc5YTe99eEtzgsCscm5RRaO/dKYQ+Y14QUpE9yMEe7QEk/XMQbDbopJctXkRvUZpeGlkofzkHsYAFiBuEwqVpH454c7IcBzVX6nfiyR1cgo4npzYIZ6V3hYEUFJ7yjyceM5jEB0wUcHYr1ZRk7Mn/C17ClhDKEYci5jCer/wFEPldwFxUefALtgYGmZsKRpSoUAi14xJNLXeas17rlAF9Cv5ENgAcSjekgSnEN/kd9PxgerKYk7DynBHCqTzk62KV8/2M9phnJnA7spgI0c9w/zr3VdRvRVwdwCoPQ+oUqoyiyF0W8TrJtlg8Hw2xqI3IECLut718N4d97ebzsLW7NTUUlKY44zL2dU20lPawlvcA9o3fQShsN+93THqhw4ecUY+3zp6clNGbOy32DUQ/GKEZjw3fF+zv
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB2257CB0872F068907A3FAD0AA7AC0@BN6PR02MB2257.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR02MB2257;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2257;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2257;4:VdcuiQRx71AaAIJX0GxDH5SAEvna3WXVbJMqtBtogAVV1jkYVBbfjKrIbBxgoCRm8KD2eqxcBev0KY9TqcaiQ5nCKvAB/WTBR1WiWJiLcczpZXGsYeOcadr0wykpRAag1AZ+iw39qJhuHYLmRRjLARqc9fmMimjFCbfKlt78fDGdmGMvxWlW8aPmN6k1hrpqHleChFTPeySsltdpgYCDqi7GYLIR33YkFoizpbvey/xOq9xc7sf9qr26ZyuDxQAP9TrJpPLVjddkCnq6Io+OnLyiwztXHu/rqfrnweEItplarBdivK7sKmN9SHqrmlms
X-Forefront-PRVS: 0624A2429E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2257;23:RVdV8UadsFCJyPdqDc2aTCcDpnx4aDDgN8dWBQz14?=
 =?us-ascii?Q?jkeyqo7gJK+OnfyBUjp6vxjM5D+8dBLzuM/DhTmsVLEPawtI85jKZO9KNriT?=
 =?us-ascii?Q?hrzFfODpi4aQTBIMz0nSrhTX6PpgCrVzlRkuubtzctEK6dPsFI4CPdaRehgW?=
 =?us-ascii?Q?/7CJnGCCzFd3HhpvoVmFy0c38lPJgqv6gzsv+vpLW4Vli+cqRaDTCUtUZnh4?=
 =?us-ascii?Q?sPoDd7e3hFtYYqxZ1QpVy8oDLzTtMBGa+r8MfCCX0/rZf0Jod1GPg8paBkfy?=
 =?us-ascii?Q?+CYVEeV3NENSybDaWmxyzOA+ZgUag91k8GYXcDyeDgyxFxx4gDkmYlPMvjxI?=
 =?us-ascii?Q?PtJsdi3v9ctNRLSyB4/sTRcFafPcaUZ2A3J4S+XbHYLxsP47Q0Dm4rzdWdoU?=
 =?us-ascii?Q?/8KCFWzcD8EfeGDFyqHEiBpoqTDRJPiQHRo6Crdkfgk5xN26qGUVzwOvTlcX?=
 =?us-ascii?Q?uisVWJubIDFHZhVkARLIiz4tGD/Br+gR7eLJc3E/I52KlTopW1n+5M9AWbKS?=
 =?us-ascii?Q?0YmFvC5GDlNlVIa0XWOE/zlR6jnA5tjc1ktNrItQi5AcsSRekIMvBLR/Z63Q?=
 =?us-ascii?Q?e70qc/RQ2wgAk5xn0pwRePc5GXJhYSNT1K10uzNZ3hwYVUKVy5DqKY3hKOJV?=
 =?us-ascii?Q?jv81Taen/TXQRY+Ti1sRUIDRztXn/agbRnVS8wnDUCX/wlhC6wzOwtaxenmk?=
 =?us-ascii?Q?A/t5FnENVH21GNFdsqg8v9tkxw/99BZHWQv1ODVkLkUMcTee1jCmQkcR7qe1?=
 =?us-ascii?Q?Uw8VJRrOgGpEbaPbFqon5KAk18f+xp/eeamKbhU0rpPq3xwf9yAgQUaQTGEt?=
 =?us-ascii?Q?GBwOJbVj0f9lS/RopYO1FGKHaqcbsJEO3GBvzOhkf52a8UZjMkP0bMiSOsYn?=
 =?us-ascii?Q?KLKPuR33AjPdxi47yOXpjV0DJt6l/s6VOtN+LdZ0N4HtDv4MvP0d4xzRSazq?=
 =?us-ascii?Q?TZnz8TwcSZY4L5XWw+cfWQlpdC8AdWLc4DfDL59foc28vCVW9dI1yNlnUeU3?=
 =?us-ascii?Q?JvNyccrdMHi2TSRoAgDFy4jWIE9BBTMjJDydAIn9TwluEApXucqGXX6TWnbE?=
 =?us-ascii?Q?V0Aps+KIuSGY/39v1VJEHVEM2nsUkkPyL85nPjtTttvhOqfm1Ej/pAVlgfJr?=
 =?us-ascii?Q?yZ+6bLWVBAqFs/3lIaI2h+P/OpZQTxqFBrRCqaj9x1SKgZfYTmXF1L+SPIni?=
 =?us-ascii?Q?gv/doLLoseIMeVYLDno/0sk/GEbsKVWoOUQGfjDrqvj8eincCtxW+n2ta3eW?=
 =?us-ascii?Q?+VNcg/waMTXrdOHRDUhet1v9FrDjwAwLQwhlPD/xohr80KZxjDcMziOcPzGA?=
 =?us-ascii?Q?CW6DdTo48LqyWmt07EJCByiKfXdM+oNfzj+tjFGnbbvmSYfJMDhYytf/et85?=
 =?us-ascii?Q?5ftnObt77hod1DgqcvvI5HZMA/B8Eh1ckAjrVSYnQIMHZqc8gqcYblhndLT0?=
 =?us-ascii?Q?mpfEA+wMZHT6m/18/oVSRUgum7TGeQ=3D?=
X-Microsoft-Antispam-Message-Info: LWaZK7wuRblhcsuF0mwsEi/ucsnsd23V5oBB131+9nnb/cem+ZcrxWR4pIRRDmEG1+3mR11YWuDV5xpVtLUwzJ0CifxnypCWzqswQ1NMdiqrglMs5e2V8yaAyUu+0yiriP2zxxzE9tpgHCASf2Hg9dX/M7F0+Px7MtA1B4Izzd1pHasLrK9DWxiCOzZUoMmv
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2257;6:+BiZmA5PsVStdcAhVZqlZfYUT/WUioP0swMxc9vPU7zEgypq1FDHgUikndj6fo5eR1rW8v6KiVQd7ih0HRaBu2Zuw+pSPmGIfTC0mE4nXwdmK4Tcd5eNXh2CFSu+/sTAwpxLCRXvo8H9OlCIijRdLfDenKpzaKUxx6N9D9JT/fa0EoTQXd7IhkX1XxoIZd5IelmQtlH+CyTQmZRpI8wOQG+bPKJ7V7DKxfm1p7AZxnXmdmsXIX1Uga4FNm+YX1rRdayRUqDiMFc7K4MljlbLJX1wJZiqlTGB6L//uxmpAyjuy3Hl+i+Ys1wFffsmDuFXid8xeXeEtI4AtzNi3FX33pSob2BrAdiHzODm3XXbSZXIg/n8ixOgPsBK2KAusPm3U9JumRM42p8OTQmn9nUO/4TT6/l0nPCWPUwKvmsVy/5KCgd0meqRBHW89EcaM9XrAWTDBDYeyiXDLhFc6XhJeA==;5:ArYiWknyay8oW7Qhv+OJQsrCcgzht2nlmZJxzIAcSAnrcHRqTl84YvRySCxmDlZoW7TFTiV1aDEwEfpRUKu/0V7y/YdcoAvzumw14SWFhhqmWtMx9qn3tR+4NvMrrgC/y3jxWciJUPKRTC0epfb6T8CRPLQ69EStTX3wr9pmGvI=;24:E3NjWksDfM4h2nzBMY/7nPSKJfSTsR6T/tiRFCv28GNJ4b4ju2MuGcpuEV665CsYGKtOdvngMviSxkJ9hzzTt+r8Uugrzkl4WZoRzyt7/pQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2257;7:xWJXw+EFhaYH1FtlB57jW5FYQpU+tdIQJdlBZ2lsWXgoIuY8Pg9B8niP1NES05rOuHxeQphMXnzTd7xu/8eWiivnvk7B8F01kofsE+TLo3aw+ygqBZujTl87Oqkdl468lz2Psm7t9gjhYXUASLollURmLOYTe0v+oEL7FUHUmDnz5bp/ckn+1vquPcnE1m+yN8lI/2d5+Hut23y3W7wifbAdiuwvX5LqjmjiH7K2oe722hxWiT06XYI98wndRWYY
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 11:05:40.6181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c2bcd9-4a17-400f-2744-08d593d2adbb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2257
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anurag Kumar Vulisha <anuragku@xilinx.com>

The present code correctly fetches the req which were previously not
queued from the started_list but fails to continue queuing from the sg
where it previously stopped queuing (because of the unavailable TRB's).
This patch correct's the code to continue queuing from the correct sg
present in the sglist.

For example, consider 5 sgs in req. Because of limited TRB's among the
5 sgs only 3 got queued. This patch corrects the code to start queuing
from correct sg i.e 4th sg when the TRBs are available.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 Changes in v2:
	1. Split the single patch into 2 patches as suggested by Felipe Balbi
	2. Added dev_WARN_ONCE message when ((req->request.actual == length) &&
	   (req->num_pending_sgs > 0))
---
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1406c4f..6bce913 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -720,6 +720,7 @@ struct dwc3_hwparams {
  * @sg: pointer to first incomplete sg
  * @start_sg: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
+ * @num_queued_sgs: counter to the number of sgs which already got queued
  * @remaining: amount of data remaining
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
@@ -738,6 +739,7 @@ struct dwc3_request {
 	struct scatterlist	*start_sg;
 
 	unsigned		num_pending_sgs;
+	unsigned int		num_queued_sgs;
 	unsigned		remaining;
 	u8			epnum;
 	struct dwc3_trb		*trb;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 330a4de..ff62e13 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1060,7 +1060,10 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 	struct scatterlist *s;
 	int		i;
 
-	for_each_sg(sg, s, req->num_pending_sgs, i) {
+	unsigned int remaining = req->request.num_mapped_sgs
+		- req->num_queued_sgs;
+
+	for_each_sg(sg, s, remaining, i) {
 		unsigned int length = req->request.length;
 		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 		unsigned int rem = length % maxp;
@@ -1099,6 +1102,8 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		if (chain)
 			req->start_sg = sg_next(s);
 
+		req->num_queued_sgs++;
+
 		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
@@ -1190,6 +1195,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 
 		req->sg			= req->request.sg;
 		req->start_sg		= req->sg;
+		req->num_queued_sgs	= 0;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
 		if (req->num_pending_sgs > 0)
@@ -2346,8 +2352,19 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 		req->request.actual = length - req->remaining;
 
-		if ((req->request.actual < length) && req->num_pending_sgs)
-			return __dwc3_gadget_kick_transfer(dep);
+		if (req->request.actual < length || req->num_pending_sgs) {
+			/*
+			 * There could be a scenario where the whole req can't
+			 * be mapped into available TRB's. In that case, we need
+			 * to kick transfer again if (req->num_pending_sgs > 0)
+			 */
+			if (req->num_pending_sgs) {
+				dev_WARN_ONCE(dwc->dev,
+					      (req->request.actual == length),
+					      "There are some pending sg's that needs to be queued again\n");
+				return __dwc3_gadget_kick_transfer(dep);
+			}
+		}
 
 		dwc3_gadget_giveback(dep, req, status);
 
-- 
2.1.1

