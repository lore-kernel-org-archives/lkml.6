Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-847009-1526502544-2-16061988483022415898
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526502544; b=QF+CoYckNR9mQM2A3FKpOnnNZIzSHLhHZtevMGiOvQjddgCK4i
    DZp6dITiBZWAHbXXl0av+HVlC8DHcvkFo63rFj6F12xMfJbfaMWrU2k4P+Dn8Ux4
    IJcLI0qLjxee2OneHBvXZcO6+UHbTksHArAuebHWy4WS3TczYcOFMt4HuV56uGci
    8c1ySubxQakvNlB3w4nuIS4xhT9PMO/wiHjdgkcFG5Ko7KmmgzEAfi0kbnvk1tGF
    ym3lBXmIkdnsxDS6psFVM0Vb+oKfENmS8dfxpAoWArmkHjv5EmllBpYrSLJAjSAQ
    GBcIhSmsDD0uDffRwX0luEzVlZnROv8YrlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1526502544; bh=ezAGBcbNqPhm
    0mI1N1krcfyfNeYX4IZ6uXGD5mli6b0=; b=UuMRAjr4kVkGwimfFBTqxWODWo25
    wtKxcGrieJFX75SqlT4l43M+bnMyUntE7Di4A90zY277jPh0PciiBqg2hybIQtgO
    GhkFs8a44mEvPQtcjdzmbNN30zVlipRih4/oD7+XTv2F+189sIFS6uYyr+JpEFD+
    uONWAuaZ2L87MaifDmy5QCt4Umg4Gpz/FFJSFc5fRSqG0YgJ/y/0KKoZG/cK9lOU
    waFD5A/MR+kYv4V1o5NlY2K/BO7ijmkaLSvRUeqX8Nrdv9LdyjLn+8Oulu4sWPpn
    h38i6szESXxpFiME7kpk/zHt8jWEwFw5vbbNnmnfBSaeNmKlwA74STjeyQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL6UKMN73wtCTvRybtHN6A9KrT8nOSqIzhWTMrxIUbHRMIQCha3hK1PoQOeJ+cc+oUmvszoOwB1pWlmIoM8J28iN6PeMNvCO5EoFZkzjGY7bClKfXkpR
    FrqMTo2s51NrG2Svx5CeB619lLNK3CGqdGTEdnh6sAhCT9gnlgvcVwU+vJk86Zdlj67B7gV5IQBpCpw70zSQDOy0ec0yYy8VZ5ru7DBtC9l2CaJ0znfUUsGC
    CnFsI9vFs5mWeKLuPxixrA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=dA6hJaGtfkUZ_AS5B9oA:9
    a=QEXdDO2ut3YA:10 a=-bWi_RMRg4sA:10 a=x8gzFH9gYPwA:10 a=_2N7QWRe9ZMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeEPU3B (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 16:29:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751033AbeEPU3A (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 May 2018 16:29:00 -0400
Subject: Re: [RFC PATCH v4 3/5] ima: differentiate auditing policy rules from
 "audit" actions
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: serge@hallyn.com, sunyuqiong1988@gmail.com, david.safford@ge.com,
        mkayaalp@cs.binghamton.edu, James.Bottomley@HansenPartnership.com,
        ebiederm@xmission.com, john.johansen@canonical.com
References: <20180511144230.75384-1-stefanb@linux.vnet.ibm.com>
 <20180511144230.75384-4-stefanb@linux.vnet.ibm.com>
 <1526391655.3937.151.camel@linux.vnet.ibm.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 16:28:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526391655.3937.151.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
x-cbid: 18051620-0012-0000-0000-00001640194C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009036; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01033282; UDB=6.00528322; IPR=6.00812413;
 MB=3.00021149; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-16 20:28:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051620-0013-0000-0000-000052CC0363
Message-Id: <2496f165-67f7-304d-08a0-ea8eedd3c3d4@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160201
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/15/2018 09:40 AM, Mimi Zohar wrote:
> Hi Stefan,
>
> On Fri, 2018-05-11 at 10:42 -0400, Stefan Berger wrote:
>> From: Mimi Zohar <zohar@linux.vnet.ibm.com>
>>
>> The AUDIT_INTEGRITY_RULE is used for auditing IMA policy rules and
>> the IMA "audit" policy action.  This patch defines AUDIT_INTEGRITY_POLICY
>> to reflect the IMA policy rules.
>>
>> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> We do need to separate out auditing the IMA policy rules from the
> "IMA-audit" messages.  Based on the IMA policy rule aspect of the
> discussions [1],  I would really appreciate if you could work with
> Richard and Steve on the new IMA policy rule audit format.
Is your patch below still valid for splitting it up into 'two distinct 
audit record types' ?

>
> This change can be upstreamed independently of either the IMA
> namespacing or the audit containerid patch sets.  The sooner we make
> this change and upstream it, the better.
>
> [1] https://www.redhat.com/archives/linux-audit/2018-March/msg00092.html
>
> thanks,
>
> Mimi
>
>> ---
>>   include/uapi/linux/audit.h          | 3 ++-
>>   security/integrity/ima/ima_policy.c | 2 +-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 4e61a9e05132..8966e7ff1c4c 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -146,7 +146,8 @@
>>   #define AUDIT_INTEGRITY_STATUS	    1802 /* Integrity enable status */
>>   #define AUDIT_INTEGRITY_HASH	    1803 /* Integrity HASH type */
>>   #define AUDIT_INTEGRITY_PCR	    1804 /* PCR invalidation msgs */
>> -#define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>> +#define AUDIT_INTEGRITY_RULE	    1805 /* IMA "audit" action policy msgs  */
>> +#define AUDIT_INTEGRITY_POLICY	    1806 /* IMA policy rules */
>>
>>   #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
>>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index 915f5572c6ff..3a1412db02a3 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -619,7 +619,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>>   	bool uid_token;
>>   	int result = 0;
>>
>> -	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_RULE);
>> +	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_POLICY);
>>
>>   	entry->uid = INVALID_UID;
>>   	entry->fowner = INVALID_UID;


