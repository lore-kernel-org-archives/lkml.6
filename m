Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2306EECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC24F20870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAsgiMVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC24F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeJ1QgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:36:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39579 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeJ1QgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:36:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id r9-v6so2417549pgv.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v0pSmNtKEnXMBdOWK7LmCBwi9zGF3A53d3hdljOtgXQ=;
        b=gAsgiMVDOn7lO3zk3Ao/gLGu8JQJFbEFSyD23mzxYyckOS+Hv5i512TmrPmGQVh1UO
         kag4E6HjFOsN3mqO4F3dmXkWOsaFSPdQudIUEtMIMfIqSomxSsdfWathITkHYtXBr1ji
         GC3B/kweP+vsFDwlIPV+QlmPtJwKCSw+Wub8ZWfWG66OpsiMMA3ROScjo94YcBUSVwM9
         YIfEIASXvlmpCjboT/j0xUKC9yhyXBIiFBhexRtyNtCV0aWyh3OTKja501+jdPgPnB5L
         k/U2EgVM9Y4YqRijTgmdti3wzJyPKdhtzocJQjLcdZaPi5skE8VnAi9PXbNzhMI7u9/t
         06Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v0pSmNtKEnXMBdOWK7LmCBwi9zGF3A53d3hdljOtgXQ=;
        b=XaB+AbfxA4sv3ZzPSs4O34kcJoz8z64oS02AMsWko8Xdw7kqcZ2P+8ukMkZDtsh3uP
         QvKefq/uXf7kA3osOe2v62WpbEtlacvvvDTMdrt8BOT+XwjBC3OrhGNmxNlhm6Sve8WP
         XIyyo7xPewJYnfUPotzKcx1vsNEKSvkSk5/Vm9uhKyeYBQOnCpdrzTHtVCpYbEl5Fnn2
         bwXb3h4yyY9Q8B51FoXjlnqQSCEHXlVykmsdJQtKfDDjWU0EBC/eE/ZaDEvvQNY2zljc
         vCL/p0faL9qgB4PZeK0CJpGCpN/i3vqVPoaiQ3drzSrRd2ehA4jLI8evH2+p0yj+NlYT
         4VWQ==
X-Gm-Message-State: AGRZ1gLVvE5YreDPYgFfWUnvPJo457D/n8UtObd6uPRN+y8HGErsW28a
        z10zQsaOh97YyUo9OknR8rM=
X-Google-Smtp-Source: AJdET5et9YPCrcXy+CTMy+7vksi/OSoZMkV22SEM/6ta2RB3bfnzKcVVNHMDcN5qlz1mkbpAdMwRXw==
X-Received: by 2002:a63:907:: with SMTP id 7-v6mr9429705pgj.121.1540713137789;
        Sun, 28 Oct 2018 00:52:17 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id p7-v6sm21182013pfb.101.2018.10.28.00.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 00:52:17 -0700 (PDT)
Date:   Sun, 28 Oct 2018 13:22:10 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [RESEND PATCH 2/2] staging: vboxvideo: Use
 unsigned int instead bool
Message-ID: <20181028075209.GA1938@himanshu-Vostro-3559>
References: <cover.1540580493.git.shayenneluzmoura@gmail.com>
 <211701e4ae42acd95afb24713314bce5a4c58ecf.1540580493.git.shayenneluzmoura@gmail.com>
 <20181026204225.GH2015@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026204225.GH2015@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Fri, Oct 26, 2018 at 04:42:25PM -0400, Sasha Levin wrote:
> On Fri, Oct 26, 2018 at 04:04:45PM -0300, Shayenne da Luz Moura wrote:
> > This change was suggested by checkpath.pl. Use unsigned int with bitfield
> > allocate only one bit to the boolean variable.
> > 
> > CHECK: Avoid using bool structure members because of possible alignment
> > issues
> > 
> > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > ---
> > drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
> > drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
> > 2 files changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/staging/vboxvideo/vbox_drv.h b/drivers/staging/vboxvideo/vbox_drv.h
> > index 594f84272957..7d3e329a6b1c 100644
> > --- a/drivers/staging/vboxvideo/vbox_drv.h
> > +++ b/drivers/staging/vboxvideo/vbox_drv.h
> > @@ -81,7 +81,7 @@ struct vbox_private {
> > 	u8 __iomem *vbva_buffers;
> > 	struct gen_pool *guest_pool;
> > 	struct vbva_buf_ctx *vbva_info;
> > -	bool any_pitch;
> > +	unsigned int any_pitch:1;
> > 	u32 num_crtcs;
> > 	/** Amount of available VRAM, including space used for buffers. */
> > 	u32 full_vram_size;
> 
> Using bitfields for booleans in these cases is less efficient than just
> using "regular" booleans for two reasons:
> 
> 1. It will use the same amount of space. Due to alignment requirements,
> the compiler can't squeeze in anything into the 7 bits that are now
> "free". Each member, unless it's another bitfield, must start at a whole
> byte.

Agreed!

FYI original thread of discussion: https://lkml.org/lkml/2017/11/21/207

As Steve says:

"Thus, changing:

 int  a : 1;
 int  b : 1;
 int  c : 1;
 int  d : 1;

to

 bool a;
 bool b;
 bool c;
 bool d;

at best increases the size required from 1 byte to 4 bytes, and at
worse, it increases it from one byte to 16 bytes."

In the above cases, we have all bitfields members and no non-bitfields
members.

But before playing with these bitfields there are some points to be
noted:
https://port70.net/~nsz/c/c11/n1570.html#J.3.9

Implementation Defined
----------------------

* Whether a ''plain'' int bit-field is treated as a signed int 
  bit-field or as an unsigned int bit-field.

eg: `int foo:3` may have a range from 0..7 or -4..3

So, changing `int foo:3` to `unsigned int foo:3` might be a sane
change to remove the ambiguity and make sure range is 0..7.

Also, such an change can also handle unsigned overflow
or better said "wrapping".

* Whether a bit-field can straddle a storage-unit boundary.

So, you can't guess what could be the possible unless you're familiar
or tested the change for different arch.

* The alignment of non-bit-field members of structures.

...

The "possible alignement issues" in CHECK report is difficult to figure
out by just doing a glance analysis. :)

Linus also suggested to use bool as the base type i.e., `bool x:1` but
again sizeof(_Bool) is implementation defined ranging from 1-4 bytes.

And since this issue is added to checkpatch now, very likely there would
be blast of patches sent on the same.

Not everyone who sends checkpatch would be able to disassemble or test
on different implementations.

But if anyone is interested check this:
https://godbolt.org/


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
