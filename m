Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeB0RSj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 12:18:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13757 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeB0RSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 12:18:37 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515427200";
   d="scan'208";a="72276476"
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
Thread-Index: AQHTrtem1a0bta5mG0WCj1M6MC3kX6O3kr4AgAAFuACAAAN9gIAABWEAgAAUJICAAAC5AIAAxtqAgAADQoA=
Date: Tue, 27 Feb 2018 17:18:35 +0000
Message-ID: <1519751913.23791.6.camel@wdc.com>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
         <1519700898.3120.3.camel@wdc.com>
         <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
         <1519702875.3120.7.camel@wdc.com>
         <db9c47e6-d8ea-1e9e-609a-ff1b1db3769c@oracle.com>
         <1519708355.3120.9.camel@wdc.com>
         <478f40f1-d86c-ee5f-daaf-6332b67fe721@oracle.com>
         <1519751213.23791.3.camel@wdc.com>
In-Reply-To: <1519751213.23791.3.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB0970;20:LGuTXK1PhBuATuWMpdPdN6hock90HNOP5vDV10WfCrtxXBSOnrPoq0uAmYEoR+zJKjw6nVIlr/7A9qeg/rWvfFnfDuu77z3EaskEzwU3hV55j02JqFBQLcYOAqw99cL0uW3fax8uyMAB99r2S70+wzd1oC1V2q1syEFQgGfoBGU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed83f350-555b-4ba0-7b9a-08d57e062233
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB0970;
x-ms-traffictypediagnostic: CY1PR0401MB0970:
wdcipoutbound: EOP-TRUE
x-exchange-antispam-report-cfa: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY1PR0401MB0970;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB0970;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(377424004)(3846002)(3280700002)(4326008)(305945005)(7736002)(25786009)(103116003)(105586002)(2201001)(106356001)(8676002)(6486002)(6512007)(8936002)(81156014)(6436002)(86362001)(2900100001)(6116002)(6246003)(68736007)(26005)(36756003)(186003)(99286004)(77096007)(229853002)(6506007)(59450400001)(5660300001)(66066001)(102836004)(2950100002)(97736004)(76176011)(3660700001)(2501003)(110136005)(72206003)(54906003)(93886005)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB0970;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Content-Type: text/plain; charset="utf-8"
Content-ID: <047FDE75BF2B9547912CBFBD57963C48@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed83f350-555b-4ba0-7b9a-08d57e062233
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 17:18:35.0558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB0970
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1RHIhOW025015

On Tue, 2018-02-27 at 17:06 +0000, Bart Van Assche wrote:
> On Tue, 2018-02-27 at 13:15 +0800, jianchao.wang wrote:
> > Can you share more details about this ? 
> 
> After having had another look, I think your patch is fine.

(replying to my own e-mail)

What I think is fine in your patch is that it skips the unprep and reprep
when requeueing. However, there is a put_device(&sdev->sdev_gendev) call
in scsi_mq_requeue_cmd() and your patch causes that put_device() call to
be skipped when requeueing. An explanation is needed in the commit message
why you think that removing that put_device() call is fine.

Bart.
