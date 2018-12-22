Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17700C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22572196F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 19:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392718AbeLVTel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 14:34:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59192 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbeLVTek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 14:34:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gan2e-0006oK-Sw; Sat, 22 Dec 2018 19:34:32 +0000
Date:   Sat, 22 Dec 2018 19:34:32 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Colin King <colin.king@canonical.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] smack: fix two memory leaks in smack_add_opt
Message-ID: <20181222193432.GC2217@ZenIV.linux.org.uk>
References: <20181222122750.13075-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222122750.13075-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 12:27:50PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if s is null or when returning via the error exit label
> out_opt_err leaks of the allocated opts can occur. Fix the leak
> on the null s case by checking s is null before the allocation. Fix
> the leak on the exit path by checking if opts was allocated by
> kfree'ing opts.
> 
> Detected by CoverityScan, CID#1475953 ("Resource leak")
> 
> Fixes: b2130173efae ("smack: take the guts of smack_parse_opts_str() into a new helper")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

There's a better fix in local tree, will go into -next tonight.
