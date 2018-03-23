Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AG47ELu5wGgDMkQkHRQjcFS+ho5ZxTztm2UoUBAVbrTB8AhcPETZLBK9WzFwlk0UL3eFRhVNOmvn
ARC-Seal: i=1; a=rsa-sha256; t=1521846564; cv=none;
        d=google.com; s=arc-20160816;
        b=J/4QDpZleInm4ZJ0lnxaMA/QxqzlG3aXSwn+ltAZcBuj2zYlmgy9je8SFFqpXchVLH
         Fca27YojMfOsudlTbLUrD9yPU6URguPpPhrn30OyNfjTOYd/IQtAphzVT4kmdpu+hZax
         tjxK1fwui+HSUPPCjw2uJMgBWyRsnEDmeyVzbgWxtK4EXci1PiEr11tSM4gE9dFp1910
         96T+0pR+VXj1WHTKLKqju6gV5DTpWvJuYINoYTNb1nFgY6ouPQcYRXg/l22JsVWHs1E3
         4Vh10iW8uvnkSHbp4SA0s5ay49OqdW+x4AUvZixDV9JHKYLlAQrYlSnIx7Fk8uH7/G70
         qJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ffs+6Y/ZVbwzJ6/71bGOeJf8hPuOKHJgO1ZSW/w1Kgs=;
        b=F+F2Y0JcowXjf2zrEPnlx4YbM74YfFzx692il1K05dV/FJihm4bra9Kezc3j5D9OXM
         WaHD2mqeb1+zx7KNpAcjPdan+7RuTJ6+OBpWgLfSx24iiI/OSeEmIwbb/5DTJvk0lgLT
         8PdymBeKHZvIB7+vFFbRyQvzbIUjzCoCitaZDDlH8CuAdeZp6PbNA5ps4A1Sy81XRird
         ry4Pk3cgdtwmGOHgcI2HGs0619VP7Dp3lXlqDjKchh79Xz8oAsobcprV+WpD1+y4xuJ1
         c+ADSj/LIDvQrlKzrvkjPfzRON2rP9UEi0mERh3FRqVWa01W/OeqPttfzuebBLBmNonk
         00uw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ISURRLGg;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=ISURRLGg;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 23 Mar 2018 16:09:20 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	Michael Shych <michaelsh@mellanox.com>
Subject: Re: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and
 auto detection functionalities
Message-ID: <20180323230920.GE17520@fury>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
 <20180322235541.GD24138@fury>
 <HE1PR0502MB37532883C411EA1BA9871443A2A80@HE1PR0502MB3753.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0502MB37532883C411EA1BA9871443A2A80@HE1PR0502MB3753.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318011865134700?=
X-GMAIL-MSGID: =?utf-8?q?1595771782750017609?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 03:59:22PM +0000, Vadim Pasternak wrote:
> 
> 
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Friday, March 23, 2018 1:56 AM
> > To: Vadim Pasternak <vadimp@mellanox.com>
> > Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; platform-
> > driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org; jiri@resnulli.us;
> > Michael Shych <michaelsh@mellanox.com>
> > Subject: Re: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and
> > auto detection functionalities
> > 
> > On Tue, Feb 13, 2018 at 10:09:32PM +0000, Vadim Pasternak wrote:
> > > This patchset:
> > > - Adds define for the channels number for mux device.
> > > - Adds differed bus functionality.
> > > - Changes input for device create routine in mlxreg-hotplug driver.
> > > - Adds physical bus number auto detection.
> > >
> > > Vadim Pasternak (4):
> > >   platform/x86: mlx-platform: Use define for the channel numbers
> > >   platform/x86: mlx-platform: Add differed bus functionality
> > >   platform/mellanox: mlxreg-hotplug: Change input for device create
> > >     routine
> > >   platform/x86: mlx-platform: Add physical bus number auto detection
> > 
> > Vadim,
> > 
> > I have rewritten most of the commit messages after parsing through them and
> > reviewing the code. I believe they are much more concise now, and make the
> > intent of the patches much clearer. I have not changed the patch content (code).
> > 
> > Please review the commit messages for the top 4 commits:
> > http://git.infradead.org/linux-platform-drivers-
> > x86.git/shortlog/refs/heads/review-dvhart-mellanox
> > 
> > Does this still match your intent?
> > 
> 
> Hi Darren,
> Thank you very much for review.
> 
> Looks good.

Thanks Vadim. I have queued these plus the Kconfig build dep fix for 4.17.

-- 
Darren Hart
VMware Open Source Technology Center
