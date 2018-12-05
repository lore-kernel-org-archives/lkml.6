Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE192C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C9E2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C9E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeLESqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:46:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeLESqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:46:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BFCB93154859;
        Wed,  5 Dec 2018 18:45:59 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DF96C5C66B;
        Wed,  5 Dec 2018 18:45:58 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:45:58 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 02/11] livepatch: Shuffle
 klp_enable_patch()/klp_disable_patch() code
Message-ID: <20181205184558.ownhinkxam2mb5ny@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-3-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 05 Dec 2018 18:45:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:22AM +0100, Petr Mladek wrote:
> We are going to simplify the API and code by removing the registration
> step. This would require calling init/free functions from enable/disable
> ones.
> 
> This patch just moves the code to prevent more forward declarations.
> 
> This patch does not change the code except of two forward declarations.
                                      ^^^^^^^^^
s/except of/except for

> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
