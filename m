Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497CAC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62092086E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62092086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbeGCNwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:52:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752863AbeGCNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:52:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w63DnLuo127313
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 09:52:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k09dh30xd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:52:07 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 3 Jul 2018 14:52:06 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Jul 2018 14:52:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w63Dq3YS31916108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jul 2018 13:52:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A01BA4C04A;
        Tue,  3 Jul 2018 16:52:28 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 595904C046;
        Tue,  3 Jul 2018 16:52:28 +0100 (BST)
Received: from oc0447013845.ibm.com (unknown [9.152.224.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jul 2018 16:52:28 +0100 (BST)
Subject: Re: [GIT] Networking
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180702.220348.527254946062449999.davem@davemloft.net>
 <CA+55aFw4+YPQUh9RTJBzxdvJ9Xf_s4soPLbCXsXuhHT0TjPtZw@mail.gmail.com>
From:   Ursula Braun <ubraun@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ubraun@linux.ibm.com; keydata=
 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
Date:   Tue, 3 Jul 2018 15:52:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFw4+YPQUh9RTJBzxdvJ9Xf_s4soPLbCXsXuhHT0TjPtZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18070313-4275-0000-0000-00000294B8A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070313-4276-0000-0000-0000379C3793
Message-Id: <5b5509f1-9713-f1bc-cb33-18ebdb1cb8c5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807030159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/2018 08:29 PM, Linus Torvalds wrote:
> On Mon, Jul 2, 2018 at 6:03 AM David Miller <davem@davemloft.net> wrote:
>>
>> are available in the Git repository at:
>>
>>   gitolite@ra.kernel.org:/pub/scm/linux/kernel/git/davem/net.git
> 
> So the af_smc poll fixes clashed with the revert of the commit that
> caused those fixed to be done in the first place.
> 
> See the changes to net/smc/af_smc.c in my commit
> 
>   a11e1d432b51 ("Revert changes to convert to ->poll_mask() and aio
> IOCB_CMD_POLL")
> 
> vs Ursula's
> 
>   24ac3a08e658 ("net/smc: rebuild nonblocking connect")
> 
> I (briefly) considered just dropping Ursula's changes entirely, but
> they looked like a nice cleanup on their own, so what I did instead
> was to try to fix up my revert instead.
> 
> That involved removing the release_sock/lock_sock pair around the
> ->poll() call, and removing the special "sock_poll_wait()" that got
> re-introduced by my revert, but that Ursula's changes seem to obviate.
> 
> However, while I can look at the code and say "my merge makes sense to
> me", (a) I can't test it, (b) I don't actually know the rules for SMC
> sockets in the first place, and (c) I may be just incompetent.
> 
> So Ursula - mind checking and testing the end result? I _think_ it's
> fine and the merge looked pretty obvious, but maybe af_smc got broken
> again.
> 

Thanks Linus for your revert. I run a test, and found it is almost fine.
Just these 2 lines are missing:

---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index e017b6a4452b..e7d7ff87499e 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1345,6 +1345,8 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 		if (sk->sk_err)
 			mask |= EPOLLERR;
 	} else {
+		if (sk->sk_state != SMC_CLOSED)
+			sock_poll_wait(file, sk_sleep(sk), wait);
 		if (sk->sk_err)
 			mask |= EPOLLERR;
 		if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-- 


> [ It's still going through by basic build tests, so I haven't pushed
> out my merge yet, but it should be in the usual places in a short
> while ]
> 
> Thanks,
> 
>                 Linus
> 

Regards, Ursula

