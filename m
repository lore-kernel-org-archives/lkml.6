Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeERPqq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:46:46 -0400
Received: from mail-cys01nam02on0065.outbound.protection.outlook.com ([104.47.37.65]:10462
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751450AbeERPqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:46:35 -0400
From: Nadav Amit <namit@vmware.com>
To: Borislav Petkov <bp@alien8.de>
CC: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Topic: [PATCH 2/6] x86: bug: prevent gcc distortions
Thread-Index: AQHT7jbL50o+w3m6PkeKHm2HX6GyP6Q1H7KAgAAEMwCAACDIAIAAShCAgAASAACAAAGeAA==
Date: Fri, 18 May 2018 15:46:33 +0000
Message-ID: <30EDFE9B-CA25-42EE-A57F-E3054B84223E@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <20180518081354.GA11379@gmail.com> <20180518101114.GB17285@pd.tnic>
 <A0A24A0C-7ED5-40DA-A017-7FE292F57939@vmware.com>
 <20180518154044.GE17285@pd.tnic>
In-Reply-To: <20180518154044.GE17285@pd.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2656;7:1bawnbben9w7G3nGhQ0ir0dDRvWPj2laL9S+8LuUEo8PPfrM9mrgI4HS+IGHbb6FcogY6Z4Xm20VwitEGdRfqKYvTS5HYwf8ndOezfHwGh3+mIJGCilq7QVajrzPxvrLA2BIhmv/jaDqm3G7yWfQTWFoL/Jnzpb4CLFijm6cwgFSzWfCtZej+H4LHbfpHojER99ui4GGy4wx/V+xq65gRjeKXyq7zkzKi8hsDOFhywwu2IRqy2mXLEIgkZ2k3/bx;20:rEmbcO0USK5Fd2Fd8IvfejyYZ4MYK18LBwMB24DhZX0aMapt8GExkX4K6e0jZu3ECSBZsGQmhVAhSfvODzI8pE8Uws7dV5k3gtfnvFLbxOoTuOCYMhIBtsAD9UnwgPiVjTWlO8w7jE2OUfwULd6eu3Tt7PBlwaCu6Ak8MkD3XdE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2656;
x-ms-traffictypediagnostic: SN2PR05MB2656:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-microsoft-antispam-prvs: <SN2PR05MB26565B27451A7C85534C9A73D0900@SN2PR05MB2656.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN2PR05MB2656;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2656;
x-forefront-prvs: 0676F530A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(199004)(189003)(476003)(97736004)(486006)(2616005)(83716003)(446003)(11346002)(7736002)(316002)(6916009)(53936002)(66066001)(6512007)(68736007)(2900100001)(54906003)(305945005)(36756003)(86362001)(6506007)(82746002)(8936002)(5660300001)(99286004)(76176011)(81156014)(81166006)(8676002)(7416002)(4326008)(102836004)(3280700002)(6116002)(2906002)(6246003)(6486002)(14454004)(229853002)(5250100002)(3660700001)(33656002)(478600001)(105586002)(93886005)(106356001)(186003)(3846002)(26005)(25786009)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2656;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: qLkVf5Z73h98lYhQzZDTfTvJZZ4LF+Ke72pnODAELlxC54Kbx8X1/MvQLXswlmd0eyd2btJZER1bgbuH/+tKEh1qrQCeR28cZPHvU6/i0rSBnfPuXx98LvelSlbJLfJxblKeImbz+y90Y0HCEZd2/j7oTYooVTwHB5Z4I6C/KYTnurv8PFeIhpriiLPQz64W
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0339D9222D6AEB4C95F86E5C81D4D5ED@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 69452fe9-1002-4b51-5beb-08d5bcd68803
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69452fe9-1002-4b51-5beb-08d5bcd68803
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 15:46:33.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2656
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IFkrOR029749

Borislav Petkov <bp@alien8.de> wrote:

> On Fri, May 18, 2018 at 02:36:21PM +0000, Nadav Amit wrote:
>> I didn’t try too hard to find more affected (micro)benchmarks, but I am
>> pretty sure there are:
> 
> So you being pretty sure there are, doesn't make me go, oh, ok, then,
> this is an uglification we should try to live with. It is still ugly
> with no proven benefit from it.

In case you didn’t read the cover-letter: the patch-set does give a 2%
performance improvement for #PF-MADV_DONTNEED microbenchmark loop.
