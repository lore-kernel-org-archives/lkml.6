Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65BAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF4C21773
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="D+mHtAkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfBSKoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:44:46 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52342 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:44:46 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so2021662wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rtDgF/4pO6bgn4+W400+2ihpz/KXZL91ULnd1KBI6iI=;
        b=D+mHtAkWeWimOwZaeIKQGtldp21MpfENNpNI+syyktxqV7y7HRC9Kv5yfghZS9SHFh
         3/deYtRPeSxDAN6Zij2Up5zyfG74eHM4FFW9QWXQIof3uf3G3IOhmr8Zq1fjL3aZSQKW
         90eaAEI1os4HcXqtGCkxwCcEcFm13orXOhfuiRXkX5Z+xITYRLTQ2p9uEtX0vlqouf+E
         NnhRKBP8J67UcMyta8uFpgwtmMqLw2uC+/VeGNm45Jr4RbjY4SoXRepMtlNiyHxCpSYF
         xRfD+AWNfRkEhWj9caUo2oTSUm629EqzzF31nljeYFi9psz8d5qwEYXEO/ybW2iVl0QO
         TOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rtDgF/4pO6bgn4+W400+2ihpz/KXZL91ULnd1KBI6iI=;
        b=ptVkKOLg3uk9pem/ExZotBRRIf+HflVVtb2OUgV8xIIKPezjAE/tJfhBlpW/um9I9c
         LCTbQ0TR/Ft0apXoNtd0a3RAAvTgHeLVER1rz9iSISN9hCFFN2DDJJrJ++AKkZbeKAKr
         BHwhHVi3xGhELji002pFvAfvyxB3kjHvOQowIOu/13pRZTIksbmH8zzRovbrYSKkHz8k
         0hbibXsuMGujM6/nTvPSDWr5z53YWAyHLugz/KF5uT/4ZD4x7fk7IAoRQf6nVv4RC8zb
         lXrF/6zS/hW4qyNunaw9JGLI+5vMvWXjYz53DRk4rzdfcVNm+TnnTPaxgBNXybTbkVFk
         C7wg==
X-Gm-Message-State: AHQUAuYd86+zOrTWJzX0Hy4/8mFqtXEHg8hOJRJKYj+HPI/u8qNMT8Li
        +q42JmNU1xHlnA0mdYJsYIyRNw==
X-Google-Smtp-Source: AHgI3IYpofnaIkuT9OQwZoSwGQQTktKiEgTSQXQkqbJAYw8WL4/jZ3MLsJDJqZW5lExfrL2TBDB0Xw==
X-Received: by 2002:a1c:cf41:: with SMTP id f62mr2466834wmg.1.1550573083524;
        Tue, 19 Feb 2019 02:44:43 -0800 (PST)
Received: from localhost (ip-213-220-234-21.net.upcbroadband.cz. [213.220.234.21])
        by smtp.gmail.com with ESMTPSA id h17sm1251297wmb.29.2019.02.19.02.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 02:44:43 -0800 (PST)
Date:   Tue, 19 Feb 2019 11:35:08 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 00/21] ethtool netlink interface, part 1
Message-ID: <20190219103508.GD3080@nanopsycho>
References: <cover.1550513384.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 18, 2019 at 07:21:24PM CET, mkubecek@suse.cz wrote:
>Note: this is marked as RFC because it's rather late in the cycle; the plan
>is to make a regular submission (with changes based on review) once
>net-next reopens after the 5.1 merge window. The full (work in progress)
>series, together with the (userspace) ethtool counterpart can be found at
>https://github.com/mkubecek/ethnl
>
>This is first part of alternative userspace interface for ethtool. The aim
>is to address some long known issues with the ioctl interface, mainly lack
>of extensibility, raciness, limited error reporting and absence of
>notifications.
>
>The interface uses generic netlink family "ethtool"; it provides multicast
>group "monitor" which is used for notifications. Documentation for the
>interface is in Documentation/networking/ethtool-netlink.txt
>
>Basic concepts:
>
>- the goal is to provide all features of ioctl interface but allow
>  easier future extensions; at some point, it should be possible to have
>  full ethtool functionality without using the ioctl interface

I'm not sure it is a good idea to map the existing iface to netlink
fully. There are things in ethtool which are not really unique for
Ethernet. Those things should be put somewhere else.


