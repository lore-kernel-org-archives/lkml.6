Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525254470; cv=none;
        d=google.com; s=arc-20160816;
        b=S9kGsBlj/5eS63Ikou3RvPXS0VU8ypVvLTjFxM3JFrSRXLXkJdW2+mkydQqd16c5uL
         UvU2CXk/jtD7hu46P/HN01HQ0JfIjieVQRNXJ7OtnX7WfRW/eth8Cky47L5t7u7cx9vn
         L1VlPSLxeoTUWYtjTfPR+EyYQGr3ViEJ7nqcTxuVhE2U0YGmAIEutvLbQamjC9btKR+Y
         Tnbr+Q/a42VmfBcAaeR7cJuV3SFuYJO2lASgvtFY2YGPGsR+pg2AGK8i9jfvKupk1Jao
         7b1is2IwDQFVZwzBh5pHajTUchYvhEhv2uz2fgnLp3/UdukCGUi/4sFe6drcS/fzUwmQ
         0nQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=o3yWDWi4vxeuwm2Nc0GxyKU/keqI3bQeq2MC388JJfo=;
        b=aO3mqYR6VMScjLs2gtbCpV22fbIMiVlmJt82jSVb4VVDKJFKAH3Hk9FBIaOQyqwxQB
         jOz1B/C2uyg7rRnzVHqcyCyFYUgFmLXmvd2GXOXgzrBseHW1TLTHRFUasHyvXdxYDSrE
         xJv1zML8CAxlRxQv+jNyP0T415doNxs6u4yWEShibzQRyD2pf2IhJO6ZQ7gmqzRIN67f
         T6zQGLKQMbF5V7bl2b8myQlsg0qTB+q6qhsmQawpQxLSDTs/19IDRMg+FYb5ROybNrXD
         RwIj+iDnkco4aluImw83GKS3T/36IexwVWDLBUb9FblUEpw9kS1PqbdWspgWBBXi1IK1
         GKeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=W5H0sX3b;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=W5H0sX3b;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZqh1/fTCqt/xMc1oI3koGehWDSZ9gWDfYOrNz1bNtlfFSUnxvoKWvBZNLPW7jGMnz/YIMClDIOTWR0JNmq2TQE=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180429133700.GD28913@kroah.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-4-boris.brezillon@bootlin.com> <20180429133700.GD28913@kroah.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 11:47:49 +0200
X-Google-Sender-Auth: BvWgmjA3aGbIGWgCVyjhfAPpTm8
Message-ID: <CAMuHMdUe=zauTS7BQXyTvMbmc-AsEVdWN0gG_3Ejg3E4T-xFXQ@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1599345232349614847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Sun, Apr 29, 2018 at 3:37 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, Mar 30, 2018 at 09:47:44AM +0200, Boris Brezillon wrote:
>> Document sysfs files/directories/symlinks exposed by the I3C subsystem.
>>
>> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
>> ---
>> Changes in v2:
>> - new patch
>> ---
>>  Documentation/ABI/testing/sysfs-bus-i3c | 95 +++++++++++++++++++++++++++++++++
>>  1 file changed, 95 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-i3c b/Documentation/ABI/testing/sysfs-bus-i3c
>> new file mode 100644
>> index 000000000000..5e88cc093e0e
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-i3c
>> @@ -0,0 +1,95 @@
>> +What:                /sys/bus/i3c/devices/i3c-<bus-id>
>> +KernelVersion:  4.16
>
> Wrong kernel versions :)

Do you update these when backporting to stable? ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
