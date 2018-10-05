Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0EAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B6292064E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 22:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYDjuzcq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6292064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeJFF2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 01:28:43 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45638 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeJFF2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 01:28:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so2564706pfn.12;
        Fri, 05 Oct 2018 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nq7sfuDcl8PWT1hmaQIotPDxXd5/W1IvtSFKuf5NWKE=;
        b=FYDjuzcqGEEZyP14+93XgVuw2jR0VcPXwmEEGkcKbWcsN0kyzPyZI8fcNEpPwRW7P8
         hTtSyvcjtSmxE+EygcpeLzyUmwwfcqt+E8ZKOBDCtJTttBgizRvJW/4SInChcdNGDP5A
         Y6/6x8nQU2+tfHx/ynvPxA0fZig/pnTQTiHSMxwblPviSHYcRyG3sw0trcP37CXtqoCt
         5tZft5kvZlXFWQCRmdV8lWfsZcRcMHXwS/H9/0kbQGfUpWR1zpnk6E/3hDbfpSu/TN4t
         UGUhTSE7cZrhEYCfrH1XpPv7a2TRW7ynGDw+emBuv/GTNQKqanvJ5Fe/BIU6g1JNDDBm
         f3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nq7sfuDcl8PWT1hmaQIotPDxXd5/W1IvtSFKuf5NWKE=;
        b=pOuEE4lKyY4DHFFvXXTxuYsi7xThWdzPyXIFohdJp2uCyEIqOcwVBNTOpzMuYuaBu3
         Hmtqaqw7I2JwWThY0VKaTG7bLL22gHAdlE5/2Or/hdHqAxuCmhS1vnRfZowKG+Ovh9w+
         8Hx0WvDTdSz2fInneCb79sIHw4jRCE/IrVoK1EVUkL63rr9v7h+T/F5e2i3CJTj7xGe/
         xkwdBO19w4mFhCnR1ddIdx9gDXHHTqW5cpeo4ee+DKJHgM+tg4AMLgBIamQ6hX7c9NDs
         eSAzByyFmEUD3fVSQfA1Myzi7PU09sco+oRet1slZgVWumU3nHZkkqKXEsiXDKFYwSEe
         v1TQ==
X-Gm-Message-State: ABuFfoispL5KOfzrMFdMr+/m5/u3Xw0vhYdHf7nkG/RKtkbKeeuuLZmZ
        p8KTUcTcUlQTmCzLMw1JrHzPC+DK
X-Google-Smtp-Source: ACcGV62FJmwER6eZa0BorwZ5NAGws+3+mbARsFNo0Oj72HY+w63A+l8tdaPGPgoSnnJtuxAJkQebmA==
X-Received: by 2002:a65:40cd:: with SMTP id u13-v6mr11920280pgp.334.1538778476644;
        Fri, 05 Oct 2018 15:27:56 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::4:fc91])
        by smtp.gmail.com with ESMTPSA id c21-v6sm15182546pfe.93.2018.10.05.15.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 15:27:55 -0700 (PDT)
Date:   Fri, 5 Oct 2018 15:27:54 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Message-ID: <20181005222752.l5da54rpww6tlyfy@ast-mbp.dhcp.thefacebook.com>
References: <20181004025750.498303-1-ast@kernel.org>
 <20181004025750.498303-2-ast@kernel.org>
 <20181005044659.GU32577@ZenIV.linux.org.uk>
 <20181005220518.747ri4q34obrnaoc@ast-mbp.dhcp.thefacebook.com>
 <CALCETrVURVaqJChL=RwZPe74+JfX-6Zzp9kLR9-mLiownSOexQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVURVaqJChL=RwZPe74+JfX-6Zzp9kLR9-mLiownSOexQ@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 03:09:20PM -0700, Andy Lutomirski wrote:
> On Fri, Oct 5, 2018 at 3:05 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Oct 05, 2018 at 05:46:59AM +0100, Al Viro wrote:
> >
> > > Another problem is your direct poking in ->i_ino.  It's not
> > > something directly exposed to userland at the moment and it should
> > > not become such.
> >
> > The patch is not making i_ino directly exposed.
> > Only 'struct bpf_file_info' is exposed to user space / bpf programs.
> 
> I think Al is saying that the valie of i_ino is not something that
> user code is permitted to know regardless of how you format it because
> it may or may not actually match the value returned by stat().
> Another way of saying that is that your patch is digging into an
> internal data structure and is doing it wrong.

several fs implementation I've looked at just do generic_fillattr()
for these fields. Are you saying some FS don't use inode->i_ino at all?
And it's bogus, hence shouldn't be read?

