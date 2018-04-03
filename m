Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522792230-2-4415863656306651710
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522792229; b=no9QmPDm1/3piA9nKksXWUhS8a0Ke+I7bTBaPA87c0zk+DPP71
    EDoZtAciWxiq/jltyNF7AvLXDH7qQjUHQ4zGPVkRdH50wus71CNTpYh6zJBuaOX5
    BWSEPeUgbar0zstvdPW98J3foU3S0IQBcYwQTggksuBxQ3ZZ9J6aSwYOgMBw+Uk0
    2jHZdBHqlu08tCCIf0u6br14MjpUEP1eLoSAf+EItzc1KoxwgvV9rbC33Jx3OPgc
    O8fVgf87gaosWetcO1EsJA9Z5/QHc2CwQpA1aqTGmJELh4BmOVxDADCCPGrRTXRX
    W7N2fmNUYODp5SAZFM8PcsVeczWf0Ib/K9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522792229;
    bh=NOVMpEJFnoatYYtRPPCqRykD0n0x6sK8T9POkF5YF5E=; b=rrxeip2VFcXG
    n/0dEtCO/FT+7y5fgoyzDuvayobGMPk/mwtdkQNd9dFjyScW7Wx8wLa2aeg6TSRq
    MVuLd03OvoGecWytMqHbpKHKLG8Cl+KLupXm5SzMfyE5l6w+S7+OL6g8VsP4fXKM
    AtLs/6zQeJ6U4mKBwatDJm39O2G1OOP27xQnqdaCdxJzVM/Jsg+u3DhfCL8qYDRT
    WlG1GcPx9H8IUJBvlhxXaIVGd7pKxYVYNe+b1xGU+I/7/NHjQwmOaqmP31hy4c07
    XeHOktw8whNkkAVuQtkhvR4vsSv6wVcHUZ1p5jjL5OpJpgRvjh55JnzuB7fiy96i
    9O7GgZDtIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=c3pUXv/p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=c3pUXv/p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCmwO+1btQiV81R9wCoeFPZKsJE6MyMCKcEhfvBuC4RSehe4LKzvxZwOzOEhvEC/4uo/ZdgUgWxmPi+qr5KKIHam9Acwg2FFNZDhEfd44hYUb4uDu8Ba
    zv5VwpnFRnklXK4yX6Zq1mLhzGRk89byS0Gv5j1fANu3mdJBKaDLN0EQhDvu0Ba3suDoCPxRTw+sfSOTXe1xfQregiXHOpplmcVmcy1nRZAdINce9BG/Boib
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=fCNCdkEL465O7O4_cXQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeDCVu1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:50:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54016 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbeDCVu0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 17:50:26 -0400
Subject: Re: [RESEND PATCH V4] pidns: introduce syscall translate_pid
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        serge.hallyn@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        jannh@google.com, prakash.sangappa@oracle.com
References: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <20180403143838.614ecc083835d07d409a699c@linux-foundation.org>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <678f275b-8d78-9b0f-177f-5ff5c9c55657@oracle.com>
Date: Tue, 3 Apr 2018 14:45:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180403143838.614ecc083835d07d409a699c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=853
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030211
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 04/03/2018 02:38 PM, Andrew Morton wrote:
> On Mon,  2 Apr 2018 15:57:29 -0600 nagarathnam.muthusamy@oracle.com wrote:
>
>> pid_t translate_pid(pid_t pid, int source, int target);
>>
>> This syscall converts pid from source pid-ns into pid in target pid-ns.
>> If pid is unreachable from target pid-ns it returns zero.
>>
>> Pid-namespaces are referred file descriptors opened to proc files
>> /proc/[pid]/ns/pid or /proc/[pid]/ns/pid_for_children. Negative argument
>> refers to current pid namespace, same as file /proc/self/ns/pid.
>>
>> Kernel expose virtual pids in /proc/[pid]/status:NSpid, but backward
>> translation requires scanning all tasks. Also pids could be translated
>> by sending them through unix socket between namespaces, this method is
>> slow and insecure because other side is exposed inside pid namespace.
>>
>> Examples:
>> translate_pid(pid, ns, -1)      - get pid in our pid namespace
>> translate_pid(pid, -1, ns)      - get pid in other pid namespace
>> translate_pid(1, ns, -1)        - get pid of init task for namespace
>> translate_pid(pid, -1, ns) > 0  - is pid is reachable from ns?
>> translate_pid(1, ns1, ns2) > 0  - is ns1 inside ns2?
>> translate_pid(1, ns1, ns2) == 0 - is ns1 outside ns2?
>> translate_pid(1, ns1, ns2) == 1 - is ns1 equal ns2?
>>
>> Error codes:
>> EBADF    - file descriptor is closed
>> EINVAL   - file descriptor isn't pid-namespace
>> ESRCH    - task not found in @source namespace
> Presumably a manpage is planned?
>
> This changelog doesn't explain what the value is to our users.  I
> assume it is a performance optimization because "backward translation
> requires scanning all tasks"?  If so, please show us real-world
> examples of the performance benefit from this patch, and please go to
> great lengths to explain to us why this optimisation is needed by our
> users.

One of the usecase by Oracle database involves multiple levels of
nested pid namespaces and we require pid translation between the
levels. Discussions on the particular usecase, why any of the existing
methods was not usable happened in the following thread.

https://patchwork.kernel.org/patch/10276785/

At the end, it was agreed that this patch along with flocks will solve the
issue.

Thanks,
Nagarathnam.

