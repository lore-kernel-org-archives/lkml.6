Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbeB0Dlf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:41:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61742 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeB0Dlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:41:32 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515427200";
   d="scan'208";a="175337228"
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
Thread-Index: AQHTrtem1a0bta5mG0WCj1M6MC3kX6O3kr4AgAAFuACAAAN9gA==
Date: Tue, 27 Feb 2018 03:41:15 +0000
Message-ID: <1519702875.3120.7.camel@wdc.com>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
         <1519700898.3120.3.camel@wdc.com>
         <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
In-Reply-To: <3b6ca136-ba62-3eca-6eca-d191490b7754@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1630;20:KrlLUCxf9IE1LVvL6yh3ecWWXIOVJA9KqrqOP2wO33t19B4bqjd9bqiPW1+IY39egbjvf2kLTRKL4GpquEA3/izFvRitVSFrYl11XNS7asY+IfvWnPR6HdwLjb4l/zNc61T9RsQ2SUrgPNaA7NL7iAsrj/9pxJ6eD7Dw0zIxiDk=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3cbaf8a6-6993-474d-de21-08d57d93f4a1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1630;
x-ms-traffictypediagnostic: CY1PR0401MB1630:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1630D8BBB977EE6798DDE0A998C00@CY1PR0401MB1630.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501198)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0401MB1630;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1630;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(346002)(366004)(396003)(189003)(199004)(377424004)(106356001)(99286004)(36756003)(66066001)(14454004)(2501003)(2950100002)(72206003)(229853002)(7736002)(8676002)(81156014)(316002)(8936002)(26005)(81166006)(5660300001)(76176011)(186003)(6506007)(59450400001)(102836004)(77096007)(6346003)(6116002)(2906002)(6512007)(3846002)(3280700002)(53936002)(25786009)(2900100001)(4326008)(110136005)(105586002)(54906003)(6436002)(6486002)(6246003)(3660700001)(478600001)(68736007)(2201001)(103116003)(86362001)(97736004)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1630;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-microsoft-antispam-message-info: cXV1oxABi6avk+TbcqEq8/qfA7ntCSkbQGm44Qj4QENOVG7u+tgQx0IbmDepQYJdleWt2oTjkNpMFKQALYdPtvb1RpKxIOevfcb8D8AFL3HZ8dBKJsFc9iKxXQNLD8hTvetZ8KfDXI7FYHaqGY7y4uMGbVEoXgXX5phOmY+mEBI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <322360C2DDBB3B4AA766D21A646B2FDB@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbaf8a6-6993-474d-de21-08d57d93f4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 03:41:16.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1630
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1R3fgKx016170

On Tue, 2018-02-27 at 11:28 +0800, jianchao.wang wrote:
> If that is true, what if aacraid driver uses block legacy instead of blk-mq ?
> w/ blk-mq disabled, __scsi_queue_insert just requeue the request with blk_requeue_request.
> 
> __scsi_queue_insert
> ...
> 	if (q->mq_ops) {
> 		scsi_mq_requeue_cmd(cmd);
> 		return;
> 	}
> 	spin_lock_irqsave(q->queue_lock, flags);
> 	blk_requeue_request(q, cmd->request);
> 	kblockd_schedule_work(&device->requeue_work);
> 	spin_unlock_irqrestore(q->queue_lock, flags);
> ...
> 
> no prep/unprep code there for block legacy code.

Hello Jianchao,

For the legacy block layer preparing and unpreparing a request happens from
inside the block layer core. Please have a look at block/blk-core.c and the
code in that file that handles the request flag RQF_DONTPREP.

Thanks,

Bart.
