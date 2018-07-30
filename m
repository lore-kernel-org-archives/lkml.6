Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF6DC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388BD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388BD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeGaAzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:55:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732038AbeGaAzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:55:06 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UNEpLP091665
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:17:47 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kj85t87ub-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 19:17:47 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Mon, 30 Jul 2018 19:17:46 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 19:17:42 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UNHfYD10944772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 23:17:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBFB2112063;
        Mon, 30 Jul 2018 19:17:25 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF94E112062;
        Mon, 30 Jul 2018 19:17:24 -0400 (EDT)
Received: from localhost (unknown [9.80.210.238])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jul 2018 19:17:24 -0400 (EDT)
Date:   Mon, 30 Jul 2018 20:17:38 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Joe Perches <joe@perches.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
 <20180730152838.GA23704@kermit-br-ibm-com>
 <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180730183047.Horde.g9hQ_3EXmF6St0upNs2DDw1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18073023-0064-0000-0000-00000331AB7F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009459; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068241; UDB=6.00549135; IPR=6.00846371;
 MB=3.00022414; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 23:17:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073023-0065-0000-0000-00003A2027FF
Message-Id: <20180730231738.GA20351@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Mon, Jul 30, 2018 at 06:30:47PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>
> > Hi, Christophe.
> >
> > On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
> > > Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> > >
> > > > Simplify the message format by using REG_FMT as the register format.  This
> > > > avoids having two different formats and avoids checking for MSR_64BIT.
> > >
> > > Are you sure it is what we want ?
> >
> > Yes.
> >
> > > Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?
> >
> > In fact, this changes how many zeroes are prefixed when displaying the
> > registers
> > (%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kernel:
>
> Indeed that's what I suspected. What is the real benefit of this change ?
> Why not keep the current format for 32bits userspace ? All those leading
> zeroes are pointless to me.

One of the benefits is simplifying the code by removing some checks.  Another is
deduplicating almost identical format strings in favor of a unified one.

After reading Joe's comment [1], %px seems to be the format we're looking for.
An extract from Documentation/core-api/printk-formats.rst:

  "%px is functionally equivalent to %lx (or %lu). %px is preferred because it
  is more uniquely grep'able."

So I guess we don't need to worry about the format (%016lx vs. %08lx), let's
just use %px, as per the guideline.

[1] https://lore.kernel.org/lkml/26f07092cdde378ebb42c1034badde1b56521c36.camel@perches.com/

Cheers
Murilo

