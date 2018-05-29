Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2837379-1527634310-2-13128677994902363162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527634310; b=egq3gY1/h+87ZGhgefN0a4x20Xlkspza49vRusmtWTJfebWUjE
    8IH39I56oX85kb1Tt5UYiLwoKuVS9RsBlsB03QMLPJYJw6Tko+SWtnuuEvof/c03
    SkSOjaE5HxJqPXpt6icxpG4HLwJzObXFIdPg66St4RvWAyofJWnd8IX5QMqIzGG3
    AzbARr5d19Zy/hB0nwuQ7MUjRNsJyWd/Tly7Xy5NRlDVMO0TZh5w+cXLjLZbvx2Z
    vgQKsWicPUS1Btap27qwI3kbA+4IksZtYsxj+67OS7P+leYTO+9Mv949TRDDwREo
    aM6gusSNJ/c6hYEUhxWEy9vqUktgl1lDAj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id
    :sender:list-id; s=fm2; t=1527634310; bh=xjnkwHNmMyBN2b1Upe9qVBu
    nq91xsxZDoF76aKvBaH0=; b=DfA5nAEBuf7pebDYU1vqsgfgCbLu7W/oprFidFo
    YikJOvZUpTwzq8Bc0sEsJz0nTWMzdz5qQBfMu/Kg4hos58nZcJF857W2tH5vrvzf
    Snq4zewOMIFXHB9F0KMPgmsqUJ5neQsExQM7xoWWFGFHGDmFIQN0qYBsGUnOC3Yd
    aKKO4OGycLcufwwAduONPN2CJMMZ7cbEt/RdisnFJiYg6ed3RlAuU7NuFup8H8eE
    0pwwXOxoXoR+4w5MgVZDmTKFD2QujYWETyogFv5T7plnkzkNi37p0GkXJ0KaVVOA
    a0sxGzC+b2mc0OktZLb1Sb8CxK22ahjL/ZSRA/DfO0bLyWQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfFVGVKIYozXrczUt0EtkdfoGZakh/m8WmzBSvoLyyZsb3fVmY86wiKeIeqmoS6hj3NnLKDr4f4eoWLabFAFdfyF/+OfGThs+9M1jNmbitvBQuFZSRSri
    gdmqzcfjTTMDpZ63/hnD6QH9j3lWCGETaeJ7svKoM75qlJ+DdnZC1VhT9uarzhDnYFkoAwuhUfg9OxG1Ta0SdyOse9zfpp77e/LaDPm3pG+m2UTqE9Lnx76D
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-KG_OBUHnIVKuRwLwd8A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935848AbeE2Wvq (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 18:51:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935806AbeE2Wvp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 May 2018 18:51:45 -0400
Date: Tue, 29 May 2018 15:53:21 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Roman Pen <roman.penyaev@profitbricks.com>
Subject: Re: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180529190332.GO3803@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1805291521570.1458-100000@iolanthe.rowland.org>
 <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzYca7EBTEbhJMoJcGspVGhmty243WQR_w7Eykmw9HX9w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052922-2213-0000-0000-000002AF3E5E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009097; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039566; UDB=6.00530826; IPR=6.00818694;
 MB=3.00021364; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-29 22:51:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052922-2214-0000-0000-00005A499796
Message-Id: <20180529225321.GQ3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805290242
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 04:10:02PM -0500, Linus Torvalds wrote:
> On Tue, May 29, 2018 at 3:49 PM Alan Stern <stern@rowland.harvard.edu>
> wrote:
> 
> > Putting this into herd would be extremely difficult, if not impossible,
> > because it involves analyzing code that was not executed.

One (ugly) way to handle it, assuming we are correct about what it
happening, would be to place ordering on the other side of the "if"
that is at least as strong as on the first side.  Probably some example
that completely breaks this approach, though...

> Does it?
> 
> Can't we simplify the whole sequence as basically
> 
>      A
>      if (!B)
>          D
> 
> for that "not B" case, and just think about that. IOW, let's ignore the
> whole "not executed" code.
> 
> If B depends on A like you state, then that already implies that the write
> in D cannot come before the read of A.
> 
> You fundamentally cannot do a conditional write before the read that the
> write condition depends on. So *any* write after a conditional is dependent
> on the read.
> 
> So the existence of C - whether it has a barrier or not - is entirely
> immaterial at run-time.
> 
> Now, the *compiler* can use the whole existence of that memory barrier in C
> to determine whether it can re-order the write to D or not, of course, but
> that's a separate issue, and then the whole "code that isn't executed" is
> not the issue any more. The compiler obviously sees all code, whether
> executing or not.
> 
> Or am I being stupid and missing something entirely? That's possible.

This will take some analysis, both to make sure that I got Roman's
example correct and to get to the bottom of exactly what LKMM thinks
can be reordered.  I am shifting timezones eastward, so I am not going
to dig into it today.

But here are a couple of things that take some getting used to:

1.	The "if (r1 == x)" would likely be "if (r1 == &x)" in the Linux
	kernel.

2.	Unless there is something explicit stopping the reordering, the
	herd tool assumes that the compiler can reorder unrelated code
	completely across the entirety of an "if" statement.  It might
	well have decided that it could do so in this case, due to the
	fact that the "if" statement isn't doing anything with x (just
	with its address).

	But yes, given that r1 comes from the load from *c, it would
	be difficult (at best) to actually apply that optimization in
	this case.

But let's find out what is really happening.  Easy to speculate, but
much harder to speculate correctly.  ;-)

							Thanx, Paul
