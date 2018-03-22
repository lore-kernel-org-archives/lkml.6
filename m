Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu/HSM6dPGV38Ri2d9bvp+gs5gX12dxHEhYVGzYXY0fPFjCyNtwVF4Cx1BVPhVUrNfi5MXM
ARC-Seal: i=1; a=rsa-sha256; t=1521715648; cv=none;
        d=google.com; s=arc-20160816;
        b=DIAAvBC1JBj9/82skm2hMB+nGIorec+YO0xzF6Umxm8kZGc/ZASLJDEoljHm1SgwsW
         KnjlWBD0V8o1sKIUYyT7RrpGVIMVc6Mqklf58VXcb5DwLHFXJlJnSis4ZI2YtrtHTDrE
         cIc2uLTBeiW4Ttra/bxbNdB0XKJKJvPSfNU1N7y4KA1+YETw0/o/qiVpObHRRXLuNvGD
         r2N8u03QaOE5HaS5Kz1v2t6Kb4cCeAZiSrzYnH4EBHqJYD00Kz2jtYXtEm2Jk2Krrfsa
         Zt0ipI0ParYnUI7VWuNdagKvZsTZcizxjPjT2y5Rz0OBtY9yunlCFNWRVEPiioZhtBFP
         K1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :from:references:cc:to:subject:arc-authentication-results;
        bh=e7yPk59F3Ig8Q5FQGUPQGHeD3JU8uhc8RUkxaxccH1M=;
        b=OUeKBidD1SZRyW/G4MKCFGdj2PAdhxg56MKk0RK2ZK0+7bzP9ePZH04NcTCjxKsfIE
         qLlH4ADXmrGKI0jSKU6y+7NPmYePzglCajeOrBovvUmJtP3oo8ISgsTIptxawNxnBkJU
         DgFAOZiG0xSUtaJxw3jqlMGt7S9l8stViWv5xNEAhcpxDEgyVCf/24gcnjimx8gDOY2M
         MybyAFw11w4sv7a75E5tUM1tgBf6Rl87ZYg058gl0pavNS676sbsP72uBRNCNsSL/WuR
         F4ooD+6RjYllh1xjxuDZ6E4DJmyql3QH34UT5G7gSP9UEFv35/k4ggIVSmaQoDAwEzEX
         97VQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbeCVKr1 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 22 Mar 2018 06:47:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754359AbeCVKrY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Mar 2018 06:47:24 -0400
Subject: Re: [PATCH v6 21/21] perf-probe: Add array argument support
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
 <152129118998.31874.16273532808298489908.stgit@devbox>
 <8c02c538-4934-59c2-7795-9058ce57e625@linux.vnet.ibm.com>
 <20180322182347.ca1aab9b77ab4c351100646b@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 16:19:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322182347.ca1aab9b77ab4c351100646b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18032210-0044-0000-0000-0000053EB303
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032210-0045-0000-0000-0000287DBB42
Message-Id: <8b3ad72c-f28c-8fc0-32b8-4401dbe16358@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220129
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189477266437642?=
X-GMAIL-MSGID: =?utf-8?q?1595634507027510521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami :)

On 03/22/2018 03:53 PM, Masami Hiramatsu wrote:
> On Mon, 19 Mar 2018 13:29:59 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>>
>> Is it okay to allow user to specify array size with type field?
> Fro this patch, yes.

So IIUC, perf _tool_ will allow user to record array either with "name[range]"
or by "name:type[length]". Please correct me if that's wrong.

And If perf tool will allow array length along with TYPE field, I guess we should
document that in man perf-probe?

Otherwise,

Acked-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

Thanks,
Ravi

>  The availability of type is checked only when
> it is automatically generated.
> IMO, it should be done in another patch, something like
> "Validate user specified type casting" patch. Would you need it?
>
> Thank you,
>

