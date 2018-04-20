Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755426AbeDTOqc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:46:32 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:41554 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755171AbeDTOq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:46:29 -0400
X-Google-Smtp-Source: AIpwx4+uUulfcBEVreq3xAvRnqS7wQw/y7ep57mnoCsvbkFT7s/obD7e8MRTSVBy9QMlvaZKK7icBw==
Date: Fri, 20 Apr 2018 16:46:25 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: David Lebrun <dav.lebrun@gmail.com>
Cc: davem@davemloft.net, dlebrun@google.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net] ipv6: sr: fix NULL pointer dereference in
 seg6_do_srh_encap()- v4 pkts
Message-Id: <20180420164625.b2d91c9f9738492eeaa8e3e7@gmail.com>
In-Reply-To: <3627f25a-0c47-6428-aa76-5baf96993a4c@gmail.com>
References: <1524232685-1203-1-git-send-email-amsalam20@gmail.com>
        <3627f25a-0c47-6428-aa76-5baf96993a4c@gmail.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2018 15:38:08 +0100
David Lebrun <dav.lebrun@gmail.com> wrote:

> On 04/20/2018 02:58 PM, Ahmed Abdelsalam wrote:
> > In case of seg6 in encap mode, seg6_do_srh_encap() calls set_tun_src()
> > in order to set the src addr of outer IPv6 header.
> > 
> > The net_device is required for set_tun_src(). However calling ip6_dst_idev()
> > on dst_entry in case of IPv4 traffic results on the following bug.
> > 
> > Using just dst->dev should fix this BUG.
> > 
> 
> Good catch, thanks for spotting this. If you actually tested your fix 
> with IPv4 and IPv6 traffic, you should mention it in the commit message. 
> Your current formulation suggests that you just guessed a fix without 
> testing.
> 

Yes, I did two tests for both IPv4 and IPv6.
Sorry for this Language Bug. 

> > 
> > Fixes: 8936ef7604c11 ipv6: sr: fix NULL pointer dereference when setting encap source address
> > Signed-off-by: Ahmed Abdelsalam<amsalam20@gmail.com>
> 
> Acked-by: David Lebrun <dlebrun@google.com>


-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
