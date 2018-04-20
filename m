Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeDTErC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 00:47:02 -0400
Received: from mout.gmx.net ([212.227.17.21]:37219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDTErB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 00:47:01 -0400
Message-ID: <1524199618.5757.3.camel@gmx.de>
Subject: Re: DOS by unprivileged user
From: Mike Galbraith <efault@gmx.de>
To: Ferry Toth <ftoth@telfort.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
Date: Fri, 20 Apr 2018 06:46:58 +0200
In-Reply-To: <9023506.UBh6vynRGa@delfion>
References: <9023506.UBh6vynRGa@delfion>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:utsrSNCO4kZceuDjcJSH3y27NmE04vr0sJ4axjlBHpn0WiZd6zj
 rJ3xeWrt3eOmF+uKQuRr86PydCZSOtVqGe+HmuyUU1SQ1UcT6ZH9t9Bfu5AMTWAueRc5jmd
 8yea4IPY1wxs2e8EK1QBk6A69pd77+mciVBDbmYY/gW561C9GGDsqC5my1NvfHHED6kSLz+
 HmbEMvX9zFeAmUEbZgt/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JkpoW/bT5Z8=:Djh/o8qCZUxOOVUj+3c6hV
 5NyiO6t4VnIHerqzuq01lNnc2HIoE7YqWpLoDOfxggTSU2s82DTfQH3iv9E2z66ouZNdL47e7
 4BUgADs4ffHj3j9Hm3yrE/aD9kmb8Z4CnTTrEQrnLuZEHFJnTKsxaS1MQrA55ps5wxAOo71S4
 uAiI76XCM4cXl2cS1zdsjBHgnIU7JIyML7t7hcN+EzbPoS8cwmciLTYqG9HKtD7jxG/niKSI3
 Iem2IZ9qvEMCT46dcttdpj20gl9HKX73cLqyh9lH/Cgq3OmZrjMziAq2M3J5fr5syvVnnpOq7
 u0UMc7wdlhGGaRaoA+MduQGrsBxa8YhOgRqhnz/9O2YNQL/dv4+By51FwZXsKkpBUF9NIDsUc
 8uZfQgIRRqe8hhjnge5EdacQZnzejAD0qYuHU8qVqZU/XY5lo6ceG2awzSwsNdG14ypy9tMv4
 KeMB3jup8fxcqKCXvfdjyULbJrhvUbd6LnxpGyt4JHGlecIRu26oLLCzJhWxnM6WtMaF7eb3P
 FKlt4NkVq4prEXCqI/hJLkMDOqNpFVqnccg6a4SXPNzbNbuL5py2wb4pJ5fWinBtILhmgDyLU
 w7y8siapK7ILY8+5F1EOSQlv9gpPagLsJfNt+rrVf1wvAXpnFnfbuMVq5vGm4ilv1vQuPRTop
 XkTsA8n3Ewf14LdYiY2qiNQlEkfB/olIaLfUYaFmVgtio3Qlw+LsO6zp9YOebWFUKOVEljHvy
 le4nK2exEjc9ftgNzpJ6ABQQyUai+xf3JqHZ2RpC2MZnyWPrKhrerdQB63IN/WdE+KcM4uTzy
 OcOhW2/vIAVIqF+Y07W5v2gpyZbnP7XmURH/0c0XuaA9VOm4Lw=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-19 at 21:13 +0200, Ferry Toth wrote:
> It appears any ordinary user can easily create a DOS on linux.
> 
> One sure way to reproduce this is to open gitk on the linux kernel repo 
> (SIC) on a machine with 8GB RAM 16 GB swap on a HDD with btrfs and quad core 
> + hyperthreading. But I will be easy enough to get the same effect with more 
> RAM, other fs etc.
> 
> In this case gitk allocates more and more memory (until my system freezes 
> 6.5GB of 7.5GB avaiable), the system starts swapping or writing to tmp files 
> (can't investigate as there is no time until it freezes) and the io wait 
> goes to 100% on all cores. At this point it is impossible to login from 
> remote and local keyboard and mouse are frozen. Hard reset is the only way 
> out at this point.

datapoint: my i4790/ext4 box running master.yesterday booted mem=8G
became highly unpleasant to use, but I retained control, and the all
cores going to 100% thing did not happen at any time.

I didn't try constraining on the gitk user, just turned it loose a few
times to see if it managed to render box effectively dead.  It failed
to kill my box, but (expectedly) did make it suck rocks.

	-Mike
