Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB5FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2BA2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgYuf+2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBUDV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:21:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37250 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfBUDVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:21:25 -0500
Received: by mail-pl1-f194.google.com with SMTP id q3so6014306pll.4;
        Wed, 20 Feb 2019 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q4BZ7lHzuKacGUOZXiCQPP1CXjsIV568Au0UpTVVeAY=;
        b=CgYuf+2pCklcidtsW2H8YvG3RN7or/XzZrhUaN/qijLrGC8aobdKpbDbv13LW7as4x
         8zILZb+dsTrhDjl2R++FAKabL17mT2ox39b9+jxNRL+Pybj1zBBBBjHt+Nb7zBXU9l4C
         1xVqtqOT9JoRGmm3s2OKnp8pBQNM4pOUUBzL8V7c3HrI/qCiAuUUOzxVlcZF3xb+16yF
         cuEgYbBugwbPQhRAidI4MSvozhxUVpGLh57PYasuQmcMrhiDT5YkOQkS+km6723mTxHQ
         J5UDRSl9vlCpvMOhxyzIiBLWxnb5nFAEWfH7jQoQf5f4hGhRjhWU4WJ3f9KdaFjsI6nF
         WOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q4BZ7lHzuKacGUOZXiCQPP1CXjsIV568Au0UpTVVeAY=;
        b=Ye8fynGLg3sLHuO1NaZZ7rq7gLcZKQStNbkQ+m7EtemrCS6ItPsr6yE1xdXeYBH+nb
         sRiewR+aMdn+B54+aL39YFpyW9s58jVkYdIhl6rAxzgOpGK+LnM+FlSebPseGCCRSUj5
         BkfI6Z6CAPgYTkIYV3t+zaycF7owV3usEM+gtGDs09ZqxbX4kezQXeybBMYGyJ1IcyH8
         b7fhsmZmG/Meaq3h4+9zqxSRW+p6rBppEPn8KtFkuf2TS3TgBWOSeGc2P6i5qjumabfx
         Kynrk+CmdwV/A/MXC33irbSwBYPJV/i9NMLdliknyeyvn+IpR49Ii+b87oIQdsWVc/uI
         DFJQ==
X-Gm-Message-State: AHQUAuaGlB2MA6IQ4ThVm73/35QJuiUH2ymSGqooN8J/xT0JkXY0Ioyq
        MQj4qk8VBxIqWgKPP4Cwxd/YIyWu
X-Google-Smtp-Source: AHgI3IZS6d/8YPBXrDMI1qIao6nVCPkypulNcYJIg7TZiyyNYEqiazx9qIwvSksDR42mA0Kz8JkpNA==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr40535339plf.233.1550719284478;
        Wed, 20 Feb 2019 19:21:24 -0800 (PST)
Received: from [192.168.1.3] (ip68-228-73-187.oc.oc.cox.net. [68.228.73.187])
        by smtp.gmail.com with ESMTPSA id k71sm30969243pga.44.2019.02.20.19.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 19:21:23 -0800 (PST)
