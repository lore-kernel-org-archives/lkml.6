Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934214AbeCGWXt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:23:49 -0500
Received: from mail-pl0-f48.google.com ([209.85.160.48]:40121 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbeCGWXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:23:48 -0500
X-Google-Smtp-Source: AG47ELv1l8robqghpZdT6LHi0HnN0pQ8XYYWMWOpyxNVBKgdyhlkLyyumrcA8/UGyq8mtoLdkPaQYw==
Date: Wed, 7 Mar 2018 14:23:43 -0800
From: Tyson Nottingham <tgnottingham@gmail.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: ext4 ignoring rootfs default mount options
Message-ID: <20180307222343.GA4353@L-66Y>
References: <20180306190315.puocf5bu3bfz6yct@csclub.uwaterloo.ca>
 <20180307040608.GA2462@thunk.org>
 <20180307151427.i6vbeq6kqo55cdgs@csclub.uwaterloo.ca>
 <20180307160856.GD7507@thunk.org>
 <20180307191324.qtloesy4zdlkfnwv@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307191324.qtloesy4zdlkfnwv@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 02:13:24PM -0500, Lennart Sorensen wrote:

> Trying to use tune2fs -E mount_opts to set some default options, and
> can't figure out how to enter two options at once.

Lennart,

I noticed this a while back, too. I don't believe you can currently. As a
workaround, you can use debugfs:

    debugfs -w -R 'set_super_value mount_opts opt1,opt2,opt3' <dev>

Note that when printing superblock info, the e2fsprogs tools call the bit-based
default mount options "Default mount options" and the string-based default mount
options "Mount options".

Tyson
