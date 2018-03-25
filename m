Return-Path: <prvs=6154fa5e2=Stanislav.Nijnikov@wdc.com>
X-Google-Smtp-Source: AG47ELvDjC4a8Ep0mi5ctIXA2O2T/+HFemxgwfsW07re4Gw28PxGA+RybHAgiIdwxybKKdEreILg
ARC-Seal: i=1; a=rsa-sha256; t=1521985483; cv=none;
        d=google.com; s=arc-20160816;
        b=osoYQGAE3hKoEXMlkECl9/mXvNc9iZQxLyhdh2q18Hpom0FW4c78b9MhHVEgE6F7IO
         LHXqKoyU5+4pfeY8+jhSccZHYQdi5pBBoSHgl0HAU35XUa4i8G8NfrvbKah95asXF/mq
         0349tRIq+JZX/S+BgGVpsR5beMy1lCqF71Pj25fPNneSwo/V8menSu+SCHFktfAtxNjF
         Ihq9rDFg4fVdHBjocjdUVx8qTBi6YqsSgloOCNrSB4zF4MmhNpLIA8tNL/eb3/jD8b/j
         YAhADgTjzG55Uz4/JcW28+B4uoTLrHBAs0yomKcPrnFhr9IP9EFyDJCYUFFWCr0Ukx28
         pqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:wdcipoutbound:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=kwoAo9sknn+UMaLBDHVQFpQ1KyOhdTlnf7bid1RgSQU=;
        b=EjyiwMIgu5zz/axezeoCTqneKB9Vge0jtvQzatiWBD8ILx2YawtRbS35/ZZcS/ZFLP
         mXMUDgNJITa2xBhMZXwlxFwCgF/J02RXFlWkcLOv1nDPYDmR2uUW1wRk5Ws287s/2l2y
         GewcJFwEbPOI85TH5uXtk4XgpGl2v3NUWipTJJ9wWFKxm2LYXEc55+LjhWOGU6tGFO9q
         fqpDcvkXfcHrV2N8CoxJ3SxeO9UsCLohCsZpsy7VIHzk9scLeum8FZsEf7Iz+G2lqOui
         H07VqkmstZCKwFK6zfbwY69nbfz2SQE//zEWVw0VwZWQLAPtPhHtl5uuvYqPkeJIWbSA
         vwFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=juvydaSR;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=C1PLxQWC;
       spf=pass (google.com: domain of prvs=6154fa5e2=stanislav.nijnikov@wdc.com designates 216.71.154.42 as permitted sender) smtp.mailfrom=prvs=6154fa5e2=Stanislav.Nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=juvydaSR;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=C1PLxQWC;
       spf=pass (google.com: domain of prvs=6154fa5e2=stanislav.nijnikov@wdc.com designates 216.71.154.42 as permitted sender) smtp.mailfrom=prvs=6154fa5e2=Stanislav.Nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,360,1517846400";
   d="scan'208";a="74297651"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Ohad Sharabi <Ohad.Sharabi@wdc.com>, "jejb@linux.vnet.ibm.com"
	<jejb@linux.vnet.ibm.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>, Ohad Sharabi <Ohad.Sharabi@wdc.com>
