Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD00C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9DF21903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732777AbeLUQhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:37:02 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41138 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeLUQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:37:01 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gaNnC-00015j-MR; Fri, 21 Dec 2018 16:36:54 +0000
Date:   Fri, 21 Dec 2018 16:36:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] smack: Fix a memory leak in smack_add_opt()
Message-ID: <20181221163654.GY2217@ZenIV.linux.org.uk>
References: <20181221090958.GE2735@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221090958.GE2735@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 12:09:58PM +0300, Dan Carpenter wrote:
> The function is leaking "opts" on the error paths.
> 
> Fixes: 90e3b564ab93 ("smack: take the guts of smack_parse_opts_str() into a new helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

D'oh...  Applied, thanks for spotting that braino.
