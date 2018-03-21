Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752325AbeCUPzi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:55:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54456 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCUPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:55:34 -0400
X-IronPort-AV: E=Sophos;i="5.48,340,1517846400";
   d="scan'208";a="74168395"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  scsi: ufs: add trace event for ufs upiu
Thread-Topic: [PATCH]  scsi: ufs: add trace event for ufs upiu
Thread-Index: AdPBLN3c/QLS4HZET1i3hLh75LbNNA==
Date: Wed, 21 Mar 2018 15:55:27 +0000
Message-ID: <MWHPR04MB1137DA8E5CFDC79A018588E09AAA0@MWHPR04MB1137.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0927;7:IeldB9lnjKAhJgG0e+mrq8m4GjtgZE11LexHrkAFVOcjWbkpolPkt5Qer/v5xd8GSTRmC0xr7Topda45Sow3EX1uH/NJy5wWbS8c94xECrcVVx4f/n55Ol+WucYG0HpYXDouysiDzlqvfZbXZlefaN5ggONZVenkWNzPOG1EESs4W+317yZcQWgk2HUytmuv0yIcW71CdXZ4u7ZvV3VVMjDmq2HIIlSyPDFamsMV7NXTKbxLJKp5RJAWuK3qzu5f;20:Ogysc7I8LvCe4OBz3sRIcMPLZzknSKi2TNmqMKp8aAuyZhB9GU+CqT0q+OQASuPpQb+1Zlmm3fpkHkYcTf1B4X8AkBym+Jdb3wC2sPFKmINAUAEijAMrFn3IraLjhSd+0q4DDdLYDO9p6nfqoE7Pmi43NFv5jNBWbFfcQUwvBn8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce1345ce-f9aa-4184-635c-08d58f442aa2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0927;
x-ms-traffictypediagnostic: MWHPR04MB0927:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0927BF1CB71D4CA682D59FBF9AAA0@MWHPR04MB0927.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319)(146099531331640)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501324)(52105095)(3002001)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0927;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0927;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(346002)(366004)(39860400002)(13464003)(199004)(189003)(86362001)(68736007)(5660300001)(229853002)(5250100002)(2501003)(7736002)(305945005)(74316002)(72206003)(8936002)(478600001)(81156014)(2900100001)(97736004)(6436002)(106356001)(102836004)(81166006)(110136005)(66066001)(316002)(8676002)(14454004)(6246003)(99286004)(55016002)(105586002)(7696005)(9686003)(53936002)(2906002)(3660700001)(3846002)(186003)(3280700002)(33656002)(26005)(6506007)(53546011)(59450400001)(25786009)(551934003)(6116002)(450100002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0927;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 6kLrLfprcwncZpGQRExk3bJm+vr+U9BqelYU9YK8Oxq8NXSOsDndnywgKgMZXR1TOQPnHLVeqRqChgYhK9naBDy61Y1ViAtPDK6EJVH+QMeCpmNImov5MS/74vjxDRF4j7hL4q5yT4sUVejgwKjE7ywOnrnYoyARDod/0qOzYZobVvQYmnixIB2qtu11CEy9/yC5KeH5PruCOfIFRCpVRGVEx21vqv76JQ1WnsuzgRfUNh3bJ896V4g3tB2PJVRuook2h4Dqd7Ih94BQH7H1vHKEblB9ScTy4WnLB4eLwU703GkO2TSB6Hf5GJxQhxfS1ByKAIdlMRkR0jZY/92a7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1345ce-f9aa-4184-635c-08d58f442aa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 15:55:27.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0927
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2LFtgPC019565



-----Original Message-----
From: Stanislav Nijnikov 
Sent: Wednesday, March 21, 2018 2:24 PM
To: Ohad Sharabi <Ohad.Sharabi@wdc.com>; James E.J. Bottomley <jejb@linux.vnet.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>; gregkh@linuxfoundation.org
Cc: Alex Lemberg <Alex.Lemberg@wdc.com>; Ohad Sharabi <Ohad.Sharabi@wdc.com>
Subject: Re: {PATCH} ] scsi: ufs: add trace event for ufs upiu


