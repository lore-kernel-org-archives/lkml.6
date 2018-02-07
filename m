Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753889AbeBGLNP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:13:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753693AbeBGLNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:13:14 -0500
Date: Wed, 7 Feb 2018 12:13:09 +0100
From: Jiri Benc <jbenc@redhat.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Christian Brauner <christian.brauner@canonical.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        netdev@vger.kernel.org, stephen@networkplumber.org,
        w.bumiller@proxmox.com, nicolas.dichtel@6wind.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net
Subject: Re: [PATCH net 1/1 v2] rtnetlink: require unique netns identifier
Message-ID: <20180207121309.46fdce62@redhat.com>
In-Reply-To: <877erphhry.fsf@xmission.com>
References: <20180205155550.21432-1-christian.brauner@ubuntu.com>
        <20180205155550.21432-2-christian.brauner@ubuntu.com>
        <2eac607b-e847-1b21-b3cb-6a45130138ee@virtuozzo.com>
        <20180205232438.GA8695@gmail.com>
        <877erphhry.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Feb 2018 16:31:29 -0600, Eric W. Biederman wrote:
> Frankly.  If we are talking precedence it should be:
> fds
> netnsids
> pids

The current order is 1. pids, 2. fds, though. Not that it matters much,
see below.

> I do think it makes a lot of sense to error if someone passes in
> duplicate arguments.  AKA multiple attribute that could select for
> the same thing.   No one will do that deliberately.  It doesn't make
> sense.  So it is just a nonsense case we have to handle gracefully,
> and correctly.  With correctness being the most important as otherwise
> people might just send in nonsense to exploit bugs.

Completely agreed. Let's just start returning error if more than one of
the pid/fs/netnsid attributes is specified. I don't think this is going
to break any user. And we'll not have to care about the order.

> I agree refusing to combine multiple attributes for the same thing
> sounds the most sensible course.

Yes, please.

Thanks!

 Jiri
