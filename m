Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AG47ELsvLnkNZcHCM9LsXJUFoh9x3O9PcJKdA0c+GHVDsxfePDfFcOPet2Kk5bRTogd6r34TltL3
ARC-Seal: i=1; a=rsa-sha256; t=1522254494; cv=none;
        d=google.com; s=arc-20160816;
        b=MmFGG37VK1t9jVlSoS9jwMDRPB5JRJW4EtnlkjH5IU62d5m0JQzuOcf+KprPaX0Mgy
         6NARvFxuZkxIiCbEhXWRlFBh/V5eroeQDBZYZIdI6wLDA4oWhpCEUtK53pdjvUaPk342
         e1as+3RdUqRWIjgmCr9SJ+6Jj++S6GAul7rDSmUR7vYn5X2ZU35gb+VqArKHeib2/0m9
         kcgagZt8kVsLx2tg61G+K+xNoVtQYLAbkG8//qe9evsb3pWn64aD6ruf72J1NcebIHq1
         ufW+Gw3nkBmc0lDpgB2r/io+aHeAYpdoFA84TtUA+cj2Puhn+c+lEW1Spb2ed+LKBuWF
         twbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DrE7LLtdIxXE+/sLZY3zJ40n8drnjxoB637d5tzg+LU=;
        b=rtB9Mp+E61LSN4fKgK+jthFQMpGo17hudSwT6LTE+cQEqyvRkfv9jwtzA3Z3rEE2Ag
         a2pRAsVSELeag1qvE3uTqLjrsylnApFWEoieMcRotrKw7hu7i0ajLlR55RT4jN3X0dya
         dyUfU4JYNowMID4QndR9UQAblfZ+ee4FSjSKsmqyZF1/+rRPfnZnsRkAEfBta9gXfAxh
         g/zd0mk7qALtBxAflHYcEjS3bZHfUQtXCHvu6yFV17PveE+TmpxCpvUONG8nPs/oVLMh
         Bu4WS70GTZqENDjOWmjU6CyMJGi4uTgfCnlfItP9NFoNvz62vNdXx66KJRoGmTEtfLR+
         DcFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=iLN1NUXR;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=iLN1NUXR;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Wed, 28 Mar 2018 18:28:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
	Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>,
	Networking <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
Message-ID: <20180328162811.GB15827@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596199528220468405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> I'm still not convinced either way (high-level or low-level
> interface), but I think
> this needs to be discussed with the networking maintainers. Given the examples
> on the github page you linked to, the high-level user space commands
> based on these ioctls
> 
>    ls-addni   # adds a network interface
>    ls-addmux  # adds a dpdmux
>    ls-addsw   # adds an l2switch
>    ls-listmac # lists MACs and their connections
>    ls-listni  # lists network interfaces and their connections
> 
> and I see that you also support the switchdev interface in
> drivers/staging/fsl-dpaa2, which I think does some of the same
> things, presumably by implementing the switchdev API using
> fsl_mc_command low-level interfaces in the kernel.

Hi Arnd

I agree that switchdev and devlink should be the correct way to handle
this. The low level plumbing of the hardware should all be
hidden. There should not be any user space commands needed other than
the usual network configuration tools and devlink.

      Andrew
