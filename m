Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELvFsapHyWVpY8s/+n/wEoi0BH4wjJMQImgvtcvRFRdrDEt8oPJdCU5UA97MOALlGyNlm5RM
ARC-Seal: i=1; a=rsa-sha256; t=1520945645; cv=none;
        d=google.com; s=arc-20160816;
        b=Yk6NptNpD+K3p92r55UE4grPzVc1NPUWhcQ+RizoQlSmYXXHtnIbJ/SDjNNAJnpPx0
         zWwJh7oV3rhWu3ip0rVCKXtQ466Gh8ou2aUNmh0N5Pqft7aaqIAnWc7W8CzbHPaSag1p
         ip224+5AoGwfPowIXIkF2JJhHA2x9aNYAWXYAd3jXVs7+wLlczHybGhY90gxISEotOes
         rCgCLroy3KXFv/o2HbaafgMqqarAFZ8nquFYtVXZJS40dfcwqHkLeU2vuvSFcUjLS4cd
         aMWSh2SmYpuOvAUlj/lkGoB3h8cbGyZZpEbQAbu5rAw0KBgePy7G7OgRsCGB07YkP4AU
         QjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=FMskqqMvqhMbBZ5SZr6ez4Uh8ya5QU0oFGUL8Dwgtvc=;
        b=zZPnNOqYsI4NYhDfWhtDRKzharwUbATpLV+KVpRkX0t6hOkhK0nHJ1Uf6n7tZ2tXjA
         SZfiUVNTAfW5ZEY9jKYs+lrLWZ720ondKaEQDO/8qbffqvllZHNL9u77Hn8OiqNfFUWM
         j8P+/IyQQyRIk9NrUFYaL9GVRWTXqUwdijs9txwZInjKLm1u5+NxICvqJNLqm7QQC3Ms
         iRqDMVL2UyFbID8oopGDE0ROdWPfQ/H22eTagoLWotEptlC45ZVJNxOzp8S7KacfgG+z
         RA4h7VoSnU1+gHywyyDNudC9soWv7g1iTklLEpjwMcmYUS0KfZQq3fgGBSZMGk91UOL0
         jQEw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of ravi.bangoria@linux.vnet.ibm.com) smtp.mailfrom=ravi.bangoria@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com
Cc: acme@kernel.org, ananth@linux.vnet.ibm.com, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, alexis.berlemont@gmail.com,
        corbet@lwn.net, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        huawei.libin@huawei.com, hughd@google.com, jack@suse.cz,
        jglisse@redhat.com, jolsa@redhat.com, kan.liang@intel.com,
        kirill.shutemov@linux.intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, pombredanne@nexb.com,
        rostedt@goodmis.org, tglx@linutronix.de, tmricht@linux.vnet.ibm.com,
        willy@infradead.org, yao.jin@linux.intel.com, fengguang.wu@intel.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 0/8] trace_uprobe: Support SDT markers having reference count (semaphore)
Date: Tue, 13 Mar 2018 18:25:55 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18031312-0008-0000-0000-000004DBFABC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031312-0009-0000-0000-00001E6F2D61
Message-Id: <20180313125603.19819-1-ravi.bangoria@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130153
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594827101403620100?=
X-GMAIL-MSGID: =?utf-8?q?1594827101403620100?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. These markers are added by developer at
important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. In case the overhead is more, execution of it can be
omitted by runtime if() condition when no one is tracing on the marker:

    if (reference_counter > 0) {
        Execute marker instructions;
    }   

Default value of reference counter is 0. Tracer has to increment the 
reference counter before tracing on a marker and decrement it when
done with the tracing.

Currently, perf tool has limited supports for SDT markers. I.e. it
can not trace markers surrounded by reference counter. Also, it's
not easy to add reference counter logic in userspace tool like perf,
so basic idea for this patchset is to add reference counter logic in
the trace_uprobe infrastructure. Ex,[2]

  # cat tick.c
    ... 
    for (i = 0; i < 100; i++) {
	DTRACE_PROBE1(tick, loop1, i);
        if (TICK_LOOP2_ENABLED()) {
            DTRACE_PROBE1(tick, loop2, i); 
        }
        printf("hi: %d\n", i); 
        sleep(1);
    }   
    ... 

Here tick:loop1 is marker without reference counter where as tick:loop2
is surrounded by reference counter condition.

  # perf buildid-cache --add /tmp/tick
  # perf probe sdt_tick:loop1
  # perf probe sdt_tick:loop2

  # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
  hi: 0
  hi: 1
  hi: 2
  ^C
  Performance counter stats for '/tmp/tick':
             3      sdt_tick:loop1
             0      sdt_tick:loop2
     2.747086086 seconds time elapsed


Perf failed to record data for tick:loop2. Same experiment with this
patch series:

  # ./perf buildid-cache --add /tmp/tick
  # ./perf probe sdt_tick:loop2
  # ./perf stat -e sdt_tick:loop2 /tmp/tick
    hi: 0
    hi: 1
    hi: 2
    ^C  
     Performance counter stats for '/tmp/tick':
                 3      sdt_tick:loop2
       2.561851452 seconds time elapsed

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
[2] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506
[3] https://lkml.org/lkml/2017/12/6/976


Note: 'reference counter' is called as 'semaphore' in original Dtrace
(or Systemtap, bcc and even in ELF) documentation and code. But the 
term 'semaphore' is misleading in this context. This is just a counter
used to hold number of tracers tracing on a marker. This is not really
used for any synchronization. So we are referring it as 'reference
counter' in kernel / perf code.

RFC series can be found at:
  https://lkml.org/lkml/2018/2/28/76

Ravi Bangoria (8):
  Uprobe: Export vaddr <-> offset conversion functions
  mm: Prefix vma_ to vaddr_to_offset() and offset_to_vaddr()
  Uprobe: Rename map_info to uprobe_map_info
  Uprobe: Export uprobe_map_info along with
    uprobe_{build/free}_map_info()
  trace_uprobe: Support SDT markers having reference count (semaphore)
  trace_uprobe/sdt: Fix multiple update of same reference counter
  perf probe: Support SDT markers having reference counter (semaphore)
  trace_uprobe/sdt: Document about reference counter

 Documentation/trace/uprobetracer.txt |  16 +-
 include/linux/mm.h                   |  12 ++
 include/linux/uprobes.h              |  11 ++
 kernel/events/uprobes.c              |  62 ++++----
 kernel/trace/trace.c                 |   2 +-
 kernel/trace/trace_uprobe.c          | 273 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/probe-event.c        |  21 ++-
 tools/perf/util/probe-event.h        |   1 +
 tools/perf/util/probe-file.c         |  22 ++-
 tools/perf/util/symbol-elf.c         |  10 ++
 tools/perf/util/symbol.h             |   1 +
 11 files changed, 382 insertions(+), 49 deletions(-)

-- 
1.8.3.1
