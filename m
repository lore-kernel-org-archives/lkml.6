Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1014489-1524077134-2-10864898960975964854
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
    1524077134; b=aARUZjldCYtPsnSrM7miVo2o1Aq5i1Qvekpl375xvbRl2FZOsx
    7PPXrlvIuoCRopDdoyBZtnkDJdQ+9/Ral7bHlGZllQChgEJyKoqK51CR0f6iGn+W
    cRQl8uvcUi1nSluYFdwwLAGyKFtn5pTcCU1h9Mw1F+BCYYndBYJ5/3u49FTYQ4Ky
    y07pMWMA9PMF5Ou6cW5z5G9QzwsC46kE3s8sxTgeBILg8OE/gKclZrrHgiCYnbWm
    //xC1yjrncyqnT70nSm/stpeE3vgfOo/RycI0B3RyQeuUTyXMfQtyH3fSQdAaNq6
    DlMevpwpz+DZPPEdMKG/bzd6WQZfRMrcnr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524077134; bh=nDF4/Bbdzsbl
    vp+aQo9fE/Un1AiS2qlWwvtB5uzxiAA=; b=Nv+otb/9oPlEVSPOORStVD6qKfmL
    YKPevOHd5JbTnTA0KgQa6sC3e4UpqAgUARTsmdtNjVS2y+9qD8UNX+/5cCbGChGF
    pnFgcGYmMrDaoX7CbyK8tIGlsCB1OvW56LczoQoBOqN0PV029hsno5qkF5VQi11c
    X39ltEbbIWvOBJ2ZalhCv4LhxJlfqCJmY9Uj3qV5tvFol6Dh8tfpG82fYoTPs2Cl
    C9qbRD5OOjYCTuOQME5CYBQJN0BVXrVtsWqXaTkkDPmGPPM9LFC+E1Y+ZOyZep1V
    vdNQuRLvBwnoMimEbRHtuY1RHMwy8UOtt7XglkniYD/aOz0LpQNTprUleA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfEil1aEMKoy0qllSLLG2fYxeXYGprsevfqaGuweBMAicQ0+p5w11jlwgghzgiYI5yx2VgbayrJ2VUCn5g8TPuIooc+UOthwoqJL3RK3oJhEmNxqUzJsq
    EHnqv+Ovn2Y5XkJIHR5pBDAAGq507NJqtr5xSMYxpX0D2RGk2dikdccX3def2XB3wUR6UMWTH9KNsakMAGka59zFwtk6sNxYkIwRfu9OiyvzMPx0q6qG/Sva
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=N659UExz7-8A:10 a=Kd1tUaAdevIA:10
    a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=U9YiKlm-kBj-qIaJ8nYA:9 a=pILNOxqGKmIA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeDRSp3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 14:45:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752647AbeDRSpZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 14:45:25 -0400
Subject: Re: [RFC PATCH V1 01/12] audit: add container id
To: Richard Guy Briggs <rgb@redhat.com>
References: <cover.1519930146.git.rgb@redhat.com>
 <2e5d93ee46feca915a101c2fc3062da674a98223.1519930146.git.rgb@redhat.com>
 <216d1ab1-531b-9185-2e31-34f162f08aad@linux.vnet.ibm.com>
 <20180316035837.ddnqvbyrbp3fdk7e@madcap2.tricolour.ca>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, mszeredi@redhat.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, simo@redhat.com, trondmy@primarydata.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        madzcar@gmail.com
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 18 Apr 2018 14:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180316035837.ddnqvbyrbp3fdk7e@madcap2.tricolour.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041818-0028-0000-0000-000009770F10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008878; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019812; UDB=6.00520300; IPR=6.00799054;
 MB=3.00020646; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-18 18:45:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041818-0029-0000-0000-00003A6E568B
Message-Id: <f966fa52-da4b-3d74-0848-1f0b08e57fd9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180167
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/15/2018 11:58 PM, Richard Guy Briggs wrote:
> On 2018-03-15 16:27, Stefan Berger wrote:
>> On 03/01/2018 02:41 PM, Richard Guy Briggs wrote:
>>> Implement the proc fs write to set the audit container ID of a process,
>>> emitting an AUDIT_CONTAINER record to document the event.
>>>
>>> This is a write from the container orchestrator task to a proc entry of
>>> the form /proc/PID/containerid where PID is the process ID of the newly
>>> created task that is to become the first task in a container, or an
>>> additional task added to a container.
>>>
>>> The write expects up to a u64 value (unset: 18446744073709551615).
>>>
>>> This will produce a record such as this:
>>> type=UNKNOWN[1333] msg=audit(1519903238.968:261): op=set pid=596 uid=0 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 auid=0 tty=pts0 ses=1 opid=596 old-contid=18446744073709551615 contid=123455 res=0
>>>
>>> The "op" field indicates an initial set.  The "pid" to "ses" fields are
>>> the orchestrator while the "opid" field is the object's PID, the process
>>> being "contained".  Old and new container ID values are given in the
>>> "contid" fields, while res indicates its success.
>>>
>>> It is not permitted to self-set, unset or re-set the container ID.  A
>>> child inherits its parent's container ID, but then can be set only once
>>> after.
>>>
>>> See: https://github.com/linux-audit/audit-kernel/issues/32
>>>
>>>
>>>    /* audit_rule_data supports filter rules with both integer and string
>>>     * fields.  It corresponds with AUDIT_ADD_RULE, AUDIT_DEL_RULE and
>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>> index 4e0a4ac..0ee1e59 100644
>>> --- a/kernel/auditsc.c
>>> +++ b/kernel/auditsc.c
>>> @@ -2073,6 +2073,92 @@ int audit_set_loginuid(kuid_t loginuid)
>>>    	return rc;
>>>    }
>>>
>>> +static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
>>> +{
>>> +	struct task_struct *parent;
>>> +	u64 pcontainerid, ccontainerid;
>>> +	pid_t ppid;
>>> +
>>> +	/* Don't allow to set our own containerid */
>>> +	if (current == task)
>>> +		return -EPERM;
>>> +	/* Don't allow the containerid to be unset */
>>> +	if (!cid_valid(containerid))
>>> +		return -EINVAL;
>>> +	/* if we don't have caps, reject */
>>> +	if (!capable(CAP_AUDIT_CONTROL))
>>> +		return -EPERM;
>>> +	/* if containerid is unset, allow */
>>> +	if (!audit_containerid_set(task))
>>> +		return 0;
>> I am wondering whether there should be a check for the target process that
>> will receive the containerid to not have CAP_SYS_ADMIN that would otherwise
>> allow it to arbitrarily unshare()/clone() and leave the set of namespaces
>> that may make up the container whose containerid we assign here?
> This is a reasonable question.  This has been debated and I understood
> the conclusion was that without a clear definition of a "container", the
> task still remains in that container that just now has more
> sub-namespaces (in the case of hierarchical namespaces), we don't want
> to restrict it in such a way and that allows it to create nested
> containers.  I see setns being more problematic if it could switch to
> another existing namespace that was set up by the orchestrator for a
> different container.  The coming v2 patchset acknowledges this situation
> with the network namespace being potentially shared by multiple
> containers.

Are you going to post v2 soon? We would like to build on top of it for 
IMA namespacing and auditing inside of IMA namespaces.

    Stefan

