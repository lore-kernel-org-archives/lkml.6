Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5257C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D69920837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D69920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLGWAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:00:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbeLGWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 17:00:34 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wB7LoFrt085614
        for <linux-kernel@vger.kernel.org>; Fri, 7 Dec 2018 17:00:33 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p814ggegk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 17:00:32 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <brking@linux.vnet.ibm.com>;
        Fri, 7 Dec 2018 22:00:32 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 7 Dec 2018 22:00:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wB7M0Smt22282420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 22:00:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40D40B2065;
        Fri,  7 Dec 2018 22:00:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCD79B2067;
        Fri,  7 Dec 2018 22:00:27 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.10.86.62])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Dec 2018 22:00:27 +0000 (GMT)
Subject: Re: [PATCH] scsi: qla2xxx: disabling pci error handler early
To:     Anatoliy Glagolev <glagolig@gmail.com>, aglagolev@purestorage.com,
        qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        kmahlkuc@linux.vnet.ibm.com
References: <1544212602-28085-1-git-send-email-glagolig@gmail.com>
From:   Brian King <brking@linux.vnet.ibm.com>
Date:   Fri, 7 Dec 2018 16:00:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1544212602-28085-1-git-send-email-glagolig@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18120722-0060-0000-0000-000002E0C96E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010190; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01128469; UDB=6.00586227; IPR=6.00908601;
 MB=3.00024588; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-07 22:00:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120722-0061-0000-0000-000047761F86
Message-Id: <d7b867f3-22d1-855d-86ce-43089e46ca6a@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=840 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812070175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2018 01:56 PM, Anatoliy Glagolev wrote:
> qla2x00_disable_board_on_pci_error and pcie error handlers may run
> in parallel. Specifically, I observed qla2xxx_pci_slot_reset running
> at around the same moment as qla2x00_disable_board_on_pci_error.
> If scsi_qla_host_t or qla_hw_data structs are removed before an error
> handler completes, the handler crashes.
> 
> This patch disables pcie error handling early in
> qla2x00_disable_board_on_pci_error and in other paths that remove
> those structs.

While this may fix this issue for PCIe AER, I think you'll still have
the exposure for EEH errors on a Power system, since we don't have
the pci_enable_pcie_error_reporting API wired up to do anything,
nor do we have much ability to do anything with it since its an
attribute of the hardware.

Is there a way to fix this that doesn't break Power?

Thanks,

Brian

> 
> Signed-off-by: Anatoliy Glagolev <glagolig@gmail.com>
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index e881fce..b8f277a 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -2775,9 +2775,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  			return ret;
>  	}
> 
> -	/* This may fail but that's ok */
> -	pci_enable_pcie_error_reporting(pdev);
> -
>  	ha = kzalloc(sizeof(struct qla_hw_data), GFP_KERNEL);
>  	if (!ha) {
>  		ql_log_pci(ql_log_fatal, pdev, 0x0009,
> @@ -3039,6 +3036,9 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  		goto probe_hw_failed;
>  	}
> 
> +	/* This may fail but that's ok */
> +	pci_enable_pcie_error_reporting(pdev);
> +
>  	pci_set_drvdata(pdev, base_vha);
>  	set_bit(PFLG_DRIVER_PROBING, &base_vha->pci_flags);
> 
> @@ -3400,6 +3400,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  		kthread_stop(t);
>  	}
> 
> +	pci_disable_pcie_error_reporting();
> +
>  	qla2x00_free_device(base_vha);
>  	scsi_host_put(base_vha->host);
>  	/*
> @@ -3625,6 +3627,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  	}
>  	qla2x00_wait_for_hba_ready(base_vha);
> 
> +	pci_disable_pcie_error_reporting(pdev);
> +
>  	qla2x00_wait_for_sess_deletion(base_vha);
> 
>  	/*
> @@ -3698,8 +3702,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  	pci_release_selected_regions(ha->pdev, ha->bars);
>  	kfree(ha);
> 
> -	pci_disable_pcie_error_reporting(pdev);
> -
>  	pci_disable_device(pdev);
>  }
> 
> @@ -5826,6 +5828,8 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
>  		return;
>  	}
> 
> +	pci_disable_pcie_error_reporting(pdev);
> +
>  	qla2x00_wait_for_sess_deletion(base_vha);
> 
>  	set_bit(UNLOADING, &base_vha->dpc_flags);
> @@ -5866,7 +5870,6 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
>  	qla2x00_unmap_iobases(ha);
> 
>  	pci_release_selected_regions(ha->pdev, ha->bars);
> -	pci_disable_pcie_error_reporting(pdev);
>  	pci_disable_device(pdev);
> 
>  	/*
> 


-- 
Brian King
Power Linux I/O
IBM Linux Technology Center

