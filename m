Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx4+PFWX9HgNjsLYZGCIdWMDQfuAHe5/HL6ME2enobESxShmmQJzLp6Rx+50hZ8uJoO1FypHs
ARC-Seal: i=1; a=rsa-sha256; t=1522845772; cv=none;
        d=google.com; s=arc-20160816;
        b=lEBPhp0JNWP4vxhCJI77wirWhUbYS/4UjUohiPNHBwleNF1nQ1rEHetqS0wdZvsfUW
         lLDhGnlAUHLPcY2nh3w92ZS3lSpIr4fBOiNSLNpp5/AUDXgqGSj+sYPBexL7oQ8LG8FI
         hUO0eVRmE9lujYfL0qEZQuEYDcOQQZQHFrFRM/K6J1KwlA076Jxrfn6m418iNIKSk1kb
         owCXwONfq8GHHjd6iwR9hgLvjMbhUnSNaiRNcddWYxEvEtoRonKTA2QALBqnjJ1Ofhef
         2L9+/zbwMO3s2uB6Ga851+KZAhBuXlL7kN1MsVwXKSj0XJtHwxSi5hCOdmvCi0M/jlyJ
         /dkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=E6Pxh3fVu6HYR3U+/W2MqBF7l+zyB2uA4yEpW41SgdI=;
        b=FH+U3g/BraMMYGZx6khBkMc7L+MfHaiM+6QUu+vNUK+BkonPhxPEINeiNTR41Ol9xC
         CuaMtUNM/0QFpsd6avhSBLpJ9QnCIBUHKh0jzQK6LT/KXGcQJ8B2ZOeIV8LjwDUB4Cd1
         JJwGiU+Iwmz5WSvcl3VN376DA3ZAlyqaJCZ/7I96CyqsvfUkT3ZWXRQRL/psJe9ivu3F
         xfYMy+I0wwUZ90nMIFNv6zCG2dYcE3HfmqGbS0Z0SJhlu2jeyNYF+yXGg1Se8OoGBecm
         s7F/keGArclViJqvKsWbc1Kn8EJj8+zupTwVOi/q4xCSPFTehwAwiXFeDgqRPGZpyUXP
         LWAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=OIKitEDq;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=OIKitEDq;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Wed, 4 Apr 2018 14:42:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stuart Yoder <stuyoder@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180404124246.GA20869@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
 <20180404010549.GA12443@lunn.ch>
 <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596819529000833924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> I hear you.  It is more complicated this way...having all these individual
> objects vs just a single "bundle" of them that represents a NIC.  But, that's
> the way the DPAA2 hardware is, and we're implementing kernel support for
> the hardware as it is.

Hi Stuart

I see we are not making any progress here.

So what i suggest is you post the kernel code and configuration tool
concept to netdev for a full review. You want reviews from David
Miller, Jiri Pirko, Jakub Kicinski, David Ahern, etc.

	Andrew
