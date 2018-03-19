Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELs8yJmyL70zG3zAAsNdkWUramzk6JxbtCpMK1CYY7ptXbeV2vEuA1ZsQ+YOgosFAx8O7Wmz
ARC-Seal: i=1; a=rsa-sha256; t=1521446260; cv=none;
        d=google.com; s=arc-20160816;
        b=OuAZoLQ18LDJWwIQ9T1E8URxsZ1y7+ZxajQZy5Y7Wsn09MSlAkKCYvNTxm2ZbuODGC
         oE9Etx8yR/+bN9KAWgE0CGxvK0Dt4wV8/0xcNuJe5GmU05UAPvaUhINQjB3nu9Wjob1B
         03o1CiiQZJCFzYbvplGigIRgYyF0Ly+rKG72vvStiCc9xr6ejw0650mcPWohpdnswMAa
         AmKg74fbfNOhJ4M75R1g5wAHqx8jSG3CZaqBZmI6lpqDmutQ5fsmEVAvO4Z9360Qe7yf
         iMjr81VDRRiVt+CqGtFFljCr0tm08L7uOZgdcAG7K4gwIm11DDcq0eja/Qruq+rBtHev
         enbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :from:references:cc:to:subject:arc-authentication-results;
        bh=sDEiEdtP5HGDt8wryI08zxcigelQ2QN86M9QwcJGrH4=;
        b=FsIdbvk7GcH9XqwEAAs4A6fZiORoxZ6q6KlY7bX0gJty/6YERmU+VbfRBK7V0nVBjh
         GBHqLw+UNk0kIIOXUH63uKtvCiv1cVsM1P8iPNeCYjLYYpBaDCWJEIJr8cGaOQ6F7rld
         voIDBy5fQ0Wsv5wyqPEp0HaZRs/CSyt/t9wFeJekUljMWCAUlJAVw25CDyK3hhczjmJu
         XeDrFboMX8QoN5z+KarZBYW9mPjzDLw8E3KKfmqJ8kYmpBNe8F+bwT1rQQrljKd0l2q0
         r0BvloybrsmgQd+t9mfb4Ln4cTRMy0r3oRTPtwAQuz/uWWdw0bzmNbqFqCGcN5iXhppa
         u9fA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755406AbeCSH5k (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 19 Mar 2018 03:57:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754524AbeCSH5j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Mar 2018 03:57:39 -0400
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
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 19 Mar 2018 13:29:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152129118998.31874.16273532808298489908.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031907-0008-0000-0000-000004DFB816
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031907-0009-0000-0000-00001E72CDF0
Message-Id: <8c02c538-4934-59c2-7795-9058ce57e625@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803190100
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595189477266437642?=
X-GMAIL-MSGID: =?utf-8?q?1595352034586620194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami,

On 03/17/2018 06:23 PM, Masami Hiramatsu wrote:
> Since kprobes events support an array argument, perf-probe
> can also support dumping array now.
> The syntax are
>
>  <array-var>[<range>]
> or
>  <pointer-var>[<range>]
>
> where the <range> is <start>..<end>. e.g. array[0..5].
> This can also be available with string type. In this
> case, the string array should be "char *array[]" or
> "char **array_ptr".
>
> Note that this feature is only available on the kernel which
> supports array type.

User can still do,

# perf probe -x ~/hello main:3 'a=a:x32[3]'

which will successfully be installed in uprobe_events. But for a
perf tool, x32[3] is not a valid type. And it seems perf tool don't
validate the 'type' field:

    static int parse_perf_probe_arg(char *str, struct perf_probe_arg *arg)
    {
        ....
        tmp = strchr(str, ':');
        if (tmp) {      /* Type setting */
                *tmp = '\0';
                arg->type = strdup(tmp + 1);
                if (arg->type == NULL)
                        return -ENOMEM;
                pr_debug("type:%s ", arg->type);
        }

Is it okay to allow user to specify array size with type field?

Thanks,
Ravi

