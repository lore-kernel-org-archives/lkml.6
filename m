Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6013ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7F220685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vQJbFVoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7F220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388198AbeGWWWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:22:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56570 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbeGWWWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:22:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6NLIlhv151863;
        Mon, 23 Jul 2018 21:19:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=NNXfYelHQQp41J2O1PtI2bcWml8VJkxfxc68LCwuSsk=;
 b=vQJbFVocbGHc7NXVtJ3CXia+NnUGqzoFtzJQXsbNyQ6wBAUaMgA3DEHdvChKWm1w/FCc
 yi4aN7Hap4dS+DUiPu/7kHzmAQwK7kVubFcUSKhzHXjDzMtFZtFr2GIi9/Ma2tWcPFTP
 iTzKevuz1oEnlNRDyTDhVZPdYJJaYusmdMWjiR4GH0Qe4ob9v23r8OMpjowOIDwkKxZt
 kDnku07Y5v/QGrSwReYqfdnvK7WSLOok4fC6U30/KMzgtWAdfWbGcIoZ0GOjLDJKYC8j
 0aKqaUZs2iSsAI6TGm3l0R3O/WGh95kTsPZIibUO5yZaBhJjNq2C2KWDHGMJRmPOwyPf Uw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2kbvsnpbt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 21:19:28 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6NLJQdD004350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jul 2018 21:19:27 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6NLJOHO028079;
        Mon, 23 Jul 2018 21:19:24 GMT
Received: from [10.132.93.82] (/10.132.93.82)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Jul 2018 14:19:24 -0700
Subject: Re: [PATCH v6] pidns: introduce syscall translate_pid
To:     Michael Tirado <mtirado418@gmail.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
References: <152788068212.768348.15192457501079586650.stgit@buzz>
 <db8d560e-47d1-c32f-e4a2-407110f2b5b6@oracle.com>
 <CAMkWEXPTb2NJH5rv8WpKWQaZVOJZp91z5Rr-e19UjrwBxB2pNw@mail.gmail.com>
From:   Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <c877358b-b7eb-c019-691e-fec489329f88@oracle.com>
Date:   Mon, 23 Jul 2018 14:13:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAMkWEXPTb2NJH5rv8WpKWQaZVOJZp91z5Rr-e19UjrwBxB2pNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8963 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807230234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/23/2018 01:55 PM, Michael Tirado wrote:
> Hey, I'm not seeing much activity on this so here's my $0.02
>
>> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
>> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
>> into pid namespace, this expose process and could be insecure.
>
> Perhaps it would be a good idea to add a sysctl switch that prevents
> credential spoofing over AF_UNIX \by default\ if that is the main
> concern, or is there another concern and I have read this wrong?  I'm
> having trouble thinking of a legitimate use of SCM_CREDENTIALS
> spoofing that isn't in a debugging or troubleshooting context and
> would be more comfortable if it were not possible at all... Anyone
> know of a program that relies on this spoofing functionality?
>
> If you look at socket(7) under SO_PEERCRED there is a way to get
> credentials at time of connect() for an AF_UNIX SOCK_STREAM, or at
> time of socketpair() for a SOCK_DGRAM. I would like to think these
> credentials are reliable, but will probably require some extra daemon
> to proxy a dgram syslog socket.

Thanks for the comments Michael! The usecase we are considering involves 
non root monitor process be able to translate the process ID of other 
non-root processes under same user within nested PID namespaces. With 
SCM_CREDENTIALS method, we require open sockets and connections between 
the processes which require PID translation and also CAP_SYS_ADMIN which 
is higher than required privilege level for non-root monitor process. 
The current patch solves this problem by enabling to open the related 
procfs fd when required during PID translation. I believe almost 
everyone agreed on this V6 patch but not sure why it is in limbo still.

Thanks,
Nagarathnam.

