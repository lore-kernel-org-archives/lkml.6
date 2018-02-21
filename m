Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754641AbeBUNSq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:18:46 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1341 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeBUNSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:18:39 -0500
X-IronPort-AV: E=Sophos;i="5.46,543,1511798400";
   d="scan'208";a="168287009"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Asutosh Das <asutoshd@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/9] scsi: ufs: add reference counting for scsi block
 requests
Thread-Topic: [PATCH 5/9] scsi: ufs: add reference counting for scsi block
 requests
Thread-Index: AQHTqtF3nCgA49p9yEi7LuXFGC4iE6Ou04rw
Date: Wed, 21 Feb 2018 13:18:33 +0000
Message-ID: <MWHPR04MB1137BE3E48766435570460689ACE0@MWHPR04MB1137.namprd04.prod.outlook.com>
References: <cover.1519120988.git.asutoshd@codeaurora.org>
 <ff8f06512eca0c6275d3d486af0d430d8111c451.1519120988.git.asutoshd@codeaurora.org>
In-Reply-To: <ff8f06512eca0c6275d3d486af0d430d8111c451.1519120988.git.asutoshd@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR04MB1070;7:huVRnkUaSkvUP73Os9+e9Ig+zQByOks1DcfdJqnWqBDo2W7ny8Vu8dK0A8+w3VTsPmGAFKcyXJ8/DNaS0QBu7XJKKmuUPwaQbm0/FfsU5bOKMOCAu0ECK38d3+1lP8sWKYUhXC4ac3z3uQFyqaN1XDbhuDJ4j6Kkcme5OZvwmpHnfDmTCDQPLFWN8+LTS4dd+olgbPZV6z9enZVtbGewjS+M2Q0XdNOgAMnTSOj/IlHTwXbP+RQgFrnaKSIawIaD;20:H2NMyVXUNkiQtaaYuzp1yRixWgfM5nmsRabbV/ve1gJJyvIeIzwyMiIY2X6Mkkw4U+qR6ESq89T/ULNQGDejTzXUcsN8zet6PODtj216jJ8JlNGuh/63WOu15bOHhSkoKVQ+MjqmKI6qcJgpSOPACGZM1VmGogchCJnfAsPmeh8=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86006cd3-4bf8-454e-ab07-08d5792d9ba7
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR04MB1070;
x-ms-traffictypediagnostic: MWHPR04MB1070:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <MWHPR04MB1070062A6E0D028207A543959ACE0@MWHPR04MB1070.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(788757137089)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(944501161)(10201501046)(6055026)(6041288)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR04MB1070;BCL:0;PCL:0;RULEID:;SRVR:MWHPR04MB1070;
x-forefront-prvs: 0590BBCCBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(39380400002)(376002)(346002)(396003)(13464003)(189003)(199004)(59450400001)(6436002)(6506007)(97736004)(478600001)(8676002)(81166006)(72206003)(8936002)(81156014)(76176011)(26005)(25786009)(6246003)(186003)(66066001)(4326008)(55016002)(9686003)(53546011)(39060400002)(102836004)(3280700002)(105586002)(53936002)(33656002)(229853002)(7736002)(2906002)(7416002)(5250100002)(2201001)(14454004)(3846002)(2501003)(6116002)(316002)(68736007)(110136005)(74316002)(54906003)(99286004)(86362001)(3660700001)(305945005)(2900100001)(106356001)(7696005)(2950100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR04MB1070;H:MWHPR04MB1137.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: ptJTDOPC8je9DKxOi5LrHiTXxZGi2n+uHf8aRN/JKDyMlzQGtWq/a/rUKf/mCnuzRyFGPSmbYlzWVd9LwwiReE/3fwn9kCdfyViJVa6r05icr9TSD574rscGpbUkNEZ3NA9wXtqn9iZBdxOB8bZHZqBC8J2e2VfhsOgNpaPabiI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86006cd3-4bf8-454e-ab07-08d5792d9ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2018 13:18:33.3020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1LDJHlJ007939



> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> owner@vger.kernel.org] On Behalf Of Asutosh Das
> Sent: Wednesday, February 21, 2018 6:57 AM
> To: subhashj@codeaurora.org; cang@codeaurora.org;
> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-scsi@vger.kernel.org; Asutosh Das <asutoshd@codeaurora.org>;
> open list <linux-kernel@vger.kernel.org>
> Subject: [PATCH 5/9] scsi: ufs: add reference counting for scsi block requests
> 
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> Currently we call the scsi_block_requests()/scsi_unblock_requests()
> whenever we want to block/unblock scsi requests but as there is no
> reference counting, nesting of these calls could leave us in undesired state
> sometime. Consider following call flow sequence:
> 1. func1() calls scsi_block_requests() but calls func2() before
>    calling scsi_unblock_requests()
> 2. func2() calls scsi_block_requests()
> 3. func2() calls scsi_unblock_requests() 4. func1() calls
> scsi_unblock_requests()
> 
> As there is no reference counting, we will have scsi requests unblocked after
> #3 instead of it to be unblocked only after #4. Though we may not have
> failures seen with this, we might run into some failures in future.
> Better solution would be to fix this by adding reference counting.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 44
> +++++++++++++++++++++++++++++++++++++-------
>  drivers/scsi/ufs/ufshcd.h |  5 +++++
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 7a4df95..987b81b 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -264,6 +264,36 @@ static inline void ufshcd_disable_irq(struct ufs_hba
> *hba)
>  	}
>  }
> 
> +void ufshcd_scsi_unblock_requests(struct ufs_hba *hba) {
> +	unsigned long flags;
> +	bool unblock = false;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	hba->scsi_block_reqs_cnt--;
> +	unblock = !hba->scsi_block_reqs_cnt;
> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> +	if (unblock)
> +		scsi_unblock_requests(hba->host);
> +}
> +EXPORT_SYMBOL(ufshcd_scsi_unblock_requests);
> +
> +static inline void __ufshcd_scsi_block_requests(struct ufs_hba *hba) {
> +	if (!hba->scsi_block_reqs_cnt++)
> +		scsi_block_requests(hba->host);
> +}
> +
> +void ufshcd_scsi_block_requests(struct ufs_hba *hba) {
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	__ufshcd_scsi_block_requests(hba);
> +	spin_unlock_irqrestore(hba->host->host_lock, flags); }
> +EXPORT_SYMBOL(ufshcd_scsi_block_requests);
> +
>  /* replace non-printable or non-ASCII characters with spaces */  static inline
> void ufshcd_remove_non_printable(char *val)  { @@ -1079,12 +1109,12 @@
> static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
>  	 * make sure that there are no outstanding requests when
>  	 * clock scaling is in progress
>  	 */
> -	scsi_block_requests(hba->host);
> +	ufshcd_scsi_block_requests(hba);
>  	down_write(&hba->clk_scaling_lock);
>  	if (ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
>  		ret = -EBUSY;
>  		up_write(&hba->clk_scaling_lock);
> -		scsi_unblock_requests(hba->host);
> +		ufshcd_scsi_unblock_requests(hba);
>  	}
> 
>  	return ret;
> @@ -1093,7 +1123,7 @@ static int ufshcd_clock_scaling_prepare(struct
> ufs_hba *hba)  static void ufshcd_clock_scaling_unprepare(struct ufs_hba
> *hba)  {
>  	up_write(&hba->clk_scaling_lock);
> -	scsi_unblock_requests(hba->host);
> +	ufshcd_scsi_unblock_requests(hba);
>  }
> 
>  /**
> @@ -1413,7 +1443,7 @@ static void ufshcd_ungate_work(struct work_struct
> *work)
>  		hba->clk_gating.is_suspended = false;
>  	}
>  unblock_reqs:
> -	scsi_unblock_requests(hba->host);
> +	ufshcd_scsi_unblock_requests(hba);
>  }
> 
>  /**
> @@ -1469,7 +1499,7 @@ int ufshcd_hold(struct ufs_hba *hba, bool async)
>  		 * work and to enable clocks.
>  		 */
>  	case CLKS_OFF:
> -		scsi_block_requests(hba->host);
> +		__ufshcd_scsi_block_requests(hba);
>  		hba->clk_gating.state = REQ_CLKS_ON;
>  		trace_ufshcd_clk_gating(dev_name(hba->dev),
>  					hba->clk_gating.state);
> @@ -5197,7 +5227,7 @@ static void ufshcd_err_handler(struct work_struct
> *work)
> 
>  out:
>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
> -	scsi_unblock_requests(hba->host);
> +	ufshcd_scsi_unblock_requests(hba);
>  	ufshcd_release(hba);
>  	pm_runtime_put_sync(hba->dev);
>  }
> @@ -5299,7 +5329,7 @@ static void ufshcd_check_errors(struct ufs_hba
> *hba)
>  		/* handle fatal errors only when link is functional */
>  		if (hba->ufshcd_state == UFSHCD_STATE_OPERATIONAL) {
>  			/* block commands from scsi mid-layer */
> -			scsi_block_requests(hba->host);
> +			__ufshcd_scsi_block_requests(hba);
> 
>  			hba->ufshcd_state =
> UFSHCD_STATE_EH_SCHEDULED;
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h index
> 7a2dad3..4385741 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -498,6 +498,7 @@ struct ufs_stats {
>   * @urgent_bkops_lvl: keeps track of urgent bkops level for device
>   * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
>   *  device is known or not.
> + * @scsi_block_reqs_cnt: reference counting for scsi block requests
>   */
>  struct ufs_hba {
>  	void __iomem *mmio_base;
> @@ -690,6 +691,7 @@ struct ufs_hba {
> 
>  	struct rw_semaphore clk_scaling_lock;
>  	struct ufs_desc_size desc_size;
> +	int scsi_block_reqs_cnt;
>  };
> 
>  /* Returns true if clocks can be gated. Otherwise false */ @@ -862,6 +864,9
> @@ int ufshcd_map_desc_id_to_length(struct ufs_hba *hba, enum
> desc_idn desc_id,
> 
>  u32 ufshcd_get_local_unipro_ver(struct ufs_hba *hba);
> 
> +void ufshcd_scsi_block_requests(struct ufs_hba *hba); void
> +ufshcd_scsi_unblock_requests(struct ufs_hba *hba);
> +
>  /* Wrapper functions for safely calling variant operations */  static inline
> const char *ufshcd_get_var_name(struct ufs_hba *hba)  {
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project.

1. The atomic variable and operations could be used for the reference counting.
     This will allow to avoid usage of the locks.
2. Why are the ufshcd_scsi_block_requests/ ufshcd_scsi_unblock_requests 
    functions not defined as static? They are not used outside ufshcd.c.

Regards
Stanislav
