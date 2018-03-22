Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753794AbeCVKUJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:20:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753688AbeCVKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:20:03 -0400
X-Google-Smtp-Source: AG47ELtDseMyjjSA50kxzP8P++a5gvXtolYV4lgN4sz2c0c4urPp4tgtb/wsTOThngCvIsa91cjqBg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/2] r8169: reinstate ALDPS for power saving
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <75F177BF-B016-402B-93B3-62D635F5F9D5@canonical.com>
Date: Thu, 22 Mar 2018 18:19:56 +0800
Cc: nic_swsd <nic_swsd@realtek.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        romieu@fr.zoreil.com, jrg.otte@gmail.com,
        David Miller <davem@davemloft.net>
Content-Transfer-Encoding: 7bit
Message-Id: <B39421A6-A863-414E-956F-0F185F09EB18@canonical.com>
References: <20171115090019.23972-1-kai.heng.feng@canonical.com>
 <20171115.195306.1005850318419905294.davem@davemloft.net>
 <75F177BF-B016-402B-93B3-62D635F5F9D5@canonical.com>
To: Hayes Wang <hayeswang@realtek.com>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Heng Feng <kai.heng.feng@canonical.com> wrote:

> Hopefully Hayes (or Realtek) can shed more lights on the issue. Apparently
> ALDPS and ASPM for r8169 is enabled in different commercial products, just
> not in Linux mainline.

Hayes and Realtek folks,

How do we make this patch going forward?
Do you find the root cause that make this patch got reverted?

I guess ALDPS is no longer needed after commit a92a08499b1f ("r8169:  
improve runtime pm in general and suspend unused ports"), now the device  
gets runtime suspended when link is down.

OTOH, ASPM is still quite useful though. When it's enabled, it can save 1W  
power usage, which is quite substantial for a laptop.

So, I'd like to hear your feedback and make ASPM for r8169 eventually gets  
upstreamed.

Kai-Heng
