Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3192ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D963208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDxm6Cz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D963208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbeGQLng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:43:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33859 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbeGQLng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:43:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so857859wrt.1;
        Tue, 17 Jul 2018 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFf1LPpu6VQ48F2Ef6gQ7jdL854vA51xd/5HvXS3j3k=;
        b=QDxm6Cz2V1Z0m1g0D1eN+HG8q0PMpnz1YPOF3dgxyoWABwxxZip8jVfO4Jzm0hLqW5
         JLotvUpeMxLoQHbPcd4jX2m5MiJDxd1KAPQEL+CQKq01DzTFaFnzIEAbq4gRTpFGaSF9
         XaqEFSRxORy5MX/wal1RWSzWD8hz0BdGZzz4rRh6MndclNQ5rHelVdhXZBD51TyLol58
         VY0QlbpWyjwKYpOlY/7Rv7l/2eyBMgTX5onLvOGHI748bygQr30IFOtsjn2/lyHoN05B
         aQIRsfc0FpD6rFfjcsYTflmzyGZmtnwsVbI2Q/iLB1CWcIP8D/VgGiVvMbwlpZS+c2WG
         xOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFf1LPpu6VQ48F2Ef6gQ7jdL854vA51xd/5HvXS3j3k=;
        b=gdHSdN3g4bDa37bLAQtBClwXYYrcDDBeuQduaq4GfEDSzhXIWFBUQ4sX9JgiDmPpq8
         szBMFLuRP0uSkJNrxQiedZ66kPc2uc2M73ZhyTJPSSxDqbc0HPWSq5IhkoIB/wsQ4Tl0
         b7jXIYGHhxEJoVXk+FSBss7+RU4/1aoGcatmIraf+/bocf5shHnW8/RoshGO6NO0gXjy
         CWygFTiyUrwDxEC6yUSXbFkfJ7aR/LGjQgNefvAw8Q63kDOycyN+CHqEvHXKbahM0r64
         AiU+Vp4ieKJyFUtPB58E8T9xm+57qAhdaHqn00D1M60E8168zwHYVjToh1kMierxuu+J
         /YrA==
X-Gm-Message-State: AOUpUlEjd3drgKSKf2fJFiOA6511UY0Tvh5VRHx1yHBSXczh73/hSLF1
        PwBZTE5dCOWdF5HaYv62GUdWr9ppzew=
X-Google-Smtp-Source: AAOMgpd+0/T8PzfO9YwMFZdqQcHzoJ+OVfaBnHhFiMibY7v7pwUoLpVru9Lf7w9AjmE3wi4CxK7PqQ==
X-Received: by 2002:adf:ed41:: with SMTP id u1-v6mr1003846wro.262.1531825888182;
        Tue, 17 Jul 2018 04:11:28 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm711167wmc.33.2018.07.17.04.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 04:11:27 -0700 (PDT)
Date:   Tue, 17 Jul 2018 04:11:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.17.7
Message-ID: <20180717111126.GA24208@flashbox>
References: <20180717105929.GA18343@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717105929.GA18343@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:59:29PM +0200, Greg KH wrote:
> NOTE, this kernel release is broken for i386 systems.  If you are
> running such a machine, do NOT update to this release, you will not be
> able to boot properly.
> 
> I did this release anyway with this known problem as there is a fix in
> here for x86-64 systems that was nasty to track down and was affecting
> people.  Given that the huge majority of systems are NOT i386, I felt
> this was a safe release to do at this point in time.
> 
> Once the proper fix for i386 systems has been accepted into Linus's tree
> (it has been posted already), I will pick it up and do a new 4.17.y
> release so that users of those systems can update.
> 

Just a heads up, it was picked up by Linux yesterday but it wasn't
tagged for stable: d1b47a7c9efc ("mm: don't do zero_resv_unavail if
memmap is not allocated").
