Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeB1HqN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:46:13 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:21554 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751464AbeB1HqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:46:12 -0500
X-IronPort-AV: E=Sophos;i="5.47,404,1515423600";
   d="scan'208";a="272390283"
From: Gaku Inami <gaku.inami.xh@renesas.com>
To: Morten Rasmussen <morten.rasmussen@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Topic: [PATCH 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Index: AQHTpnkM434vxT3DyUyJ59SAlFfPpKO5gRyw
Date: Wed, 28 Feb 2018 07:46:03 +0000
Message-ID: <PS1PR06MB1755EB9FD0AFD1D2E0C85C7DA2C70@PS1PR06MB1755.apcprd06.prod.outlook.com>
References: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
In-Reply-To: <1518711654-23503-1-git-send-email-morten.rasmussen@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gaku.inami.xh@renesas.com;
x-originating-ip: [211.11.155.138]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;PS1PR06MB1274;7:NzLQZfPar2wb683V6/ZpCqtO5G7yJwkCxtz6qDcqLiA8ZJ8fwrYkkiD5pERc4iZbhb09q92YQww1KUft1z1j+WAMcNPcSzd/b/vxIfbX5qEm/pKLtWlZ3DZNBngMk1VO7Op7mxI9fToxaLQZ69zEsjJN4HzuTbLOS6QSYI1eY9Le1eV1GR0le0Go26TXqCurunTp9cMzgYXs9e3abkOVrod2i+JWisgkUcFzP0zE09zdSscNrCKczYnpkmDnAsFD;20:p3nLeek/qOZRQmmHEZhepgWq3hgWkxZyj22Z4IE1lh9igqLVP5dJzOATWnPt0/0vZ5pErPmomAnL86uUMPu36Yo7vYxRWzh6vt6j4bwmUSFPGfKrsasBMMMLBj1rg4qOrZB87v2oYegcCpHJsi2iEpFsRg0CFmGh/kWwJUTPHUE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf9278c4-b2ba-45a4-4abe-08d57e7f5155
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:PS1PR06MB1274;
x-ms-traffictypediagnostic: PS1PR06MB1274:
x-microsoft-antispam-prvs: <PS1PR06MB127463F2C0D3F665B101E034A2C70@PS1PR06MB1274.apcprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501217)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041288)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:PS1PR06MB1274;BCL:0;PCL:0;RULEID:;SRVR:PS1PR06MB1274;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(346002)(39380400002)(199004)(189003)(13464003)(5660300001)(14454004)(2950100002)(3660700001)(68736007)(74316002)(106356001)(6436002)(2900100001)(478600001)(81156014)(8936002)(105586002)(305945005)(81166006)(33656002)(7736002)(8676002)(97736004)(5250100002)(229853002)(2906002)(66066001)(26005)(3846002)(6116002)(99286004)(102836004)(4326008)(110136005)(2501003)(53936002)(76176011)(25786009)(3280700002)(7696005)(186003)(6506007)(6246003)(55016002)(9686003)(86362001)(316002)(2201001)(53546011)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:PS1PR06MB1274;H:PS1PR06MB1755.apcprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 5nHe+UdIbkk4OqVfQ8PbwbTLK3jPhsDJgWIBFNq/EBIF6GW/upJFGbgu+X3/u8CJqHIvp1KRf7uiig7HTdO8HORJBM2ZMEhdu1h1kB57+dnqZvmQxWw1c0lfdcvU+lwx/qkZrbJ7qCarywXSpHOKtDFjxMcFgQQfwSIn9Rq5QnE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9278c4-b2ba-45a4-4abe-08d57e7f5155
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 07:46:03.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR06MB1274
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1S7kK5Z001438

Hi

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Morten Rasmussen
> Sent: Friday, February 16, 2018 1:21 AM
> To: peterz@infradead.org; mingo@redhat.com
> Cc: valentin.schneider@arm.com; dietmar.eggemann@arm.com; vincent.guittot@linaro.org; linux-kernel@vger.kernel.org;
> Morten Rasmussen <morten.rasmussen@arm.com>
> Subject: [PATCH 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric capacity systems
> 
<snip>
> 
> The patches have been tested on:
>    1. Arm Juno (r0): 2+4 Cortex A57/A53
>    2. Hikey960: 4+4 Cortex A73/A53
> 
> Test case:
> Big cpus are always kept busy. Pin a shorter running sysbench tasks to
> big cpus, while creating a longer running set of unpinned sysbench
> tasks.

Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

I tested as same in other SoC. It looks fine.

The patches have been tested on:
   3. Renesas R-Car H3 : 4+4 Cortex A57/A53

Results:
Single runs with completion time of each task
R-Car H3 (tip)
    total time:                          0.9415s
    total time:                          0.9582s
    total time:                          1.3275s
    total time:                          1.6752s

R-Car H3 (misfit)
    total time:                          0.9312s
    total time:                          0.9429s
    total time:                          0.9525s
    total time:                          0.9660s

10 run summary (tracking longest running task for each run)
	R-Car H3
	avg	max
tip     1.6752  1.6753
misfit  0.9890  1.0204

Regards,
Inami
