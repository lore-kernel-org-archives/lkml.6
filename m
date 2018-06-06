Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9595A6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbeFFKiR convert rfc822-to-8bit (ORCPT
        <rfc822;monsieuricon@codeaurora.org> + 25 others);
        Wed, 6 Jun 2018 06:38:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60566 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932589AbeFFKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:38:14 -0400
Date: Wed, 06 Jun 2018 16:08:04 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc: Add support for function error injection
To: Josef Bacik <jbacik@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <5ad23690185a90a887514d702ecb45783090d7c0.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
        <87h8mozajv.fsf@concordia.ellerman.id.au>
        <1527761352.z5jz8jg2d5.naveen@linux.ibm.com>
        <87zi0fyktj.fsf@concordia.ellerman.id.au>
        <1527793526.g9zv2oo8k4.naveen@linux.ibm.com>
In-Reply-To: <1527793526.g9zv2oo8k4.naveen@linux.ibm.com>
User-Agent: astroid/0.11.1 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 18060610-0008-0000-0000-00000244B4E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060610-0009-0000-0000-000021AABF2B
Message-Id: <1528280140.q9nkfry2ll.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060122
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen N. Rao wrote:
> Michael Ellerman wrote:
>> 
>> I guess if it doesn't already apply to tip you should rebase it. You've
>> probably missed 4.18 anyway.
> 
> Oh ok. I just tried and it seems to apply just fine. I'll post v2 after 
> giving this a quick test.

I didn't post a v2 since I have decided against using this approach. The 
reason for that is Masami's series to remove jprobes. The discussion 
there reminded me that we can't easily override functions with kprobes 
on powerpc. Though it works for this particular scenario, we would just 
be setting a bad example.

As such, I won't be changing generic code, but will simply make the 
necessary changes in powerpc code.

Sorry for the noise.

- Naveen
