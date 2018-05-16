Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbeEPEa0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:30:26 -0400
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com ([104.47.41.42]:29338
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750775AbeEPEaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:30:23 -0400
From: Nadav Amit <namit@vmware.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alok Kataria <akataria@vmware.com>,
        Christopher Li <sparse@chrisli.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Beulich <JBeulich@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 0/8] Improving compiler inlining decisions
Thread-Topic: [RFC 0/8] Improving compiler inlining decisions
Thread-Index: AQHT7JNaBX0TIj5NlUyn2mGKiojEhaQxuDkAgAAL0gA=
Date: Wed, 16 May 2018 04:30:19 +0000
Message-ID: <03B86732-8D0B-40A7-B09C-5823104E631F@vmware.com>
References: <20180515141124.84254-1-namit@vmware.com>
 <20180516034802.nuf7ft65nvtgc65j@treble>
In-Reply-To: <20180516034802.nuf7ft65nvtgc65j@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [2601:647:4580:b719:5df9:e80:3939:60d2]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2782;7:QWOdb1MYt5UP+D2ninh3dBZd5BXPbGqgUWPsXdIKLZiB4JRYDPG3yKaqWXBRRS8Ny2K10Eyqgf+V8ETPOiIfRAB/Po/E02uAP4TT3M/GJiBczaRqJmF8s5bLag5xrUlOrt3utrAT1ey/8bbaTiBayEeOrTymXSQGiKRcnSH672La1sGG8Q06Qx8ldS+3ThjUdBprrgMJ7I0X9dUddkav00soGEObpl5Byvv8kwrvFwZAshU0Ua1z2NOcYqCYxvgZ;20:4BltrassJPmaPWpiH6nt7tblABYD+ZYnLMcSSufq0yggswIh4BfKA4Q7uVSzQgj8ufLtOMWMTZjfDO0eIdMnwieNC1YHY5XpbnE7ajivBlkohgajZzRDnZ5yuZ3ugenwUtTpaDRt7yWslg0AspnfuEKNn5gmm0mMJX5In3v7rF8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(186003)(6436002)(229853002)(8676002)(6486002)(81166006)(81156014)(2616005)(476003)(86362001)(46003)(105586002)(446003)(11346002)(8936002)(6306002)(6512007)(5250100002)(68736007)(36756003)(6116002)(4326008)(106356001)(25786009)(82746002)(6246003)(53936002)(54906003)(6506007)(97736004)(316002)(99286004)(2900100001)(7736002)(2906002)(33656002)(76176011)(3660700001)(305945005)(966005)(3280700002)(5660300001)(83716003)(6916009)(486006)(102836004)(14454004)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2782;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2782;
x-ms-traffictypediagnostic: SN2PR05MB2782:
x-microsoft-antispam-prvs: <SN2PR05MB2782AA30416B1F85FD77115BD0920@SN2PR05MB2782.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN2PR05MB2782;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2782;
x-forefront-prvs: 0674DC6DD3
x-microsoft-antispam-message-info: YJ++tUJH9cMRW9+XPCnTZA0K5bUFQiKh40eoQmOBiYo3e1BkoCF4u65+xav3XQQ+FQ3XIvcbeqj8TgupvSf+Ymc9lRq8fRDpaIjqW3qL7QGjMQ5psN+EvbSMNv4/o4kyfDAHAbXG5C3BSc+gdkNmy7tT68ZBwskJtl67b9pJwlLuz0dw0t19jxuKakwpRvKA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41EF0C5E06A1F24B953A2126074DC072@namprd05.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 888ee442-5c1b-4f07-7048-08d5bae5bb60
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888ee442-5c1b-4f07-7048-08d5bae5bb60
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 04:30:19.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4G4UV0v024446

Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Tue, May 15, 2018 at 07:11:07AM -0700, Nadav Amit wrote:
>> This patch-set deals with an interesting yet stupid problem: code that
>> does not get inlined despite its simplicity.
> 
> I got the 0/8 patch twice, and didn't get the 1/8 patch.  Was there an
> issue with the sending of the patches?

Strange. I am not sure why it happened. Anyhow 1/8 is available here:
https://lkml.org/lkml/2018/5/15/961 . I will forward it to you.

Thanks,
Nadav
