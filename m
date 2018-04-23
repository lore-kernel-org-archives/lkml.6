Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeDWFov (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:44:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751216AbeDWFos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:44:48 -0400
Date: Mon, 23 Apr 2018 07:44:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [REVIEW][PATCH 15/22] signal/s390: Use force_sig_fault where
 appropriate
In-Reply-To: <20180420143811.9994-15-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
        <20180420143811.9994-15-ebiederm@xmission.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18042305-0040-0000-0000-00000431D182
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042305-0041-0000-0000-00002635F561
Message-Id: <20180423074437.1203f39f@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230061
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 09:38:04 -0500
"Eric W. Biederman" <ebiederm@xmission.com> wrote:

> Filling in struct siginfo before calling force_sig_info a tedious and
> error prone process, where once in a great while the wrong fields
> are filled out, and siginfo has been inconsistently cleared.
> 
> Simplify this process by using the helper force_sig_fault.  Which
> takes as a parameters all of the information it needs, ensures
> all of the fiddly bits of filling in struct siginfo are done properly
> and then calls force_sig_info.
> 
> In short about a 5 line reduction in code for every time force_sig_info
> is called, which makes the calling function clearer.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>  arch/s390/kernel/traps.c | 32 ++++++--------------------------
>  arch/s390/mm/fault.c     | 23 ++++++-----------------
>  2 files changed, 12 insertions(+), 43 deletions(-)
 
Compiles & boots. Comparing old vs. new the same values are
set in siginfo. Looks good.

Acked-by: Martin Schwidefsky >schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
