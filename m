Return-Path: <SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3819521-1520445488-2-6043566717022141265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520445487; b=MyQNWXTuyVi3d270NfdTxSg76mR9rNpVZv3qcvuVVsjE4Gm
    Wxf+1eR4lBvNgdaulNLWciy2gWySjtcplrDglFfEiW1Z2I4wOVofHLtW2e6a3uPZ
    2NC9sVV3qcK4FMjHTkJ53Dpdo4LVPA+fxzXvEgssWyuFSTylyJhELAN2CPJCU6bm
    DmhWmuifvqVBEJ2LhOYlPbrZGKMMEiCazymUK0ExDg1l1HxJHle3mDfhAcjHz/sj
    SA87YTksgCorFnGJgBSL/BSQWLrzlB3fI3yGVxxlWNx64T4Wgyk9RYWtkjyktzSp
    ijR+AOT9J0O55pP41Ba23nylJBfa6snPnCanyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:reply-to
    :references:mime-version:content-type:in-reply-to:message-id; s=
    arctest; t=1520445487; bh=Rwuwv+oYg7dEnQftSE3NysXbbJphjgGF3sr0Tk
    TkhF4=; b=BKI2fDH6rmwpvxMf5G/xY6W36T8ZzrFlctm9UKnJoKZEQCM/c66BUs
    Hd7uI/THDygWcvXPMr4NobDQzCMfs1YVb7DkEgK41RCzOZQR+MCudAMvm8139on4
    I8ku50b1N0ZWc8k9/VG6BIvO2V/zL6H9tbIi0hnduUwXrrv8TCvxrNRY2jB9htH+
    T2yv3nsmv6VyGG6Vltt4Zb0PH+cTY4/1sex+PfLWA0YCQtt0ngWNdx/yyHplQGfw
    xEL5Ut2LCjt+2dIgeBuWBUUiIp3tHpbrfVFaQb2cPYTdhCJzew6YQzAf+A5k9ebO
    sY/Ng2MwRql+rY+imXfSoa8s4UPjDxZg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,d=none) header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=jjiN=F5=linux.vnet.ibm.com=paulmck@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=linux.vnet.ibm.com header.result=pass header_org.domain=ibm.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF02D21770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=paulmck@linux.vnet.ibm.com
Date: Wed, 7 Mar 2018 09:58:33 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Lai Jiangshan <jiangshanlai+lkml@gmail.com>, Tejun Heo <tj@kernel.org>,
        torvalds@linux-foundation.org, jannh@google.com, bcrl@kvack.org,
        viro@zeniv.linux.org.uk, kent.overstreet@gmail.com,
        security@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 7/7] RCU, workqueue: Implement rcu_work
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180306172657.3060270-1-tj@kernel.org>
 <20180306173316.3088458-1-tj@kernel.org>
 <20180306173316.3088458-7-tj@kernel.org>
 <CAJhGHyAuz3TRCpPnCBzZ+om3k9N3ykCWYOq_bv+hucV=XXiY9w@mail.gmail.com>
 <20180307145408.GC3918@linux.vnet.ibm.com>
 <20180307162317.GO25181@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307162317.GO25181@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030717-0036-0000-0000-000002CC6BF7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008630; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999671; UDB=6.00508503; IPR=6.00779076;
 MB=3.00019896; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-07 17:58:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030717-0037-0000-0000-000043919BC1
Message-Id: <20180307175833.GF3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803070205
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 05:23:17PM +0100, Peter Zijlstra wrote:
> On Wed, Mar 07, 2018 at 06:54:08AM -0800, Paul E. McKenney wrote:
> > One downside of allowing RCU callback functions to sleep is that
> > one poorly written callback can block a bunch of other ones.
> 
> Not to mention that we really want the RCU callbacks to be simple and
> short. Needing fancy things in the callback really should be the
> exception not the rule.

Very much agreed with that as well!

Besides, Tejun's queue_rcu_work() provides this functionality and
seems pretty straightforward to use.

							Thanx, Paul
