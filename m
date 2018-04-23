Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1566850-1524505370-2-937993738369681858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524505370; b=ExWyABoMszcL6HUycgKiNQQ0eeGsUC2GBRuuEcjy19cgzjy+Rv
    W/+4CWKvbLaFZnto6zQ9a/3rsSSy5tnNkd0Mg4rLjlZPI2pBRHxI/8IvpUpXeYmM
    WetrD+2nAotNtQEpWi+15yHld0qMQlHAs/CYQVJOjmBZuTc0ltG5W8QilDCoQanO
    uM99FsQpzTgGCsqzdxLJzREdxGsER/+WPO7si9+ysAVXpCo0/NJd8o9w9mfxCu2+
    RqyRguQfwmUfTt2GfEyymGzo7PdvXT1Ky9KAIiN5KKaoFX9N9TmSaXAcLmOxGNV8
    TaPM8qlNXhsNmPJ4YfQy1hoGxUmFrRR/IQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524505370;
    bh=7UVuO+B9KoJ3NxTVt5GsOcB4zZYzflcTOmkPvPWqMw0=; b=GwWkBGVgsK+U
    297glYy/bbHI4Ck50+jFALUI96SMUhLKk3sTXzln0TZNXFmm1dRTZBrhOQMJVBIi
    7L4uvW7s1KXO43vXn+kLGWIWxG2BiPitw9zS+k4cdVV4pvzephJ37GCaEMzu1J1S
    UDRaDIpX+EqjpiFDg1YoStDZTtQvNboOKcmuPt+zaPILF0uliqEopVHs6mhw4Y7T
    VoY3Pg/w3JXPGER6ruyhETz6atceSUKzrgM0zCQvFKblpswe6S1airvT+rOWrui2
    bhq3YFeG++IS0eyiPsIXj+W+LEExkzjSIxQp/vcgAZGXlB8S7MCtvR/5Zi3cWpIg
    oH7cOQLqUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=RTscaBsv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=RTscaBsv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCsPVPuvJhT2/U5qYr2h34NfS/vBTUjKp9JxDUQ12mrVlb0rs7dELDZHDWeYaW4RrP3MPzYcAmK3XmUq5WBS+daR+XCtLW1VXqgpGpLcH0vV4a9RnoZ0
    30wIoBYm0t1H8YtLD1Qb0oFBCKtMghpVY1hKQWm+QTmweQtaGjxqiY9627IS+gvHOhWHT7vez/jtEmijmCaUU0wn850pQ044qFau0qwwTsaKCQxz7a77EafR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=iPWucsFWNPUNLheS-swA:9
    a=TVlZ9uTGJynycJAW:21 a=v7JN1BV70XNN04Dq:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932200AbeDWRm2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 13:42:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34270 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932104AbeDWRm0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Apr 2018 13:42:26 -0400
Subject: Re: [PATCH RFC v5] pidns: introduce syscall translate_pid
To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <152286911105.615669.14053871624892399807.stgit@buzz>
 <ba7b704f-1fc4-a08d-e7cf-2766160bd419@oracle.com>
 <87h8oqhagl.fsf@xmission.com>
 <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <e1402871-77a5-6a0f-a75c-ccad77b93f49@oracle.com>
Date: Mon, 23 Apr 2018 10:37:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <112c7cac-1982-3a2e-ffc0-878bc5ae4bb6@yandex-team.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8872 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=17 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804230177
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/05/2018 12:02 AM, Konstantin Khlebnikov wrote:
> On 05.04.2018 01:29, Eric W. Biederman wrote:
>> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>>
>>> On 04/04/2018 12:11 PM, Konstantin Khlebnikov wrote:
>>>> Each process have different pids, one for each pid namespace it 
>>>> belongs.
>>>> When interaction happens within single pid-ns translation isn't 
>>>> required.
>>>> More complicated scenarios needs special handling.
>>>>
>>>> For example:
>>>> - reading pid-files or logs written inside container with pid 
>>>> namespace
>>>> - attaching with ptrace to tasks from different pid namespace
>>>> - passing pids across pid namespaces in any kind of API
>>>>
>>>> Currently there are several interfaces that could be used here:
>>>>
>>>> Pid namespaces are identified by inode number of /proc/[pid]/ns/pid.
>>
>> Using the inode number in interfaces is not an option. Especially not
>> withou referencing the device number for the filesystem as well.
>
> This is supposed to be single-instance fs,
> not part of proc but referenced but its magic "symlinks".
>
> Device numbers are not mentioned in "man namespaces".
>
>>
>>>> Pids for nested Pid namespaces are shown in file /proc/[pid]/status.
>>>> In some cases conversion pid -> vpid could be easily done using this
>>>> information, but backward translation requires scanning all tasks.
>>>>
>>>> Unix socket automatically translates pid attached to SCM_CREDENTIALS.
>>>> This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
>>>> into pid namespace, this expose process and could be insecure.
>>>>
>>>> This patch adds new syscall for converting pids between pid 
>>>> namespaces:
>>>>
>>>> pid_t translate_pid(pid_t pid, int source_type, int source,
>>>>                                  int target_type, int target);
>>>>
>>>> @source_type and @target_type defines type of following arguments:
>>>>
>>>> TRANSLATE_PID_CURRENT_PIDNS  - current pid namespace, argument is 
>>>> unused
>>>> TRANSLATE_PID_TASK_PIDNS     - task pid-ns, argument is task pid
>>>
>>> I believe using pid to represent the namespace has been already
>>> discussed in V1 of this patch in https://lkml.org/lkml/2015/9/22/1087
>>> after which we moved on to fd based version of this interface.
>>
>> Or in short why is the case of pids important?
>>
>> You Konstantin you almost said why they were important in your message
>> saying you were going to send this one.  However you don't explain in
>> your description why you want to identify pid namespaces by pid.
>>
>
> Open of /proc/[pid]/ns/pid requires same permissions as ptrace,
> pid based variant doesn't have such restrictions.

Can you provide more information on usecase requiring PID translation 
but not used for tracing related purposes?
On a side note, can we have the types TRANSLATE_PID_CURRENT_PIDNS and 
TRANSLATE_PID_FD_PIDNS integrated first and then possibly extend the 
interface to include TRANSLATE_PID_TASK_PIDNS in future?

Thanks,
Nagarathnam.
> Most pid-based syscalls are racy in some cases but they are
> here for decades and everybody knowns how to deal with it.
> So, I've decided to merge both worlds in one interface which clearly 
> tells what to expect.

