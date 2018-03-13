Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520936132; cv=none;
        d=google.com; s=arc-20160816;
        b=DHfa8lN7KqigfjIN6XOWHU7ksqyGaNczQOAXUDtX+v8FnNqURvXl4+mdkbmTUrpvOO
         bC3cAmZMGuR/2HKDWpgjWGu1DEq7A8W1GQQ+R5XKdiVlGmoOP/+U3LuTIoTnDcZVfZlF
         Rd4/nto7f9xjvewDeZFJG61SzedPuuGbQWmnMLDCekw6LYOBP/47Ddcz1sQFV7CowlJ4
         fRWBRcy+S5SD96p8yQS3xdNWheQaCIaKfbEP7Pfxi1xwqo8TcXUYv2/HxOn6jEKmoWd6
         qimSQS1pTzzpnmu+pAAVytKoB6yMdqEhj+pwO6V7zexuNqHUCW5jMfvg10xy1HsZlsqD
         wTcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tXurIzgDS2GGSfwF44rS8YEpF2qAvmRarzvu2PLKcck=;
        b=DdP1jCY++ZU7kasnR5cpiH+znwDWVUmWnlAjUda6q2erwkARK+78OslAun4eydA7Gm
         JQwgohRA5EnE3K9NfZG39tHXDPYv/uefCqMm8BL17fTkvynzkitBU3P1uGVMHyH5J6Ns
         lTLhGfurqc6jAyEvyOYAx66b60iX3zq7KxTDXLgWIiIZcAmqq+zWxERdtdj73/hNIkki
         GlF7oNA85zedAhTFTOvB9AbhPQSz+B5J4o32Ou2FiKTUiC6oiC7/Srvr5yudqzcU/0Cr
         zwYoZlSRumkjXEliljfbycW3eUIA1bFsNY7Irrhc3u0TtDF2+LAZ2YFSluOSRIOyhdqc
         9XtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=CEL4BuMs;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=CEL4BuMs;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELv7KTuzjUDSLjqY5smuLmTjCGiPLDnbVBHGQ2IFdnqpnxYD/hNO+ytRy807WEZDVAt0h7QFFw==
MIME-Version: 1.0
In-Reply-To: <20180313085534.11650-2-vivek.gautam@codeaurora.org>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org> <20180313085534.11650-2-vivek.gautam@codeaurora.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Mar 2018 19:15:08 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DXvnjaFw4Ct1Xn90nQZ4F4dLtov0ymG-tycQt5oLNpiQ@mail.gmail.com>
Message-ID: <CAAFQd5DXvnjaFw4Ct1Xn90nQZ4F4dLtov0ymG-tycQt5oLNpiQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594812129788829883?=
X-GMAIL-MSGID: =?utf-8?q?1594817125714969878?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vivek,

Thanks for the patch.

On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> The lists managing the device-links can be traversed to
> find the link between two devices. The device_link_add() APIs
> does traverse these lists to check if there's already a link
> setup between the two devices.
> So, add a new APIs, device_link_find(), to find an existing
> device link between two devices - suppliers and consumers.

I'm wondering if this API would be useful for anything else that the
problem we're trying to solve with deleting links without storing them
anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
better alternative?

Best regards,
Tomasz
