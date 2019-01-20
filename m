Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A37C26641
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3901B20861
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 19:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfATT2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 14:28:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:58932 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfATT2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 14:28:02 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2D41A7DE;
        Sun, 20 Jan 2019 19:27:59 +0000 (UTC)
Date:   Sun, 20 Jan 2019 12:27:55 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tony Jones <tonyj@suse.de>
Cc:     Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf scripts python: Add Python 3 support to
 exported-sql-viewer.py
Message-ID: <20190120122755.1a8fe456@lwn.net>
In-Reply-To: <f086e4fb-0bbf-9e21-25e2-708b092f1636@suse.de>
References: <1547718344-27382-1-git-send-email-s1seetee@linux.vnet.ibm.com>
        <1547718344-27382-3-git-send-email-s1seetee@linux.vnet.ibm.com>
        <f086e4fb-0bbf-9e21-25e2-708b092f1636@suse.de>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2019 16:45:04 -0800
Tony Jones <tonyj@suse.de> wrote:

> On 1/17/19 1:45 AM, Seeteena Thoufeek wrote:
> 
> > +if sys.version_info[0] < 3:
> > +    import cPickle
> > +else:
> > +    import _pickle as cPickle  
> 
> Do you really need this?
> 
> pickle is already in Python2.

Did you mean in Python3?  I would agree that using it is better than
importing the semi-hidden _pickle module.

That said, I'll echo the questions about testing.  Pickle works in
Python3, but it is fraught with all kinds of bytes/str and encoding
issues; I've found it sufficiently fragile in practice that I really just
try to avoid it.  How have you verified that this script works under both
versions of Python?

Thanks,

jon
