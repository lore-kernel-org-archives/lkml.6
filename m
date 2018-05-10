Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2107488-1525956227-2-16819707719193705752
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525956226; b=Auv0VN/BC5tSm3W/5U710R/TSDMDPF3dcO6Zx+twILjn0gjMOQ
    1maQZCu3+8+ZbT1QKMNCuTgKS8unRjVNwKvqxGCFnc1UD6uX+teel4SEFRWtBc7G
    eM5i3LHSw6K0LBGlTOGDL6wJ+c1Lg2N19QOkVCbZjFFg6srlb+TU+Yjo/+FOkMPo
    GP5fHeWmYdD+vQFqmQU0wxD0gNabWWeMVFSNATqPqeSGwtuyiskxDHyrtFJcXue2
    hq6Sksz0V5wOH4XsBat7GyTnhorTJiMXEU9FMwcGmsw4Pid0K9BeKh4Aa3VDEVam
    ZcoNGDvc1t1JCMQs0Il9yvxyrVcUTzL6WZsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1525956226; bh=Ha8eN5/CTife
    dC35MM1FCXtacBkoKS6woVbpVQCcDJI=; b=jZKruOzjS9NNSRNsh5tSlUWl99+v
    7xlp0EiutryTIaT98VovG54FaSI1lea595q2l4fs/XO0dmBSpeV+h5CsqRxxQ3Pe
    Zfe0TW+O1hVC+ZfRYLtirpxpQtXHA+2A7GasCSg5J3gsUb2wZHGQK2NC2bwSj01e
    WZJYobUSDO3L3Z+utCkLoS/c8c9SUAEouGuhIeImz6Y8KmRWB6Jn9pgHBYBJmnNC
    CdAqE+GC0ImWxysrURw8BB5o2k9FjFJrzIpKFHwJyEqbL4UYcjrKVu6/O0kgYoua
    xOOjr9OuRrrmplkPc4qrzIdwe16oAwvBx5WEzIaUjxJ0HfTkPEfZzlAQrg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNqBMvcinGbIxit5iY8puIereo0qU4oi5XC1NImykUviMsFn/vCVb3oGnDzyZW5DK66f4S0ojPh9dgJcqYVmGApz0DUpla7JraiwqxhfpKiimpbRRbYs
    Nhu3jEaD0QbzPtZ/LemZlAFsdjRoQ7ueGw/QvRm8Ibj8P86NQtrgLVJFwoPmzWkkgXCRT7pPHLFU9mwSRP6HcUI0AVga/9SD8r2S4LtohkSNPz5Fz3g7mYCs
    KVpjli5BBP9r0LmkChXkrA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=6nUXITN49fC6jhMlmTEA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964801AbeEJMnn (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 08:43:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935042AbeEJMnm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 08:43:42 -0400
Subject: Re: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
To: J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
 <becb898c-b778-d104-5781-899599f536d4@gmail.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Thu, 10 May 2018 18:11:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <becb898c-b778-d104-5781-899599f536d4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051012-0056-0000-0000-0000044C6C40
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009000; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000259; SDB=6.01030247; UDB=6.00526509; IPR=6.00809378;
 MB=3.00021030; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-10 12:43:39
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051012-0057-0000-0000-000008907B35
Message-Id: <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805100123
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/08/2018 10:04 PM, J Freyensee wrote:
>
>>           do {
>> -            tpm_msleep(TPM_POLL_SLEEP);
>> +            tpm_msleep(TPM_TIMEOUT_POLL);
>>
> I'm just curious why it was decided to still use tpm_msleep() here 
> instead of usleep_range() which was used in the 2nd patch.

TPM_TIMEOUT_POLL is in msec i.e. 1 msec and usleep_range() is used only 
when timeout is needed in usecs.

>
> Otherwise,
>
> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>

Thanks !!

Thanks & Regards,
     - Nayna


