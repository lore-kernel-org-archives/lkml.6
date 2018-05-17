Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeEQPHL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:07:11 -0400
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:12835
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751319AbeEQPHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:07:08 -0400
From: Matt Sealey <Matt.Sealey@arm.com>
To: Kim Phillips <Kim.Phillips@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
CC: Florian Fainelli <f.fainelli@gmail.com>,
        Pawel Moll <Pawel.Moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>, "Ingo Molnar" <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com"
        <alexander.shishkin@linux.intel.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
Subject: RE: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
Thread-Topic: [PATCH] drivers/perf: arm-ccn: stop spamming dmesg in event_init
Thread-Index: AQHT7XWVQYchghNqw0Gmf2REANsJZ6Qz/XAQ
Date: Thu, 17 May 2018 15:07:04 +0000
Message-ID: <HE1PR0802MB241294860D79A65132C69382EE910@HE1PR0802MB2412.eurprd08.prod.outlook.com>
References: <20180504104117.8086-1-mark.rutland@arm.com>
        <20180508184050.75c60b82ba538d0ecdeb2d78@arm.com>
        <1525882003.4199.55.camel@arm.com>
        <20180509184154.9994df2874e7a08025b56dea@arm.com>
        <cee9c043-3d64-56b9-4f23-e8c8370387dd@gmail.com>
 <20180516192528.5519d2faf59766e0544bb2ee@arm.com>
