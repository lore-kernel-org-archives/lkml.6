Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA75221904
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=explicate.org header.i=@explicate.org header.b="Zhaf5e1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389731AbeLTU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:59:44 -0500
Received: from www.explicate.org ([71.19.157.6]:54161 "EHLO
        smtp.svc.explicate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731157AbeLTU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:59:44 -0500
Received: (qmail 405 invoked by uid 1000); 20 Dec 2018 20:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=explicate.org; 
 i=@explicate.org; q=dns/txt; s=v01.y2019; t=1545339584; 
 h=date : from : to : cc : subject : message-id : 
 references : mime-version : content-type : in-reply-to : 
 date : from : subject; 
 bh=BmZuE5Y3x3RItI+kubVE1AOLIiH5y2XqBjiEEEcfugE=; 
 b=Zhaf5e1vZpXs8c4QZGSBwkiOHwb9YJtASzRE7dXOLkzOzKp66d6IK8V/
 /Rzsj1lnMPpG0kDDybv/qSiHUmv7Kf9ddHWWvOwPiIcXb6FksQUz44tTjX
 eTGVLRFPRejr83apZITAenGFXIB4p9pAmpTVoRLK075dmQ653Z92w85bU=
Date:   Thu, 20 Dec 2018 12:59:43 -0800
From:   Ken Pizzini <kkpp@explicate.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: Re: PROBLEM: Xen paging-request boot failure since 4.19.5
Message-ID: <20181220205943.GA17537@144vak35.msa.explicate.org>
References: <20181219212537.GA25174@144vak35.msa.explicate.org>
 <fea48b7a-443a-11ac-a3c2-9d26af808f87@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fea48b7a-443a-11ac-a3c2-9d26af808f87@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 11:12:40AM -0500, Boris Ostrovsky wrote:
> This is addressed by https://lkml.org/lkml/2018/12/11/266 but has not
> been merged yet.

Confirmed: applying the patch in that posting to my Gentoo
sys-kernel/gentoo-sources-4.19.10 tree results in a working
system for me.

Thanks,
		--Ken Pizzini
