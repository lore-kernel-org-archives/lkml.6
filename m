Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753074AbeDISmD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:42:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751767AbeDISmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:42:02 -0400
Date: Mon, 9 Apr 2018 11:42:58 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] memory-model: fix cheat sheet typo
Reply-To: paulmck@linux.vnet.ibm.com
References: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523292618-10207-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040918-2213-0000-0000-0000028CD300
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008825; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01015496; UDB=6.00517792; IPR=6.00794747;
 MB=3.00020488; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-09 18:41:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040918-2214-0000-0000-000059B0FB3B
Message-Id: <20180409184258.GP3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090189
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 06:50:15PM +0200, Paolo Bonzini wrote:
> "RWM" should be "RMW", and that's more or less the extent to which I
> can claim to change the document. :)  In particular, "Self" is not
> documented and the difference between "Self" and "SV" is not clear
> to me.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Applied, though without the questions.  ;-)

"Self" is for things like smp_load_acquire() and smp_store_release()
that order themselves against later and earlier accesses, respectively.
This ordering applies to later/earlier access to all variables, not
just the one that smp_load_acquire()/smp_store_release() accessed.
In contrast, things like smp_mb() order only other accesses, not
themselves.  Or at least it is impossible to proves whether or not they
order themselves because they are not separately visible to other CPUs.

"SV" is "same variable", which applies to pretty much anything that
accesses a variable, but not to things like smp_mb() which do not.

Does that help?

							Thanx, Paul

> ---
>  tools/memory-model/Documentation/cheatsheet.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
> index 956b1ae4aafb..c0eafdaddfa4 100644
> --- a/tools/memory-model/Documentation/cheatsheet.txt
> +++ b/tools/memory-model/Documentation/cheatsheet.txt
> @@ -1,6 +1,6 @@
>                                    Prior Operation     Subsequent Operation
>                                    ---------------  ---------------------------
> -                               C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
> +                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
>                                --  ----  -  -  ---  ----  -  -  --  --  ---  --
> 
>  Store, e.g., WRITE_ONCE()            Y                                       Y
> -- 
> 1.8.3.1
> 
