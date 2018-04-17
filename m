Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeDQVyn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:54:43 -0400
Received: from mail-cys01nam02hn0225.outbound.protection.outlook.com ([104.47.37.225]:10880
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeDQVyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:54:41 -0400
From: Trond Myklebust <trondmy@hammer.space>
To: "bfields@fieldses.org" <bfields@fieldses.org>,
        "syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com"
        <syzbot+4b98281f2401ab849f4b@syzkaller.appspotmail.com>
CC: "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: general protection fault in encode_rpcb_string
Thread-Topic: general protection fault in encode_rpcb_string
Thread-Index: AQHT1gDiDIUW1CsFSU2D4EXhiIr/fKQFe1gAgAAF/QA=
Date: Tue, 17 Apr 2018 21:54:36 +0000
Message-ID: <1524002074.63751.5.camel@hammer.space>
References: <f4f5e80803d08f47b9056a0366dd@google.com>
         <20180417213308.GC18217@fieldses.org>
In-Reply-To: <20180417213308.GC18217@fieldses.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [68.49.162.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR13MB2448;7:u1N73uN51CHaR4K2RKTy8YVlzFZ4cT6wNv2dP7VxBoT3xnUy44TzT8ydsxAYOgeT5ZxtDiIJGKZtZeoiDmEtfClb76P1d5PybCVK2/TzLDVNTyXtdWKnTf9PvODDv6HbEkUiL+JdU7IUn9Eu2jump99RJCzc65qp7UApm40M8oCBVceoehFuOncGlishuFa13zKdh3//npeD1gZm0l9genoeTmcKQ/FD+ibyYdsHGZxZ8rnua7lnmmQLw8HWc+d7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7027125)(7031125)(7023125)(7093024)(5600026)(2017052603328)(7153060)(7177020)(7172020)(7174020)(7193020);SRVR:SN6PR13MB2448;
x-ms-traffictypediagnostic: SN6PR13MB2448:
authentication-results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=hammer.space;
x-microsoft-antispam-prvs: <SN6PR13MB244831F7117AA197A487B07DD9B70@SN6PR13MB2448.namprd13.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(84791874153150);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501361)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(2016111802025)(16045075)(20161123558120)(20161123564045)(20161123562045)(16040078)(6059035)(20161123560045)(16043105)(16046073)(6043046)(6072148)(201708071742011);SRVR:SN6PR13MB2448;BCL:0;PCL:0;RULEID:;SRVR:SN6PR13MB2448;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(34036004)(39830400003)(39380400002)(366004)(376002)(396003)(346002)(377424004)(57704003)(3846002)(26005)(33896004)(59450400001)(446003)(102836004)(14454004)(6116002)(186003)(2906002)(6506007)(6246003)(6436002)(6486002)(2616005)(38610400001)(86362001)(476003)(11346002)(586005)(110136005)(6306002)(6512007)(229853002)(54906003)(2900100001)(53936002)(4326008)(81166006)(8936002)(966005)(3660700001)(25786009)(3280700002)(8676002)(5250100002)(76176011)(103116003)(66066001)(52396003)(2501003)(99286004)(305945005)(7736002)(5660300001)(498600001)(66950200005)(35760200005)(46492003);DIR:OUT;SFP:1501;SCL:5;SRVR:SN6PR13MB2448;H:SN6PR13MB2494.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:nov;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: OWKPTWAa9Rvz4QsyCK7lzKiR6cdnpde25VOGwJTIeOR1p19M04+XoP6p4llkBUDqePteSULg3Bpx6xCiHhHyVyTcaaN/HODdzodgK5JhrGqxhPFKXBS4M9eZH4jOAfCL5hZN6g4SPerTGfpyLbVyTTTXkD0I+FbJKeNacF/BMISaydDgz8PmL0ICvow6prjfURj7kf5AcOsd3DuX78CVAnsqDI7vd9nP2wG1f5Y2d/oNiohZ1CxxwinoIcVJ23A4NHxFVMxhKs7ZTPxDZF4YeXH9eAHPWsOpjWSJ5ONF2Yp09yAz6lqsm4WhW5J7x/3Q5HuhxdbyePVHB8pEP03vvIFo5z0W2e35Zm4adxaizWvy6BTBP8+fYYlFmuuQ9WcMacJkqwEVjU7ZKXEtMDkjZ2ZQlu0ueItgpx0eS0BMx10=
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBEBA5DE54D9B54A95A1C0E9AC575662@namprd13.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 2dcea376-661a-4139-1094-08d5a4add00b
X-OriginatorOrg: hammer.space
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dcea376-661a-4139-1094-08d5a4add00b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 21:54:36.8070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR13MB2448
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3HLsngI028362

On Tue, 2018-04-17 at 17:33 -0400, J. Bruce Fields wrote:
> On Mon, Apr 16, 2018 at 09:02:01PM -0700, syzbot wrote:
> > syzbot hit the following crash on bpf-next commit
> > 5d1365940a68dd57b031b6e3c07d7d451cd69daf (Thu Apr 12 18:09:05 2018
> > +0000)
> > Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=4b98281f2401ab849f4b
> > 
> > So far this crash happened 2 times on bpf-next.
> > C reproducer: https://syzkaller.appspot.com/x/repro.c?id=6433835633
> > 868800
> > syzkaller reproducer:
> > https://syzkaller.appspot.com/x/repro.syz?id=6407311794896896
> > Raw console output:
> > https://syzkaller.appspot.com/x/log.txt?id=5861511176126464
> 
> Based on that, looks like it's attempting an nfs mount while causing
> kmalloc failures?
> 
> Probably one of rpcb->r_netid, r_addr, or r_owner was bad in
> rpcb_enc_getaddr.
> 
> Hm, and previous log makes it look like it was an
> rpc_sockaddr2uaddr()
> in rpcb_getport_async() that was made to fail.  Do we need to check
> for
> failure of:
> 
> 	map->r_addr = rpc_sockaddr2uaddr(sap, GFP_ATOMIC);
> 
> ?

Yes, and we can probably convert it, and the other GFP_ATOMIC
allocations in the rpcbind client to use GFP_NOFS in order to improve
reliability.

Cheers
  Trond
-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammer.space
