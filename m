Return-Path: <muriloo@linux.ibm.com>
X-Google-Smtp-Source: AIpwx4//nMU77ZGlAaPFxAkh4QByvVtVh9ETUD8Q7zkloOJXTO9AytbnERnQFUln5e9gi7D2OXVs
ARC-Seal: i=1; a=rsa-sha256; t=1523478106; cv=none;
        d=google.com; s=arc-20160816;
        b=m053BsH+R56tmj8BpG7nNpBz2ANjb+5yx6YgJJrK3eUnXvpirJtjJQabivS9mnGKS0
         vAAYExOZCadGsUoZNX4O31ex3BOxa5/LfntAYV2CGDBF5aBQFsYb3zeCxhB0SlvUGKtu
         ko6PLoj7vZ8Uac8U2yM/xow0HKl7SptJsbg7or/+8yEoleGo00+/FZIWBTdQ6ZSZA5v8
         MxbTuEiQfKwBDV4HA2sV8S6L/mC294DApsjc3hIfZPQVOIi85iOuwh/7gzwRRo4rl39P
         gvoxWvLs/6inlevqQOE/8YNefqkhIYiElsP4bhPxNBzcpe1B4OPnHhBTmz7QLjZl/UwX
         doPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:organization:autocrypt:openpgp:from
         :references:cc:to:subject:reply-to:arc-authentication-results;
        bh=DtmUlnQ+DHxzVgL5M0hPO9mNzsl15IriXvQ6o+EC5E4=;
        b=NbMQcn2wR6YHIorD4Bo827CdkxXcwuxOnX/gEp/tZAp1wrvFpcScSgVQ1IjZEqb7nl
         H2Ih2QTjRqw+agwpR0MBw3uR/5vu/RvtfILkdLbKmpXPc68P+VwNFVwlKRqniLP+/Aml
         sYd0VwE3RoTmaxxQHiY9eMztBWYfAnR9hKWIwQokCqb3LE7NQXX4cUsYsZe6hQ5jvzd+
         MsPbiL/3dLmQQIM2xz/xZV9QfNVdVUiNRemP925UlZjpAX0K4Dzicc4MMJCPCWy8sPjF
         g+YXhq7HFAN1XTuaZGuvqElioYAlEr6rljfjOiz3TEOOtaXBY45TuoTwQBIYHKY+QzhU
         wn/g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of muriloo@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=muriloo@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of muriloo@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=muriloo@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Reply-To: muriloo@linux.ibm.com
Subject: Re: [PATCH] perf session: Fix undeclared 'oe'
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        He Kuang <hekuang@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Mackerras <paulus@samba.org>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Simon Que <sque@chromium.org>, Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>
References: <20180411184135.27664-1-muriloo@linux.ibm.com>
 <20180411193353.GA5656@kroah.com>
