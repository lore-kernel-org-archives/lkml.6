Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61996C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F83520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfAQNWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 08:22:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbfAQNWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 08:22:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0HDIrNR011365
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:22:19 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q2r3fy1br-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:22:18 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 17 Jan 2019 13:22:17 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 17 Jan 2019 13:22:14 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0HDMDaU58064996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Jan 2019 13:22:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1796852050;
        Thu, 17 Jan 2019 13:22:13 +0000 (GMT)
Received: from [9.85.75.36] (unknown [9.85.75.36])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E0975204E;
        Thu, 17 Jan 2019 13:22:10 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 check-perf-trace.py
To:     Jiri Olsa <jolsa@redhat.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <20190117123202.GC16366@krava>
Date:   Thu, 17 Jan 2019 18:53:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117123202.GC16366@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011713-0008-0000-0000-000002B24F66
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011713-0009-0000-0000-0000221E6CC1
Message-Id: <260a7c51-88c4-ff1c-ff74-68e5afe0983e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901170098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Seeteena, Jiri,

On 1/17/19 6:02 PM, Jiri Olsa wrote:
> On Thu, Jan 17, 2019 at 03:15:28PM +0530, Seeteena Thoufeek wrote:
>> Support both Python 2 and Python 3 in check-perf-trace.py.
>> ``print`` is now a function rather than a statement. This should have
>> no functional change.
>>
>> Fix indentation issue, replace spaces with tab
>>
>> Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> hum, could you please add some info about testing those changes?
> (or even some global into 0/.. patch)
> 
> this is working for me on python2:
> 
> 	[root@krava perf]# perf script rec check-perf-trace
> 	^C
> 	[root@krava perf]# perf script   -s scripts/python/check-perf-trace.py
> 	trace_begin
> 
> 	unhandled events:
> 
> 
> 	event                                          count
> 
> 	----------------------------------------  -----------
> 
> 	raw_syscalls__sys_enter                      3509879
> 
> 
> but fails for python3:
> 
> 	[root@ibm-x3650m4-01-vm-04 perf]# perf script rec check-perf-trace
> 	^C[ perf record: Woken up 0 times to write data ]
> 	Warning:
> 	1 out of order events recorded.
> 	[ perf record: Captured and wrote 43.132 MB perf.data (490171 samples) ]
> 
> 	[root@ibm-x3650m4-01-vm-04 perf]# perf script   -s scripts/python/check-perf-trace.py
> 	Traceback (most recent call last):
> 	  File "scripts/python/check-perf-trace.py", line 18, in <module>
> 	    from perf_trace_context import *
> 	ModuleNotFoundError: No module named 'perf_trace_context'
> 	Error running python script scripts/python/check-perf-trace.py

Yes I'm seeing the same error with check-perf-trace.py.

I think the issue happens only when we use 'perf script -s path/to/script.py'
instead of 'perf script report script_name':

Ex:

  # PERF_EXEC_PATH=`pwd` ./perf.python3 script record stackcollapse
    ^C[ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.263 MB perf.data (497 samples) ]

  # PERF_EXEC_PATH=`pwd` ./perf.python3 script report stackcollapse
    migration/21 1
    migration/41 1
    perf 9
    rngd 1
    sshd 1
    swapper 482
    xfsaild/sda5 2

  # PERF_EXEC_PATH=`pwd` ./perf.python3 script -s scripts/python/stackcollapse.py 
    Traceback (most recent call last):
      File "scripts/python/stackcollapse.py", line 31, in <module>
        from perf_trace_context import *
    ModuleNotFoundError: No module named 'perf_trace_context'
    Error running python script scripts/python/stackcollapse.py

So, it seems, this is not the script issue. Something is wrong when we build perf
with python3?


Here is my test summary on Powerpc Fedora 29:

                              Python2           Python3
 check-perf-trace.py          ok                FAIL (No module named 'perf_trace_context')
 event_analyzing_sample.py    ok                ok
 export-to-sqlite.py          ok                ok
 exported-sql-viewer.py       ok                FAIL (details at the end)
 export-to-postgresql.py      FAIL              FAIL
 failed-syscalls-by-pid.py    ok                ok
 futex-contention.py          ok                ok
 intel-pt-events.py           NOT TESTED        NOT TESTED
 mem-phys-addr.py             NOT TESTED        NOT TESTED
 net_dropmonitor.py           ok                ok
 netdev-times.py              ok                ok
 powerpc-hcalls.py            ok                ok
 sctop.py                     ok                ok
 stackcollapse.py             ok                ok
 stat-cpi.py                  FAIL (Seg fault)  FAIL (Seg fault)
 syscall-counts-by-pid.py     ok                ok
 syscall-counts.py            ok                ok


exported-sql-viewer.py FAILURE:
===============================
  # PERF_EXEC_PATH=`pwd` ./perf.python3 script -s ./scripts/python/exported-sql-viewer.py my_test_db
    Traceback (most recent call last):
    File "./scripts/python/exported-sql-viewer.py", line 2614, in <module>
       Main()
    File "./scripts/python/exported-sql-viewer.py", line 2601, in Main
      db, dbname = dbref.Open("main")
    File "./scripts/python/exported-sql-viewer.py", line 2573, in Open
      raise Exception("Failed to open database " + dbname + " error: " + db.lastError().text())
    Exception: Failed to open database my_test_db error: could not connect to server: No such file or directory
        Is the server running locally and accepting
        connections on Unix domain socket "/var/run/postgresql/.s.PGSQL.5432"?
    QPSQL: Unable to connect
    Error running python script ./scripts/python/exported-sql-viewer.py

Thanks,
Ravi

