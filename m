Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752530AbeCOQvQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:51:16 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:44911 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCOQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:51:13 -0400
X-Google-Smtp-Source: AG47ELsTDTDZgcVBW566KSTnqZnLXC3Q6b+/O7rQwCFg8gAsuorZVLRDXGfr7e77LV+kDBsNCdU+Ow==
Date: Thu, 15 Mar 2018 18:50:59 +0200
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To: Liran Alon <liran.alon@oracle.com>
Cc: <netdev@vger.kernel.org>, <daniel@iogearbox.net>, <mrv@mojatatu.com>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <yuval.shaia@oracle.com>, <idan.brown@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
Message-ID: <20180315185059.1f780722@halley>
In-Reply-To: <e653a52e-6a7d-49c9-aec6-6bc6437819c6@default>
References: <e653a52e-6a7d-49c9-aec6-6bc6437819c6@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 09:35:51 -0700 (PDT) Liran Alon <liran.alon@oracle.com> wrote:
> ----- shmulik.ladkani@gmail.com wrote:
> 
> > On Thu, 15 Mar 2018 08:01:03 -0700 (PDT) Liran Alon
> > <liran.alon@oracle.com> wrote:  
> > > 
> > > I still think that default behavior should be to zero skb->mark only  
> > when skb  
> > > cross netdevs in different netns.  
> > 
> > But the previous default was scrub the mark in *both* xnet and
> > non-xnet
> > situations.
> > 
> > Therefore, there might be users which RELY on this (strange) default
> > behavior in their same-netns-veth-pair setups.
> > Meaning, changing the default behavior might break their apps relying
> > on
> > the former default behavior.
> > 
> > This is why the "disable mark scrubbing in non-xnet case" should be
> > opt-in.  
> 
> We think the same.
> The only difference is that I think this for now should be controllable
> by a global /proc/sys/net/core file instead of giving a flexible per-netdev
> control.
> Because that is a larger change that could be done later.

A flags attribute to veth newlink is a very scoped change.
User controls this per veth creation.
This is way more neat than /proc/sys/net and provides the desired granular
control.

Also, scoping this to veth has the advantage of not affecting the many other
dev_forward_skb callers.

Regards,
Shmulik
