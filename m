Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeEAGuS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 02:50:18 -0400
Received: from mail-sn1nam02on0059.outbound.protection.outlook.com ([104.47.36.59]:39221
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751083AbeEAGuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 02:50:17 -0400
From: Nadav Amit <namit@vmware.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Suboptimal inline heuristics due to non-code sections
Thread-Topic: Suboptimal inline heuristics due to non-code sections
Thread-Index: AQHT4RiozIiV7/XJckSM7Cv1H8EVuA==
Date: Tue, 1 May 2018 06:50:14 +0000
Message-ID: <A74E4351-A9FA-434D-AD47-3A509F802FFB@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2496;7:XJC9dHoHXmcX2GQtCHoZzMXWK0zBv4A18yfepTvjE9OqzT4z0XqGV6Qc6HkjDx0oq559KkeEtl1g9KqMz0QtKYGh8tDpeAqtxvpeOVmbWJkOAK7gHuOVfLl9lXiz4wRo5ARpQ+KxpzflbNXsQaJjhxQ1HL9omKABH1Mjkh0nWsyYulDxiWSZC0+WfABIDj9KAxgCMBUL5R9IUgx5rtYUvUpFcucswixPy2T9gQnixztLqDXxNzz1yn0tqKdb+uC3;20:ZjGPuG6dRv8d28Mhc592IDCdO9McBfLqzx9rFnYypUllSlB/cNpX4VuwvdGVwxDTFiXZ+w2Qt0qCD39h1cxsTnzrextfmdjhlcbtFo52tiIsFubG4ImDR0Nn3y4eSOHZqNVeGMa/3Anrm2E8sf9b517WjhxxYwTsHZTm8JLRCmI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2496;
x-ms-traffictypediagnostic: SN2PR05MB2496:
x-microsoft-antispam-prvs: <SN2PR05MB24968A2F4CBA45662EDE22AAD0810@SN2PR05MB2496.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN2PR05MB2496;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2496;
x-forefront-prvs: 06592CCE58
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(39380400002)(39860400002)(199004)(189003)(97736004)(5660300001)(4326008)(25786009)(7736002)(8936002)(305945005)(5250100002)(81156014)(81166006)(8676002)(83716003)(2906002)(478600001)(3280700002)(36756003)(86362001)(68736007)(6486002)(54906003)(6436002)(26005)(6506007)(102836004)(2616005)(82746002)(59450400001)(186003)(316002)(486006)(106356001)(3846002)(6116002)(14454004)(105586002)(66066001)(2900100001)(99286004)(3660700001)(110136005)(6512007)(53936002)(476003)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2496;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: I8E0UmvxkZvfSiQgj+D8ISXHeEBPWd9HOMiEY/zv4IwL6HVD3B2f/ub9Aer3wj0MCwKrhW538Av2jqdBdz/fM8gR/Z3bIQjikSCB54FdcJBni9kkymUIHS3oaFo/sjzyafBjejtQm1uFUlUsXe9ku0efpgbJUGcuF/eSBlTvzJMoNI1hf9ADMIW8DdKJlAgH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDB25BF1A5B6BB43B03B59CA3984B30A@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3d6737ef-657a-4165-69e8-08d5af2fcb4a
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6737ef-657a-4165-69e8-08d5af2fcb4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2018 06:50:14.9877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2496
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w416oPZB019958

When gcc considers the size of a function for inlining decisions, it
apparently considers *all* sections. Since the kernel extensively uses
sections for things other than code (e.g., exception-table, bug-table), the
optimality of these decisions seem questionable to me.

The objtool’s sections may be the most extreme case, as these sections are
discarded, while their size still appears to be considered by the inlining
heuristics. It may be beneficial not to consider (some) the other sections
as well, as they do not affect code-caching but only increase the kernel
size.

To illustrate the issue, consider the function copy_overflow():

   0xffffffff819315e0 <+0>:	push   %rbp
   0xffffffff819315e1 <+1>:	mov    %rsi,%rdx
   0xffffffff819315e4 <+4>:	mov    %edi,%esi
   0xffffffff819315e6 <+6>:	mov    $0xffffffff820bc4b8,%rdi
   0xffffffff819315ed <+13>:	mov    %rsp,%rbp
   0xffffffff819315f0 <+16>:	callq  0xffffffff81089b70 <__warn_printk>
   0xffffffff819315f5 <+21>:	ud2    
   0xffffffff819315f7 <+23>:	pop    %rbp
   0xffffffff819315f8 <+24>:	retq   

This function seems to me as a great candidate for inlining. Yet, in my 4.16
build (using gcc 7.2), I get 38 non-inlined instances of this function in
vmlinux. Forcing CONFIG_STACK_VALIDATION to be disabled reduces the number
non-inlined instances to 35. Removing, in addition, the data which is saved
in the __bug_table makes all the instances of the function to be inlined.

Obviously this certain function can be set as __always_inline, but the inline
heuristics seems to me as wrongfully biased. 

What do you think?

Is there a way to make gcc to ignore sections for its inlining heuristics?

Thanks,
Nadav
