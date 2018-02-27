Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeB0RHB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:07:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59767 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbeB0RG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:06:57 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515427200";
   d="scan'208";a="168867517"
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
Thread-Index: AQHTrtem1a0bta5mG0WCj1M6MC3kX6O3kr4AgAAFuACAAAN9gIAABWEAgAAUJICAAAC5AIAAxtqA
Date: Tue, 27 Feb 2018 17:06:54 +0000
Message-ID: <1519751213.23791.3.camel@wdc.com>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
         <1519700898.3120.3.camel@wdc.com>
         <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
         <1519702875.3120.7.camel@wdc.com>
         <db9c47e6-d8ea-1e9e-609a-ff1b1db3769c@oracle.com>
         <1519708355.3120.9.camel@wdc.com>
         <478f40f1-d86c-ee5f-daaf-6332b67fe721@oracle.com>
In-Reply-To: <478f40f1-d86c-ee5f-daaf-6332b67fe721@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1708;7:1iSYzW2yZ+f3c1/9emg2qzufhZYgRxYolInjKWMOeGb/VnUq0h0RgVvWkxiG77cTkODJ4sdDvFQSaXgxxLsftHReQ5nRPSUJcGk3eHGG4k4MX/de0PDUjXvOewZguyyTTBGPTQ76/wnylDRpWpp1JscmZJZFfU4mDGm0Lu0DD4gYHRNKxzMoNnOazZLlYgbVqF5GcVXEHih2XGIX1EdbEyYMU+mhWMtKAOQILhld2bGMv9Db+wtR58iLNunoYHRQ;20:ITuv6wUqWJd8co2JNABkZ/YgNul9inYewu6GI7OWi0IpxT0rXvsQwBAi3u5c9o80PPQVRcfaLxTn83mejOkllf+wrwe/7ImeRXfQdwaopf9NU7+pYs7wzNXTaqlQH9AtgBIo+9GWImxNns+DCdO/dtcOcqU+LQDTcX+4CeUL27k=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9debef9a-c7d3-4ff1-ed66-08d57e0480e5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1708;
x-ms-traffictypediagnostic: CY1PR0401MB1708:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1708331F3BD6A9246CD692F998C00@CY1PR0401MB1708.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(3002001)(6055026)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR0401MB1708;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1708;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(189003)(377424004)(199004)(68736007)(558084003)(6512007)(6436002)(2950100002)(54906003)(229853002)(3280700002)(2201001)(102836004)(77096007)(26005)(186003)(110136005)(97736004)(6246003)(53936002)(2900100001)(66066001)(2906002)(99286004)(14454004)(7736002)(6116002)(86362001)(3846002)(316002)(6486002)(6506007)(5660300001)(81166006)(72206003)(103116003)(8936002)(93886005)(105586002)(3660700001)(4326008)(81156014)(25786009)(8676002)(305945005)(36756003)(106356001)(478600001)(2501003)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1708;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: i8z5eOt6WmKh2VGsYKoW6pVWBVZQeqYOpFLSdvnnLYEBPaBa+UMuc0cJa1CNNnhERX6tsyayRPcVnTrfr31+K1rDjTErLXxL2/JR/9OiYagcsCPInB/TNIfbZIcU1XuYdjVZhMWwbnlPrL9YYd58F/w7Mj/tuzM9KbENwlEvQiI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <32D1BF44E365E74FBA4F004FE9D79AB0@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9debef9a-c7d3-4ff1-ed66-08d57e0480e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 17:06:54.9220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1708
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RH75es021428

On Tue, 2018-02-27 at 13:15 +0800, jianchao.wang wrote:
> Can you share more details about this ? 

After having had another look, I think your patch is fine. So if you want you
can add:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
