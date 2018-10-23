Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9259C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2F620665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Bs8bEHQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2F620665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJWRET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:04:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35336 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727542AbeJWRER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:04:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id o14-v6so567636ljj.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ALc6zVYagNaWriW2b+KFlrJErOKBzdWvlAJ7dZvVcoM=;
        b=Bs8bEHQdfxiVxFp0OyN0B80oq9isjtQEqD49vrRUctnT11ckAgvytjPcReaxYINGSf
         zQdEMGIYVkFzB0bPwA9lphzpiFiqrIrzqfd17LjxnnScw2YJHv+YPiJSKo3mWhyuA3IF
         bz8i0vHquJ6xde+HcpN37m3lCpFbGSyfy1Ygbopxo47enToyFy2pZzLFmchATN+CK8A1
         cVLh8x6L6smt93dCOI5KoUcJueSGYovhk167wrorNMForkST9R/1uvzLRny/NleIkjD8
         GUkDzthw5dSk41F2pAQjFkGiFWqvZfF7jt+nNZEbbdWJcTOqsZ2FXscbIJNlJpTfju8/
         BU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ALc6zVYagNaWriW2b+KFlrJErOKBzdWvlAJ7dZvVcoM=;
        b=FNknNng7iRKKwAKtH5oqaElzSuXk5I0KlPJoEkJQuRHY7mYDivC5JpPbBRHb8dfh73
         D2gHGLgGd+KSKXgXg/5HEZrKCncG1UPqjHHS44GeaDJcPba2lliUlbl4yb3F5pcjw9qw
         y2DlamrImaCST2PM3+9HfwW0SzM7GfvnzWwgSvhYmM2utVygNNpJZHFMPt+XuphO0Cgy
         HL3JklKXDDNdzUazbFWAB/rmkXMt3xmbAq0wrkiHB5L5jxOEZGehGJ2ejvClmJsQThFb
         Y/alrjKZxyc8tZaLJAEJ1V7h3LeWzoZgyhT8SaeSucVf6w6JTcGeLRoJ8/2xlyi2YQQO
         BUlw==
X-Gm-Message-State: AGRZ1gLyVismqUye7igC1TE1JvrzRzb24ZiY4tYakFeY0tPN8gQo2Afi
        AlFZlqVKbzlt5m/yp+eLN5AaG83DdvXdq9C0h7WrRQ==
X-Google-Smtp-Source: ACcGV62j3LQo8+ZHJxyFEIjPQn9j2y2K+9/xESX8q1vI6XfW8U50LU5EPVMuoHN2NS5B7efK7y8S/5vmAzq3qNDKMwI=
X-Received: by 2002:a2e:350e:: with SMTP id z14-v6mr12914651ljz.49.1540284112420;
 Tue, 23 Oct 2018 01:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181022100726.5hwvc5xswg3k3a2f@localhost> <20181022182243.GM16290@twin.jikos.cz>
In-Reply-To: <20181022182243.GM16290@twin.jikos.cz>
From:   Olof Johansson <olof@lixom.net>
Date:   Tue, 23 Oct 2018 09:41:40 +0100
Message-ID: <CAOesGMgjfpifo4xWaiT5KGx1_knOkqgGAb5+dTVbh+6S41Smag@mail.gmail.com>
Subject: Re: Circular lock dep in btrfs triggered by shrinker
To:     dsterba@suse.cz, dsterba@suse.de, linux-btrfs@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 7:22 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Oct 22, 2018 at 03:07:26AM -0700, Olof Johansson wrote:
> > I hit the below circular locking dependency. Seems like the assumption made in
> > 712e36c5f2a7fa56 ("btrfs: use GFP_KERNEL in btrfs_alloc_inode") either isn't
> > true, or has since changed?
>
> I think it must have been there from the beginning. There were reports
> of this lockdep warning like the below and IIRC a few more
> (https://lkml.kernel.org/r/20180627120523.GA2287@suse.cz), but without a
> resolution.
>
> Incidentally, there was a fix that's now in the 4.20 pull and only after
> I had seen your report I realized that it was the fix for the warning:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/commit/?h=for-4.20-part1&id=84de76a2fb217dc1b6bc2965cc397d1648aa1404
>
> It disables the filesystem allocations using the memalloc_nofs mechanism
> around free space inode allocation, while my original patch expected
> only regular inodes created by VFS.

Ah, great. I'll take that branch for a spin later today and confirm at
my end too.


-Olof
