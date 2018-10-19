Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261DEECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96DD2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTNm+93r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96DD2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbeJSQSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbeJSQSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:18:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 329C12064A;
        Fri, 19 Oct 2018 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539936820;
        bh=M0Nv6tRQvAOn7Hihd9TNgq8tGOenGSu+8sGly1voZIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTNm+93r2A7pdu00ZWDAXofkbRjhB1BhwUebDmZ+8j6OZHcHlp8mSACEMQDXweAg1
         DCk3J6/AYCxUZH+rqXIwWzs2Ctfmu1B8lC83LGd9e4L46cXCiUHQjghNCtO18lXOSC
         lmiSUyAXFcF+9P6Es+hgzUNhU3yog/KzmnPGTpoY=
Date:   Fri, 19 Oct 2018 10:13:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Miller <davem@davemloft.net>
Cc:     akpm@linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT] Networking
Message-ID: <20181019081338.GA21456@kroah.com>
References: <20181018.171914.1210096727703399564.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181018.171914.1210096727703399564.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 05:19:14PM -0700, David Miller wrote:
> 
> 1) Fix gro_cells leak in xfrm layer, from Li RongQing.
> 
> 2) BPF selftests change RLIMIT_MEMLOCK blindly, don't do that.
>    From Eric Dumazet.
> 
> 3) AF_XDP calls synchronize_net() under RCU lock, fix from Björn
>    Töpel.
> 
> 4) Out of bounds packet access in _decode_session6(), from Alexei
>    Starovoitov.
> 
> 5) Several ethtool bugs, where we copy a struct into the kernel
>    twice and our validations of the values in the first copy can
>    be invalidated by the second copy due to asynchronous updates
>    to the memory by the user.  From Wenwen Wang.
> 
> 6) Missing netlink attribute validation in cls_api, from Davide
>    Caratti.
> 
> 7) LLC SAP sockets neet to be SOCK_RCU FREE, from Cong Wang.
> 
> 8) rxrpc operates on wrong kvec, from Yue Haibing.
> 
> 9) A regression was introduced by the disassosciation of route
>    neighbour references in rt6_probe(), causing probe for
>    neighbourless routes to not be properly rate limited.  Fix
>    from Sabrina Dubroca.
> 
> 10) Unsafe RCU locking in tipc, from Tung Nguyen.
> 
> 11) Use after free in inet6_mc_check(), from Eric Dumazet.
> 
> 12) PMTU from icmp packets should update the SCTP transport
>     pathmtu, from Xin Long.
> 
> 13) Missing peer put on error in rxrpc, from David Howells.
> 
> 14) Fix pedit in nfp driver, from Pieter Jansen van Vuuren.
> 
> 15) Fix overflowing shift statement in qla3xxx driver, from Nathan
>     Chancellor.
> 
> 16) Fix Spectre v1 in ptp code, from Gustavo A. R. Silva.
> 
> 17) udp6_unicast_rcv_skb() interprets udpv6_queue_rcv_skb() return
>     value in an inverted manner, fix from Paolo Abeni.
> 
> 18) Fix missed unresolved entries in ipmr dumps, from Nikolay
>     Aleksandrov.
> 
> 19) Fix NAPI handling under high load, we can completely miss events
>     when NAPI has to loop more than one time in a cycle.  From Heiner
>     Kallweit.
> 
> Please pull, thanks a lot!
> 
> The following changes since commit bab5c80b211035739997ebd361a679fa85b39465:
> 
>   Merge tag 'armsoc-fixes-4.19' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2018-10-12 17:41:27 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 

Now merged, thanks.

greg k-h
