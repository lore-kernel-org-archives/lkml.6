Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63728C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E352084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E352084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeLLRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:34:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbeLLRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:34:51 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBCHYH3d096023
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 12:34:50 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pb4xtwppv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 12:34:50 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <nayna@linux.ibm.com>;
        Wed, 12 Dec 2018 17:34:49 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Dec 2018 17:34:44 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBCHYhgQ20250842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Dec 2018 17:34:43 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E1BAAE064;
        Wed, 12 Dec 2018 17:34:43 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF875AE05C;
        Wed, 12 Dec 2018 17:34:38 +0000 (GMT)
Received: from [9.85.69.250] (unknown [9.85.69.250])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 12 Dec 2018 17:34:38 +0000 (GMT)
Subject: Re: [PATCH v2 5/7] efi: Import certificates from UEFI Secure Boot
To:     James Morris <jmorris@namei.org>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jforbes@redhat.com,
        seth.forshee@canonical.com, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com,
        mpe@ellerman.id.au, Josh Boyer <jwboyer@fedoraproject.org>
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-6-nayna@linux.ibm.com>
 <alpine.LRH.2.21.1812120547110.11653@namei.org>
From:   Nayna Jain <nayna@linux.ibm.com>
Date:   Wed, 12 Dec 2018 23:01:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1812120547110.11653@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18121217-0060-0000-0000-000002E2F4EB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01130779; UDB=6.00587611; IPR=6.00910912;
 MB=3.00024670; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-12 17:34:47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121217-0061-0000-0000-000047836919
Message-Id: <d36bfd7c-7564-778b-1e75-5b835d40b6f1@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812120151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/2018 12:17 AM, James Morris wrote:
> On Sun, 9 Dec 2018, Nayna Jain wrote:
>
>> +/*
>> + * Blacklist an X509 TBS hash.
>> + */
>> +static __init void uefi_blacklist_x509_tbs(const char *source,
>> +					   const void *data, size_t len)
>> +{
>> +	char *hash, *p;
>> +
>> +	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
>> +	if (!hash)
>> +		return;
>> +	p = memcpy(hash, "tbs:", 4);
>> +	p += 4;
>> +	bin2hex(p, data, len);
>> +	p += len * 2;
>> +	*p = 0;
>> +
>> +	mark_hash_blacklisted(hash);
>> +	kfree(hash);
>> +}
>> +
>> +/*
>> + * Blacklist the hash of an executable.
>> + */
>> +static __init void uefi_blacklist_binary(const char *source,
>> +					 const void *data, size_t len)
>> +{
>> +	char *hash, *p;
>> +
>> +	hash = kmalloc(4 + len * 2 + 1, GFP_KERNEL);
>> +	if (!hash)
>> +		return;
>> +	p = memcpy(hash, "bin:", 4);
>> +	p += 4;
>> +	bin2hex(p, data, len);
>> +	p += len * 2;
>> +	*p = 0;
>> +
>> +	mark_hash_blacklisted(hash);
>> +	kfree(hash);
>> +}
>>
> These could be refactored into one function.
>
>

Thanks James for reviewing.

Yes, the code should be refactored.  However, I think making it a single 
function would require adding a new field to the function callback 
definitions as well. Probably, a simpler approach would be to define a 
common function uefi_blacklist_hash(...)  which can then be used by the 
two functions uefi_blacklist_x509_tbs(...) and 
uefi_blacklist_binary(...). These two functions now act as wrapper 
functions. Below is the example code:

+/*
+ * Blacklist a hash.
+ */
+static __init void uefi_blacklist_hash(const char *source, const void 
*data,
+                                 size_t len, char *type, size_t type_len)
+{
+       char *hash, *p;
+
+       hash = kmalloc(type_len + len * 2 + 1, GFP_KERNEL);
+       if (!hash)
+               return;
+       p = memcpy(hash, type, type_len);
+       p += type_len;
+       bin2hex(p, data, len);
+       p += len * 2;
+       *p = 0;
+
+       mark_hash_blacklisted(hash);
+       kfree(hash);
+}
+
+/*
+ * Blacklist an X509 TBS hash.
+ */
+static __init void uefi_blacklist_x509_tbs(const char *source,
+                                          const void *data, size_t len)
+{
+       uefi_blacklist_hash(source, data, len, "tbs:" , 4);
+}
+
+/*
+ * Blacklist the hash of an executable.
+ */
+static __init void uefi_blacklist_binary(const char *source,
+                                        const void *data, size_t len)
+{
+       uefi_blacklist_hash(source, data, len, "bin:" , 4);
+}


Thanks & Regards,
    - Nayna



