Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbeETDDB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 23:03:01 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:37524 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752459AbeETDC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 23:02:59 -0400
Date: Sat, 19 May 2018 23:02:58 -0400 (EDT)
Message-Id: <20180519.230258.1374885458106197707.davem@davemloft.net>
To: vladbu@mellanox.com
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org, jhs@mojatatu.com,
        jiri@resnulli.us, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: don't disable bh when accessing action idr
From: David Miller <davem@davemloft.net>
In-Reply-To: <vbflgcgnece.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
References: <1526658324-6570-1-git-send-email-vladbu@mellanox.com>
        <CAM_iQpUKjFPKAONSW42_6Mdp-VTTvaOx-GPDH2bJqW7LW1QYBw@mail.gmail.com>
        <vbflgcgnece.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vlad Buslov <vladbu@mellanox.com>
Date: Sat, 19 May 2018 13:12:49 +0300

> 
> On Sat 19 May 2018 at 02:59, Cong Wang <xiyou.wangcong@gmail.com> wrote:
>> On Fri, May 18, 2018 at 8:45 AM, Vlad Buslov <vladbu@mellanox.com> wrote:
>>> Underlying implementation of action map has changed and doesn't require
>>> disabling bh anymore. Replace all action idr spinlock usage with regular
>>> calls that do not disable bh.
>>
>> Please explain explicitly why it is not required, don't let people
>> dig, this would save everyone's time.
> 
> Underlying implementation of actions lookup has changed from hashtable
> to idr. Every current action implementation just calls act_api lookup
> function instead of implementing its own lookup. I asked author of idr
> change if there is a reason to continue to use _bh versions and he
> replied that he just left them as-is.

A detailed analysis of the locking requirements both before and
after the IDR changes needs to be in you commit message.

Nobody who reads this from scratch understands all of this background
material, so how can anyone reading your patch review it properly and
understand it?
