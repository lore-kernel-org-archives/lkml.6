Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC05FC10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AC021925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfBOR6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:58:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbfBOR6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:58:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FHtHZC021436
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 12:58:34 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qp1rbhaf9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 12:58:34 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 15 Feb 2019 17:58:31 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 17:58:28 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1FHwR7L2228508
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 17:58:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D75A52052;
        Fri, 15 Feb 2019 17:58:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.92.223])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0D1C25204F;
        Fri, 15 Feb 2019 17:58:25 +0000 (GMT)
Subject: Re: [PATCH v3] x86/ima: require signed kernel modules
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Date:   Fri, 15 Feb 2019 12:58:15 -0500
In-Reply-To: <20190215170144.GH11489@garbanzo.do-not-panic.com>
References: <1550249418-7986-1-git-send-email-zohar@linux.ibm.com>
         <20190215170144.GH11489@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19021517-0020-0000-0000-000003174E94
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021517-0021-0000-0000-000021688570
Message-Id: <1550253495.7468.0.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=888 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-02-15 at 09:01 -0800, Luis Chamberlain wrote:
> On Fri, Feb 15, 2019 at 11:50:18AM -0500, Mimi Zohar wrote:
> > Have the IMA architecture specific policy require signed kernel modules
> > on systems with secure boot mode enabled; and coordinate the different
> > signature verification methods, so only one signature is required.
> > 
> > Requiring appended kernel module signatures may be configured, enabled
> > on the boot command line, or with this patch enabled in secure boot
> > mode.  This patch defines set_module_sig_enforced().
> > 
> > To coordinate between appended kernel module signatures and IMA
> > signatures, only define an IMA MODULE_CHECK policy rule if
> > CONFIG_MODULE_SIG is not enabled.  A custom IMA policy may still define
> > and require an IMA signature.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks!

