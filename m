Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55398C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2A2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbfAWMzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:55:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbfAWMzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:55:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NCnKQM067334
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:55:10 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q6qwat7n1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 07:55:10 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 23 Jan 2019 12:55:08 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Jan 2019 12:55:06 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0NCt5dB45416546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 12:55:05 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AFB442041;
        Wed, 23 Jan 2019 12:55:05 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE79342049;
        Wed, 23 Jan 2019 12:55:04 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.208])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Jan 2019 12:55:04 +0000 (GMT)
Date:   Wed, 23 Jan 2019 14:55:03 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, linux-kernel@vger.kernel.org,
        ogabbay@habana.ai
Subject: Re: [PATCH 01/15] habanalabs: add skeleton driver
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <20190123000057.31477-2-oded.gabbay@gmail.com>
 <20190123122804.GB2194@rapoport-lnx>
 <20190123124004.GA19703@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123124004.GA19703@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012312-0012-0000-0000-000002EBDBF5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012312-0013-0000-0000-000021230B53
Message-Id: <20190123125502.GF4747@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=887 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901230096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 01:40:04PM +0100, Greg KH wrote:
> On Wed, Jan 23, 2019 at 02:28:05PM +0200, Mike Rapoport wrote:
> > On Wed, Jan 23, 2019 at 02:00:43AM +0200, Oded Gabbay wrote:
> > > +/**
> > > + * hl_device_release - release function for habanalabs device
> > > + *
> > > + * @inode: pointer to inode structure
> > > + * @filp: pointer to file structure
> > > + *
> > > + * Called when process closes an habanalabs device
> > > + */
> > 
> > It's nice to see docs coming along with the codei
> > I have some comments for the formatting.
> > 
> > kernel-doc won't be happy about missing return value descriptions, and
> > although they are sometimes redundant or too obvious their absence makes
> > 'make V=1 htmldocs' really noisy.
> > 
> > In general, it would be nice if you could link hanabnalabs driver
> > kernel-doc somewhere in Documentation/ run 'make V=1 htmldocs'.
> > 
> > > +static int hl_device_release(struct inode *inode, struct file *filp)
> 
> There's no need for kerneldoc comments for static functions, as no one
> can call them and they are not part of any api.
> 
> So what would be better here is to just drop the /** line and use /*

Maybe it'd make sense to use /* for most of the comments in this driver as
there are kernel-doc formatting issues in non-static functions as well, I
was just too lazy to go over all of them.
 
> thanks,
> 
> greg k-h
> 

-- 
Sincerely yours,
Mike.

