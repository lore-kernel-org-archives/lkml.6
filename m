Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F68C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312A320844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312A320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGYUyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:54:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730051AbeGYUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:54:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PJdKp3031560
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:41:14 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ketx2v3qq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:41:14 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 25 Jul 2018 15:41:13 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:41:09 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PJf81P1245560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 19:41:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD487AC062;
        Wed, 25 Jul 2018 15:41:52 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A925AC05F;
        Wed, 25 Jul 2018 15:41:52 -0400 (EDT)
Received: from localhost (unknown [9.85.190.157])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 15:41:51 -0400 (EDT)
Date:   Wed, 25 Jul 2018 16:41:05 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Gustavo Romero <gromero@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH 6/7] powerpc/traps: Print signal name for unhandled
 signals
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <20180724192720.32417-7-muriloo@linux.ibm.com>
 <0364bdc4-ddf9-85de-1128-8fc8791d63dd@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0364bdc4-ddf9-85de-1128-8fc8791d63dd@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18072519-0064-0000-0000-0000032F999E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009426; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066056; UDB=6.00547671; IPR=6.00843915;
 MB=3.00022322; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 19:41:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072519-0065-0000-0000-00003A11B8EF
Message-Id: <20180725194105.GB23643@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gustavo.

On Wed, Jul 25, 2018 at 12:19:00PM -0300, Gustavo Romero wrote:
> Hi Murilo,
> 
> LGTM.
> 
> Just a comment:
> 
> On 07/24/2018 04:27 PM, Murilo Opsfelder Araujo wrote:
> > This adds a human-readable name in the unhandled signal message.
> > 
> > Before this patch, a page fault looked like:
> > 
> >      Jul 11 16:04:11 localhost kernel: pandafault[6303]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00007fff93c55100 code 2 in pandafault[10000000+10000]
> > 
> > After this patch, a page fault looks like:
> > 
> >      Jul 11 18:14:48 localhost kernel: pandafault[6352]: segfault (11) at 000000013a2a09f8 nip 000000013a2a086c lr 00007fffb63e5100 code 2 in pandafault[13a2a0000+10000]
> 
> I _really_ don't want to bikeshed here, but I vouch for keeping the
> "unhandled" word before the signal name, like:
> 
> [...] pandafault[6352]: unhandled segfault (11) at 000000013a2a09f8 nip [...]
> 
> because the issue reported here is really that we got a segfault _and_
> there was no handler to catch it.

Either way works for me.

> But feel free to wait for additional comments to decide it.

Sure.  I intend to wait a couple of weeks to respin the series based on
community feedback.

Cheers
Murilo

