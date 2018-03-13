Return-Path: <kernel-hardening-return-12497-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtkjLnxiT9fuSsATjSH+BhHFUk9nRP0rdRqTyohMbG3KRgS1qIlZhElQLILoxGdJTuxR4Q5
ARC-Seal: i=1; a=rsa-sha256; t=1520931281; cv=none;
        d=google.com; s=arc-20160816;
        b=mTig6K9pLEwsQVQUsI2rfTh5gvxpk0YJIy7WmWDNvB6/lFYyc/Hu5PcNv7ZIccZLNE
         G13GeK4xczmjBvRzIZ8Nzhtvmx5EXHtCrBOt+v+MQZIqr6zF6e73ohLH/S2bbSYJQwAJ
         r2t5MHTmLPFiSraCcmDa232D2EKm9unPeEpgmvYlPO+3OrhDUMN9+Jcxxa7Mo363sFVM
         r/TDyqPZsm6J2dajXQXRm1ESbwRX/wOtxQ6VCyibecRhzNs74HAKrBV7Cffwb9alahzy
         vvmCa1ZvaRDnJP9XIWuFbVHpR7CeKLkSGFOWVWKpaEzR4kd2M7jLf9gUGlZlUHOlGll1
         Xq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=d/uUwxWgGyXbjm0eXhEx2aL15Oy+FeDl2lLTXXTyyeI=;
        b=zWCHzMPKdArDTZK/sX2K4VMhwIKPLUCTa+3DRF8WE+wgwmS+6cs29j2veCUnyrQLyE
         YButvOWb28XiHwMtkv9NwiAblhJqtdJrrckN7SsicQLC7S7TKeNxybBZl0i3+t/wPUXE
         ccS0Wn3zfq3pZGnO6eq7528mWTUnx+LR9iQLCcgUhr8fdBl1d4vFWQTBW4Kx+IY7Puzb
         MM58k9QDp7bQtpHFl+Ij7D8RuPx7nBBiSW09DzM6Ui+bKumH4n1N457th9FSSInN96PW
         lcW/YlgDXRuxnEK/iVWufDxm5ERO/BjkgHZm6y9NWMCcvb2EwYyT9pA3vtjlUEc3WZHj
         x2uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12497-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12497-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12497-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12497-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 01:35:40 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, linux-samsung-soc@vger.kernel.org,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH 0/2] Remove VLA usage in rtc-s5m
Message-ID: <20180313003540.GF3795@piout.net>
References: <cover.1520660422.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1520660422.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530980012652646?=
X-GMAIL-MSGID: =?utf-8?q?1594812039250387378?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 10/03/2018 at 00:27:02 -0600, Gustavo A. R. Silva wrote:
> This patchset aims to remove VLA usage from rtc-s5m.
> 
> The first patch moves an enum from rtc.h to rtc-s5m.c, as this is the
> only driver in which such enum is actually being used [1].
> 
> The second patch adds the enum name RTC_MAX_NUM_TIME_REGS, which will
> be used as a maximum length to the current VLAs, hence turning them
> into fixed-length arrays instead.
> 
> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2
> 
> Thanks
> 
> Gustavo A. R. Silva (2):
>   rtc: s5m: move enum from rtc.h to rtc-s5m.c
>   rtc: s5m: Remove VLA usage
> 

Both applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
