Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB54C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5152075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF5152075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeICSnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:43:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeICSnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:43:15 -0400
Received: from mail-wm0-f69.google.com ([74.125.82.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1fwpkg-00042d-2e
        for linux-kernel@vger.kernel.org; Mon, 03 Sep 2018 14:22:50 +0000
Received: by mail-wm0-f69.google.com with SMTP id s205-v6so730072wmf.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6tUNnLBUiNGvfisC7bfJCfrZKOJiSlHSFwL1IbZMA7g=;
        b=QJizQoORbNtCu/CFeXhAgciQJql8oZY+iAy3rUieMcOv8ALf7TB5C2MBIAfvv3T5R5
         6fPWuVcEF/mUAbTUPn45oJoaJA4pco/s0F0mU0TypJk8UdbGoJx0HwaJpygFsH5pY4h/
         A3XI4BvZQSx3oMydlhVZcLi14Ym9lPPU/59WN07hLP2AySDWSQLjkqh5XPUpjtYfvCoJ
         2uS6gqiodpOneKSZh5VhaE34hjRFWg7hxYHPgyEppguysGLHEuIbaCdOos0bAMymcmKM
         eL1BTiBm5RE8YtMqtgYDtEAeH6C4JEGbV/j7GSv+Hy39OkPQ3v4kmFR+xIvPFwbNwL15
         ovOg==
X-Gm-Message-State: APzg51Cwp7Qb4LGvG1edJmDoM4p6mLH+erV3KvXOF20MklvOcdFDTHK6
        oN6MG7aEWJuIV+mfWl/Pbgd1Lck2C1KqdxV0syJEzeZDbitFfNUu7euGhQ80VayiWDpaRxPbjB1
        +n8IPOMuRFi7f2vZa5HCmTAg6pcIUyhUU9h97BMy0xQ==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr5498606wmh.134.1535984569556;
        Mon, 03 Sep 2018 07:22:49 -0700 (PDT)
X-Google-Smtp-Source: ANB0VdZXktrGTUiCG6wFLlZ89wn6DUxmHE/cQ2XWN2E9t8GOxIwXt5sX8rk4GasIqNcy4440NYzEFA==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr5498584wmh.134.1535984569211;
        Mon, 03 Sep 2018 07:22:49 -0700 (PDT)
Received: from gmail.com ([2a02:8070:8895:9700:c821:418a:c0d6:253e])
        by smtp.gmail.com with ESMTPSA id d1-v6sm16015349wrc.52.2018.09.03.07.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:22:48 -0700 (PDT)
From:   Christian Brauner <christian.brauner@canonical.com>
X-Google-Original-From: Christian Brauner <christian@brauner.io>
Date:   Mon, 3 Sep 2018 16:22:47 +0200
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, dsahern@gmail.com, fw@strlen.de,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180903142246.wvgucy57phpipy7h@gmail.com>
References: <20180828231859.29758-1-christian@brauner.io>
 <adc2fae5-e22b-3a74-d531-01570e7970ee@virtuozzo.com>
 <20180829181303.4sacopk7y3p5xyou@gmail.com>
 <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
 <20180830144544.tpross4jd6awou4u@gmail.com>
 <20180901013427.tj3t2mlik4t7hlt5@gmail.com>
 <2319a029-7aca-b7aa-2e8f-4dfdeedcb6df@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2319a029-7aca-b7aa-2e8f-4dfdeedcb6df@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:41:45PM +0300, Kirill Tkhai wrote:
> On 01.09.2018 04:34, Christian Brauner wrote:
> > On Thu, Aug 30, 2018 at 04:45:45PM +0200, Christian Brauner wrote:
> >> On Thu, Aug 30, 2018 at 11:49:31AM +0300, Kirill Tkhai wrote:
> >>> On 29.08.2018 21:13, Christian Brauner wrote:
> >>>> Hi Kirill,
> >>>>
> >>>> Thanks for the question!
> >>>>
> >>>> On Wed, Aug 29, 2018 at 11:30:37AM +0300, Kirill Tkhai wrote:
> >>>>> Hi, Christian,
> >>>>>
> >>>>> On 29.08.2018 02:18, Christian Brauner wrote:
> >>>>>> From: Christian Brauner <christian@brauner.io>
> >>>>>>
> >>>>>> Hey,
> >>>>>>
> >>>>>> A while back we introduced and enabled IFLA_IF_NETNSID in
> >>>>>> RTM_{DEL,GET,NEW}LINK requests (cf. [1], [2], [3], [4], [5]). This has led
> >>>>>> to signficant performance increases since it allows userspace to avoid
> >>>>>> taking the hit of a setns(netns_fd, CLONE_NEWNET), then getting the
> >>>>>> interfaces from the netns associated with the netns_fd. Especially when a
> >>>>>> lot of network namespaces are in use, using setns() becomes increasingly
> >>>>>> problematic when performance matters.
> >>>>>
> >>>>> could you please give a real example, when setns()+socket(AF_NETLINK) cause
> >>>>> problems with the performance? You should do this only once on application
> >>>>> startup, and then you have created netlink sockets in any net namespaces you
> >>>>> need. What is the problem here?
> >>>>
> >>>> So we have a daemon (LXD) that is often running thousands of containers.
> >>>> When users issue a lxc list request against the daemon it returns a list
> >>>> of all containers including all of the interfaces and addresses for each
> >>>> container. To retrieve those addresses we currently rely on setns() +
> >>>> getifaddrs() for each of those containers. That has horrible
> >>>> performance.
> >>>
> >>> Could you please provide some numbers showing that setns()
> >>> introduces signify performance decrease in the application?
> >>
> >> Sure, might take a few days++ though since I'm traveling.
> > 
> > Hey Kirill,
> > 
> > As promised here's some code [1] that compares performance. I basically
> > did a setns() to the network namespace and called getifaddrs() and
> > compared this to the scenario where I use the newly introduced property.
> > I did this 1 million times and calculated the mean getifaddrs()
> > retrieval time based on that.
> > My patch cuts the time in half.
> > 
> > brauner@wittgenstein:~/netns_getifaddrs$ ./getifaddrs_perf 0 1178
> > Mean time in microseconds (netnsid): 81
> > Mean time in microseconds (setns): 162
> > 
> > Christian
> > 
> > I'm only appending the main file since the netsns_getifaddrs() code I
> > used is pretty long:
> > 
> > [1]:
> > 
> > #define _GNU_SOURCE
> > #define __STDC_FORMAT_MACROS
> > #include <fcntl.h>
> > #include <inttypes.h>
> > #include <linux/types.h>
> > #include <sched.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/stat.h>
> > #include <sys/time.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> > 
> > #include "netns_getifaddrs.h"
> > #include "print_getifaddrs.h"
> > 
> > #define ITERATIONS 1000000
> > #define SEC_TO_MICROSEC(x) (1000000 * (x))
> > 
> > int main(int argc, char *argv[])
> > {
> > 	int i, ret;
> > 	__s32 netns_id;
> > 	pid_t netns_pid;
> > 	char path[1024];
> > 	intmax_t times[ITERATIONS];
> > 	struct timeval t1, t2;
> > 	intmax_t time_in_mcs;
> > 	int fret = EXIT_FAILURE;
> > 	intmax_t sum = 0;
> > 	int host_netns_fd = -1, netns_fd = -1;
> > 
> > 	struct ifaddrs *ifaddrs = NULL;
> > 
> > 	if (argc != 3)
> > 		goto on_error;
> > 
> > 	netns_id = atoi(argv[1]);
> > 	netns_pid = atoi(argv[2]);
> > 	printf("%d\n", netns_id);
> > 	printf("%d\n", netns_pid);
> > 
> > 	for (i = 0; i < ITERATIONS; i++) {
> > 		ret = gettimeofday(&t1, NULL);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		ret = netns_getifaddrs(&ifaddrs, netns_id);
> > 		freeifaddrs(ifaddrs);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		ret = gettimeofday(&t2, NULL);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		time_in_mcs = (SEC_TO_MICROSEC(t2.tv_sec) + t2.tv_usec) -
> > 			      (SEC_TO_MICROSEC(t1.tv_sec) + t1.tv_usec);
> > 		times[i] = time_in_mcs;
> > 	}
> > 
> > 	for (i = 0; i < ITERATIONS; i++)
> > 		sum += times[i];
> > 
> > 	printf("Mean time in microseconds (netnsid): %ju\n",
> > 	       sum / ITERATIONS);
> > 
> > 	ret = snprintf(path, sizeof(path), "/proc/%d/ns/net", netns_pid);
> > 	if (ret < 0 || (size_t)ret >= sizeof(path))
> > 		goto on_error;
> > 
> > 	netns_fd = open(path, O_RDONLY | O_CLOEXEC);
> > 	if (netns_fd < 0)
> > 		goto on_error;
> > 
> > 	host_netns_fd = open("/proc/self/ns/net", O_RDONLY | O_CLOEXEC);
> > 	if (host_netns_fd < 0)
> > 		goto on_error;
> > 
> > 	memset(times, 0, sizeof(times));
> > 	for (i = 0; i < ITERATIONS; i++) {
> > 		ret = gettimeofday(&t1, NULL);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		ret = setns(netns_fd, CLONE_NEWNET);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		ret = getifaddrs(&ifaddrs);
> > 		freeifaddrs(ifaddrs);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		ret = gettimeofday(&t2, NULL);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		ret = setns(host_netns_fd, CLONE_NEWNET);
> > 		if (ret < 0)
> > 			goto on_error;
> > 
> > 		time_in_mcs = (SEC_TO_MICROSEC(t2.tv_sec) + t2.tv_usec) -
> > 			      (SEC_TO_MICROSEC(t1.tv_sec) + t1.tv_usec);
> > 		times[i] = time_in_mcs;
> > 	}
> > 
> > 	for (i = 0; i < ITERATIONS; i++)
> > 		sum += times[i];
> > 
> > 	printf("Mean time in microseconds (setns): %ju\n",
> > 	       sum / ITERATIONS);
> > 
> > 	fret = EXIT_SUCCESS;
> > 
> > on_error:
> > 	if (netns_fd >= 0)
> > 		close(netns_fd);
> > 
> > 	if (host_netns_fd >= 0)
> > 		close(host_netns_fd);
> > 
> > 	exit(fret);
> > }
> 
> But this is a synthetic test, while I asked about real workflow.
> Is this real problem for lxd, and there is observed performance
> decrease?

As you can see in this mail I explicitly stated that it is a real
performacne issue we see with LXD. You asked for numbers I gave you
numbers by writing a test-program just per your request. The benefit of
this "synthetic" case is that it allows us to clearly see the
performance benefit. Expecting me to hack all of this into LXD just to
get some perf numbers that will show the exact same thing per your
request is - and I hope I'm not being unreasonable here - expecting a
bit much.

> 
> I see, there are already nsid use in existing code, but I have to say,
> that adding new types of variables as a system call arguments make it
> less modular. When you request RTM_GETADDR for a specific nsid, this
> obligates the kernel to make everything unchangable during the call,
> doesn't it?
> 
> We may look at existing code as example, what problems this may cause.
> Look at do_setlink(). There are many different types of variables,
> and all of them should be dereferenced atomically. So, all the function
> is executed under global rtnl. And this causes delays in another config
> places, which are sensitive to rtnl. So, adding more dimensions to RTM_GETADDR
> may turn it in the same overloaded function as do_setlink() is. And one
> day, when we reach the state, when we must rework all of this, we won't
> be able to do this. I'm not sure, now is not too late.
> 
> I just say about this, because it's possible we should consider another
> approach in rtnl communication in general, and stop to overload it.

While I sympathize with your concerns this all seems very vague. There
is a real-world use case that is solved by this patchset.
