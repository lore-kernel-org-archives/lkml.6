Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC5CECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:11:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF5A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGQSp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:45:28 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:41894 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729695AbeGQSp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:45:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HI5B07009167;
        Tue, 17 Jul 2018 11:11:05 -0700
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2k7gpga449-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 17 Jul 2018 11:11:05 -0700
Received: from IL-EXCH03.marvell.com (10.5.102.220) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 11:11:03 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by IL-EXCH03.marvell.com
 (10.5.102.220) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Tue, 17 Jul
 2018 21:11:00 +0300
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 17 Jul 2018 11:11:00 -0700
Received: from [10.4.50.2] (unknown [10.4.50.2])
        by maili.marvell.com (Postfix) with ESMTP id 0C7673F7040;
        Tue, 17 Jul 2018 10:35:37 -0700 (PDT)
Subject: Re: dvb usb issues since kernel 4.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <CA+55aFwuAojr7vAfiRO-2je-wDs7pu+avQZNhX_k9NN=D7_zVQ@mail.gmail.com>
 <1d3d0fe3-bc02-7720-15ac-6bc06e00067c@marvell.com>
 <CA+55aFwb5hPtPFbB02SSn+wTkqTDSgHGFkiw7LB57mj42VzyZQ@mail.gmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        David Miller <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josef Griebichler <griebichler.josef@gmx.at>,
        Hannes Frederic Sowa <hannes@redhat.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>,
        Ingo Molnar <mingo@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        dma <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <nadavh@marvell.com>,
        <thomas.petazzoni@bootlin.com>, <omrii@marvell.com>
From:   Hanna Hawa <hannah@marvell.com>
Message-ID: <361dec80-081e-c796-2052-71d006b84ffc@marvell.com>
Date:   Tue, 17 Jul 2018 21:07:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFwb5hPtPFbB02SSn+wTkqTDSgHGFkiw7LB57mj42VzyZQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_04:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=898 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 07/17/2018 08:09 PM, Linus Torvalds wrote:
> On Tue, Jul 17, 2018 at 4:58 AM Hanna Hawa <hannah@marvell.com> wrote:
>>
>> After some debug/bisect/diff, found that patch "softirq: Let ksoftirqd
>> do its job" is problematic patch.
>
> Ok, this thread died down without any resolution.
>
>> - Using v4.14.0 (including softirq patch) and the additional fix
>> proposed by Linus - no timeout issue.
>
> Are you talking about the patch that made HI_SOFTIRQ and
> TASKLET_SOFTIRQ special, and had this:
>
>   #define SOFTIRQ_NOW_MASK ((1 << HI_SOFTIRQ) | (1 << TASKLET_SOFTIRQ))
>
> in it?
yes, exactly..

Link to the patch:
https://git.linuxtv.org/mchehab/experimental.git/commit/?h=v4.15%2bmedia%2bdwc2&id=ccf833fd4a5b99c3d3cf2c09c065670f74a230a7

Thanks,
Hanna

>
> I think I'll just commit the damn thing. It's hacky, but it's simple,
> and it never got applied because we had smarter suggestions. But the
> smarter suggestions never ended up being applied either, so..
>
>                        Linus
>
