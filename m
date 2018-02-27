Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeB0FMn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 00:12:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54784 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeB0FMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 00:12:41 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515427200";
   d="scan'208";a="72382608"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
Thread-Topic: [PATCH] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
Thread-Index: AQHTrtem1a0bta5mG0WCj1M6MC3kX6O3kr4AgAAFuACAAAN9gIAABWEAgAAUJIA=
Date: Tue, 27 Feb 2018 05:12:36 +0000
Message-ID: <1519708355.3120.9.camel@wdc.com>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
         <1519700898.3120.3.camel@wdc.com>
         <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
         <1519702875.3120.7.camel@wdc.com>
         <db9c47e6-d8ea-1e9e-609a-ff1b1db3769c@oracle.com>
In-Reply-To: <db9c47e6-d8ea-1e9e-609a-ff1b1db3769c@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1772;7:MpeI9Bh7CQwVb9sxk8kwvgreGiloiUkPA0mlJNOQgqCKgLTN5VL0T3xXCyTA0iyJZ3SAf69J/hhcln/0UI8US9dP7TShEKcRIrMRI+YMgHdnIS/87lnFFAah1GpLrJUGuD/TpdIiUC2j08jPHH9V0XhKbf5IJYr57UGmWAOXPxbd9Din//HwgAKBLimmfK+tG9MSDrj/1wGu5VhqFUToNVBwEl+19cFeqmQgvTOp/siOu7TNTgg+y2Sqhz4t0Qsr;20:cCgAWH9PIejt5wiHzTCOfK1ujfM/kp4huiiyIn2Fbi1/Yw1/eSYqf/YwFs1h1gCeaKJV2KfWIEPAcQuNpGq7xJj3pn+K2xwxHjD3IBxnhnSpjXSCStghOFaGlRufyJc1j5g/Ig16bX2uxV0Q5X+KQ6rTcd3dU1KG/OSt6apJ1lw=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 93215271-4232-40f8-07d6-08d57da0b778
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1772;
x-ms-traffictypediagnostic: CY1PR0401MB1772:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB17720F36EC60ED756E0388DE98C00@CY1PR0401MB1772.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501198)(52105095)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0401MB1772;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1772;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(377424004)(199004)(189003)(93886005)(2900100001)(99286004)(66066001)(53936002)(77096007)(26005)(186003)(103116003)(68736007)(97736004)(14454004)(6116002)(6346003)(76176011)(3660700001)(3280700002)(72206003)(6246003)(478600001)(6506007)(4326008)(7736002)(105586002)(6436002)(316002)(8676002)(2501003)(2950100002)(6486002)(229853002)(81156014)(81166006)(2201001)(25786009)(8936002)(3846002)(305945005)(110136005)(6512007)(2906002)(36756003)(102836004)(54906003)(59450400001)(5660300001)(86362001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1772;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-microsoft-antispam-message-info: i3q9BFi6JLgUQJPa7f/voVGflCPQyYOqCkmDB7P3Vqh9md0j8P91we8l7YU99SN0y+ZaN7C5X/0GoNB5ZdwAliUfT6wYhU5+ESv2y1W47yW1Q9KLHK36f8WcKWKuNU9ZRf6NnnbgTMIjIW92YbMJrzE1qbHpK/421Z5zuaCfAEI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <32AC73E3167C964C8D99FD26ACC50304@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93215271-4232-40f8-07d6-08d57da0b778
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 05:12:36.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1R5CmcT010205

On Tue, 2018-02-27 at 12:00 +0800, jianchao.wang wrote:
> On the other hand, this patch is to align the actions between blk-mq and block
> legacy code in __scsi_queue_insert.

Hello Jianchao,

Since the legacy SCSI core unpreps an reprepares a request when requeuing it I
think your patch does not align the blk-mq and legacy block layer actions but
instead makes the behavior of the two code paths different.

Thanks,

Bart.
