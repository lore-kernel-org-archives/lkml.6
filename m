Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48MI7mj7zpNCkEbKXFfmLwZ0575OY5VuRT0DNNdIbB+Tnx9eU6oqlSCrxk3Gz18EKlIcWVa
ARC-Seal: i=1; a=rsa-sha256; t=1522281121; cv=none;
        d=google.com; s=arc-20160816;
        b=HZTPC7NC1ycrIJtOycS27sX8myZkrG8du87+n/i9QnX6TtEw6jWg2uZTJ+OqExWwuS
         RR4i4m+VyS2SR6Rh6O64zHABGRYmC9kWwU3SijYhhIjAmPQXXRSF0oX5wttTQgS1Vmgk
         vSNwUigXDHYjtv1kmYkPcRLfER0AXrt4hN/gr49ff2sWGVYO9fbaWIicQPgfM07tSqkX
         ifr+doFv72xgFpYUgnnkBkzFcFhZDjSWda+qOX+q1qkIcoK2cNkI/W7YmjCpZ5ddYvvy
         HDmbHqhklcvaphdg2Uy581D+bfKasP7f2qJMOlg5ho4ilQmt4BeHbXOuIWZFSR8CDheQ
         /EpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:mime-version:date:in-reply-to
         :subject:cc:to:from:user-agent:references:arc-authentication-results;
        bh=/4n25k1dYPAF2J+4EU2IuhlZq15hKyh69/3AIc2Xt3w=;
        b=FxSFRMatCzVOojme5JUyzHb6qv641A/JUhQhc24lMyHc69V+rrxVqxwGmxTuKuzduH
         iO4pWQxZmYzquFDQ5D6TmYtGyQlXYmM/GsksfKcZcbm0HPl+Y3f+5o26eGdezkVnh/Q3
         McFDP+60iWbjqcBopHv3n9AXOk9gFbE8zzuTgLgWdMM/ooCAemIzrP2N3feY3sJnKFBi
         427OBcLRMzmDokLnAMXUNE8iQsafHaTaot2dFQWcMFPX+LoIMzp66F8B2Zn9aKLu/VT/
         0bBIxeGCszCReVN/0tyVzki5os6ENA8/BS78bb8DNvka4Uin16vO2pUIfnyRBsyD6n/k
         2Gkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeC1XwA (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Mar 2018 19:52:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750946AbeC1Xv7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Mar 2018 19:51:59 -0400
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com> <1519264541-7621-8-git-send-email-linuxram@us.ibm.com> <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com> <87muys3p2v.fsf@morokweng.localdomain> <34fd1ae9-9697-ac6c-d6bc-7c25b4515a25@intel.com>
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
In-reply-to: <34fd1ae9-9697-ac6c-d6bc-7c25b4515a25@intel.com>
Date: Wed, 28 Mar 2018 20:51:42 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18032823-8235-0000-0000-00000D3B5742
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008761; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01009846; UDB=6.00514467; IPR=6.00789128;
 MB=3.00020300; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-28 23:51:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032823-8236-0000-0000-00004040D761
Message-Id: <878tabvjw1.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-28_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803280241
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064680200522222?=
X-GMAIL-MSGID: =?utf-8?q?1596227448906614092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Dave Hansen <dave.hansen@intel.com> writes:

> On 03/28/2018 01:47 PM, Thiago Jung Bauermann wrote:
>>>>  	if (flags)
>>>> -		assert(rdpkey_reg() > orig_pkey_reg);
>>>> +		assert(rdpkey_reg() < orig_pkey_reg);
>>>>  }
>>>>
>>>>  void pkey_write_allow(int pkey)
>>> This seems so horribly wrong that I wonder how it worked in the first
>>> place.  Any idea?
>> The code simply wasn't used. pkey_disable_clear() is called by
>> pkey_write_allow() and pkey_access_allow(), but before this patch series
>> nothing called either of these functions.
>> 
>
> Ahh, that explains it.  Can that get stuck in the changelog, please?

Yes, will be in the next version.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

