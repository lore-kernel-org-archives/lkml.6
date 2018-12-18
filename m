Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9906C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FF621850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeLRLY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:24:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726390AbeLRLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:24:26 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBIBONUo045023
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:24:24 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2peyysr06v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:24:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Tue, 18 Dec 2018 11:24:14 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 18 Dec 2018 11:24:11 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBIBOAvb56098868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 11:24:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E7F14C044;
        Tue, 18 Dec 2018 11:24:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB36C4C046;
        Tue, 18 Dec 2018 11:24:09 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.152.224.151])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 18 Dec 2018 11:24:09 +0000 (GMT)
Subject: Re: [PATCH v2] net/smc: fix TCP fallback socket release
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181217052122.GA26299@myunghoj-Precision-5530>
 <a9ad19c4-1ef7-4dc9-639e-03b3459457e2@linux.ibm.com>
 <20181218070339.GA20290@myunghoj-Precision-5530>
From:   Ursula Braun <ubraun@linux.ibm.com>
Openpgp: preference=signencrypt
Date:   Tue, 18 Dec 2018 12:24:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181218070339.GA20290@myunghoj-Precision-5530>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121811-0008-0000-0000-000002A2FDEF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121811-0009-0000-0000-0000220D90E4
Message-Id: <8cb0dcc2-4341-f56a-8465-303d238bc5f5@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812180101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/18/2018 08:03 AM, Myungho Jung wrote:
> On Mon, Dec 17, 2018 at 03:58:58PM +0100, Ursula Braun wrote:
>>
> 
> Hi Ursula,
> 
> Thank you for your suggestion. I have a question on your comment.
> 
>>
>> On 12/17/2018 06:21 AM, Myungho Jung wrote:
>>> clcsock can be released while kernel_accept() references it in TCP
>>> listen worker. Also, clcsock needs to wake up before released if TCP
>>> fallback is used and the clcsock is blocked by accept. Add a lock to
>>> safely release clcsock and call kernel_sock_shutdown() to wake up
>>> clcsock from accept in smc_release().
>>
>> Thanks for your effort to solve this problem. I have some minor
>> improvement proposals:
>>
>>>
>>> Reported-by: syzbot+0bf2e01269f1274b4b03@syzkaller.appspotmail.com
>>> Reported-by: syzbot+e3132895630f957306bc@syzkaller.appspotmail.com
>>> Signed-off-by: Myungho Jung <mhjungk@gmail.com>
>>> ---
>>>  net/smc/af_smc.c | 14 ++++++++++++--
>>>  net/smc/smc.h    |  2 ++
>>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>> index 5fbaf1901571..5d06fb1bbccf 100644
>>> --- a/net/smc/af_smc.c
>>> +++ b/net/smc/af_smc.c
>>> @@ -147,8 +147,14 @@ static int smc_release(struct socket *sock)
>>>  		sk->sk_shutdown |= SHUTDOWN_MASK;
>>>  	}
>>>  	if (smc->clcsock) {
>>> +		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
>>> +			/* wake up clcsock accept */
>>> +			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
>>> +		}
>>
>> This part is not needed, since an SMC socket in state SMC_LISTEN is never
>> a use_fallback socket.
> 
> In smc_sendmsg(), set use_fallback to true if SMC socket is SMC_INIT
> state and the message has MSG_FASTOPEN flag. After this, smc_listen()
> would trigger smc_tcp_listen_work(). Is this not an expected scenario?
> Then, what is the reason for not skipping smc_sendmsg() in SMC_INIT
> state?
> 

You are right, I have not had the FASTOPEN case in mind, sorry. If we want
to allow fallback in case of FASTOPEN, we need the kernel_sock_shutdown() here
for proper cleanup. Nice!

>>
>>> +		mutex_lock(&smc->clcsock_release_lock);
>>>  		sock_release(smc->clcsock);
>>>  		smc->clcsock = NULL;
>>> +		mutex_unlock(&smc->clcsock_release_lock);
>>>  	}
>>>  	if (smc->use_fallback) {
>>>  		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
>>> @@ -205,6 +211,7 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>>>  	spin_lock_init(&smc->conn.send_lock);
>>>  	sk->sk_prot->hash(sk);
>>>  	sk_refcnt_debug_inc(sk);
>>> +	mutex_init(&smc->clcsock_release_lock);
>>>  
>>>  	return sk;
>>>  }
>>> @@ -821,7 +828,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>>>  	struct socket *new_clcsock = NULL;
>>>  	struct sock *lsk = &lsmc->sk;
>>>  	struct sock *new_sk;
>>> -	int rc;
>>> +	int rc = 0;
>>
>> Without clcsock the good path should not be executed. Thus I suggest
>> to initialize with something negative like -EINVAL.
>>
>>>  
>>>  	release_sock(lsk);
>>>  	new_sk = smc_sock_alloc(sock_net(lsk), NULL, lsk->sk_protocol);
>>> @@ -834,7 +841,10 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>>>  	}
>>>  	*new_smc = smc_sk(new_sk);
>>>  
>>> -	rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
>>> +	mutex_lock(&lsmc->clcsock_release_lock);
>>> +	if (lsmc->clcsock)
>>> +		rc = kernel_accept(lsmc->clcsock, &new_clcsock, 0);
>>> +	mutex_unlock(&lsmc->clcsock_release_lock);
>>>  	lock_sock(lsk);
>>>  	if  (rc < 0)
>>>  		lsk->sk_err = -rc;
>>> diff --git a/net/smc/smc.h b/net/smc/smc.h
>>> index 08786ace6010..9a2795cf5d30 100644
>>> --- a/net/smc/smc.h
>>> +++ b/net/smc/smc.h
>>> @@ -219,6 +219,8 @@ struct smc_sock {				/* smc sock container */
>>>  						 * started, waiting for unsent
>>>  						 * data to be sent
>>>  						 */
>>> +	struct mutex            clcsock_release_lock;
>>> +						/* protects clcsock */
>>
>> I suggest to be more precise: "protects clcsock of a listen socket" 
>>
>>>  };
>>>  
>>>  static inline struct smc_sock *smc_sk(const struct sock *sk)
>>>
>>
> 

