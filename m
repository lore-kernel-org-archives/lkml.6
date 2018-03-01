Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163014AbeCAXLJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:11:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30846 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162854AbeCAXLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:11:05 -0500
X-IronPort-AV: E=Sophos;i="5.47,409,1515427200";
   d="scan'208";a="72758956"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "hch@lst.de" <hch@lst.de>,
        "opensource.ganesh@gmail.com" <opensource.ganesh@gmail.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi_lib: increase {host|target|device}_busy count after
 dispatch cmd
Thread-Topic: [PATCH] scsi_lib: increase {host|target|device}_busy count after
 dispatch cmd
Thread-Index: AQHS3d92zLNWsDeNvE6P9uZ5cIsMfqO9qWKA
Date: Thu, 1 Mar 2018 23:11:02 +0000
Message-ID: <1519945861.2675.9.camel@sandisk.com>
References: <1496655478-4039-1-git-send-email-opensource.ganesh@gmail.com>
In-Reply-To: <1496655478-4039-1-git-send-email-opensource.ganesh@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1467;20:XJ/Fa/juDfkC6bg8z3TgEqYl1ZFnpQEc59qIVnssIonzfJOvZAMsErAXiENaM8Veif10uzZkwDQbfE7k58ELGJljEqbGrlVBJZSwRyvHX0s+GL+Wrynm/yKw2+cCnXszQvS4DY2+B5h3J7+CUEhGEtHZNh4BqM22qrRwP+2yB9k=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 58f3a5fe-35ad-4728-10d2-08d57fc9b429
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1467;
x-ms-traffictypediagnostic: CY1PR0401MB1467:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB146788685321BE657C87B37A98C60@CY1PR0401MB1467.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501224)(52105095)(3002001)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0401MB1467;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1467;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(366004)(39860400002)(346002)(377424004)(199004)(51444003)(189003)(6512007)(6486002)(103116003)(72206003)(14454004)(6436002)(53936002)(66066001)(25786009)(59450400001)(106356001)(8676002)(36756003)(68736007)(2906002)(229853002)(77096007)(7736002)(33896004)(3280700002)(305945005)(478600001)(8936002)(4326008)(26005)(54906003)(39060400002)(6506007)(9686003)(81166006)(110136005)(6246003)(186003)(81156014)(2201001)(5660300001)(316002)(86362001)(2950100002)(6116002)(102836004)(105586002)(3660700001)(97736004)(3846002)(99286004)(76176011)(2501003)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1467;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 1G11MEq7lKaY8gXb5AIxqUQV8FZOz0oL9ZKFEVOu6mdWrfWOfkhDuWUpje5cfEGMsi2TTbKBHY+xXN+vzTFVuLhH3qKXEF3VmZTl3VutgwvXUqRa42vn0teW0IgOe1Y6bnRgGxU9uC1q5cX9Tndq/xVvm61RSryThNUAj2SSGts=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C456706F68F6274AA9DDEBEA8B6893AE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f3a5fe-35ad-4728-10d2-08d57fc9b429
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 23:11:02.9131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1467
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21NBajQ023840

On Mon, 2017-06-05 at 17:37 +0800, Ganesh Mahendran wrote:
> In android system, when there are lots of threads running. Thread A
> holding *host_busy* count is easily to be preempted, and if at the
> same time, thread B set *host_blocked*, then all other threads will
> be io blocked.

Hello Ganesh,

Have you considered to insert preempt_disable() and preempt_enable() calls
where necessary to achieve the same effect? I think that would result in a
much less intrusive patch.

Thanks,

Bart.
