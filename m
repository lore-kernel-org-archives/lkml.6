Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA097C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B663920989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbfA3Pmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:42:47 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48172 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbfA3Pmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:42:47 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gos0j-00046N-Sn; Wed, 30 Jan 2019 15:42:45 +0000
Date:   Wed, 30 Jan 2019 15:42:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next] fs/splice: iter_to_pipe -- Use PIPE_DEF_BUFFERS
 instead of hardcoded number
Message-ID: <20190130154245.GK2217@ZenIV.linux.org.uk>
References: <20190130153911.GJ2332@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130153911.GJ2332@uranus.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:39:11PM +0300, Cyrill Gorcunov wrote:
> And use ARRAY_SIZE for easier code modification if we ever need in future.

Umm...  Why PIPE_DEF_BUFFERS, though?  Because it's a constant from more or
less the same area that happens to be equal to the value we use here?
