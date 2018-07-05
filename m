Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CABC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB5A24112
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB5A24112
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeGEORr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:17:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753870AbeGEORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:17:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65EEPOS021952
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 10:17:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1jehq5ej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:17:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Thu, 5 Jul 2018 15:17:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 15:17:39 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65EHcjE38994080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 14:17:38 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5FB5AE058;
        Thu,  5 Jul 2018 17:17:38 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C977AE057;
        Thu,  5 Jul 2018 17:17:38 +0100 (BST)
Received: from oc0447013845.ibm.com (unknown [9.152.224.125])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 17:17:38 +0100 (BST)
Subject: Re: WARNING in smc_unhash_sk
To:     Eric Biggers <ebiggers3@gmail.com>, linux-s390@vger.kernel.org
Cc:     syzbot <syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <001a114fa99028d2a10565e33df4@google.com>
 <20180704200139.GB725@sol.localdomain>
From:   Ursula Braun <ubraun@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ubraun@linux.ibm.com; keydata=
 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
Date:   Thu, 5 Jul 2018 16:17:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180704200139.GB725@sol.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070514-4275-0000-0000-000002957F78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070514-4276-0000-0000-0000379D08D3
Message-Id: <ee68e1f0-b177-8c84-cb6e-ccfbe1ef9a04@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/04/2018 10:01 PM, Eric Biggers wrote:
> Hi Ursula,
> 
> On Fri, Feb 23, 2018 at 07:59:01AM -0800, syzbot wrote:
>> Hello,
>>
>> syzbot hit the following crash on upstream commit
>> af3e79d29555b97dd096e2f8e36a0f50213808a8 (Tue Feb 20 18:05:02 2018 +0000)
>> Merge tag 'leds_for-4.16-rc3' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds
>>
>> So far this crash happened 27 times on
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/master,
>> net-next, upstream.
>> C reproducer is attached.
>> syzkaller reproducer is attached.
>> Raw console output is attached.
>> compiler: gcc (GCC) 7.1.1 20170620
>> .config is attached.
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+3a0748c8f2f210c0ef9b@syzkaller.appspotmail.com
>> It will help syzbot understand when the bug is fixed. See footer for
>> details.
>> If you forward the report, please keep this part and the footer.
>>
>> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638 sk_del_node_init
>> include/net/sock.h:638 [inline]
>> WARNING: CPU: 1 PID: 9921 at ./include/net/sock.h:638
>> smc_unhash_sk+0x335/0x450 net/smc/af_smc.c:90
>> Kernel panic - not syncing: panic_on_warn set ...
> 
> This is still happening and it can be easily reproduced with:
> 
> 	#include <sys/socket.h>
> 
> 	int main()
> 	{
> 		char buf[64] = { 0 };
> 		struct iovec iov  = { .iov_base = buf, .iov_len = sizeof(buf) };
> 		struct msghdr msg = { .msg_iov = &iov, .msg_iovlen = 1 };
> 		int fd;
> 
> 		fd = socket(AF_SMC, SOCK_STREAM, 0);
> 		sendmsg(fd, &msg, MSG_FASTOPEN);
> 	}
> 
> It seems the following sock_put() in smc_release() is done without any previous
> sock_hold(), causing a use-after-free:
> 
>         if (smc->use_fallback) {
>                 sock_put(sk); /* passive closing */
>                 sk->sk_state = SMC_CLOSED;
>                 sk->sk_state_change(sk);
>         }
> 

Sorry for the delay. Now patch is submitted for the net-tree.

