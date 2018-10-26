Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C56ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1866F2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 18:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Kcw8JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1866F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeJ0DcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:32:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33062 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbeJ0DcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:32:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id w16-v6so1695034lfc.0;
        Fri, 26 Oct 2018 11:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YSCo8uNIuTuy167cDW74WBGLJtzms6hFrgMG3hXLnbU=;
        b=B4Kcw8JCuQokXQQ9ns6eW7NmqRYq2HoF2m4yb71AKW4ttZn67gNfOzfk8LgTEyPGt1
         qk5Mo6QUoMghVnLwwlH7Q90WohjeYB7TAH8xu9AgDaAIOIqWAepKdXhPF8/l7Oj67jYt
         KeyP4Hb5d8Fk4sNRe6xQgJK4qqdfVAugbiX35UAhz5mO3Luc1Seyey/zh7nInCUSfFXe
         baEsMjlBiCpPw7cpOnLhqckRbv+Nl8RKZ8ZpSH9S41idtbjc4oQKN383xFHx7MX27U79
         Px6CN/QcliwMLfFBt7Iu2hxGmsRnv9cbvjFN84mV/0tfOPjRp++2ROz/SLFdxYhXpL3i
         B7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YSCo8uNIuTuy167cDW74WBGLJtzms6hFrgMG3hXLnbU=;
        b=mGSoMetJiVdtzjyFF53YrYlmSnw8COCuMgSZGX02dg/z/RzammPfvqpAlaEL4BfIQG
         pUBbJ7wX0laSFKj3vKU57srCx83zvKI0lIxENNc3Vs54GuOb7DeC1taCAXo2iOTbZ0iC
         3F88KCqKYa+hd0uzyZyQhUdF31DkqxukwYtJWX2RFdjP3Rdb10yzwxmcSSilaJYQXTpF
         3+wz0bPz0D6/Joi9GD6LircXCcnpfVMqwG/4aqV7GwX7upnSLi9HiObWUJHAXS1LHNGO
         abdWA86thujqbQMYEuvbT0h4eNxkOE2Lt10y9rsQ6ycsGEWKwRKi9KvGJXhsPzelfNzD
         FXTw==
X-Gm-Message-State: AGRZ1gLabnmeULMXfaYhbMS893BWaccC+nodT5q2fJTRqMo2KaJ/gF1t
        47fbF5WB6VHwYxfBC+q+TaAi8jVcVF6moBqBNFM=
X-Google-Smtp-Source: AJdET5cbmSHziGXKx7NzB4egJm094vKy0sh88KGamYMQTYMfJr4Hm+Ed5nZHvS1iNeydMoN40U3YWYqYK9M1Tx++5QY=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr2868444lfk.151.1540580042085;
 Fri, 26 Oct 2018 11:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181026172549.3628-1-colin.king@canonical.com>
 <CANiq72nFZS=3KGaQpGjRbprh8HTBiTcSpxScE2uacDmg-xqDGA@mail.gmail.com> <20181026184009.GV25444@bombadil.infradead.org>
In-Reply-To: <20181026184009.GV25444@bombadil.infradead.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 Oct 2018 20:53:50 +0200
Message-ID: <CANiq72m-2FU7ioqj9sqsfWk4nSp2FO9S_8kYcbnGReXNAXYM2w@mail.gmail.com>
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To:     Matthew Wilcox <willy@infradead.org>
Cc:     colin.king@canonical.com, jk@ozlabs.org,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com, maxime.ripard@bootlin.com,
        sean@poorly.run, linuxppc-dev@lists.ozlabs.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 8:40 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 26, 2018 at 08:20:12PM +0200, Miguel Ojeda wrote:
> > On Fri, Oct 26, 2018 at 7:27 PM Colin King <colin.king@canonical.com> w=
rote:
> > >
> > > From: Colin Ian King <colin.king@canonical.com>
> > >
> > > Trivial fix to a spelling mistake of the error access name EACCESS,
> > > rename to EACCES
> >
> > ? It is not a typo, it is the name of the error (POSIX). Same thing
> > for the rest of the patches.
>
> Are you sure?  From open(2):
>
>        EACCES The  requested access to the file is not allowed, or search=
 per=E2=80=90
>               mission is denied for one of the directories in the path  p=
refix
>               of  pathname,  or the file did not exist yet and write acce=
ss to
>               the parent directory is not  allowed.   (See  also  path_re=
solu=E2=80=90
>               tion(7).)
>
> include/uapi/asm-generic/errno-base.h:#define   EACCES          13      /=
* Permission denied */

I thought you were doing the reverse change. Never mind! :-)

(Btw, the POSIX reference is
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html#tag_1=
3_09,
in case you want to include it or are curious)

Cheers,
Miguel
