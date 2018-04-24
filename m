Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDXVR6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:17:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17008 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:17:54 -0400
X-IronPort-AV: E=Sophos;i="5.49,324,1520870400";
   d="scan'208";a="173298346"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "pmenzel+linux-block@molgen.mpg.de"
        <pmenzel+linux-block@molgen.mpg.de>
CC: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Topic: Regression 4.17-rc1: SSD doesn properly resume causing system
 hang (NULL pointer dereference)
Thread-Index: AQHT2/Iaokzl6JZ9+0atRxesfkEEnKQQLgAAgAANxACAACwEAIAAA7cA
Date: Tue, 24 Apr 2018 21:17:50 +0000
Message-ID: <19e19bc6b2fef11faf428fe75447b06e56af9ffd.camel@wdc.com>
References: <59ca6556-11a6-4f77-76e7-d51c7175eb32@molgen.mpg.de>
         <67ffdf0050a04bf3615c3d8a3a90b0c9c2aeb1ad.camel@wdc.com>
         <2cc5f0fb-4caa-9c28-7daa-68993d5cb41a@molgen.mpg.de>
         <14ff1ed06e36a372680872c227b5abe389c753da.camel@wdc.com>
         <a3a7f906-3681-15cc-67af-b96e4ac71b0e@molgen.mpg.de>
         <134955874b401e6764077393c75ab2d4549b940a.camel@wdc.com>
         <6a2162a7-5f48-c107-0b1c-5258089522c5@molgen.mpg.de>
In-Reply-To: <6a2162a7-5f48-c107-0b1c-5258089522c5@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.233.165.212]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1103;7:paGjDQn8u2O2fdu5lehdKOkbSZNmozr0X/QwduZTomOnAfDVdBAX028upt9xMSfgmQXoA3NfRmAjQSOm4D9GI0nK339qiFHagI+svag352gc4Ptn2wA9gIhHvi4D3IGQCZW0GTedG0zAOzrqO7Qxo9KhNwGZ14jRn/OopZBtwnt+bBaF2WwOJBLnE5X5kdqfNojwzfiud7d5EUznInls885SxGAghNO8YqIs/mKM9aIDZkrAwQZLTlykmEK+U2md;20:+rav+QLIluhme+nzPDThKAbjY+Q7VXIkwkMcaNzm4hmucQMThMa2xIzJzfxzUjdHCA9Haw/rWUVcjpkJM254Rb2qJO06gG7CEaoMrZkJDA36UuhI7cVLGTuZKTZco147z6piur28BhFAniNy8i63Y8aGZadHWsRqBFkE3nwQCls=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB1103;
x-ms-traffictypediagnostic: MWHPR04MB1103:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1103815048B98BEFEE642C2398880@MWHPR04MB1103.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB1103;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1103;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(377424004)(6512007)(2616005)(6506007)(6246003)(8936002)(186003)(486006)(476003)(6436002)(97736004)(76176011)(59450400001)(102836004)(3280700002)(93886005)(54906003)(305945005)(53936002)(25786009)(4326008)(446003)(11346002)(316002)(3660700001)(86362001)(99286004)(2900100001)(81156014)(5660300001)(106356001)(478600001)(66066001)(36756003)(118296001)(6486002)(5250100002)(7736002)(26005)(81166006)(8676002)(105586002)(68736007)(229853002)(3846002)(6116002)(2906002)(14454004)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1103;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dZn9/kdIwTKW1kQKZPmvdD62Vt8Liw23Mdma6krd5jzKlhx4hWT23sNXUUFlKlSuVd8aiknv/8eQ88tBVr/AF5+fU1jl24cudkCWQ2elMGef6V1UzF1+JWPT+7XaZJoaaQtZ8LbF7YxdWLinPuGR+VO6tgMfCz4OE5rkoW1YxnGIu4EsjceSMt0sZ03dmtpm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D45FB520D4C1E0478444848C53851307@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7428e385-e47b-47a4-3955-08d5aa28d5bd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7428e385-e47b-47a4-3955-08d5aa28d5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 21:17:50.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3OLI3CE002842

On Tue, 2018-04-24 at 23:04 +0200, Paul Menzel wrote:
> I applied your change, and rebuilt the Linux kernel. Unfortunately, it 
> looks like, it didn’t make a difference.

In that case I don't know what is causing the failure. Can you run a bisect
to determine which commit introduced this regression?

Thanks,

Bart.
