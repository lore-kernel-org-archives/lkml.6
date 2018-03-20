Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173734-1521577139-2-7494053348447994161
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521577138; b=IryYfjiytYDEVXe0TxLNbgqNinenepU6vPOJOxqyswRmQFO
    PTaPEidSL7KzIlHW/McHBgCjVWBB7pMf50PI2Ll0SGRjYjx4dzQJ9Ks4zg5BKiAx
    +AyQmOJWNNPZEISp+0iJ1vzEJpe2uYMC1qRJ2l7DCH8Hn5FeFdPK6+4iCX06PZvW
    Q4l5fTtFEUb+6HY36PewKuxQXbSXXFJEpBBmiG7/7mPOz8nf+ikGf1/mAlYzWFZW
    XpewkhiFHFR0ade2YDuYgxdUiKkEIzC+Hw7sLfz/k0hbRrZbGzUm61twW0uORETB
    J6/CgfROOIf9FbFuO5ORr1TghUO/cltgO5tInNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521577138; bh=sVvK6AtI8FVsHgrKQlNMPOgzMCZwk7zBhU9Bms2NMG4=; b=R
    QGS+huqfoVDGLpIwhKmACIFeZgIpLKpWUA73eNMbFycwgpkBvFvGF4Q1HalibUMZ
    A42hHv2H1LNJgKCX5x2+t7uVSHfgiXAaom9nhLSKM/SPya9ixVk0JUPB7rH8OZOC
    H1pFi6Fz3qZMdvHsEwfOmfaoEUA8Ill3dFOwKE2ujXB7I0P1bP7JdJ4a2zQJZuL7
    B7w6HL9f2WRby7lYaGK+jL6m+wsTLo9k+7LoCxQyP37lv79KDAi1VqXxpmtGooph
    eV1WQAok488EUmpVe3E0x2BOXYXp5BsuHDD/WkbJn6uTZUK1Qzr4rM9m8rljkRfg
    Ry5bi4UvULyr4BloXZT6A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=VtJsWrIk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=VtJsWrIk x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeCTUS5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 16:18:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42022 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTUS4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Mar 2018 16:18:56 -0400
Subject: Re: [RESEND RFC] translate_pid API
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <87vadzqqq6.fsf@xmission.com>
 <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
 <877eqejowd.fsf@xmission.com>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
Date: Tue, 20 Mar 2018 13:14:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <877eqejowd.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8838 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


(Resending the reply as there was a reject due to HTML in email)

On 03/14/2018 03:03 PM, ebiederm@xmission.com wrote:
> Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> writes:
>
>> On 03/13/2018 08:29 PM, ebiederm@xmission.com wrote:
>>> The cost of that ``cheaper'' u64 that is not in any namespace is that
>>> you now have to go and implement a namespace of namespaces.  You haven't
>>> even attempted it.  So just no.    Anything that brings us to needing
>>> a namespace of namespaces is a bad design.
>> I am not trying to implement a namespace of namespaces.
> No you are using a design that will require a namespace of namespaces
> to be implemented to support CRIU (checkpoint/restart in userspace).
>
> So when I see your patch I see a patch that only implements the easy
> half of the work that needs to be done.
>
>>>> Following patch uses a 64-bit ID for namespace exported by procfs
>>>> for pid translation through a new file /proc/<pid>/ns/pidns_id.
>>> And this design detail is what brings the automatic nack.
>>>
>>> Use file descriptros and it sounds like your use case justifies what you
>>> are trying to do.
>> File descriptors are problematic for following reasons.
>> 1) I need to open a couple of file descriptors for every pid
>> translation request.
> You can cache descriptors across requests.  I suspect simply
> by tracking the origin of the shared memory segment you can figure
> out it's pid namespace.
>
>> 2) In case of nested PID namespaces, say a new pid namespace is
>> created at level 20,
>>      with unique ID, I could just record this ID in a shared memory for
>> interested process
>>      to use. In case of file descriptors, every level has to figure out
>> the process ID of the
>>      newly created namespace's init process and open a file descriptor
>> to track it.
> Toss in a bind mount of the file in some filesystem if that helps.
>
> But if I understand what you are talking about you are talking about
> having a shared memory segment shared between processes in different
> pid namespaces.
>
> In that shared memory segment for a processes in different namespaces
> you are talking about having the conversation structured as having
> information structured as pid-namespace pid.
>
> And crucuially you want anyone in any pid namespace to be able to read
> that shared memory segment and to make sense of what is going on,
> by just reading the pid namespace id.

This captures the usecase. Adding to that, every level is made up of
a combination of User, pid and mount namespace.

>
>
> Namespaces are all about making identifiers relative to their namespace.
>
> The only way I can see you gain an advantage with your shared memory
> design is by making identifiers that are not relative to their pid
> namespace.   As such identifiers will completely defeat the ability
> to implement CRIU support.
>
> The closest I have to such identifiers today are bind mounts of the
> namespace files.  So if you also have a common mount namespace you could
> use that.

We don't have common mount namespace. Each nested level will have
a new mount namespace. When a new nested level (User + pid + mnt) is
created, init process of new level cannot bind mount the namespace 
directory,
as the effects wont be visible to the other levels.

On other hand, the new init process could send SCM_CREDENTIALS message
to a centralized listener running outside of the whole setup which does only
bind mounts. Here, we have a single point of failure for the whole 
system and
this listener has to run as root to be able to do bind mounts. Apart 
from these,
I am not able to see the bind mount by listener being propagated to child
namespaces in my setup. Not sure if I am missing anything or this is the
expected behavior.

Is it possible to have application provide the ID to be associated with
the namespace? During dump, we can save the ID and during restore,
we can assign the ID using the same API. There is a possibility of
collision during restore. Is it ok to fail the restore during such scenario?

Thanks,
Nagarathnam.

>
> In theory a name in some other namespace is possible.  However anyone in
> a container will only be able to see the names in their container or in
> nested sub containers.  Which is what you have already with pids.  So I
> don't think that will help.
>
> Eric

