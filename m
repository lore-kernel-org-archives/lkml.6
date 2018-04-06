Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeDFPdj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:33:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:15857 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753478AbeDFPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:33:36 -0400
X-IronPort-AV: E=Sophos;i="5.48,415,1517846400";
   d="scan'208";a="75276073"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>
Subject: Re: [PATCH] qla2xxx: correctly shift host byte
Thread-Topic: [PATCH] qla2xxx: correctly shift host byte
Thread-Index: AQHTzXyPbbDeKVF6O0uGNlN9C1KesqPz3kCA
Date: Fri, 6 Apr 2018 15:33:30 +0000
Message-ID: <222067aa244e369343101a4df9efab1ebd1b918c.camel@wdc.com>
References: <20180406075222.7358-1-jthumshirn@suse.de>
In-Reply-To: <20180406075222.7358-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
x-originating-ip: [199.255.44.172]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0751;7:SwPs7gH6ehjVjH4Gf2IHRFrn04HMgI+cLnvt/uCegmpdCpRObkekixqY8c4v85shvfAxjRbYqPcwMIqcRmm0eSF+JAtWCSE9/G0ATB1/DsRl28ut2M18B5gPpaTRZjePRn8RxrCOnY/S/yOGSFqhSzc/yP/6YcFhp7xy4c75801vVnGIlYnE1ideXb6xhTK2NznmU2cXl4meOZul5dG1Y/fqqyBtcvaGAyYZIYy3TpOpedZcjhIi+JPPSNb1ZqZC;20:OgUcXSnZCWIBdrQ7v5sVdUbv32/E80RmAcsO9UH6iNC8zZS+rdeafcj6FM8IN5MYt0uQVOH9Ua8OiJLB9vK1JoRX7HOlIXZl8MUh+UrWr7FjUX5sfrRaGIXKDXVbDGhI0oOfNpFDZoyV2AFRigdFmotB8SoFSeSpGFakLQMTbXM=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: deb21dca-c141-4901-87db-08d59bd3c04f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0751;
x-ms-traffictypediagnostic: MWHPR04MB0751:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB07519469694BA21B9378FC6598BA0@MWHPR04MB0751.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB0751;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0751;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(39380400002)(376002)(199004)(189003)(377424004)(2900100001)(3660700001)(110136005)(5660300001)(76176011)(66066001)(7736002)(3280700002)(14454004)(72206003)(2501003)(2616005)(86362001)(4326008)(97736004)(486006)(118296001)(59450400001)(305945005)(476003)(36756003)(6506007)(68736007)(5250100002)(229853002)(99286004)(25786009)(11346002)(6512007)(6436002)(6486002)(8936002)(81156014)(105586002)(8676002)(186003)(2906002)(446003)(53936002)(54906003)(81166006)(106356001)(26005)(3846002)(478600001)(316002)(102836004)(6246003)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0751;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: YTlvkwTMuP2kh50Bc02bt+dcH6Ag/vJ15n+tL1815oOeSpO6t3dbTfnTPMnlr12sBq/w/5XvX/t5t4K9NmqIK+C/tiTAYyK4McIS4JXGga4w2ZHWhgBK8045183Dn9O9JwKPCTDbmT8rNefMrmptGj2JbdB3BF2abSD4ck3R2ozOzCj8/nVvrQK6wqhO80xWiqEhiHs3mWzMrU/AMoV47g3xXmsP/Q77akIxug46vovK7VpcYWdTsPSOUdFYhwScsxXZtsFnIhwJqZPY2PC2W1jbyVvgQ/advETD48RhLMAPgMARrlD4fXcDyn8Amhz+4EBACZ52FPDSHP8xHmti0FcU7LXdBQzdRnsCpmhMS04bVDT4GVGaPxRq9NX7CNvOee3mlsfFVGFlS2lvZ+VtnHgeOXQ+inNONvLnI7UhyPs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3F8BA0CE0D8EA42AD08B49828DBF996@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb21dca-c141-4901-87db-08d59bd3c04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 15:33:30.8385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0751
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w36FXjGm023108

On Fri, 2018-04-06 at 09:52 +0200, Johannes Thumshirn wrote:
> The host byte has to be shifted by 16 not 6.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/qla2xxx/qla_isr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
> index 89f93ebd819d..49d67e1d571f 100644
> --- a/drivers/scsi/qla2xxx/qla_isr.c
> +++ b/drivers/scsi/qla2xxx/qla_isr.c
> @@ -2368,7 +2368,7 @@ qla25xx_process_bidir_status_iocb(scsi_qla_host_t *vha, void *pkt,
>  	bsg_job->reply_len = sizeof(struct fc_bsg_reply);
>  	/* Always return DID_OK, bsg will send the vendor specific response
>  	 * in this case only */
> -	sp->done(sp, DID_OK << 6);
> +	sp->done(sp, DID_OK << 16);
>  
>  }

Hello Johannes,

Had you noticed the following statements? I think the "<< 1" should be removed
from these statements.

$ git grep 'SAM_STAT.*<< 1'
drivers/scsi/qla2xxx/qla_isr.c:         cmd->result |= SAM_STAT_CHECK_CONDITION << 1;
drivers/scsi/qla2xxx/qla_isr.c:         cmd->result |= SAM_STAT_CHECK_CONDITION << 1;
drivers/scsi/qla2xxx/qla_isr.c:         cmd->result |= SAM_STAT_CHECK_CONDITION << 1;

Thanks,

Bart.
