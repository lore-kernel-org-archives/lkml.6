Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92071ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4740A20846
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2HZSO/pH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4740A20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbeGLXd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:33:27 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46929 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732243AbeGLXd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:33:27 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so11309107pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E59WpRPCjmtFx5KXXD35289bbHUJ8DPuvAaEKu2ztBA=;
        b=2HZSO/pHC2CLSf3beAjygTAjeXsmduUwOa4MT4Zs4mYzi6g/RDcsRTAIPYAczzkyzz
         2dK/6U+xbFuCLjF16xvVzHB+rx8ztmwJ+7AJNe2XyYA3a1zD2I6q/skCUxIyDtOjBRDi
         eWTQ/3IrJklEVYMbpC5VR8PqWzKJBqW5geIu3s2Jsprl/TjPQXB/yuGBSgkQ+Irp1WbV
         eZh7Ci+h1PfAeeeNiuqrVqI6LTPVgocaWKoIidYMBkHasU6ir970xdnUlB9lhYG6kveB
         FSoPc+lHD65XgF+Jr54ch0XY1UWfgFaD83Q9in/YNbXPbtciL9otg/XUDpnfiZWSZmn3
         qffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E59WpRPCjmtFx5KXXD35289bbHUJ8DPuvAaEKu2ztBA=;
        b=pn6rwtbJ0xU63MKdRLJK/2r0k7awzopQL2I7YBXPKxCPdvxeqMcKLr6/XcdDDRypP6
         GgD3vnZgohhVBJXOQcrTtLl7okp1b+ibSWvQ18wy78M6k4MpgKmW+cXqL90rrEkbK2eh
         YeRgN6Re8jbDpTAJ714L60maLyRN64ydQvbbl1hB/3JfnmFIAqi4/uR92ff9xygGLTz+
         m9h+cEBtW66XJjYHZU7cm+r/QXdhqWWs4C+dDU1Z5XcehPSbjtfRl70gKywisuiNTsln
         dOl0urU2vzFkeTYCYsG3v5iIf4c+spSI8iE5jyzrta9OiuF/ntyezMDcdaYZUlgPTTZE
         gZjQ==
X-Gm-Message-State: AOUpUlGqlMejfNqCAXmZSoWpts0ZSxtfhdIPdJwrXD64ybuo5wZq79RW
        dzddyQVbKy6nGp946DbwspWZZA==
X-Google-Smtp-Source: AAOMgpd/A3vmghXXTnE2leJPQuO03iBopb9+UurOqjao4l4btbG/VTMiaz55vyIBWUFIgmSgb7zKLw==
X-Received: by 2002:a17:902:bc8c:: with SMTP id bb12-v6mr4038339plb.84.1531437699188;
        Thu, 12 Jul 2018 16:21:39 -0700 (PDT)
Received: from [100.125.106.90] (24.sub-174-237-8.myvzw.com. [174.237.8.24])
        by smtp.gmail.com with ESMTPSA id s20-v6sm34661548pga.37.2018.07.12.16.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 16:21:38 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <22105.1531436081@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 16:21:35 -0700
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <611054C7-D6E8-4C89-958E-3128C9305E1E@amacapital.net>
References: <20180712223223.GA28610@thunk.org> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk> <22105.1531436081@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 3:54 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
>> So maybe the answer is that you open /dev/sda1 and /dev/sda2 and then
>> pass the file descriptors to the fsopen object?  We can require that
>> the fd's be opened with O_RDWR and O_EXCL, which has the benefit where
>> if you have multiple block devices, you know *which* block device had
>> a problem with being grabbed for an exclusive open.
>=20
> Would that mean then that doing:
>=20
>    mount /dev/sda3 /a
>    mount /dev/sda3 /b
>=20
> would then fail on the second command because /dev/sda3 is already open
> exclusively?
>=20

I tend to think that this *should* fail using the new API.  The semantics of=
 the second mount request are bizarre at best.=
