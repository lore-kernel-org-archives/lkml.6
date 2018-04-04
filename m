Return-Path: <andrew@lunn.ch>
X-Google-Smtp-Source: AIpwx49QboY6/VHw5qh8e9Bf+7EJlSyqwDMak0MwPSg4d39McXu0a9RRe6GVnRwTZGGv7DzgRpaf
ARC-Seal: i=1; a=rsa-sha256; t=1522803953; cv=none;
        d=google.com; s=arc-20160816;
        b=bqVU8oORuX/iIQvC/tNqttBA31D1p9gV7X4HzeMnLo3BI6GwRizPG7EZWD1qf5jWZ5
         ultWP8EBqKaUIOUnGU3dAGtf1xKb2t8YWI6wPB/VHfGsiJv9oSAPlP2yuMIgjmfbMomj
         kpOzDTWzfx3Dliu5E5JSPRb7OMWz6+w/5or4/2Bx63CTjH4vAZotW6rXrOW2iqOx30Ai
         yobanaXeIFfi5esmq6QU0QXyAO5KKPkR+qskakG//oYk0TJP0nYAzjb1KKGv4QkxeWfN
         itETc4I2alVixyPzYqZP2pJtbemy4W+898djhwsCu3jX+fi6vf9uN8YQPUcfpfO4Qm8c
         fP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=9vhrbLIWv1rf4YhjG573k+9q49uSVhs+71nTbMG1I0c=;
        b=YtkZBkSFOiai7Vtvlk8regvfBX+5Xi/yZETvpXiFjXp1lEm5LpqmBIJZJyS3YyrbDa
         m4XQ06QzmwdsZEeo3VPhgmMuuiRFU7Kx3wsuzasaIKvY3qnroW9subR80XPJHl+vOi9T
         0CSR9cvD87hD46gFsN3ZBsechvSLLMOjCUqtVbQBOl06gerk//U++EBa/Rga4L3gyjI9
         y+B4aF0JN2eqJ4exqwpSVdcP9ZspAect6rPOeXuS+xGu+PPhLBUjzXotVMb+NZAWwWCB
         paUh4epS4HrcgnOI0D4uTBH/OZ640+MM2KoCEFi5NlJVv3jV8DkxTL77NCOz/onqkLmc
         kh/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=6MDKipMy;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Authentication-Results: mx.google.com;
       dkim=pass header.i=@lunn.ch header.s=20171124 header.b=6MDKipMy;
       spf=pass (google.com: domain of andrew@lunn.ch designates 185.16.172.187 as permitted sender) smtp.mailfrom=andrew@lunn.ch
Date: Wed, 4 Apr 2018 03:05:49 +0200
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
Message-ID: <20180404010549.GA12443@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com>
 <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596775678710384040?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Suppose you want to create and assign a network interface to a KVM
> virtual machine, you would do something like the following using
> a user space tool like restool:
>    -create a new (empty) dprc object
>    -create a new dpni and assign it to the dprc
>    -create a new dpio and assign it to the dprc
>    -create a new dpbp and assign it to the dprc
>    -create a new dpmcp and assign it to the dprc
>    -create a new dpmac and assign it to the dprc
>    -connect the dpni to the dpmac

Hi Stuart

It this connecting to a physical port at the bottom?

If so, i would expect that when you probe the device you just create
all these for each physical port. You then just need to map one of
them into the KVM, in the same way you map one PCI device into a KVM.

If these are virtual devices, VF devices you would normally do

echo 4 > /sys/class/net/<device name>/device/sriov_numvfs

on the physical device to create virtual devices.

> The fsl-mc bus and DPAA2 is very NXP-specific, so there doesn't
> seem to be anything that can be made generic here to provide
> more common benefit.

Which is why you should try to avoid all of this.  The user knows how
to use standard linux commands and concepts. They don't want to have
to learn the inside plumbing of your hardware.

       Andrew
