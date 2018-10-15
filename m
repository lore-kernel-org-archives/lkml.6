Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD77C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9006A2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BLCHoXm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9006A2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeJPBNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:13:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:13:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so22205409wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qi7uUp+5P3jKzIoPxwv0nxUSnPJinrSX8mKMCwzFyWI=;
        b=BLCHoXm2j/tKjuSg+enr9vA9Yey6LxBDevVZhXzTCkRf0WVKeS7sQlj/j9AZKe9QHb
         EJcShDZxQLUVi5SASPQhsunbY3hCA7cUqyvEEoS+35mKqXcX5lhSzhHj+rJMRoL5Rnqn
         4lj2EHs7q9Za2/qRp+sEIZ/iYlm47esfvY8hNHB1LuBkrbrQqJ/sBPQEtjaFVvmoJarb
         JMeZFuQLo/3ekg0Sh2uDCveEkxzQoQI8Lmio+2tWA9nEtaTi2HcKKmrCG/3N5q117xnG
         LZoUq+ctRZ8fUcUliEm+x96+Hixmg7OYo7nUSNtlbiyfy/CorZ6IKHi6CbPFcOJaEFHg
         7C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qi7uUp+5P3jKzIoPxwv0nxUSnPJinrSX8mKMCwzFyWI=;
        b=cvR4SSxywfb0miIrtFWypGGc3Z12lID1vChu1oOf+naVD0IfGRcoeFozni0OV4WBnD
         s8ezwO2dAxIpoWVrweJg4y1Hi7INfo+CYISTn7PozmJb4N4uCNqj9+XCrb2FE1jPk0SX
         LfXG6VRDLpSUOtUexWqYYz1jxRtSUBGugHpZRLD9NRAJejO/TJYl9IaK7zKLWMQzJFJL
         VHZWhxmBkf4tYc/+ByNp+S1bLT8fY9Aod8CYS2QAlDxQm15skaRLZzw0U/Q0xoyfSgUD
         MNnGLPi5bVmTIjJophqHvWKaBBYEq76aJb4ghRPimVSxxGoqke+UkAtE7fQ6uvJBfTnl
         6o0A==
X-Gm-Message-State: ABuFfohjVi8EIDIdNeRPTdtnnJq5ABvkmTaiYoxkyY68PS8bnNPxc6UW
        IOGKcOY+iJ3U2E3U2CvBiHcI97iQ92fVEPQcaDev4w==
X-Google-Smtp-Source: ACcGV63Sov8TVcOXTmY+nde/pkIeXMgJB7yG5UYCXvJmcY2+R3uA4wnzoKNosnOcMpcHo1/qy/zoW9Kk6ygdjkaLIbA=
X-Received: by 2002:adf:b188:: with SMTP id q8-v6mr15478631wra.95.1539624440889;
 Mon, 15 Oct 2018 10:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <1539623427-10789-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <CAG48ez2cHT1U5nn+dNCAg3Lk5047=Tr20T8HkKhBUt1Mv+gNeg@mail.gmail.com>
In-Reply-To: <CAG48ez2cHT1U5nn+dNCAg3Lk5047=Tr20T8HkKhBUt1Mv+gNeg@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Mon, 15 Oct 2018 10:27:09 -0700
Message-ID: <CALCETrU-UWQve_cQm58sMENRW2K=z-Vf94KYoWfXCtz5gc_nFg@mail.gmail.com>
Subject: Re: [RFC] Allow user namespace inside chroot
To:     Jann Horn <jannh@google.com>
Cc:     Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 10:22 AM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Oct 15, 2018 at 7:10 PM <nagarathnam.muthusamy@oracle.com> wrote:
> > Following commit disables the creation of user namespace inside
> > the chroot environment.
> >
> > userns: Don't allow creation if the user is chrooted
> >
> > commit 3151527ee007b73a0ebd296010f1c0454a919c7d
> >
> > Consider a system in which a non-root user creates a combination
> > of user, pid and mount namespaces and confines a process to it.
> > The system will have multiple levels of nested namespaces.
> > The root namespace in the system will have lots of directories
> > which should not be exposed to the child confined to the set of
> > namespaces.
> >
> > Without chroot, we will have to hide all unwanted directories
> > individually using bind mounts and mount namespace.
>
> IMO what you really should be doing is to create a tmpfs, bind-mount
> the directories you want into it, and then pivot_root() into that, not
> the other way around.

Indeed.  Or you can just recursive bind-mount the subtree you want and
then pivot_root() into it.

--Andy