Subject: Re: [RFC PATCH net-next v3 00/21] ethtool netlink interface, part 1
To:     Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
References: <cover.1550513384.git.mkubecek@suse.cz>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 mQENBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAG0KEZsb3JpYW4gRmFpbmVsbGkgPGZhaW5lbGxpQGJyb2FkY29tLmNvbT6JAccEEAECALEF
 AlPAG9YXCgABv0jL/n0t8VEFmtDa8j7qERo7AN0gFAAAAAAAFgABa2V5LXVzYWdlLW1hc2tA
 cGdwLmNvbY4wFIAAAAAAIAAHcHJlZmVycmVkLWVtYWlsLWVuY29kaW5nQHBncC5jb21wZ3Bt
 aW1lCAsJCAcDAgEKAhkBBReAAAAAGRhsZGFwOi8va2V5cy5icm9hZGNvbS5jb20FGwMAAAAD
 FgIBBR4BAAAABBUICQoACgkQgTG1xCm8ZqD+Dgf9HhhzqvJYIPomNeg+ll7/TbzWb871E+HQ
 TaufJQFQwLEbgdFSZO2uj4UqfDpCyTwtHTVMJogWt3pCAE1sadeIY8OlT6918ofKIl8AiHj2
 BlfL7ASZ5wzkRMt/4TZoinq9O1tPEynb5G6PdZTV3UQtmSGnpt2EOu7KtRJsnThBiXoOO9TJ
 Asg4vXJ0ZM1y/MPhQlZbPCHQZFe1gaVWBPLGnLyWyeprqgSLWHaGqrUhlfK1sLuJK1bjYDCI
 NetK0pS4cA4ZJgogr5FrtV64R19zLl02mt/Yj7rAmjC3ZBuwVi3V35kD8Kd4d9QM2apsiILV
 bzGbtVCSUgvxI+1SsJEm3bkBDQRTwBvBAQgArGvvWip77T4xgJztZp9YRylAcVTC9gtx0Gg6
 eYk/EPANGm9TkuGpI++T/Il2H2TjFQNC7eubWohbYj0+6Tmf8nP+VmyobDxPXcMrK7x4xy9o
 D+Kub2Vf0SXbsM8fL/SqzGbFWZSm73L1L4GZoxvYIz0i7LExYSX2u5YVLaMBaH9HwKt2cvr7
 MuTrRHtcbOZImoXT29g2UnoF1uwxYNeRhZY/lRvVkkY0lDipPuDwg3SpfHMtCybPq1uAswQd
 gEbHzRsEXwCR1OF3pIuGt4I3tSEhH/k1caqi0BlqjbGUOkku44xC2gf1ZU267FBBkdV3yJ/7
 KnrJEnkMCYhS3kII9wARAQABiQJBBBgBAgErBQJTwBvCBRsMAAAAwF0gBBkBCAAGBQJTwBvB
 AAoJEJNgBqiYLw9VDRUIAJaTef6hsUAESnlGDpC+ymL2RZdzAJx9lXjU4hhaFcyhznuyyMJq
 d3mehmLxsqDRvHDiqyD71w2Bnc838MVZw0pwBPdnb/h9Ocmp0lL/9hwSGWvy4az5lYVyoA9u
 14UIzh0YNGu6jr0isd/LJAbHXqwJwWWs3y8PTrpEp68V6lv+aXt5gR03lJEAvIR1Awp4JJ/e
 Z5y12gQISp0X8xal9YhhDWER92YLYrO2b6Hc2S31lAupzfCw8lmZsP1PRz1GmF/KmDD9J9N/
 b8IehhWQqrBQjMjn2K2XkvN75HnAMHKFYfHZR3ZHtK52ZP1crV7THtbtrnPXVDq+vO4QPmdC
 +SEACgkQgTG1xCm8ZqC6BwgAl3kRh7oozpjpG8jpO8en5CBtTl3G+OpKJK9qbQyzdCsuJ0K1
 qe1wZPZbP/Y+VtmqSgnExBzjStt9drjFBK8liPQZalp2sMlS9S7csSy6cMLF1auZubAZEqpm
 tpXagbtgR12YOo57Reb83F5KhtwwiWdoTpXRTx/nM0cHtjjrImONhP8OzVMmjem/B68NY++/
 qt0F5XTsP2zjd+tRLrFh3W4XEcLt1lhYmNmbJR/l6+vVbWAKDAtcbQ8SL2feqbPWV6VDyVKh
 ya/EEq0xtf84qEB+4/+IjCdOzDD3kDZJo+JBkDnU3LBXw4WCw3QhOXY+VnhOn2EcREN7qdAK
 w0j9Sw==
Message-ID: <1cef1440-7345-a9a0-eab8-ab1c79c0d075@gmail.com>
Date:   Wed, 20 Feb 2019 19:21:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Let me start with a big thank you for tackling this humongous amount of
work!

