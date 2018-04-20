Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755409AbeDTOhv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:37:51 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:42671 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755339AbeDTOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:37:45 -0400
X-Google-Smtp-Source: AIpwx49NTXaFAjlM2HtI23I7/xpv+8JFYZWgUS9Xhf95p2g8g5X1ZJUMLj9qr3ORsNV9zDPhiSQvLQ==
Subject: Re: [PATCH] [net] ipv6: sr: fix NULL pointer dereference in
 seg6_do_srh_encap()- v4 pkts
To: Ahmed Abdelsalam <amsalam20@gmail.com>, davem@davemloft.net,
        dlebrun@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1524232685-1203-1-git-send-email-amsalam20@gmail.com>
From: David Lebrun <dav.lebrun@gmail.com>
Message-ID: <3627f25a-0c47-6428-aa76-5baf96993a4c@gmail.com>
Date: Fri, 20 Apr 2018 15:38:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1524232685-1203-1-git-send-email-amsalam20@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 02:58 PM, Ahmed Abdelsalam wrote:
> In case of seg6 in encap mode, seg6_do_srh_encap() calls set_tun_src()
> in order to set the src addr of outer IPv6 header.
> 
> The net_device is required for set_tun_src(). However calling ip6_dst_idev()
> on dst_entry in case of IPv4 traffic results on the following bug.
> 
> Using just dst->dev should fix this BUG.
> 

Good catch, thanks for spotting this. If you actually tested your fix 
with IPv4 and IPv6 traffic, you should mention it in the commit message. 
Your current formulation suggests that you just guessed a fix without 
testing.

> 
> Fixes: 8936ef7604c11 ipv6: sr: fix NULL pointer dereference when setting encap source address
> Signed-off-by: Ahmed Abdelsalam<amsalam20@gmail.com>

Acked-by: David Lebrun <dlebrun@google.com>
