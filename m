Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D630C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B2320855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfBUMzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:55:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfBUMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:55:11 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LCn3YP026244
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:55:10 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qsv93gdu9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 07:55:10 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Thu, 21 Feb 2019 12:55:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 12:55:06 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LCt4fe14680262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 12:55:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE47A405C;
        Thu, 21 Feb 2019 12:55:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44BAAA4062;
        Thu, 21 Feb 2019 12:55:04 +0000 (GMT)
Received: from osiris (unknown [9.152.212.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Feb 2019 12:55:04 +0000 (GMT)
Date:   Thu, 21 Feb 2019 13:55:02 +0100
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI command
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
 <alpine.LFD.2.21.1901301912380.2372@schleppi>
 <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
 <20190221131240.0ab463d1.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190221131240.0ab463d1.cohuck@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19022112-4275-0000-0000-000003123C78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022112-4276-0000-0000-000038207053
Message-Id: <20190221125502.GB4221@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 01:12:40PM +0100, Cornelia Huck wrote:
> On Thu, 21 Feb 2019 11:42:25 +0100
> Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
> > On 30.01.19 19:32, Sebastian Ott wrote:
> > > On Wed, 30 Jan 2019, Tony Krowiak wrote:  
> 
> > >>  /*
> > >> +* A config change has happened, Force an ap bus rescan.
> > >> +*/
> > >> +void ap_bus_cfg_chg(void)
> > >> +{
> > >> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> > >> +
> > >> +	ap_bus_force_rescan();
> > >> +}
> > >> +EXPORT_SYMBOL(ap_bus_cfg_chg);  
> > > There is no need for the export symbol - you don't call that function
> > > from module code.  
> > That's what I have learned now: You don't need to export a symbol
> > as long as the symbol is only called in static code parts of the kernel.
> > But you need to export it when it is intended to be used by code
> > which sits in a kernel module. So now the big question:
> > How does a provider of a function in the kernel know, if the caller is in static
> > code or in module code ? And ... maybe this may even change over
> > the time. So my recommendation is to always export the symbol with
> > the EXPORT_SYMBOL macro. This way you don't need to change the
> > code providing a function when the caller code changes or additional
> > code uses the symbol.
> > 
> > Other opinions ?
> 
> Well, if you know it will be called from module code in upcoming
> patches, export it. If not, I consider it the choice of the maintainer.
> You can easily add the export later on, if needed, anyway, and I don't
> consider changing the code a problem.
> 
> In this particular case, both exporting and not exporting looked like
> reasonable choices to me.

The number of exported symbols should be as small as possible. Each
exported symbol eats up extra memory for meta information, plus I
really do not want to deal with semi-automated bots sending patches to
remove not needed exported symbols.

You can check usage of exported symbols with "make export_report".

