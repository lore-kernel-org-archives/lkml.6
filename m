Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeEOAnh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 20:43:37 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:45940 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752336AbeEOAnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 20:43:35 -0400
X-Google-Smtp-Source: AB8JxZqiFx2c2f4+7hkFVZjG+5LIGO6p9RTrBIG1oGh0+CxvXMoPUIH43IDHrvD96MfkkabgWcPTKA==
Date: Mon, 14 May 2018 17:43:34 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 5/8] rcu: Use rcu_node as temporary variable in
 funnel locking loop
Message-ID: <20180515004334.GC209519@joelaf.mtv.corp.google.com>
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-6-joel@joelfernandes.org>
 <20180514180027.GC26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514180027.GC26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:00:27AM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 08:15:38PM -0700, Joel Fernandes (Google) wrote:
> > The funnel locking loop in rcu_start_this_gp uses rcu_root as a
> > temporary variable while walking the combining tree. This causes a
> > tiresome exercise of a code reader reminding themselves that rcu_root
> > may not be root. Lets just call it rcu_node, and then finally when
> > rcu_node is the rcu_root, lets assign it at that time.
> > 
> > Just a clean up patch, no logical change.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> I agree that my names could use some improvement, but given that you
> called it rnp_node in the patch and rcu_node in the commit log, I would
> argue that rnp_node has a Hamming-distance problem.  ;-)
> 
> How about rnp_start for the formal parameter, rnp for the cursor running
> up the tree, and retaining rnp_root for the root?

Ok, that's fine with me. Probably easier to read too. I will rewrite it
accordingly.

thanks,

- Joel
 
