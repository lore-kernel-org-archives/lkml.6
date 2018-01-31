Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeAaHjM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:39:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43144 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbeAaHjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:39:09 -0500
X-IronPort-AV: E=Sophos;i="5.46,438,1511798400";
   d="scan'208";a="70796737"
From: Avri Altman <Avri.Altman@wdc.com>
To: Asutosh Das <asutoshd@codeaurora.org>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
Thread-Topic: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
Thread-Index: AQHTmYaHcSUT5SYu3EOc2oEnVQ6gu6ONmZLw
Date: Wed, 31 Jan 2018 07:39:06 +0000
Message-ID: <DM5PR04MB1085C5039CA525D6FB77DBE3FCFB0@DM5PR04MB1085.namprd04.prod.outlook.com>
References: <1517288066-13171-1-git-send-email-asutoshd@codeaurora.org>
In-Reply-To: <1517288066-13171-1-git-send-email-asutoshd@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR04MB1002;7:06inITYU7H2K4fnJ6Mw1lIx9GPeQE0trJtqa+dWW7z32uiBRF3Wnz+ZpMOdk1Z1oZPYD+UPdsx/8Z/lPhyRE0yzgDJoMvKuTHcRDcSwOQD/1IwJVOouqLxZNFqd0zU75t4cT/F23qNHMPmdKvJgcFvHVWfrMyt4RnTjp6VMVFnhSft7Ep4IiNuP80YUqxQx445ueHkhbKWLD42pIePQni7Mjuh3sHMISsK2X+chvnQnmyrhUwIC4yiW0Xfjca41F;20:Ai7nRc14xwSkBkpg9YWf/Z2JF9O1bl90mKsWZOWAt9WbHQ9qgM4Ylslt818A1WncDRxRFdLSEP3B17N/l5QocobfFjXM0hx77Wn0BEw/6ALZTBOLEgisXyh4z8/TCjhbqH3mPhk5iaqkZbtTbZxzN24GR9VsWNBKqT72irJ4o2w=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 07a0d53b-9a6b-44c3-5d50-08d5687db53f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM5PR04MB1002;
x-ms-traffictypediagnostic: DM5PR04MB1002:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM5PR04MB10028C6E9A10D1B273D783AFFCFB0@DM5PR04MB1002.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(104084551191319)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041288)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR04MB1002;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB1002;
x-forefront-prvs: 056929CBB8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(39380400002)(376002)(13464003)(199004)(189003)(7736002)(86362001)(53936002)(9686003)(6436002)(55016002)(33656002)(74316002)(7416002)(229853002)(2900100001)(81156014)(81166006)(66066001)(106356001)(8936002)(8676002)(105586002)(2906002)(99286004)(110136005)(316002)(54906003)(97736004)(5660300001)(39060400002)(6116002)(14454004)(3660700001)(25786009)(68736007)(7696005)(76176011)(4326008)(2501003)(59450400001)(26005)(102836004)(478600001)(2201001)(3846002)(305945005)(6246003)(2950100002)(186003)(6506007)(53546011)(72206003)(3280700002)(77096007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB1002;H:DM5PR04MB1085.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Eh9G8Otg6daIpPXu4PN7NkIuI/ghFHTd7SkEfjj8twyqFiMZuWNKHQgQ68zsTX5soDdKONkgkWcv1tKTir/RSQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a0d53b-9a6b-44c3-5d50-08d5687db53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2018 07:39:06.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1002
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0V7dJfJ012272

Hi,
Can you elaborate how this can even happen?
Isn't the interrupt aggregation capability should attend for those cases?

Thanks,
Avri

> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org [mailto:linux-scsi-
> owner@vger.kernel.org] On Behalf Of Asutosh Das
> Sent: Tuesday, January 30, 2018 6:54 AM
> To: subhashj@codeaurora.org; cang@codeaurora.org;
> vivek.gautam@codeaurora.org; rnayak@codeaurora.org;
> vinholikatti@gmail.com; jejb@linux.vnet.ibm.com;
> martin.petersen@oracle.com
> Cc: linux-scsi@vger.kernel.org; Venkat Gopalakrishnan
> <venkatg@codeaurora.org>; Asutosh Das <asutoshd@codeaurora.org>; open
> list <linux-kernel@vger.kernel.org>
> Subject: [PATCH 1/1] scsi: ufs: make sure all interrupts are processed
> 
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> 
> As multiple requests are submitted to the ufs host controller in parallel there
> could be instances where the command completion interrupt arrives later for a
> request that is already processed earlier as the corresponding doorbell was
> cleared when handling the previous interrupt. Read the interrupt status in a
> loop after processing the received interrupt to catch such interrupts and handle
> it.
> 
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c index
> 8af2af3..58d81de 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -5357,19 +5357,30 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
>  	u32 intr_status, enabled_intr_status;
>  	irqreturn_t retval = IRQ_NONE;
>  	struct ufs_hba *hba = __hba;
> +	int retries = hba->nutrs;
> 
>  	spin_lock(hba->host->host_lock);
>  	intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> -	enabled_intr_status =
> -		intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
> 
> -	if (intr_status)
> -		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
> +	/*
> +	 * There could be max of hba->nutrs reqs in flight and in worst case
> +	 * if the reqs get finished 1 by 1 after the interrupt status is
> +	 * read, make sure we handle them by checking the interrupt status
> +	 * again in a loop until we process all of the reqs before returning.
> +	 */
> +	do {
> +		enabled_intr_status =
> +			intr_status & ufshcd_readl(hba,
> REG_INTERRUPT_ENABLE);
> +		if (intr_status)
> +			ufshcd_writel(hba, intr_status,
> REG_INTERRUPT_STATUS);
> +		if (enabled_intr_status) {
> +			ufshcd_sl_intr(hba, enabled_intr_status);
> +			retval = IRQ_HANDLED;
> +		}
> +
> +		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
> +	} while (intr_status && --retries);
> 
> -	if (enabled_intr_status) {
> -		ufshcd_sl_intr(hba, enabled_intr_status);
> -		retval = IRQ_HANDLED;
> -	}
>  	spin_unlock(hba->host->host_lock);
>  	return retval;
>  }
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
> Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux
> Foundation Collaborative Project.
