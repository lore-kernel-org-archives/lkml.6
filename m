Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B843ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4D42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4D42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeGRRAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:00:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55240 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727535AbeGRRAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:00:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6IGJ3aM113427
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:21:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ka5mvswrd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 12:21:25 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 18 Jul 2018 10:21:24 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Jul 2018 10:21:20 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6IGLJrq5702118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Jul 2018 09:21:19 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D847BE058;
        Wed, 18 Jul 2018 10:21:19 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0231BBE056;
        Wed, 18 Jul 2018 10:21:18 -0600 (MDT)
Received: from localhost (unknown [9.80.83.190])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 18 Jul 2018 10:21:18 -0600 (MDT)
Date:   Wed, 18 Jul 2018 13:21:16 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/prom_init: remove linux,stdout-package property
References: <20180712171904.18971-1-muriloo@linux.ibm.com>
 <87a7qoq3z2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7qoq3z2.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18071816-0036-0000-0000-00000A113E56
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009387; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062641; UDB=6.00545615; IPR=6.00840496;
 MB=3.00022187; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-18 16:21:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071816-0037-0000-0000-000048258A3C
Message-Id: <20180718162116.GA24748@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807180181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 07:37:37PM +1000, Michael Ellerman wrote:
> Hi Murilo,
> 
> Thanks for the patch.
> 
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> > This property was added in 2004 by
> >
> >     https://github.com/mpe/linux-fullhistory/commit/689fe5072fe9a0dec914bfa4fa60aed1e54563e6
> >
> > and the only use of it, which was already inside `#if 0`, was removed a month
> > later by
> >
> >     https://github.com/mpe/linux-fullhistory/commit/1fbe5a6d90f6cd4ea610737ef488719d1a875de7
> >
> > Fixes: https://github.com/linuxppc/linux/issues/125
> 
> That is going to confuse some scripts that are expecting that to be a
> "Fixes: <some commit>" tag :)
> 
> The proper tag to use there would be "Link:".
> 
> But, I'd prefer we didn't add github issue links to the history, as I'm
> not sure they won't bit-rot eventually. Not because I'm a anti-Microsoft
> conspiracy person but just because it's a repo I set up and manage and
> there's no long term plan for it necessarily.
> 
> > ---
> >  arch/powerpc/kernel/prom_init.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> Including the link here would be ideal, as it means it doesn't end up in
> the commit history, but it does end up in the mail archive. So if we
> ever really need to find it, it should be there.
> 
> cheers

Hi, Michael.

Thanks for reviewing it.  I've sent v2 with your suggestions:

    https://lkml.kernel.org/r/20180718161544.12134-1-muriloo@linux.ibm.com

Cheers

--
Murilo

