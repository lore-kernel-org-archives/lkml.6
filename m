Return-Path: <kernel-hardening-return-12395-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuWPsGyPbO0zKDG+0KW4IszlnT8lbKmEerIuedXjZ3K9heEpKalbUaj18BKK3x3cS32dNLU
ARC-Seal: i=1; a=rsa-sha256; t=1520786387; cv=none;
        d=google.com; s=arc-20160816;
        b=FJA5LW6RRcaIe+lRzzjPqWCZVXMb7S3iOhpfDJwNBSKbEJoBSFPpctcWGW8AnFRE4F
         7gU3lqZ1UKv9VK6+Vdud7rzMwIWcpP7MdRAnOmQpHAM2LRqfDSuS0wyfROpmqMz5/z6W
         STpNXnizMpRjjhJMZOhr8GmbnmTLOh/75ATlqfMoUOldKjdbTNZX4Psfivr8e8P5a43m
         pKALI4l4mX0nPn/3hmp1Wk3s0epnKSI1uKjIwPiHOU0q0ekoTMdFyrZch/6ujBV+DzSc
         wRZAHTkZMJm5hc0TyLLwpYpm98YNVaI7eMBXS2i/b0Is3ltlzCzaVmExsGIFY0OqItmZ
         ENGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=iYez+zv5Z3YMu1VjleJfLmgfkFb8gpDHz2TcWQUdryE=;
        b=aaH5t5IOcxv4PZTT5szSu4KdB+eN/IJ/h/nU3xKyNOTwB8C+1TAI3bNO5H7DFEw416
         dMIKnU7oTfbHm8DdirtrIiIubdB7EcJsdBXF88/mrzDUh5O3ynUlf7VtcaNsA+VNvsWj
         dClZ+1cJN5x5Wep1DO6DbcoHCBvYVfFnRdPH4JJjTPchPk5OxkeHf8nq5YU6w+4dUnSV
         KjZtHulL7uOflBuviYA9qCFj6w06RH77PJvREV4feuTRyzwhZeNL2xE5XgzYYDThBSwP
         g9XbNvX1eGkWUCazNU9uW4H97PIjvWP/6Ee162J8hwidAMM92PI7rGFuV8n/XImw+zcj
         6Meg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12395-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12395-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12395-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12395-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E907321707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
MIME-Version: 1.0
In-Reply-To: <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com> <44ee5bd5053d579dc6c46b21e2ef8f6acf70e4ce.1520660422.git.gustavo@embeddedor.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 11 Mar 2018 17:39:24 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
Message-ID: <CAJKOXPdTgYRGvj99dYroY_6AvZD0KOV5yj+LUVNHWs7XUw8QsA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtc: s5m: Move enum from rtc.h to rtc-s5m.c
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Lee Jones <lee.jones@linaro.org>,
	linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <garsilva@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530993391759902?=
X-GMAIL-MSGID: =?utf-8?q?1594660106711050363?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 7:27 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Move this enum to rtc-s5m.c once it is meaningless to others drivers [1].
>
> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2

Instead of external link (which might or might not work soon) you can
just put "Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>".

Anyway:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
