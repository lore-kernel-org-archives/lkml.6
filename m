Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF7AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF37420857
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="oMpoF8oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfA2SRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:17:47 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37282 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfA2SRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:17:47 -0500
Received: by mail-qt1-f196.google.com with SMTP id t33so23310796qtt.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZEklhevKI3Gbhsb8btAczqDD1QOFHCflfX9NR1AtiuI=;
        b=oMpoF8oy79RuME85jCKezNXquwMeoHATz7FZ4NHIYYgps1343D6U2bnUqP0o0KH/Se
         C9uFwqnGrrnetRAEwQbrfx2ng8r3ea9h2qmUQSu6Sgdv6FPL+7mrWQU1hIpz4d+x7UQ2
         nHGvh2Qu33xo8Y3eMeVIlMWt0OTBvvewTuEyX1NX0CkklJHRB8mW7fZ6QYAxnGNsNASn
         KzI16qTifb5+qj1UM+xt1K22dQVVu149ptQE9BkIhEVK6NX1Bs0Z2b+C9NcJ/kxus55i
         TiIiKAJ9TXWsE70JlUQD7vhOj8jw3oX16/eZE3k5NW3wIvERtEY2DA8PGrviArJj+NCb
         z+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZEklhevKI3Gbhsb8btAczqDD1QOFHCflfX9NR1AtiuI=;
        b=qu/vz93qJxrU3p3isv1Ad8px+gTaqtzRENvhp3iz5z4C3JU/2EPZhuDdl7/mfh0eDY
         jqs7CcNO0hD9d9AkLY4kmSaPfpiPs+XaSLArCiT9PvRaOyXms0jpWQJIO0r3SYbu0NDQ
         yDsDR2J/1EWjH4RJ4QZ5cWzJcfetnOZERXAkrxD63u5PRsZoOUvM6Ra9xKTwF5LdIIfo
         d0q8h/DP/iTdqxjBdtnpQUF56WfAImF89qy2dxliN32c1HdKiwFkUIvIbudmZyOCPpxI
         DnjL9PfLvzrCgBTx36VX0O66j4YGHSNIdKwS7Qn3ujuNEGjpsSIMk8EnYQZ0e2S+l+Dk
         NHZg==
X-Gm-Message-State: AJcUukes6XHWOfaZKPIRS8yO54OE02wtZmgIeafhsktkt3lLRVPfeGYg
        Woc0V0WUlL/9Y0IZc/vm/NlODw==
X-Google-Smtp-Source: ALg8bN4nnbZ9oOpkYdiiEUJ9B/YxJfGjNOrjQ8JujZijkSFXJV7mWjUyn3xhhANDE9X5P+89GI/HnQ==
X-Received: by 2002:a0c:f403:: with SMTP id h3mr25622844qvl.137.1548785866526;
        Tue, 29 Jan 2019 10:17:46 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l4sm56869941qtf.22.2019.01.29.10.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:17:45 -0800 (PST)
Date:   Tue, 29 Jan 2019 13:17:44 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        Omar Sandoval <osandov@osandov.com>,
        Nick Terrell <terrelln@fb.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] btrfs: plumb level through the compression
 interface
Message-ID: <20190129181743.bap6zerlaup5ewaq@MacBook-Pro-91.local>
References: <20190128212437.11597-1-dennis@kernel.org>
 <20190128212437.11597-9-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128212437.11597-9-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:24:34PM -0500, Dennis Zhou wrote:
> Zlib compression supports multiple levels, but doesn't require changing
> in how a workspace itself is created and managed. Zstd introduces a
> different memory requirement such that higher levels of compression
> require more memory. This requires changes in how the alloc()/get()
> methods work for zstd. This pach plumbs compression level through the
> interface as a parameter in preparation for zstd compression levels.
> This gives the compression types opportunity to create/manage based on
> the compression level.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
