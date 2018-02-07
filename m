Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754278AbeBGRy1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:54:27 -0500
Received: from resqmta-ch2-11v.sys.comcast.net ([69.252.207.43]:51412 "EHLO
        resqmta-ch2-11v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753896AbeBGRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:54:25 -0500
Date: Wed, 7 Feb 2018 11:54:22 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Steven Rostedt <rostedt@goodmis.org>
cc: Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        mingo@redhat.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
In-Reply-To: <20180207122910.1a91a48e@gandalf.local.home>
Message-ID: <alpine.DEB.2.20.1802071152580.22710@nuc-kabylake>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain> <20180207021703.GC3617@linux.vnet.ibm.com> <20180207042334.GA16175@bombadil.infradead.org> <alpine.DEB.2.20.1802071040570.22131@nuc-kabylake> <20180207120949.62fa815f@gandalf.local.home>
 <20180207171936.GA12446@bombadil.infradead.org> <20180207122910.1a91a48e@gandalf.local.home>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfOnw7sutZvncgfyDJO89s+RkTHRH3/dniDNsnIDaRi91Vl1cOcWuONdCZpOAt4YuyHOHQOGgs8JdCC3UciNnRFEtgPTYLxP51vh121ZiGJzRd7zHoHkY
 i4Hqs4ISZMFsjXFL467BDDnUG8sz8tyxbFIgIninIoa/EQZTM8JsdhfkqbEIEOh7t6Yhn7ex7kLkvAQENdNPc/L9SHopQ8gEDzlEKAvJjmTkqhNR1hZoZoXN
 XiB1sewFnsLTh8fDYWqPUp9EYVJSmhT8eloAp0OPKVfHJ+PEXrhmC/bt3dzKI8dX8ffzacrSflt599Zre260D0UMYgCVxNkU4mc0FSquZJRcofNuJ9+ZThUc
 Vruyxl0X+xUPKaZqNluIpDIXdjgKctZ6JBhYeOY8U9RryfMWMMc/jiuAWYClyvHDil0Ao0uo4e2AjeYoXZGadcxqy1M3X1rmerr1V5uw6xbAgjpDwHPpCEJI
 HKSyLr3OrOxcmokq6VSC38b97kAcn8vGVoUVjaDtmcKVYW1y1nx/5PGTsxG6GDAwkhbxdi09/4K6mOuEthk69nlN+uQt06Gu9uvxue6gKYFHCdgrnmENY1wZ
 efIpfoqdbCE+kXOjLBir8HAwx2SUJ0YLnURu9gLrpJ9J4tNmJlhRohtROF4nIkKKdxkWRb/VRZ2HYbx7EmaePSrk
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2018, Steven Rostedt wrote:

> But a generic "malloc" or "free" that does things differently depending
> on the size is a different story.

They would not be used for cases with special requirements but for the
throwaway allows where noone cares about these details. Its just a
convenience for the developers that do not need to be bothered with too
much detail because they are not dealing with codepaths that have special
requirements.
