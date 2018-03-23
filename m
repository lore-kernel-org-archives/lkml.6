Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeCWRo4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:44:56 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56569 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWRox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:44:53 -0400
X-IronPort-AV: E=Sophos;i="5.48,351,1517846400";
   d="scan'208";a="74954991"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
CC: "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] target: remove spin_lock_assert() in
 __target_(attach|detach)_tg_pt_gp()
Thread-Topic: [PATCH 2/2] target: remove spin_lock_assert() in
 __target_(attach|detach)_tg_pt_gp()
Thread-Index: AQHTwssw/ek84VX6f0CewLK+jkAVz6PeF6yA
Date: Fri, 23 Mar 2018 17:44:46 +0000
Message-ID: <1521827085.2535.12.camel@wdc.com>
References: <20180321153854.GB24312@kernel.org>
         <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
         <20180322093745.GC4229@kernel.org>
         <20180323155513.dwbgvblenlji33as@linutronix.de>
         <1521822325.2535.5.camel@wdc.com>
         <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
         <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
         <20180323171959.7ac6klrqg4fdk3ey@linutronix.de>
In-Reply-To: <20180323171959.7ac6klrqg4fdk3ey@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0206;7:LrkbN2eMPGY6bkrDUTO9jF0tUBBkU+1+fsRLxW3SBEL5KW7ezjfo3e3wlfq4xGW9iwbvw5Eias7LkXUiEUb3+wTPj8mr15oFcJnUcJD6wd4A27H1bK2sHdgd484xX5kuEczVvWBLh+cBlK27Gv/TnKaUrXsjMc9N1EVFQqH59nKAxe7qMH8oeqRdm9uSnJ/tq9mW22//oYzS56UzycYF++XH3s4ibtGg3PZPjYNdAx9LmZPnLW0SbdxX1SZEqF7u;20:wvLgZHL+c8xXMB2BMEWEw1bMexplVSF9mxwGcniFo2jABlBypB0jwdtXqe1wWGrsQxYFqwI8IiXZ4aiwj5fQk0t5F6RsyqXyV/ZTx25bHwwANkvMYKP7OdPnURaaKZFvpMjM6MEL35iZztAFEr9bAa34TP8nubp0D31sU8jPXl4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 15d89f87-3603-4c91-0ddf-08d590e5c50a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0206;
x-ms-traffictypediagnostic: MWHPR04MB0206:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0206725FE791A1715641238698A80@MWHPR04MB0206.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0206;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0206;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(39860400002)(346002)(396003)(189003)(199004)(51444003)(377424004)(106356001)(68736007)(7736002)(93886005)(59450400001)(186003)(76176011)(7416002)(478600001)(103116003)(11346002)(97736004)(446003)(316002)(14454004)(72206003)(305945005)(5890100001)(6116002)(5250100002)(26005)(3846002)(6246003)(2501003)(2906002)(66066001)(6436002)(6486002)(53936002)(6512007)(229853002)(54906003)(110136005)(4326008)(102836004)(5660300001)(6506007)(81166006)(3280700002)(3660700001)(2201001)(86362001)(2900100001)(8676002)(81156014)(8936002)(105586002)(25786009)(99286004)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0206;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 2Z3d7+mONgqrdP2vwXDaFvyPvz8fgwR47WToSTgyrjn43FRU2rN4Su80xBM82vuXcjlN+8/HMGSm5lomt+5WrDTRJTPi9yK8Sv+bn8r+mNfbltmKVHbfYnhuGA3XQwKwE7kVW25cG0WgTpdsz/WNaUKxffKI8FFJ2stxKxyfLZnIDr3JdFdy2c330wnQ/MoHf2NGFdUj7kZXVlC+jXca0eFfJV5czWl3LgaDAIQ0D780qtWUoazPfUXBMwuzHrW9ihiR1AQFwPI1m09azdkJE3mfUJElosxEbIrJayEqt2T+hhOK/LBfMJ4P6/FngoKw7FzS0fdrAb7+UCn/Jq56wg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0EF4A7A86E3864C8F349081FE016E90@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d89f87-3603-4c91-0ddf-08d590e5c50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 17:44:46.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NHj1R6010138

On Fri, 2018-03-23 at 18:19 +0100, bigeasy@linutronix.de wrote:
> __target_attach_tg_pt_gp() and __target_detach_tg_pt_gp() check if the caller
> holds lun_tg_pt_gp_lock(). Both functions are static, the callers are
> acquiring the lock before the invocation of the function so the check
> looks superfluous.
> Remove it.

Does this check cause trouble to anyone or to a specific kernel configuration?
In other words, do we really need to remove these checks? I think that these
checks are useful as documentation to people who read the SCSI target code.
The target code is already hard to follow so I think any documentation,
especially documentation in the form of code that is checked at runtime, is
welcome.

Thanks,

Bart.
