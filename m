Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752518AbeCWRrW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:47:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53915 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCWRrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:47:17 -0400
X-IronPort-AV: E=Sophos;i="5.48,351,1517846400";
   d="scan'208";a="74995344"
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
Subject: Re: [PATCH 1/2 v2] target: drop spin_lock_assert() + irqs_disabled()
 combo checks
Thread-Topic: [PATCH 1/2 v2] target: drop spin_lock_assert() + irqs_disabled()
 combo checks
Thread-Index: AQHTws2CUdKr1letFECJ4oHEGDSLBqPeGFiA
Date: Fri, 23 Mar 2018 17:47:14 +0000
Message-ID: <1521827233.2535.15.camel@wdc.com>
References: <20180321153854.GB24312@kernel.org>
         <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
         <20180322093745.GC4229@kernel.org>
         <20180323155513.dwbgvblenlji33as@linutronix.de>
         <1521822325.2535.5.camel@wdc.com>
         <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
         <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
         <20180323173633.kh5fwrfj6b5elki5@linutronix.de>
In-Reply-To: <20180323173633.kh5fwrfj6b5elki5@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3776;7:qk56/aq22WaGzlKN0QDJPMJfRA3OO8GgnkJHkIEQ8ET/1NFyFE3r/YRongWJMyKyprehPbVCIDWGc1LjxdLsHaVh6EQGvj467ggMwH79Locq5eFhdX/PZNkc4XVEwRLbot3wPgNwJoHRUEEn6/lnVB56kyGc0G5nMwBDLWDanzm6ap9JceQ1z7mK0poiDhaaPYUPtcCHe1dxobuHoZvHOOzJQjx54DcduJ5f437/gArKY+9mAShdyX0BaEnazgYY;20:YE6cxfLkisesWea1PdZUWZ0+52U7Hp6sYzrhr3qJO/bKVZA12u1e9F0ezcPyYr2nAleLrOlTwUHV1+MfW2C38IQcwp6BoDSvM63xxs02aLA+xMa30h3zM1cMeO/eM7xw6MoGgPr1HLqif0RC46RdFSX889hvAmmOJHpT3h1EgK4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e1a85ae-3b7f-4821-bfd2-08d590e61d26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB3776;
x-ms-traffictypediagnostic: MWHPR04MB3776:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB3776EA583E525957F4BC882B98A80@MWHPR04MB3776.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB3776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3776;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39860400002)(39380400002)(346002)(396003)(377424004)(199004)(189003)(68736007)(66066001)(478600001)(6116002)(3846002)(86362001)(6486002)(36756003)(2201001)(6436002)(2906002)(3660700001)(2900100001)(3280700002)(93886005)(105586002)(316002)(72206003)(25786009)(4326008)(14454004)(97736004)(76176011)(5250100002)(2501003)(99286004)(5660300001)(7416002)(229853002)(305945005)(7736002)(110136005)(54906003)(26005)(8676002)(81156014)(186003)(103116003)(53936002)(81166006)(106356001)(8936002)(6512007)(6506007)(6246003)(11346002)(59450400001)(446003)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3776;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: czsD3mPEbZv+Z57cV3kyM4i+SVJ+MqtLlcVtu8a+NqhG7LJSiJN8xlQc6UZxzrbcmnmiKhvWzxT4C2XQqSkXal82h0VZHpaUdC69Iu15BA6SC2ucKrHLSg4JpWt1/jLqp2gms+5tlmLHnRfEzQiCXpHlHr3SqaLdNQJIUwWz+QoBNKSa5EDUeCCSYNOpybR0Uzx3nVlznCr/fr1KXjbR56lrEznEcgZXNFGSRhc1MEGxP7fj0KpidFbO6lzrN5pp1OsSf1VuxjO+E/GUe167sPFuRPk4ucJ5WC+mb3gjX93axpzGlE3JS9KSfmLU3WMUaSo3Rgm/nbf11VqXCDm5bw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <07681E6E0C3FEB4D8675F0958D837123@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1a85ae-3b7f-4821-bfd2-08d590e61d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 17:47:14.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NHlQ3N013388

On Fri, 2018-03-23 at 18:36 +0100, Sebastian Andrzej Siewior wrote:
> There are a few functions which check for if the lock is held
> (spin_lock_assert()) and the interrupts are disabled (irqs_disabled()).
> > From looking at the code, each function is static, the caller is near by
> 
> and does spin_lock_irq|safe(). As Linus puts it:
> 
> > It's not like this is some function that is exported to random users,
> > and we should check that the calling convention is right.
> > 
> > This looks like "it may have been useful during coding to document
> > things, but it's not useful long-term".
> 
> Remove those checks.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
