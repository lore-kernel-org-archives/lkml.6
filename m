Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752590AbeC3Vs1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:48:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752249AbeC3Vs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:48:26 -0400
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
To: Keith Busch <keith.busch@intel.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de,
        linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
From: =?UTF-8?Q?Rodrigo_Rosatti_Galv=c3=a3o?=
        <rosattig@linux.vnet.ibm.com>
Date: Fri, 30 Mar 2018 18:48:18 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180330212439.GA28945@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18033021-0024-0000-0000-00001827EB1C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008773; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01010764; UDB=6.00515014; IPR=6.00790042;
 MB=3.00020337; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-30 21:48:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18033021-0025-0000-0000-00004F518AE1
Message-Id: <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-30_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803300218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Doesn't that mean your host is using this command wrong? The NLB is a
> 0's based value, we're supposed to +1 to get the correct block count.

Keith, I tested passing different values to the c (number of blocks) and 
s (64-bit LBA of first block to access) parameters, and it was failing. 
When I removed the +1, the command worked fine.

I used a simple script to validate this:

for s in {0..20}
     do
             for c in {0..20}
             do
                     nvme write-zeroes /dev/nvme0 -n 10 -s $s -c $c
             done
     done


Is there some other way to test it?

-- 
Rodrigo R. Galvão
Intern - Linux Technology Center - IBM
