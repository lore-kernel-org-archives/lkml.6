Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeDBOuy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 10:50:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751255AbeDBOux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 10:50:53 -0400
Subject: Re: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
To: Keith Busch <keith.busch@intel.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        chaitany kulkarni <ckulkarnilinux@gmail.com>, hch@lst.de
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
 <20180330212439.GA28945@localhost.localdomain>
 <93622938-f532-b8ac-2bca-fe40ed759e71@linux.vnet.ibm.com>
 <CAK0tqikdyFoZGuRnh3_YXKtrY9NqEZVv5AysL+xGKpvGJ762fA@mail.gmail.com>
 <8a3d1471-571d-3352-1414-bf2051e2ebb9@linux.vnet.ibm.com>
 <20180402142141.GC28945@localhost.localdomain>
From: Rodrigo Rosatti Galvao <rosattig@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 11:50:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180402142141.GC28945@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040214-0008-0000-0000-0000098AC831
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008789; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01012065; UDB=6.00515771; IPR=6.00791338;
 MB=3.00020376; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-02 14:50:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040214-0009-0000-0000-000046A3959C
Message-Id: <c50d1e28-47f9-9ca3-23cf-bf425acd8a4b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-02_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804020166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Keith. The patch you proposed worked fine!!

I just sent a V2 with that change!


On 04/02/2018 11:21 AM, Keith Busch wrote:
> On Mon, Apr 02, 2018 at 10:47:10AM -0300, Rodrigo Rosatti Galvao wrote:
>> One thing that I just forgot to explain previously, but I think its
>> relevant:
>>
>> 1. The command is failing with 4k logical block size, but works with 512B
>>
>> 2. With the patch, the command is working for both 512B and 4K.
> While you're not getting errors with your patch, you're not zeroing out
> the requested blocks, so that's a data corruption.
>
> The issue is the +1 is in the wrong place. It needs to be added to the
> native format prior to converting it to a 512b sector count. Do you want
> to resend with that change?
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

-- 
Rodrigo R. Galvão
Intern - Linux Technology Center - IBM
