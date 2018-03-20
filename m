Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCTFaI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 01:30:08 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:26217 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751153AbeCTFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 01:30:04 -0400
X-IronPort-AV: E=Sophos;i="5.48,333,1517842800";
   d="scan'208";a="275678194"
From: Gaku Inami <gaku.inami.xh@renesas.com>
To: Morten Rasmussen <morten.rasmussen@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
CC: "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCHv2 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Topic: [PATCHv2 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
Thread-Index: AQHTvGyN/bFV5dbR5kK0F1GSuG+WhqPYnpLA
Date: Tue, 20 Mar 2018 05:30:00 +0000
Message-ID: <OSBPR01MB1800210FC368705EAADA27C4A2AB0@OSBPR01MB1800.jpnprd01.prod.outlook.com>
References: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
In-Reply-To: <1521125224-15434-1-git-send-email-morten.rasmussen@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gaku.inami.xh@renesas.com;
x-originating-ip: [211.11.155.139]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;OSBPR01MB1990;20:aPUFR7TqfrBSrFtxJlNBYzQ/smaePXuZwm3WOgIUF7B3qaFmU8uhfpNClnKkiOx8onrbMvX1A3rVz4tMEWP8aAxNB22S6y26N07uLYJKEmxkAtxIoULh1mG6kks4itJ9XiSXMBqG56hIgI6Q1wyuKzQKuzMQbnajMf2c16aKHKI=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 376f1e7c-530d-478c-f26f-08d58e23a066
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:OSBPR01MB1990;
x-ms-traffictypediagnostic: OSBPR01MB1990:
x-microsoft-antispam-prvs: <OSBPR01MB19900E82AA405BF7405BDF49A2AB0@OSBPR01MB1990.jpnprd01.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(944501307)(52105095)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:OSBPR01MB1990;BCL:0;PCL:0;RULEID:;SRVR:OSBPR01MB1990;
x-forefront-prvs: 061725F016
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(39860400002)(396003)(376002)(13464003)(189003)(199004)(8676002)(81156014)(2950100002)(81166006)(316002)(68736007)(5250100002)(2900100001)(2906002)(3280700002)(8936002)(106356001)(105586002)(25786009)(14454004)(6506007)(33656002)(3846002)(54906003)(2501003)(478600001)(3660700001)(66066001)(6116002)(110136005)(53546011)(97736004)(6246003)(2201001)(76176011)(7696005)(9686003)(74316002)(55016002)(7736002)(26005)(4326008)(305945005)(186003)(99286004)(5660300001)(229853002)(102836004)(86362001)(53936002)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:OSBPR01MB1990;H:OSBPR01MB1800.jpnprd01.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: myjjZYg1SvnqSQDj4cIWUXV3VaMCzqJnXCD0WTyGiZwwbvHVySjYogiIQ3FV7Z0XvKmq8Fno6i3qrvPmK+HZbxdReOARcUf9gw2ao0S35/QCVsLHU7kc1EGgWSwXhdexZZJpygvOZ+IxzuIXETkYXKHOT28sAUexnAU9wPzDpIMrRrMmjjhoDFe82yeSyegbT/DL4UsPexWSwb1dbT/x6C9hQhyY/aKsmTDrLzn1nDpfzKPZ9F+gJXckq9Zya6D7GpPIhlJfHr69wJfjrzyckzc7IRP5Pg35G5c6ze7bLD4yAxgU7Cc1U5kpNKX/3bMwby3gh7jtTP2qMQY5lxd+wA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376f1e7c-530d-478c-f26f-08d58e23a066
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2018 05:30:00.6706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1990
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2K5UFfO021841

Hi

> -----Original Message-----
> From: Morten Rasmussen [mailto:morten.rasmussen@arm.com]
> Sent: Thursday, March 15, 2018 11:47 PM
> To: peterz@infradead.org; mingo@redhat.com
> Cc: valentin.schneider@arm.com; dietmar.eggemann@arm.com; vincent.guittot@linaro.org; Gaku Inami
> <gaku.inami.xh@renesas.com>; linux-kernel@vger.kernel.org; Morten Rasmussen <morten.rasmussen@arm.com>
> Subject: [PATCHv2 0/7] sched/fair: Migrate 'misfit' tasks on asymmetric capacity systems
[snip]
> 
> The patches have been tested on:
>    1. Arm Juno (r0): 2+4 Cortex A57/A53
>    2. Hikey960: 4+4 Cortex A73/A53
> 

I have tested this on our R-Car again and it works well. In addition,
I confirmed that this patch-set also brings performance improvement to
other benchmarks(e.g. memory load latency in LMbench). You can add:

Tested-by: Gaku Inami <gaku.inami.xh@renesas.com>

The patches have been tested on:
   3. Renesas R-Car H3 : 4+4 Cortex A57/A53

Results:
Single runs with completion time of each task
R-Car H3 (tip)
    total time:                          0.9435s
    total time:                          0.9952s
    total time:                          1.3511s
    total time:                          1.6747s

R-Car H3 (misfit)
    total time:                          0.9387s
    total time:                          0.9280s
    total time:                          0.9616s
    total time:                          0.9934s

10 run summary (tracking longest running task for each run)
	R-Car H3
	avg	max
tip     1.6737  1.6758
misfit  0.9980  1.0409

Regards,
Inami

[snip]
