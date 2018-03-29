Return-Path: <yong.deng@magewell.com>
X-Google-Smtp-Source: AIpwx48A/yWRf3t+8oM3X5px10M+rfrVPaHu7RVs1uMbIXodC16AcHzj3E32UOm8eg6VHsv1Mzca
ARC-Seal: i=1; a=rsa-sha256; t=1522285392; cv=none;
        d=google.com; s=arc-20160816;
        b=y51q3Y4aqX7dGehdlyW4V+EQTEgG0wC4Cj7Kc7KbePHA95MsWL71mCss/9jIoIc6DT
         cneIkLW+YycRjsJ2vhXWuzXsT8nOEEP3xdNgyUMxZy3N/WXKWWxAhUQq3hC/r4qjHAzB
         aZCV79m7MkMkcE03ri9kX46p6/Y9LpafTSUl5/C3tosCFOrwBKmO/A45NVRn6Ca75HwL
         AIfJf2urTIZ6dVV/+XO8T1qwq0Ext8MNi57+X83Qt/hS5j9YofuOyABt+m7/2HiD3GnD
         7pAu0c5BLuYHPPBhz/gavBpcV979C4tz9bgDEeqHOXLhzby6idR1+6urote2C+c1O+4D
         5xxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=DYEX9X20yNKsrieOR4e+T7r3bjDOu0n2YssoBtuprEo=;
        b=d5PCGl+byCpBEyHuTgruP/jOjX/Ci8tBeH2v7KW4+g2pkW8pouxRM+7OCJskWEuJOg
         ou8cujLy5/Npb4Cr/88T/I9FdFAc6oNLDOwF4jap0Gj62czXvNyBlkewE7DtmvZBu/S2
         eH+N6HfqLrPi6j1JZanWkyuapmnKU6a9OpV4Feqiaax+o9fd4Coo8dfAGX9RNHn3DuCU
         Aj9lG7gh8yKCqLBo0/rosW4//cXyjhPIDmXzQGYDWuBJl6ZyZT5OAAOc2QbPJGPBSv3Z
         XgP+DyNf61sBYcHBaOA6vNYXBn6gFUby94dj4NeCci6RoTu42cr1X+/Zo8DHzb9DDKsn
         R06g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 115.124.20.3 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of yong.deng@magewell.com designates 115.124.20.3 as permitted sender) smtp.mailfrom=yong.deng@magewell.com
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4562396|-1;CH=green;FP=0|0|0|0|0|-1|-1|-1;HT=e01e01542;MF=yong.deng@magewell.com;NM=1;PH=DS;RN=24;RT=24;SR=0;TI=SMTPD_---.BUBmmlY_1522285377;
Date: Thu, 29 Mar 2018 09:02:56 +0800
From: Yong <yong.deng@magewell.com>
To: Martin Kelly <mkelly@xevo.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, "David S. Miller"
 <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Randy Dunlap
 <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>, Stanimir
 Varbanov <stanimir.varbanov@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Philipp
 Zabel <p.zabel@pengutronix.de>, Ramesh Shanmugasundaram
 <ramesh.shanmugasundaram@bp.renesas.com>, Yannick Fertre
 <yannick.fertre@st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, Todor
 Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH v9 0/2] Initial Allwinner V3s CSI Support
Message-Id: <20180329090256.e9621262cf069c475a706087@magewell.com>
In-Reply-To: <9b60dee0-2504-6ae3-fda3-64c4458025c3@xevo.com>
References: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
	<9b60dee0-2504-6ae3-fda3-64c4458025c3@xevo.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594151284000328035?=
X-GMAIL-MSGID: =?utf-8?q?1596231927163800137?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, 28 Mar 2018 16:29:47 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> On 03/05/2018 05:51 PM, Yong Deng wrote:
> > This patchset add initial support for Allwinner V3s CSI.
> > 
> > Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> > interface and CSI1 is used for parallel interface. This is not
> > documented in datasheet but by test and guess.
> > 
> > This patchset implement a v4l2 framework driver and add a binding
> > documentation for it.
> > 
> > Currently, the driver only support the parallel interface. And has been
> > tested with a BT1120 signal which generating from FPGA. The following
> > fetures are not support with this patchset:
> >    - ISP
> >    - MIPI-CSI2
> >    - Master clock for camera sensor
> >    - Power regulator for the front end IC
> > 
> 
> Hi Yong,
> 
> Thanks so much, this driver is a great contribution!
> 
> Unfortunately the board I'm working with (nanopi neo air) uses the MIPI 
> CSI-2 CSI0 interface rather than CSI1. Do you have any plans to support 
> the MIPI CSI-2 interface at some point? If not, do you know the scope of 
> what would be involved?

AFAIK, there is no document about MIPI CSI-2. You can take a look at the
source code in BSP:
https://github.com/friendlyarm/h3_lichee/tree/master/linux-3.4/drivers/media/video/sunxi-vfe/mipi_csi
And try to port it to mainline.

Thanks,
Yong
