Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8152DC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D4E20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D4E20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbeIBOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:14:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36170 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbeIBOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:14:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A43D2636E;
        Sun,  2 Sep 2018 09:58:59 +0000 (UTC)
Received: from localhost (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F4E610EE822;
        Sun,  2 Sep 2018 09:58:53 +0000 (UTC)
Date:   Sun, 2 Sep 2018 11:58:51 +0200
From:   Jiri Benc <jbenc@redhat.com>
To:     Christian Brauner <christian.brauner@canonical.com>
Cc:     David Miller <davem@davemloft.net>, nicolas.dichtel@6wind.com,
        ktkhai@virtuozzo.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, pombredanne@nexb.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        dsahern@gmail.com, fw@strlen.de, lucien.xin@gmail.com,
        jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next 0/5] rtnetlink: add IFA_IF_NETNSID for
 RTM_GETADDR
Message-ID: <20180902115851.2b224c23@redhat.com>
In-Reply-To: <20180901184704.lzynbw5zkyiqc6wb@gmail.com>
References: <81379a4f-7149-10ff-2453-886314d0b0c4@virtuozzo.com>
        <20180830144544.tpross4jd6awou4u@gmail.com>
        <ba6a1b18-959e-e307-45fa-e0da9d6f0b0f@6wind.com>
        <20180831.175847.339882322459287210.davem@davemloft.net>
        <20180901184704.lzynbw5zkyiqc6wb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 02 Sep 2018 09:58:59 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 02 Sep 2018 09:58:59 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jbenc@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2018 20:47:05 +0200, Christian Brauner wrote:
> Sorry for the late reply. Yup, sounds good to me.
> But maybe IFA_TARGET_NETNSID to indicate that we're talking network
> namespaces here? Seems to me that NSID might give the wrong impression.
> I'll send v1 soon. I expect tomorrow or sometime next week.

On the other hand, we currently have IFLA_IF_NETNSID for the link
operations. IFA_IF_NETNSID is more consistent with the existing
attribute. It may be confusing to authors of user space programs to
have attribute names doing the same thing constructed differently for
different calls (IFLA_IF_NETNSID and IFA_TARGET_NETNSID).

As for the patch set itself, it makes sense to me, whatever the
final attribute name is.

Thanks,

 Jiri
