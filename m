Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754552AbeDBWJW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 18:09:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60300 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754429AbeDBWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 18:09:20 -0400
X-IronPort-AV: E=Sophos;i="5.48,397,1517846400";
   d="scan'208";a="178124062"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "tj@kernel.org" <tj@kernel.org>
CC: "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Thread-Topic: [PATCH 2/2] blk-mq: Fix request handover from timeout path to
 normal execution
Thread-Index: AQHTyrUNkNkjnUv7yk+FmjLOLTu6JKPt+B6AgAAAm4CAAAzSAIAAAWEAgAACJYA=
Date: Mon, 2 Apr 2018 22:09:18 +0000
Message-ID: <6d6985b8d95317aa5572809f1b987c45e932c5b2.camel@wdc.com>
References: <20180402190053.GC388343@devbig577.frc2.facebook.com>
         <20180402190120.GD388343@devbig577.frc2.facebook.com>
         <b52fa22c-c7fa-5ebd-35cb-527786e6d08e@wdc.com>
         <20180402211047.GF388343@devbig577.frc2.facebook.com>
         <afef8f4812b357deeadc0999f4c85d7b0049b738.camel@wdc.com>
         <20180402220136.GI388343@devbig577.frc2.facebook.com>
In-Reply-To: <20180402220136.GI388343@devbig577.frc2.facebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0623;7:uVLKWHY5YFfICsTxbGGvsDmrH1D2MDnL+vZl9QLNT/FOA9khuhcmydW/soqvhXNBlpid6/2aM0y9XbnosZdP6+AyKxDVPF9GRTiZIr90Er1LHGAXuXXxa+qPoRO/Xa+umNxG4U0VZ/Bb/nhB431fJwXE6w3pbrWRtq8OwARXwoTOgve4NYyf9jV88Zvq7dX2a0o8UYGxCGZnCQUi3QEqzF4hnFt9RZgtS9tZUAEF09MRhmide6/mdV2N7GkOP5EN;20:KQTDfdaE/h+nWiXqQ3YSsl7HulfJHx1J09p0FEEp/UlNjql46Wti6M25QRPupluXtteukdvUx6fJoE63gTxnlENO1He2vEvK0IF/6Mk3Y9qTOkLhlMPhl3FES7kofTfZlpa9mnTVKqxoLZ+oD1gtVf4ZTSLk4I/sp4xbp5sukz8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47033f4a-e14c-4d33-26c2-08d598e66117
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0623;
x-ms-traffictypediagnostic: MWHPR04MB0623:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0623455472BD84664948C7AB98A60@MWHPR04MB0623.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0623;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0623;
x-forefront-prvs: 0630013541
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(377424004)(7736002)(105586002)(186003)(118296001)(26005)(102836004)(6506007)(305945005)(3280700002)(3660700001)(2351001)(316002)(86362001)(106356001)(25786009)(229853002)(6116002)(5660300001)(68736007)(3846002)(2906002)(97736004)(72206003)(81166006)(81156014)(8676002)(76176011)(8936002)(478600001)(53936002)(6916009)(99286004)(2900100001)(66066001)(4326008)(1730700003)(5250100002)(14454004)(6512007)(486005)(476003)(2616005)(446003)(11346002)(59450400001)(5640700003)(2501003)(54906003)(6436002)(6246003)(36756003)(93886005)(6486002)(486005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0623;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: qhxG2SUSn8LqbRHYdT8XLttNi9wKpoMiUOHMUEG9xnmpty40HY2mA4jRL0ETaIO2wSdfvR/bP3Vb7OPJGLp2BO+gB0FFaauFBBYhnxOsNbOuNzRBJxRg6d1kjacUieC2kfARVXKmqkk6Y/GQWwotsREDQIgBVtnwg8yLAcs3yP1bYWnGZba26FDg6L8hGwM7G/zhSEg0CyFYA7R8qjn3WLfGHDqyjs2HDVAYbMrirRM/bx6dx3us536ZHeFjyr2C2zm0Ji22m4bw01xCq90IF4rfERrbD43AUKgSkeHthTZitVbpj9s1IysXkHE0QwI2k8xGr6ZiUCS32PUm6A2iiq8UNCZVBdZamiIFhKYQRhVU5BpxPT08kYzYhI5cqJ+04JK+umwXdOTgtZ9C3AlCGGfiS88/foXP1/MBqD380nw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1620BAA1A268540AFDDDB9F9EE971AA@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47033f4a-e14c-4d33-26c2-08d598e66117
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2018 22:09:18.0506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0623
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w32M9UB1021760

On Mon, 2018-04-02 at 15:01 -0700, tj@kernel.org wrote:
> On Mon, Apr 02, 2018 at 09:56:41PM +0000, Bart Van Assche wrote:
> > This patch increases the time during which .aborted_gstate == .gstate if the
> > timeout is reset. Does that increase the chance that a completion will be missed
> > if the request timeout is reset?
> 
> It sure does, but we're comparing an outright kernel bug vs. an
> inherently opportunistic mechanism being a bit more lossy.  I think
> the answer is pretty clear.

Hello Tejun,

Please elaborate what your long-term goal is for the blk-mq timeout handler.
The legacy block layer suspends request state changes while a timeout is
being processed by holding the request queue lock while requests are being
processed, while processing a timeout and while calling q->rq_timed_out_fn(rq).
Do you think it is possible to make the blk-mq core suspend request processing
while processing a timeout without introducing locking in
blk_mq_complete_request()? If you do not plan to add locking in
blk_mq_complete_request(), do you think it is possible to fix all the races we
discussed in previous e-mails?

Thanks,

Bart.
