Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526294502-2-8877779439036470986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526294502; b=DC8b9Wvph5MBwm6TMFWt6g6POEg5L/kkBeAhsiehnoyra5PaCk
    OJ6bTFw5kZ34pz1zVjR05XqTiKBQOnZwYLWjPCAu0dtFVOvnHPwCuwek5aC+iPWL
    BDpbW8Toi8n7GW8QYtOuO7G1gKCFJEuX9wABxJNeYsr6e1tAyoWN00BiOXsZJMKq
    yljMpbcPLH6T/hOhVQFS8gaCAFzSjKZjCu7gzMjvAUdMyyRTkm7Cux1uObSF+LHN
    9GbvOBaW1wXoyprKA4yXSDDLnavB7RmQLM23M181ktcgHmjiWq0QRsTDJe/tYkdi
    CUsjH0am2msgWJf54GyeRYZBjvtiJbZ+U4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1526294502; bh=iCrrqR4RLZQ1
    yy4SLCLfP+S1S6skeQqo/TRiYRzQi0A=; b=bygLQDWpyeQ+ChHwXyEtr+tXCMWv
    mz/2153KSQwheOE4tC+BZ/ujQCfaa4yBZKM5e0sFd4hVDIx4tNtXm4t/0McPevBl
    5et6A6p7QVqU+5qtj5Ecn7uUJ5edUtkBHkUe/DGBkHzlc3e0Z5Umxm+USEFbqviv
    jHfFH788OLUS4YxxJBmInKAka+KUFBLgMJArh9D69zcRc6JYkVS6Ebdx5WzMoEAG
    Gjh2erNnPX3y5jxvpGJnjdJxtCrCfvs3Oc6/D26uNIhKngLWPHeC2eWHGs/eyC49
    B5tBGEUVdlo2QxDAKZpI8TUV+oJ9tmclho8eCWFI5lGKFY4v1kKjDHBLcA==
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
    x-vs=clean score=0 state=0
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIZTc5UJtnEqkXKyQbKTwmO8YZcHOD55oGRHybSDNfoYyYkBKf2Q8IsPAmEvlIEmbjv5iXmVb3MOp+kP0xNOowqMGXeAf/PDxziYFldZ/OM4QI85qI9x
    IOAeXdC69HDtMzhlFuEMyqia/gZXsCybaLCXuzO5RfD1KmzQ8WXIb41Zd/fGPvYfw1cFcle/EaexDfOGlhBPLzh0AFjgu+zjExTCEfRMKK9QhaG91mJYaDfA
    p45Lt5eLK/YuAFTCbo3reg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=rfv-BnDkNG9hx1l8uFUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeENKlj (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 06:41:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751596AbeENKli (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 06:41:38 -0400
Subject: Re: [PATCH v3 1/2] tpm: reduce poll sleep time in tpm_transmit()
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: J Freyensee <why2jjj.linux@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com
References: <20180507160733.8817-1-nayna@linux.vnet.ibm.com>
 <20180507160733.8817-2-nayna@linux.vnet.ibm.com>
 <becb898c-b778-d104-5781-899599f536d4@gmail.com>
 <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 16:09:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <107cd9f7-69a3-dbb8-1a61-541172832a0c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051410-0052-0000-0000-000002EE31BC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009023; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032126; UDB=6.00527630; IPR=6.00811258;
 MB=3.00021102; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 10:41:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051410-0053-0000-0000-00005CAD9BD7
Message-Id: <4896f0b6-70b7-77ad-1b33-f13890b6fec2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140111
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/10/2018 06:11 PM, Nayna Jain wrote:
>
>
> On 05/08/2018 10:04 PM, J Freyensee wrote:
>>
>>>           do {
>>> -            tpm_msleep(TPM_POLL_SLEEP);
>>> +            tpm_msleep(TPM_TIMEOUT_POLL);
>>>
>> I'm just curious why it was decided to still use tpm_msleep() here 
>> instead of usleep_range() which was used in the 2nd patch.
>
> TPM_TIMEOUT_POLL is in msec i.e. 1 msec and usleep_range() is used 
> only when timeout is needed in usecs.

Just to add bit more details:

usleep_range() is used in wait_for_tpm_stat() and get_burstcount() which 
are expected to return quickly. tpm_transmit() is a generic function 
used across all drivers and commands.
Some of the commands (eg. hash, key generation) take longer compared to 
other commands (eg. extend). The sleep time in tpm_transmit is reduced 
but kept in msecs to balance between the smaller and longer commands.

Thanks & Regards,
     - Nayna

>
>>
>> Otherwise,
>>
>> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
>
> Thanks !!
>
> Thanks & Regards,
>     - Nayna
>
>

