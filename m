Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48BneSdBRiej5xjlg8v0a7Ck6Ungazdl31RuSptO4A2k9IhNhzXZ4+vu0McikYgJgG0t+Im
ARC-Seal: i=1; a=rsa-sha256; t=1523955300; cv=none;
        d=google.com; s=arc-20160816;
        b=Y9N3WW7MQhu2LnHmcyM6ySOJZ2pGZZUaE+45yVI9AmyoR+gMXcvRwMCStGBSNbEnDn
         qJeeKcKuwp/7zncb75hMqC6pBW8iRghTavC+9abCMoGG7DZNQAVZYbTLRAtQe0atWrGL
         Bv0hWctKEhLtxg3Gdr2Aiw1OiZnp4wT6YjeSwlCRbz857oJrdJ3zdFYCaCt+iEgNvca/
         fq5APysq7jhVU4IyOlNz4rtdwbjGeTrQVf4XKelzcs3inhvcC9wVBqx249FFsnTawlD8
         T1uGpSV1E8a0Dofz75EhdMDLXo0voHou9u+4yZ9rmrRoZMmXs8hIuPeG55Cc9r2LrQi0
         MUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=FK35o9OAqZ8EvWqkXu0Uonmq1yj9KVS23aPSIIb1G2s=;
        b=rLlMVNy0lDI3xK9nZTiSG0PZRpXYjerhISIYX+WCyUn3qG8xJq5qFKIMs+TOoRL4gI
         F5Jj6920hRmOHOVVirX9efI6sLDabBFyfaw9vR9kPY//u4Zg+0Fpy/t29P7PGMnrK3Sx
         JmSneFiRLcRvK+ry6jitNn1uOPX4XteW4Wv4eIko7ql770lhzMRAyk+85BgavpAccXWm
         SRA18MZtlmmALPh2tU96ycIUPqMIszQ/RaSS7tXdpG/7aaYzMBFZNvZ9Js1y85XAHa+n
         3+taCjpJuM7/GHz1VQZhsT83GOl4nq64+MUtsdKhIed45/QmljitH+iRefVFwXS2dxXc
         rqBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Tue, 17 Apr 2018 10:54:37 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Wang <davidwang@zhaoxin.com>
cc: 'Christoph Hellwig' <hch@infradead.org>, mingo@redhat.com, hpa@zytor.com,
    gregkh@linuxfoundation.org, x86@kernel.org, linux-kernel@vger.kernel.org,
    brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com,
    benjaminpan@viatech.com, lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH] x86/dma-mapping: override via_no_dac for new VIA PCI
 bridges
In-Reply-To: <000001d3d628$4e91a4c0$ebb4ee40$@zhaoxin.com>
Message-ID: <alpine.DEB.2.21.1804171052440.1694@nanos.tec.linutronix.de>
References: <000001d3d628$4e91a4c0$ebb4ee40$@zhaoxin.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894379144798679?=
X-GMAIL-MSGID: =?utf-8?q?1597982954020261272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 17 Apr 2018, David Wang wrote:
> > On Mon, Apr 16, 2018 at 05:26:56PM +0800, David Wang wrote:
> > > PCI bridges integrated in new VIA chipset/SoC have no DAC issue.
> > > Enable DAC for the platforms with these chipset/SoC can improve DMA
> > > performance about 20% when DRAM size > 4GB.
> > >
> > 
> > So we get an exception to an exception?  Is there any way to figure out
> the
> > PCI IDs actually affected?
> Yes.
> 
> Do you mean we should list the PCI IDs of the PCI bridges which have no DAC
> issue?

The question was rather to have a list of PCI IDs for those chipsets which
have the problem and set the 'disable' flag only for those. That makes a lot
more sense than making a list of new chips which disable the disable flag.

Thanks,

	tglx
