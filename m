Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B0C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130DF208A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130DF208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbeHIO7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:59:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731130AbeHIO7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:59:34 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w79CTdx4136457
        for <linux-kernel@vger.kernel.org>; Thu, 9 Aug 2018 08:34:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2krnme89th-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 08:34:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 9 Aug 2018 13:34:49 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 Aug 2018 13:34:45 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w79CYilk37748788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Aug 2018 12:34:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DFDC42042;
        Thu,  9 Aug 2018 15:34:52 +0100 (BST)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF9AE4203F;
        Thu,  9 Aug 2018 15:34:51 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.8.123])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  9 Aug 2018 15:34:51 +0100 (BST)
Date:   Thu, 9 Aug 2018 15:34:42 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "Fancer's opinion" <fancer.lancer@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mips: switch to NO_BOOTMEM
References: <1531727262-11520-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726070355.GD8477@rapoport-lnx>
 <20180726172005.pgjmkvwz2lpflpor@pburton-laptop>
 <CAMPMW8p092oXk1w+SVjgx-ZH+46piAY8xgYPDfLUwLCkBm-TVw@mail.gmail.com>
 <20180802115550.GA10232@rapoport-lnx>
 <CAMPMW8qq-aEm-0dQrWh08SBBSRp3xAqR1PL5Oe-RvkJgUk6LjA@mail.gmail.com>
 <20180808214215.bf6hyurv3nunfynd@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808214215.bf6hyurv3nunfynd@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080912-0016-0000-0000-000001F4623B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080912-0017-0000-0000-0000324A75BA
Message-Id: <20180809123441.GA3264@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=908 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808090131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 02:42:15PM -0700, Paul Burton wrote:
> Hi Sergey & Mike,
> 
> On Thu, Aug 09, 2018 at 12:30:03AM +0300, Fancer's opinion wrote:
> > Hello Mike,
> > I haven't read your patch text yet. I am waiting for the subsystem
> > maintainers response at least
> > about the necessity to have this type of changes being merged into the
> > sources (I mean
> > memblock/no-bootmem alteration). If they find it pointless (although I
> > would strongly disagree), then
> > nothing to discuss. Otherwise we can come up with a solution.
> > 
> > -Sergey
> 
> I'm all for dropping bootmem.
> 
> It's too late for something this invasive in 4.19, but I'd love to get
> it into 4.20.

I can resend my patch once merge window is closed. We can then apply
additional changes Sergey has done in his set on top.

> Thanks,
>     Paul
> 

-- 
Sincerely yours,
Mike.

