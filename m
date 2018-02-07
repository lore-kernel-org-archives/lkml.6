Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbeBGQrH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:47:07 -0500
Received: from resqmta-ch2-08v.sys.comcast.net ([69.252.207.40]:60038 "EHLO
        resqmta-ch2-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754490AbeBGQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:47:06 -0500
Date: Wed, 7 Feb 2018 10:47:02 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, mingo@redhat.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
In-Reply-To: <20180207042334.GA16175@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.20.1802071040570.22131@nuc-kabylake>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain> <20180207021703.GC3617@linux.vnet.ibm.com> <20180207042334.GA16175@bombadil.infradead.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfHGw4Hvcp66gHBR1iIk5FV5wgIHfe9u53KpyriSGpy1EIkkf4TKuO2e4f+5ONwLIJhnw6Jf/ryLIp359IwuLpuwr/McjMuXl9LyTFEhI4+lMCF7ZmMqT
 IJOsCv18BZGE1QnNblzvw0KfT/8JDnsp6OojkOJvm8eKsx6xXYjHdYnf0tRrDrqyWq1NoFzumYC2Aab4z1pmXpd6DUYQSQWOBw5bZl5Iy1P7SaDgkuVFw2Qu
 1Axr7B+iunfD0H0jbVS65JvT1Xo5IaXNGShaWExl5+nvZuYB0ftPBWlRwHf3mxDviTpXmMuGjlosFhe9H0ljB58ksvf4di+WSmKb5L1O2Aw2DWYoCiXrDgwf
 jZ2PjZWRNKFVDMIEvYKYcR4eBrWgCp+O5q8Teki+DOzaEwJKN8Hcu6TlAKw4sHd7DzJQb4vVIBBv5XDhl2unFvP0ZW2FqNXE+WsUhfhRFCLb4ka4rpmC/bUr
 W/crs4YRIgvSCp0L/9arkJv3rRMpPfwYuXA/k+TFqarNtA5VNfA8A0eMbbLlfcW6iuB9n1kE4moZIfjcvsNZ9ZICHQ3hHafDOCrlis5UccojcGn1WgpiPgdB
 VL5eYvBPe6+akpl2cKqP3UEHUdMHwtVEh0A0NKtDkIYSIJJ3EW5eUcV+1riVh2TimX87/pynRXtiVRnpCACF8dCf
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Matthew Wilcox wrote:

> Personally, I would like us to rename kvfree() to just free(), and have
> malloc(x) be an alias to kvmalloc(x, GFP_KERNEL), but I haven't won that
> fight yet.

Maybe lets implement malloc(), free() and realloc() in the kernel to be
consistent with user space use as possible? Only use the others
allocation variants for special cases.

So malloc would check allocation sizes and if < 2* PAGE_SIZE use kmalloc()
otherwise vmalloc().

free() would free anything you give it.
