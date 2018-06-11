Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4+kYMOk6HlvJQQAAmS7hNA
	; Mon, 11 Jun 2018 09:03:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF387607A4; Mon, 11 Jun 2018 09:03:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 34E15606FA;
	Mon, 11 Jun 2018 09:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34E15606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeFKJDf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 05:03:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:47485 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932538AbeFKJDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:03:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 45A70AE5B;
        Mon, 11 Jun 2018 09:03:32 +0000 (UTC)
Date: Mon, 11 Jun 2018 11:03:31 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jikos@kernel.org, jpoimboe@redhat.com, jeyu@kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] livepatch: Nullify obj->mod in klp_module_coming()'s
 error path
Message-ID: <20180611090331.deciyqbbql3h2e3o@pathway.suse.cz>
References: <20180607092949.1706-1-mbenes@suse.cz>
 <20180607092949.1706-2-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607092949.1706-2-mbenes@suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-06-07 11:29:47, Miroslav Benes wrote:
> klp_module_coming() is called for every module appearing in the system.
> It sets obj->mod to a patched module for klp_object obj. Unfortunately
> it leaves it set even if an error happens later in the function and the
> patched module is not allowed to be loaded.
> 
> klp_is_object_loaded() uses obj->mod variable and could currently give a
> wrong return value. The bug is probably harmless as of now, but we're
> gonna rely on klp_is_object_loaded() and correct obj->mod much more and
> the bug would be visible then.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
