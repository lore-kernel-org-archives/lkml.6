Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C27C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C827220656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrz07DuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbfAOIsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:48:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34932 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfAOIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:48:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2317238wmt.0;
        Tue, 15 Jan 2019 00:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YNQM8SbAvD4caqNlRyJ+lsvlBhcfmgqwWM2paM5xmDI=;
        b=nrz07DuPB/NHFFWP/XRyRp7h/NuGuSE/uAFDh52iZNqRRBCFwrOomBF5t30+ysPBaS
         GgMoYhOt+05ojFiY1Im6VTyQahSJ8q3Bsse6HhhEGd5WPt0DLHLUN/tdqUA0j8HQV/W4
         MRTNlHUHBG0mnaZSAEM6uOKer3KG7EyG99UEjqrPDnCmnWUxW6yWKNGsXBepsWaxMfUT
         jljPCuA2F+mnzJUQBsvzasfVvvzB4cFEtfIbMDDecbHNSe+X4KAuW3/Ih9MVvprhJNq/
         x6qhNMYvGLf9JAzCb4wlJJy6bnwplqe6yGHBwkfSUE+Vsk3FYUi5QumLASSkuzet6Pfd
         ptyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YNQM8SbAvD4caqNlRyJ+lsvlBhcfmgqwWM2paM5xmDI=;
        b=HfzUwqVMJE7sPbZpKUXv7+0gZBEY6vx5KBJrCd6S24li8zd8nU1koLMGU0yBoOiSWQ
         t17fiE5GuyXjEKDgJhD1JrjPVCNs+EaVpbwnwdAx19N1R00DvMjM+gvaoA70U2bpP1Nf
         yJr+GfKO4MrKxFO6RIxB+P8/Lpr5Kg3K0nJ7oflbLSNRWhJCyvTBmiyOclcZC8GzKH2i
         +vxdbDRW6q56qiWxjtWOCm+lZ1xpBXYVuplh09eeE26Uf59LSHm3a/4wizOfANGNvlYQ
         XkhUrcP+sPslN8cZQFBN9x4VXBeflB7sicMMGtT/3goJG/wIHXrrzt9+WNysPNHVvYQi
         oijg==
X-Gm-Message-State: AJcUukcq509AyqFwDovsXLsG5YvOjl7V23wY1/oxk2TM8KiRynxb/u1f
        sy0ZVo35hwFIKY35vuDlIAI=
X-Google-Smtp-Source: ALg8bN6TeYFPkFwlRdIjDm6G1fy021qD9FXoLVke94GWrIbo3f2qibeUSyBMVfdaO/Jj8OIy49BUZw==
X-Received: by 2002:a1c:e913:: with SMTP id q19mr2420767wmc.55.1547542114407;
        Tue, 15 Jan 2019 00:48:34 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q12sm21204265wmf.2.2019.01.15.00.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 00:48:33 -0800 (PST)
Date:   Tue, 15 Jan 2019 09:48:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Michael Sabolish <sabolish@me.com>,
        Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190115084832.fypbuhyvgfizh3am@pali>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114120023.wkftfz6pwatehpfe@pali>
 <20190114123042.GH13316@quack2.suse.cz>
 <E11914DA-D254-4198-A152-F9D6E61514BE@me.com>
 <20190115083111.qq2mt2p2kn4opwx7@pali>
 <20190115084119.GE29524@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115084119.GE29524@quack2.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 January 2019 09:41:19 Jan Kara wrote:
> On Tue 15-01-19 09:31:11, Pali Rohár wrote:
> > On Monday 14 January 2019 19:07:35 Michael Sabolish wrote:
> > > I can try and make a pull-request for udftune, and I can just copy the API for tune2fs.  It would work something like:
> > > 
> > > udftune -O read-only device            (to set read-only access type)
> > > 
> > > or:
> > > 
> > > udftune -O ^read-only device          (to clear read-only access type (aka set rw))
> > 
> > This API is ambiguous. What does it mean for ^read-only? In UDF you have
> > following access types: overwritable, rewritable, writeonce, readonly,
> > pseudo-overwritable, unknown.
> > 
> > So you would need to know to which R/W access type to switch
> > (overwritable, rewritable, writeonce or pseudo-overwritable).
> > 
> > With information of media type, you could be able to guess correct
> > access type. But for UDF images stored in VFS there is no media
> > information. Also you can have uncommon setup, e.g. usage of CD-R
> > writeonce setup on CD-R/W disc. So "autodetection" of media type would
> > not work always correctly.
> > 
> > So I think that it would be better to have following API:
> > 
> >   udftune --access-type=<new_access_type>
> > 
> > or
> > 
> >   udftune --change-access-type=<new_access_type>
> > 
> > I understand that you would like to have similar API as tune2fs, but UDF
> > settings are too different from ext*.
> 
> If you wanted to follow tune2fs interface, you can have e.g.:

Question is if it is a good idea to follow this interface.

> udftune -E access-type=<foo>
> 
> Another question about the feature is - the access type is actually per
> partition and there can be multiple partitions on UDF media. So I think we
> need to specify the partition number in the command and <foo> has to
> actually be something like <partition number>,<access_type>.

Access type is stored in partition descriptor and in UDF (as opposite of
ECMA-167) you can have only one partition descriptor. IIRC there is some
exception when you have two partition descriptors, but then one have to be
readonly and second virtual.

-- 
Pali Rohár
pali.rohar@gmail.com
