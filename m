Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AB8JxZpZb/biirmh6M8S6l+5Wlwr71okpibVc/gbbeei8Dj6St4jnKDJqC0jaZGr5j5RliIqt0ZP
ARC-Seal: i=1; a=rsa-sha256; t=1525079416; cv=none;
        d=google.com; s=arc-20160816;
        b=Ocvzge+itcarpxdNGX0uMxe2HQ8dA8JLFRklMLkxiRLJnnOWXANq3NXbKggjRwuz47
         /M9rTPNIBp82OpgxcdXoBc31xWB148+yeVgjVfcjBa0HtlOdVCxUcIW+Ms2xcSD51bov
         NqTe5RmlZd+g5bUJODShPGqft7uYEu0/Ty5KK/mmJZ4cRoLuXwKJVwVMNtPm3EBy9q7F
         M5C91YJShjfpkoGPnxufYqnRm8OmeS9rorELmaC1hP71RwNTJT+nysOB7jKCvyID4iBL
         4rf5ynEj8dPVPs5Qvdb59CjamwGnBlGI6zfVrWo2pdbCNtq6QoapjB0Nqfwha9/XdK7L
         VXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=popk1tislSO+T9XvZNnoozsYph7YdN6XuG+/W5rse6o=;
        b=Cog480sxs9NDpqel23fCQrxgq7K1itw9h0GNr+8JqAA35+p0LJ2/neQinfQeChmSTh
         s5k/zxzXD4gl/gB0SRvwqU2dqMIyRD/TX2bE0sJytOnBC3q3EBHv1xRVmEaiBPnkVHlp
         Z70Tmlw2QSnDCc6ECdhVYLgscf+D+PipHoqD8UDxtcW9FC1PX/3YUE3tH/SCEIl/boyI
         Di7hvNBgrTEJ9gp3X25TDh4jp0RmVtPukZ3m5FrKT4G8GkpE1kDMT0QQo3lIjcfNA8vc
         ZF5MZp4m7zHQ+Gv5gXFQxUPPE/0Bz4XAiupWcZHV96HeyyqSDUHN0aiAtz+rj/t16iWo
         Sw1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 30 Apr 2018 11:10:14 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
 <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
 <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring
 <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 03/10] i3c: Add sysfs ABI spec
Message-ID: <20180430111014.49083a77@bbrezillon>
In-Reply-To: <20180429133700.GD28913@kroah.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
	<20180330074751.25987-4-boris.brezillon@bootlin.com>
	<20180429133700.GD28913@kroah.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347988973645659?=
X-GMAIL-MSGID: =?utf-8?q?1599161673844787253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Sun, 29 Apr 2018 15:37:00 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, Mar 30, 2018 at 09:47:44AM +0200, Boris Brezillon wrote:
> > Document sysfs files/directories/symlinks exposed by the I3C subsystem.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > ---
> > Changes in v2:
> > - new patch
> > ---
> >  Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
> >  1 file changed, 95 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
> > new file mode 100644
> > index 000000000000..5e88cc093e0e
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-i3c
> > @@ -0,0 +1,95 @@
> > +What:		/sys/bus/i3c/devices/i3c-<bus-id>
> > +KernelVersion:  4.16  
> 
> Wrong kernel versions :)

I'll fix that.

Thanks,

Boris
