Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422737-1524844456-2-7545655440695303645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524844455; b=WFYzxic0m1irUeiLa/ZgJXG41v7MRrruItf7U0nAyb1KLFV9EI
    A+dE6rFncAHmrJ65VN/3ldj4deDKIfrNsFYeEZsowmcyPY5I+Hgdk9TexyfvhWuA
    mAdpiSLXK8S6JqfvITReSU6f2kQykC8CTxT4Adnl+TxBJHZMfS30/l4ePBAXIg6g
    gkBjZC4prEr0V0etNZnTIk/dADJzSq35ANUW9FRuGLVIKFXDrzOGDhR+MBlvqqNl
    CC8yvFCcB7G9Og2VZgyYQx+np/ZF//gIjhClw52NEzHQham6MV6QWecoyOM/orMC
    RN4Js4LnjBWizSkKcSapZzdbDKMEwFLmJ9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524844455; bh=wpJFzKOpFbxI
    iP1O0PGEuOfVyhXp365FT7fYKDQIyiw=; b=H+OLij8gb82oexG86jT/aT0unYv8
    BZD4vVMjXejoot03pGrXPZLwHQhB0UFj3vZ/l1L5F2CnOSEeS5uO4dlWyZY5mtGa
    L+rhdk0f0IKHVFxPETtHaRfltIXQ7lOpDjH/2IfsM+AOH/0mMZ+1j9mN32suOtor
    azyRFDs4a1aQCux7YA87+sAv6N8sVLpHmX694zSm6nNe3UScC8Xu+XHEerBjXoH4
    fHjcIwOLddtE25PDNlhXR3PtU9bqtsXFs4vF5rLGj7s21mH3KjWsh0H6xPGO2VCN
    VSV9Ghg9aKPvY+m4fpChT/0/WeL8Th5/X3wnxzL7uBy4l0fkj8aQWnXrEg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=de.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=de.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIC4dUbzCcwLa9gy/kr5WQDGjnlaZwVKR9YXleDdn9MmmbfBkZ05yNR/l/ueAIXeQq/Z7Vd/2JLHOqAlaYcV6tEWIjMiYP6mbVsi5AifHrGUMDY869Dm
    urVbCxG/iECIScEm1o2oaG6PQGF3s4TEzePXeKybntzM/riOTFu2AgZSAB9Vju2os8bZi8IlumS+hA5WjMJwcnYozFmuWmXF/hYLarYI8SWXjCgCH0rv5JD5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=dhuEvT4pT64O_vYcsA0A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758555AbeD0Pxy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:53:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758486AbeD0Pxy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 11:53:54 -0400
Subject: Re: [PATCH 4.4 12/50] KVM: s390: wire up bpb feature
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20180427135655.623669681@linuxfoundation.org>
 <20180427135656.428437126@linuxfoundation.org>
 <2764478b-8acb-653b-779f-1fb51d9a5931@de.ibm.com>
 <20180427151715.GA3876@kroah.com> <20180427154650.GA15121@kroah.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Date: Fri, 27 Apr 2018 17:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180427154650.GA15121@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042715-0008-0000-0000-000004F0C752
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042715-0009-0000-0000-00001E84D59E
Message-Id: <f8e1244f-d5b8-1eb9-4e71-fb4b0dd7d610@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804270152
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/27/2018 05:46 PM, Greg Kroah-Hartman wrote:
> On Fri, Apr 27, 2018 at 05:17:15PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, Apr 27, 2018 at 05:10:04PM +0200, Christian Borntraeger wrote:
>>>
>>>
>>> On 04/27/2018 03:58 PM, Greg Kroah-Hartman wrote:
>>>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>>>
>>>> ------------------
>>>>
>>>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>>>
>>>>
>>>> From: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> Ick, that is wrong right there, my scripts messed up, this should not
>> have 2 author lines :(
>>
>> I'll go look at all of these, odds are it made the same error
>> everywhere...
> 
> Yes, I've now fixed that up in the queue.

As this patch backport was also functionally incorrect and Martin is already away
do you want me to send an updated version?
