Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+8xMfsXTN6Wa+0xqdTB3UZ/Of3iJhWbF1RuH0fbYnHzW0UdbPac4uNbtkgCDAgo6Zg7pKr
ARC-Seal: i=1; a=rsa-sha256; t=1522270045; cv=none;
        d=google.com; s=arc-20160816;
        b=KVsFwKHCTNBhcU19V4Qm9i4o0RmU2KZfknOl2TKDz1PYKrqqy2TRwiDL9VNQZJnF7J
         er2kPlyQLU572GSd+xwOCOadnpRIQWH1W7WTQT3WuBG6fMCUtFHWmWjXBO4AFEx6m+o0
         lcdEveRmXj3E/1cjHBwapBkctlV/Fc3vkZbx6ktLTDJFJc85X2nd0AONtrmyxkSly/bL
         M3ZzjK5SWcENWNNE6P7Xh8vNBlSJlVE8lq9MUx9DiG2u8S8PZ/tu/WTExU++Oy+lqnxH
         U5GxlmMm0SuqpIGEKHquLVl89XNpwmbNxCTApJKNTdZUANBTblIAAO2m7sBuv0gQuR1J
         5FfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:mime-version:date:in-reply-to
         :subject:cc:to:from:user-agent:references:arc-authentication-results;
        bh=4EQTTy1IwcQLRfbgw+7tHRIZ0ROsWMdVETxTrr8pZ+w=;
        b=nNeM/ATBJean+un1i6IBlzVelivYzT8JYWvVG1vaz1C40V4P1NoqoiCxUwMwJjhc5n
         h5ax5NKgTsTXyJq0VE9vVLyoEuvSpcNPEP87g9CAWTp60OjzS8MkqlIWNVWgDdSn+dEb
         Vp39PiKJMc+JlUc+WK6VVBCQyB4WjzCz+8jkJSkyIetpdvaai+XuJF21oU/HFE3KqWW0
         4uys4bazRa9eyilVdjuiEMtTBvyH+TGASk9VRMaw3CMlN/IFG9gRq60CvrFQVj0M233b
         ARVx9Ydi3D4pD0LA6Rusy7BCvQex6tKv+8QX/4CcMCl1eMiJHtPc+/K5GopMjcRKhYDl
         jtmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752887AbeC1UrY (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Mar 2018 16:47:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752828AbeC1UrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Mar 2018 16:47:23 -0400
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com> <1519264541-7621-8-git-send-email-linuxram@us.ibm.com> <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
User-agent: mu4e 1.0; emacs 25.3.1
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        akpm@linux-foundation.org, benh@kernel.crashing.org,
        paulus@samba.org, khandual@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
        hbabu@us.ibm.com, mhocko@kernel.org, ebiederm@xmission.com,
        arnd@arndb.de
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in pkey_disable_clear()
In-reply-to: <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
Date: Wed, 28 Mar 2018 17:47:04 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18032820-0028-0000-0000-0000095D5E44
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008760; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009784; UDB=6.00514431; IPR=6.00789066;
 MB=3.00020296; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-28 20:47:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032820-0029-0000-0000-00003A268C07
Message-Id: <87muys3p2v.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280212
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064680200522222?=
X-GMAIL-MSGID: =?utf-8?q?1596215835347130613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Dave Hansen <dave.hansen@intel.com> writes:

> On 02/21/2018 05:55 PM, Ram Pai wrote:
>> --- a/tools/testing/selftests/vm/protection_keys.c
>> +++ b/tools/testing/selftests/vm/protection_keys.c
>> @@ -461,7 +461,7 @@ void pkey_disable_clear(int pkey, int flags)
>>  			pkey, pkey, pkey_rights);
>>  	pkey_assert(pkey_rights >= 0);
>>
>> -	pkey_rights |= flags;
>> +	pkey_rights &= ~flags;
>>
>>  	ret = pkey_set(pkey, pkey_rights, 0);
>>  	/* pkey_reg and flags have the same format */
>> @@ -475,7 +475,7 @@ void pkey_disable_clear(int pkey, int flags)
>>  	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
>>  			pkey, rdpkey_reg());
>>  	if (flags)
>> -		assert(rdpkey_reg() > orig_pkey_reg);
>> +		assert(rdpkey_reg() < orig_pkey_reg);
>>  }
>>
>>  void pkey_write_allow(int pkey)
>
> This seems so horribly wrong that I wonder how it worked in the first
> place.  Any idea?

The code simply wasn't used. pkey_disable_clear() is called by
pkey_write_allow() and pkey_access_allow(), but before this patch series
nothing called either of these functions.


--
Thiago Jung Bauermann
IBM Linux Technology Center

