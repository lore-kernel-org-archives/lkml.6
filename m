Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE8B160A325
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E39208A1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 15:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E39208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeG3REU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:04:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726787AbeG3RET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:04:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6UFOO1g003649
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:28:49 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kj49db7jj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 11:28:49 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Mon, 30 Jul 2018 09:28:48 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Jul 2018 09:28:43 -0600
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6UFSgBX62521376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Jul 2018 08:28:42 -0700
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58DCB78060;
        Mon, 30 Jul 2018 09:28:42 -0600 (MDT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBB1F7805C;
        Mon, 30 Jul 2018 09:28:41 -0600 (MDT)
Received: from localhost (unknown [9.80.210.238])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jul 2018 09:28:41 -0600 (MDT)
Date:   Mon, 30 Jul 2018 12:28:38 -0300
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
Subject: Re: [PATCH v2 04/10] powerpc/traps: Use REG_FMT in show_signal_msg()
References: <20180727145811.12334-1-muriloo@linux.ibm.com>
 <20180727145811.12334-5-muriloo@linux.ibm.com>
 <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180727184023.Horde.KRXPzZpG18uxt_B9sy_FBg5@messagerie.si.c-s.fr>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18073015-8235-0000-0000-00000DDB5D72
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009457; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068120; UDB=6.00549051; IPR=6.00846215;
 MB=3.00022407; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-30 15:28:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073015-8236-0000-0000-000042130400
Message-Id: <20180730152838.GA23704@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=870 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807300168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Fri, Jul 27, 2018 at 06:40:23PM +0200, LEROY Christophe wrote:
> Murilo Opsfelder Araujo <muriloo@linux.ibm.com> a écrit :
>
> > Simplify the message format by using REG_FMT as the register format.  This
> > avoids having two different formats and avoids checking for MSR_64BIT.
>
> Are you sure it is what we want ?

Yes.

> Won't it change the behaviour for a 32 bits app running on a 64bits kernel ?

In fact, this changes how many zeroes are prefixed when displaying the registers
(%016lx vs. %08lx format).  For example, 32-bits userspace, 64-bits kernel:

before this series:
  [66475.002900] segv[4599]: unhandled signal 11 at 00000000 nip 10000420 lr 0fe61854 code 1

after this series:
  [   73.414535] segv[3759]: segfault (11) at 0000000000000000 nip 0000000010000420 lr 000000000fe61854 code 1 in segv[10000000+10000]
  [   73.414641] segv[3759]: code: 4e800421 80010014 38210010 7c0803a6 4bffff30 9421ffd0 93e1002c 7c3f0b78
  [   73.414665] segv[3759]: code: 39200000 913f001c 813f001c 39400001 <91490000> 39200000 7d234b78 397f0030

Have you spotted any other behaviour change?

Cheers
Murilo

