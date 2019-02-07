Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3880C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CC221907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 13:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBGNuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 08:50:06 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36614 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfBGNuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 08:50:06 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1grk3g-0004Hh-6E; Thu, 07 Feb 2019 13:49:40 +0000
Date:   Thu, 7 Feb 2019 13:49:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Denis Efremov <efremov@ispras.ru>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] security: fix documentation for the path_chmod hook
Message-ID: <20190207134939.GA2217@ZenIV.linux.org.uk>
References: <cover.1549540487.git.efremov@ispras.ru>
 <0275d06334cdb1d2a87384d7971924a70776b3cb.1549540487.git.efremov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0275d06334cdb1d2a87384d7971924a70776b3cb.1549540487.git.efremov@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 03:44:54PM +0300, Denis Efremov wrote:
> The path_chmod hook was changed in the commit
> "switch security_path_chmod() to struct path *" (cdcf116d44e7).
> The argument @mnt was removed from the hook, @dentry was changed
> to @path. This patch updates the documentation accordingly.
> 
> Signed-off-by: Denis Efremov <efremov@ispras.ru>
> ---
>  include/linux/lsm_hooks.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index cb93972257be..5d6428d0027b 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -304,8 +304,7 @@
>   *	Return 0 if permission is granted.
>   * @path_chmod:
>   *	Check for permission to change DAC's permission of a file or directory.
> - *	@dentry contains the dentry structure.
> - *	@mnt contains the vfsmnt structure.
> + *	@path contains the path structure.

May I politely inquire about the value of these comments?  How much information
is provided by refering to an argument as "the dentry structure" or "the path
structure", especially when there's nothing immediately above that would introduce
either.  "Type of 'dentry' argument is somehow related to struct dentry,
try and guess what the value might be - we don't care, we just need every
argument commented"?

Who needs that crap in the first place?
