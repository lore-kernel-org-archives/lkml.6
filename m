Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751188AbeEUSqx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:46:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49876 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeEUSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:46:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,427,1520870400";
   d="scan'208";a="80201852"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "osandov@osandov.com" <osandov@osandov.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAAAdgCAAANfAIAAASwAgAAM54CAAAVVAIAABROAgAD+3gCAADm6AIAAAm4A
Date: Mon, 21 May 2018 18:46:26 +0000
Message-ID: <18450c81c05a4e65e3fcca4ece3f0fe9bad8170f.camel@wdc.com>
References: <20180518090636.GA14738@kmo-pixel>
         <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
         <20180520221733.GA11495@kmo-pixel>
         <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
         <20180520223116.GB11495@kmo-pixel>
         <b0aa2a8737b2d826fea58dc0bc113ddce50f018a.camel@wdc.com>
         <20180520232139.GE11495@kmo-pixel>
         <238bacfbc43245159c1586189a436efbb069306b.camel@wdc.com>
         <20180520235853.GF11495@kmo-pixel>
         <d3fbfaa667f5ac64c1f230249e3333594cb4a128.camel@wdc.com>
         <20180521183742.GC14774@vader>
In-Reply-To: <20180521183742.GC14774@vader>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3759;7:kQYO2GUyimNg9s+OJjpEIMNkbo6MAZccikc7bip4FNsoNGLk3EQheYilXEhv5yIR32mDOLJMwBBdzrt0QQXC7GPQqDAU3xSiDvpAxHJdBAF6XGB/pg4bfxsUml3BeCL0xEb55zP7E6Tjm2QZd1awxdbPblbJbH5DNwCIcwB46Ly3r5PL+gVP9KSUMKin1+ttQL/pwI6PFRUt9spYOk7ybBmBz2CISkjF6s+3SY2eXEclNkC8XoLlzc5rNqhY+TJV;20:OmvN9mNVhdOEMEpwOCEkrIhhN7h6hXMRvYcDBzOKnF/ma5IE6395Cxs18ON6+RXTDwWeF7kQgnjGLnYxrKZLTTgLzWltT5bXkq/clrBY8HivSlRSU8HZQYWR6qUNCzb8XrrnQJlD1JTYEZlYa0ngmyK/8NgOJMfSCSinvGPAzpA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB3759;
x-ms-traffictypediagnostic: MWHPR04MB3759:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB37599BC3E517150503E62CEA98950@MWHPR04MB3759.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB3759;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3759;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(377424004)(199004)(189003)(6246003)(6506007)(4326008)(6512007)(316002)(53936002)(39060400002)(186003)(476003)(11346002)(446003)(54906003)(102836004)(2616005)(14454004)(26005)(93886005)(106356001)(76176011)(5250100002)(2501003)(99286004)(66066001)(118296001)(229853002)(6436002)(105586002)(5640700003)(6486002)(6116002)(2351001)(3846002)(8936002)(6916009)(68736007)(36756003)(8676002)(2900100001)(5660300001)(72206003)(305945005)(3280700002)(86362001)(25786009)(486006)(97736004)(3660700001)(81156014)(1730700003)(81166006)(478600001)(2906002)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3759;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: h0LZLFbhFNmJKGka4lO+d1EjG0pBM9tFa1uceMxHEqnJ4TEaV2/4sWoxLXkqmmd4EhKkFqAkOWxBTbiNXQugLwelHOK0HBeUMf2msABe+lV6CBOtTDbj1aMimRTUuPlbNQy31p/1yn/4e5y4SWaHL5FXYxEysupMx9HpCIDQLxRzEU7oBV7PfXhTTyUfNVNf
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DFEDEF0E0F97B4A9351FD1B3BBB9FA9@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e4d02b6b-ed5f-4cf0-083c-08d5bf4b2847
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d02b6b-ed5f-4cf0-083c-08d5bf4b2847
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 18:46:26.1051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3759
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4LIl0qa027688

On Mon, 2018-05-21 at 11:37 -0700, Omar Sandoval wrote:
> Have you made any progress in porting srp-test to blktests so we don't
> have to have this conversation again?

Hello Omar,

Porting the srp-test software to the blktests framework is still high on my
to-do list. I will start working on this as soon as the work on adding SMR
support for fio has been completed.

Bart.
