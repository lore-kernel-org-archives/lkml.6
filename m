Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1180209-1524080375-2-65250331844068054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524080374; b=dlpPXjCvpN9fVDOBc7aohu1oTcBaFwpG2CrvR6DLYzAcA17kCh
    3VnYicm6fsmr1RC4Bns11FMrCYpVv7E5FfGhs6bE0V2usC96B1WBNLVEAeZK/WV7
    vsEMxwWNUka2mI32gZUXgBh7FbHmxnE1rpFJRMlpgJdEr/y8Xws1V0hF8CQhDoB2
    xJDcMZqoCVz3ES7M/DLxBu2eUluix4B6nAOZvyQLcdgG0XfB9sGd25InhuhGcwGD
    YXzB8t9pFOagS4ns9QIcMHMKtuZ+lBm1ZV40NNUIzJSiaK43N+KNlFD9WuTFT8Rx
    pVusVmvy3U5zsFLT+lpcgPBvsYtcavGEpv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524080374; bh=KIs04BkUehY7
    y5LEjDLaoew33ZGGUqb9hUMtLLrq9T4=; b=h9R08j4iqg9NOMRPewxGqkrfZ05E
    dRUCkZ+VixgMjrszIckZ6OnFrBcCR5e+98aTLHwYYTOZHbvG532QDLcS1ZElz16U
    7+gJHeSadRNJr8mdStU0f04sgjRUZmWGJXaGy3e13G27v4NagqTYSYCoHkL9g1BK
    n1EZKWvAAR2eAtv7TXgDxSqNjxNu0/It5Qv64O2J9OcUC4zaSQbqqZztD35eV7mj
    OFTrI9jcjHX34EKXCcGkzwrh+gc50wlFJNPTaHbhVoad8Q8kSMWEDbtUZpoNrHg0
    iQFCjP3pa4eAryqTtf2J0Tjck6Bn/2oP/BGjofhndd2u/ikTtSkWuoGiRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFzVI+6gEeds83Tdvy33D7pfTdY1/jUUY6n5UMAA4AKEi/8JQohidp9OpA8Wg+OwaDxJvK10rkrqXc+hE/6c3aU8KOPS/SXD/u1JgT5JrrgwJph8qZeJ
    OaYcCqNH1EYkF7d/h+BZ1w59Wuq4X/JoeuqyOU90733UYARiuNYfIwRXCVsZSg/flEIlAYSJ2zbdQQlgOHyN6KeSeLZlWwoC9PjKpNL4M4mntnv2zZSgyyxR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMjCk5kom2EynFyzopoA:9
    a=pILNOxqGKmIA:10 a=P8DiOWeu0RwA:10 a=uSJDGqdCSd8A:10 a=x8gzFH9gYPwA:10
    a=rcqGhh1FAl0A:10 a=85vV7UR2iKEA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752247AbeDRTjb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 15:39:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752091AbeDRTj3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 15:39:29 -0400
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: Richard Guy Briggs <rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
 <20180316035837.ddnqvbyrbp3fdk7e@madcap2.tricolour.ca>
 <f966fa52-da4b-3d74-0848-1f0b08e57fd9@linux.vnet.ibm.com>
 <20180418192359.n4q53bvsdhrjftjg@madcap2.tricolour.ca>
Cc: mszeredi@redhat.com, ebiederm@xmission.com, simo@redhat.com,
        jlayton@redhat.com, carlos@redhat.com, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, eparis@parisplace.org,
        dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        viro@zeniv.linux.org.uk, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com, trondmy@primarydata.com
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 18 Apr 2018 15:39:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180418192359.n4q53bvsdhrjftjg@madcap2.tricolour.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041819-0044-0000-0000-00000407604D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008878; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019830; UDB=6.00520310; IPR=6.00799072;
 MB=3.00020647; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-18 19:39:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041819-0045-0000-0000-0000083965AD
