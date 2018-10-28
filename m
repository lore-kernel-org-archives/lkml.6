Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E416AECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B98020873
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 09:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B98020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeJ1Sgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 14:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:53506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbeJ1Sgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 14:36:53 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29009204FD;
        Sun, 28 Oct 2018 09:52:37 +0000 (UTC)
Date:   Sun, 28 Oct 2018 05:52:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        igor stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/17] prmem: llist, hlist, both plain and rcu
Message-ID: <20181028055233.08fd81b0@vmware.local.home>
In-Reply-To: <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
        <20181023213504.28905-15-igor.stoppa@huawei.com>
        <1634210774.446.1540381072927.JavaMail.zimbra@efficios.com>
        <243a8ff2-889c-089f-a1ff-c882933ca5c3@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018 17:03:01 +0300
Igor Stoppa <igor.stoppa@gmail.com> wrote:

> I was hoping that by CC-ing kernel.org, the explicit recipients would 
> get both the mail directly intended for them (as subsystem 
> maintainers/supporters) and the rest.
> 
> The next time I'll err in the opposite direction.

Please don't.

> 
> In the meanwhile, please find the whole set here:
> 
> https://www.openwall.com/lists/kernel-hardening/2018/10/23/3

Note, it is critical that every change log stands on its own. You do
not need to Cc the entire patch set to everyone. Each patch should have
enough information in it to know exactly what the patch does.

It's OK if each change log has duplicate information from other
patches. The important part is that one should be able to look at the
change log of a specific patch and understand exactly what the patch is
doing.

This is because 5 years from now, if someone does a git blame and comes
up with this commit, they wont have access to the patch series. All
they will have is this single commit log to explain why these changes
were done.

If a change log depends on other commits for context, it is
insufficient.

Thanks,

-- Steve
