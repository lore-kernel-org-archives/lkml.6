Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeETXku (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 19:40:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8776 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeETXks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 19:40:48 -0400
X-IronPort-AV: E=Sophos;i="5.49,423,1520870400";
   d="scan'208";a="80093973"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
CC: "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Topic: [PATCH 00/10] Misc block layer patches for bcachefs
Thread-Index: AQHT5zXcA2yvhxQJyUaLKhajN8kmNKQ0dDMAgADMbQCAAGY2AIADm3GAgAAAdgCAAANfAIAAASwAgAAM54CAAAVVAA==
Date: Sun, 20 May 2018 23:40:45 +0000
Message-ID: <238bacfbc43245159c1586189a436efbb069306b.camel@wdc.com>
References: <20180509013358.16399-1-kent.overstreet@gmail.com>
         <a26feed52ec6ed371b3d3b0567e31d1ff4fc31cb.camel@wdc.com>
         <20180518090636.GA14738@kmo-pixel>
         <8f62d8f870c6b66e90d3e7f57acee481acff57f5.camel@wdc.com>
         <20180520221733.GA11495@kmo-pixel>
         <bb4fd32d0baa6554615a7ec3b45cc2b89424328e.camel@wdc.com>
         <20180520223116.GB11495@kmo-pixel>
         <b0aa2a8737b2d826fea58dc0bc113ddce50f018a.camel@wdc.com>
         <20180520232139.GE11495@kmo-pixel>
In-Reply-To: <20180520232139.GE11495@kmo-pixel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [67.180.189.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0688;7:fj9eZRnZesYUerJGSkKqfyzNPNDOCTMg3938CSopu054EiJkGdUsTztvWAoJJQ6gzvhyQtN+bFjXXJVeAqQVVyT6nnEsxFdI8TPnLdk9FqlabT6jx3FPD6SmMiq2u/8ddNWOXoyQ5iJKAQSs7m7vFymYi83klrdUBCUxIdMUd1tQbcugIXEmQzoIW7YasfeVYsjLW4GMyPLu4fCHbKf0crF/zfAly4022tZh6NnboeVo6M8K2zxa2pG2wtPwtSWa;20:xqz4CaPMKxzqVZ7y6VmEVRKNxQZLvRhAkfhv4Vh8CRI+uEyq/Qq76iU/bd0aHqQ6kJVclWZ+rshmYxEuAYQL+phnnLh9CN9T1ODmRUXho1/FuySlhMlLQ951YtLmoyF2FKW+uPZIwm5izPCcLJhn9d+n8T05Svkuj+wRxkJPNJo=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0688;
x-ms-traffictypediagnostic: MWHPR04MB0688:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB06887A3D87B54779116B119498960@MWHPR04MB0688.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:MWHPR04MB0688;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0688;
x-forefront-prvs: 06780E24F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39380400002)(396003)(39860400002)(377424004)(199004)(189003)(1361003)(446003)(81156014)(2906002)(81166006)(476003)(2616005)(6506007)(8676002)(102836004)(26005)(478600001)(76176011)(186003)(2900100001)(7736002)(97736004)(14454004)(72206003)(3280700002)(3660700001)(54906003)(305945005)(93886005)(316002)(118296001)(4326008)(8936002)(486006)(36756003)(11346002)(6512007)(6486002)(53936002)(6436002)(3846002)(6116002)(5640700003)(5660300001)(2351001)(6916009)(99286004)(5250100002)(2501003)(6246003)(66066001)(25786009)(86362001)(229853002)(106356001)(68736007)(105586002)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0688;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: QiBVJfjJGIPSgrZhwxKgmG6su5olnWl7B5vVMn4Qwy2jm9bXxlnQKO3FXWjajRrLLLBBHcaRFs+qOktCUF0lHSaFw5pefQW5m9t8t9o7NeXxlw8OhyoGh1/YmpekJYUVlvm2ZaBNc9oUJ14zNBdUGPRcwS6xGlSpVkEu+KutF+bNpZQjcKDYDmOebsn3N5ZW
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9BBC200AF993E04D9BC9734E2B816F86@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4c6b52e1-4d53-4843-d7ec-08d5beab1bb8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c6b52e1-4d53-4843-d7ec-08d5beab1bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2018 23:40:45.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0688
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4KNevpU019996

On Sun, 2018-05-20 at 19:21 -0400, Kent Overstreet wrote:
> I really have better things to do than debug someone else's tests...
> [ ... ]
> ../run_tests: line 65: cd: /lib/modules/4.16.0+/kernel/block: No such file or directory

Kernel v4.16 is too old to run these tests. The srp-test script needs the
following commit that went upstream in kernel v4.17-rc1:

63cf1a902c9d ("IB/srpt: Add RDMA/CM support")

Bart.