Subject: RE: [PATCH v3] scsi: ufs: add trace event for ufs upiu
Thread-Topic: [PATCH v3] scsi: ufs: add trace event for ufs upiu
Thread-Index: AQHTxAgUVPCwYapC1kCSQl1Glh1gZ6Pg9jtg
Date: Sun, 25 Mar 2018 13:44:37 +0000
Message-ID: <MWHPR04MB1137878F56EFB4522602228B9AAE0@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <1521961684-13588-1-git-send-email-ohad.sharabi@sandisk.com>
In-Reply-To: <1521961684-13588-1-git-send-email-ohad.sharabi@sandisk.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB0671;7:Ee5Y1aX6X03AK1ksqa7bnULAd7lSkIm/8vp2OUcCSqGMkzWHXrU0ZTwv9Spo1y6poG1q2866R28pNUTdl2ixql4VsZtYcktsH9VTklPz/FdYQ59bcefiySK+NZNFlag/YAGzdVmu0UoPSWrSq/2JKeyqL+2HYugfw//SCG3SOjUmj0ARZdrWMBPqqSvF3p/36okHSI5ZQqAgVCHkp+jsNtr4gFmDPVIjFq/fec7wyUzTimwxflUv6XnXGe3ZzRYg;20:SgbnRoufDdXEf5kIAz0GKUDJdHw6Zd0wblo+sdsu/Y1ttUGbCU75w7VTJOeGNmfIUc61Lb6vKdgF6nnLY/5haESlIsG2iwCPlIGDfEi2tmWmh86RECVjGtRXdHdbRvkpcZcjqBAyvufUZFQElf6PdWYFyuUgwge5jsf8OfUKD8Y=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8579c746-ab92-4047-d03d-08d592568ced
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603328)(7153060)(7193020);SRVR:MWHPR04MB0671;
x-ms-traffictypediagnostic: MWHPR04MB0671:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB0671C24406F0CC7523678F5A9AAE0@MWHPR04MB0671.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(104084551191319)(146099531331640)(42932892334569);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR04MB0671;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB0671;
x-forefront-prvs: 0622A98CD5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(39380400002)(376002)(366004)(39860400002)(199004)(189003)(13464003)(3660700001)(55016002)(2201001)(26005)(102836004)(4326008)(6246003)(33656002)(72206003)(97736004)(6436002)(551934003)(110136005)(5250100002)(8676002)(11346002)(54906003)(446003)(81166006)(8936002)(81156014)(478600001)(25786009)(316002)(2501003)(229853002)(86362001)(53546011)(1691005)(6116002)(7696005)(76176011)(2906002)(2900100001)(3280700002)(6506007)(59450400001)(99286004)(68736007)(105586002)(66066001)(53936002)(14454004)(9686003)(74316002)(7736002)(305945005)(3846002)(106356001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB0671;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: PoC3lgE+uwCzE9ZOfvdW0qTBfi9poIHE7c37IdglgjhN5sz69BRzxU8u+cpvkQSJbAi4K4g4mmxXknBzSmlyo9jriNuIBk/WQIjOdR+lEJSZcuWIg0GGvjz26syG4XiVi4H6HsSr/LgkrZekPhmfxc48oMofI4bJbvFvZFixTpdEPRoqa4zTN8qtDJKcljoMPKrUfEaULNTBoTBOXp2wK6JSYG9dWpCXZ4i5zx/+ppkTnFdGcCyJC/3UFBG8J5s/gqwG195ukSvXIntV9aTSU2S2xHIvfFiJI9js+dQOoFp7dtpnkDrFbK2OHf//9nHRkWG5ZCxfE76wWOm7Jugepw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8579c746-ab92-4047-d03d-08d592568ced
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2018 13:44:37.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0671
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595892513876179134?=
X-GMAIL-MSGID: =?utf-8?q?1595917450156306076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Looks fine.

Reviewed-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>

> -----Original Message-----
> From: Ohad Sharabi [mailto:ohad.sharabi@sandisk.com]
> Sent: Sunday, March 25, 2018 10:08 AM
> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>; jejb@linux.vnet.ibm.=
com; martin.petersen@oracle.com;
> gregkh@linuxfoundation.org
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org; Alex Lember=
g <Alex.Lemberg@wdc.com>; Ohad Sharabi
> <Ohad.Sharabi@wdc.com>
> Subject: [PATCH v3] scsi: ufs: add trace event for ufs upiu
>=20
> Add UFS Protocol Information Units(upiu) trace events for ufs driver,
> used to trace various ufs transaction types- command, task-management
> and device management.
> The trace-point format is generic and can be easily adapted to trace
> other upius if needed.
> Currently tracing ufs transaction of type 'device management', which
> this patch introduce, cannot be obtained from any other trace.
> Device management transactions are used for communication with the
> device such as reading and writing descriptor or attributes etc.
>=20
> v2->v3:
>     - modify args 3,4 of trace_ufshcd_upiu to be void *
>=20
> v1->v2:
>     - split to transaction specific functions (fix warnings and simplifie=
s
>       code)
>     - adding traces when sending query command
>=20
> Signed-off-by: Ohad Sharabi <ohad.sharabi@sandisk.com>
> ---
>  drivers/scsi/ufs/ufshcd.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/trace/events/ufs.h | 27 +++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>=20
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index c7da2c1..23ffaed 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -274,6 +274,35 @@ static inline void ufshcd_remove_non_printable(char =
*val)
>  		*val =3D ' ';
>  }
>=20
> +static void ufshcd_add_cmd_upiu_trace(struct ufs_hba *hba, unsigned int =
tag,
> +		const char *str)
> +{
> +	struct utp_upiu_req *rq =3D hba->lrb[tag].ucd_req_ptr;
> +
> +	trace_ufshcd_upiu(dev_name(hba->dev), str, &rq->header, &rq->sc.cdb);
> +}
> +
> +static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba, unsigned in=
t tag,
> +		const char *str)
> +{
> +	struct utp_upiu_req *rq =3D hba->lrb[tag].ucd_req_ptr;
> +
> +	trace_ufshcd_upiu(dev_name(hba->dev), str, &rq->header, &rq->qr);
> +}
> +
> +static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int t=
ag,
> +		const char *str)
> +{
> +	struct utp_task_req_desc *descp;
> +	struct utp_upiu_task_req *task_req;
> +	int off =3D (int)tag - hba->nutrs;
> +
> +	descp =3D &hba->utmrdl_base_addr[off];
> +	task_req =3D (struct utp_upiu_task_req *)descp->task_req_upiu;
> +	trace_ufshcd_upiu(dev_name(hba->dev), str, &task_req->header,
> +			&task_req->input_param1);
> +}
> +
>  static void ufshcd_add_command_trace(struct ufs_hba *hba,
>  		unsigned int tag, const char *str)
>  {
> @@ -283,6 +312,9 @@ static void ufshcd_add_command_trace(struct ufs_hba *=
hba,
>  	struct ufshcd_lrb *lrbp;
>  	int transfer_len =3D -1;
>=20
> +	/* trace UPIU also */
> +	ufshcd_add_cmd_upiu_trace(hba, tag, str);
> +
>  	if (!trace_ufshcd_command_enabled())
>  		return;
>=20
> @@ -2584,6 +2616,7 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>=20
>  	hba->dev_cmd.complete =3D &wait;
>=20
> +	ufshcd_add_query_upiu_trace(hba, tag, "query_send");
>  	/* Make sure descriptors are ready before ringing the doorbell */
>  	wmb();
>  	spin_lock_irqsave(hba->host->host_lock, flags);
> @@ -2593,6 +2626,9 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
>=20
>  	err =3D ufshcd_wait_for_dev_cmd(hba, lrbp, timeout);
>=20
> +	ufshcd_add_query_upiu_trace(hba, tag,
> +			err ? "query_complete_err" : "query_complete");
> +
>  out_put_tag:
>  	ufshcd_put_dev_cmd_tag(hba, tag);
>  	wake_up(&hba->dev_cmd.tag_wq);
> @@ -5464,11 +5500,14 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hb=
a, int lun_id, int task_id,
>=20
>  	spin_unlock_irqrestore(host->host_lock, flags);
>=20
> +	ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_send");
> +
>  	/* wait until the task management command is completed */
>  	err =3D wait_event_timeout(hba->tm_wq,
>  			test_bit(free_slot, &hba->tm_condition),
>  			msecs_to_jiffies(TM_CMD_TIMEOUT));
>  	if (!err) {
> +		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete_err");
>  		dev_err(hba->dev, "%s: task management cmd 0x%.2x timed-out\n",
>  				__func__, tm_function);
>  		if (ufshcd_clear_tm_cmd(hba, free_slot))
> @@ -5477,6 +5516,7 @@ static int ufshcd_issue_tm_cmd(struct ufs_hba *hba,=
 int lun_id, int task_id,
>  		err =3D -ETIMEDOUT;
>  	} else {
>  		err =3D ufshcd_task_req_compl(hba, free_slot, tm_response);
> +		ufshcd_add_tm_upiu_trace(hba, task_tag, "tm_complete");
>  	}
>=20
>  	clear_bit(free_slot, &hba->tm_condition);
> diff --git a/include/trace/events/ufs.h b/include/trace/events/ufs.h
> index bf6f826..f8260e5 100644
> --- a/include/trace/events/ufs.h
> +++ b/include/trace/events/ufs.h
> @@ -257,6 +257,33 @@
>  	)
>  );
>=20
> +TRACE_EVENT(ufshcd_upiu,
> +	TP_PROTO(const char *dev_name, const char *str, void *hdr, void *tsf),
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
>  #endif /* if !defined(_TRACE_UFS_H) || defined(TRACE_HEADER_MULTI_READ) =
*/
>=20
>  /* This part must be outside protection */
> --
> 1.9.1
