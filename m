Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033506AbeCARnv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:43:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24226 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033270AbeCARnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:43:49 -0500
X-IronPort-AV: E=Sophos;i="5.47,408,1515427200";
   d="scan'208";a="73249097"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
Thread-Topic: [PATCH V2] scsi: core: use blk_mq_requeue_request in
 __scsi_queue_insert
Thread-Index: AQHTsHHVjOEcXDmyrUm+gBCv0tqSDKO6GPCAgACHmACAAQhFgA==
Date: Thu, 1 Mar 2018 17:43:46 +0000
Message-ID: <1519926225.2675.6.camel@wdc.com>
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
         <1519840355.2777.8.camel@wdc.com>
         <624cedc6-9658-7b76-9c63-61c30fdfe6be@oracle.com>
In-Reply-To: <624cedc6-9658-7b76-9c63-61c30fdfe6be@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1536;7:3LC3C5bq1vjp7E99T72lLNqw9SwsdGkbRFuUVvW3i1cNEbhQI7ib7TF/RyqJzYikBde8VUVLhSGGHTLHaJM1AHKc42Rr1D1Tq4RljrB4exS6EPYlrcvJdrZZhpcoGU/jE1LXBehH8+KYMEA5tsvKbI9ZOHYmz2h0aWzKyPy6235kO0QF4Tgs5ncb2XLHilhkn+Q1CRWyxIQmXILFBDPq1CU1fT6GdG3RUpax7pJoLM6LTVARU4tbyo8ohPojDtcm;20:FXRKKEu4gGs6OCkZ7lBcQzYKOydzvqnSrsV+Aod5uQQ6Ovq7uRZ7nyVZbefdKhfjsqtJZbUqNXPvDPAV/BVUFovuPiXVorqXAr37VVZGPng0HzB7SD76Y6xDqgCeDQCkOl4Jsn8nODX7C57Duxa2mYrm5bHQhs4ACDzEH45JcNE=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ee0a3a1-13cd-4048-9d1a-08d57f9bfc2b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1536;
x-ms-traffictypediagnostic: CY1PR0401MB1536:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB1536730E7B99762E3587579E98C60@CY1PR0401MB1536.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501224)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR0401MB1536;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1536;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(346002)(396003)(366004)(57704003)(189003)(199004)(377424004)(52314003)(2950100002)(2201001)(5660300001)(86362001)(575784001)(97736004)(103116003)(4326008)(14454004)(110136005)(54906003)(7736002)(305945005)(106356001)(105586002)(6512007)(316002)(99286004)(3660700001)(3280700002)(6436002)(66066001)(6486002)(6246003)(3846002)(81166006)(81156014)(2906002)(76176011)(68736007)(2900100001)(478600001)(2501003)(8936002)(77096007)(186003)(26005)(8676002)(53546011)(6506007)(59450400001)(229853002)(36756003)(6116002)(102836004)(25786009)(72206003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1536;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: wRiEfv0yYliO6I3xIilY8XB3rIi2tJ6IxUGHrX+KalaWU+wFYZVh2xNfrZPhJVYhuvjr3tawz/CVt6kneluEfbbDjVUME+y561bp/Owhl3N9P1R9/Bd1xYmSJqbpd6iKGcGuQruDXxNRE3VWX4GqoKsxXazG5xYYS1lxlgmOvdE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <F357BBC82A598C48B98BC46D935190DE@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee0a3a1-13cd-4048-9d1a-08d57f9bfc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 17:43:46.9387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1536
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21Hi0hl022126

On Thu, 2018-03-01 at 09:57 +0800, jianchao.wang wrote:
> On 03/01/2018 01:52 AM, Bart Van Assche wrote:
> > On Wed, 2018-02-28 at 16:55 +0800, Jianchao Wang wrote:
> > > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > > index a86df9c..6fa7b0c 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -191,7 +191,8 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
> > >  	 */
> > >  	cmd->result = 0;
> > >  	if (q->mq_ops) {
> > > -		scsi_mq_requeue_cmd(cmd);
> > > +		blk_mq_requeue_request(cmd->request, true);
> > > +		put_device(&device->sdev_gendev);
> > >  		return;
> > >  	}
> > >  	spin_lock_irqsave(q->queue_lock, flags);
> > 
> > Anyone who sees the put_device() call that follows the blk_mq_requeue_request()
> > call will wonder why that call occurs there. So I think we need a comment above
> > that call that explains where the matching get_device() call is.
> 
> Yes, I will add this.
> 
> > For the legacy code path, there is a get_device() call in scsi_prep_fn() but no
> > put_device() call in scsi_unprep_fn() - the matching put_device() calls occur in
> > scsi_end_request() and after blk_requeue_request().
> > 
> > For scsi-mq however there is a get_device() call in scsi_mq_get_budget() and a
> > put_device() call in scsi_mq_put_budget(). So why do we need the put_device()
> > calls after blk_mq_requeue_request() and in the mq path for scsi_end_request()?
> > 
> 
> From the source code, we know the scsi_mq_get_budget will be invoked every time
> when we issue a request. But scsi_mq_put_budget is just in the fail path.
> 
> scsi_queue_rq // if any error
>   -> scsi_mq_put_budget
> 
> blk_mq_dispatch_rq_list // if no driver tags
>   -> blk_mq_put_dispatch_budget
>     -> scsi_mq_put_budget
> blk_mq_do_dispatch_sched/blk_mq_do_dispatch_ctx // if no requests
>   -> blk_mq_put_dispatch_budget
>     -> scsi_mq_put_budget
> 
> So we have to add put_device after blk_mq_requeue_request() and in
> scsi_end_request() to match the scsi_mq_get_budget.

Hello Jianchao,

Yes, the block layer core guarantees that scsi_mq_get_budget() will be called
before scsi_queue_rq(). I think the full picture is as follows:
* Before scsi_queue_rq() calls .queuecommand(), get_device() is called for the
  SCSI device and the device, target and host busy counters are incremented.
* If the SCSI core decides to requeue a command, scsi_queue_insert() causes
  __scsi_queue_insert() to call scsi_device_unbusy(). That last function
  decreases the device, target and host busy counters but not put_device(sdev).
  Hence the need for a separate put_device() call after requeuing.

It's unfortunate that the SCSI core became so asymmetric. Anyway, since I am
now convinced that this patch is correct, feel free to add:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
