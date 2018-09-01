Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BFBC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B092083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 01:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B092083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeIAFok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 01:44:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeIAFok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 01:44:40 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fvuo3-0007iQ-QB
        for linux-kernel@vger.kernel.org; Sat, 01 Sep 2018 01:34:32 +0000
Received: by mail-pf1-f200.google.com with SMTP id t23-v6so7775757pfe.20
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 18:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kvY4dx5qMhe3gGzuKiXxa54rrT3g0DYcjzNbL056+c=;
        b=Gf7aurhexYbIw9/f8pdATM5OcC8YtLKrnWvRqJoWtgeQhZ8oNkA6SM9L7rqZ4KIO3W
         sqWqvvycbQmkETuzhBOkyNnL7hbfC8Tjc1WVr0QDpp5nO+Cbol7MXKzsIdI+LVycNLfX
         riIebzLwSfOvsks02BdSRBVoz1ApcjnmUEN208A5jpakdsgJ1thwAnPPt2/gis6oVOdB
         SiZFKTk99gvssmSPApM1tzmpJHqHt3NkU6kLyGvQ8JEM8qeTS16eV3+T+CDC34gZ+gUe
         hV0yGXOsbZkBq/5REHTp7nVrln49xo8mEyi3v4hLVqhHH3XUKWC0ZJ103huXfD38x962
         AvKA==
X-Gm-Message-State: APzg51A3ysUS0E+b+TKbvACDjjI7xdT6hmy9ZpiY2f6zTzKJeE6uFvsV
        HFSlo61lcYHWuoCMMvc0QhI7/n8lqoyqh5PAb5JcagfMnjlLE+Jgew59DJwEIAaxEP5lIloutab
        KK6nAyUxmYM1rGjBK2031j31GI32zx9u/WW3LOEE3qA==
X-Received: by 2002:a63:2c0e:: with SMTP id s14-v6mr14934939pgs.199.1535765670378;
        Fri, 31 Aug 2018 18:34:30 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdYB03l/rfCPtGpmSTvPR+Rz6HW3hCveK/HLdSumc5on+FA8dLL171Q2poeQvyGkTvudxUC7OA==
X-Received: by 2002:a63:2c0e:: with SMTP id s14-v6mr14934924pgs.199.1535765670031;
        Fri, 31 Aug 2018 18:34:30 -0700 (PDT)
Received: from gmail.com ([208.181.63.202])
        by smtp.gmail.com with ESMTPSA id r85-v6sm29554723pfd.144.2018.08.31.18.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 18:34:29 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Sat, 1 Sep 2018 03:34:27 +0200
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180901013427.tj3t2mlik4t7hlt5@gmail.com>
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
 <20180829181303.4sacopk7y3p5xyou@gmail.com>
 <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830144544.tpross4jd6awou4u@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 04:45:45PM +0200, Christian Brauner wrote:
> On Thu, Aug 30, 2018 at 11:49:31AM +0300, Kirill Tkhai wrote:
> > On 29.08.2018 21:13, Christian Brauner wrote:
> > > Hi Kirill,
> > > 
> > > Thanks for the question!
> > > 
> > > On Wed, Aug 29, 2018 at 11:30:37AM +0300, Kirill Tkhai wrote:
> > >> Hi, Christian,
> > >>
> > >> On 29.08.2018 02:18, Christian Brauner wrote:
> > >>> From: Christian Brauner <christian@brauner.io>
> > >>>
> > >>> Hey,
> > >>>
> > >>> A while back we introduced and enabled IFLA_IF_NETNSID in
> > >>> RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
> > >>> to signficant performance increases since it allows userspace to avoid
> > >>> taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
> > >>> interfaces from the netns associated with the netns_fd. Especially when a
> > >>> lot of network namespaces are in use, using setns() becomes increasingly
> > >>> problematic when performance matters.
> > >>
> > >> could you please give a real example, when setns()+socket(AF_NETLINK) cause
> > >> problems with the performance? You should do this only once on application
> > >> startup, and then you have created netlink sockets in any net namespaces you
> > >> need. What is the problem here?
> > > 
> > > So we have a daemon (LXD) that is often running thousands of containers.
> > > When users issue a lxc list request against the daemon it returns a list
> > > of all containers including all of the interfaces and addresses for each
> > > container. To retrieve those addresses we currently rely on setns() +
> > > getifaddrs() for each of those containers. That has horrible
> > > performance.
> > 
> > Could you please provide some numbers showing that setns()
> > introduces signify performance decrease in the application?
> 
> Sure, might take a few days++ though since I'm traveling.

