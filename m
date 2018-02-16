Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AH8x226zQAOwltLb2p27cpBdFW0EZ4WP941BK+haxL5NPLjECLksyaVDmOePE84kzq5wa6ejBVHe
ARC-Seal: i=1; a=rsa-sha256; t=1518744762; cv=none;
        d=google.com; s=arc-20160816;
        b=LjDe0jmiPboz/RopnFD324uy+Qe7/x69wjpuzSndq8Juv0MqK+n2KWMVyRav9ldAd5
         pL0w5N0K1m4GCGkUbVKIDM4pOIgUMPVoLeyORzXoqk3RGVzIb3OQuIyaPw8JZvAHnZ0A
         rl2S717ykRyfWWNl+vM679PmhYDiSIW3BtkXaBwAOaMXG6WO3/S2XDsjjTaGtn1u4UUO
         Ig4CaLvFoYl586afNAyssYCNLA/Axn/Qw+9biyJ5Ttr3A883B3MtQ6h15tTv7H+bzArI
         XKnpYrRr3MHYCKng3ECcDYzOK3FZ84Jb6tJgNBuuXBjMngEV60bwKxJbDurf/bxWGbQT
         pyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=UD2A8fO5KUbn1BSyfinkrpPIMKXdb8washFhgF3421Q=;
        b=GA/Cr6M/NKfx2KNijLlaNq5t3GZh02p70STfwUwbAjih5SE9cq2VUCR2zoIOBa906T
         4LHPx9sKhOnLSBQauD8S7QWGoVW09+vrSRxbsesiUmIq6pVYdYgHtXAjk2z8+Hrz3yYc
         Ya+DUdKKg13hd/zuDiTqa6ew2Ef4ePeTXG541+3ZsEexl/SbxGZIz7BHbECino+4EjqU
         w/cPJW7qaw2MCfwTnTAEvtGcIoqyIX7iKIEnjX55PFFBCOMq7U1Ctqclkw1cv3wwoKlT
         oF/SKdS0P5mIJrurgQK6Vh4wi4om5imBIP15R7JCATGL91OX1ENtFEqvzVbFlyJzGT8Z
         Vczw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Ln4fnzhz;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Ln4fnzhz;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Thu, 15 Feb 2018 17:32:37 -0800
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com
Subject: Re: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and
 auto detection functionalities
Message-ID: <20180216013237.GC5786@fury>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318011865134700?=
X-GMAIL-MSGID: =?utf-8?q?1592519308238528107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:09:32PM +0000, Vadim Pasternak wrote:
> This patchset:
> - Adds define for the channels number for mux device.
> - Adds differed bus functionality.
> - Changes input for device create routine in mlxreg-hotplug driver.
> - Adds physical bus number auto detection.

Hi Vadim,

We are now in the RC cycle for 4.16. Do you consider these changes to be
"fixes" that need to be included in 4.16? It was difficult to tell from
the commit messages how severe some of the possible issues were.

I'm concerned about the level of testing seen by the previous patch
series if we are getting these changes so soon after they were merged.
Can you comment on why these are being discovered now - and how
confident are we in the drivers with these changes applied?

> 
> Vadim Pasternak (4):
>   platform/x86: mlx-platform: Use define for the channel numbers
>   platform/x86: mlx-platform: Add differed bus functionality
>   platform/mellanox: mlxreg-hotplug: Change input for device create
>     routine
>   platform/x86: mlx-platform: Add physical bus number auto detection
> 
>  drivers/platform/mellanox/mlxreg-hotplug.c | 31 +++++++++-----
>  drivers/platform/x86/mlx-platform.c        | 68 ++++++++++++++++++++++++++++--
>  include/linux/platform_data/mlxreg.h       |  4 ++
>  3 files changed, 90 insertions(+), 13 deletions(-)
> 
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
