Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752920AbeDHQvR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:51:17 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51884 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752137AbeDHQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:51:15 -0400
Date: Sun, 08 Apr 2018 12:51:14 -0400 (EDT)
Message-Id: <20180408.125114.2111042327285982582.davem@davemloft.net>
To: march511@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make net_gso_ok return false when gso_type is
 zero(invalid)
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180406014340.1562-1-march511@gmail.com>
References: <20180406014340.1562-1-march511@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenhua Shi <march511@gmail.com>
Date: Fri,  6 Apr 2018 03:43:39 +0200

> Signed-off-by: Wenhua Shi <march511@gmail.com>

This precondition should be made impossible instead of having to do
an extra check everywhere that this helper is invoked, many of which
are in fast paths.
