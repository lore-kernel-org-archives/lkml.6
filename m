Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525395066; cv=none;
        d=google.com; s=arc-20160816;
        b=Xk2/oNqGoKaDEtak8LjXZiMZx3GVLHN12wHvbJi/TqUMVLLTrMwrjQI8vwky4kPDbW
         duLYusRTUUxF8Zaot3by7OwvrlSXJOSYUxj31z3q5aMgE08OJrxIQ2OggEFtqroYczeX
         3dDZ+E9QMyHdmjKSFKt/BDzkxx0XhA+Cw7VWrsh3r6K6hXGt4TSJhxfEO+jc6w4wjO6o
         2cSGe/FX5mC8gyDaTTrXueplW+Sh9LdD92mTtP9/ytjvN+6XpuQ8E8OJAe3Aw52pTvWu
         BLxsswI3KtwSswJjcaopXW8c0T7w5YEAkB/ZbiFgcYIyEL5fya4c4+xSHSAoP9uMofDx
         UFwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:references:in-reply-to:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=GhteYO3JFiiR5zPrmIsO5pi8HBO7xyPOHTzR8KdFuyQ=;
        b=U0L/QDNogK/I5v4zn2ON3EAIDB3VeVAsACuGylbS/pzZQTy3h7wO6TtZIkRbV9sPPg
         5WTPB6ue4LWA5ANNYdNCS0VtYrl8yZoEIYVQsBrNxPbLd7ixH3vKAp9p5OxxcqyFwxzq
         +52u/VI64WTnA+eqp8JM/ofacrwI1rPb78xjL1chHWtV0nDhJxZ1lfiiz7YDkvf7J9Xa
         Y5NK0642bhz8JjDfPncfIi20PM7Jstm9ogsEBl4Umv715jxypxFwo+T7maFxOvDe2eOW
         fI5p5Dz3UVZ1Y9+3N6GAB8zpwu9oD1hfv4mvrq9AG6qfLPG73pFgYTuvvVggbegAU9je
         BnGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p1jJv6LJ;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p1jJv6LJ;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqLZCYkUSuUGuonjwB6UeobUrtgq/zktps9/kG7h7pTA2AqnHI1+NlMXXB/4QtswH0zKODUlw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Dan Haab <dhaab@luxul.com>,
	Dan Haab <riproute@gmail.com>
Cc: Jon Mason <jonmason@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH] ARM: dts: BCM5301X: Relicense most DTS files to the GPL 2.0+ / MIT
Date: Thu,  3 May 2018 17:51:02 -0700
Message-Id: <20180504005102.20717-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
In-Reply-To: <20180502141102.31769-1-zajec5@gmail.com>
References: <20180502141102.31769-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599361889970961407?=
X-GMAIL-MSGID: =?utf-8?q?1599492656778397109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed,  2 May 2018 16:11:02 +0200, Rafał Miłecki <zajec5@gmail.com> wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> These files were created and ever touched by a group of three people
> only: Dan, Hauke and me. They were licensed under GNU/GPL or ISC.
> 
> Introducing and discussing SPDX-License-Identifier resulted in a
> conclusion that ISC is a not recommended license (see also a
> license-rules.rst). Moveover an old e-mail from Alan Cox was pointed
> which explained that dual licensing is a safer solution than depending
> on a common compatibility belief.
> 
> This commit switches most of BCM5301X DTS files to dual licensing using:
> 1) GPL 2.0+ to make sure they are compatible with Linux kernel
> 2) MIT to allow sharing with more permissive projects
> Both licenses belong to the preferred ones (see LICENSES/preferred/).
> 
> An attempt to relicense remaining files will be made separately and will
> require approve from more/other developers.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---

Applied to devicetree/next, thanks!
--
Florian
