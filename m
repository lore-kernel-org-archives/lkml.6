Return-Path: <p.zabel@pengutronix.de>
X-Google-Smtp-Source: AB8JxZrGYnzidQdeJKEP3L1wLP5kkW1vbn1nPWRbByrLbuBTi1ITwS59nltMxbMDRdjmmIe7d+WL
ARC-Seal: i=1; a=rsa-sha256; t=1524218436; cv=none;
        d=google.com; s=arc-20160816;
        b=SPqrjdjVsYmLBTht/Pi8I9PAnZbLIbmNxVVRVaOSskixtbh244mVP/oiQzMPPZIVk+
         4jujmeUZOYWLSfxUrphDpxe2A2G+MhiWO0xOUP6vXv1xRg9wPgGBhe50qfb2z2rOPiPT
         aicU80/grwSmWQUFEfHo74J/Wb/3EoRaMFH7DAD2GMbXq23M4B1nZzKGus7S+KXDkJ7e
         K/9TislY/ocp53HF8wnrhs2YjpbmD4rif61E7jdAy0wZCTGAQY7Otv3WteN6JKUTfsIq
         hCfVpnL05elUiQhrj9BYT7WUUTuKKjcZN+ImeGQmUrPUu8JwEopjjbE6TRC1ZhJyV2IB
         FjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=aij0oTAXcNvxVT8YNoWZq6Jfj3HtLK4njKslORX1nVU=;
        b=AMrj2sQQjMj19rgShz1eaTwtLYX2N8fF1CUD8FL7DZD84wS4hAwefYfRUuLDbeJIWZ
         9GYIjoMVsC9l7xzUQL908iS/g/1eWBfSrTPnv/o0j+TGZ8soo3tUWfmSPKxvgU4DyuUB
         HTe6RrQiriezc2rD+FszYE29xLG3tEMlrXAuachUSWMQrgJS2QEztTDpLiEX1I7mH5Me
         u9rInqonbbWIBA5ra/VcQKmMnKax1P5TePzVhZ4Le1Mtg5Ne/Ip3QCASv/YOrkOoAabY
         64VT1SdWyQr7XviL79Ga9aD5/Tj5i4WmpgUIZ9x3SiYRX2Rm/6ZVrP29VtWne9R0eun6
         vWMg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of p.zabel@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <1524218419.16259.7.camel@pengutronix.de>
Subject: Re: [PATCH 1/8] drm/mediatek: Use regmap for register access
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
 ulrich.hecht+renesas@gmail.com,  laurent.pinchart@ideasonboard.com,
 ck.hu@mediatek.com, airlied@linux.ie,  robh+dt@kernel.org,
 mark.rutland@arm.com, mturquette@baylibre.com,  sboyd@codeaurora.org,
 lee.jones@linaro.org
Cc: davem@davemloft.net, gregkh@linuxfoundation.org, mchehab@kernel.org,
	rdunlap@infradead.org, pi-cheng.chen@linaro.org, sean.wang@mediatek.com,
	linux-clk@vger.kernel.org, linux@armlinux.org.uk,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
	Matthias Brugger
	 <mbrugger@suse.com>
Date: Fri, 20 Apr 2018 12:00:19 +0200
In-Reply-To: <3fffe06c-f19b-ef26-a19d-771611aae158@gmail.com>
References: <20171114214114.15793-1-mbrugger@suse.com>
	 <20171114214114.15793-2-mbrugger@suse.com>
	 <1511427282.7685.1.camel@pengutronix.de>
	 <3fffe06c-f19b-ef26-a19d-771611aae158@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584079267404697590?=
X-GMAIL-MSGID: =?utf-8?q?1598258871420672542?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matthias,

On Fri, 2018-04-20 at 11:41 +0200, Matthias Brugger wrote:
> Hi Philipp,
> 
> On 11/23/2017 09:54 AM, Philipp Zabel wrote:
> > Hi Matthias,
> > 
> > On Tue, 2017-11-14 at 22:41 +0100, Matthias Brugger wrote:
> > > The mmsys memory space is shared between the drm and the
> > > clk driver. Use regmap to access it.
> > > 
> > > Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  4 ++--
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c  | 30 +++++++++++++++++-------------
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.h  |  4 ++--
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 13 ++++---------
> > >  drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
> > >  5 files changed, 26 insertions(+), 27 deletions(-)
> > 
> > [...]
> 
> [...]
> > >  	}
> > >  
> > >  	value = mtk_ddp_sel_in(cur, next, &addr);
> > >  	if (value) {
> > > -		reg = readl_relaxed(config_regs + addr) & ~value;
> > > -		writel_relaxed(reg, config_regs + addr);
> > > +		regmap_read(config_regs, addr, &reg);
> > > +		reg &= ~value;
> > > +		regmap_write(config_regs, addr, reg);
> > 
> > 		regmap_update_bits(config_regs, addr, value, 0);
> > 
> > Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> 
> Thanks for having a look on that.
> 
> I'll update the next version with regmap_update_bits and leave your Reviewed-by,
> hope that's ok.

Yes, that's fine.

regards
Philipp
