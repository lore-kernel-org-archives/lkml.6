Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbeDCOAb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 10:00:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750777AbeDCOAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 10:00:30 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20180403132032.bseezddmd6rrka6g@ninjato>
References: <20180403132032.bseezddmd6rrka6g@ninjato> <20180326210929.5244-1-dave@stgolabs.net> <20180326210929.5244-2-dave@stgolabs.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dhowells@redhat.com, Davidlohr Bueso <dave@stgolabs.net>,
        peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/6] drivers/i2c: Update i2c_trace_msg static key to modern api
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13517.1522764027.1@warthog.procyon.org.uk>
Date: Tue, 03 Apr 2018 15:00:27 +0100
Message-ID: <13518.1522764027@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram Sang <wsa@the-dreams.de> wrote:

> > No changes in refcount semantics -- key init is false; replace
> > 
> > static_key_slow_inc|dec   with   static_branch_inc|dec
> > static_key_false          with   static_branch_unlikely
> > 
> > Added a '_key' suffix to i2c_trace_msg, for better self
> > documentation.
> > 
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-i2c@vger.kernel.org
> > Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Reviewed-by: David Howells <dhowells@redhat.com>
