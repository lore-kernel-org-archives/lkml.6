Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeCOQMC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 12:12:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54159 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeCOQMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 12:12:00 -0400
X-Google-Smtp-Source: AG47ELuoUhxQI3tQz02DHCNgvA6Yj2iRgrbKNYMsbDH4AHTSsTVXuXwXZLefiUy0V1tdknJL1MlpWA==
Date: Thu, 15 Mar 2018 18:11:47 +0200
From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To: Liran Alon <liran.alon@oracle.com>
Cc: <mrv@mojatatu.com>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
        <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <yuval.shaia@oracle.com>, <idan.brown@oracle.com>
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
Message-ID: <20180315181147.0f7c21e7@halley>
In-Reply-To: <58e67195-56f6-4d01-8747-f8322a382358@default>
References: <58e67195-56f6-4d01-8747-f8322a382358@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 08:01:03 -0700 (PDT) Liran Alon <liran.alon@oracle.com> wrote:
> 
> I still think that default behavior should be to zero skb->mark only when skb
> cross netdevs in different netns.

But the previous default was scrub the mark in *both* xnet and non-xnet
situations.

Therefore, there might be users which RELY on this (strange) default
behavior in their same-netns-veth-pair setups.
Meaning, changing the default behavior might break their apps relying on
the former default behavior.

This is why the "disable mark scrubbing in non-xnet case" should be opt-in.

Regards,
Shmulik
