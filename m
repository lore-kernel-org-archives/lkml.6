Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1133DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DB8208DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DB8208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbeHBNq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:46:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387428AbeHBNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:46:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w72Bs4b1020907
        for <linux-kernel@vger.kernel.org>; Thu, 2 Aug 2018 07:56:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2km026m06y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 07:56:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Thu, 2 Aug 2018 12:56:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 Aug 2018 12:56:02 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w72Bu1sw34865164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 2 Aug 2018 11:56:01 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E0EB11C04A;
        Thu,  2 Aug 2018 14:56:11 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 74D4811C052;
        Thu,  2 Aug 2018 14:56:06 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.181])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 Aug 2018 14:56:05 +0100 (BST)
Date:   Thu, 2 Aug 2018 14:55:51 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     "Fancer's opinion" <fancer.lancer@gmail.com>,
        Paul Burton <Paul.Burton@mips.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Huacai Chen <chenhc@lemote.com>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: switch to NO_BOOTMEM
References: <1531727262-11520-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180726070355.GD8477@rapoport-lnx>
 <20180726172005.pgjmkvwz2lpflpor@pburton-laptop>
 <CAMPMW8p092oXk1w+SVjgx-ZH+46piAY8xgYPDfLUwLCkBm-TVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMPMW8p092oXk1w+SVjgx-ZH+46piAY8xgYPDfLUwLCkBm-TVw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18080211-0020-0000-0000-000002AFF113
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080211-0021-0000-0000-000020FC1D95
Message-Id: <20180802115550.GA10232@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=827 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1808020125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 26, 2018 at 10:55:53PM +0300, Fancer's opinion wrote:
> Hello, folks
> Regarding the no_bootmem patchset I've sent earlier.
> I'm terribly sorry about huge delay with response. I got sucked in a new
> project, so just didn't have a time to proceed with the series, answer to the
> questions and resend the set.
> If it is still relevant and needed for community, I can get back to the series
> on the next week, answer to the Mett's questions (sorry, man, for doing it so
> long), rebase it on top of the kernel 4.18 and resend the new version. We also
> can try to combine it with this patch, if it is found convenient.

So, what would be the best way to move forward?

> Regards,
> -Sergey
> 
> 
> On Thu, 26 Jul 2018, 20:20 Paul Burton, <paul.burton@mips.com> wrote:
> 
>     Hi Mike,
> 
>     On Thu, Jul 26, 2018 at 10:03:56AM +0300, Mike Rapoport wrote:
>     > Any comments on this?
> 
>     I haven't looked at this in detail yet, but there was a much larger
>     series submitted to accomplish this not too long ago, which needed
>     another revision:
> 
>         https://patchwork.linux-mips.org/project/linux-mips/list/?series=787&
>     state=*
> 
>     Given that, I'd be (pleasantly) surprised if this one smaller patch is
>     enough.
> 
>     Thanks,
>         Paul
> 

-- 
Sincerely yours,
Mike.

