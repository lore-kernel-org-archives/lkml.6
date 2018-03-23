Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeCWR4N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:56:13 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7351 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeCWRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:55:58 -0400
X-IronPort-AV: E=Sophos;i="5.48,351,1517846400";
   d="scan'208";a="74995772"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
CC: "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] target: remove spin_lock_assert() in
 __target_(attach|detach)_tg_pt_gp()
Thread-Topic: [PATCH 2/2] target: remove spin_lock_assert() in
 __target_(attach|detach)_tg_pt_gp()
Thread-Index: AQHTwssw/ek84VX6f0CewLK+jkAVz6PeF6yAgAABh4CAAAGVgA==
Date: Fri, 23 Mar 2018 17:55:54 +0000
Message-ID: <1521827753.2535.18.camel@wdc.com>
References: <20180321153854.GB24312@kernel.org>
         <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
         <20180322093745.GC4229@kernel.org>
         <20180323155513.dwbgvblenlji33as@linutronix.de>
         <1521822325.2535.5.camel@wdc.com>
         <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
         <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
         <20180323171959.7ac6klrqg4fdk3ey@linutronix.de>
         <1521827085.2535.12.camel@wdc.com>
         <20180323175013.6uucllg5ogyzfovt@linutronix.de>
In-Reply-To: <20180323175013.6uucllg5ogyzfovt@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0624;7:vQfKvS7GLV4ZEzogEXAHSFNrbRLY04gfGcbVbWx6kWe6saEDSG7G23HLDUl1S2Nj0kKq53E+OrK4oqbn4iwwIstKZrvmbW+AA0bB4kvxII12iflvTOvC1C7IAmxUPqwFSed07pAiLt62i8V3y9m/8ZXoPX1MkzYe8y5X2oGr1A0vf9vDXZRPk3KnUK8Mu4ptOxhVdRX49eBZgNJSxLQ5q5OZgATfXsEMFC9GCnWGNV9LH2txW7j1acDQZjRw9Lo7;20:BHPFq7uegWOo3BXz16K6pg6ZBD+R1q1nPs7pavNZQ+YKGhLkA8AYt5Bd80XX/yrHFimwtAfUk7IttfwHmy93vdjEx1jyHfjQ0+0bnt6Rwdv+vATKsaQhnQqQb4MlkMqUMekGm6HajbOw/DzEI+/6ZIHUS4EGcRZHob5EAxaCXYI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52ab6491-0c9e-4864-512d-08d590e752c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0624;
x-ms-traffictypediagnostic: MWHPR04MB0624:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0624866B6FEF78A8DB8904D398A80@MWHPR04MB0624.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0624;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0624;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(376002)(39380400002)(199004)(189003)(377424004)(51444003)(81156014)(1730700003)(7736002)(316002)(3280700002)(68736007)(5640700003)(2351001)(3660700001)(478600001)(81166006)(2900100001)(8936002)(2501003)(5250100002)(11346002)(6116002)(3846002)(4326008)(97736004)(2906002)(105586002)(106356001)(103116003)(6506007)(53546011)(5660300001)(446003)(6512007)(8676002)(76176011)(26005)(6486002)(7416002)(53936002)(6436002)(305945005)(229853002)(186003)(59450400001)(66066001)(54906003)(99286004)(36756003)(93886005)(6916009)(6246003)(72206003)(25786009)(102836004)(86362001)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0624;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 4WtSC/mOKk2ucxGuDeKMryO1NaqnpfFFdfGvAmgoUgapuXp6F4rydoZdJ9iqGxAxE60S81fWMeZF41L+5e+9t5B2TtJMGRQoiZFzARXXyqFw9Cec0Zse7aXodJXHmizo4fCJwrL9/4vB1sd4tQ44iZ/yeg15CtQQEd9Eu40S+Kwp29gdaJa0zhm+AkzsRYG/hFytnSHs2G9aDVkqpxaOo69LhOyem/PBNzvpvHYgtl3TiTS+UsU2JRsElaMd4tz5wjyajsbPtRbJpLbsc5YFzEs/YkPuvzcOaB0wyH1jHWGiDyd+NuYBSx/UqHk1grCkIWnf9QVLz7OQNIvQvDZL8w==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <10DDBCCF35C36246B75B0AB3D36CA660@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ab6491-0c9e-4864-512d-08d590e752c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 17:55:54.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0624
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NHuJmk013594

On Fri, 2018-03-23 at 18:50 +0100, bigeasy@linutronix.de wrote:
> On 2018-03-23 17:44:46 [+0000], Bart Van Assche wrote:
> > In other words, do we really need to remove these checks? I think that these
> > checks are useful as documentation to people who read the SCSI target code.
> > The target code is already hard to follow so I think any documentation,
> > especially documentation in the form of code that is checked at runtime, is
> > welcome.
> 
> so if I remove those two and add a kernel doc comment instead, saying
> that the caller needs to ensure that "lun->lun_tg_pt_gp_lock" is held
> then we would remove the obvious runtime check and add a piece of
> documentation. Would that work?

Comments are not verified at runtime and hence can become outdated if the code
is modified. assert_spin_locked() and lockdep_assert_held() assertions however
are verified at runtime with the proper kernel configuration options enabled.
Hence my preference for assert_spin_locked()/lockdep_assert_held() over source
code comments.

Thanks,

Bart.
