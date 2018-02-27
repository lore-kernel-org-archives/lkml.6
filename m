Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeB0DI1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:08:27 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10870 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeB0DIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:08:25 -0500
X-IronPort-AV: E=Sophos;i="5.47,398,1515427200";
   d="scan'208";a="175334758"
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
Thread-Index: AQHTrtem1a0bta5mG0WCj1M6MC3kX6O3kr4A
Date: Tue, 27 Feb 2018 03:08:19 +0000
Message-ID: <1519700898.3120.3.camel@wdc.com>
References: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1519631932-1730-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [76.103.131.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1356;7:DsEZUsySDHatzHSL5i+nLyTbZYpcC1WR+DC+nlaVL2DChEwMArW2ZOzCXITo85jxYcfBgbjCCKIF+e2+HF2AwPvheqIcQBqwDE3GZBXk7a7C6kdmqQBjWoibD1JRi+qg5bEiopYCh+cnqAWiH0HYdPxHAQbRtIVNJyGJyTLI6e/pNnqLWqD3pVl1LIFhmJH34tpJf7+4mlaHJGBhFWHX7KYj5tv686fDNzwgcZlmx5lXlta4SL5wb/XDuGUHDufy;20:IX4DhMwtMXhfzqZXglxm07aIsWIYNG6wvaBhn1mhLyivu/J1q3QbNL9quW1AlHbSIdSv+I4YLjIjGf1rvphy7q8mEeuClw+DY/hUTD+ZM9qLl63bRsA331kLXBKxfqboOc/ehSOZkLsDXI1XSadnPUKPUb0dhgMSPMQ0VB2g14o=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c26db955-e38f-4d51-9b24-08d57d8f5a87
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1356;
x-ms-traffictypediagnostic: CY1PR0401MB1356:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1356D1EB2C46D7FF164044A698C00@CY1PR0401MB1356.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3231220)(944501161)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR0401MB1356;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1356;
x-forefront-prvs: 05961EBAFC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(366004)(376002)(396003)(377424004)(199004)(189003)(3846002)(6116002)(81166006)(81156014)(8676002)(6486002)(2201001)(2501003)(8936002)(6506007)(186003)(6246003)(36756003)(4326008)(102836004)(478600001)(2906002)(59450400001)(77096007)(5660300001)(25786009)(26005)(3660700001)(3280700002)(68736007)(76176011)(2900100001)(53936002)(2950100002)(97736004)(54906003)(110136005)(305945005)(316002)(7736002)(6436002)(105586002)(6512007)(66066001)(72206003)(86362001)(14454004)(99286004)(229853002)(106356001)(103116003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1356;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: YV5AL+S+iGM3xUR92veINLtjN8dotsJZUII/IYl/UHnsUNQ7EaOwwyem/HkLDOzVpddnVtgT23Z0Eux22KJBQ5qeTATdTmWWl7qsu5MrDPdYNrd4DuzqvXqqRTSgC/91zwp5a1mG85qYovnnc189VRAYYXt6RPPtnvLEgtaIAHo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C7A9CF06C4305409D8B56C96812A786@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26db955-e38f-4d51-9b24-08d57d8f5a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2018 03:08:19.4331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1356
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1R38Yi8011933

On Mon, 2018-02-26 at 15:58 +0800, Jianchao Wang wrote:
> In scsi core, __scsi_queue_insert should just put request back on
> the queue and retry using the same command as before. However, for
> blk-mq, scsi_mq_requeue_cmd is employed here which will unprepare
> the request. To align with the semantics of __scsi_queue_insert,
> just use blk_mq_requeue_request with kick_requeue_list == true.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  drivers/scsi/scsi_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index a86df9c..06d8110 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -191,7 +191,7 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>  	 */
>  	cmd->result = 0;
>  	if (q->mq_ops) {
> -		scsi_mq_requeue_cmd(cmd);
> +		blk_mq_requeue_request(cmd->request, true);
>  		return;
>  	}
>  	spin_lock_irqsave(q->queue_lock, flags);

I think this patch will break the code in the aacraid driver that iterates
over sdev->cmd_list because commands are added to and removed from that
list in the prep / unprep code.

Bart.
