Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C8C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB6620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB6620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbeGYWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:04:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730484AbeGYWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:04:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PKmdiX098109
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:51:18 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kexfvcvjb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:51:17 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 25 Jul 2018 16:51:17 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 16:51:12 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PKpBG15112106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 20:51:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C032DAC059;
        Wed, 25 Jul 2018 16:51:55 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E76AC05E;
        Wed, 25 Jul 2018 16:51:54 -0400 (EDT)
Received: from localhost (unknown [9.85.190.157])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 16:51:54 -0400 (EDT)
Date:   Wed, 25 Jul 2018 17:51:08 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org, "Tobin C . Harding" <me@tobin.cc>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] powerpc/traps: Show instructions on exceptions
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-8-muriloo@linux.ibm.com>
 <20180725180134.Horde.BdhyE2b-TXhoVB7W8bsBhg1@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180725180134.Horde.BdhyE2b-TXhoVB7W8bsBhg1@messagerie.si.c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18072520-0052-0000-0000-0000031371B8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009427; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066079; UDB=6.00547685; IPR=6.00843939;
 MB=3.00022324; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 20:51:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072520-0053-0000-0000-00005D7D8D6C
Message-Id: <20180725205108.GE23643@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Wed, Jul 25, 2018 at 06:01:34PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
> 
> > Move show_instructions() declaration to arch/powerpc/include/asm/stacktrace.h
> > and include asm/stracktrace.h in arch/powerpc/kernel/process.c, which
> > contains
> > the implementation.
> > 
> > Modify show_instructions() not to call __kernel_text_address(), allowing
> > userspace instruction dump.  probe_kernel_address(), which returns -EFAULT if
> > something goes wrong, is still being called.
> > 
> > Call show_instructions() in arch/powerpc/kernel/traps.c to dump
> > instructions at
> > faulty location, useful to debugging.
> 
> Shouldn't this part be in a second patch ?

Makes sense.  Perhaps I should split this patch in two: one to remove
__kernel_text_address() check in show_instructions(), and another to
call show_instructions() in show_signal_msg().

> Wouldn't it be better to also see regs in addition if we want to use this to
> understand what happened ?
> So you could call show_regs() instead of show_instructions() ?

I see that show_regs() prints more information and calls
show_instructions() at the end if in privileged state.

I'm not sure about which situations we might want to call show_regs() -
and display a bunch of information - or just dump instructions for some
signals.

Isn't calling show_regs() in this case considered overkill?

Cheers
Murilo

