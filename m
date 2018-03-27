Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3592446-1522148751-2-3651326329682429129
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
    t=1522148750; b=rUh98pd/GrfJIbIHMM8RchTgCsJm/PlnW9Mv0YezIjQFhvu
    EvPaNncYRcfyuptvFAUghCaJIAsdnGcGGbjJFRN/S2FWqkgBz4ZK75ALmez3qpOG
    1ot4+ZafXX9FWoHXORwOdvmeVwCa618nzb/NKapQZULempzhD8fMjsRuj7eEOAnZ
    9NvEsVAVVvgr5d+UJQRWidv9vgEJq+Lj6ceMc22IAmacU8j7QiGyj3HyLM04UmIG
    kaFRF7riN6OzUi7kDZnyfKvTXCqyZ3Pix7UGJn9DEbNUAtOcWaw9N1djCH8w5zCe
    MZLCQycx9fUaBBIxxoc+wDiY7OmrDhG1YPjTRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1522148750; bh=YsEPgKMknf9VbWKt+5FoLoD013cmmwhr07FWfzvE42Q=; b=e
    MwMRDDONPD2ozftk4RhNPF9NpSBp3NuvbKxF+4kIFPE63D/PESzwCoM+zam70aY2
    zddJGOd1ZOusb9uD+gnXp4nhJttambSNgEEQ2XuQhAi3Cobd1LTPsqGOw9651BL/
    Pve/Q+gMER0ABZofYrGDENEG7JswwTs//PHc9FAsicdf1OPoT0cmY+kWvJbvThIN
    jxv7MlwGNfeRRm9rhP0kA29whvtYHwPM6jLuShsKnBO5k0jbsAyKwfeRl/DK91dJ
    TW8NptA06bNmX7bNcpk1aDP3eGxzwjmWzdGMhDzzgYUai9BvBffrNEnMDJQ9f64w
    dgDxx6VnUNbKXQIBEn55w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=oEjZX/lo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=oEjZX/lo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC6ysRkC5aoTeKHldRvDEuSzmRzS4KkfZvQB21btu8adKIUanWMX9YmiV2NlapW8aAHu8zddhHM8XtN8SCxYVr9Rj/kdfVfheCaHmG8+HWftx0VxUwUc
    +piT7r409tI8eSYcRg4ehM43hgFFwrufTvKdNApps5CywGGfQdS0CfjkMauhn8N6eW4mf01kQZB/NVsAL5HV6WyYYegp5fsA9JMwDAOHiTdW4LwQWtgZ3u0C
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=Kl8uKyrRPpMA:10
    a=v2DPQv5-lfwA:10 a=Am4ss40yAAAA:8 a=VwQbUJbxAAAA:8 a=sPvJsLco0634SHSL3IIA:9
    a=0wifVkHyRKilrrn5:21 a=vn_4eoHKoosBDELx:21 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751686AbeC0LFp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 07:05:45 -0400
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:19138
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751205AbeC0LFo (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Mar 2018 07:05:44 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
From: <v.anuragkumar@gmail.com>
To: Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <APANDEY@xilinx.com>, <v.anuragkumar@gmail.com>,
        <anuragku@xilinx.com>
Subject: [PATCH v2 1/2] usb: dwc3: gadget: Correct handling of scattergather lists
Date: Tue, 27 Mar 2018 16:35:20 +0530
Message-ID: <1522148721-5744-1-git-send-email-v.anuragkumar@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(39380400002)(2980300002)(438002)(189003)(199004)(47776003)(87572001)(51416003)(6266002)(52956003)(2906002)(50466002)(36756003)(61266001)(48376002)(107886003)(103686004)(76482006)(4326008)(39060400002)(2876002)(106002)(82202002)(26005)(486005)(476003)(2616005)(6250500002)(42882007)(486005)(336012)(59450400001)(36386004)(73392003)(186003)(90966002)(316002)(110136005)(55446002)(305945005)(54906003)(478600001)(356003)(42186006)(16586007)(106466001)(50226002)(5660300001)(63266004)(81166006)(8676002)(86152003)(81156014)(406003)(8936002)(45356006)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2267;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT056;1:hIVOmyJYTmbgT0cW1GfMuBtyOU6berfL7Ln2GuAjBcuVNx3uXgJCsspv5DdfacUQVmG1LTZ3QF2dn0bTFi4PlV3ECs4XuMdnLiBhFzFQ2lqX4Mxi1ziJu5nE1u5BRpPg
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb039b7-9266-4aaa-bdda-08d593d2adc8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:DM5PR02MB2267;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2267;3:ppGxrBbxFrwpKkTtOB7gOsV1WRrFyynyaLwMqjTo/VHu2/e38BBkCv9RzLoy1HnPUF7dYFNpP8wf1f8dKJL8f/vSTPnoV+3t2R13XZb8bIGJpRBLosWfuqclaf0zdq9pvEtRZCEOJroQWaMcGyIyde0h+zdOsQhpec4AN47qNu9Wq4IcBhc33m6RfoOMRQAdred0VzKf0JpolaC2aoUVN5ZwK7FUzZ6XAHMkVIHzkykd3ZOmEKPiswmI931VL+CBKiotuXC4dzf5PZBlJfZciQCHpmG6eQMKZSBM6+WIWuL6DOoy3GoGtfQvi3DDXM9/30/uSUDZMfvNwaJbSMixb7KfBuCw4uyDw5qhbfTUzCk=;25:qjRjsycs8Nz0EHbX47K1u8nAuDyCfBeOXrkZida0KOIVh8oJ/vqaoo4omxgNa8O1MvLSUnxcGWcUNR18kXV8M1/YpKqe5Qs9URBOwGAxYEbaTq9kOtB6/8L2IU/RAh+h4szIiAQsF1+O7+ZnbmXg5vLn559ktBJc4ZAsyJeCnsp50lh/kJ3pWFPOKuwyeqhQIp52AWAuVohVC7u16Nmn2a5aeJqYBRxa6Txsd4LYL/0EMcFVoNTzrbKQa/tGOld+vFAdDhj9wXNCPSIAp7ato3AcHAdfGKYMIbXfuuH4Z1mnfBVLLHCLXqKF4SfEpYFovtbFR5K4dmGVEvfPdRaJQA==
X-MS-TrafficTypeDiagnostic: DM5PR02MB2267:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2267;31:55cz/2zoRJTsnIUlplNbhszqSWM+hzu6s4AR6JWDkdQXCt2dluwxKGOB8flNM0bmkGNigxSpmd9di7ixkdOeX9/xDCV0XjjPL8jR9DmAg+P76kfVscF69gV6p34V6TyJAwZJgd9ePmB4o3uazhrTxnD5itJGsZsr4LHsFqhxq/7ey5+TYHPEBamGrlFqQZtCGoJRSR6p5H+jIyQ8fIEcHcTGJ1Y0Jxe57r1SWiOx4bU=;20:2MUmkXbsbIWXhzf8QOjg1SlrfEGTQ1ETBXrr41WseB3okLM5aXOxXZW2mW/ah5CGhuMyX7uNEZ/m5FMAjqAW8GAucs+mrsrQTy0OqlJTm2CH7OUMjSQXv8m+fleigjVc4NjCZfkFihDkQYR+nVlevqiE7XBBPHNYMHLhxOMJZmxuVXamtyKBadmGuIZJC7FZI4ybHZJL+7/2NRTNCCEblBFhaECwjGbsEZaG4uy4nCdhZdBSdNdeMdFLph03WsIBvJeRW5MUx2xxGeuebgoJyG+HZC39dvouU27gzxsa8jT6cu/w0jPgvdX157UcrtkMpzxngyZN7Fj1xyHDSrInW2EoNOt2oQtS7jmwNLAHdYpkY5VEVqZs1w1ZjvOpSNgWyTxO78HrxCEpwfN9d2RWQE4mScazj23faaQI952Rccv5x89J/hGWQcHNzyLnN0L9K/uXifPRwUCqUioNsOpCzLIVSdU2NJH06vQJQDJ23xwyM1nFNlnBIq0VcVeUhsTH
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB226761E3497774894D005B73A7AC0@DM5PR02MB2267.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(36289512736943);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR02MB2267;BCL:0;PCL:0;RULEID:;SRVR:DM5PR02MB2267;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2267;4:8WCgFIukKqqLnv4zRW30x3liZC7Yijc+3FwYkgXV2k7wJ82Xc48rj5L5Fj4Rdu8BFWGiQBsw1GLg+F4/Pd59yEYJPEu6gSIldPDth6yyU58YrZ0upfhQ64J5V7AiQ79Dpdnr/q1wRkLRr4swyfZpU0VJr+mHhm5XmdkkYmNAy42SN69DuCDZDi/aI3Bs8jGsDREdEpp1E+fD9rsrmXdAzj4rHHBwHZDtuM6Y1v+f2qCP3rN/G6G0yQsm+jldSCXeF1Iv60xAB407E5KYV8X02aZr4+jCNf/AtJPouA/CTEjk+rDfgMHr12xTwog3d+MX8RMPJvN0F6AUS8qAxa0IiFaVPN+Ac0/fNjSrfHOrqEw=
X-Forefront-PRVS: 0624A2429E
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR02MB2267;23:pcWhZDxWSfRjyvq/XshYfHxbkQUzNSQOVTsd4RGNH?=
 =?us-ascii?Q?nQ4IWOqjEzloas5fiTPo2UGbjhTOXkO+Oo2TTaCv8QR6ISoo1c+TEXvWeNAK?=
 =?us-ascii?Q?0fkLzu9jx8tDIo9CS8e09QEi4nlQo+s5leOdlXkrU60Gx7cr/icK0K6ERcEm?=
 =?us-ascii?Q?UuOp7RPawoaZhkaZwtHIR3QqGUjUgdwZUPC0knpSF9Z1TV7GjQhiLz0ebeeQ?=
 =?us-ascii?Q?E14gDLn6ULrhIo93NcWC0T6+tqHyGrtUqF1q8c641snjwFHMa+6a50hTd/cY?=
 =?us-ascii?Q?1FDCUIpyxyIEAiLhhTtiHe75yAkdziGy6wGWNcgzFETQR20D7iXjduYNXjm2?=
 =?us-ascii?Q?bkL88FkSafNTTdtOjEvtz6DRrLzXL8l2gwAljUHGd6uwR8KoeLqFilYwtXw9?=
 =?us-ascii?Q?/tpsokVsi3Qarjfw6FCjdM2ZzPmo9DChUduhF4m0N+eH1kNXb2SYeBBK2YoI?=
 =?us-ascii?Q?XwFj+DUrfdXbgRG6VbPAOLuTkqgXgtMgx5vS1S1EfRXtbp6OkyU1kguxc5vD?=
 =?us-ascii?Q?6wKhSDm50OlQ6ANUYYuZZqzr6QyQGODJtBHhcDvS2/+hniyjw4JwAyA8aR5s?=
 =?us-ascii?Q?qzHqk66NYefqRAkRLi9YvNnq4SCioAMDA8TtI6FJbCfqLXPUTILX48Z0vPyJ?=
 =?us-ascii?Q?hgIWp0WCDFiODC9MRd30L2vNQCVbjjxS4ic77ef7nyWKkumXNIFfXkvmvdAB?=
 =?us-ascii?Q?bxrzzZclzHQQguRvQGjJkOPXNF2BMzJ8NoCl/LbGh6nQiU0x1E167qtTzIxH?=
 =?us-ascii?Q?6DiRDPF6I8FXrCQ0K5FL/gXsUAjQf7cJjQTExHwsz2BgvkoizElW8abn47+c?=
 =?us-ascii?Q?GZ78zIX4X9D+y/wwtaNwOUfq4e54qXzX9IsztEwZw2kMvQT96G2tU4W8ROf1?=
 =?us-ascii?Q?Syhu/J0q46+qVdMQDHB2dngGtY2SDmSD/pMvQcrYkIO4sQ3Hd/mq+OlGRP5Q?=
 =?us-ascii?Q?lNAPR0lXnYnVGis6F4eQlf0YJLMJQLOx0VviaY5bjASL1YjNRw7+OQWHYACm?=
 =?us-ascii?Q?FhrtZ/H7uZS02JIAriOd739gAAeijyegEB5EGx0yu4Okon1Hfa2U8LwxkGzU?=
 =?us-ascii?Q?3l5CHmts5ZfN1nI4EfNIrDM9r15T2mlhfgS98ks9tUvoYWvWlzKzqJhNH3O5?=
 =?us-ascii?Q?9YUFy1vz1NoaP0Kvpg2UZSEKQc9fgLDkVkYtapufwh4eq17kumXmsuaoLr8Z?=
 =?us-ascii?Q?6W82mnMSRERe//BOU7rp7G5anjDBKwszObUgTc5MxJNrCd8vs6m+NfW+2VM3?=
 =?us-ascii?Q?VtAHflWXIQtVLiz1kcO5UJb7bNPSX5knMQWgm0wdEhsPe5cghK/mrcpsqLJj?=
 =?us-ascii?Q?lmSE24ktxydasJ8DCdBNBwQ8JgLXbhoISpKusf9I/NPZ1by6MGLElTmaKhRc?=
 =?us-ascii?Q?J2UxRIYukJrhgZAmz8yHkaUBlcpPzdnBDcxynJj77TJgLGwIsKAZj8GQVDVx?=
 =?us-ascii?Q?ssNKX93qg=3D=3D?=
X-Microsoft-Antispam-Message-Info: B2XlxmVdOZ+IGP03zi5/tTwodtjbygpZuyI1Rx31SeC3DG9hBPwy3MjHGqTKix6QXN419yt6El8DLcuzeTb1tcX5M2mBRcoY3sunXIGnhJSXInLwHRuUj7BFv3y1oUsqFnA5WTk6aw6apdat90ISj49iIxhBY6zMFBz0zRELDWwgbNrW9YrXSpT19ofH4iWD
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2267;6:RJGwUs7b2g7O5pKlz0UnjVDVmkaddSSu6rt8vv13UneTWEkcJnJPp9ddQ44MTIW6Ii3SgLibV1uO3Rrht6ijcUM8hwchIAEVTzkjgejT/OUn6b7p51BNCRQNCPGlOvfjrJIvOCorsMbSfzEiMYRT1C5OHyoq3WPax4nrIk45IigL/WCQSeUf+9KlqmNhhDQ2G8cGTgiOg5Y3o3xNLUyBTMYj83rJVPktLO9g7rbh30Ww+xl2cSbC32rkuyG1nH1VbR8JlXp/4tPftnMEnOpBLg0o7KAZrQW4jwFEK3RUw450SZNedIpZ1gx+Q8R6ABeKG3tN+QPWQL+6ZyK2KZCtum+auJfQB/8D3wCYaXa124YByeAZwsdGVAmGalMED8i8Dit2f7z5rA9+5Bsh4ixhwK2iID/fujybUpnP3Pvm71PfmA6Yozj1CsELWdtsdzhBZnZm4slxubx7Wv1eCgxVXA==;5:0W6c8bv4oQ5DUbWsXWwgKcg2OitER9nTuC46P0ElISKoHuqKGH+zpa79csn3kz+GnbnqN7Ex0mlzh4oM3GHCs03MAT67oL3BjftBXgOmz1qFI89epicqMqS7TeObufSg739mvg5f+lc67HEXjg6Nk3m2yPxwjWHboIudwn7pLO8=;24:F0sl8U0W1qKDU0GLBF10Sk5bXIox/O7Ww1vNWjFK8GmbspRSMUOnUPCAbeeNxDrCsEJtLPR8J5SPx7akL/NEC6Bcj2MEcqi0wnhV66Pyh+M=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR02MB2267;7:EilU4v0alC7z1CF956XFzqP2loEo4OFh9Zc9uNOcGsIpwtV5WY+mEVpG+KsO8FAXYw29H+d/nVL1vWbDYuuHWf4xgxxoqOZP3cqI2o5fGDmvNGzHbutD1AMuBb/RRcR0jNTDuu9/axtddN9u/spf0LtbVWYKt3Hq5PjeJmcb+/SOYjXY9RclnZwLMyKoI3fZBeIdBPpewCU5AwltwkS4UFsjk4HqBNO0wGFVRI3F8uokfAaBFLBtPnihQkIdjSH4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 11:05:40.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb039b7-9266-4aaa-bdda-08d593d2adc8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2267
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anurag Kumar Vulisha <anuragku@xilinx.com>

The code logic in dwc3_prepare_one_trb() incorrectly uses the address
and length fields present in req packet for mapping TRB's instead of
using the address and length fields of scattergather lists. This patch
correct's the code to use sg->address and sg->length when scattergather
lists are present.

Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
---
 Changes in v2:
      1. Split the single patch into 2 patches as suggested by Felipe Balbi
      2. Renamed sg_to_start variable to start_sg 
---
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 25 ++++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 860d2bc..1406c4f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -718,6 +718,7 @@ struct dwc3_hwparams {
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
  * @sg: pointer to first incomplete sg
+ * @start_sg: pointer to the sg which should be queued next
  * @num_pending_sgs: counter to pending sgs
  * @remaining: amount of data remaining
  * @epnum: endpoint number to which this request refers
@@ -734,6 +735,7 @@ struct dwc3_request {
 	struct list_head	list;
 	struct dwc3_ep		*dep;
 	struct scatterlist	*sg;
+	struct scatterlist	*start_sg;
 
 	unsigned		num_pending_sgs;
 	unsigned		remaining;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2bda4eb..330a4de 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -978,11 +978,19 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
-	unsigned		length = req->request.length;
+	unsigned int		length;
+	dma_addr_t		dma;
 	unsigned		stream_id = req->request.stream_id;
 	unsigned		short_not_ok = req->request.short_not_ok;
 	unsigned		no_interrupt = req->request.no_interrupt;
-	dma_addr_t		dma = req->request.dma;
+
+	if (req->request.num_sgs > 0) {
+		length = sg_dma_len(req->start_sg);
+		dma = sg_dma_address(req->start_sg);
+	} else {
+		length = req->request.length;
+		dma = req->request.dma;
+	}
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -1048,7 +1056,7 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
-	struct scatterlist *sg = req->sg;
+	struct scatterlist *sg = req->start_sg;
 	struct scatterlist *s;
 	int		i;
 
@@ -1081,6 +1089,16 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			dwc3_prepare_one_trb(dep, req, chain, i);
 		}
 
+		/*
+		 * There can be a situation where all sgs in sglist are not
+		 * queued because of insufficient trb number. To handle this
+		 * case, update start_sg to next sg to be queued, so that
+		 * we have free trbs we can continue queuing from where we
+		 * previously stopped
+		 */
+		if (chain)
+			req->start_sg = sg_next(s);
+
 		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
@@ -1171,6 +1189,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 			return;
 
 		req->sg			= req->request.sg;
+		req->start_sg		= req->sg;
 		req->num_pending_sgs	= req->request.num_mapped_sgs;
 
 		if (req->num_pending_sgs > 0)
-- 
2.1.1

