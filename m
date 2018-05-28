Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeE1DuF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 23:50:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753118AbeE1DuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 23:50:03 -0400
Subject: Re: [PATCH] perf test 39 (Session topology) dumps core on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20180524135600.77128-1-tmricht@linux.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Mon, 28 May 2018 09:19:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524135600.77128-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052803-0040-0000-0000-0000043E67DD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052803-0041-0000-0000-00002643B03F
Message-Id: <610eac04-1e34-9032-0a95-2f9818a31a9b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280045
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 05/24/2018 07:26 PM, Thomas Richter wrote:
> @@ -95,7 +98,7 @@ int test__session_topology(struct test *test __maybe_unused, int subtest __maybe
>  {
>  	char path[PATH_MAX];
>  	struct cpu_map *map;
> -	int ret = -1;
> +	int ret;

This is failing for me:

tests/topology.c: In function ‘test__session_topology’:
tests/topology.c:101:6: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  int ret;
      ^
cc1: all warnings being treated as errors
  CC       util/intlist.o
mv: cannot stat 'tests/.topology.o.tmp': No such file or directory
/home/ravi/Workspace/linux/tools/build/Makefile.build:96: recipe for target 'tests/topology.o' failed
make[4]: *** [tests/topology.o] Error 1
make[4]: *** Waiting for unfinished jobs....


Thanks,
Ravi
