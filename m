Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeDKNj3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:39:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751546AbeDKNj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:39:28 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180411132613.18974-1-colin.king@canonical.com>
References: <20180411132613.18974-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] afs: fix integer overflow when shifting 1 more than 32 places
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23534.1523453966.1@warthog.procyon.org.uk>
Date: Wed, 11 Apr 2018 14:39:26 +0100
Message-ID: <23535.1523453966@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Shifting 1 (a 32 bit signed int) more than 32 places will overflow
> the int, so explicitly use 1ULL to avoid this overflow.
> ...
> -	mask = (1 << nr_slots) - 1;
> +	mask = (1ULL << nr_slots) - 1;

nr_slots cannot be larger than 9, so what I wrote is actually fine and is more
efficient on a 32-bit machine.

David