On 2/18/2019 10:21 AM, Michal Kubecek wrote:
> Note: this is marked as RFC because it's rather late in the cycle; the plan
> is to make a regular submission (with changes based on review) once
> net-next reopens after the 5.1 merge window. The full (work in progress)
> series, together with the (userspace) ethtool counterpart can be found at
> https://github.com/mkubecek/ethnl
> 
> This is first part of alternative userspace interface for ethtool. The aim
> is to address some long known issues with the ioctl interface, mainly lack
> of extensibility, raciness, limited error reporting and absence of
> notifications.
> 
> The interface uses generic netlink family "ethtool"; it provides multicast
> group "monitor" which is used for notifications. Documentation for the
> interface is in Documentation/networking/ethtool-netlink.txt
> 
> Basic concepts:
> 
> - the goal is to provide all features of ioctl interface but allow
>   easier future extensions; at some point, it should be possible to have
>   full ethtool functionality without using the ioctl interface

+1

> - inextensibility of ioctl interface resulted in way too many commands,
>   many of them obsoleted by newer ones; reduce the number by  ignoring the
>   obsolete commands and grouping some together
> - for "set" type commands, allows passing only the attributes to be
>   changed; therefore we don't need a get-modify-set cycle (which is
>   inherently racy), userspace can simply say what it wants to change
> - provide notifications to multicast group "monitor" like rtnetlink does,
>   i.e. in the form of messages close to replies to "get" requests

+1

> - allow dump requests to get some information about all network devices
>   providing it

And it seems like you have also added some filtering capability with at
least the settings dump, right? That is also highly welcome.

> - be less dependent on ethtool and kernel being in sync; allow e.g. saying
>   "ethtool -s eth0 advertise foo off" without ethtool knowing what "foo"
>   means; it's kernel's job to know what mode "xyz" is and if it exists and
>   is supported
> 
> Main changes between RFC v2 and RFC v3:
> 
> - do not allow building as a module (no netdev notifiers needed)

I would very much prefer that we could build this as a module. Some
systems might be memory constrained or opt to disable ethtool entirely
(security?). If this is not too much trouble, can we try to maintain that?

> - drop some obsolete fields
> - add permanent hw address, timestamping and private flags support
> - rework bitset handling to get rid of variable length arrays
> - notify monitor on device renames
> - restructure GET_SETTINGS/SET_SETTINGS messages
> - split too long patches and submit only first part of the series
> 
> Main changes between RFC v1 and RFC v2:
> 
> - support dumps for all "get" requests
> - provide notifications for changes related to supported request types
> - support getting string sets (both global and per device)
> - support getting/setting device features
> - get rid of family specific header, everything passed as attributes
> - split netlink code into multiple files in net/ethtool/ directory
> 
> ToDo / open questions:
> 
> - some features provided by ethtool would rather belong to devlink (and
>   some are already superseded by devlink); however, only few drivers
>   provide devlink interface at the moment and as recent discussion on
>   flashing revealed, we cannot rely on devlink's presence

Should we just move everything under devlink given that ethtool over
netlink or devlink are essentially manipulating the same (or close to)
objects? It seems to me that at least now is the right time to make
decisions about what should stay in ethtool and be offered via netlink,
what should be migrated to something else (e.g.: Jiri mentioned
rtnetlink), and what is a devlink candidate.

How do we proceed to easily triage which of these netlink facilities
should things be routed to/from?

> 
> - while the netlink interface allows easy future extensions, ethtool_ops
>   interface does not; some settings could be implemented using tunables and
>   accessed via relevant netlink messages (as well as tunables) from
>   userspace but in the long term, something better will be needed

Right, so as a driver writer, one thing I kind of hate is having to fill
a netlink skb myself because that's a lot of work, and it makes it
fairly hard to do mass conversion of internal APIs due to the increased
complexity in auditing what drivers do.

