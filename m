Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2038058-1527595777-2-15431000446703525609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527595777; b=Oyu6bOQAXSJfSHACo2fFcnobObU6314GJhP4UhoUQ2zRapGmwM
    jA/7QGFv1ocsqk6SnZwlFa1sN6/BKW6eHH23ja3DpGbJmWXpls5VMC8eBzZWODS1
    2i9G/33r5VfdnWNxUgi1oL98qKV2QLsAbCMRpkN7taXqtTLgE2a/8+ayGUCu9k0Z
    t1kJClRc7vsDIISH7jkRIF/YwiyzzydWghZ/6TjxH71V7h/GBTTDfP7RO0J9nDIn
    nigUC3f0Hm/tXhiiNkWvAt+lXLczNZCKrhu2YTdeTNj3Yb3JlG1gyZLCdhRJGORl
    0FImtjFkig58ThvxwKyzVpDjD7qeqPHPbn1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527595777; bh=VjrSwM+CdLPS9mOBE9v9uZR
    2sfhhx6mYpYLeIHIAFro=; b=O9hCtlloSOV63mQt9MI1WyR9r+f+QDe+zgDo34p
    wGd8pqKB4ZvPnm+ZgJiRHFx6udNyM/5/tzSbeDslyKnXTs2zeCpA0JuuB4vBCaAo
    nLomgjkxsBDNyJ2LGImFb8GLA3sMVkzOpUFKHGrK8ZUHR6AEOwQaKNDiRu0ngTpZ
    y0esW+1WesMsKcQilK9lb6wa+wM1Ed50IjvqEpfHO5QDq5VRtewAj8133fw6Rag/
    TB8ObTWsR0tf7RgwF/tmua3MrvDtvcQRkcrDPp7ErCQF1EppP0b1qwPSh8FGQmz2
    0rmP/F6/vVe50J5xXzRZXuMCIFW3d6xRQNTiHpOYpUaN6Vg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI47ByqHqaZqTN2YyGYW1zTTPRflds9ovUCzx+K3XJLMSzRmnH92zUYl6RueHpn/pJWYzQ4coJYFaDqtmpqH2iwBJ6WY7vOIEBsl0GS5pddXwrU0QLx8
    ASeuITkMjlp5TaBPQONzdtcH5DGNQJ8QHzhXmHp52ia1LGWYDvLSABSMaVz5C6WyYdh7eOuknLa6ZRil8hDkF5vZKhu1uG4EtfxeD4jFe2c6f5cWEp4LS8+R
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=7gfbgRp0pa4TWhDk674A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeE2MJe (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 08:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933419AbeE2MJd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 08:09:33 -0400
Date: Tue, 29 May 2018 05:11:07 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, mingo@kernel.org
Subject: Re: [PATCH RFC tools/memory-model] Add litmus-test naming scheme
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180525191020.GA5914@linux.vnet.ibm.com>
 <20180529093050.GB6533@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529093050.GB6533@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052912-0040-0000-0000-000004362484
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039351; UDB=6.00530820; IPR=6.00818480;
 MB=3.00021357; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 12:09:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0041-0000-0000-0000083C490A
Message-Id: <20180529121107.GF3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290139
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 10:30:50AM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Fri, May 25, 2018 at 12:10:20PM -0700, Paul E. McKenney wrote:
> > This commit documents the scheme used to generate the names for the
> > litmus tests.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > ---
> >  README |  136 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 135 insertions(+), 1 deletion(-)
> 
> Whilst I think documentation like this is extremely important for users,
> this feels like it's documenting how to drive parts of diy and I'm not
> convinced that it belongs in the kernel source tree as long as the projects
> remain separate.
> 
> Why not contribute this to the herdtools7 documentation, then just reference
> that from here? That would also be helpful for other people interested in
> memory models, but perhaps not interested in Linux (assuming such people
> exist ;).

We would still need at least a pointer from the Linux kernel to that
documentation, but I am happy either way.  We probably need examples of
the common cases, but probably not a full exposition of all the available
herd7 edges.

Should this be in the herdtools7 documentation, or as added detail
from a variation on the "diyone7 -bell linux-kernel.bell -show edges"
command?  If the latter, I suppose that the ones coming from the .bell
file might simply be labelled as such.

							Thanx, Paul
