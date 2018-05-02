Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525260725; cv=none;
        d=google.com; s=arc-20160816;
        b=eYf+OpvPd1qtH/za/p8jELfcwqdGeqdl8+eJ00W7K1UAA1lN1eIFPMOTu+wDThxX75
         uAiVoytMc3w4BxtKs0CBngwQ2QNmxpei1mv3Yn6osP46FS8l2sscNmzuB51T5BNfmpKD
         6Ax1Ah746rjwf3KO1/ig6FYyWw19KWOU0yuUE3WcHzsg8p+jYe9tG83dIrkhIjLhc24w
         xp3aAVqDrfNY7Nw2482BA8MSkZscZCGtizkNR+GAc5UW+H2X3M4T/0X88VKq8Dt8N2Sy
         /+q9ar4jgkDNwFUOraFUzF0sXiFwx2lC/Uf4v2tVB8SB3o/TraaLyyos7xTcnXmB5nUS
         W8Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=0QtBf/z/p5YVnQKaBxo68oDtlbHPqU8a4K0vtrzZxms=;
        b=XLvlkvp8QzqkNniPy0Q08Yt/V8kceil9h7Xc9+6a5kbJkY5xse6sn18iASrR62IKdT
         NOuHMPhaJkmw4RD+8ER2hYyg6K4386iQrowHf1RNXdH30PvO0MJ0NV5aw20g+B3mXlS2
         IFbornpWKFbHTjiDPUHkDXlzra9W63M8VGtoZTRTy+VqokzXKJoU3Zz9h2NJOswyLvv+
         DMU/r0zsjB4Vm9afq6gmqrCU7GLYBGZko+dP1AlqKc0KdSRyrqaaooMe+2UXIoPXf8JD
         bycl2BM786D5pRiMj8IfFAbjuE/S+8KHJWvG+I4RFOlI+qX6X2npXZLA4A9K9A1BaCgi
         4zqw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ARRy4T8e;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ARRy4T8e;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZpvq9sTFjIfZthkq8grSogNL2sd3gaOPdGcVMANA55pFYcolsgQYafA8/dliT+nKrAFEmLmO+yQ9MEQKMAdx04=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180502111046.GA22091@kroah.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-4-boris.brezillon@bootlin.com> <20180429133700.GD28913@kroah.com>
 <CAMuHMdUe=zauTS7BQXyTvMbmc-AsEVdWN0gG_3Ejg3E4T-xFXQ@mail.gmail.com> <20180502111046.GA22091@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 13:32:04 +0200
X-Google-Sender-Auth: L3G-yGQUB46lnldvHyT9mji8ujM
Message-ID: <CAMuHMdWgmPOntSQH0artOgBf4GrxOHJmHX8gyw1gmAW0ichPyg@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] i3c: Add sysfs ABI spec
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>, Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>, Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vitor Soares <Vitor.Soares@synopsys.com>,
	Linus Walleij <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347988973645659?=
X-GMAIL-MSGID: =?utf-8?q?1599351791197752232?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Wed, May 2, 2018 at 1:10 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, May 02, 2018 at 11:47:49AM +0200, Geert Uytterhoeven wrote:
>> On Sun, Apr 29, 2018 at 3:37 PM, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>> > On Fri, Mar 30, 2018 at 09:47:44AM +0200, Boris Brezillon wrote:
>> >> Document sysfs files/directories/symlinks exposed by the I3C subsystem.
>> >>
>> >> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> >> ---
>> >> Changes in v2:
>> >> - new patch
>> >> ---
>> >>  Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
>> >>  1 file changed, 95 insertions(+)
>> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
>> >>
>> >> diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
>> >> new file mode 100644
>> >> index 000000000000..5e88cc093e0e
>> >> --- /dev/null
>> >> +++ b/Documentation/ABI/testing/sysfs-bus-i3c
>> >> @@ -0,0 +1,95 @@
>> >> +What:                /sys/bus/i3c/devices/i3c-<bus-id>
>> >> +KernelVersion:  4.16
>> >
>> > Wrong kernel versions :)
>>
>> Do you update these when backporting to stable? ;-)
>
> I'm not adding new features/subsystems to stable :)

True. So let's leave that for the LTSI patch monkey ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
