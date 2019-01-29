Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FCEC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C2C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="xOY//dpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfA2SGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:06:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44644 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfA2SGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:06:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id o8so12044423qkk.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5wNE0HV5mvZVQ9rThDrqHS4OERbxFOIR6q7tTWzLOKY=;
        b=xOY//dpoHTVUwSZfXZ/05OjwDr0eF+y/2Y6bmSq3zkXheRGFMsDGg1qdJq3wtc5STH
         lb0YOkAJeD0agD6UrailHN7236stm9yD5bwleGOB+xJdj2XuQottg45Iv8JqosUdHRXT
         ojB8zhW1G5Gi+PfF2l71gXrwc6A0KHSpbxP9YfmmGoCvYDpMnYv8pEVKQ6rNAeNGENsz
         WGRTqNh0wFlXU+zyYLGVg2oYmpq0JALL5odLklyruosv59nJi780zLiwyjXoAq5MH8UC
         YOJgGSZpO3Txw6p+PAKVOJU9p/oAlcG7xaDmGi6ZRBtcOKVqQGJ4Ty86hcQTsdNq2ROB
         tE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5wNE0HV5mvZVQ9rThDrqHS4OERbxFOIR6q7tTWzLOKY=;
        b=SmSwjEJu2DNN01FsXowW8kI1c3drtyq9uYhFfTRwVuIrh579/xCt5uQ+emvNENrx1w
         chhFsgzIrMT1zEsUMy2wLGkriK+QPOiwpwB+Lpyv2pEk8u58R9ILzAF4Dw43wcXmVQqz
         y9r5dVjJ1AB4/tigcm6OscDm2DTqoiCGuzHYWeMqGCTod2yKybCXqQJOTTRUHdJbbVVB
         9JQJRumuQZNAIb++Z/F9qajbpFRyhrTJ7ZgQ8ZrNiFEpXjEpuaRigKGWBop3oKNRj43+
         x/31admFYHs/kmKTl3c5DDM0WPLzngfvjtlxVMreSevMQwf09cOCEMkEZ0ZTCcNlTweo
         UdCQ==
X-Gm-Message-State: AJcUuke6WLsBZP5mAr50U/ru8Mnja5jbIMqnYNQZwp9fsNiamnZ9/WEF
        a3mLhYURvNXIEHjs9TVCgmytKA==
X-Google-Smtp-Source: ALg8bN5OiT6B5uDi2ytO0Ovt3RiW4nREYjxhJNEamHsz0esCnkgcXtZvsqppNmUmdj4oM0X0MYCh4g==
X-Received: by 2002:a37:7885:: with SMTP id t127mr24899602qkc.323.1548785175262;
        Tue, 29 Jan 2019 10:06:15 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s46sm88555537qtc.63.2019.01.29.10.06.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:06:14 -0800 (PST)
Date:   Tue, 29 Jan 2019 13:06:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Nick Terrell <terrelln@fb.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] btrfs: add compression interface in
 (get/put)_workspace()
Message-ID: <20190129180612.2su6scf3mcuj4bdd@MacBook-Pro-91.local>
References: <20190128212437.11597-1-dennis@kernel.org>
 <20190128212437.11597-7-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128212437.11597-7-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:24:32PM -0500, Dennis Zhou wrote:
> There are two levels of workspace management. First, alloc()/free()
> which are responsible for actually creating and destroy workspaces.
> Second, at a higher level, get()/put() which is the compression code
> asking for a workspace from a workspace_manager.
> 
> The compression code shouldn't really care how it gets a workspace, but
> that it got a workspace. This adds get_workspace() and put_workspace()
> to be the higher level interface which is responsible for indexing into
> the appropriate compression type. It also introduces
> btrfs_put_workspace() and btrfs_get_workspace() to be the generic
> implementations of the higher interface.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
