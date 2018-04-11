Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeDKNBo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:01:44 -0400
Received: from sesbmg22.ericsson.net ([193.180.251.48]:53792 "EHLO
        sesbmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753017AbeDKNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:01:42 -0400
X-AuditID: c1b4fb30-e6c349c000005e22-1c-5ace0734a050
From: Jon Maloy <jon.maloy@ericsson.com>
To: Ying Xue <ying.xue@windriver.com>, Jia-Ju Bai <baijiaju1990@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "tipc-discussion@lists.sourceforge.net"
        <tipc-discussion@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] net: tipc: Replace GFP_ATOMIC with GFP_KERNEL in
 tipc_mon_create
Thread-Topic: [PATCH v3] net: tipc: Replace GFP_ATOMIC with GFP_KERNEL in
 tipc_mon_create
Thread-Index: AQHT0X9aNgww/cwaY0uyVLV74ARKhaP7XCsAgAArH9A=
Date: Wed, 11 Apr 2018 13:01:37 +0000
Message-ID: <BN6PR15MB1553A17CEE70F118762039929ABD0@BN6PR15MB1553.namprd15.prod.outlook.com>
References: <1523442262-4823-1-git-send-email-baijiaju1990@gmail.com>
 <7bf48d79-54fe-421a-e04c-f2d6cd2c71e2@windriver.com>
