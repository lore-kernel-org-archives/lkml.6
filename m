Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeDXRbv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:31:51 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60304 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDXRbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:31:45 -0400
X-IronPort-AV: E=Sophos;i="5.49,324,1520870400";
   d="scan'208";a="77315885"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "pmenzel+linux-block@molgen.mpg.de"
        <pmenzel+linux-block@molgen.mpg.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Topic: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Index: AQHT2/Iaokzl6JZ9+0atRxesfkEEnA==
Date: Tue, 24 Apr 2018 17:31:40 +0000
Message-ID: <14ff1ed06e36a372680872c227b5abe389c753da.camel@wdc.com>
References: <59ca6556-11a6-4f77-76e7-d51c7175eb32@molgen.mpg.de>
         <67ffdf0050a04bf3615c3d8a3a90b0c9c2aeb1ad.camel@wdc.com>
         <2cc5f0fb-4caa-9c28-7daa-68993d5cb41a@molgen.mpg.de>
In-Reply-To: <2cc5f0fb-4caa-9c28-7daa-68993d5cb41a@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.233.165.212]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0577;7:qfWhtJCdPDjZVVT4hGQgP1a3i35o8rysup3brrm7oVgxoc4IosdKGHkSapMonbdn6oNGrknZ3fF8BmeD1bm5/nAriaxFDpaTETZPh+R64U6tX2w6ixX+PsuueWe/cDaU9c9uPnvOyESB/gYuOBfACHLg48dCA42lk3JUT7WUz1MxNWJtk/KHnK++qCmOPw1UZtJqq/4L8pLZxXa9CTW9v1xEqWJBd8EjmfDJSnIilrlma/rn4ZtbfnqxNKCn8lBk;20:cIcXxRRSEnwOrSjehP0NczmpMb3BcQlO2Bmz2Yck5ntpJgC9erx6IyFoZbqszk5ftA7kOlwYSahVWSQBudTu5Ucpg8koyDRuL9vmGYMsifjsUBCA/uK/nW0ZMZFlhyoAfpXDAIvx8CkyC45hZoYImuQ8FuZTw6BPbgEoEloS1Vw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0577;
x-ms-traffictypediagnostic: MWHPR04MB0577:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB05777EE55343F66C27C15B7398880@MWHPR04MB0577.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR04MB0577;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0577;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(377424004)(199004)(189003)(72206003)(6116002)(86362001)(4326008)(3846002)(305945005)(316002)(99286004)(2616005)(14454004)(11346002)(3280700002)(5890100001)(5660300001)(486006)(36756003)(476003)(105586002)(25786009)(186003)(2501003)(2906002)(118296001)(446003)(5250100002)(7736002)(2900100001)(26005)(6486002)(3660700001)(68736007)(54906003)(97736004)(81166006)(81156014)(229853002)(8676002)(102836004)(478600001)(59450400001)(106356001)(110136005)(6506007)(53936002)(6512007)(6246003)(76176011)(8936002)(66066001)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0577;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0oYPJg/+ffEBTLnGn9nX6PJ85tljmnIkTF1NWET/puDiu02/21Q/dm6pGh8D70imGZ3QDS4uq80j4REo520nl+Y2qKiQBJ5JCjTYp5TzscaKRi8UwVsAIt0asyTuNe75PYsJNqr+UPkFKjpLIXiNqQgL4ad1pz99XKiv0dMgTySCW2BiDSXzzOwGhbq22SL/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E675AA673B99046A1D0CD4F22AD66AC@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: ea643d1d-148f-43a6-b4b2-08d5aa093da5
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea643d1d-148f-43a6-b4b2-08d5aa093da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 17:31:40.7084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0577
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3OHVvrL020113

On Tue, 2018-04-24 at 19:10 +0200, Paul Menzel wrote:
> Please find the configuration file attached. The log only has 
> `initcall_debug no_console_suspend` added.

What I was looking for in the .config is the following:
CONFIG_SCSI_MQ_DEFAULT=y

Can you also provide the disassembly output for blk_set_runtime_active,
e.g. by loading vmlinux into gdb and by running the command "disas
blk_set_runtime_active"?

Thanks,

Bart.
