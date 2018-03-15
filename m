Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu57WyntrQnMNZuSZhS65aaIJSZWVlzL8PqcIBmhO0fJoKgfVYGEDEB/5Cq4AMsoJgtbKkb
ARC-Seal: i=1; a=rsa-sha256; t=1521100757; cv=none;
        d=google.com; s=arc-20160816;
        b=wDBMc1fYlrtFzISHzGZfAMC2Rj7PuscoXI4YWtMkPNxCzzsTWD+ZjsBOfpeYiv8o3J
         SE46O2+cPdwVUk38c/JEKHr4GhAdga23ZgVSiWGG34D/TrnLJ1ukDzU50LjnR0bmm83E
         qbrsMqa3D3e78K/di392cZt3V0HlL0vY0+wEjoYDPTJh0Qnj7om6wP4O2kj+YohotJjQ
         t1B0Px9OonHnfeVQu4n3uGmNuU3VXjotebo9t40UQp6zf4M6kY+xawCM3jALGpkk612x
         6kcWn3SmjU8YH/nDf8Uol9+G8FA0jkYhDdIVcw9xEx454Cvj7gO650rtmLv8hOaalQGw
         sZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :from:references:cc:to:subject:arc-authentication-results;
        bh=dBQHzrkIkvP5BeqpRItaT3YIkE90MATh6HBMeCQAccE=;
        b=dQKooDFvxOb6jtnmubnGyBGINAulDMtR2SHDQt04IzndRF4U4v8qDMImveX7FRWVI1
         6681GQmgIXkkgNCIcLukIFmRIFyiQ2s1EqO5pJ49buwLw0Vi5I/xdGH21yiDpXd6ZkdH
         dqnRPANYDQVPfFx3MT86mCNZtxgGQAma75cGyhFiRIhVYucQNVtpdq/1o4PjU/qrMNoN
         LyjL3UzCTvkGTq2bpJRszwXKn6ViFFlv6R8RraX7UtCBa70X1LpXWN9Ft46pamPEtYXy
         8ghSzBuBLLV1WlDiSSBMRzMPz/4mU+Mu+AwWfEkQnRRLS/Ixaq4zECeLl+qP21ve3b5f
         3y5A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeCOH7P (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Mar 2018 03:59:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751571AbeCOH7O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Mar 2018 03:59:14 -0400
Subject: Re: [PATCH v5 16/19] tracing: probeevent: Add array type support
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
 <152049905133.7289.17516121776689315422.stgit@devbox>
 <72be81a4-710a-b942-277d-9156c3debc5d@linux.vnet.ibm.com>
 <20180315161840.71d524a73307881febfe34c2@kernel.org>
 <20180315162303.1250dea1500aea420ecd85c6@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 13:31:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315162303.1250dea1500aea420ecd85c6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031507-0016-0000-0000-00000532E64A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031507-0017-0000-0000-0000286FEEC2
Message-Id: <d94e56c0-4096-5b8d-9e84-6a83b3daa84f@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150091
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358839822578667?=
X-GMAIL-MSGID: =?utf-8?q?1594989748191668648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/15/2018 12:53 PM, Masami Hiramatsu wrote:
>
> Sorry, that is too complicated than enough. you should try to specify a[0] instead of a.
>
>  $ sudo ./perf probe -x ~/hello foo1 'a=a[0]:x32[3]'

Cool.. that works fine.

$ sudo ./perf script
           hello  1779 [034]    76.081971: probe_hello:foo1: (100005fc) a={0x4,0x5,0x6}

Thanks,
Ravi

> :)
>
> Thank you,
>

