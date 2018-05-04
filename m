Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeEDRM6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:12:58 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35800 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeEDRM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:12:56 -0400
Date: Fri, 04 May 2018 13:12:54 -0400 (EDT)
Message-Id: <20180504.131254.1527992250615929790.davem@davemloft.net>
To: wang6495@umn.edu
Cc: kjlu@umn.edu, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: cls: fix a potential missing-check bug
From: David Miller <davem@davemloft.net>
In-Reply-To: <1525417505-19056-1-git-send-email-wang6495@umn.edu>
References: <1525417505-19056-1-git-send-email-wang6495@umn.edu>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wang6495@umn.edu>
Date: Fri,  4 May 2018 02:05:05 -0500

> Given that gen_tunnel() may return a value larger than 255 based on
> data, the new value of f->res.classid should be re-checked.

gen_tunnel() may not ever return a value larger than 255.

data->tgenerator is a u8 and therefore can never take on a value
outside of the range of 0 to 255.

I'm not applying this patch, sorry.
