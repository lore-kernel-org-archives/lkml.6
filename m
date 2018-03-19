Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521468356; cv=none;
        d=google.com; s=arc-20160816;
        b=W9KsvVYAdK6AeTtbXE8KPSsQmQjuTRT8+MnZfT6BFars+brQVts8VZUM0fEAutzAed
         rPC/tVoeoOcwUtTerLWjDcGQkur5uZ+zlo82jkgmyufT/wqwk5zA/TKXk8rIrKA8as1T
         MQeDLFiUk1AuS1ZjyGWxB5obBPzAEzGI2LhX47oh0Er+tvCKqqmhOENfCLblpjMOsolo
         ro84+CppYCNbvhvEcg8ws8zpK4dBzPr20yYI7bY6+6j92rJeosKgnZdNxj9S6vwiGTqn
         oP8dVtgsbpNIQR/RB8+hrDMFMR9F/q2jMCtOiLelzLXrV90dvKL6ekZD4QNr3io+6yUN
         v43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=VpReCA2NQQhBPOg6xwlm3w3RHzV2Bqr7tCS+UWleg7g=;
        b=N2IxMr15Htlidl23bOjAuzIPiiEtBvf7JNYyM6bI9+/SzlQuOpyvZEMGlzso0FAEf+
         vrI1R1GRPUkQuoLbZsUlglBcq77WaoNASnd8NbzWoIrteobI7SoFPKxNVpn9lRX++rWB
         bFBnKT92o4Jb6bYAiQ3zXvOEKtJU9RrDrMTtV9kzdCyUc75FbD3AwAD7LUgnijYVA/dF
         wog+bWHL+x4O5kIrB5MQ33ertpDNasqwRU+VaAMesq7SCXnnXb5DDo2hIT/VsVmO1Spf
         tQyoV26ZSZa5BsmvlnXOHf3+MBSgR1mAbLkbMu7VsFUideCYLjvxt6z/Nm6KnObQTWQa
         hXcg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NaPFAnIN;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NaPFAnIN;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AG47ELu8YG79a4jFXaFpMk4Jd8FNrOyWXmYApHFwOvl9q5dDXeneufUX1GeWj65aS5XbSWBTCnGcag==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Mon, 19 Mar 2018 15:05:55 +0100
From: Johan Hovold <johan@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	DTML <devicetree@vger.kernel.org>,
	linux-omap <linux-omap@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Rob Herring <robh+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	=?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
	kernel@pyra-handheld.com, Andreas Kemnade <andreas@kemnade.info>,
	Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/5] misc serdev: Add w2sg0004 (gps receiver) power
 control driver
Message-ID: <20180319140555.GN18359@localhost>
References: <cover.1512114576.git.hns@goldelico.com>
 <5494ad34b39a6c62601e3747440268dfb3be7d5a.1512114576.git.hns@goldelico.com>
 <20171222124427.GI3374@localhost>
 <91850CC3-B280-4701-9D07-96AFF3A79A6F@goldelico.com>
 <90F9A8E4-035A-4A9E-8AAB-757491D63E69@goldelico.com>
 <20180112153903.GB5992@localhost>
 <E7ECBBB8-2E88-4F04-AFC3-659332E84CF6@goldelico.com>
 <20180118061314.GG3286@localhost>
 <8B2641B8-E86B-425C-9E79-E9C41E4E623C@goldelico.com>
 <461DBB7C-5FF7-4723-9518-C9A5E7E5610D@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461DBB7C-5FF7-4723-9518-C9A5E7E5610D@goldelico.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1584169666984958099?=
X-GMAIL-MSGID: =?utf-8?q?1595375203404924354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 04:53:12PM +0100, H. Nikolaus Schaller wrote:

> If I look for example at the camera module drivers provided by
> drivers/media/i2c, most of them could be easily power-controlled from
> user-space by i2c-tools and 1-2 gpios through /sys/class/gpio and
> a big set of scripts.
> 
> Still they have a place in the kernel and cameras are powered on
> if the device is opened and powered down if it is closed.
> 
> So I am still trying to understand the rationale and logic (if one exists)
> behind having them in kernel but rejecting our driver which does the
> same for a different class of devices.

For media we have a framework in place; for gps we do not (yet).

Johan