In-Reply-To: <7bf48d79-54fe-421a-e04c-f2d6cd2c71e2@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com;
x-originating-ip: [192.75.88.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1587;7:CNkW6X6sFQSpNAA3L1Q0qEbs2Rq/mPu64wZYAzfBOkxXAZOTidqps4VNY1SjoaIyNniBI3PjXNiQ1pBsYSCe5XVnM4iRnzJ6tkJa+mnt+aqMfx3uMnTtazJ+HbjZgL8wRZ4r0EI0DrT3P9MuF83GRnCmfPdHYqn5AJ6uw7IOsiIKlUfk6cNcAqQoaXgJis1Qcuzc1LA69sb0/qpGlOaSLz+g98uQQRwEDiqIvG+Hhf5TusSzwy3/43cf7hVwDFVT
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1587;
x-ms-traffictypediagnostic: BN6PR15MB1587:
x-microsoft-antispam-prvs: <BN6PR15MB1587C3B1C45A10B53C98C7DB9ABD0@BN6PR15MB1587.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(143289334528602)(9452136761055)(85827821059158)(788757137089)(42262312472803);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR15MB1587;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1587;
x-forefront-prvs: 0639027A9E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(346002)(366004)(396003)(376002)(189003)(199004)(13464003)(68736007)(2900100001)(81156014)(8936002)(6436002)(229853002)(8676002)(53936002)(81166006)(86362001)(74316002)(6246003)(5660300001)(7736002)(305945005)(2906002)(14454004)(66066001)(39060400002)(3660700001)(3280700002)(55016002)(110136005)(478600001)(5250100002)(53546011)(2501003)(54906003)(33656002)(106356001)(476003)(97736004)(9686003)(316002)(11346002)(186003)(486006)(4326008)(59450400001)(105586002)(99286004)(102836004)(6506007)(76176011)(25786009)(7696005)(26005)(3846002)(446003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR15MB1587;H:BN6PR15MB1553.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: NbK0j9gmATKiY0KQILCYPYQ0qwFs2tAEATxVUa1u9qLJf2f7xisRZ4nLKsRygt3rYq9YXJmQuSrQC5lF1lZmLwhjtz9ZPfYgUJc/AbCel0a9EyeGPcyeGfukwA9BzNuB74I1PMoGwmmAnrA2ekSjCB+7w2zgw8VzHfWSsBGHk0tXUlsbnC/JshKfw1/EAcvIr45x3cngVr+wMTv7a80imi6w0rFEDYJ6SmXlXm4npzlGxh0GZ7B9hEamJYidLOTY9IUbLLsvVQKoYHuaRXnmaghTgISiWobNag7gtfmiwVgDc7OsxzwmcAAVda8aEtNYNtULiU9HVve1p9WseoGoKNHq75qm3hl1itoyopmzYBUzbv4i9zJY5Ue1DU3fKWmcUEPn3BhTmutJ/tl+gzPUU8aiSkfqBACRumYfAKLqxko=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cb8ad197-b28c-4a81-f672-08d59fac5c57
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8ad197-b28c-4a81-f672-08d59fac5c57
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2018 13:01:37.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1587
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUiTYRj3/Y7t81i9LY8nO8iRoIYnBUM6lKKGhBr1Ry6hVn6pebJvmVaQ
        mMlSJDtUHJpLJx6Ylq5cdunI1EzNCkRJwRuhLG9qMfLbZ9B/v4vn+T0vL0NKa2h3Jj5Zw6qT
        VYkykQNVcqrlpO9ecZ8yIGfFUd5w5yEhL+3PpuSfW0tF8nd6V7mx/6J8YnCQDBEpjLVDhOK5
        bkSseKFfJBSLTTsUjcanRCStdNgXwybGp7Fq/wNnHeJaWhtEqVZIXzBkijNRPeQiewbwHrhR
        PErlIgdGit8i6O3KpgViRPC7ppAUyCqCpS8WQiBVBPTU6UU8ofACAbUDbesD7hHQ2b0sEsg4
        gsn2cZpfI8JeMFukRbmIYZxxBlhLWT5D4h4EpkdWgs9sxkoYmuq25Z3xaSj6UkIIOBgM2jnE
        Ywp7wldtmZjHEhwNH0fHKB5L8TXoqGiz6fY4FExZJlseYVdYfV9vm0NiNxieLCeEszEYXvaT
        AnaB2QkrzXdDOAp6pqIE2QPaTY9pAW+HT+V5iO8M2EhAWZVx3fCFn4XCIwF+g6Bsdp4SDB+4
        acleX5YAnT39tBDSIlitzlonVSQU9erpAhSo+6+hbq0Jib2hsdVfkD3gft6YWGc7ehN0l0xS
        ekTVIReO5c4lxQYF+bHq+PMcl5Lsl8xqmtDa/2k3WgJMaHYm1Iwwg2ROkg3DvUoprUrjMpLM
        CBhS5izpsKxJkhhVxhVWnXJGfSmR5cxoK0PJ3CTy8GalFMeqNGwCy6ay6n8uwdi7ZyKviFvW
        H8UHK78F/nn1fVqZv+LibXfh2ECOaot0/nAO5+35zFxScfuBZlrNxhjFT3bqREx+QL13dUTY
        3PLERPiurtfbHI8W7O47dNn6IcE8cjWIcmrKRakRR+42h1RGDwVrNobZ1Zjm64MNdQnSlqUT
        moHjv67PRBpq07Vpfm37LTKKi1MF+pBqTvUXKQ2DlTsDAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3BD1o16020306



> -----Original Message-----
> From: Ying Xue [mailto:ying.xue@windriver.com]
> Sent: Wednesday, April 11, 2018 06:27
> To: Jia-Ju Bai <baijiaju1990@gmail.com>; Jon Maloy
> <jon.maloy@ericsson.com>; davem@davemloft.net
> Cc: netdev@vger.kernel.org; tipc-discussion@lists.sourceforge.net; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] net: tipc: Replace GFP_ATOMIC with GFP_KERNEL in
> tipc_mon_create
> 
> On 04/11/2018 06:24 PM, Jia-Ju Bai wrote:
> > tipc_mon_create() is never called in atomic context.
> >
> > The call chain ending up at tipc_mon_create() is:
> > [1] tipc_mon_create() <- tipc_enable_bearer() <-
> > tipc_nl_bearer_enable()
> > tipc_nl_bearer_enable() calls rtnl_lock(), which indicates this
> > function is not called in atomic context.
> >
> > Despite never getting called from atomic context,
> > tipc_mon_create() calls kzalloc() with GFP_ATOMIC, which does not
> > sleep for allocation.
> > GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> which
> > can sleep and improve the possibility of successful allocation.
> >
> > This is found by a static analysis tool named DCNS written by myself.
> > And I also manually check it.
> >
> > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> 
> Acked-by: Ying Xue <ying.xue@windriver.com>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
> 
> > ---
> > v2:
> > * Modify the description of GFP_ATOMIC in v1.
> >   Thank Eric for good advice.
> > v3:
> > * Modify wrong text in description in v2.
> >   Thank Ying for good advice.
> > ---
> >  net/tipc/monitor.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c index
> > 9e109bb..9714d80 100644
> > --- a/net/tipc/monitor.c
> > +++ b/net/tipc/monitor.c
> > @@ -604,9 +604,9 @@ int tipc_mon_create(struct net *net, int bearer_id)
> >  	if (tn->monitors[bearer_id])
> >  		return 0;
> >
> > -	mon = kzalloc(sizeof(*mon), GFP_ATOMIC);
> > -	self = kzalloc(sizeof(*self), GFP_ATOMIC);
> > -	dom = kzalloc(sizeof(*dom), GFP_ATOMIC);
> > +	mon = kzalloc(sizeof(*mon), GFP_KERNEL);
> > +	self = kzalloc(sizeof(*self), GFP_KERNEL);
> > +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> >  	if (!mon || !self || !dom) {
> >  		kfree(mon);
> >  		kfree(self);
> >
