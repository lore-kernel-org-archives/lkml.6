Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752519AbeBIDyh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 22:54:37 -0500
Received: from mout.gmx.net ([212.227.17.22]:37673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752201AbeBIDyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 22:54:36 -0500
Message-ID: <1518148447.24350.34.camel@gmx.de>
Subject: Re: [RFC 2/2] Introduce sysctl(s) for the migration costs
From: Mike Galbraith <efault@gmx.de>
To: Rohit Jain <rohit.k.jain@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        joelaf@google.com, jbacik@fb.com, riel@redhat.com,
        juri.lelli@redhat.com, dhaval.giani@oracle.com
Date: Fri, 09 Feb 2018 04:54:07 +0100
In-Reply-To: <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
         <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:hhroIFAx2rJRYIMvWSLKN7lZ4Tu+3MovynRTrMkw1sSGjzJw9uQ
 8KfJDcGn370a/ApZHNl8iSmkrH1eIyxR3Hs8x3uQ56+Huv8hJ5sUM2Bl3VPH0QAj+wtZeEg
 82IwODhFGjhvP0DcXFi5xCNxvUW/McRUx1Cu9wjsi7jG5efUOhiIwjSdPvoD4BbaUBxdAMn
 /qht+jP3umYpbN1vb1ZZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8ZdK9L3l2/A=:9QLwgxoiIj/WBfZ6DEeP4y
 Cyid8DCoooVsNS4yTzU7+6TxE9xMBADfsarkg2NH0mYDMAP/y/277rkuuT9mhZNyY26nx8PdR
 YThzcTlRazGcxZDaV8lCEvC2fLDUuXjKyqT6p9irHjUzqwWBn2EB9rf/25JAwB5wKMmUz8q5q
 RUarbvuBdnfFjepkwqmQObvA98J05khH8bblsMtsMIygiMlDFP+5D0Co35V1gnb6W0T6Tg2Yk
 2/OERwwTmOejW7kQ0bWJ6omcw5SMivPD04VSRJtTWo8+/QiyoDzmWKL0Y1ixbrgDc4OPmQFnk
 s5uKN2pLzbtE5FNQ1LHTT8M07U5bXSumC3cR8D81M3GC/23+OqpiCJD19OJyNIbHy0mwhZ+Mv
 i/D5IQUorcmAfw7jiZcuiIQJGN/rqGKJUWWPgobVu46WJmNLQelc2ZnVZ56ik8tzZkzfjmrFL
 3RDVx5TjOHp3B2VC4se5MPxunKlVOky6B6MIi1IX0/F6iytk09LxNMR1O+bbQR3hfl7zEmBoz
 +H8LdWEik0YvATV96u79m0AZr+XqTH1+J6U0xzFEPzpufBxZJE4/nhUAYuxRcKY7uOtkQrG2h
 Y95Pi5tQL7d2eYeK3xuyxJ6D2n/oAyTuNspjIXeMpJi3p3t6DDODiP0mTZ4LQT5V7pn0vWILy
 3DGyolKK8HoqiqTXMBtoDq6omq0Um57+NORsJv9gF3/yRYEDZXwQOC0zImJ78q/L2UiCrIYWl
 6/syWtseS33FWplHJqVFofiRWR5cexbX4Q/qITX8bmeDbNWbrW2y6WJkH5Q5E1Bg4INNMmJG5
 jUvJSwudnkFIokmmBfjanI94GZ047RvFUOpHlblGoglJrtU5aA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-02-08 at 14:19 -0800, Rohit Jain wrote:
> This patch introduces the sysctl for sched_domain based migration costs.
> These in turn can be used for performance tuning of workloads.

With this patch, we trade 1 completely bogus constant (cost is really
highly variable) for 3, twiddling of which has zero effect unless you
trigger a domain rebuild afterward, which is neither mentioned in the
changelog, nor documented.

bogo-numbers++ is kinda hard to love.

	-Mike
