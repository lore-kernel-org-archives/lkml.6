Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeB1MGY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:06:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752192AbeB1MGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:06:22 -0500
Date: Wed, 28 Feb 2018 04:06:17 -0800
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, ananth@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, oleg@redhat.com
Subject: Re: [RFC 0/4] trace_uprobe: Support SDT markers having semaphore
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18022812-0008-0000-0000-000004D57706
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022812-0009-0000-0000-00001E689B4E
Message-Id: <20180228120617.GA63063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> [2018-02-28 13:23:41]:

>   # readelf -n ./tick
>   Provider: tick
>   Name: loop2
>   ... Semaphore: 0x0000000010020036
> 
>   # readelf -SW ./tick | grep probes
>   [25] .probes           PROGBITS        0000000010020034 010034
> 
> 
> Semaphore offset is 0x10036. I don't have educated 'perf probe'
> about semaphore. So instead of using 'perf probe' command, I'm
> manually adding entry in the <tracefs>/uprobe_events file.
> Special char * denotes semaphore offset.
> 
> 
>   # echo "p:sdt_tick/loop2 /tmp/tick:0x6e4 *0x10036" > uprobe_events
> 
>   # perf stat -e sdt_tick:loop2 -- /tmp/tick
>   hi: 0
>   hi: 1
>   hi: 2
>   hi: 3
>   ^C
>   Performance counter stats for '/tmp/tick':
>               4      sdt_tick:loop2                                              
>      3.359047827 seconds time elapsed
> 
> 
> Feedback?
> 
> TODO:
>  - Educate perf tool about semaphore.
> 

Is it possible to extend perf buildcache with a new option to work with
semaphore?