>- inextensibility of ioctl interface resulted in way too many commands,
>  many of them obsoleted by newer ones; reduce the number by  ignoring the
>  obsolete commands and grouping some together
>- for "set" type commands, allows passing only the attributes to be
>  changed; therefore we don't need a get-modify-set cycle (which is
>  inherently racy), userspace can simply say what it wants to change
>- provide notifications to multicast group "monitor" like rtnetlink does,
>  i.e. in the form of messages close to replies to "get" requests
>- allow dump requests to get some information about all network devices
>  providing it
>- be less dependent on ethtool and kernel being in sync; allow e.g. saying
>  "ethtool -s eth0 advertise foo off" without ethtool knowing what "foo"
>  means; it's kernel's job to know what mode "xyz" is and if it exists and
>  is supported
>
>Main changes between RFC v2 and RFC v3:
>
>- do not allow building as a module (no netdev notifiers needed)
>- drop some obsolete fields
>- add permanent hw address, timestamping and private flags support
>- rework bitset handling to get rid of variable length arrays
>- notify monitor on device renames
>- restructure GET_SETTINGS/SET_SETTINGS messages
>- split too long patches and submit only first part of the series
>
>Main changes between RFC v1 and RFC v2:
>
>- support dumps for all "get" requests
>- provide notifications for changes related to supported request types
>- support getting string sets (both global and per device)
>- support getting/setting device features
>- get rid of family specific header, everything passed as attributes
>- split netlink code into multiple files in net/ethtool/ directory
>
>ToDo / open questions:
>
>- some features provided by ethtool would rather belong to devlink (and
>  some are already superseded by devlink); however, only few drivers
>  provide devlink interface at the moment and as recent discussion on
>  flashing revealed, we cannot rely on devlink's presence

Could you explain why please?


>
>- while the netlink interface allows easy future extensions, ethtool_ops
>  interface does not; some settings could be implemented using tunables and
>  accessed via relevant netlink messages (as well as tunables) from
>  userspace but in the long term, something better will be needed
>
>- currently, all communication with drivers via ethtool_ops is done
>  under RTNL as this is what ioctl interface does and likely many
>  ethtool_ops handlers rely on that; if we are going to rework ethtool_ops
>  in the future ("phase two"), it would be nice to get rid of it
>
>- ethtool_ops should pass extack pointer to allow drivers more meaningful
>  error reporting; it's not clear, however, how to pass information about
>  offending attribute
>
>- notifications are sent whenever a change is done via netlink API or
>  ioctl API and for netdev features also whenever they are updated using
>  netdev_change_features(); it would be desirable to notify also about
>  link state and negotiation result (speed/duplex and partner link
>  modes) but it would be more tricky
>
>Michal Kubecek (21):
>  netlink: introduce nla_put_bitfield32()
>  ethtool: move to its own directory
>  ethtool: introduce ethtool netlink interface
>  ethtool: helper functions for netlink interface
>  ethtool: netlink bitset handling
>  ethtool: support for netlink notifications
>  ethtool: implement EVENT notifications
>  ethtool: generic handlers for GET requests
>  ethtool: move string arrays into common file
>  ethtool: provide string sets with GET_STRSET request
>  ethtool: provide driver/device information in GET_INFO request
>  ethtool: provide permanent hardware address in GET_INFO request
>  ethtool: provide timestamping information in GET_INFO request
>  ethtool: provide link mode names as a string set
>  ethtool: provide link settings and link modes in GET_SETTINGS request
>  ethtool: provide WoL information in GET_SETTINGS request
>  ethtool: provide message level in GET_SETTINGS request
>  ethtool: provide link state in GET_SETTINGS request
>  ethtool: provide device features in GET_SETTINGS request
>  ethtool: provide private flags in GET_SETTINGS request
>  ethtool: send netlink notifications about setting changes
>
> Documentation/networking/ethtool-netlink.txt | 441 +++++++++++++
> include/linux/ethtool_netlink.h              |  17 +
> include/linux/netdevice.h                    |  14 +
> include/net/netlink.h                        |  15 +
> include/uapi/linux/ethtool.h                 |  10 +
> include/uapi/linux/ethtool_netlink.h         | 265 ++++++++
> include/uapi/linux/net_tstamp.h              |  13 +
> net/Kconfig                                  |   8 +
> net/Makefile                                 |   2 +-
> net/core/Makefile                            |   2 +-
> net/ethtool/Makefile                         |   7 +
> net/ethtool/bitset.c                         | 572 +++++++++++++++++
> net/ethtool/bitset.h                         |  40 ++
> net/ethtool/common.c                         | 227 +++++++
> net/ethtool/common.h                         |  29 +
> net/ethtool/info.c                           | 332 ++++++++++
> net/{core/ethtool.c => ethtool/ioctl.c}      | 244 ++-----
> net/ethtool/netlink.c                        | 634 +++++++++++++++++++
> net/ethtool/netlink.h                        | 252 ++++++++
> net/ethtool/settings.c                       | 559 ++++++++++++++++
> net/ethtool/strset.c                         | 461 ++++++++++++++
> 21 files changed, 3937 insertions(+), 207 deletions(-)
> create mode 100644 Documentation/networking/ethtool-netlink.txt
> create mode 100644 include/linux/ethtool_netlink.h
> create mode 100644 include/uapi/linux/ethtool_netlink.h
> create mode 100644 net/ethtool/Makefile
> create mode 100644 net/ethtool/bitset.c
> create mode 100644 net/ethtool/bitset.h
> create mode 100644 net/ethtool/common.c
> create mode 100644 net/ethtool/common.h
> create mode 100644 net/ethtool/info.c
> rename net/{core/ethtool.c => ethtool/ioctl.c} (91%)
> create mode 100644 net/ethtool/netlink.c
> create mode 100644 net/ethtool/netlink.h
> create mode 100644 net/ethtool/settings.c
> create mode 100644 net/ethtool/strset.c
>
>-- 
>2.20.1
>
