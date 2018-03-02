Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936532AbeCBQbi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:31:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:52209 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932746AbeCBQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:31:36 -0500
X-IronPort-AV: E=Sophos;i="5.47,412,1515427200";
   d="scan'208";a="175796796"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V3] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
Thread-Topic: [PATCH V3] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
Thread-Index: AQHTsdburqDNChC1OkidHui4mYfcHqO9JCmA
Date: Fri, 2 Mar 2018 16:31:33 +0000
Message-ID: <1520008291.2855.7.camel@wdc.com>
References: <1519961474-15236-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1519961474-15236-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB3725;7:rkureimMoCIdytqX9/b0zMMiuxgCFVD6J7zDQTcqxpKgga4WuqqKOaT99eA3+P4mQYuMetUbeRKF9eWvr8DNyGMzR7Ka2fiwqYmuZl59/fn4y6VKOKNqk2xId4pU/v8CtqZr7EXls7sAEOsvtaHaxz/6nj4oyMrvuswEC1FxpX4O8lSSn7JGqIEuLMlq4bMekdFxMT7pO7z2phae68UjO5RabLY08nRmazelhQ1YPtUzK1Fvh39c5phytRB5pQyY;20:0VDUiWhiQ3rqaJOduGlKcuNEfHfzOPWgMjiiz+TPafPNm0+9YZaZbdi9m7MJklvn13ER9zEm32sZL1VW0QRDxyxD4BWcc+DFwQchX9QoljjRLy++ZVMDNWXTDYSPNWDaUnf0T+0Uvo1fVZ4VbP0db27FMn+lIkUP2Md5GbSuOTU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fcf6d42-4b97-4f6e-509a-08d5805b0f8f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:MWHPR04MB3725;
x-ms-traffictypediagnostic: MWHPR04MB3725:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB3725F1BD4EC984040D5743A298C50@MWHPR04MB3725.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501241)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB3725;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB3725;
x-forefront-prvs: 05991796DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(377424004)(6512007)(2906002)(6486002)(6436002)(5660300001)(81156014)(81166006)(8676002)(36756003)(3280700002)(8936002)(53936002)(106356001)(110136005)(54906003)(14454004)(6246003)(68736007)(305945005)(2900100001)(105586002)(316002)(7736002)(6116002)(3846002)(229853002)(2950100002)(86362001)(99286004)(2501003)(26005)(72206003)(6506007)(66066001)(478600001)(186003)(3660700001)(102836004)(59450400001)(4326008)(97736004)(103116003)(25786009)(2201001)(76176011)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB3725;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: LXf/dVMIGFXp/jmuGDAVGVAT6iclXPRTIVWBDzVzF5jIPk8kNV9TDmbFKRLFJ9jS+m+1WrLbWSwhrdtSOAq0dK81uFAWJCVQnvNpMFPJS1AXRjb7SWyqH6g+dbBiW3UacCm9LEhwy81KktAWXlULi73f7IWDA2cXHEoRY6rFegc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <34E3BA2ED5E63C429BC5BF0DC23876A6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf6d42-4b97-4f6e-509a-08d5805b0f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 16:31:33.2035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB3725
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w22GVkqV003409

On Fri, 2018-03-02 at 11:31 +0800, Jianchao Wang wrote:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index a86df9c..d2f1838 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -191,7 +191,13 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>  	 */
>  	cmd->result = 0;
>  	if (q->mq_ops) {
> -		scsi_mq_requeue_cmd(cmd);
> +		/*
> +		 * scsi_device.sdev_gendev will be get every time in .get_budget and
> +		 * be put in scsi_end_request. Hence we need to put the reference
> +		 * here when we decide to requeue request.
> +		 */
> +		blk_mq_requeue_request(cmd->request, true);
> +		put_device(&device->sdev_gendev);
>  		return;
>  	}
>  	spin_lock_irqsave(q->queue_lock, flags);

Please consider to change the new comment into something like the following:
"Before a SCSI command is dispatched, get_device(&sdev->sdev_gendev) is called
and the host, target and device busy counters are increased. Since requeuing a
request causes these actions to be repeated and since scsi_device_unbusy() has
already been called, put_device(&device->sdev_gendev) must still be called. Call
put_device() after blk_mq_requeue_request() to avoid that removal of the SCSI
device can start before requeueing has happened."

Thanks,

Bart.
