Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC033C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2C122448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C122448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHJUjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:39:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727462AbeHJUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:39:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7AI01kI124634
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:08:12 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kscgdy8rm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:08:11 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Fri, 10 Aug 2018 14:08:10 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 Aug 2018 14:08:05 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7AI84uv66125894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Aug 2018 18:08:04 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35EBFAC065;
        Fri, 10 Aug 2018 14:08:31 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71D07AC060;
        Fri, 10 Aug 2018 14:08:30 -0400 (EDT)
Received: from localhost (unknown [9.80.83.42])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Aug 2018 14:08:30 -0400 (EDT)
Date:   Fri, 10 Aug 2018 15:08:00 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Joe Perches <joe@perches.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 5/6] powerpc: Add show_user_instructions()
References: <20180801213320.11203-1-muriloo@linux.ibm.com>
 <20180801213320.11203-6-muriloo@linux.ibm.com>
 <7209fa95-8d40-14ca-f27a-ce3edb64191e@c-s.fr>
 <20180803004201.GA5891@kermit-br-ibm-com>
 <69cf990b-d4aa-97e7-be3b-7936caa91688@c-s.fr>
 <87pnyzhm9l.fsf@concordia.ellerman.id.au>
 <20180803113141.GA5476@kermit-br-ibm-com>
 <1cfa56a3-027d-cf2c-3150-12aa45a35bd9@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1cfa56a3-027d-cf2c-3150-12aa45a35bd9@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 18081018-0068-0000-0000-00000326E13B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009519; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01071734; UDB=6.00551974; IPR=6.00851529;
 MB=3.00022638; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-10 18:08:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081018-0069-0000-0000-00004558AE5B
Message-Id: <20180810180800.GB30475@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=747 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808100193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe.

On Fri, Aug 10, 2018 at 11:29:43AM +0200, Christophe LEROY wrote:
>
>
> Le 03/08/2018 à 13:31, Murilo Opsfelder Araujo a écrit :
> > Hi, everyone.
> >
> > I'd like to thank you all that contributed to refining and making this
> > series better.  I did appreciate.
> >
> > Thank you!
>
> You are welcome.
>
> It seems that nested segfaults don't print very well. The code line is split
> in two, le second half being alone on one line. Any way to avoid that ?

What do you mean by "nested segfaults"?  I'd guess it's related to nested
virtualization, e.g.: host (kvm hv) -> guest1 (kvm pr) -> guest2?  So the
segfault would have been originated in guest2?

Can you provide us with more details about how to reproduce that?

Anyway, is "XXXXXXXX" so important that it needs to be printed at all?  Can't we
just discard it and not print it?

Murilo

