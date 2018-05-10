Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966570AbeEJQPA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:15:00 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34319 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966443AbeEJQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:14:56 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520870400";
   d="scan'208";a="77616981"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
Thread-Topic: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
Thread-Index: AQHT48vXJqSyK9joLk6vczqXprVwi6QpLHKA
Date: Thu, 10 May 2018 16:14:50 +0000
Message-ID: <d534de4765c0fbcc7bcd858c1d2f40391ece19ac.camel@wdc.com>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
In-Reply-To: <20180504171701.6876-1-paolo.valente@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.173]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0320;7:mWAcCwik+D5RxTN9OWV0iISd0U7qR7T0uuk3Ur0r1nKYaYeRZrBjkKpUdp0s3L8jY3/DprVsdSWea8sSE8/QK/Rwi4Uqde+RopJQmnAz/fpXho4egBarSqu4czmSCUjK6zzPu8Zs6J+KE4KTGHFzYltR0tPJ4TS8g8k5FdOJAwGG4Xo0VaFjQJLmeQdfBYPZab1wh2kwu/awhBXplH/mB0qbbI1aotupP4QD8zaF4wt9PuynHr54uNQN9NqDZsLf;20:/WZysHjD4bn7vwriVD7a4VTtOf37DnWx1TknJJB+NOYb6j0AylY0TIuJfZ5e/hGHxkq6QgD3oX1YPBgtT8g+8OJ9tpWJSkN229FBGLZ4QkxIcDsXQdn9EcfWboV1cJHE95b7aMTaiowFyANcQ4HKnsF25dpW7qHYkVtrvLSUoOU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0320;
x-ms-traffictypediagnostic: MWHPR04MB0320:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0320BC6C8A660461C719A64898980@MWHPR04MB0320.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0320;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0320;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(39380400002)(346002)(376002)(396003)(199004)(189003)(377424004)(14454004)(446003)(5660300001)(2616005)(2501003)(186003)(72206003)(3846002)(558084003)(3660700001)(6116002)(5250100002)(2906002)(11346002)(66066001)(476003)(4326008)(6246003)(486006)(86362001)(316002)(8936002)(36756003)(81156014)(97736004)(8676002)(81166006)(25786009)(76176011)(106356001)(102836004)(6436002)(105586002)(229853002)(6486002)(68736007)(6512007)(53936002)(2900100001)(110136005)(118296001)(26005)(6506007)(3280700002)(305945005)(99286004)(478600001)(59450400001)(54906003)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0320;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Lu3PH3VSFTJjorArlTE9k5b66n/Dhj2Qe9Vj89kVxnbWpQnF07ckNuVV6Wa3gKUYwwU1/9YPn2zhDuW3KaVb2swf4YmKbzn5g0Dff+D3K54ZCShaxXn7u8TvbDs6uCNQsgBHdlnqZTu+oOToaDBc1Li/ioTC2jkNel8qhOrfWWZmbppng/+ck6kCBCU0WaSc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC59134250FBD84B959712B7A65E94A3@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 62fb9c9a-febd-4910-0f03-08d5b6912869
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fb9c9a-febd-4910-0f03-08d5b6912869
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 16:14:50.6030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4AGF6sd012753

On Fri, 2018-05-04 at 19:17 +0200, Paolo Valente wrote:
> When invoked for an I/O request rq, [ ... ]

Tested-by: Bart Van Assche <bart.vanassche@wdc.com>
