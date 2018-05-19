Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbeESDPb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 23:15:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42300 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751117AbeESDP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 23:15:29 -0400
Date: Sat, 19 May 2018 05:15:22 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [v4.17-rc5][bisected] be83bbf80682 breaks /proc/vmcore mmap
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051903-0020-0000-0000-0000041EE2C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051903-0021-0000-0000-000042B40FAD
Message-Id: <cover.thread-4f3684.your-ad-here.call-01526696764-ext-9375@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805190035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

be83bbf80682 "mmap: introduce sane default mmap limits" introduced a
problem with mapping /proc/vmcore if it is bigger than 2gb. This
breaks s390 kernel zfcpdump. But it should be a general problem.

Please consider the following one-liner fix, if it makes sense.

Vasily Gorbik (1):
  procfs: fix mmap() for /proc/vmcore

 fs/proc/inode.c | 1 +
 1 file changed, 1 insertion(+)

-- 
⢀⡵⣤⡴⣅  2.17.0
⠏⢟⡛⣛⠏⠇ space invaders edition
