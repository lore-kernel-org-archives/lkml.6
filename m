Return-Path: <hverkuil@xs4all.nl>
X-Google-Smtp-Source: AIpwx4+FlS6VfTdA/jirhHOe2IdV+YhFCIMEg0WsVEQ/Bjuw0YBFIX7Vm6UdjILZHGIEuQf4QPcq
ARC-Seal: i=1; a=rsa-sha256; t=1522758242; cv=none;
        d=google.com; s=arc-20160816;
        b=W6h0k8Xd/QUzgh1z56J+aAHjGN5Qrkqv+u25jxAaqqa0NSP+hT8L+owKd2hSlwJ1nu
         TcNg5l+NGtwf8seXVDfppqvN0as/B+0Zu/VaX87mspKiVUYdeFNNorrfIYe8YGR5pksT
         /4+zmoZ3efwGQMepeN09Bxng0zUpXWHYUBWRWHAbauP+3hvuZMf+GZl9GHrdj8KilDRG
         ML/bAIzEUZkQ6XlB1XyAGxKHryclwAEl05upqSG3hqcQ0qc36LGrvy0Ynnv9J83FXd/1
         V8LvKiG5m9gVPuxhRlszJKPQ3QQ7F6QX4Ve55aAsRIjXAu/bRASgOtNuMJdYfxU8/tZ8
         8m8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=PvN1mtUgn7iquy05YnFcmKDqtChnYRR3MqwEfvsWSHI=;
        b=L9KKhWID+l2Qc6Vv1vlp8IPirUnUOrtNFfrFReA79zGJQYtIa3ff/2avqeIEKfm4yj
         KNH78z6aChYeXUWyA9tMemQ0A+gvoWf8s5+kXBnTzXUGz2FAc2Gjx/wyrEm46RrByzBK
         K6VWGHwIFv+8TBLKvNpY5mJhtYzbnU2Cn2SuFTCklvPKFj6k8dhHawlZAJqZ7orSI81o
         DTg+1e4L5/59xsZApNXO6UFcMRuZmqLZ5lKeGDskhSL0GPkjkHadD95gHWRjfD+Gp4i/
         9bh9h560CXChXLQikby1t2yenjzq0xWV59KPR65MXXnykVZcFFtTDEeUUnRU2GLg6DYl
         L2xQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.24 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hverkuil@xs4all.nl designates 194.109.24.24 as permitted sender) smtp.mailfrom=hverkuil@xs4all.nl
Subject: Re: [PATCH v9 2/2] media: V3s: Add support for Allwinner CSI.
To: Yong Deng <yong.deng@magewell.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Hans Verkuil <hans.verkuil@cisco.com>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
 Yannick Fertre <yannick.fertre@st.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Todor Tomov <todor.tomov@linaro.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <1520302562-1577-1-git-send-email-yong.deng@magewell.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <218b07cd-4490-517e-1dff-ada7d73dfcf1@xs4all.nl>
Date: Tue, 3 Apr 2018 14:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520302562-1577-1-git-send-email-yong.deng@magewell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL0sGgC6qH20QntbIvi3cXISbtHayvotZCiqd0UrfWBMecvQvEVjsQ4OHMOtdW3gqH0jXB2ad97cDMF5Vwz6dT/R53jnhy4vf0/v9pvKM650DIUqFwNu
 W3NX3LWlen9/vmrN2Z7sdhkg1CgCkVLJM/IVwrHDhYws2v57VrRMPJOvtrku952cT12zd2l1H5R6cEK719KRembBVvz7ihYPkLP1tmoI2LWfourw3Ztb9jhw
 OxoeH5w+7Zt4B0OLt6EDFOi1Tj01NBuFECYaO7jMDmLLqztHUbzY2g1V9mQC8if//eTGM5zrnBuRI0DjGkkx5D0HMA12e9WxYslkGnnY4K7SfD6LYSu27Wls
 7+vvY+qQZLWDPxhEnYrQ/tDVYlfYpZ5FZyZbZ7Me0QlLScPSXVHgb7QGtu7Ojk2FGYQvK3islU5n33sOa9nW1pFkbojEnN1QeNDwt8NAc148MchLqfpwaN2u
 eOqxPN+z2ZInsK4Y6tLgQ7JyiK9OiyXPU7pITWbSnnQ++E374IDnM76Hq0mM96aur9kI0GGsMTox2fQHxTjivVAY8demthMDNBw2ZgRnx2kDtGKQaLxatjTV
 GeFIC5n/bCauLpv7Pnp+a4yQmXE3YAf32GH86Pldq4vim/CP+fJJULoyZlRZrRkV3YzDyLQ2YFxPpQgdo9fB4ixXE5X6dvgvEOLpTUBjwE72V/NL8VslYe4i
 MUk2Kxv+evhVcaE9ujSpRZPZt07noAFEMdgJccRUmXsYUy6dKaUGfJXf7YM39DJ6X3GULimcq73gjgVWS/nuKgbfD/Y9i4ExxbS4QAeCjWrS+53gGrM5iKy1
 IgVl6vQ6AkJSa79YMdA94jIkGEqWt2t/0cp/+lYJVSFWlfb/3Ur3YrPVtM+RPW9tczoJkQ8RwFDXmHmEwAHjzS/LN13V1x0sUMy6ZXFV3gkz0uWEdzIHaWD1
 p+EQo31kKt9EC+KqU3PR7ju9QQg=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594152837685471403?=
X-GMAIL-MSGID: =?utf-8?q?1596727746250271196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06/03/18 03:16, Yong Deng wrote:
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patch implement a v4l2 framework driver for it.
> 
> Currently, the driver only support the parallel interface. MIPI-CSI2,
> ISP's support are not included in this patch.
> 
> Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Tested-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks!

	Hans
