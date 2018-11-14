Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B62C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B061214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR7JDe2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B061214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeKNVgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:36:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKNVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:36:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so14358353wmc.2;
        Wed, 14 Nov 2018 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YKynv5i976Bs+oA2+Hw62uL4KpU1VbryymcDUpH5res=;
        b=fR7JDe2zMLSW27Wgfsaf2UXZeLy821ZeaP4MRlfFJstF47UIMuiujXQajqwmlgnUUe
         YHqX6AHjkGSLHwSa2o0GYFT1Zyt44j5P68FVxyBB6FraGkPgKC67kwjTsazjNWL7cyGm
         +48OgPIR3BhdfGU+MZt1ZoQ1TQSfrMfiQg1lmJqMO3JQ0/kwTy1nY4wOQBojCKDwfYLN
         8im8nXB+Stb81tp+a+nwpLEloB0hCOejNVHdISWv3zwPICH6HHDAlxKSSWv3q+Y+yvTz
         myhscKqWPJaQrWCkIcYkPPX6j5gidC6iwsmzBc1azuDDLGbkvVutIzZUEXAzlMMrSvjT
         IR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YKynv5i976Bs+oA2+Hw62uL4KpU1VbryymcDUpH5res=;
        b=QssZYMFsurWqpUINz8oKKmkbEuNwWX/92dy1uErv76ahr4apNJ10Lh2XB2sFUHgz1K
         +jGaQj1z7YDebvjB+MVi4ENol8XIOWGaCXis6wlMKA6Wsj5jNFKpMuA4sbuMJU3l4lkM
         wSP9x6WfALXpM0oPpOKfN/SWp9ujad8zu5rMUt35viMIpPZ0JDGqildw4D+jpDNOFoOZ
         0Zmg2CpP0RGEt49i3z31IS8SLCiJypKg6CaRCk3whgPFTUHFS/Kk0/IRAup6H5ptBdJU
         /vtqM33WXLgQwGPDXQPHDXLZWsWPGO9da27cwRcorPNVJG1fXtSGvv5BPrAyoIoa2emB
         ZbGw==
X-Gm-Message-State: AGRZ1gIUlSAueGDPmuvvKOnEHcgfHnXGCuNV7BE+VujdZKjqtOLSMaMw
        afveKeYwsbLVk6iS9gn2mZE=
X-Google-Smtp-Source: AJdET5fvU2NHQHuxeNNEV663PrNVpTAFj7tv+7w0p3yiRAPCGWLcb7slRz3l3LW4l470xTZnI4dVcw==
X-Received: by 2002:a1c:85d2:: with SMTP id h201mr1004193wmd.151.1542195223932;
        Wed, 14 Nov 2018 03:33:43 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k15sm8361654wru.8.2018.11.14.03.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 03:33:42 -0800 (PST)
Date:   Wed, 14 Nov 2018 12:33:41 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Andreas Henriksson <andreas@fatal.se>
Cc:     Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181114113341.yx2wlzqku5yh3k4h@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
 <20181002081654.jxesr3kj62snzez5@pali>
 <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
 <20181012091941.o22srnhse4kzqjhf@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181012091941.o22srnhse4kzqjhf@fatal.se>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 October 2018 11:19:41 Andreas Henriksson wrote:
> Hello everyone,
> 
> On Tue, Oct 02, 2018 at 04:44:10AM -0400, Jaroslav Skarvada wrote:
> > I am downstream maintainer of dosfstools in Fedora/RHEL. My personal opinion
> > with such kind of projects is that one or two years without activity doesn't
> > mean the project is dead. I don't know what happened with Andreas, but
> > in case of no response my +1 for the GitHub fork. I think it's non offensive
> > solution which can be easily reverted if needed. Please let me know if you do it
> 
> It seems Andreas is a Debian Developer (like myself), so I used the
> debian tooling for 'missing in action' (mia-query) and it seems
> he is occationally active (but showing obvious signs of busyness).
> 
> I even found his irc nick and found him online. I told him about this
> mailing list thread and he replied that he has been extremely busy
> with things in his personal life lately and said he should really
> try to find some time to catch up with things, but since he hasn't
> replied here I thought I'd just let you know about the situation.
> Hopefully things calms down for him soon to allow him to catch up.

Hi! One more month passed. Do you have some news? Probably when Andreas
can look at pending patches?

And... has somebody else time to look at those pending patches and do
some initial review? I would really appreciate if somebody look and
comment them.

There are 14 open pull requests:
https://github.com/dosfstools/dosfstools/pulls

> I hope you find a good way to handle things in the mean time. More
> people probably need to help out reviewing incoming issues/PRs and other
> things that can help Andreas out with the maintenance burden, but with
> his current lack of time it might be better if someone motivated and
> capable just forks the project on github and starts doing the
> maintenance work in the fork. If things works out well, maybe this gives
> Andreas confidence he can safely hand over the official maintainer role
> to someone with more time for it (and you can 'unfork' again).
> 
> Regards,
> Andreas Henriksson

-- 
Pali Rohár
pali.rohar@gmail.com
