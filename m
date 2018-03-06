Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AG47ELtbYJGG3Hdlm3/8fA1UJ1HXXIDswyYrI0QR+QINgw5qTb3Sjo63DM/DJ+xOHUqwZBRvKs9Y
ARC-Seal: i=1; a=rsa-sha256; t=1520340867; cv=none;
        d=google.com; s=arc-20160816;
        b=BvGMLYGNSorr7H69jhOuCARCbrI8NeQz5gHBOTs8ur31ldnImgXmsLq1NSCKgDLKrc
         BazXUVutnj5baTlURlVQ6KOLs/OL1XIS+dIW0MDPlpcLEYyXD/WZCFCTvY4ZHiBggjcr
         4rMynQMQRPE9FBjNAigtSQjJQZ0F6N1FZk5NBearbzB/0Nixsd4w5IWJ4zQ90yRrO0rl
         T7PIZhDlbkg3MC0Kn4uApPo/KBIiqRnTYcUqGVBrE28VzmE31Idpkd35G043mkQCxo0c
         7djMdHGxEZ/Tbl22u+45dGuC52ywCXvLAZUBTlycyUDzIov2B1uLdTN/YA9dG8UpNOk0
         EQhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=4XjN1FqWqFQw+W5dMaTG1VEhOhpMTdjmEPTtCVq2FAQ=;
        b=ZKuDUR9olSRbKRXNAJ2aWPJV1Pks1E5RT9XL31cS5CnXRR3r5ay1n7ik8PF9AR6aia
         e2IwMYr9C8RehCemssJPj8ZxxdkmG3tH1Z47IFT2G1oVNGaAy1ogQRtqUck3ryw+BTFt
         9r0+JUuVFLhrSOnLEGgyS5WisuD54irl299IolzqiJ/2W6KBX/rJunYd+z0G7og9mU+q
         Mk7lWvfGPJb2QyypZV4pbOERJugeH7J76b6QR6+KYXq0DZYB2x6q3Up1nxiFM49Jw2vh
         eW0Am6rSJfXgFxsTSHw/W5iNsNAj+kGX/h8twq33Z3pD9GOb8zcEQLJsWEFcEi0aBBIF
         GWcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=MQjnCwZ4;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=MQjnCwZ4;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Tue, 6 Mar 2018 13:54:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Pavel Machek <pavel@ucw.cz>
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, joel@jms.id.au,
	andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
	jdelvare@suse.com, linux@roeck-us.net, benh@kernel.crashing.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
Message-ID: <20180306125416.GD26143@lunn.ch>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306124002.GA13950@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1594192944974091541?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 01:40:02PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> > ---
> >  .../devicetree/bindings/peci/peci-aspeed.txt       | 73 ++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.txt b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > new file mode 100644
> > index 000000000000..8a86f346d550
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.txt
> > @@ -0,0 +1,73 @@
> > +Device tree configuration for PECI buses on the AST24XX and AST25XX SoCs.
> 
> Are these SoCs x86-based?

ARM, as far as i can tell. If i get the architecture correct, these
are BMC, Board Management Controllers, looking after the main x86 CPU,
stopping it overheating, controlling the power supplies, remote
management, etc.

    Andrew