Hey Kirill,

As promised here's some code [1] that compares performance. I basically
did a setns() to the network namespace and called getifaddrs() and
compared this to the scenario where I use the newly introduced property.
I did this 1 million times and calculated the mean getifaddrs()
retrieval time based on that.
My patch cuts the time in half.

brauner@wittgenstein:~/netns_getifaddrs$ ./getifaddrs_perf 0 1178
Mean time in microseconds (netnsid): 81
Mean time in microseconds (setns): 162

Christian

I'm only appending the main file since the netsns_getifaddrs() code I
used is pretty long:

[1]:

#define _GNU_SOURCE
#define __STDC_FORMAT_MACROS
#include <fcntl.h>
#include <inttypes.h>
#include <linux/types.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#include "netns_getifaddrs.h"
#include "print_getifaddrs.h"

#define ITERATIONS 1000000
#define SEC_TO_MICROSEC(x) (1000000 * (x))

int main(int argc, char *argv[])
{
	int i, ret;
	__s32 netns_id;
	pid_t netns_pid;
	char path[1024];
	intmax_t times[ITERATIONS];
	struct timeval t1, t2;
	intmax_t time_in_mcs;
	int fret = EXIT_FAILURE;
	intmax_t sum = 0;
	int host_netns_fd = -1, netns_fd = -1;

	struct ifaddrs *ifaddrs = NULL;

	if (argc != 3)
		goto on_error;

	netns_id = atoi(argv[1]);
	netns_pid = atoi(argv[2]);
	printf("%d\n", netns_id);
	printf("%d\n", netns_pid);

	for (i = 0; i < ITERATIONS; i++) {
		ret = gettimeofday(&t1, NULL);
		if (ret < 0)
			goto on_error;

		ret = netns_getifaddrs(&ifaddrs, netns_id);
		freeifaddrs(ifaddrs);
		if (ret < 0)
			goto on_error;

		ret = gettimeofday(&t2, NULL);
		if (ret < 0)
			goto on_error;

		time_in_mcs = (SEC_TO_MICROSEC(t2.tv_sec) + t2.tv_usec) -
			      (SEC_TO_MICROSEC(t1.tv_sec) + t1.tv_usec);
		times[i] = time_in_mcs;
	}

	for (i = 0; i < ITERATIONS; i++)
		sum += times[i];

	printf("Mean time in microseconds (netnsid): %ju\n",
	       sum / ITERATIONS);

	ret = snprintf(path, sizeof(path), "/proc/%d/ns/net", netns_pid);
	if (ret < 0 || (size_t)ret >= sizeof(path))
		goto on_error;

	netns_fd = open(path, O_RDONLY | O_CLOEXEC);
	if (netns_fd < 0)
		goto on_error;

	host_netns_fd = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
	if (host_netns_fd < 0)
		goto on_error;

	memset(times, 0, sizeof(times));
	for (i = 0; i < ITERATIONS; i++) {
		ret = gettimeofday(&t1, NULL);
		if (ret < 0)
			goto on_error;

		ret = setns(netns_fd, CLONE_NEWNET);
		if (ret < 0)
			goto on_error;

		ret = getifaddrs(&ifaddrs);
		freeifaddrs(ifaddrs);
		if (ret < 0)
			goto on_error;

		ret = gettimeofday(&t2, NULL);
		if (ret < 0)
			goto on_error;

		ret = setns(host_netns_fd, CLONE_NEWNET);
		if (ret < 0)
			goto on_error;

		time_in_mcs = (SEC_TO_MICROSEC(t2.tv_sec) + t2.tv_usec) -
			      (SEC_TO_MICROSEC(t1.tv_sec) + t1.tv_usec);
		times[i] = time_in_mcs;
	}

	for (i = 0; i < ITERATIONS; i++)
		sum += times[i];

	printf("Mean time in microseconds (setns): %ju\n",
	       sum / ITERATIONS);

	fret = EXIT_SUCCESS;

on_error:
	if (netns_fd >= 0)
		close(netns_fd);

	if (host_netns_fd >= 0)
		close(host_netns_fd);

	exit(fret);
}

