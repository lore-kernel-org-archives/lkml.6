Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60759C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9482081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfBHTVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:21:33 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51174 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbfBHTVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:21:33 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1gsBiN-0003cv-3J
        for linux-kernel@vger.kernel.org; Fri, 08 Feb 2019 19:21:31 +0000
Received: by mail-it1-f198.google.com with SMTP id p66so8240789itc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LTYfkTayWDF8Zw8EigtDX2gxulRjVRoHQ/Y7rwPeu54=;
        b=q+hzGhy+UmdOjqqek4i5w8LpBMJwK4IdJRG4rLdsh9fgNjV8hAniTJzo/75pzj4AY1
         Hkrx6erZQJil7c3yKq/GCg6k5+LhTu+xONiEOz5RDB+WuwmE1o+djRg7s+12oQdewgTm
         TZPksYjJynqfYeEjubCviYiYsEZOdqFjQvLZCxc1ySWgFS9/83henbDqQQg7Bl9m1JSn
         UJz6cfoDeOqhYoLqmmQr8Sx5YNb+J/FMiAudLiDDDKhkEOkbGimKa+NSOen1rKsjk4HV
         iSSS2eGCThtBdVagSl1UDiPmVoX+Wt0InsvYFHW9d8m8++kKU55PNLbmoe0NFiR0l4v9
         E99Q==
X-Gm-Message-State: AHQUAuYfalGnVOZHnhBlHvl/4FRwRslwdGNKg5MJZlvznREzpX2aw2p2
        4JHoNnhjGcqMgitxg7buKzGGHrDQNDLKoL2hfzIb7mBwDmFQPtqD199785GdOisObyckxVlOqBI
        qOxugVGfuWHIT+tOYbFKnr38By3OHRPY7iJk92vtvOQ==
X-Received: by 2002:a24:b34b:: with SMTP id z11mr48705iti.43.1549653690051;
        Fri, 08 Feb 2019 11:21:30 -0800 (PST)
X-Google-Smtp-Source: AHgI3IbwfwXEnl8YGpLw/JWe5wm6FCrzb12kgn53l3K86MQoTN65e5Xxvkzf8F8G/o6vsUqDEEY7tQ==
X-Received: by 2002:a24:b34b:: with SMTP id z11mr48688iti.43.1549653689761;
        Fri, 08 Feb 2019 11:21:29 -0800 (PST)
Received: from localhost ([2605:a601:ac2:fb20:ac97:1957:a992:bb67])
        by smtp.gmail.com with ESMTPSA id x79sm1571152ita.34.2019.02.08.11.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 11:21:28 -0800 (PST)
Date:   Fri, 8 Feb 2019 13:21:27 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/ima: require signed kernel modules
Message-ID: <20190208192127.GO3218@ubuntu-xps13>
References: <1548962339-10681-1-git-send-email-zohar@linux.ibm.com>
 <1548962339-10681-2-git-send-email-zohar@linux.ibm.com>
 <20190205151859.GD16362@ubuntu-xps13>
 <1549385244.4146.148.camel@linux.ibm.com>
 <20190205183201.GA3218@ubuntu-xps13>
 <1549392741.4146.161.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1549392741.4146.161.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 01:52:21PM -0500, Mimi Zohar wrote:
> On Tue, 2019-02-05 at 12:32 -0600, Seth Forshee wrote:
> > On Tue, Feb 05, 2019 at 11:47:24AM -0500, Mimi Zohar wrote:
> > > Hi Seth,
> > > 
> > > On Tue, 2019-02-05 at 09:18 -0600, Seth Forshee wrote:
> > > > On Thu, Jan 31, 2019 at 02:18:59PM -0500, Mimi Zohar wrote:
> > > > > Require signed kernel modules on systems with secure boot mode enabled.
> > > > > 
> > > > > To coordinate between appended kernel module signatures and IMA
> > > > > signatures, only define an IMA MODULE_CHECK policy rule if
> > > > > CONFIG_MODULE_SIG is not enabled.
> > > > > 
> > > > > This patch defines a function named set_module_sig_required() and renames
> > > > > is_module_sig_enforced() to is_module_sig_enforced_or_required().  The
> > > > > call to set_module_sig_required() is dependent on CONFIG_IMA_ARCH_POLICY
> > > > > being enabled.
> > > > > 
> > > > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > 
> > > > With respect to interactions with the kernel lockdown patches, this
> > > > looks better than the patches I saw previously. I don't feel like I know
> > > > enough about what's going on with IMA to ack the patch, but I feel
> > > > confident that it's at least not going to break signature enforcement
> > > > for us.
> > > 
> > > Thank you for testing!  Could this be translated into a "tested-by"
> > > "(for w/lockdown patches)"?
> > 
> > Yeah, that's fine. To be clear about what I tested, I've confirmed that
> > it doesn't interfere with requiring signed modules under lockdown with
> > CONFIG_IMA_ARCH_POLICY=n and IMA appraisal enabled.
> > 
> > Tested-by: Seth Forshee <seth.forshee@canonical.com>
> 
> Oh!  You've disabled the coordination of the two signature
> verification methods.  Any chance you could test with
> "CONFIG_IMA_ARCH_POLICY" enabled?

Ok, I've tested this now and it also seems to be working. However it
does seem redundant to have CONFIG_IMA_ARCH_POLICY alongside lockdown,
as it doesn't enforce anything not already being enforced by lockdown.

Seth
