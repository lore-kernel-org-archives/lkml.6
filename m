Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeEHDaj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 23:30:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51916 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeEHDah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 23:30:37 -0400
Date: Mon, 07 May 2018 23:30:35 -0400 (EDT)
Message-Id: <20180507.233035.1288287836007018606.davem@davemloft.net>
To: mdf@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        alex.williams@ni.com
Subject: Re: [PATCH 2/2] net: nixge: Address compiler warnings about
 signedness
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504171834.9365-2-mdf@kernel.org>
References: <20180504171834.9365-1-mdf@kernel.org>
        <20180504171834.9365-2-mdf@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w483UiZv010648

From: Moritz Fischer <mdf@kernel.org>
Date: Fri,  4 May 2018 10:18:34 -0700

> Fixes the following warnings:
> warning: pointer targets in passing argument 1 of
> ¡is_valid_ether_addr¢ differ in signedness [-Wpointer-sign]
>   if (mac_addr && is_valid_ether_addr(mac_addr)) {
>                                       ^~~~~~~~
> expected ¡const u8 * {aka const unsigned char *}¢ but argument
> is of type ¡const char *¢
>  static inline bool is_valid_ether_addr(const u8 *addr)
>                     ^~~~~~~~~~~~~~~~~~~
> warning: pointer targets in passing argument 2 of
> ¡ether_addr_copy¢ differ in signedness [-Wpointer-sign]
>    ether_addr_copy(ndev->dev_addr, mac_addr);
>                                    ^~~~~~~~
> expected ¡const u8 * {aka const unsigned char *}¢ but argument
> is of type ¡const char *¢
>  static inline void ether_addr_copy(u8 *dst, const u8 *src)
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

Applied.
