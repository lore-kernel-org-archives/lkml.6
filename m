Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934499AbeB1Rwq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:52:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7742 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbeB1Rwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:52:43 -0500
X-IronPort-AV: E=Sophos;i="5.47,406,1515427200";
   d="scan'208";a="72423929"
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
Thread-Index: AQHTsHHVjOEcXDmyrUm+gBCv0tqSDKO6GPCA
Date: Wed, 28 Feb 2018 17:52:39 +0000
Message-ID: <1519840355.2777.8.camel@wdc.com>
References: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY1PR0401MB1115;7:bbDBvRA9PHznV1Vcwtznoha+NJudMClaT/nvMNL5AsMWW4zF1k2icWpP04f9tghC+fFQkcr+JsaPs+6xFEme8scfChoI2P5Wn54VOuRt9I4RVEzb7aY74gOcfWRparheJWIM1aY69dvIuHZI/mTWasgsq9anu//lVoi7baT4pETbpOEniJT4xQgUVgp1atZvEw/oZyzMIhqG1vgVTNHgZOIUI9dSFJH1R3W3KZx69lg9aXQoborrN5e5sSnqzzxL;20:j9YSEyIIuREBpiq5ylEn2lxPyCMF8RdapSvfXTf0uCWAtec3kdicqUMMJnzO42o21t3g0Qs0vYUsPOnZSrENH+EAC+Am+81E5LUNI1HR0fw+WkLEWxSxYo7kBO5Bq8qQchSM3k8u3jnWKaD3IT3pXQ17XtnilchLBOA6515YLGU=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 462dd814-d226-4694-0d6c-08d57ed40f5d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY1PR0401MB1115;
x-ms-traffictypediagnostic: CY1PR0401MB1115:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR0401MB11152330F856D5F0BB7667D598C70@CY1PR0401MB1115.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231220)(944501217)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR0401MB1115;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0401MB1115;
x-forefront-prvs: 0597911EE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39380400002)(39860400002)(396003)(189003)(57704003)(199004)(377424004)(478600001)(5660300001)(81166006)(81156014)(25786009)(14454004)(8676002)(99286004)(54906003)(110136005)(72206003)(316002)(2950100002)(2201001)(102836004)(105586002)(186003)(77096007)(26005)(59450400001)(8936002)(86362001)(575784001)(103116003)(229853002)(6506007)(66066001)(2900100001)(36756003)(305945005)(7736002)(53936002)(97736004)(6436002)(6116002)(2906002)(6486002)(3280700002)(6246003)(68736007)(3660700001)(3846002)(76176011)(2501003)(106356001)(6512007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR0401MB1115;H:CY1PR0401MB1536.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: duKjcJ6pnD1uibeDVPXxbG34Ebi2CLChbT535f3b0mqH07w0iQwONovMrR1ixXPkvmRIviGwiK4AqosDd/1sQuBIrQGi7WVnccU1agDT+zIsNgeJCqgOIVhHiHDbBHf1Q/mrScSbelh26d50wPJ/w7dXz5frrYdOoNrpQTB7IwA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9124CAE3631E75419285C1CF6FB0460D@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 462dd814-d226-4694-0d6c-08d57ed40f5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2018 17:52:39.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0401MB1115
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1SHqo2H012406

On Wed, 2018-02-28 at 16:55 +0800, Jianchao Wang wrote:
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index a86df9c..6fa7b0c 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -191,7 +191,8 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
>  	 */
>  	cmd->result = 0;
>  	if (q->mq_ops) {
> -		scsi_mq_requeue_cmd(cmd);
> +		blk_mq_requeue_request(cmd->request, true);
> +		put_device(&device->sdev_gendev);
>  		return;
>  	}
>  	spin_lock_irqsave(q->queue_lock, flags);

Anyone who sees the put_device() call that follows the blk_mq_requeue_request()
call will wonder why that call occurs there. So I think we need a comment above
that call that explains where the matching get_device() call is.

For the legacy code path, there is a get_device() call in scsi_prep_fn() but no
put_device() call in scsi_unprep_fn() - the matching put_device() calls occur in
scsi_end_request() and after blk_requeue_request().

For scsi-mq however there is a get_device() call in scsi_mq_get_budget() and a
put_device() call in scsi_mq_put_budget(). So why do we need the put_device()
calls after blk_mq_requeue_request() and in the mq path for scsi_end_request()?

Thanks,

Bart.
