Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AG47ELtsP0pqsX6YkIZgMoeC9U7kThQSAgremjXrQbC144rAzJzcrVGa/hvRAhDvL1fy7ZUBCi+d
ARC-Seal: i=1; a=rsa-sha256; t=1519751664; cv=none;
        d=google.com; s=arc-20160816;
        b=nJ8AzA6DRFatdPieDo3XW/TM6+nDPbog5s4ESohwaZhUPsY5kPH82o8t2NUNPo2M2B
         2XUu+sGKUu5aLNY6MDeHP7bCiYnM3SujAigklqmHVdmRlB2JsHX68V+lORCm95+GV6RM
         o6eMZc0+btMOxVov9FJcXdQKNFMiFI5ajkgol4/GTKkSlnn7eTB3QOe39Y0sqWOV0fzn
         E9avKlqao56ygkr2RrE2eGqH2wcmzdd4WvHQ9fASOrJP2mGMK+Y4yk2kw42NJkpTV8q4
         2f+lxPFwMsj4EbrjpxXT0S7O/jJafmhFy3D32gR4buOTnhNM8ytaoExvJtv/AowgzuUm
         ObdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=uauiOP89cDCVR4c4mW5lzkGASIN5XJXDOZ462LWDtBs=;
        b=YO3w2qEKQvJB6iRdiFIIGM++OiqSZo5+RRLIJ6uBa5hfRFPdSI0AvudZH5hWwV7Dew
         Zv28VKYEOYtfVdxmoyiRLGvJCK6m6loUKMA5Yz0fOZDG0npPRDj/Ee3gTv/0ga7aMDkx
         TJDu8AekH6M0oFnVLjBMwrkFY8bajb61hxkuvW/vi5bTxFtwtoroBAseDd0JOK0Tb5kP
         a2xlUhFFN6H3KdE4WKjgMqITRvnI9f4JSMfiNANOBwa5IMQ6++aDh3ifB25GjVgCtcVJ
         Wdh5JVZk/WsimN7YLTPiDBdsd2s9tywXYhlPKXN0Mp2nSKx34xHcQqWOl1Q1XAoBVed/
         1iFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Tue, 27 Feb 2018 17:14:19 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 3/3] ARM: mach-stm32: Add Extended TrustZone Protection
 driver
Message-ID: <20180227171419.3nlz23qzptvew2as@lakrids.cambridge.arm.com>
References: <20180227140926.22996-1-benjamin.gaignard@st.com>
 <20180227140926.22996-4-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227140926.22996-4-benjamin.gaignard@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593563504713995835?=
X-GMAIL-MSGID: =?utf-8?q?1593575120815090910?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:09:26PM +0100, Benjamin Gaignard wrote:
 +
> +static const u32 stm32mp1_ip_addr[] = {
> +	0x5c008000,	/* 00 stgenc */
> +	0x54000000,	/* 01 bkpsram */
> +	0x5c003000,	/* 02 iwdg1 */
> +	0x5c000000,	/* 03 usart1 */
> +	0x5c001000,	/* 04 spi6 */
> +	0x5c002000,	/* 05 i2c4 */

...

This duplicates information that is in the DT, which is unfortunate.

Why can these not be marked disabled inthe DT instead? 

If it's dynamic form boot-to-boot, then the FW can probe this prior to
entering Linux, and patch the DT appropriately.

Thanks,
Mark.
