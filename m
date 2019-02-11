Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F554C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7DA521B1A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549898369;
	bh=yRRmLrQzmLE2WY7CjA9HEefc5BSJSi+Ducv/l8yXXHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S53cG/sDahfqacGp5LhE4eBX3SiyJg/GPfUCi83+fwStvwQ1b8YIRTyMTQIgd8w/y
	 wN2Sp/NAPSjk3FzPRna7FoQrbtt2P35E5pblK52yNONKa8ZzR0KO3xuMgfvrFBcsEm
	 oZL+nFR0IPQgUCGo8ZR5eNGMvQ+kPT0allT/K2SI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391883AbfBKPTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:19:21 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:36089 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391232AbfBKPTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:19:17 -0500
Received: by mail-yb1-f195.google.com with SMTP id h40so4310334ybj.3;
        Mon, 11 Feb 2019 07:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BFYPumxKKPP36JuhPr/IfmW+1Q+3YoYu1coLT5Kp5pM=;
        b=Nme0C2xtsGNr1D+lbCbAq5UVD3xbmfXUX93YzBg3iHCXi+ZCjMoNaeEEGTldahoqjK
         3an+/MxiKVcvpUaWSjmFu2GOJYcMvyNNIFlKGqYrNX6Wc3PNp6graBymVlf24RleN4Zy
         y4s5JTW5QOb0oivldSXgUr/MiscrvPD71rfEqz9W7K+OWb1KkJTMuNJRO2EkzuJcLXtT
         la/vCm2UDIuBaMP64iK5R0Iz5kkWVtEcnVRgxnXwMLx+WcZyQ9yjtE7PEVleLa/lXGSs
         yzsFhNx5O1EVNPMbm2noxkzUC7uYS0D1NyMgJRf2Mxher307q6if6BpKiBh9WhlZ1B9r
         mlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BFYPumxKKPP36JuhPr/IfmW+1Q+3YoYu1coLT5Kp5pM=;
        b=fiPaCf2p0/V8/FPg7u7BQNzx+gsXx39TDoS7Slj11X3QC57jEaRJy1JRCmfPNwGSyS
         cx848rUjo5tB9sAjNNucrqbgEP88WXClxnckcHXM79XBu2bxywk3H4ehuor8rGDl+CmK
         Jbq+RbkrxIvpULPqtzJSsJ7kC+c6cBMqq7G1cQ7Q+3N0cneeVuoMzeHqkNDdipdmor2l
         u9mT2x2krObCDUsolJIlE3EKcjsB9ySMtNBYuYa3KLbpeZ37IAzvXL3Mno+Tt4vaYHQK
         eauwsDGXRi/HosqXOtXeFo3NttfhSCTOcjNBsPSPPgu/QhBf3vQzpq5zHQtChav6ns1H
         rXkQ==
X-Gm-Message-State: AHQUAub0skXMuZ4EdoeSE0Txm/GoEwXjB59NdHAugkJDq1Dsr3IPwu4o
        n34CityrlTo9998tCuNhrNmPwQav
X-Google-Smtp-Source: AHgI3IYnv92JetFfRxO0ZVPYTZ+wHZDNo/s41dGr2XJEV0VwaDMHAi821/j9tjvLin894c+gVuMa/w==
X-Received: by 2002:a25:2c04:: with SMTP id s4mr28393196ybs.262.1549898356023;
        Mon, 11 Feb 2019 07:19:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:96aa])
        by smtp.gmail.com with ESMTPSA id h62sm3951193ywe.100.2019.02.11.07.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 07:19:14 -0800 (PST)
Date:   Mon, 11 Feb 2019 07:19:12 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Tibor Billes <tbilles@gmx.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: add documentation for pids.events file
Message-ID: <20190211151912.GM50184@devbig004.ftw2.facebook.com>
References: <alpine.DEB.2.20.1902091539220.29523@serpens>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1902091539220.29523@serpens>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 04:05:33PM +0100, Tibor Billes wrote:
> cgroup: add documentation for pids.events file
> 
> Document the event counters file for pid cgroups.
> 
> Signed-off-by: Tibor Billes <tbilles@gmx.com>

Applied to cgroup/for-5.0.

Thanks.

-- 
tejun
