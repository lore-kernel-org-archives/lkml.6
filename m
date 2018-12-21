Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C384C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD83421917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732612AbeLUP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:29:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731126AbeLUP3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:29:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBLFNlLf001107
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:29:53 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ph20gtptg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:29:53 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.ibm.com>;
        Fri, 21 Dec 2018 15:29:52 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Dec 2018 15:29:50 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBLFTmq420316288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Dec 2018 15:29:49 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B17F78068;
        Fri, 21 Dec 2018 15:29:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 713A87805F;
        Fri, 21 Dec 2018 15:29:47 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.80.209.37])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 Dec 2018 15:29:47 +0000 (GMT)
Subject: Re: [PATCH 03/10] SCSI: fcoe: convert to use BUS_ATTR_WO
From:   James Bottomley <jejb@linux.ibm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Johannes Thumshirn <jth@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Date:   Fri, 21 Dec 2018 07:29:45 -0800
In-Reply-To: <20181221075442.17109-4-gregkh@linuxfoundation.org>
References: <20181221075442.17109-1-gregkh@linuxfoundation.org>
         <20181221075442.17109-4-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18122115-0016-0000-0000-00000967AA11
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010261; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01134999; UDB=6.00590167; IPR=6.00915171;
 MB=3.00024787; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-21 15:29:52
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122115-0017-0000-0000-0000417D0C6E
Message-Id: <1545406185.2765.8.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-21_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812210119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[scsi list cc added]
On Fri, 2018-12-21 at 08:54 +0100, Greg Kroah-Hartman wrote:
> We are trying to get rid of BUS_ATTR() and the usage of that in the
> fcoe driver can be trivially converted to use BUS_ATTR_WO(), so use
> that instead.
> 
> At the same time remove a unneeded EXPORT_SYMBOL() marking for the
> sysfs callback function we are renaming, no idea of how that got into
> the tree...

The EXPORT_SYMBOL removal is fine, but

[...]
> --- a/include/scsi/libfcoe.h
> +++ b/include/scsi/libfcoe.h
> @@ -405,10 +405,8 @@ int fcoe_transport_attach(struct fcoe_transport
> *ft);
>  int fcoe_transport_detach(struct fcoe_transport *ft);
> 
>  /* sysfs store handler for ctrl_control interface */
> -ssize_t fcoe_ctlr_create_store(struct bus_type *bus,
> -			       const char *buf, size_t count);
> -ssize_t fcoe_ctlr_destroy_store(struct bus_type *bus,
> -				const char *buf, size_t count);
> +ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
> size_t count);
> +ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
> size_t count);

You're really damaging our prefix namespace here.  It looks like the
ctlr_ name is a farly recent addition for sysfs (only myra/b) use it in
SCSI but it's inviting symbol clashes.

Since the XXX_ATTR_RO seem to be defined with only local file usage in
mind, I think we need static functions to shim the problem, like below
(provided this is the only instance, because if it isn't, you probably
need a XXX_ATTR_WO_prefix() macro)

James

---

diff --git a/drivers/scsi/fcoe/fcoe_sysfs.c b/drivers/scsi/fcoe/fcoe_sysfs.c
index 5c8310bade61..88e5c26ce381 100644
--- a/drivers/scsi/fcoe/fcoe_sysfs.c
+++ b/drivers/scsi/fcoe/fcoe_sysfs.c
@@ -671,8 +671,20 @@ static const struct device_type fcoe_fcf_device_type = {
 	.release = fcoe_fcf_device_release,
 };
 
-static BUS_ATTR(ctlr_create, S_IWUSR, NULL, fcoe_ctlr_create_store);
-static BUS_ATTR(ctlr_destroy, S_IWUSR, NULL, fcoe_ctlr_destroy_store);
+static ssize_t ctlr_create_store(struct bus_type *bus, const char *buf,
+				 size_t count)
+{
+	return fcoe_ctlr_create_store(bus, buf, count);
+}
+
+static ssize_t ctlr_destroy_store(struct bus_type *bus, const char *buf,
+				  size_t count)
+{
+	return fcoe_ctlr_destroy_store(bus, buf, count);
+}
+
+static BUS_ATTR_WO(ctlr_create);
+static BUS_ATTR_WO(ctlr_destroy);
 
 static struct attribute *fcoe_bus_attrs[] = {
 	&bus_attr_ctlr_create.attr,

