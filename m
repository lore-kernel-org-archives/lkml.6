Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeERTSO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:18:14 -0400
Received: from mail-sn1nam02on0062.outbound.protection.outlook.com ([104.47.36.62]:9440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751363AbeERTSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:18:11 -0400
From: Nadav Amit <namit@vmware.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Peter Anvin <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgACNMgCAABDSAIAAERIAgAACU4CAAASRAIAAAOaAgAACnwCAAAJMgIAAAfyA
Date: Fri, 18 May 2018 19:18:09 +0000
Message-ID: <C481FBCA-2FA6-49B6-84DC-83FF03F539B9@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <CA+55aFwA7K0urWTy1CQysnNt8j5Njvz+76o2CuomucNA7mOymQ@mail.gmail.com>
 <6DB0E0C2-CCD2-4FCE-BD8B-5E340E308FF7@vmware.com>
 <CA+55aFzbWA1XJTitwX6DvHxr7EqDa-tEjpedn5yfYpC1edYQog@mail.gmail.com>
 <BF0C5636-3EFC-4D57-9019-3EB209E56D2C@zytor.com>
 <CA+55aFzLhG1L0WXvJiUSWrAN5ghzn4XFAK64wgFoyVAHTHZH-A@mail.gmail.com>
 <2F760FAE-C19C-4BC3-A8CC-7D17CEF3B116@zytor.com>
 <6A3E90AA-7838-4C2A-B628-908F34902B75@vmware.com>
 <CA+55aFysH5iiJWCVFu1J6GQfN2G1AbMcHyc4RhpnrnPjtM3L0Q@mail.gmail.com>
In-Reply-To: <CA+55aFysH5iiJWCVFu1J6GQfN2G1AbMcHyc4RhpnrnPjtM3L0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2462;7:H9mqUoZSO7EEWfI7hqvtIIjH7+7GnzpEUnRazETzVzJRZf6CMWLRXIGSmWxDX843gshwqu/VUgxfVJa1FyT+MQq92c1FLCgoCc0ErzF0IyIeLxykQbhDQmXlgaQ23FwIBkxQJAP4RlGVON0/6YVhVhY3kfIpgFhglMAUU/SbmVclUwQlXb1saCweU2l5K4czRMQN4Q1fUdCMKkZAj+oEf1CpBW6Dn6+8Yz2BmesHkRMDbYtfvx9sA9Qhb6uLzmOR;20:hp6JMYk7xr2SrEpojoIwofpRoO9AbfOfPw1zUsK8GEfXSnF3PwEN2Spdw9w42CzFtWpC2U9varTGqIlpm6nY91rWeG0qrg3nR2S7u9QcCMHw3Zv4KAwrSo6i8cICVBpfR5MQZOMn5vw3uslaK28Rba41yBQUGY3/PDW+w479GVk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2462;
x-ms-traffictypediagnostic: SN2PR05MB2462:
x-microsoft-antispam-prvs: <SN2PR05MB246222F563EEA7D179130A13D0900@SN2PR05MB2462.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2462;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2462;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(199004)(189003)(8936002)(486006)(8676002)(81166006)(81156014)(3280700002)(2616005)(76176011)(82746002)(102836004)(305945005)(6916009)(5250100002)(6246003)(7736002)(476003)(53546011)(33656002)(99286004)(6506007)(3846002)(5660300001)(26005)(14454004)(6512007)(11346002)(446003)(6116002)(25786009)(36756003)(53936002)(83716003)(86362001)(6436002)(478600001)(6486002)(186003)(229853002)(2906002)(54906003)(4326008)(316002)(66066001)(106356001)(105586002)(2900100001)(97736004)(68736007)(93886005)(3660700001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2462;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MNUu7biLO2K8Rlf4yIEH167XcUs7jM5Mk7dwzoglh/Wddxph7ZLAwhRoGJ5gZnv8aWbpDPE1I/uq0Q7sjIWY/psidfqySKVRJEhd2+Y0wpLg8Nb00u+TETJfJL/kdi8eOUcXIq/cgH82+y4fGhGIQ83BQYziSXoyqy08uHZN7HIgPJ6tRNpWSJ7Th9S3ZYnQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8AD6C222C27E45A4070E89E15028F5@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6491fbad-ef04-4d44-ee6d-08d5bcf4176d
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491fbad-ef04-4d44-ee6d-08d5bcf4176d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 19:18:09.2665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2462
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IJIKsY014637

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, May 18, 2018 at 12:02 PM Nadav Amit <namit@vmware.com> wrote:
> 
>> I can add a -Wa,[filename.s] switch. It works, but sort of undocumented.
> 
> Oh, if it assembles things together, then that sounds optimal.
> 
> And yes, like hpa says, we should make sure that behavior is acknowledged
> by the GNU as people, so that they then don't come back and say "hey, now
> we assemble things as separate units".
> 
> That said, the "separate units" model really doesn't make much sense now
> that I think about it, because 'as' supports only one output file. So I
> guess the as people wouldn't have any issues with just accepting the
> "concatenate all input files" syntax.

Gnu ASM manual says: "Each time you run as it assembles exactly one source
program. The source program is made up of one or more files.”
