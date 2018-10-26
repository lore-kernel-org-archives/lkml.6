Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFDECDE4B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093AB2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 10:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dw2YelZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093AB2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJZS4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:56:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeJZS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X5L8N2hL9OFDSaFKVaP49nuxxCgolVFpwwGbpiPLoh8=; b=dw2YelZFnGTEoXq8ckOn+96BO
        m2I5TlRQEVKX8seeCThXrIpVy7mhkiNf3/Z609hiddmR+ZsTY5OFy0cy5LN7gHrjyu7eB0Ycf6Ign
        0xsjN6dV3t3I/X7ci8m5vU0bBJsVchUg6GShQPey/DQO1UdqvfkZpEaMJTVXxF/frs4SXBAJIw/AJ
        BGXp8AVwwauNLmBvvPVSw8PpnuK4mXdBQ5et5FLoKNgCEdEA4YJClANAOCgVNdwytgYXdZNurBJgQ
        d5nd8KDAQ7T00Q98x0G51xZYJReid0W3NI+p8E4qKz3lz9QU7vthcORFK+sh0YxocAo8kAvrr+J+M
        9d407XQLQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFzDu-00047C-6V; Fri, 26 Oct 2018 10:20:10 +0000
Date:   Fri, 26 Oct 2018 03:20:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, igor.stoppa@huawei.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] prmem: documentation
Message-ID: <20181026102009.GP25444@bombadil.infradead.org>
References: <20181023213504.28905-1-igor.stoppa@huawei.com>
 <20181023213504.28905-11-igor.stoppa@huawei.com>
 <20181026092609.GB3159@worktop.c.hoisthospitality.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026092609.GB3159@worktop.c.hoisthospitality.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 11:26:09AM +0200, Peter Zijlstra wrote:
> Jon,
> 
> So the below document is a prime example for why I think RST sucks. As a
> text document readability is greatly diminished by all the markup
> nonsense.
> 
> This stuff should not become write-only content like html and other
> gunk. The actual text file is still the primary means of reading this.

I think Igor neglected to read doc-guide/sphinx.rst:

Specific guidelines for the kernel documentation
------------------------------------------------

Here are some specific guidelines for the kernel documentation:

* Please don't go overboard with reStructuredText markup. Keep it
  simple. For the most part the documentation should be plain text with
  just enough consistency in formatting that it can be converted to
  other formats.

I agree that it's overly marked up.
