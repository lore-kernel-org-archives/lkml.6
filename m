Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1623703-1525108337-2-8080511789308796061
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525108337; b=Sqi5QL8glw0+TAZcGdfxvp8e3j2F6y3dmNpUkx4PFz/tJd3Zkl
    mPPSM4NqZ9V+DZm566/4xlIPAdL0Q58xPlHCBcMDuYLia7Tb0R3uOZSwARYMu5Vh
    xhH2AuUtiMPgtnfz6itF4d3Stzcatco3ZXN6POfYTBeDyZ9fhXOXDdJkIX+swgvG
    7jjuNvWrlBRBKypCBEX6VHTV687tn8V+//LGVNISPvi4pVZk8P/ELqZ0QuKQAf5a
    6d7B+p4fbtbq+y9IC9wOkdI8F6vx/ar5RapAt4rc7nFXImIUcE7zkTXi8SZOFktt
    ScIQeTeWkGHySFUkIu0PL+7S0L1xA02pkl8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=reply-to:subject:from:to:cc:references
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:message-id:sender:list-id; s=fm2; t=
    1525108337; bh=Ycn8YmBrixTSmEKek0w3cV+RQm8NVEXGYiLs6UqoTxI=; b=l
    4dlZzS7Pd6iR2uStZW+fAzCe0agVNgX+6bQiOX+oSNFUHwPjuqHmnkm2NCVso4M+
    QRVQEX1R0AcXtdU9X/5raZszV0FvtHaNIQgg/rAzwmotJQxzdjOtk9Xv2xQqIKR4
    U5rPmptUa3N+TKbxasgQpV01nC4onMSuDhmM6ba27mEIZP9nw8RB9+CAl9rOKaKl
    f7W33ojDO3/3kDr2pobQ8xwanLxIhHZ52Mt/D3D5rRqmWgOc9oPV3dbLRRHL+UK7
    A45SEHLe6UeI/5/XD4ls2y+OtvTiigz/LwlKLT7L8cU25q/1Wpgb1krtVfmh8NLk
    V5SAZl9j3pRs22R1Xjjeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN1IEtKq+FaNuQN1xIGWRZeHZsc62LhuWAl3wA8eR2QktDQr0FEM/PvJmiH1Jeo11zdtRohD1HQikiisPOCFHo/biWBOi+HGfHCM7Uv27Zj0VXWatwZt
    Sv9xmC0v576CPJ86mCAb9ki0p+KBKgBJXR03E9p9UBhkXoiaovRil0f34tsRIUfnpTrKevt+4LZJPhQkLiKXZTtY7cu3TE4ZHF/Oe1fa0t2aYuoFDT0QXsZd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=8q1hZfNLLjQcVCFKhU8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeD3RMN (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 13:12:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754881AbeD3RML (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 13:12:11 -0400
Reply-To: muriloo@linux.ibm.com
Subject: Re: [PATCH] perf session: Fix undeclared 'oe'
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        He Kuang <hekuang@huawei.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Simon Que <sque@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20180411184135.27664-1-muriloo@linux.ibm.com>
 <20180411193353.GA5656@kroah.com>
 <82d8f577-bbbb-0419-bf41-057522eb3f30@linux.ibm.com>
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
Date: Mon, 30 Apr 2018 14:11:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <82d8f577-bbbb-0419-bf41-057522eb3f30@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18043017-2213-0000-0000-0000029B6221
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008952; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025539; UDB=6.00523703; IPR=6.00804771;
 MB=3.00020864; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-30 17:12:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18043017-2214-0000-0000-000059F1E518
Message-Id: <81025fb9-bab8-58ff-8f82-b1da9a1202ec@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804300165
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 05:21 PM, Murilo Opsfelder Araújo wrote:
> On 04/11/2018 04:33 PM, Greg Kroah-Hartman wrote:
>> On Wed, Apr 11, 2018 at 03:41:35PM -0300, Murilo Opsfelder Araujo wrote:
>>> Using linux-3.18.y branch, perf build fails with the following:
>>>
>>>     $ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1 HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1 prefix=/usr DESTDIR=/tmp/builddir/build all
>>>     [...]
>>>     util/session.c: In function ‘__perf_session__process_pipe_events’:
>>>     util/session.c:1093:36: error: ‘oe’ undeclared (first use in this function)
>>>       ordered_events__set_copy_on_queue(oe, true);
>>>                                         ^
>>>     util/session.c:1093:36: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>> This patch fixes it for linux-3.18.y branch.
>>
>> Why is this failing now?  Has it always been broken?  Is there an
>> upstream patch that fixed this instead?
>>
> 
> Hi, Greg.
> 
> We've caught this build issue this week. I'm not sure since when it's
> failing.
> 
> The upstream patch that fixes this is:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa713a4eb9cebe5dec71b1bd11429603e17d841d
> 
> commit fa713a4eb9cebe5dec71b1bd11429603e17d841d
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Mar 3 11:48:12 2015 -0300
> 
>     perf ordered_events: Untangle from perf_session
> 
> But it doesn't apply straightforwardly.  At
> fa713a4eb9cebe5dec71b1bd11429603e17d841d, perf API and perf_evlist
> struct are slightly different from linux-3.18.y.
> 
> A list of upstream patches for a clean backport (I think) would be:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54245fdc357613633954bfd38cffb71cb9def067
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75be989a7a18e9666efd92b846ee48bed79e8086
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=313e53b08e99b1dacf9ea2b0fbe97890db1ea95f
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9fa8727aa4d98d35ca50ef9cd8a50c6468af921d
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa713a4eb9cebe5dec71b1bd11429603e17d841d
> 
> Do you prefer all above patches backported to linux-3.18.y or just the
> one-line fix I sent?
> 
>>> Fixes: 95b33b99cdd6 ("perf inject: Copy events when reordering events in pipe mode")
>>
>> Was this just a bad backport?
> 
> Some patches were left behind, I guess.
> 
>>
>> thanks,
>>
>> greg k-h

Hi, Greg.

I've realized that perf build on v3.18.107 is still broken, actually, it
got a bit worse than v3.18.104.

After applying my patch to fix the undeclared 'oe', perf build fails
with the following errors:

$ make -s -j16 -C tools/perf V=1 WERROR=0 NO_LIBUNWIND=1
HAVE_CPLUS_DEMANGLE=1 NO_GTK2=1 NO_LIBNUMA=1 NO_STRLCPY=1 NO_BIONIC=1
prefix=/usr DESTDIR=/tmp/builddir/build all
[...]
tests/code-reading.c: In function ‘read_object_code’:
tests/code-reading.c:145:19: error: ‘KMOD_DECOMP_LEN’ undeclared (first
use in this function)
  char decomp_name[KMOD_DECOMP_LEN];
                   ^
tests/code-reading.c:145:19: note: each undeclared identifier is
reported only once for each function it appears in
tests/code-reading.c:208:2: warning: implicit declaration of function
‘dso__needs_decompress’ [-Wimplicit-function-declaration]
  if (dso__needs_decompress(al.map->dso)) {
  ^
tests/code-reading.c:208:2: warning: nested extern declaration of
‘dso__needs_decompress’ [-Wnested-externs]
tests/code-reading.c:209:3: warning: implicit declaration of function
‘dso__decompress_kmodule_path’ [-Wimplicit-function-declaration]
   if (dso__decompress_kmodule_path(al.map->dso, objdump_name,
   ^
tests/code-reading.c:209:3: warning: nested extern declaration of
‘dso__decompress_kmodule_path’ [-Wnested-externs]
tests/code-reading.c:145:7: warning: unused variable ‘decomp_name’
[-Wunused-variable]
  char decomp_name[KMOD_DECOMP_LEN];
       ^

Apparently, this was introduced by commit
091b3b4ba55daf8b28f40794aefdaa0bdb5af7a1:

commit 091b3b4ba55daf8b28f40794aefdaa0bdb5af7a1
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Jun 8 16:31:07 2017 +0900

    perf tests: Decompress kernel module before objdump


Namhyung, are you fixing this?

Cheers
Murilo
