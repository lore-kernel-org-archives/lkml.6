Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389FEC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A762075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A762075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJZToO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:44:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727417AbeJZToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:44:13 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QAxO2H112989
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:07:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nc116t41e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:07:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 26 Oct 2018 12:07:29 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 26 Oct 2018 12:07:20 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9QB7J2C6947122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 11:07:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98C204C04A;
        Fri, 26 Oct 2018 11:07:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D24C54C040;
        Fri, 26 Oct 2018 11:07:12 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.204.79])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 26 Oct 2018 11:07:12 +0000 (GMT)
Date:   Fri, 26 Oct 2018 12:07:09 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>, linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        SH-Linux <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
 <20181025093833.GA23607@rapoport-lnx>
 <CAL_JsqL62ttsGSbE1BS5v-mX3pKE-p_HyvuZD6nB+GUbQyetzg@mail.gmail.com>
 <20181025172935.GA27364@rapoport-lnx>
 <CAL_JsqJrMq+QHvuOsqEdCFchmXsd4s2XKUD_TboKzeEQprJvjg@mail.gmail.com>
 <1bb3bd63-a88e-b668-ea36-f0f985c0e2b1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb3bd63-a88e-b668-ea36-f0f985c0e2b1@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18102611-4275-0000-0000-000002D426A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102611-4276-0000-0000-000037E03A3A
Message-Id: <20181026110708.GA3814@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810260097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:07:13PM -0700, Florian Fainelli wrote:
> On 10/25/18 2:13 PM, Rob Herring wrote:
> > On Thu, Oct 25, 2018 at 12:30 PM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>
> >> On Thu, Oct 25, 2018 at 08:15:15AM -0500, Rob Herring wrote:
> >>> +Ard
> >>>
> >>> On Thu, Oct 25, 2018 at 4:38 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >>>>
> >>>> On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
> >>>>> On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi all,
> >>>>>>
> >>>>>> While investigating why ARM64 required a ton of objects to be rebuilt
> >>>>>> when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> >>>>>> because we define __early_init_dt_declare_initrd() differently and we do
> >>>>>> that in arch/arm64/include/asm/memory.h which gets included by a fair
> >>>>>> amount of other header files, and translation units as well.
> >>>>>
> >>>> I think arm64 does not have to redefine __early_init_dt_declare_initrd().
> >>>> Something like this might be just all we need (completely untested,
> >>>> probably it won't even compile):

[ ... ]
 
> FWIW, I am extracting the ARM implementation that parses the initrd
> early command line parameter and the "setup" code doing the page
> boundary alignment and memblock checking into a helper into lib/ that
> other architectures can re-use. So far, this removes the need for
> unicore32, arc and arm to duplicate essentially the same logic.

Presuming you are going to need asm-generic/initrd.h for that as well,
using override for __early_init_dt_declare_initrd in arm64 version of
initrd.h might be the simplest option.

> -- 
> Florian
> 

-- 
Sincerely yours,
Mike.

