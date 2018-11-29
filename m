Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F46C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C558A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L1ecJF3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C558A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeK3IXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:23:15 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35924 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeK3IXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:23:15 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CB19410C07B3;
        Thu, 29 Nov 2018 13:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543526189; bh=jSWGDtnuZikYt/TErXicMXsZUhz6K+l15eXWL0s6+ho=;
        h=From:To:CC:Subject:Date:References:From;
        b=L1ecJF3CsbDIvopyVhbpG9n0pBM0Pwsjs94wDTyY5nQu2m0sOhGWIWEOWN/O7DThA
         /JH7EaN1G5E2K7HA0ddB2qbfpl8mRVC+gUimG9FWF9AYrqop8gdbb7L183nH7O//WU
         sTtf/6LfX3jJ0TkLdYrH20EJu7TLK7tZrvhGB/lbUyPmFtMsEXF9+dKSXaallDvcon
         c2i6XNAV/iCfLQQBDed6+nIXsNpuA5IZ3QryGlsqX8Kxr2R3TXcj3ab0ouvvO6YjJv
         n1s6iEJifrZzfwr7dFXGlBKbNELCi+p/mwx/tv9OcSHruZAzlyEwjeovJbLl7x4tDO
         xeH+KxiZ6DhKQ==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8352E3D85;
        Thu, 29 Nov 2018 13:16:29 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Thu, 29 Nov 2018 13:16:29 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Jose Abreu <jose.abreu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+/oo0RKKbidaU63fw0ncGEK7A==
Date:   Thu, 29 Nov 2018 21:16:29 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146419EBB@US01WEMBX2.internal.synopsys.com>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 6:29 AM, Jose Abreu wrote:=0A=
> Some ARC CPU's do not support unaligned loads/stores. Currently, generic=
=0A=
> implementation of reads{b/w/l}()/writes{b/w/l}() is being used with ARC.=
=0A=
> This can lead to misfunction of some drivers as generic functions do a=0A=
> plain dereference of a pointer that can be unaligned.=0A=
>=0A=
> Let's use {get/put}_unaligned() helper instead of plain dereference of=0A=
> pointer in order to fix this. =0A=
=0A=
Please add a few lines of comment about what the accessor does in general -=
 maybe=0A=
copy-paste from generic file if needed.=0A=
=0A=
> +#define __raw_readsx(t,f) \=0A=
> +static inline void __raw_reads##f(const volatile void __iomem *addr, \=
=0A=
> +				  void *buffer, unsigned int count) \=0A=
> +{ \=0A=
> +	if (count) { \=0A=
=0A=
Could you reduce 1 level of indentation by checking for !count and return.=
=0A=
=0A=
> +		const unsigned long bptr =3D (unsigned long)buffer; \=0A=
> +		u##t *buf =3D buffer; \=0A=
> +\=0A=
> +		do { \=0A=
> +			u##t x =3D __raw_read##f(addr); \=0A=
> +\=0A=
> +			/* Some ARC CPU's don't support unaligned accesses */ \=0A=
> +			if (bptr % ((t) / 8)) { \=0A=
=0A=
This math is loop invariant so instead of using bptr here, have something l=
ike=0A=
is_aligned =3D (unsigned long)buffer % ((t) / 8)) outside the loop. A reaso=
nable=0A=
compiler already does that but this one is easier on eyes.=0A=
=0A=
> +				put_unaligned(x, buf++); \=0A=
> +			} else { \=0A=
> +				*buf++ =3D x; \=0A=
> +			} \=0A=
> +		} while (--count); \=0A=
> +	} \=0A=
> +}=0A=
=0A=
Per your later post the compiler is doing the good job here, but sometimes =
it=0A=
might not. Adding a condition inside a loop is not a good idea in general. =
Better=0A=
to code the 2 loops seperately.=0A=
=0A=
> +=0A=
> +#define __raw_readsb __raw_readsb=0A=
> +__raw_readsx(8, b);=0A=
=0A=
The trailing ; is not needed=0A=
=0A=
> +#define __raw_readsw __raw_readsw=0A=
> +__raw_readsx(16, w);=0A=
> +#define __raw_readsl __raw_readsl=0A=
> +__raw_readsx(32, l);=0A=
=0A=
> +=0A=
>  #define __raw_writeb __raw_writeb=0A=
>  static inline void __raw_writeb(u8 b, volatile void __iomem *addr)=0A=
>  {=0A=
> @@ -126,6 +155,32 @@ static inline void __raw_writel(u32 w, volatile void=
 __iomem *addr)=0A=
>  =0A=
>  }=0A=
>  =0A=
> +#define __raw_writesx(t,f) \=0A=
> +static inline void __raw_writes##f(volatile void __iomem *addr, \=0A=
> +				   const void *buffer, unsigned int count) \=0A=
> +{ \=0A=
> +	if (count) { \=0A=
> +		const unsigned long bptr =3D (unsigned long)buffer; \=0A=
> +		const u##t *buf =3D buffer; \=0A=
> +\=0A=
> +		do { \=0A=
> +			/* Some ARC CPU's don't support unaligned accesses */ \=0A=
> +			if (bptr % ((t) / 8)) { \=0A=
> +				__raw_write##f(get_unaligned(buf++), addr); \=0A=
> +			} else { \=0A=
> +				__raw_write##f(*buf++, addr); \=0A=
> +			} \=0A=
> +		} while (--count); \=0A=
> +	} \=0A=
> +}=0A=
=0A=
Same as for read !=0A=
=0A=
> +=0A=
> +#define __raw_writesb __raw_writesb=0A=
> +__raw_writesx(8, b);=0A=
> +#define __raw_writesw __raw_writesw=0A=
> +__raw_writesx(16, w);=0A=
> +#define __raw_writesl __raw_writesl=0A=
> +__raw_writesx(32, l);=0A=
=0A=
Ditto !=0A=
=0A=