In-Reply-To: <20180516192528.5519d2faf59766e0544bb2ee@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sealey@arm.com;
x-originating-ip: [217.140.111.135]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0802MB2426;7:Yy2dq+TZgdW8MeIAqBmrJRzjTjHIAAjwX5TL686nLayo3AZ+jdNd6Nem0uWSwXeRfje1jYF/I6UzFE29T/c8w/ttWDbUVAWRyaaPSigDCxo5GJbvRVo2GMz2MA7+PD5bc/eTd/7+Oed1tGRcykikZNqkAAtj/m11R9P3WEdbZotOPmbcsHgGTdQU3yyny0Y9qC6GXzBsAMBQMRFXW7rj6RvBIz4oPnpyrqJuxNRITYQC7TFauVyy7SiBD159rWU/
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR0802MB2426;
x-ms-traffictypediagnostic: HE1PR0802MB2426:
x-microsoft-antispam-prvs: <HE1PR0802MB2426A35F839A1736EBA90ECCEE910@HE1PR0802MB2426.eurprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0802MB2426;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2426;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(366004)(39380400002)(376002)(40434004)(199004)(189003)(53754006)(59450400001)(486006)(2906002)(6246003)(316002)(53936002)(110136005)(11346002)(446003)(54906003)(66066001)(102836004)(25786009)(476003)(6506007)(99286004)(305945005)(14454004)(7736002)(4326008)(7696005)(55016002)(6436002)(72206003)(478600001)(229853002)(3280700002)(39060400002)(3660700001)(26005)(76176011)(9686003)(74316002)(97736004)(5660300001)(33656002)(7416002)(5250100002)(86362001)(106356001)(105586002)(5890100001)(8676002)(2900100001)(8936002)(93886005)(81156014)(68736007)(6116002)(81166006)(3846002)(26753002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0802MB2426;H:HE1PR0802MB2412.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /NiUJFjjGbPo23FeniJs5aRSi8FfLUfCpzP2vkjAztOgpAE4GGBb29cuPM3EzKfUYRzIgVrrmvdMnQqG2c8LZK5R19XCuN4wfTTVTo+Q8DXwZReuZ5KyzkISBFdp2du7medoP+H67C9+Rm/XPmfoLsYjKjlNxsOsCKxjaRmAC10CByjZknGEH9umraJ6m7ZS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cc4d6f98-a768-450d-bf3b-08d5bc07d99e
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d6f98-a768-450d-bf3b-08d5bc07d99e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 15:07:04.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2426
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HF7Hjk018887

Hi all,

> > I don't have any dog in this, but maybe if providing information to the
> > users is so essential to having a pleasant user experience, then
> > rethinking the whole way these messages are funneled is necessary
> > because the kernel log + dmesg is by no means appropriate. Take a look
> > at what the networking maintainers recently did with netlink extended
> > ack. You used to just get an "unsupported" error, and now you know
> > exactly what is wrong when extack is available. It seems to me like
> > something like this is what you might want here since you want to have
> > perf be as user friendly as possible.
>
> Thanks, Florian.

Florian, I'd love to know if you mean "implement netlink extended ack in
perf" or "do something idiomatic for perf"?

Let us assume we are semantically challenged over here. I'm going to
proceed from the latter.

> Acme & other perf people, do you foresee a problem adding netlink
> extended ack support to the perf subsystem for extended error message
> communication?
>
> If not, is struct perf_event_attr amenable to having error reporting
> bit(s) added?

I did have a think about this when Kim mentioned it in passing, and my
reasoning was that a serialized error record similar to ACPI APEI BERT/ERST
tables (without the NVRAM abstraction) would fit the need.

As soon as I wrote down my thoughts I realized it scratch more itches than
just something useful for perf.

It would conceptually be a buffer passed from userspace with the syscall,
which would be populated in the kernel with an identifying header, each
record denoting its own length. The syscall fills the buffer with records
of particular format for the syscall, and the errno returned to the
application is then the state of the error recording buffer - for instance,
if the kernel ran out of space in the buffer before reporting all the errors
it could (-ENOBUFS or -EAGAIN), if it stopped recording errors on something
that requires being contained and returned at that point (-EFAULT), and so
on (anyone who's got RAS on the brain will see where I'm coming from).

I have a distinct dislike of filling the kernel with const strings, so the
records would be strictly machine-readable and contain information about
the error for the record and the source. If userspace needs to print a
string then it can look up unique identifiers (UUIDv1, give or take, to
remove the need for any authority on numbering) in a database - be that
plaintext, gettext.po, bdb, sqlite, xml, json, C structure embedded in the
tool - one for each error source. That keeps strings, translations, string
formatting entirely outside the kernel, and keeps records from being freeform
typo-laden strings.

That'd give some generic Producer code in the kernel, and imply a companion
Consumer library in userspace (with said database backend), which could also
be responsible for logging the binary records somewhere for future reference
(perhaps bounded by capabilities or container privileges).

Pretty much every syscall that has problems returning 'just an errno'
could benefit from such a system, the only impediment I can see to it is
that it's adding a new subsystem to the kernel to produce these records,
and any syscall that needs it would have to gain either an extra parameter,
or attribute setting addition (like setsockopts) or to shoehorn the buffer
pointer into an existing parameter structure like perf_event_attr. That
would have to be locked down to a consistent method that would be
recommended (like adding a new syscall interface, not everyone has an
attribute interface or parameter structure) although there's no stopping
kernel devs adding in a way for legacy applications to easily receive
the same information through existing ABI.

In the case of perf_event_attr there is space enough to mark a bit to say
that errors could be reported in a buffer, but not enough in the reserved
space that exists to store a pointer for 64-bit systems (or 128-bit ones..)
without increasing its size. But, besides that, it would have the benefit
of simply being serialized with the syscall, and not a supplemental,
potentially non-thread-safe errno/strerror-like kernel-side implementation,
nor extra syscalls to retrieve information or arbitrary formatted or
unformatted strings.

Netlink extended ack could benefit from it simply by having been passed
an nlattr pointing to the buffer and recording extended error information
in it - the extended ack structure can report the status of the buffer
and use the cookie field to reproduce some information if necessary (which
extends the RAS error record concept further when needed).

Thoughts? Does anyone have any objections to a RAS-like error reporting
system for system calls, or any ideas on things that would benefit from
it above and beyond perf? We could always audit all the system calls and
their behaviors so we could do some worked examples but anyone who's got
a good candidate outside perf is welcome to suggest it.

Ta,
Matt




IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
