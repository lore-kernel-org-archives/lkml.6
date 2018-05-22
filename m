Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1586559-1526952333-2-12351171100237883332
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526952333; b=GDFgdxV4YLU/XSKscUP4uCMBS0PWqo2mV8VSnX2jo9hZg2y3UE
    MtbKKxfm13ilobAqMhRmFWoByew11lTYAOMnNFHBGowet2bPjJlZEo9zrSnnL0eh
    uvAYSrxrRXW4JydPZWblV2/v40Qz7ZBNry5C3NlztijR/v9w50Jg3ZJJzuMPafzI
    V3nVfccO/RXOCLeDBMP6D32b6Ubk8XAeSgXASX3SJaPz9ZAGW3/l1/p8MFvk+tvz
    veojn53xnkpytfyTnqiOU+Y/rw3gU9prRHtFNZ+WX5jQg7zm+Pwh6gkQ/oh5e/BA
    ZQnRmBzzq5pDdpIvYgCy0JvQyOTCOON/tomA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526952333;
    bh=avTrpxxKU/+F41CPF49bNLXbfvpV8q7XpDjGQTuWXSg=; b=Gy1hrNWTjKFa
    dMLMIrUhg+6M2kGs6pKqzga9ystOQsaRxCDVoC6tt9SouiBkxYLSBPA+VEEuITc0
    lefW5ZTx4MgOHVnqslUsHERlVM03S3PvogyUDYrgRw8tNev3Ql1T+SUChInZfVBh
    A+bbITEfIS3MSX7pRutohBgv2jwjSVNaayjiaCtAG70KnhtGGtwQQT13r0L17CHz
    frTk7PAD9d8z5OYrkXuRn4PwrL0DzrSxUmJOPIA8PKGS6vMH8e63OE2q/65g5ZGb
    kQN9441yC8R1iXCp+CQVLu6CCa22Z0oamQVLNn6XsXbTL26b3+SeyE1FH5WY2vHf
    hrbSAclU1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMNmfrjn3/197XxSajrDuasDnhenk6k3qRrpd49jiXJTXmuthglUkSx8elQ5Yppsx5e4i3Yl3AIWIUoRsWQnXUnd43OA6XKbqBasMdHi0Zehd+81whqT
    4iOb9Xso+y7OHJbctpvB97OArGkcMX6lbrtYHRWQIRn9ROI/wfy8CZkN8AzsS2VH2N0wWb8RWzXhBCTOSFIiLoBqWLobeyJPh5EGTL/LY8gb/NpFBL3hO4Sw
    cYYqdu53Tc2VSmELGEUVPQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=MyVaHAqUCHEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=DfNHnWVPAAAA:8 a=K6HrmWtEAAAA:8 a=hBqU3vQJAAAA:8
    a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=aGHLdmtl8EguY6c55xEA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=rjTVMONInIDnV1a_A2c_:22 a=yV38gEssg_2GhkhKF82i:22
    a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeEVBZa (ORCPT <rfc822;linux@kroah.com>);
        Mon, 21 May 2018 21:25:30 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42839 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751186AbeEVBZ3 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 21 May 2018 21:25:29 -0400
Subject: Re: [PATCH 26/33] apparmor: use match_string() helper
To: John Johansen <john.johansen@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-27-git-send-email-xieyisheng1@huawei.com>
 <06051489-f5fd-b7bd-d5be-db3706dbded3@canonical.com>
CC: James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <43468e7a-f166-151f-9e98-00a478a138f1@huawei.com>
Date: Tue, 22 May 2018 09:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <06051489-f5fd-b7bd-d5be-db3706dbded3@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi John,

On 2018/5/21 23:33, John Johansen wrote:
> On 05/21/2018 04:58 AM, Yisheng Xie wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
>>
> 
> Andy Shevchenko patch to do the same thing is already in apparmor-next

Sorry, I will drop this one.

Thanks
Yisheng
> 
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: linux-security-module@vger.kernel.org
>> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
>> ---
>>  security/apparmor/lsm.c | 25 +++++++++++--------------
>>  1 file changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index ce2b89e..9b5904f 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1378,14 +1378,12 @@ static int param_set_audit(const char *val, const struct kernel_param *kp)
>>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>>  		return -EPERM;
>>  
>> -	for (i = 0; i < AUDIT_MAX_INDEX; i++) {
>> -		if (strcmp(val, audit_mode_names[i]) == 0) {
>> -			aa_g_audit = i;
>> -			return 0;
>> -		}
>> -	}
>> +	i = match_string(audit_mode_names, AUDIT_MAX_INDEX, val);
>> +	if (i < 0)
>> +		return -EINVAL;
>>  
>> -	return -EINVAL;
>> +	aa_g_audit = i;
>> +	return 0;
>>  }
>>  
>>  static int param_get_mode(char *buffer, const struct kernel_param *kp)
>> @@ -1409,14 +1407,13 @@ static int param_set_mode(const char *val, const struct kernel_param *kp)
>>  	if (apparmor_initialized && !policy_admin_capable(NULL))
>>  		return -EPERM;
>>  
>> -	for (i = 0; i < APPARMOR_MODE_NAMES_MAX_INDEX; i++) {
>> -		if (strcmp(val, aa_profile_mode_names[i]) == 0) {
>> -			aa_g_profile_mode = i;
>> -			return 0;
>> -		}
>> -	}
>> +	i = match_string(aa_profile_mode_names,
>> +			 APPARMOR_MODE_NAMES_MAX_INDEX, val);
>> +	if (i)
>> +		return -EINVAL;
>>  
>> -	return -EINVAL;
>> +	aa_g_profile_mode = i;
>> +	return 0;
>>  }
>>  
>>  /*
>>
> 
> 
> 

