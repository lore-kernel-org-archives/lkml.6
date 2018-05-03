Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoI49/IExAlC5Iouw+F2bMCPu7Az6PM6golV0gYRKuFkyjOsuAClbd+d0Lt+iZplfU9zbGR
ARC-Seal: i=1; a=rsa-sha256; t=1525386211; cv=none;
        d=google.com; s=arc-20160816;
        b=pVYeTzbEisCt04WvSxCUBRrotsJAS/s/9V2M1Ud4t2Rcx70iArY9d62+tTvB8s0v4P
         mzYP10xtaQBYWmQq6b7Kdckzru6DYjW247grwHYNgGlRtwGm7sRoPmTg63yoj3qcx2QN
         Huaz9NCOqVjvEDySPZMDlipAx3KUgHfYWhTjKfCr8TcQ56bXn1aE5BDOYJafXeDqNyWw
         BCk5AvXv4LBPyZ9wplQNQSu/6wBXaPcge54eMaSLZvRdHg1+pxLoBINWlA2UgMuaxksE
         iUM4+oeU8Y+EBNljT30zsKIPAx4cRXENs8lYtDAZyeG4vTT1ANo3xQABZeJF9ZlXGGt+
         0hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=o3S6Mp74BG41bpjACc+hR2CgEBypw3h+CKhNqVbptn8=;
        b=aLZSF4xOycAtOUflWmBcG+9nY2+jnWM1zOn9urKutJwhCLCIeGjuHgsWP3U1G9kvZu
         a7iWpfYPC0vZL0Gu0TzI1NQ8zWlsHAkdNARlH13QZZTdAOje1TYfr6Yf5y78qARuXgLN
         JrQROI6pS/19QMjIXmFnH/VW7mRpSE46P40/eaHl3ExALfHLuL/+58x2EGsg1/VpXOke
         EUub4ZHPP0SFQYdgqVVgms3m/u88TypGPkszRd+tiRoSSgls2ovNkqA+LYxf9dfXXIap
         9WxjvvGZNurumd+XoQO2OXnRE/NJgF5sSTIgY5OTLgNE5G7zq9nx/nRZn5aAmZRclbrx
         rpEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 3 May 2018 22:23:29 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com, Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
	Kees Cook <keescook@chromium.org>, x86@kernel.org,
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180503222329.GD27853@wotan.suse.de>
References: <20180429093558.5411-1-hdegoede@redhat.com>
 <20180429093558.5411-3-hdegoede@redhat.com>
 <1525185374.5669.49.camel@linux.vnet.ibm.com>
 <dc122066-9973-a1be-3456-6d6181a8fc9f@redhat.com>
 <1525202847.5669.64.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525202847.5669.64.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599483371694356834?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 03:27:27PM -0400, Mimi Zohar wrote:
> On Tue, 2018-05-01 at 21:11 +0200, Hans de Goede wrote:
> > Only the pre hook?  I believe the post-hook should still be called too,
> > right? So that we've hashes of all loaded firmwares in the IMA core.
> 
> Good catch!  Right, if IMA-measurement is enabled, then we would want
> to add the measurement.

Mimi, just a heads up, we only use the post hook for the syfs fallback
mechanism, ie, we don't even use the post hook for direct fs lookup.
Do we want that there?

  Luis
