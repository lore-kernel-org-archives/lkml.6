Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1142023-1526318918-2-2497472919547916611
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526318918; b=cALaOw3e6NkEJyWyiPR7RsjKE3gijmsAz/tp4WLpwxja/ajZke
    F0dOM8ZhoAD4mZOFmiRJy9mWNYglQWe7GfrzHVfsLvCLwBpjk9KEz+Y+NLqJPNSZ
    YxB9DZ6mvD9Zzp+6Ia8Z+gSwAsXEzOXUtDUCGqdp7qTzPlI1bYbPDBDhtNYWskzS
    5vm4FRqT/LgvInNHcx5lgor46flVW3Jwe1PqQBmECwsa1D4guPcnjg2EHJhn4oSv
    w9UGuSKoc7TPT7KeF/l661XJbzfJrjzjv70XIjfmOfKHBfVobEwwvZ4b0HiIzSt8
    xpjA7zqRvvwn7RLpj87qXRhTfTZsc/byE1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:message-id:date
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526318918; bh=bW+iO8umi+aBZhJ1s6EozwO3DLu0mU
    yAUPfSsReSp40=; b=bLmjUlNRLafW9P9ubmCaFyHoX7C54TB8uAIPdkAUULB3hB
    3uIlNeXdM40AetzmHt9zp79Luj6Ah0/iZktnouZCW1sd0hP9pks9YklR/+Si6F6j
    YaQf4h1fwIC+BK6EGWYHGyrPXtBC5Wi4szeX2nsWorHVCLwX/CqF/HVOjBaI/aAm
    jRueXYwt4MEwfcW+E0MGmXa/1aaig5R9xsgDuTJ4ful35drC2V9UL7WWOXpV6DL9
    8K8eXWMHrifANsra9zW2r7RvfgLUbqeiHUICbJ1X3pWexqbuQFQNCHI6H47SChcV
    Gq06Wcdd03lo9zvmRK+wZTGQvCXn0VmIv0ZIvNpw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=pbpwFoQk x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-netapp-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=netapp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=netapp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=pbpwFoQk x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-netapp-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=netapp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=netapp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAO2Gmo8iCPZws8bb05RGuO/wle6nGMjUIRpSethQYDmSOkMW7rPRU3Jg0HZRqM95zEnyF1zVXKkHSdvzm0ei35Ypwnxe/RbYdlLVMHuuD/Hkaq2BYAP
    pGT/3gqpYGrBJ45/QZ3kMQeBJ+UAx9gbAKSsZBVxEwnc7dDy2H4CN6cakdljvE/fcgiaspOLeZJnQz46mBpS0eIk69ETX3YyRPcGtgfJY33SJXkXlMg/fADE
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=YIlzM3F11_MA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=JDjsHSkAAAAA:8 a=6XPOJ6aHNCTl6mb_W8MA:9
    a=QEXdDO2ut3YA:10 a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbeENR2g (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 13:28:36 -0400
Received: from mx142.netapp.com ([216.240.21.19]:37324 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeENR2e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 13:28:34 -0400
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="253685586"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
From: Boaz Harrosh <boazh@netapp.com>
To: Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rik van Riel" <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
Subject: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
Message-ID: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
Date: Mon, 14 May 2018 20:28:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::38) To CY4PR06MB3080.namprd06.prod.outlook.com
 (2603:10b6:910:58::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:CY4PR06MB3080;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;3:/SscqJztj+o9OxfH+HHaNvFtpfgRwtGQsMuea1en3LSmljRo0eSwo7HYA5r2qoqCpFkh9TtXB0//NkrO+gJEFKy4ecpyF9RPfNxjIx79doEaU/ERWJW3WA4tK2gNbZp3riMNkLtmeWTKyCuZLRKBKb34bLfXPG2uKMav/4DyF+KiCJRldpMAPzM0MNmptb2YzSmRmsViTPT8awJRpenMdFmH5mBMqvaJvrI1KSlGb5OCUvcT5i8S+Zwf+Ugs57GL;25:xna4X1fRwOpc+IT1A30br8q0LB+gJJqXoAa1kZmQn4ePYftFLqDFYEuO0QfcZbB6j4euixSSz6CLT3xRxw/z9BmLbG30Uxcn4B9DpDnT2Sb/pQ325KmpEbULgk2VWK7HiVykdqDgvwZDoB4q2sSEu/MQMcklwD590VeX0LdQCf6dDLZ5IQPdiYw4LMjMaMkfM1snfSNjOaTnz0+6m2cymF3vqZn61kRdQuPtVyZjIqraVZzRHvz68evnKDTbZSCluIzswNJn6d7XkvHPHRp3dpcgYi/HO9ES4meZCVry2y6V7ogmU+PJhS2XezSKvBRLyq7oM6SYFXWTHZ2cMapf0Q==;31:j6gok7WVjBkiSYaK7qUMFfQcNczxp/V3oaVsngwOCINThcmSCAxyT/6qftjof/iZqIWyNiYP0tocqyBZQoyq0BR1Ubpzhj8nGIClsDXStcLS3EBOLnFPOvbRsLI3nAnCo/LljmSehR5Um2KZ0ZsxIBdhWoojduCnewIV9Ob3+uNquQ/wql7HD1Ppt2dwnpiTCytiCq5Uxi2do19oivxE1hOqv3HjNoEGeH2d9MZvCNg=
X-MS-TrafficTypeDiagnostic: CY4PR06MB3080:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;20:l8CLsU9BX2iaaQYRqNmgGnfku8FWVJPPus0PwK9uzigAgt8lYjhVCzrmrOPm7c81541gMuThE1ir4tC+kfz956UaUh0OHNzeJbYYk8SJQWpTur75zjHmXeGbM8Lrw4MvuPUi/m9sWH1oPH599rl/IbMiB/MRM8dXqMRA4PK8VwwHP+BHJYDdnvqU6T9LnP8lGrah8yEIy87OncOiv1XEbr76clKqriyEDgTy9kFK9620pt5ELXZOty1qVbPxeRZfAsixARdVKv5hAllM37pueTJ7teRLwQQBSFyP3hYvBrffH8d6HmEsTiAPREdY6cDUe2tvaKbj2iw8N8aooLj53aRSyceVEcVeq2ZR77WrafChDn7J4vV/h+GOkL839uyhpwJvNPOFcwJsYQnAoNCN7NFDxYHsp/8LrW+ziNJo2rZL6BQapR+dAmVrFD0JzqnafudVhdEQQ+qwC3QJaXmV1qE5z6TtsjHxLPXqPpo2LVWFaoVGI/Y4gEkit1DDmDgC;4:KN+G3ixjasGi6WVa/NLtjmTLd9QUqPDHa5PFM5stjDM6XVizwK/+ljJdUuK8OTWBspzDik4FF8pHUPRJwr/vb+DMwvDrQLFC/4kQkzS8UvSPwk71AsgNVsSgfIerTRj5abHD7HMpMFMQs2oCA3hsEEu4SLK+PbM3qoinv+3j2bnFF/36iESgqrGQczeh4pOzEzD09BhhLRiPD5Xth6T/x+YeCXPgs+Le/5pvTjBOKSKOnF5/4k7MpYS/7KQ9M8PXpsKxxPhbC+/bo4eEi1pwdtvo3l+5s0fdzIxAW1wnTHmB4S3Qo0nCKYX7udpTXhCJ
X-Microsoft-Antispam-PRVS: <CY4PR06MB3080440FE062478CFC5C1547EE9C0@CY4PR06MB3080.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR06MB3080;BCL:0;PCL:0;RULEID:;SRVR:CY4PR06MB3080;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(50466002)(476003)(316002)(16576012)(54906003)(110136005)(8936002)(478600001)(58126008)(2906002)(68736007)(72206003)(6666003)(6486002)(8666007)(64126003)(106356001)(105586002)(2616005)(956004)(486006)(5660300001)(107886003)(77096007)(26005)(65826007)(31686004)(7736002)(53936002)(66066001)(8676002)(31696002)(81156014)(16526019)(386003)(97736004)(25786009)(4326008)(52116002)(3846002)(230700001)(52146003)(2486003)(23676004)(65806001)(59450400001)(1857600001)(305945005)(47776003)(6116002)(65956001)(2501003)(36756003)(81166006)(7416002)(21314002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB3080;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA2TUIzMDgwOzIzOnFwTGNGZk1yVzNmelZWWTQwa0JmVHR5aDBx?=
 =?utf-8?B?UURZY2hzcWNwcmxkZUYxSkM3dVE2WW9QK3Q5NG13NTlaVVdjeEJyVm5XSkI0?=
 =?utf-8?B?QThQSy9YWXk3bTc1a0diZlYwb2lXTm9zOTZrTU9zL2ZKRHhTYkRqVDdzWDR5?=
 =?utf-8?B?WmtQalJlNmlpKzV3UG5ZdCt3STM2MWdlNzg3bWFLdmJoUkE1R1gyVEVFK3ZV?=
 =?utf-8?B?WHlDYmpiZzdSSTRUQWhqVVQwZVIzbTBJMmlCVm5yRTJnVlZabVFOR0EvL1Qv?=
 =?utf-8?B?RzloY292MHRFYmQvTHY2WTFxUWhHMWgwVGI5bFNvZktrcUhrbytxNlp2Z0VE?=
 =?utf-8?B?YUJ6L0kyVWM1UE1YY2dRcXMzUGVCcjA5cXpNeXNScUdIRXJkRTZtQjdCZUgv?=
 =?utf-8?B?MDVNazZCUHJsZ0prdDB4Z1JNaURLWUw1SUJVWnNyWlFTUXNZWjU5aG1BZUM3?=
 =?utf-8?B?cVRqc01ObTlSdFlwcmdDYzZCVHZpMzg0Ry9aTE1FczFkaVVuZ0I5ZnRUTU1s?=
 =?utf-8?B?QjR3UGIwSkNvcnQzZ1VZZmVnN0Q3NDd4bm1GTWRrYVcvTlhCa2JTcnVKNHhn?=
 =?utf-8?B?SGd4VHRLODNwa3FpOVI3YlZ5T3dXM21GOGx2Wjl1S0l2SG5WNy9JVUFMWWR6?=
 =?utf-8?B?VDU2YWdTbmNieU9Wa0RmUG1TM2tFYlg2T3hsakFWKzZkc1FKNzQxL3hzYmNM?=
 =?utf-8?B?Rm9LUWQ5VThqNDZObjRnTFVxNFpJQTFMZ210NVhGZ25UTUtiUWFtWE1nWklM?=
 =?utf-8?B?R08wajB3Y0Z6SDZ5MHlwUTFOQ0VuMDJsQXRsb3VQYS91anpxT2dFcE10K015?=
 =?utf-8?B?bUJsSnJOWHhndXBsclVOSDJLRElHYkg1T3BuTEJRcTdGRTdKM0pIT1F6cEpj?=
 =?utf-8?B?VWdvM3JOeHpBeWllcUhJQ2VPWm9hV2pyWXE4Q2RDS085Zm4xVVZlWmNOQk1W?=
 =?utf-8?B?ZFlCdzg5SS9abmhFUlJzM0lramRPenJOWEh2NWhKTEFuSzU3dlVITUdRcWFZ?=
 =?utf-8?B?ZlBwYms3TkgwQWNYQ0FMRXlXYnJoWkVDdWtWNzhHeSswbUdHMC9tV1VDV0lD?=
 =?utf-8?B?b1Q0Z2g5NzBVY0ppK3liWElmajh5anZqWGFGdTErVlpzR0hsbnFkRmRveXVM?=
 =?utf-8?B?MGdFMkZSWVdFQ3FEemZscXlzTnVERzVFN3ByOGZoTUY3Y3g2bXh5bzF1QnV5?=
 =?utf-8?B?VjVQSXRENTUySElTTmk2TnZYNzJkZjh6SXovNElKMGZSYkV0Z2YrZzhaTldE?=
 =?utf-8?B?cS8yamFNR01IRjFLU0lzdDN0YmpabExQVmhBQUJrTjVXUkFTVTc4WTNIVDRK?=
 =?utf-8?B?Rzc1K3RMNXNFZ0o1WDQyUGZ3eWxWRGdha1RrYjFzbjlCdkdZc2NCNXJySlRP?=
 =?utf-8?B?VDdBUExIRU83Yi81Mkp1dHM1TklFN1hqOFpZNjd4S2Y3RHhSYzUyNEg3aDVx?=
 =?utf-8?B?VmJrTGZBbWpvSHIrNXllVnppemc1Y2ZYVkZCNDNjb2xMdzA1azl6K2dtUEJH?=
 =?utf-8?B?NkFmYXErWE5IKzRhNUxjeXhzWTRXSThmUE5jdlpIcjBHQjQydWRFYlJma2VT?=
 =?utf-8?B?M0ZjZmgxUnlTa1M1UWcwQnRWblFDOHAxeUtmbWpVdFQvUEpFS21zaCt6UG1r?=
 =?utf-8?B?eWRFL215MEVwb3I4V2dFeGJHeTJQcXB0bDY2Qm1jRlJPSzZMaDloejZvNHlZ?=
 =?utf-8?B?dS9sNEJjSTl1WHcwQ1lMYS91ZXU1NmxGWUcwVXYrMFZpdjNwU0ZtNmYxZUwy?=
 =?utf-8?B?cWJnUUpUUkFiZXlTNDRWTVY0U1FmSjZsN1VpOE1xc2sxRnZhNzZmNnpVWDdE?=
 =?utf-8?B?c0FORGVFNmV2N0tPYlorbHhqRUxMQ0JwR1pnSFNqVXJMeEN2WVVMS0ZSZXF1?=
 =?utf-8?B?cHFFbjFyS0ZSTDJkR09jM0g5cUN5enI0S2NocDZ3SEV2MFNFdkJLNE1tVFlE?=
 =?utf-8?B?anhKQ0djMGQwU2htU2NmMWpjaVdSaWFwK1B1bmxmRFE1ckpSVEo2eEF5Zm1l?=
 =?utf-8?B?Q2VmaDAxN1JYeTA5V1o1UFVQVkozeEI5NTdCTWtaSzBIVGE3a1BSNFVIL2cv?=
 =?utf-8?B?VkJWc1I5S1NKVkgxNEhHNTVJUm5lVCszR2R4U0dYTFV5MlhsVTRteU5sVWdO?=
 =?utf-8?B?c0E9PQ==?=
X-Microsoft-Antispam-Message-Info: uZrzzPsljon+xqy8WvNSZZKto4UmhRQL3vY0/xsW75Mrj7FJNqOpvzYFmKYlHUr1E8+g7e01igZu8ht5MgaCwwVlQ5tv7PZFTLfu8EoUqB5Ww1i75pDX7W4wkxJSqrsrHSWGiKcelRVMgpPVXbJnh8vs2VnrZ43r+jMifS4PUH+uoFB3XHiyrdtP/SDNFCBG
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;6:5+ddUpNSHboTAtr4yshkBKNMjGNjCch57GuQAUbojVMB+8N/28V/S7dUtIb67mSmviFCjJyiVrvKw/uo9ApUZn/rtpnnyeNXuo+C5OkTpcLDjmqGRICkvq1PSGljO687PIZcRPI5ciTcVmui2Z6diMFeHVDSeEYUyDmS4eZpkQXUy26TwLRG8JG+nmy/alRNRhOsgFtgTQvgaTpeqDoq8cJrvqGVoJvi2cfF3pYc0OLSyDVky7rdVnlioXlyrPSjI1wIGLZNSGxgyMG2AZ7UE6G9aE6qUpxArmiFH1FS0QiP4ELfwJ3WKyhGiekygBQxqCLWnNMsuJa/wdFrJmMrBeC8ufLQ1I4Gu8ELcZHYrkcj5kYhWfKGiypi+IIAPZHxYA0mZSfyqz7/x6Qvk9exUFNinFQlgSdfofSDc+KfbRZj4s0Ff91uOV6zfbf38DY/KR5uLLdvYoBUU80kcC5BTw==;5:LDoBFS0O5kiOkRv1wwXSDJvx+oICuGvu0enPrfkFzcvIXYpMaB3haXoKrf9gA6Ewy4syiKc2wgCc6h+v8Ih66SX0wb/nTGf571po/VeWGPubhedQ3o73wKx0SKTeaFIuOPWeVT9/oLSlr3zGLQzo+HRg9hmUpUg0JtHi6GVD/LE=;24:20kVEvRb/ZlvDucYnAR4lpU18TPj/QDEmU6sW/ryAZ3yQHQJW3dMy2peuH3v75kMepTViuhH8fi0e34yulhR/HHYSvJR8Hubd80mgDf2Apg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;7:YesqoRjqyRwC4s94TowaXlxyiXLNkIHGl10LAKLrmisaa27xEnmKk2alhi7FoeJFq3AIB0737dz0jvXMxLVwBsl0X6nCKRYp4VOvE/ccZtVGT3TGNuAeWt8jZIMYdpQfdb3f7eqbMThkufGMklprQMJ53hvAkpbGBjhgNw6kUGtp7lDxdnnV0+o6hNj02uM6yHQDz/99N6Ic8F62hOhMfNStBF4lLjFtdMr9Q3omcAQuHPTlqLJ2Qmp/53xDHctC
X-MS-Office365-Filtering-Correlation-Id: cf323139-2bc8-422e-5d79-08d5b9c01c5f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 17:28:26.4445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf323139-2bc8-422e-5d79-08d5b9c01c5f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3080
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On a call to mmap an mmap provider (like an FS) can put
this flag on vma->vm_flags.

The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
from a single-core only, and therefore invalidation (flush_tlb) of
PTE(s) need not be a wide CPU scheduling.

The motivation of this flag is the ZUFS project where we want
to optimally map user-application buffers into a user-mode-server
execute the operation and efficiently unmap.

In this project we utilize a per-core server thread so everything
is kept local. If we use the regular zap_ptes() API All CPU's
are scheduled for the unmap, though in our case we know that we
have only used a single core. The regular zap_ptes adds a very big
latency on every operation and mostly kills the concurrency of the
over all system. Because it imposes a serialization between all cores

Some preliminary measurements on a 40 core machines:

	unpatched		patched
Threads	Op/s	Lat [us]	Op/s	Lat [us]
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1	185391	4.9		200799	4.6
2	197993	9.6		314321	5.9
4	310597	12.1		565574	6.6
8	546702	13.8		1113138	6.6
12	641728	17.2		1598451	6.8
18	744750	22.2		1648689	7.8
24	790805	28.3		1702285	8
36	849763	38.9		1783346	13.4
48	792000	44.6		1741873	17.4

We can clearly see that on an unpatched Kernel we do not scale
and the threads are interfering with each other. This is because
flush-tlb is scheduled on all (other) CPUs.

NOTE: This vma (VM_LOCAL_CPU) is never used during a page_fault. It is
always used in a synchronous way from a thread pinned to a single core.

Signed-off-by: Boaz Harrosh <boazh@netapp.com>
---
 arch/x86/mm/tlb.c  |  3 ++-
 fs/proc/task_mmu.c |  3 +++
 include/linux/mm.h |  3 +++
 mm/memory.c        | 13 +++++++++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index e055d1a..1d398a0 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -640,7 +640,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 		local_irq_enable();
 	}
 
-	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
+	if (!(vmflag & VM_LOCAL_CPU) &&
+	    cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
 		flush_tlb_others(mm_cpumask(mm), &info);
 
 	put_cpu();
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c486ad4..305d6e4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -680,6 +680,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
 #endif
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+		[ilog2(VM_LOCAL_CPU)]	= "lc",
+#endif
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ac1f06..3d14107 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -226,6 +226,9 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_LOCAL_CPU	BIT(37)		/* FIXME: Needs to move from here */
+#else /* ! CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
+#define VM_LOCAL_CPU	0		/* FIXME: Needs to move from here */
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #if defined(CONFIG_X86)
diff --git a/mm/memory.c b/mm/memory.c
index 01f5464..6236f5e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1788,6 +1788,7 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	int retval;
 	pte_t *pte, entry;
 	spinlock_t *ptl;
+	bool need_flush = false;
 
 	retval = -ENOMEM;
 	pte = get_locked_pte(mm, addr, &ptl);
@@ -1795,7 +1796,12 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 		goto out;
 	retval = -EBUSY;
 	if (!pte_none(*pte)) {
-		if (mkwrite) {
+		if ((vma->vm_flags & VM_LOCAL_CPU)) {
+			/* VM_LOCAL_CPU is set, A single CPU is allowed to not
+			 * go through zap_vma_ptes before changing a pte
+			 */
+			need_flush = true;
+		} else if (mkwrite) {
 			/*
 			 * For read faults on private mappings the PFN passed
 			 * in may not match the PFN we have mapped if the
@@ -1807,8 +1813,9 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 				goto out_unlock;
 			entry = *pte;
 			goto out_mkwrite;
-		} else
+		} else {
 			goto out_unlock;
+		}
 	}
 
 	/* Ok, finally just insert the thing.. */
@@ -1824,6 +1831,8 @@ static int insert_pfn(struct vm_area_struct *vma, unsigned long addr,
 	}
 
 	set_pte_at(mm, addr, pte, entry);
+	if (need_flush)
+		flush_tlb_range(vma, addr, addr + PAGE_SIZE);
 	update_mmu_cache(vma, addr, pte); /* XXX: why not for insert_page? */
 
 	retval = 0;
-- 
2.5.5
