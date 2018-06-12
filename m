Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DA55C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D08F2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 14:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D08F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934197AbeFLOJI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 10:09:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934130AbeFLOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 10:08:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5CDwlFR033920
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:08:53 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jje8awcvt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 10:08:53 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Tue, 12 Jun 2018 08:08:52 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:08:49 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5CE8msm42532996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:08:48 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3EF6BE056;
        Tue, 12 Jun 2018 08:08:48 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3AE5BE051;
        Tue, 12 Jun 2018 08:08:47 -0600 (MDT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.159.203])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 12 Jun 2018 08:08:47 -0600 (MDT)
Subject: Re: [PATCH] scsi: qla4xxx: add error handling for try_module_get
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     QLogic-Storage-Upstream@qlogic.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jun 2018 07:08:45 -0700
In-Reply-To: <1528778910-42113-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528778910-42113-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18061214-0020-0000-0000-00000E2B2111
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009175; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01045907; UDB=6.00535611; IPR=6.00824885;
 MB=3.00021602; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-12 14:08:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061214-0021-0000-0000-000061E7CE3E
Message-Id: <1528812525.3171.1.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 12:48 +0800, Zhouyang Jia wrote:
> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling try_module_get.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/scsi/qla4xxx/ql4_os.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/qla4xxx/ql4_os.c
> b/drivers/scsi/qla4xxx/ql4_os.c
> index 0e13349..6b677ab 100644
> --- a/drivers/scsi/qla4xxx/ql4_os.c
> +++ b/drivers/scsi/qla4xxx/ql4_os.c
> @@ -7687,7 +7687,10 @@ static int qla4xxx_sysfs_ddb_logout_sid(struct
> iscsi_cls_session *cls_sess)
>  	 * to be seamless without actually destroying the
>  	 * session
>  	 **/
> -	try_module_get(qla4xxx_iscsi_transport.owner);
> +	if (!try_module_get(qla4xxx_iscsi_transport.owner))
> +		ql4_printk(KERN_WARNING, ha,
> +			"%s: cannot get module.\n", __func__);
> +

This isn't error handling at all.  If try_module_get() fails it means
you're about to get the text segment freed from underneath you if the
code can be executed concurrently with the module_exit function.  The
comment implies that qla4xxx operates with a zero module use count even
when there are logged in sessions, so module_exit can race with logout
(or indeed any other userspace initiated function).  This means that
the entire module reference counting of qla4xxx looks to be racy and
wrong.  Can we get a description of what the expected theoretical model
is so we can validate (or invalidate) this theory?

James



