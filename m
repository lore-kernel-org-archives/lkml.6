Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D733AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C8327A64
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQHmYllT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C8327A64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936238AbeF1XVf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:21:35 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40779 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932883AbeF1XVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:21:31 -0400
Received: by mail-pl0-f68.google.com with SMTP id t6-v6so3490192plo.7;
        Thu, 28 Jun 2018 16:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=+hgYTpgJreKAtp7SUc+fq6XafQa+acnycs/yhXw8EXs=;
        b=bQHmYllT4f8F2lNmza49Lc+P5zHuYOexbN6fkQ0LyJ2uFC9kP6BqszqaLexi84p6jl
         OVML0giOHlmRfkn0kTzRPc9mayhqtxrbE0Ibf+VI9YF2WFXUUI7wjVypY5cmbz0HmXeV
         J6hbesIo21L2AjiSOhw3HxJbpVtCF8yapmyu+1j4/gA9MyMa2xcPN9wIWtK7tqcoW/Je
         u05e630jYLonRt24LZUbAgh4mOlUgzGw/32+mYx0Q1wzCyv3UmcXCFdVjAur+OXrExss
         s9qsS/9CUNoExDi015e9BGJcB+N/80OuJ9mmgwFBlxrgNgGdMzHvnGH5S/Sw2GHit6Hb
         aabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=+hgYTpgJreKAtp7SUc+fq6XafQa+acnycs/yhXw8EXs=;
        b=JwJyMpiKiQcCTBfLFTFOryMMFQSHQybPVaejUgst1Wv6oSNngNQoXl9HwUZpkCz6Nl
         HrgF/j8U/86fShwnd0FmB0MuWZ8CCL+hx+9DhmXTa5X6MeqKOqK/6R0TkkPR3+vfh0iJ
         GcadGiFwNZkYdeSQW62i89cmySefOwtRs9xSeu2ZBN8fYuASoyZop2tTqgq9BnQr3hZP
         cZr45HSOXkrfn8lEMV4QsbTe/VK1LpoyH8zTJ0bBZ40szzzsRZw+Eh70IXa7Ri7Mx54W
         MR+brodIGNaSEKttYklg5oZTqeaZqqIuWYrAIf9EuwOYUgxXloX6M3/Z5kyFsAjuQ4rk
         3E2Q==
X-Gm-Message-State: APt69E0OYCV+C2+3ng2tom32/hDuK+hp3qwaxnc6rh9gldEroFx0roJ9
        E7UXxBEgo4usrd/S0hrodyPiLLfPoE6FBRy7/L4=
X-Google-Smtp-Source: ADUXVKKuHjJRNJswUf2tmp4KhT4d+PMLcOCOH1z2gRVZoupkeVDp9Yr17pwHFIvuP1qWek/8lf6HajRKRxo6S5wegME=
X-Received: by 2002:a17:902:9681:: with SMTP id n1-v6mr12723584plp.244.1530228090982;
 Thu, 28 Jun 2018 16:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:21a5:0:0:0:0 with HTTP; Thu, 28 Jun 2018 16:21:30
 -0700 (PDT)
In-Reply-To: <20180628225857.GB1231@thunk.org>
References: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
 <20180628225857.GB1231@thunk.org>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Fri, 29 Jun 2018 09:21:30 +1000
Message-ID: <CAN05THStuq+RLzb_oNiD2TvN6MjMMnTdCxNiHuYWHRueQ46=_A@mail.gmail.com>
Subject: Re: config files and how to have persistent Linux kernel Driver/File
 System configuration info saved
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Steve French <smfrench@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 8:58 AM, Theodore Y. Ts'o via samba-technical
<samba-technical@lists.samba.org> wrote:
> On Thu, Jun 28, 2018 at 05:37:15PM -0500, Steve French wrote:
>> Ronnie brought up an interesting point about the problems consistently
>> configuring file systems (or any Linux module for that matter) so that
>> reboot doesn't wipe away security or performance tuning changes.
>
> In general it's considered best practice to make the file system
> auto-tune itself as much as possible, because the sad fact is that
> 99.9999% of the customers aren't going to bother to add any tuning
> parameters.  So there hasn't been a push to try to create something
> more complex, because it's generally not needed.

True, but in these cases I think we are more looking at server or
mountpoint specific options than
actual fs tuning.

For example nfsmount.conf can be used to say "only use NFSv4 when
accessing server abc" etc.
For the case of CIFS I could imagine that an administrator might want
to set "disable smb1 protocol globally"
etc.

>
> Settings via /sys/fs/ext4 are generally for developers as they try to
> understand how things work, so they can improve the file systems
> defaults / auto-tuning algorithms.
>
>                                                 - Ted
>
