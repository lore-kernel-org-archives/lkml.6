Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2413C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699912154F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="quMHuXUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 699912154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeHQRmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:42:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeHQRmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:42:05 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562E12154F;
        Fri, 17 Aug 2018 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534516708;
        bh=PIfVKUqQ7c7J/cSPpRKe+aAWBT5q3U/be6mA9Oel6uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quMHuXUa1wr7ahSL669I2XTLuFdfpC/rfOwfKcdIlmgao0xMx9eSOWGXt43B7cqZk
         JDK/pPSphcQIlxc3AOJ0eDcN2dvbRSHXL6WA63PN7SH6QWLgpNjM9HKI3Tv1qhKS8F
         NlGmq7d6YbofaRRsjrZ9s+Wy+dhOn/5ZNPXuKQZQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 71AB5141C3A; Fri, 17 Aug 2018 11:38:25 -0300 (-03)
Date:   Fri, 17 Aug 2018 11:38:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     dwarves@vger.kernel.org, Dodji Seketeli <dodji@redhat.com>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: pahole v1.12 (BTF edition)
Message-ID: <20180817143825.GA22443@kernel.org>
References: <20180816200942.GA19939@kernel.org>
 <nycvar.YFH.7.76.1808162328040.2839@n3.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1808162328040.2839@n3.vanv.qr>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 16, 2018 at 11:49:38PM +0200, Jan Engelhardt escreveu:
> On Thursday 2018-08-16 22:09, Arnaldo Carvalho de Melo wrote:
> 
> >	After a long time without announces, here is pahole 1.12,
> >available at:
> >
> >	https://fedorapeople.org/~acme/dwarves/dwarves-1.12.tar.bz2
> >
> >	git://git.kernel.org/pub/scm/devel/pahole/pahole.git	
> >
> >	Some distros haven't picked 1.11, that comes with several
> >goodies, my bad for not having announced it at that time more widely,
> 
> Missing announcements can be forgiven. But there are automatic tools 
> that scrape the web for updates (usually something tries to scan
> the enclosing directory of the last known URL), so uploads are 
> essential.
> Since 1.11 was never uploaded, it did not find its way..
> (One had to grab a tarball gitweb generated from the tag,
> but had to know there was a 1.11, too).
> 
> 
> Can we have signatures for the release tarballs?
> (Only if you think it's worth having.)

Yeah, I think I can create a file with sha256 for the tarball and sign
it, just like I signed the v1.12 tag:

  https://git.kernel.org/pub/scm/devel/pahole/pahole.git/tag/?h=v1.12
 
> >Please report any problems to me, I'll try and get problems fixed.
> 
> Here's one (or six):

Yeah, C++ has been a second class citizen for all pahole's life, with
progress being made mostly when I collaborate with folks at the ATLAS
project at CERN that had tons of C++ code being ported from 32-bit based
clusters to 64-bit ones.

I'll try to work some time on the reports below to see if we get a bit
more progress there.

> $ cat x.cpp 
> #include <utility>
> struct F {
>         template<typename T, typename... A> F(T &, T &&, A &&...x) { }
>         F clone() const && { int q; return F(q, 3, 4); }
>         int xpub() { return xprot(); }
>         protected:
>         int xprot() { return xpriv(); }
>         private:
>         int xpriv() { return 0; }
> };
> int z;
> F f(z,2,3,4);
> int main()
> {
>         f.xpub();
>         std::move(f).clone();
> }
> 
> 
> $ g++-7 x.cpp -c -ggdb3 -Wall && pahole x.o
> die__process_function: tag not supported 0x2f (template_type_parameter)!
> //expected: handle type
> die__process_function: tag not supported 0x4107 (GNU_template_parameter_pack)!
> //expected: handle type
> die__process_function: tag not supported 0x4108 (GNU_formal_parameter_pack)!
> //expected: handle type
> ftype__recode_dwarf_types: couldn't find 0x321 abstract_origin for 0x397 (formal_parameter)!
> //expected: handle type
> ftype__recode_dwarf_types: couldn't find 0x326 abstract_origin for 0x39f (formal_parameter)!
> ftype__recode_dwarf_types: couldn't find 0x3e0 abstract_origin for 0x447 (formal_parameter)!
> struct F {
>         class F clone(const class F  *);
> 	//expected: "struct F clone(const struct F *&&);"
> 
>         int xpub(class F *);
> 
> protected:
> 
>         int xprot(class F *);
> 
> private:
> 
>         int xpriv(class F *);
> 
> //expected: "public:"
> 
>         void F<int, int, int>(class F *, int &, , , );
> 	//expected: "void F<int, int, int>(struct F *, int &, int &&, int &&, int &&);
> 
>         void F<int, int>(class F *, int &, , );
> 	//expected: "void F<int, int, int>(struct F *, int &, int &&, int &&);
> 
>         /* size: 1, cachelines: 0, members: 0 */
>         /* last cacheline: 1 bytes */
> };
