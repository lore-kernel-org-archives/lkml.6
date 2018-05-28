Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1111766-1527545200-2-17032558016244259252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527545200; b=WnK8Ep2Ut15X57jxAaNm2xIPFk53NZ9GN27+adwJYePdB4Jp0a
    hIH3P+wlLXH9gifoe0jGOrRtr0SlE+hBkZPzRjoVmiwxo3YXbzUYXihPcHgo65P0
    dBG3YfuR9srto+K2NZy7U6EkeECVGJNH+3Gmuzzx4xlNgdKgkBchyEOTrqYS7cC4
    8+hMtX9GpDo2yh36TWhEk1B0W4PJbWIM8L1P8mAmA29PRXt9vml1gQASfpuCuQ7m
    ifbbxVMC1esxMz3aGLvfYBXjVgpJl7ZZUUrAelWov7QoECpgqLs0WkPgAAYc3NYs
    Hcw+kfwCA4ddFU2Kb3Rmt+4gL8pgkObN46sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :mime-version:content-type:message-id:sender:list-id; s=fm2; t=
    1527545200; bh=nh0OnXUhtbz1A7/iby1jf55iCNggdTwSJQcQkFqX7mE=; b=P
    WLeIyeIhOUPTm6AQAGyh8r7Ov4xvB4+2USMIXqJuLDGwIg0Ni708m+McZLEmfDlX
    pFNxoWijztDMr50eH1fPbhBThTtKamTk6dvMKPW/f01fSKuQVhM/y3mAgUITVLxH
    /UEM1MXAxMTuHmznEAxoI1R24bKdYOzbYAyxYZgZhmYkEaiMNn0UBUbfYTr4pL/w
    i2ojf6Xsj03hd/HC8MsJEAaejPn+4BlPB/RINFUA23AxLH3WM+VkyhrVWj2pZiTx
    RqYFJMIiZM8hyl+fhrD1tbCu0MZj7ozdfzr+30sHl2S9mvMYj8UGM7THVm1QTuyv
    JcclcOWq5MVzHYZDBFgAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBgCSPXfseweGZWev7SxVd4IfGV5YdSd7h+1p1cZVodJ5ce+PT+L6tNP/FqCXjAxqwTBy/NO6lZnRvEwL7hLRbX5+OxbdIygnbjlnSUln4GALPiCdJSR
    OkEX4euOUJXdN9KiQDTi+l32KLZsAkTc8oer4MbUeqkrNa4TgImkmPo3vFqRQBpJt/4oHuEkG8z3wf7t8hkEjIieQZvg+DQd5VPXklGrTuVzYNj0hu0VuML1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=NEAV23lmAAAA:8 a=5jCBht2tGJ4gRT6qiNAA:9 a=erNY0-7vEpguNVtA:21
    a=Xbo8Jzl48kCKX_Gh:21 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934824AbeE1WGh (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 18:06:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934434AbeE1WGg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 18:06:36 -0400
Date: Mon, 28 May 2018 15:08:11 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org,
        torvalds@linux-foundation.org, roman.penyaev@profitbricks.com
Subject: LKMM litmus test for Roman Penyaev's rcu-rr
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052822-0044-0000-0000-0000041E72E2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000263; SDB=6.01039070; UDB=6.00531776; IPR=6.00818198;
 MB=3.00021346; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-28 22:06:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052822-0045-0000-0000-000008509605
Message-Id: <20180528220811.GA5221@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280262
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!

The litmus test below is a first attempt to model Roman's rcu-rr
round-robin RCU-protected linked list.  His test code, which includes
the algorithm under test, may be found here:

https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c

The P0() process below roughly corresponds to remove_conn_from_arr(),
with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
that the algorithm is safe, and also claims that it becomes unsafe if
either synchronize_rcu() is removed.

Does this in fact realistically model Roman's algorithm?  Either way,
is there a better approach?

							Thanx, Paul

------------------------------------------------------------------------

C C-RomanPenyaev-list-rcu-rr

{
	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
	int *y=z;
	int *x=y;
	int *w=x;
	int *v=w; (* List head is v. *)
	int *c=w; (* Cache, emulating ppcpu_con. *)
}

P0(int *c, int *v, int *w, int *x, int *y)
{
	rcu_assign_pointer(*w, y); /* Remove x from list. */
	synchronize_rcu();
	r1 = READ_ONCE(*c);
	if (r1 == x) {
		WRITE_ONCE(*c, 0); /* Invalidate cache. */
		synchronize_rcu();
	}
	smp_store_release(x, 0);  /* Emulate kfree(x). */
}

P1(int *c, int *v)
{
	rcu_read_lock();
	r1 = READ_ONCE(*c); /* Pick up cache. */
	if (r1 == 0) {
		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
	}
	r2 = rcu_dereference(*r1); /* Advance to next element. */
	smp_store_release(c, r2); /* Update cache. */
	rcu_read_unlock();

	/* And repeat. */
	rcu_read_lock();
	r3 = READ_ONCE(*c);
	if (r3 == 0) {
		r3 = READ_ONCE(*v);
	}
	r4 = rcu_dereference(*r3);
	smp_store_release(c, r4);
	rcu_read_unlock();
}

locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)