> -----Original Message-----
> From: Ohad Sharabi [mailto:ohad.sharabi@sandisk.com]
> Sent: Tuesday, February 20, 2018 4:35 PM
> James E.J. Bottomley <jejb@linux.vnet.ibm.com>;
> To: Martin K. Petersen <martin.petersen@oracle.com>; Greg KH
> < gregkh@linuxfoundation.org>; linux-scsi@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Alex Lemberg <Alex.Lemberg@wdc.com>; Ohad Sharabi
> <ohad.sharabi@sandisk.com>
> Subject: [PATCH] ] scsi: ufs: add trace event for ufs upiu
> 
> Add UFS Protocol Information Units(upiu) trace events for ufs driver,
> used to trace various ufs transaction types- command, task-management
> and device management.
> The trace-point format is generic and can be easily adapted to trace
> other upius if needed.
> Currently tracing ufs transaction of type 'device management', which
> this patch introduce, cannot be obtained from any other trace.
> Device management transactions are used for communication with the
> device such as reading and writing descriptor or attributes etc.
> 
> Signed-off-by: Ohad Sharabi <ohad.sharabi@sandisk.com>
> ---
>  drivers/scsi/ufs/ufshcd.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/trace/events/ufs.h | 28 +++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index a355d98..6d79c99 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -274,6 +274,47 @@ static inline void ufshcd_remove_non_printable(char *val)
>  		*val = ' ';
>  }
>  
> +static void ufshcd_add_upiu_trace(struct ufs_hba *hba, unsigned int tag,
> +	const char *str)
> +{
> +	struct utp_task_req_desc *descp;
> +	struct utp_upiu_task_req *task_req;
> +	struct utp_upiu_req *rq;
> +	u8 tx_code, *hdr, *tsf;
> +	int off;
> +
> +	if (!trace_ufshcd_upiu_enabled())
> +		return;
> +
> +	off = (int)tag - hba->nutrs;
> +	if (off < 0) {
> +		rq = hba->lrb[tag].ucd_req_ptr;
> +		hdr = (u8 *)&rq->header;
> +	} else {
> +		descp = &hba->utmrdl_base_addr[off];
> +		task_req = (struct utp_upiu_task_req *)descp->task_req_upiu;
> +		hdr = (u8 *)&task_req->header;
> +	}
> +
> +	tx_code = hdr[0] & 0x3f;

The tx_code variable is not used.
Please combine the if and switch code, otherwise Sparse gives warnings that rq and task_req could be not initialized.

> +	switch (hdr[0] & 0x3f) {
> +	case UPIU_TRANSACTION_COMMAND:
> +		tsf = (u8 *)&rq->sc.cdb;
> +		break;
> +	case UPIU_TRANSACTION_TASK_REQ:
> +		tsf = (u8 *)&task_req->input_param1;
> +		break;
> +	case UPIU_TRANSACTION_QUERY_REQ:

Is this case used ATM?

> +		tsf = (u8 *)&rq->qr;
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	/* trace UPIU header and Transaction Specific Fields (TSF) */
> +	trace_ufshcd_upiu(dev_name(hba->dev), str, hdr, tsf);
> +}
> +
>  static void ufshcd_add_command_trace(struct ufs_hba *hba,
>  		unsigned int tag, const char *str)
>  {
> @@ -283,6 +324,9 @@ static void ufshcd_add_command_trace(struct ufs_hba *hba,
>  	struct ufshcd_lrb *lrbp;
>  	int transfer_len = -1;
>  
> +	/* trace UPIU also */
> +	ufshcd_add_upiu_trace(hba, tag, str);
> +
>  	if (!trace_ufshcd_command_enabled())
>  		return;
>  
> @@ -5462,11 +5506,14 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
>  
>  	spin_unlock_irqrestore(host->host_lock, flags);
>  
> +	ufshcd_add_upiu_trace(hba, task_tag, "tm_send");
> +
>  	/* wait until the task management command is completed */
>  	err = wait_event_timeout(hba->tm_wq,
>  			test_bit(free_slot, &hba->tm_condition),
>  			msecs_to_jiffies(TM_CMD_TIMEOUT));
>  	if (!err) {
> +		ufshcd_add_upiu_trace(hba, task_tag, "tm_complete_err");
>  		dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
>  				__func__, tm_function);
>  		if (ufshcd_clear_tm_cmd(hba, free_slot))
> @@ -5475,6 +5522,7 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba, int lun_id, int task_id,
>  		err = -ETIMEDOUT;
>  	} else {
>  		err = ufshcd_task_req_compl(hba, free_slot, tm_response);
> +		ufshcd_add_upiu_trace(hba, task_tag, "tm_complete");
>  	}
>  
>  	clear_bit(free_slot, &hba->tm_condition);
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index bf6f826..0b2ff5d 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -257,6 +257,34 @@
>  	)
>  );
>  
> +TRACE_EVENT(ufshcd_upiu,
> +	TP_PROTO(const char *dev_name, const char *str, unsigned char *hdr,
> +			unsigned char *tsf),
> +
> +	TP_ARGS(dev_name, str, hdr, tsf),
> +
> +	TP_STRUCT__entry(
> +		__string(dev_name, dev_name)
> +		__string(str, str)
> +		__array(unsigned char, hdr, 12)
> +		__array(unsigned char, tsf, 16)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev_name, dev_name);
> +		__assign_str(str, str);
> +		memcpy(__entry->hdr, hdr, sizeof(__entry->hdr));
> +		memcpy(__entry->tsf, tsf, sizeof(__entry->tsf));
> +	),
> +
> +	TP_printk(
> +		"%s: %s: HDR:%s, CDB:%s",
> +		__get_str(str), __get_str(dev_name),
> +		__print_hex(__entry->hdr, sizeof(__entry->hdr)),
> +		__print_hex(__entry->tsf, sizeof(__entry->tsf))
> +	)
> +);
> +
>  #endif /* if !defined(_TRACE_UFS_H) || defined(TRACE_HEADER_MULTI_READ) */
>  
>  /* This part must be outside protection */
> -- 
> 1.9.1