> 
> - currently, all communication with drivers via ethtool_ops is done
>   under RTNL as this is what ioctl interface does and likely many
>   ethtool_ops handlers rely on that; if we are going to rework ethtool_ops
>   in the future ("phase two"), it would be nice to get rid of it
> 
> - ethtool_ops should pass extack pointer to allow drivers more meaningful
>   error reporting; it's not clear, however, how to pass information about
>   offending attribute
> 
> - notifications are sent whenever a change is done via netlink API or
>   ioctl API and for netdev features also whenever they are updated using
>   netdev_change_features(); it would be desirable to notify also about
>   link state and negotiation result (speed/duplex and partner link
>   modes) but it would be more tricky

Historically you listen for a link event and you determine the link
parameters from there, I don't know if there is much value in giving the
full link parameter list, especially given those could theoretically
change depending on your medium (e.g.: wireless), or there could be a
lot to query at that time...

> 
> Michal Kubecek (21):
>   netlink: introduce nla_put_bitfield32()
>   ethtool: move to its own directory
>   ethtool: introduce ethtool netlink interface
>   ethtool: helper functions for netlink interface
>   ethtool: netlink bitset handling
>   ethtool: support for netlink notifications
>   ethtool: implement EVENT notifications
>   ethtool: generic handlers for GET requests
>   ethtool: move string arrays into common file
>   ethtool: provide string sets with GET_STRSET request
>   ethtool: provide driver/device information in GET_INFO request
>   ethtool: provide permanent hardware address in GET_INFO request
>   ethtool: provide timestamping information in GET_INFO request
>   ethtool: provide link mode names as a string set
>   ethtool: provide link settings and link modes in GET_SETTINGS request
>   ethtool: provide WoL information in GET_SETTINGS request
>   ethtool: provide message level in GET_SETTINGS request
>   ethtool: provide link state in GET_SETTINGS request
>   ethtool: provide device features in GET_SETTINGS request
>   ethtool: provide private flags in GET_SETTINGS request
>   ethtool: send netlink notifications about setting changes
> 
>  Documentation/networking/ethtool-netlink.txt | 441 +++++++++++++
>  include/linux/ethtool_netlink.h              |  17 +
>  include/linux/netdevice.h                    |  14 +
>  include/net/netlink.h                        |  15 +
>  include/uapi/linux/ethtool.h                 |  10 +
>  include/uapi/linux/ethtool_netlink.h         | 265 ++++++++
>  include/uapi/linux/net_tstamp.h              |  13 +
>  net/Kconfig                                  |   8 +
>  net/Makefile                                 |   2 +-
>  net/core/Makefile                            |   2 +-
>  net/ethtool/Makefile                         |   7 +
>  net/ethtool/bitset.c                         | 572 +++++++++++++++++
>  net/ethtool/bitset.h                         |  40 ++
>  net/ethtool/common.c                         | 227 +++++++
>  net/ethtool/common.h                         |  29 +
>  net/ethtool/info.c                           | 332 ++++++++++
>  net/{core/ethtool.c => ethtool/ioctl.c}      | 244 ++-----
>  net/ethtool/netlink.c                        | 634 +++++++++++++++++++
>  net/ethtool/netlink.h                        | 252 ++++++++
>  net/ethtool/settings.c                       | 559 ++++++++++++++++
>  net/ethtool/strset.c                         | 461 ++++++++++++++
>  21 files changed, 3937 insertions(+), 207 deletions(-)
>  create mode 100644 Documentation/networking/ethtool-netlink.txt
>  create mode 100644 include/linux/ethtool_netlink.h
>  create mode 100644 include/uapi/linux/ethtool_netlink.h
>  create mode 100644 net/ethtool/Makefile
>  create mode 100644 net/ethtool/bitset.c
>  create mode 100644 net/ethtool/bitset.h
>  create mode 100644 net/ethtool/common.c
>  create mode 100644 net/ethtool/common.h
>  create mode 100644 net/ethtool/info.c
>  rename net/{core/ethtool.c => ethtool/ioctl.c} (91%)
>  create mode 100644 net/ethtool/netlink.c
>  create mode 100644 net/ethtool/netlink.h
>  create mode 100644 net/ethtool/settings.c
>  create mode 100644 net/ethtool/strset.c
> 

-- 
Florian
