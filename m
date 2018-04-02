Return-Path: <sean.wang@mediatek.com>
X-Google-Smtp-Source: AIpwx48rcSCKqcs8291K6iNmQhooRstKxK+aiRQRQqekiKZx3Yq7WiP3FYjNEzLmjnEqFnZDQfzb
ARC-Seal: i=1; a=rsa-sha256; t=1522638260; cv=none;
        d=google.com; s=arc-20160816;
        b=0xKyqpjLgLOc7moy7GPsSM9+rXrncAlKkVt+VkPwYbwnP1Eub4fLCGqQ3Dbud9yHMA
         Hgze1nmyY+mSxZTAB1CgQBxOu2GrxHIAJFPqrFy6cIQj3i2i0qGbkN0ucuQ8uj+voJlZ
         R1JF9EbIKe8eN9bfCp7LtPou9aefgN0NKjArOv6GVaDu+PReqp0hz2Hu6c/Y2H6xUGCM
         TJVpYzq83N8oYYQKQ+/+Ir7prJMTicr3AYlXimyJjDy/u0EQsPOOjqQW7gCaZIDwh6yr
         Krd/kal3fLykZPJCEzercxCugGpKJsGhlLgr97SI+B4XfLRErfUsqbE633yDaAjZUEkC
         d28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=qNTqID5ZIfm8meWHm2ruK2PyPAfp55VaAwavz3Mk+J0=;
        b=kpSuZz7VeGj4YxOUb3pSa2URzHMnY0wiACea5Fwxe0KIERLyCOnmaqEREsq7tDJYr4
         hHYhlFC2fUtHxGzF0e98pMAz6TmVbjfSVDvbo79Qn1sVR2QaALsC8jdnn+dPG1SvRL4c
         QjTOLmMe3+BB8aSTr9Zpfw9JsSackIRZXJBB7M36GAysryBQrFhQ+BTmoth3VF84JXia
         gXlxG68mOMe8uJlH8ZibSBzW1JQN/IC7vQWatVNTOs5oBtHwZgxRfR0jKBvjVWx0eBJT
         3ut/KtbSPBMJL9fbVTDK95dXrrFdDG4T43ku0MFRqqvbpLu56iD52rQq7JdZKa0IOdYx
         f2tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sean.wang@mediatek.com designates 210.61.82.184 as permitted sender) smtp.mailfrom=sean.wang@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sean.wang@mediatek.com designates 210.61.82.184 as permitted sender) smtp.mailfrom=sean.wang@mediatek.com
X-UUID: e22dedfa3e574ca98adc252ea6956da2-20180402
Message-ID: <1522638255.18424.44.camel@mtkswgap22>
Subject: Re: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
From: Sean Wang <sean.wang@mediatek.com>
To: NeilBrown <neil@brown.name>
CC: Chris Coffey <cmc@babblebit.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	<devel@driverdev.osuosl.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date: Mon, 2 Apr 2018 11:04:15 +0800
In-Reply-To: <87vada1owt.fsf@notabene.neil.brown.name>
References: <20180329095637.GA16778@kroah.com>
	 <20180329124745.24694-1-cmc@babblebit.net>
	 <87vada1owt.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23758.004
X-TM-AS-Result: No-21.392200-8.000000-10
X-TMASE-MatchedRID: L8tZF6zWW2r4OiVTWoD8RCa1MaKuob8Pt3aeg7g/usCe9toQ6h6LEwpB
	K2hUihAXadgG7kzTAhSwiqg6QcdK5wDBaeVuVh0C9Ib/6w+1lWQAHmJpemgWrl9I8oY/f0KuJDk
	GkQuDnwMZYxhOyN53UwBCe/zihxdXULNUje/+PyDISPeZE8elXsMdI0UcXEHzh8BhJvgqWBl4oU
	XbKg7So+GR/MGrL4SXKaAgIi2Kz7o1GNNcYTZ3yO9VsdrlGzy3dZPoD9V2prSbKItl61J/ycnjL
	TA/UDoASlnU38LCY8vkwjHXXC/4I5BlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.392200-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23758.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596276317072561882?=
X-GMAIL-MSGID: =?utf-8?q?1596601936429258743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-04-02 at 09:34 +1000, NeilBrown wrote:
> On Thu, Mar 29 2018, Chris Coffey wrote:
> 
> > This fixes the following sparse warning:
> >
> > drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
> > 'mtk_set_ethtool_ops' was not declared. Should it be static?
> >
> > Signed-off-by: Chris Coffey <cmc@babblebit.net>
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> Thanks,
> NeilBrown
> 
Hi, Neil

Forgive me I cannot find the cover letter in the original series in my
mailbox to make a reply, so I rudely made here just letting you know
something good to the growth of mt7621 support in upstream.

do you have maintained an out-of-tree branch to boot the mt7621 machine
with those staging patches?

If so, it would become a bit easier for me that maybe I could give a
hand for migrating these staging driver for mt7621 to mainline. I
thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
current mainline code.

	Sean
> 
> > ---
> > Changes in v2:
> >  - Per GregKH's feedback (thanks!), don't add unnecessary new .h file
> >  dependencies. This patch version reverts those changes and fixes the
> >  problem directly in ethtool.c (which is that it didn't include
> >  ethtool.h anywhere -- mtk_set_ethtool_ops is not static).
> >
> >  drivers/staging/mt7621-eth/ethtool.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
> > index 38ba0c040a..5268c5ca09 100644
> > --- a/drivers/staging/mt7621-eth/ethtool.c
> > +++ b/drivers/staging/mt7621-eth/ethtool.c
> > @@ -13,6 +13,7 @@
> >   */
> >  
> >  #include "mtk_eth_soc.h"
> > +#include "ethtool.h"
> >  
> >  static const char mtk_gdma_str[][ETH_GSTRING_LEN] = {
> >  #define _FE(x...)	# x,
> > -- 
> > 2.11.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
