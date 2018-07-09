Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC204C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BC620881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 19:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BC620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeGITUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 15:20:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754521AbeGITUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 15:20:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A1D3F7D84D;
        Mon,  9 Jul 2018 19:20:08 +0000 (UTC)
Received: from localhost (ovpn-200-25.brq.redhat.com [10.40.200.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FACD1C596;
        Mon,  9 Jul 2018 19:20:04 +0000 (UTC)
Date:   Mon, 9 Jul 2018 21:20:03 +0200
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, brouer@redhat.com
Subject: Re: [PATCH] samples/bpf: Fix tc and ip path in xdp2skb_meta.sh
Message-ID: <20180709212003.10b8e490@redhat.com>
In-Reply-To: <30be797e-e247-1b34-6607-0f0fd3b898fd@gmail.com>
References: <20180709150418.32034-1-treeze.taeung@gmail.com>
        <20180709174029.3c05e750@redhat.com>
        <30be797e-e247-1b34-6607-0f0fd3b898fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 09 Jul 2018 19:20:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 09 Jul 2018 19:20:08 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'brouer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 02:44:06 +0900
Taeung Song <treeze.taeung@gmail.com> wrote:

> Hi Jesper Dangaard Brouer,
> 
> On 07/10/2018 12:40 AM, Jesper Dangaard Brouer wrote:
> > On Tue, 10 Jul 2018 00:04:18 +0900
> > Taeung Song <treeze.taeung@gmail.com> wrote:
> >   
> >> The below path error can occur:
> >>
> >>    # ./xdp2skb_meta.sh --dev eth0 --list
> >>    ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory
> >>
> >>    # which tc
> >>    /sbin/tc
> >>
> >> So use 'which' command instead of absolute path of tc and ip
> >>
> >> Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
> >> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> >> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> >> ---
> >>   samples/bpf/xdp2skb_meta.sh | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/samples/bpf/xdp2skb_meta.sh b/samples/bpf/xdp2skb_meta.sh
> >> index b9c9549c4c27..67cf7b5f336d 100755
> >> --- a/samples/bpf/xdp2skb_meta.sh
> >> +++ b/samples/bpf/xdp2skb_meta.sh
> >> @@ -16,8 +16,8 @@
> >>   BPF_FILE=xdp2skb_meta_kern.o
> >>   DIR=$(dirname $0)
> >>   
> >> -export TC=/usr/sbin/tc
> >> -export IP=/usr/sbin/ip
> >> +export TC=`which tc`
> >> +export IP=`which ip`  
> > 
> > This is not a good solution, as 'which' can return something else.
> > E.g. on my system I've aliased 'tc' to 'sudo tc', and `which tc` returns:
> > 
> > $ which tc
> > alias tc='sudo tc'
> > 	/usr/bin/sudo
> > 
> > The easiest solution is to simply do:
> > 
> >   export TC=tc
> >   export IP=ip
> > 
> > The more fancy solution is to allow callers to redefine $IP and $TC:
> > 
> > [ -z "$TC" ] && TC=tc
> > [ -z "$IP" ] && IP=ip
> >   
> 
> Yep, you are right, I'll change it.
> 
> > And then you should also fix the use of 'basename', see below patch...
> >   
> 
> I thought it'd be fine to leave 'basename' as it is,
> because if callers redefine TC=/home/taeung/tc and give
> the options --verbose or --dry-run, 'basename' can more tidily show outputs.

The 'basename' does not work correctly if e.g. TC='sudo tc'.

Below output is with 'basename' removed, else it would say "sudo qdisc del ..."

TC='sudo tc' IP='sudo ip' ./xdp2skb_meta.sh -v --dev mlx5p1 --dry-run
# Device set to: DEV=mlx5p1
# Dry-run mode: enable VERBOSE and don't call TC+IP
sudo tc qdisc del dev mlx5p1 clsact
sudo tc qdisc add dev mlx5p1 clsact
sudo tc filter add dev mlx5p1 ingress prio 1 handle 1 bpf da obj ./xdp2skb_meta_kern.o sec tc_mark
# Flush XDP on device: mlx5p1
sudo ip link set dev mlx5p1 xdp off
sudo ip link set dev mlx5p1 xdp obj ./xdp2skb_meta_kern.o sec xdp_mark


> But it seems to be trivial, I'll resend this patch as v2 based on your 
> comment !

Thx, already ACKed it :-)

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
