Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752839AbeCMVSq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 17:18:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751903AbeCMVSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 17:18:45 -0400
Date: Tue, 13 Mar 2018 14:18:37 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: John Garry <john.garry@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf-core build fails on powerpc
References: <20180313191742.GA29120@us.ibm.com>
 <152d2ba4-fe57-beab-87d5-554a0fede9ae@huawei.com>
 <20180313201003.GB29120@us.ibm.com>
 <543acf58-520d-e3e2-211e-17068d713a4f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543acf58-520d-e3e2-211e-17068d713a4f@huawei.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.7.1 (2016-10-04)
X-TM-AS-GCONF: 00
x-cbid: 18031321-0048-0000-0000-0000024A1270
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008668; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002608; UDB=6.00510174; IPR=6.00781938;
 MB=3.00020014; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 21:18:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031321-0049-0000-0000-0000446D607B
Message-Id: <20180313211837.GC29120@us.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Garry [john.garry@huawei.com] wrote:
> On 13/03/2018 20:10, Sukadev Bhattiprolu wrote:
> 
> > Hi John,
> > 
> > I have an xfs file system which seems to have d_type == DT_UNKNOWN for all
> > entries in 'tools/perf/pmu-events/arch/power8'! readdir(3) says ->d_type
> > may not be supported by all file systems.
> > 
> > Not relying on ->d_type seems to fix it:
> > 
> 
> Hi Sukadev,
> 
> Thanks for debugging this. Jiri Olsa (cc'ed) warned me on this, so I did add
> the check for d_type == DT_UNKNOWN.
> 
> But, if all files have d_type == DT_UNKNOWN, you're code would from visual
> observation look to be same as mine (apart from check for '.' or '..'
> filename, which I would say is already covered by stat() and S_ISDIR()). Or
> is d_type value just unreliable?

In the current code and with DT_UNKNOWN, is_leaf_dir() returns false when
it sees the "." or ".." entries right? In the new code, we skip those and
return false only if we find some other directory. 

Thanks,

Sukadev
