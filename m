Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeCWQZd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:25:33 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:8299 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbeCWQZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:25:30 -0400
X-IronPort-AV: E=Sophos;i="5.48,350,1517846400";
   d="scan'208";a="177419846"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>
CC: "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] target: Use WARNON_NON_RT(!irqs_disabled())
Thread-Topic: [PATCH] target: Use WARNON_NON_RT(!irqs_disabled())
Thread-Index: AQHTwSradWvxjdgAqEmtQCoI9WXRAaPbBs4AgAD5uYCAAfvLgIAACHCA
Date: Fri, 23 Mar 2018 16:25:25 +0000
Message-ID: <1521822325.2535.5.camel@wdc.com>
References: <20180321153854.GB24312@kernel.org>
         <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
         <20180322093745.GC4229@kernel.org>
         <20180323155513.dwbgvblenlji33as@linutronix.de>
In-Reply-To: <20180323155513.dwbgvblenlji33as@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0753;7:lYNwxLLeEThxV1KuBkFpeEVPxEiS/bUlLxxXo7R0rEhrYn5C0JYHmYwLXSsmf5ACXdG6OGpBfhcozQiuIC07dMQCv+fK9C/YVF0c+rWBo0Er9uQXUmc/Pf7+XmeOVVDVCxfPe60zvHkyeepLnrfIqbgYp87xBE2AdeQoRy/B+guBx5vfPqA9+g6ckjYpvKHNDEkZaJNvdoXAI7iI785/wSHXtGztuP5r9AJMI/QRg+RoY/F3bCOeW3NYzDCT0VxX;20:dyz0NwTXJtHF/BH7OT9Bkx9jYrGXoDgN8cJeO7yB5VZ2ppgDwsgtN1P7v5DhRYSTou+P2LzSaeJbvyB/q22/OP7TIQpqCVJYIt816pvyHtL2vhlbR1E85QlpQ9ahLxUEUnt3sCAvbVEtW03DSnFoHv0dDyL5gpF/tA6pKzU5Blg=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d8cb143-49f8-43a4-60da-08d590daaf5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0753;
x-ms-traffictypediagnostic: MWHPR04MB0753:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07538D4A40E5161CEF2563A398A80@MWHPR04MB0753.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0753;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0753;
x-forefront-prvs: 0620CADDF3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(51444003)(189003)(199004)(377424004)(186003)(6486002)(36756003)(6512007)(6436002)(4326008)(25786009)(68736007)(6246003)(59450400001)(26005)(305945005)(8676002)(6506007)(103116003)(2906002)(53936002)(76176011)(93886005)(99286004)(66066001)(3660700001)(11346002)(316002)(54906003)(97736004)(3846002)(110136005)(6116002)(5660300001)(105586002)(14454004)(478600001)(7736002)(3280700002)(446003)(2201001)(8936002)(229853002)(72206003)(106356001)(7416002)(86362001)(81166006)(5250100002)(81156014)(2501003)(2900100001)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0753;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 14P01GskB6UUFcD8rBq51mZEZIG5WZw2jd4pnRdc7kdl0fo372Um1eUUPWyVhMF/5MbA1PVjukfrbjjgaJ5xzWjrnYq8A81BpkRRoMzYL66Z/a0enEkhL2zg1Q/pD8CofP4T51yg90u+CCJ/WOHnE36AKRbW9eGP2QRH+SEiG+M0VFm/8U2QpYU5kIL361DZuqFV/1pBaTPbNdt6DaQdGzmCUCtqWhqdX0+LyE4uvk5tpUmQeV5+kio76iRFbHTGnMzCXtuWeomFBEXEIx5pALN3R3I6cbGNBThE4xFkQqyvvVdcBCs2+My0eye7P/p/7efW4QDnTxZQA6MT36m9+g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E43EC1815970742906861AF2E51524A@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8cb143-49f8-43a4-60da-08d590daaf5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2018 16:25:26.0189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0753
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2NGPbIJ005635

On Fri, 2018-03-23 at 16:55 +0100, Sebastian Andrzej Siewior wrote:
> I am going take this into -RT tree for now until we have different
> solution.

Have you considered to delete the WARN_ON_ONCE(!irqs_disabled()) statement?
I think that check duplicates functionality that already exists in lockdep
since lockdep is already able to detect spinlock use inconsistencies.

Bart.
