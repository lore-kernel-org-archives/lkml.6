Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3943267-1524036173-2-11411959023479686216
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524036173; b=YmRq7CJIZmjiPzwFcOD+AE3H+W/dYB6OLjtQKMbeP4T8DeOcSC
    pIVVAfTUhjElxVzx1wvEGIeAMey464nxWR3ICGS4h390sfxzaLLzAuHOl6xlOAt2
    Uaaj/9Z5UvzkZwuT+9c/Q1pcfx10nGfP0iuEGKtP/76C40eVgfBT9IzOXP85MU+J
    MWK8lbeLJN83ZmiieKx1txIpmaxO11hOVrc6HsN3tLik3+xQVMmcKsOeRBJK06PU
    iDj0aHqz/V7GIPLpWR3Mu8M5F8E3Z9NFWUY8ZaL+8wAkPyUP8xo64JHheTqKY8wz
    ww+4Puw++Ih6UGC385eEeS5SzLMCKWwSHuZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1524036173; bh=CnB0kYK4ce65
    Ua1g2CqDM6yWyWyGUyWV997wLsV+TU0=; b=i3qwKWiSmbM0dcbsYSIXqNKaHWhF
    WBTeYdNeDi9pX6zMZybYnPWVVCs0m4FFoFRSdRXyGUkOvzUTELxcedRlRx5pKTWU
    6Uy3NtARVEyUvxtLmtpARnxS6B4W+lMyGfFEUQXgvAi0uD/7cPcyZtnYpzsXNxdC
    6Hrclv4dEfYGV47gLO6B2nmcgowVrs4bU0pUbh+eCgehsRSx4fyxynBfW+n66++K
    0NN2C+qKB1lVxUOWylAdp1C/y1hasgy7NEXE172zgWj6IP6B1GlmDuA/P+ubyJcO
    T+Dwp+pWLa1QE/1sIwCrJBrcKmKQjuNu6mYC4PYd7lJzQhzL0yiyZWB9jA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJwVTBK3je7rwT49D9kBMd8KWeJPzCIXe9/+nSLrxP7E8R10N900pINCE1gC1ps05vZeXbawmEmm/7zZzFN6j2pzAGLAcWLx9cMlawkUcd3W083uPlaz
    DBiNi0Vuqxb3lN95cP138jdbXmQamcKoy+gYngIqvH64RepGDdX7+QdAF2LcOFUwJcW4KYlU+kXG/zdrJUgkFb2spYJvuYaa2NL2sID9c+jaP1kJOuqrRvyT
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=VnNF1IyMAAAA:8 a=0Bp8YTwOAzDgjGqoHC0A:9
    a=Rf4N0vrutWrSMj7M:21 a=omYvkQoRJekBR1HJ:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeDRHWk (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 03:22:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752760AbeDRHWj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Apr 2018 03:22:39 -0400
Subject: Re: [PATCH v3] module: Fix display of wrong module .text address
To: "Tobin C. Harding" <me@tobin.cc>
Cc: jeyu@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com,
        heiko.carstens@de.ibm.com, peterz@infradead.org, acme@kernel.org,
        keescook@chromium.org, stable@vger.kernel.org
References: <20180418071436.21392-1-tmricht@linux.ibm.com>
 <20180418071724.GA6892@eros>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Wed, 18 Apr 2018 09:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180418071724.GA6892@eros>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041807-0012-0000-0000-000005CC1A0D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041807-0013-0000-0000-000019486957
Message-Id: <72461e74-2229-bf33-cbce-9a016bef4df9@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180068
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/18/2018 09:17 AM, Tobin C. Harding wrote:
> On Wed, Apr 18, 2018 at 09:14:36AM +0200, Thomas Richter wrote:
>> Reading file /proc/modules shows the correct address:
>> [root@s35lp76 ~]# cat /proc/modules | egrep '^qeth_l2'
>> qeth_l2 94208 1 - Live 0x000003ff80401000
>>
>> and reading file /sys/module/qeth_l2/sections/.text
>> [root@s35lp76 ~]# cat /sys/module/qeth_l2/sections/.text
>> 0x0000000018ea8363
>> displays a random address.
>>
>> This breaks the perf tool which uses this address on s390
>> to calculate start of .text section in memory.
>>
>> Fix this by printing the correct (unhashed) address.
>>
>> Thanks to Jessica Yu for helping on this.
>>
>> Fixes: ef0010a30935 ("vsprintf: don't use 'restricted_pointer()' when not restricting")
>> Cc: <stable@vger.kernel.org> # v4.15+
>> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Jessica Yu <jeyu@kernel.org>
>> ---
> 
> What's changed in each version please?
> 
> 
> thanks,
> Tobin.
> 

V2: Changed sprintf format string from %#lx to 0x%px (suggested by Kees Cook).
V3: Changed sprintf agrument from 0 to NULL to avoid sparse warning.

-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
