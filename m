Return-Path: <DavidWang@zhaoxin.com>
X-Google-Smtp-Source: AIpwx49qdGaTZY9nfhc+mPxVH+7nM8KDGw7SR7youBfEvWR1oA9NIsBGbDz/duHMJJ0oNK35Ky4v
ARC-Seal: i=1; a=rsa-sha256; t=1523954706; cv=none;
        d=google.com; s=arc-20160816;
        b=yWj7fgX2rz8mAsFRIeBKTUGYQcphuG6BGDGnPiyXuISBjcPCnKmNb3q3ES7SMEtMVu
         uKzpJh+RrxCr/a0w8p7+w88M+51LOXkzvivyEBwsJ5mOFT446S6946Q9b+UfTuUPUmfY
         GZug1Vcu9/Y9EE8oaq8HR2XPrGjGNr8OwrwrNzdD+IVUI3NVdxfTm0YE6YUJwswskZ8e
         N7/C0+un7hZMz3vyxkFkyWP/QbT2iWwWQwPGSFNz/7b5iF5jRR4HEq85CEHUNLRCQEes
         n5ftfXFgXid49VPkx3W3r35rAIieKxDb0EFTgJmwjHxqn6hCcbmngtgDUnq4C30kn4K8
         wz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=ihsfGQsSzOzLpy1WU5m4pnBxPrxY6W8kYB78qdoja40=;
        b=0eS5+RknII3L2pcNK46pu7mBFS9KDE9BDlZA5HdIQjXoxw5qS+hO+XbG9M653Tf2t1
         DS9X+mWtL5vEROPwRnPhU5n4Gpune2iABeChWppqWTYIoxGS3/fKs0BnWGYl1giJT3wQ
         D5VKQnqJl8g8IRQTXPpl3lKnfjL/bkwA8AaPM9um/+YJ6N1hB/WWqqpRS/KBW67dpfVK
         lycWBMzMhw0zFqHCHOSsyRQKmxHx54Tvg+EhLTSBO9mjOVdAOzUljKHvj4V6yWVaCzst
         XrCOFrhwOCwhVvtIAXV+cAlzkB8DVoTLupRamllODjfVUht4h7z+TtrLZLEreRQaSQ46
         z8hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 180.169.121.91 is neither permitted nor denied by best guess record for domain of davidwang@zhaoxin.com) smtp.mailfrom=DavidWang@zhaoxin.com
From: David Wang <davidwang@zhaoxin.com>
To: 'Christoph Hellwig' <hch@infradead.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<gregkh@linuxfoundation.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <brucechang@via-alliance.com>,
	<cooperyan@zhaoxin.com>, <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
	<lukelin@viacpu.com>, <timguo@zhaoxin.com>
Subject: Re: [PATCH] x86/dma-mapping: override via_no_dac for new VIA PCI bridges
Date: Tue, 17 Apr 2018 16:44:32 +0800
Message-ID: <000001d3d628$4e91a4c0$ebb4ee40$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPWJWP7w0EjoZkeTnm5pu211P7x3g==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597894379144798679?=
X-GMAIL-MSGID: =?utf-8?q?1597982329344314331?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----=D3=CA=BC=FE=D4=AD=BC=FE-----
> =B7=A2=BC=FE=C8=CB: Christoph Hellwig [mailto:hch@infradead.org]
> =B7=A2=CB=CD=CA=B1=BC=E4: 2018=C4=EA4=D4=C216=C8=D5 20:34
> =CA=D5=BC=FE=C8=CB: David Wang <davidwang@zhaoxin.com>
> =B3=AD=CB=CD: tglx@linutronix.de; mingo@redhat.com; hpa@zytor.com;
> gregkh@linuxfoundation.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; brucechang@via-alliance.com;
> cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> =D6=F7=CC=E2: Re: [PATCH] x86/dma-mapping: override via_no_dac for new =
VIA PCI
> bridges
>=20
> On Mon, Apr 16, 2018 at 05:26:56PM +0800, David Wang wrote:
> > PCI bridges integrated in new VIA chipset/SoC have no DAC issue.
> > Enable DAC for the platforms with these chipset/SoC can improve DMA
> > performance about 20% when DRAM size > 4GB.
> >
>=20
> So we get an exception to an exception?  Is there any way to figure =
out
the
> PCI IDs actually affected?
Yes.

Do you mean we should list the PCI IDs of the PCI bridges which have no =
DAC
issue?
There are lots of PCI bridges(PCIE root ports) in our new chipsets/SoCs. =
And
no DMA issues found.=20
So, we only want to recognize the chipset/SoC by reading VID/DID of Bus =
0,
Device 17, function 0.

Thx.
---
David