> 
> > 
> > I worry about all this just because of netlink interface is
> > already overloaded, while this patch makes it even less modular.
> 
> Introducing the IFA_IF_NETNSID property will not make the netlink
> interface less modular. It is a clean, RTM_*ADDR-request specific
> property using network namespace identifiers which we discussed in prior
> patches are the way to go forward.
> 
> You can already get interfaces via GETLINK from another network
> namespaces than the one you reside in (Which we enabled just a few
> months back.) but you can't do the same for GETADDR. Those two are
> almost always used together. When you want to get the links you usually
> also want to get the addresses associated with it right after.
> In a prior discussion we agreed that network namespace identifiers are
> the way to go forward but that any other propery, i.e. PIDs and fds
> should never be ported into other parts of the codebase and that is
> indeed something I agree with.
> 
> > In case of one day we finally reach rtnl unscalability trap,
> > every common interface like this may be a decisive nail in
> > a coffin lid of possibility to overwrite everything.
> > 
> > > The problem with what you're proposing is that the daemon would need to
> > > cache a socket file descriptor for each container which is something
> > > that we unfortunately cannot do since we can't excessively cache file
> > > descriptors because we can easily hit the open file limit. We also
> > > refrain from caching file descriptors for a long time for security
> > > reasons.
> > > 
> > > For the case where users just request a list of the interfaces we
> > > can already use RTM_GETLINK + IFLA_IF_NETNS which has way better
> > > performance. But we can't do the same with RTM_GETADDR requests which
> > > was an oversight on my part when I wrote the original patchset for the
> > > RTM_*LINK requests. This just rectifies this and aligns RTM_GETLINK +
> > > RTM_GETADDR.
> > > Based on this patchset I have written a userspace POC that is basically
> > > a netns namespace aware getifaddr() or - as I like to call it -
> > > netns_getifaddr().
> > > 
> > >>
> > >>> Usually, RTML_GETLINK requests are followed by RTM_GETADDR requests (cf.
> > >>> getifaddrs() style functions and friends). But currently, RTM_GETADDR
> > >>> requests do not support a similar property like IFLA_IF_NETNSID for
> > >>> RTM_*LINK requests.
> > >>> This is problematic since userspace can retrieve interfaces from another
> > >>> network namespace by sending a IFLA_IF_NETNSID property along but
> > >>> RTM_GETLINK request but is still forced to use the legacy setns() style of
> > >>> retrieving interfaces in RTM_GETADDR requests.
> > >>>
> > >>> The goal of this series is to make it possible to perform RTM_GETADDR
> > >>> requests on different network namespaces. To this end a new IFA_IF_NETNSID
> > >>> property for RTM_*ADDR requests is introduced. It can be used to send a
> > >>> network namespace identifier along in RTM_*ADDR requests.  The network
> > >>> namespace identifier will be used to retrieve the target network namespace
> > >>> in which the request is supposed to be fulfilled.  This aligns the behavior
> > >>> of RTM_*ADDR requests with the behavior of RTM_*LINK requests.
> > >>>
> > >>> Security:
> > >>> - The caller must have assigned a valid network namespace identifier for
> > >>>   the target network namespace.
> > >>> - The caller must have CAP_NET_ADMIN in the owning user namespace of the
> > >>>   target network namespace.
> > >>>
> > >>> Thanks!
> > >>> Christian
> > >>>
> > >>> [1]: commit 7973bfd8758d ("rtnetlink: remove check for IFLA_IF_NETNSID")
> > >>> [2]: commit 5bb8ed075428 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_NEWLINK")
> > >>> [3]: commit b61ad68a9fe8 ("rtnetlink: enable IFLA_IF_NETNSID for RTM_DELLINK")
> > >>> [4]: commit c310bfcb6e1b ("rtnetlink: enable IFLA_IF_NETNSID for RTM_SETLINK")
> > >>> [5]: commit 7c4f63ba8243 ("rtnetlink: enable IFLA_IF_NETNSID in do_setlink()")
> > >>>
> > >>> Christian Brauner (5):
> > >>>   rtnetlink: add rtnl_get_net_ns_capable()
> > >>>   if_addr: add IFA_IF_NETNSID
> > >>>   ipv4: enable IFA_IF_NETNSID for RTM_GETADDR
> > >>>   ipv6: enable IFA_IF_NETNSID for RTM_GETADDR
> > >>>   rtnetlink: move type calculation out of loop
> > >>>
> > >>>  include/net/rtnetlink.h      |  1 +
> > >>>  include/uapi/linux/if_addr.h |  1 +
> > >>>  net/core/rtnetlink.c         | 15 +++++---
> > >>>  net/ipv4/devinet.c           | 38 +++++++++++++++-----
> > >>>  net/ipv6/addrconf.c          | 70 ++++++++++++++++++++++++++++--------
> > >>>  5 files changed, 97 insertions(+), 28 deletions(-)
> > >>>
