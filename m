Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AIpwx49iOWVnyPSh85lnUJDgqfAkfbOvNvOn19d+FHlVwezez5QMzQ32yNaqmYLbtbh4hyrk8775
ARC-Seal: i=1; a=rsa-sha256; t=1523368204; cv=none;
        d=google.com; s=arc-20160816;
        b=pQAetcT1etSq6NiBdNvSyefg6ZRIPuM0VFAtF7QaCnBeMa3r/vACYnTzjA5U1GLcnW
         SL08I5OCmPsqgndoIJBaguhwo6t9XfYZ4gmUzNnq3lN35xCoQP6V0ZyhwXI+EoczU62N
         1vOSOSC2+w93jqkqa9uPHYwF/j2pxQPf9bvmXs1cn9u9UxFR6TYJ1v3AIXpujihWhDxt
         BexhH25LJOwLP9ELjOfq9LQuoFwYePJiPdRqN+a7LPSTkR3pVub2qHJKn5xlxt3qNdKn
         JrYSL/UIhcroko67N6zIEyWSy6rgVcBgbnTnwyTtHk9jXmm7E6EjYrlGcFJyqN3IwSlH
         w9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=/r76roiQRDZ37AsKWx8/D79uGF6u8fiQMuSoR1n71oE=;
        b=mskFMH1ow9nDb8XjJcLmp4TFX/f0NvtFDW4nrs79fKEKvgZ3jyosQnyy0Bhh6pqlki
         u5dmQ32B8JvyVhCFcSp3ZIHOj6bkhb6AnwsURg/s0IovWNCyxXGiTsQh40vB6epEqJ6/
         qfW8dAm867FAOw8zKx1w9gf6zo9z6tcJQ8dY6NmMt26tFcpkhOfe7NgQDpl1Cy8KNMzd
         1gfVVOTVVaK2nP9ZnJK3dNvIBd/8xl9dEoBH2yGwYC0otMUuSbvJrbT76lHvIephPEuC
         /UramybTMV6nLgKSW1h3UxA7TMphS5x/y73nei4eQGGHJ/h9Da12QQm3l1Ln0erkDyMg
         MXZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Tue, 10 Apr 2018 14:49:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>,
	<linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	"Lars-Peter Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, "Mark Rutland" <mark.rutland@arm.com>, "David S. Miller"
	<davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, Michael Hennerich
	<michael.hennerich@analog.com>, Phil Reid <preid@electromag.com.au>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: add current-sense-cuicuit
 and voltage-divider
Message-ID: <20180410144946.00004552@huawei.com>
In-Reply-To: <20180410131338.k744yajxspiaqwn4@rob-hp-laptop>
References: <20180403153635.8228-1-peda@axentia.se>
	<20180403153635.8228-2-peda@axentia.se>
	<20180408175031.4945e2d7@archlinux>
	<20180410131338.k744yajxspiaqwn4@rob-hp-laptop>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739881382169628?=
X-GMAIL-MSGID: =?utf-8?q?1597367337660865441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 10 Apr 2018 08:13:38 -0500
Rob Herring <robh@kernel.org> wrote:

> On Sun, Apr 08, 2018 at 05:50:31PM +0100, Jonathan Cameron wrote:
> > On Tue,  3 Apr 2018 17:36:34 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> > 
> > circuit in the patch title is spelled wrong.
> >   
> > > An ADC is often used to measure other quantities indirectly. These
> > > bindings describe two cases, a current through a sense resistor, and
> > > a "big" voltage measured with the help of a voltage divider.
> > > 
> > > Signed-off-by: Peter Rosin <peda@axentia.se>  
> > 
> > Will definitely be wanting wide opinions on this one - Rob in particularly
> > for the binding side.
> > 
> > One comment inline. What we have here is nice and generic, but is
> > it what would be 'expected' for current sense circuit?  Should we
> > also be more specific in the naming.  There are lots of options for
> > current sense circuits and this is just the simplest (current loop
> > for example).
> > 
> > One option would be to use current-sense-shunt perhaps?
> > 
> > https://en.wikipedia.org/wiki/Current_sensing_techniques
> > Gives a few that I didn't think of beyond current loops etc.
> > 
> >   
> > > ---
> > >  .../bindings/iio/afe/current-sense-circuit.txt     | 45 ++++++++++++++++++++++
> > >  .../bindings/iio/afe/voltage-divider.txt           | 45 ++++++++++++++++++++++
> > >  MAINTAINERS                                        |  7 ++++
> > >  3 files changed, 97 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> > >  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> > > new file mode 100644
> > > index 000000000000..0bc7d89387c0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> > > @@ -0,0 +1,45 @@
> > > +Current Sense Curcuit
> > > +=====================
> > > +
> > > +When an io-channel measures the voltage over a current sense resistor,
> > > +the interesting mesaurement is often the current through the resistor,
> > > +not the voltage over it. This binding describes such a current sense
> > > +curcuit.
> > > +
> > > +Required properties:
> > > +- compatible : "current-sense-circuit"
> > > +- io-channels : Channel node of a voltage io-channel.
> > > +
> > > +Optional properties:
> > > +- numerator : The io-channel scale is multiplied by this value (default 1).
> > > +- denominator : The io-channel scale is divided by this value (default 1).
> > > +
> > > +Example:
> > > +The system current is measured by measuring the voltage over a
> > > +3.3 ohms sense resistor.  
> > 
> > Hmm. It sort of feels like the binding doesn't really reflect the
> > hardware as directly as it might.   Should we be explicitly having the
> > resistance in this case?  (with some more mapping logic needed in the
> > driver to figure out the scaling this causes).  
> 
> I think having the resistance would be better as least in this case. For 
> other cases like voltage dividers I'm not sure though. Those would be 
> different compatibles so the associated properties don't necessarily 
> need to be the same.

Agreed, that was my thought as well.  Given with divider it really is the
ratios that matter, I'd keep it defined in terms of them.  We'll have
some slightly interesting bindings to interpret to get to what matters
internally, but I don't think that will be too bad.

So nicer bindings at the slight cost of driver complexity.  Sounds fine
to me!
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