Message-Id: <c1ec93a2-b398-373c-55da-b2be8e60c6b6@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180176
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/18/2018 03:23 PM, Richard Guy Briggs wrote:
> On 2018-04-18 14:45, Stefan Berger wrote:
>> On 03/15/2018 11:58 PM, Richard Guy Briggs wrote:
>>> On 2018-03-15 16:27, Stefan Berger wrote:
>>>> On 03/01/2018 02:41 PM, Richard Guy Briggs wrote:
>>>>> Implement the proc fs write to set the audit container ID of a process,
>>>>> emitting an AUDIT_CONTAINER record to document the event.
>>>>>
>>>>> This is a write from the container orchestrator task to a proc entry of
>>>>> the form /proc/PID/containerid where PID is the process ID of the newly
>>>>> created task that is to become the first task in a container, or an
>>>>> additional task added to a container.
>>>>>
>>>>> The write expects up to a u64 value (unset: 18446744073709551615).
>>>>>
>>>>> This will produce a record such as this:
>>>>> type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
>>>>>
>>>>> The "op" field indicates an initial set.  The "pid" to "ses" fields are
>>>>> the orchestrator while the "opid" field is the object's PID, the process
>>>>> being "contained".  Old and new container ID values are given in the
>>>>> "contid" fields, while res indicates its success.
>>>>>
>>>>> It is not permitted to self-set, unset or re-set the container ID.  A
>>>>> child inherits its parent's container ID, but then can be set only once
>>>>> after.
>>>>>
>>>>> See: https://github.com/linux-audit/audit-kernel/issues/32
>>>>>
>>>>>
>>>>>     /* audit_rule_data supports filter rules with both integer and string
>>>>>      * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
>>>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>>>> index 4e0a4ac..0ee1e59 100644
>>>>> --- a/kernel/auditsc.c
>>>>> +++ b/kernel/auditsc.c
>>>>> @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
>>>>>     	return rc;
>>>>>     }
>>>>>
>>>>> +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
>>>>> +{
>>>>> +	struct task_struct *parent;
>>>>> +	u64 pcontainerid, ccontainerid;
>>>>> +	pid_t ppid;
>>>>> +
>>>>> +	/* Don't allow to set our own containerid */
>>>>> +	if (current == task)
>>>>> +		return -EPERM;
>>>>> +	/* Don't allow the containerid to be unset */
>>>>> +	if (!cid_valid(containerid))
>>>>> +		return -EINVAL;
>>>>> +	/* if we don't have caps, reject */
>>>>> +	if (!capable(CAP_AUDIT_CONTROL))
>>>>> +		return -EPERM;
>>>>> +	/* if containerid is unset, allow */
>>>>> +	if (!audit_containerid_set(task))
>>>>> +		return 0;
>>>> I am wondering whether there should be a check for the target process that
>>>> will receive the containerid to not have CAP_SYS_ADMIN that would otherwise
>>>> allow it to arbitrarily unshare()/clone() and leave the set of namespaces
>>>> that may make up the container whose containerid we assign here?
>>> This is a reasonable question.  This has been debated and I understood
>>> the conclusion was that without a clear definition of a "container", the
>>> task still remains in that container that just now has more
>>> sub-namespaces (in the case of hierarchical namespaces), we don't want
>>> to restrict it in such a way and that allows it to create nested
>>> containers.  I see setns being more problematic if it could switch to
>>> another existing namespace that was set up by the orchestrator for a
>>> different container.  The coming v2 patchset acknowledges this situation
>>> with the network namespace being potentially shared by multiple
>>> containers.
>> Are you going to post v2 soon? We would like to build on top of it for IMA
>> namespacing and auditing inside of IMA namespaces.
> I don't know if it addresses your specific needs, but V2 was posted on
> March 16th along with userspace patches:
> 	https://www.redhat.com/archives/linux-audit/2018-March/msg00110.html
> 	https://www.redhat.com/archives/linux-audit/2018-March/msg00124.html
>
> V3 is pending.
Thanks. I hadn't actually looked at primarily due to the ghak and ghau 
in the title. Whatever these may mean.

Does V2 or will V3 prevent a privileged process to setns() to a whole 
different set of namespaces and still be audited with that initial 
container id ?

