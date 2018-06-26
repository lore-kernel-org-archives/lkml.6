Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C18C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A1DC26D50
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 19:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1DC26D50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eso.teric.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeFZTI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 15:08:26 -0400
Received: from eso.teric.us ([69.164.192.171]:59628 "EHLO eso.teric.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbeFZTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 15:08:24 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jun 2018 15:08:24 EDT
Received: from neo.teric.us (neo.teric.us [198.58.100.135])
        by eso.teric.us (Postfix) with ESMTPS id 6705A1036E;
        Tue, 26 Jun 2018 13:59:00 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eso.teric.us;
        s=mail; t=1530039540;
        bh=u0EoG65BWuYx4wB7/fi9WqtQerA8g5/L0RbQ/i+5wMI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaX8lUzySQY1bKmb4huRh3JFzH1y2+KYAYUPW5sqFPWQB+mJXKJIEYmrv7tKPe0M0
         6ycinEqQZjoujBKdpT6HbDro8Zs+fqZpmWzBedx0wrQBspGfdsHr7ioFaW2bwdzLNe
         khjpEZshndzAB7rTHBrgXJhQrg15zP7hQFx3ptQkXSQtmG3NXSZA3jlsgkJkxJJ9Ji
         APknXlekhGceqzWDX2nbO418Jyzdt7h5wqes1093fKBO7DFbxBCSQpB8Ui+Aa4aXLb
         EI7HPCvpgPi2igG+lrm9KkmF4QyEsRrvzicREkgE26fwGLHxA8BPKWZvTHqkiEyfVV
         UfofQLTCLYmgg==
Received: by neo.teric.us (Postfix, from userid 1002)
        id 2AFE326665; Tue, 26 Jun 2018 13:59:00 -0500 (CDT)
Date:   Tue, 26 Jun 2018 13:59:00 -0500
From:   Julia Cartwright <juliac@eso.teric.us>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        artlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: simple-framebuffer enquire
Message-ID: <20180626185900.GA20755@kryptos.localdomain>
References: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
 <9fb661e6-482b-76e0-2af0-a62a70e5606d@redhat.com>
 <CAOf5uwk2cf_+27nk9i9MQmbfJ8LCfPYopkcX__9M64jMYmhu1A@mail.gmail.com>
 <CAOf5uwkEuDgAJ7e8rNFyiKpUZPA3NhQGREtOGsm1EVSofW3rzQ@mail.gmail.com>
 <233d6808-4d44-9e47-7e3f-4f35cf731706@redhat.com>
 <CAOf5uwkJimhGJd_BtUuDyxaD5-ZYGe3JZtgC4pDKc_jnvaV21g@mail.gmail.com>
 <CAOf5uwnVoXw1MA=n3vphMhtto=fc+NVf11idLF8nwC6JCvf4+A@mail.gmail.com>
 <7b996681-3a94-1f93-10c0-5369fe843cbc@redhat.com>
 <CAOf5uwmxZxxKG0CnstnNaTYdt-1+=YZHr8eSac5TdwfANdobxQ@mail.gmail.com>
 <996603c6-9779-7412-d998-bd7b49194490@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996603c6-9779-7412-d998-bd7b49194490@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 08:44:58PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 26-06-18 18:35, Michael Nazzareno Trimarchi wrote:
[..]
> > cat memblock/reserved
> >     0: 0x80004000..0x80007fff
> >     1: 0x80100000..0x81e030b3
> >     2: 0x83000000..0x83007fff
> >     3: 0x84000000..0x85ffffff
> >     4: 0x86fa2000..0x87021fff
> > 
> > +       reserved-memory {
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               display_reserved: framebuffer@86fa2000 {
> > +                       reg = <0x86fa2000 0x80000>;
> > +               };
> > +
> > +       };
[..]
> > Still have the same on ioremap.
> 
> Hmm, I guess the kernel does map the entire region its get
> passed and simply makes sure to not touch the reserved mem,
> where as with the changes to the passed in mem-region the
> sunxi u-boot code does the memory does not get mapped by
> the kernel at all ?

If the intent is to reserve memory _and_ prevent it from being included
in the kernel's linear map, then it is also necessary to include the
'no-map' property for this reserved-mem node.

From Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt:

   no-map (optional) - empty property
       - Indicates the operating system must not create a virtual mapping
         of the region as part of its standard mapping of system memory,
         nor permit speculative access to it under any circumstances other
         than under the control of the device driver using the region.

    Julia
