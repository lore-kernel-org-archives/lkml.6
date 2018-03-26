Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELt+dOEksrTvyyEqDEemGXMOxEYKzJcrpLzyFD7tmVa2YUWujDtH9pDAqvZ7PP2OpH6hcklj
ARC-Seal: i=1; a=rsa-sha256; t=1522093163; cv=none;
        d=google.com; s=arc-20160816;
        b=NaP0EvjCP7291o9AcVDxfB9a5CNO8rjoO9fvlBVvdWcKlznMr+M960J0niiAwJI6uF
         FAGR+irnmOkX5MqM66Z/iU2/q1YTQWqubeYb2n9ojJy8dnXG9YMjLamLWF+Ourr/au6z
         csdITPLzVgR1uc2rKrVgGQ75WPoInwtiYB4sdkzv+AWs6XwkX6mON5qOY6eKz0UYto0V
         oPlX/P7fQ99DrzVNE57jw+VDyrLAGHiszZKZB5XBVkU1JffdtJRgZm9VikEe4XpTdBJy
         FAFl6lsffcxNNrW73vHVaooWNFW80ZL1hAMFbw9sHQMBJz/u23k+fAkYwDPtVabI0uu4
         EZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:mime-version:date:in-reply-to
         :subject:cc:to:from:user-agent:references:arc-authentication-results;
        bh=8UmC+N40sREB++Qbk72nwA1d5MyPaC7oj2tT5QAl7yA=;
        b=eFFq8ixPLMnI4zWfgSb0f981yiYUbTeaR5Zd7agnU7ZTf3efXW/YlZw0bY3Ge0NBiF
         H2mRN+N/76iPn8DZNu5tNjLU4hY0QbxHWZqYNQV+bKqFS20UQEizhoChcaZhMRrBwQBg
         X2fBpS4BI8GevMuPO43FqapFbaa1rDN35JvakfMl6CEz5RJ4NAI0lUCvvATjVSr1jZvm
         lVnyjQvzxKJZMwWKirzjUMoDracy+UjBSY0aDiinu2PgU50XscPbx0Nseuh830y5OzX3
         7Fx33VljlUKrFLfgdbTXRjGdB4RGcWicExyGgegWB7xnJfx5N9ejwTNNWMASHYfmCHws
         p58w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751196AbeCZTjJ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 26 Mar 2018 15:39:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751138AbeCZTjI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Mar 2018 15:39:08 -0400
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com> <1519264541-7621-5-git-send-email-linuxram@us.ibm.com> <00081300-e891-3381-3acd-e3312e54fb58@intel.com>
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
Subject: Re: [PATCH v12 04/22] selftests/vm: typecast the pkey register
In-reply-to: <00081300-e891-3381-3acd-e3312e54fb58@intel.com>
Date: Mon, 26 Mar 2018 16:38:51 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 18032619-0008-0000-0000-000002EB368B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008748; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000255; SDB=6.01008802; UDB=6.00513843; IPR=6.00788084;
 MB=3.00020253; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-26 19:39:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032619-0009-0000-0000-000038B00FE8
Message-Id: <87h8p239v8.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803260199
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064769921910354?=
X-GMAIL-MSGID: =?utf-8?q?1596030361560735040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Dave Hansen <dave.hansen@intel.com> writes:

> On 02/21/2018 05:55 PM, Ram Pai wrote:
>> -static inline unsigned int _rdpkey_reg(int line)
>> +static inline pkey_reg_t _rdpkey_reg(int line)
>>  {
>> -	unsigned int pkey_reg = __rdpkey_reg();
>> +	pkey_reg_t pkey_reg = __rdpkey_reg();
>>
>> -	dprintf4("rdpkey_reg(line=%d) pkey_reg: %x shadow: %x\n",
>> +	dprintf4("rdpkey_reg(line=%d) pkey_reg: %016lx shadow: %016lx\n",
>>  			line, pkey_reg, shadow_pkey_reg);
>>  	assert(pkey_reg == shadow_pkey_reg);
>
> Hmm.  So we're using %lx for an int?  Doesn't the compiler complain
> about this?

It doesn't because dprintf4() doesn't have the annotation that tells the
compiler that it takes printf-like arguments. Once I add it:

--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -54,6 +54,10 @@
 #define DPRINT_IN_SIGNAL_BUF_SIZE 4096
 extern int dprint_in_signal;
 extern char dprint_in_signal_buffer[DPRINT_IN_SIGNAL_BUF_SIZE];
+
+#ifdef __GNUC__
+__attribute__((format(printf, 1, 2)))
+#endif
 static inline void sigsafe_printf(const char *format, ...)
 {
 	va_list ap;

Then it does complain about it. I'm working on a fix where each arch
will define a format string to use for its pkey_reg_t and use it like
this:

--- a/tools/testing/selftests/vm/pkey-helpers.h
+++ b/tools/testing/selftests/vm/pkey-helpers.h
@@ -19,6 +19,7 @@
 #define u32 uint32_t
 #define u64 uint64_t
 #define pkey_reg_t u32
+#define PKEY_REG_FMT "%016x"

 #ifdef __i386__
 #ifndef SYS_mprotect_key
@@ -112,7 +113,8 @@ static inline pkey_reg_t _read_pkey_reg(int line)
 {
 	pkey_reg_t pkey_reg = __read_pkey_reg();

-	dprintf4("read_pkey_reg(line=%d) pkey_reg: %016lx shadow: %016lx\n",
+	dprintf4("read_pkey_reg(line=%d) pkey_reg: "PKEY_REG_FMT
+			" shadow: "PKEY_REG_FMT"\n",
 			line, pkey_reg, shadow_pkey_reg);
 	assert(pkey_reg == shadow_pkey_reg);

--
Thiago Jung Bauermann
IBM Linux Technology Center

