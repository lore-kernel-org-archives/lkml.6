Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF56ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A90E20B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHOCYX7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A90E20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeGPOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:22:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35865 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbeGPOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:22:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id h9-v6so32031798wro.3;
        Mon, 16 Jul 2018 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52EqzEF0IJ2j4zCF2cRXQVwzGOLX3w15hmO6G9A45Mw=;
        b=sHOCYX7TGSsFaP0nwAbRs1SCJlRCbOD+OSkzJcXu+EFXnBcwI3PN3kxS/iDivkunVp
         TF7HQzUelvqlNOpyoOU0gwROc7juMAk5K+IkF57NC+40vEDkGA4+tscze3USu6cspj5c
         mTvx9FSQzdGOWY7FsWPjJHNmHNMhve+VLGkaNprtzfnsDoyiNwXZBexGnjYW3cplXNLr
         IxE6FFLYJpni+yC2Rj57xvMWp3jiMHyiJzyg4qW8G4oIKso7n7/zNNsvpzLw6F/Z4d/R
         VQQDqNS4ijE/I7DhGYozZTBTCToxE/xfdyAzCikLrbpfTU7YEvx7f9PPiOVzCi2oluZM
         x0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52EqzEF0IJ2j4zCF2cRXQVwzGOLX3w15hmO6G9A45Mw=;
        b=hbhIIH/CZ7PGzVbvhR+m5ciXb6QAZDl36YK32XodJflxwskSk+gfGHCJ1CFciuTCic
         ruskQ9RXEWMZSZUehfVxGGIboaYDD017PBslb1U/hiS65l+iDMKWhsDubjE6VmtdXUsG
         MBIHu5ZoIMl/s0qyCbdZka5PW5ujpitDwL6ZxgpOgK42fuQWWb5DNCaoJHS8AikfDUh3
         o7vf+wZNRPJxoolK4HSEGRTjx21sRZRqVJONPdLvqkW/YGFX09ICBYTRpZlAigEdq8Q7
         2A+Zd+/OMgksb7zIB6YwJaUZLyXg3Iyu+qIdSxF+ytZzmRB/eVLRb5ZBa1dMb2hU+Qno
         ERKw==
X-Gm-Message-State: AOUpUlF2GICYJPOcfatM6mYjyCExmGqBKeMR14yksoppB7BteIecoyN8
        W3S845mUUPDE5fvb4NiELQo4e46T
X-Google-Smtp-Source: AAOMgpcx5jzS84/MOpV/u46O1fqQWmUOyJ96N4a46+Q5INDuJPTcoIOVsWt9MwYFF9mlboP7sH06DA==
X-Received: by 2002:adf:f90d:: with SMTP id b13-v6mr11851744wrr.38.1531749316519;
        Mon, 16 Jul 2018 06:55:16 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id d7-v6sm26246675wro.92.2018.07.16.06.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:55:15 -0700 (PDT)
Date:   Mon, 16 Jul 2018 06:55:14 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
Message-ID: <20180716135514.GA4433@flashbox>
References: <20180716073504.433996952@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:36:08AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.113 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled with -Werror, and installed onto my OnePlus 6.

No issues noticed in dmesg or general usage.

Thanks!
Nathan
