Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A59C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5065208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5065208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389521AbeHAQuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:50:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389430AbeHAQuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:50:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w71EseMm189773
        for <linux-kernel@vger.kernel.org>; Wed, 1 Aug 2018 11:04:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kkbrf1w37-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:04:00 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 1 Aug 2018 09:03:59 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Aug 2018 09:03:54 -0600
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w71F3rTW22741458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Aug 2018 08:03:53 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72840BE058;
        Wed,  1 Aug 2018 09:03:53 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA71BE056;
        Wed,  1 Aug 2018 09:03:52 -0600 (MDT)
Received: from localhost (unknown [9.80.99.86])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed,  1 Aug 2018 09:03:52 -0600 (MDT)
Date:   Wed, 1 Aug 2018 12:03:50 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
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
Subject: Re: [PATCH v3 9/9] powerpc/traps: Add line prefix in
 show_instructions()
References: <20180731145020.14009-1-muriloo@linux.ibm.com>
 <20180731145020.14009-10-muriloo@linux.ibm.com>
 <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e0fe17-8c4e-4ccc-dadf-9b320ca5a1d2@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18080115-0012-0000-0000-00001694BEA3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009467; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068852; UDB=6.00549529; IPR=6.00847167;
 MB=3.00022441; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-01 15:03:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080115-0013-0000-0000-000053E126BA
Message-Id: <20180801150350.GC6022@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808010155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Wed, Aug 01, 2018 at 08:41:15AM +0200, Christophe LEROY wrote:
>
>
> Le 31/07/2018 à 16:50, Murilo Opsfelder Araujo a écrit :
> > Remove "Instruction dump:" line by adding a prefix to display current->comm
> > and current->pid, along with the instructions dump.
> >
> > The prefix can serve as a glue that links the instructions dump to its
> > originator, allowing messages to be interleaved in the logs.
> >
> > Before this patch, a page fault looked like:
> >
> >    pandafault[10524]: segfault (11) at 100007d0 nip 1000061c lr 7fffbd295100 code 2 in pandafault[10000000+10000]
> >    Instruction dump:
> >    4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >    392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> >
> > After this patch, it looks like:
> >
> >    pandafault[10850]: segfault (11) at 100007d0 nip 1000061c lr 7fff9f3e5100 code 2 in pandafault[10000000+10000]
> >    pandafault[10850]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >    pandafault[10850]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> >
> > Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
>
> Does the script scripts/decode_stacktrace.sh also works with this format
> change ?

I've got more feedback from Michael about this.  A better approach would be
having a new show_user_instructions(), a slightly modified version of
show_instructions(), that can be called from within show_signal_msg().

Since _exception_pkey() dies if the exception is in kernel mode, we'll be
safe to call the new show_user_instructions(), without interfering in
scripts/decode_stacktrace.sh.

Cheers
Murilo

