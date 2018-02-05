Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeBEIRB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:17:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750943AbeBEIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:16:54 -0500
Date: Mon, 5 Feb 2018 09:16:06 +0100
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: s390 unistd.h & perf
References: <20180202162322.GF26905@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202162322.GF26905@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18020508-0016-0000-0000-0000051F6A32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020508-0017-0000-0000-0000285C1765
Message-Id: <20180205081606.GA4612@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802050106
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Feb 02, 2018 at 01:23:22PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 	I noticed, after fast forwarding my perf/urgent branch to
> torvalds/master, that this appears in my perf build:
> 
> Warning: Kernel ABI header at 'tools/arch/s390/include/uapi/asm/unistd.h' differs from latest version at 'arch/s390/include/uapi/asm/unistd.h'
> 
> 	Looking at the log for that file I noticed this cset:
> 
> 4381f9f12e79 ("s390/syscalls: use generated syscall_table.h and unistd.h header files")
> 
> 	Can you please take a look how this affects the syscall table
> generation process in tools/perf and how can we proceed to silence that
> warning, i.e. to update the copy we have in tools/?

I reworked the our system call table a bit to also have a text file containing
the system calls.  For this, I also have an update for perf.  Will post these
patches by end of this week.

Thanks and kind regards,
  Hendrik
