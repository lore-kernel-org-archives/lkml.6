Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755099AbeDFPB3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:01:29 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50809 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754993AbeDFPBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:01:24 -0400
X-IronPort-AV: E=Sophos;i="5.48,415,1517846400";
   d="scan'208";a="178452632"
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "himanshu.madhani@cavium.com" <himanshu.madhani@cavium.com>
Subject: Re: [PATCH] qla2xxx: correctly shift host byte
Thread-Topic: [PATCH] qla2xxx: correctly shift host byte
Thread-Index: AQHTzXyPbbDeKVF6O0uGNlN9C1KesqPz1UOA
Date: Fri, 6 Apr 2018 15:01:20 +0000
Message-ID: <0753246e70d16062b87930b2b75eec31a4bb88eb.camel@wdc.com>
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
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0913;7:L/QmthVGqaKOTwCgToLABnPvL7mO8g9oAsGy9+GxcMr8rvAIyZpdj5hxcsluNvzIV5FAoYDHXIWLyLGw5AOMmlDyfnNYalnks3obUQ2ONeH2TxubyuRwKhytw61+Qr6dPPFhBmQyjIzYb6pZvbpLtCIkhLAit0S7ziJoCZcUCBREAsTsF5XHos1YpcoNgNanZXXd1N8kbYRA8olkNvpvYV8usk4dnUa5eEU7uCb7E+BtcOy6jQrhPEAAiW2pZq2L;20:E9t8USjNPKCmDUOPIyZnd1vf+sHTlEIElUBAWD7c3hQ0rTGi8cufvof7x28078eL18/vRjEBbhfZ9CQdukvWeB8G0yyLiT08vjTbLdb4JEgCWxSjCnT8AVFYe1FdOg0if/EsWMnI+ke4vngcp/Iifn9rgRuEP/1ph/AyfhOfXU0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5bda979-e2db-4c5c-2938-08d59bcf41f4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0913;
x-ms-traffictypediagnostic: MWHPR04MB0913:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0913FCAC35BAF968772D8B0A98BA0@MWHPR04MB0913.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR04MB0913;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0913;
x-forefront-prvs: 0634F37BFF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(39380400002)(376002)(39860400002)(189003)(377424004)(199004)(59450400001)(76176011)(106356001)(86362001)(2906002)(6246003)(66066001)(102836004)(118296001)(26005)(99286004)(4326008)(105586002)(6116002)(72206003)(8676002)(2616005)(229853002)(6506007)(11346002)(3846002)(3660700001)(186003)(446003)(81166006)(8936002)(476003)(14454004)(316002)(97736004)(110136005)(54906003)(68736007)(3280700002)(5660300001)(478600001)(2900100001)(81156014)(305945005)(7736002)(25786009)(6436002)(5250100002)(2501003)(486006)(6486002)(6512007)(36756003)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0913;H:MWHPR04MB1198.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: B4Uiqv6e7qNVuFm3pfgBLURd9c4AKErA1bqrZTTkzwqVr09T1SXAPSSfJYnwS+WWqc+6uJ6FA7EOVs+PzbMeXa4cKZOriNhnlYF+rCx69fRDLCoB0nxWeE1YcstDWF/AerGuQbTeIURN+KBWek8IWmGdHlQPbwKUS62qYpygewVuYQssMuTg0rQALzebfwzd3cNaBYnjBwz+vUcB7JrVSBgvN/DSOnhtkCiqmmfaPGEjum7EGIJoYoDzwyObzuXBYhTMbCvjxq8pUE6bFWeqXU+kJVj+164mex/ypgBApi8Ti/K1SnwRviOiWoJbfP3VigjJauBTjatNN+a9ZbIWqFbxA7/56nuSsz1SPlKHM/Xkq2kFt34N9ZAQ0Wf3fhQkzwUNT3EjjhMgZiV5qi/jmxLeBV089AWAV47lIM+Bg6c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA62C0CAA3EFE342B049CA7E48FB72C1@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bda979-e2db-4c5c-2938-08d59bcf41f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2018 15:01:20.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0913
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w36F1Znv022182

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

Please mention in the description of this patch that this patch does not
change any functionality because DID_OK == 0. Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
