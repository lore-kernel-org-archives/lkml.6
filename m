Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753130AbeCNIaF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 04:30:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750862AbeCNIaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 04:30:02 -0400
Subject: [linux-next][bisected c7c133f3][gcc 4.8.5] build fail with error:
 first argument to
 =?UTF-8?Q?=E2=80=98=5F=5Fbuiltin=5Fchoose=5Fexpr=E2=80=99?= not a constant
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>, mpe <mpe@ellerman.id.au>,
        sachinp <sachinp@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 13:59:54 +0530
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031408-8235-0000-0000-00000D28A6C9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008670; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002826; UDB=6.00510305; IPR=6.00782157;
 MB=3.00020026; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 08:30:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031408-8236-0000-0000-0000400DF5D7
Message-Id: <1521016194.31953.9.camel@abdul.in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Today's next kernel fails to build with gcc 4.8.5 on powerpc machine.


./include/linux/jiffies.h: In function ‘jiffies_delta_to_clock_t’:
./include/linux/kernel.h:855:2: error: first argument to ‘__builtin_choose_expr’ not a constant
  __builtin_choose_expr(__builtin_constant_p(x) &&  \
  ^
./include/linux/kernel.h:867:19: note: in expansion of macro ‘__max’
 #define max(x, y) __max(typeof(x), typeof(y), x, y)

Machine Type: Power8 Baremetal
gcc: 4.8.5


Builds fine when below patch is reverted
c7c133f3 kernel.h: skip single-eval logic on literals in min()/max()

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
