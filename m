Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBACC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDBA2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvLUns0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDBA2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeINDMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:12:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40738 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeINDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:12:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id n2-v6so8302647wrw.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=golBgE3OWJfANA4Cb9GGvuo39/Fbuzy8PVgvnBVygEw=;
        b=EvLUns0VVCSaFmoIenO0yO/E/2jDPbQGeiUbiNymyLw/Ub79XIB64TsLwdrDCD/8Ti
         YbvZF29hlhwZHrJhwQe8kmrsdeb1TbHae4lEH24dWVaZpYKbqxF6M3VXMCFDow0l/Ksi
         PxmwoigB4QKsY1Nwdp0B0zPXPArpMOxXN8CpLTGuI+Sq3xoH2s3pQGYnWWSoArAjN+No
         a9E4dCdAqL+cXs5ctmYf09kTSqP9VRVXY4Hhfs8DITgA4gP0M/12MDLuItSiPN3wkcSP
         hCYi0O4I9c5cvIRb2jjdEWbP/YVn0JRmP+oMlyS3rEm4cNKbwB5AZz3i4m/TRAXcd8mI
         LnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=golBgE3OWJfANA4Cb9GGvuo39/Fbuzy8PVgvnBVygEw=;
        b=khhFvxXSSYFtUL2n8sCQMarr3k8J/E7cpGb6U7BP51PnmAwxdBUo8CdiqT88G73+y3
         achJspBuvhs9JJHuVwE5PDLASCeF8POW7VdRLjevGvr/x07YBVsbjxdf0pS9deepMOBj
         9lFELR0j7LKTAXkYOHiuyWvobC3CuT6nRokcAd/6Ku2fgQYbDnVYFkiAXK2+H7q+cM3W
         xahhgglVcBGU+o+aLUPwDSXIZN0d7U+i5qWHQ4opaARHmY4He7k2jEgGcu37gbZ5qRrv
         RXiOHHXHkTNsK6tvXwLH/77sCMyvPQWCqfC1BvkXUbusEj0B10gBkOih+wg5e0B+GzR0
         w9xA==
X-Gm-Message-State: APzg51DxVkXzOl9nLqd4glYGNFQUUR+YrZ/o+tbBhVDROT+0jqqfnZMz
        WgGadlt6tnTiiyUsVEYrEBD+y8w=
X-Google-Smtp-Source: ANB0VdZi/srcIU2zXARyQJ5iTSpwQRD3pDgM2JWSh4c4qp/PwBeXjuKG1SxZ0+tel8aCc3xJ8LidGw==
X-Received: by 2002:a5d:6550:: with SMTP id z16-v6mr6965319wrv.194.1536876087008;
        Thu, 13 Sep 2018 15:01:27 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id 132-v6sm26905wmd.13.2018.09.13.15.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 15:01:26 -0700 (PDT)
Date:   Fri, 14 Sep 2018 01:01:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC] UAPI: Check headers by compiling all together as C++
Message-ID: <20180913220124.GA12570@avx2>
References: <20180905185922.GA25461@avx2>
 <20180905192636.GA13608@kroah.com>
 <20180905193111.GA27217@avx2>
 <20180905222247.GT19965@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180905222247.GT19965@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 11:22:47PM +0100, Al Viro wrote:
> On Wed, Sep 05, 2018 at 10:31:11PM +0300, Alexey Dobriyan wrote:
> > On Wed, Sep 05, 2018 at 09:26:36PM +0200, Greg KH wrote:
> > > On Wed, Sep 05, 2018 at 09:59:22PM +0300, Alexey Dobriyan wrote:
> > > > > On Wed, Sep 05, 2018 at 04:54:27PM +0100, David Howells wrote:
> > > > > > 
> > > > > > Here's a set of patches that inserts a step into the build process to make
> > > > > > sure that the UAPI headers can all be built together with C++ (if the
> > > > > > compiler being used supports C++).  All but the final patch perform fixups,
> > > > > > including:
> > > > > 
> > > > > Wait, why do we care?  What has recently changed to start to directly
> > > > > import kernel uapi files into C++ code?
> > > > 
> > > > I think David is seriously trying to compile kernel with C++ compiler
> > > > and this is first step.
> > > > 
> > > > He isn't alone. Resistance is futile. :^)
> > > 
> > > "struct class" is going to be a hard one to overcome :)
> > 
> > "struct class" makes you hostis publicus #1 of the Linux++ empire. :^)
> 
> Don't tempt me...

<= g++-8 doesn't support C99 style initializers.
g++-8 mostly does: for example

	.foo = {
		[BAR] = 1,
	},

doesn't work, but regular .foo = 42 does.
Additionally, g++ makes noise about order of initializators.
C++20 is supposed to make things better.

g++ supports -fpermissive which is a blessing.

clang doesn't support -fpermissive which makes everything way more
tedious and it has problems with alternatives (and IIRC vdso code).

Now with gcc version bumped recently I think __attribute__((cleanup))
is supported which makes destructor-like behaviour possible:

	with_spinlock(&p->l) {
		return 0;
	}

	with_mutex(&m) {
	}

	with_rcu() {
	}
