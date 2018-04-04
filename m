Return-Path: <stuyoder@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522812150; cv=none;
        d=google.com; s=arc-20160816;
        b=s3z/WMNyMStzQeuCGU9wlrJzI1EpDcm4h1P/tBh9aCniD4EB4f3eHZ9o8k/U2+3MOb
         rrs/a/unTMC/7WQ2z1/vcd02D9pEk4ipP6fkvj4KZGcHIluzSk1iFNyUQDJbVsgTPrI1
         57P+Fw1gOJhVt913dmwviuVyu4YWMEHtfUajYJT6jmkiTycJLTVDiIia6AEYDJKhvcrt
         D+JTuy1Nqm3Y1D/Fnjl0Oy8qPMDlxE9G4hwE6Aq1F16Ng+pQDYmTNMHGVi+c8+cOSHpr
         p6s9mnSbEliuKwjaHC/Ck3jpwXuyRJAtrYyR8rrbTxOo6i8D91rbqjIn2AJ82YDTn66C
         ojYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=YHpKvu4yFNnrrcb+vVpsxU4no5IBMEtIIj0JWO7r7Tg=;
        b=JfGIdq6XXAwDToYmVj2Tg1lD6I8Bql9dp0ylDA/smDvVDgeV9mW4taOmuiqmWwaotL
         7eOTB+1Iynq3J0WdwQgh7O1MqZwwDUfH9Yal6ELzNx7M5Bsm54CgGFTjJifcANV4hRfm
         bd1z7WVqLWcT5Dk8Qdk0wrSb4Quj+NFAVQ8mHvxa1fr8axszmjAU1kid0v7qwH6DnSzf
         u1fxDWky9LmkXAt9ezfb18Fgfmhp/JVUevhq9yIZKRCtdcKdPiObeVoalPJyiBbcBQ5e
         ba45k6DQWmKeOMKVCa/KmotSar7k8ikMvhkU42mwouRTppyTq72rfL4LkuZSCQa+DZsn
         Zz8A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vO6HA0uU;
       spf=pass (google.com: domain of stuyoder@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=stuyoder@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vO6HA0uU;
       spf=pass (google.com: domain of stuyoder@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=stuyoder@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/agfwhbBGMFzOrfzoMLkC66sY4xm4ZHGyISW1Gkgqt9NxiYzI7cIR6jyo9kHQAYgTnr9K8q95Z9q4pE7Nlkr8=
MIME-Version: 1.0
In-Reply-To: <20180404010549.GA12443@lunn.ch>
References: <cover.1521818402.git.ioana.ciornei@nxp.com> <d8c243a9ead2fe1375dee242aec26d1276129409.1521818402.git.ioana.ciornei@nxp.com>
 <CAK8P3a089ZiPdp1CcVct8Kac+ejkNP8TrVpWYSr_nMGo4goO1Q@mail.gmail.com>
 <HE1PR04MB32126A07A4B4CC7225E661E4E0A30@HE1PR04MB3212.eurprd04.prod.outlook.com>
 <CAK8P3a1aQCm_r95Ka4x+j8SJLCLFvLuX3A4twK1WJcJs66YwKg@mail.gmail.com>
 <CAEac7tZ4we46EEa2DuAbmMr+hW6Q4BoBKJFFf1k_k57r2oJpng@mail.gmail.com> <20180404010549.GA12443@lunn.ch>
From: Stuart Yoder <stuyoder@gmail.com>
Date: Tue, 3 Apr 2018 22:22:29 -0500
Message-ID: <CAEac7tYSAmgt-kAcLNToKdrBOZhvq4Q+HxYEG+NkGZAk6kDADw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bus: fsl-mc: add restool userspace support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	gregkh <gregkh@linuxfoundation.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
	Roy Pledge <roy.pledge@nxp.com>, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595743497041548891?=
X-GMAIL-MSGID: =?utf-8?q?1596784273712720699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 8:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
>> Suppose you want to create and assign a network interface to a KVM
>> virtual machine, you would do something like the following using
>> a user space tool like restool:
>>    -create a new (empty) dprc object
>>    -create a new dpni and assign it to the dprc
>>    -create a new dpio and assign it to the dprc
>>    -create a new dpbp and assign it to the dprc
>>    -create a new dpmcp and assign it to the dprc
>>    -create a new dpmac and assign it to the dprc
>>    -connect the dpni to the dpmac
>
> Hi Stuart
>
> It this connecting to a physical port at the bottom?

Yes.

> If so, i would expect that when you probe the device you just create
> all these for each physical port.

The problem is that there is not just one set of objects to implement a network
interface.  For the highest throughput packet processing you need one dpio
per core.  So, it will depend on what the requirements are.  You might want
multiple dpbp (buffer pools) and set up pools of different size
buffers for different
packet classifications.

You might want to have other objects like a crypto accelerator (dpseci) in the
container as well.

The dprc is a container holding any combination of those objects.  So you have
complete flexibility.

> You then just need to map one of
> them into the KVM, in the same way you map one PCI device into a KVM.
>
> If these are virtual devices, VF devices you would normally do
>
> echo 4 > /sys/class/net/<device name>/device/sriov_numvfs
>
> on the physical device to create virtual devices.
>
>> The fsl-mc bus and DPAA2 is very NXP-specific, so there doesn't
>> seem to be anything that can be made generic here to provide
>> more common benefit.
>
> Which is why you should try to avoid all of this.  The user knows how
> to use standard linux commands and concepts. They don't want to have
> to learn the inside plumbing of your hardware.

I hear you.  It is more complicated this way...having all these individual
objects vs just a single "bundle" of them that represents a NIC.  But, that's
the way the DPAA2 hardware is, and we're implementing kernel support for
the hardware as it is.

Thanks,
Stuart