From: =?UTF-8?Q?Murilo_Opsfelder_Ara=c3=bajo?= <muriloo@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=muriloo@linux.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFC2LJYBCADMXZCh0JjMe5T/r1QaUHwCCCvyVaMVniJyTBaqUXPujCaddOKJF+Qhnpnp
 0QJfOr/mnpeXe/HXHw1ICEBlMLfgR+VzQKvb7PHCtrKLEhCKeQOhmII4sxvpUfV/zjZBqp9z
 1ljZ+QJLr2j7mkKwdc1tZ2fyhev1OkbeeRgs3vAN1YMzN4BA1qRvID6BJBVE0SaMM0V4TxOH
 kjmA91n+B9rC3PQk03gN+7UAbrat3DQEAhLvrRyL3ncOWO6uayN7a5LvxxtrJrHJpaNcWdGD
 aUWXEfLsD4wD3xzldReOejqgxn2NOhvWa1P7MptwgXNYgPNLZ5nEVQLtD/CP37lS5KibABEB
 AAHNLk11cmlsbyBPcHNmZWxkZXIgQXJhdWpvIDxtdXJpbG9Ab3BzZmVsZGVyLmNvbT7CwHsE
 EwECACUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheABQJQti/pAhkBAAoJEJThzGhIzw44
 IaAIALToGEGjp1E4Cvr6BoznLPDoWMmfiGeyekZihS/SsANM4hAV9982x4BXRjde4wICSMEt
 sBy+t0FUKr4gbNGzAb10P1OifLfqwlPfpHkolvd71hCBS3CDvnwoADDKcIttKqSy6EsSFPX7
 5qqX/G2gVBjmZTxfj54EjQ7QE2EQdkqX1Rj/BBaiUyDtWjpIzieRdnkAkjKY0iOU7jX9Z8aD
 LcIijXgD6x594peuhORXMeBMmcdKOylKeS7JzRln37xHs5HYzSr2BMFm9Cvh7L4n4zL2UuJ9
 7HhcXbAyhlU/slRjeBNnn0X4JRZmmgpYoxOcrP/3iZvlXDf+qMzoxd4H0I3OwE0EULYslgEI
 AJpuIIHFGV4l3aneSjMLRRX94w+n9HmOQWG3pcqVyv0rnhr9qnov7HTNQ+kPw6eXFWTxHXJD
 4++eGizTHdtptcw73G8bzBs8hj9N85DTYon3doIEtQwRQdvd3I/oLL8PyKvRGmrJ17Aecprf
 69OIqp43SIuH5rQ9u7uIS2dKxql+3v0VE5IcARyF82k8Ys7Jf0OtIFoIZRIF8sQkGFGJHlfa
 w0dMdfkvm9+ASUYJyCi1ggyyd46l4XTjAPs1wQwyLRmJ4aleL5FiXdTNNQ8SmYGDy17werKL
 fWcgqOZC/Z3cEK1LvYUzcqGrf8/3bsP2QMfvFmPEV4W2Co0DqPDxg1UAEQEAAcLAXwQYAQIA
 CQUCULYslgIbDAAKCRCU4cxoSM8OOJPBB/4ld3N0LoT57XIZj2ZCJ0C9VdknlE9QTEG2huD0
 mVAL2Em3ZydgJz/TWXEKAMO50OHDvHiRFutFGZtHZuhCDgENQCaRvyI/xfi/UUA29J8Ahg2l
 zaICSEXwAuFZnecurvgTX2ioZNPrri2rgjKqEB+uJhkYXAziMCFSq1m+blREfjipiPKnTcLB
 EYizy8CewE2qHW2whXiYO7E+UPg186pF86bXiNYpEJSWB9z7ZlFsHE+ABngUjqrrCAmoteTK
 URTzrqPMFaiUrColsoulJamkbEn7amM9pN285U3CFREnsRv5m7TmSnPhZbBzAbEeHEaeqwO3
 xFlpAuK/RlKTJ/9D
Organization: IBM
Date: Wed, 11 Apr 2018 17:21:29 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411193353.GA5656@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18041120-0028-0000-0000-0000096EDC80
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008838; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01016490; UDB=6.00518382; IPR=6.00795737;
 MB=3.00020525; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-11 20:21:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041120-0029-0000-0000-00003A5637BE
Message-Id: <82d8f577-bbbb-0419-bf41-057522eb3f30@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110188
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597476305299961588?=
X-GMAIL-MSGID: =?utf-8?q?1597482579138243359?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 04:33 PM, Greg Kroah-Hartman wrote:
> On Wed, Apr 11, 2018 at 03:41:35PM -0300, Murilo Opsfelder Araujo wrote:
>> Using linux-3.18.y branch, perf build fails with the following:
>>
>>     $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1 prefix=/usr DESTDIR=/tmp/builddir/build all
>>     [...]
>>     util/session.c: In function ‘__perf_session__process_pipe_events’:
>>     util/session.c:1093:36: error: ‘oe’ undeclared (first use in this function)
>>       ordered_events__set_copy_on_queue(oe, true);
>>                                         ^
>>     util/session.c:1093:36: note: each undeclared identifier is reported only once for each function it appears in
>>
>> This patch fixes it for linux-3.18.y branch.
> 
> Why is this failing now?  Has it always been broken?  Is there an
> upstream patch that fixed this instead?
> 

Hi, Greg.

We've caught this build issue this week. I'm not sure since when it's
failing.

The upstream patch that fixes this is:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa713a4eb9cebe5dec71b1bd11429603e17d841d

commit fa713a4eb9cebe5dec71b1bd11429603e17d841d
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Tue Mar 3 11:48:12 2015 -0300

    perf ordered_events: Untangle from perf_session

But it doesn't apply straightforwardly.  At
fa713a4eb9cebe5dec71b1bd11429603e17d841d, perf API and perf_evlist
struct are slightly different from linux-3.18.y.

A list of upstream patches for a clean backport (I think) would be:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54245fdc357613633954bfd38cffb71cb9def067

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75be989a7a18e9666efd92b846ee48bed79e8086

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=313e53b08e99b1dacf9ea2b0fbe97890db1ea95f

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9fa8727aa4d98d35ca50ef9cd8a50c6468af921d

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa713a4eb9cebe5dec71b1bd11429603e17d841d

Do you prefer all above patches backported to linux-3.18.y or just the
one-line fix I sent?

>> Fixes: 95b33b99cdd6 ("perf inject: Copy events when reordering events in pipe mode")
> 
> Was this just a bad backport?

Some patches were left behind, I guess.

> 
> thanks,
> 
> greg k-h
> 

Cheers
Murilo
