Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753079AbeBEPvT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:51:19 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64234 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752767AbeBEPvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:51:13 -0500
Date: Mon, 5 Feb 2018 10:51:10 -0500 (EST)
From: Nicolas Pitre <nico@fluxnic.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        David Laight <David.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] xen: hypercall: fix out-of-bounds memcpy
In-Reply-To: <20180205150340.328921-1-arnd@arndb.de>
Message-ID: <nycvar.YSQ.7.76.1802051047031.1842@knanqh.ubzr>
References: <20180205150340.328921-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 63CA88AA-0A8C-11E8-B6D3-692D1A68708C-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Feb 2018, Arnd Bergmann wrote:

> +	if (cmd > ARRAY_SIZE(evtchnop_len))
> +		return -ENOSYS;
> +	len = evtchnop_len[cmd];

What if cmd == ARRAY_SIZE(evtchnop_len) ?


Nicolas
