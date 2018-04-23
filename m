Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx4/qGmXjtpXqMrJThHwvpRyNLX/vNXzZ0BA1zqf4k6Ymn95//SoOnxGy/3pCT13g56wy2ofi
ARC-Seal: i=1; a=rsa-sha256; t=1524517907; cv=none;
        d=google.com; s=arc-20160816;
        b=kLgfB/LokOYbqTbh//xYp/6zP1jl8LE54+sskftv8ucpsd4soh683R0xbBaoEnwl2k
         v6xzVIcgKpDesQy5j9G6ZWdMlvkxu2y0NJ1I7mVU8S5P2yuZFJjrHPM/n/fZVzEABrou
         lRB1olqarga9s1f0wY0E6IMmYJ/9ZGc77f6QjyJk5B8Yr9QIVB3+N3kqL4EogL10UpBg
         Wcjc5eSUbB2IWdeYTn7G/2K7nMqSrDLzEZLkHIwVDVg+xTWrr8EqJCDpreNhAEjaOspt
         ALVVIOLakc+C9L5TnN5wmnwVpZobJ5dBQrUEQiGjfTHo+/XJjv0Jr8/mkJR63b4fD7Je
         T2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=mhgjo6GDD6dRq8ebVXo3cZldHYEXAbvFIOhz1C6JOpo=;
        b=ufhI+0QCMDpqKG4NRALboo00wBNx8BZZq6UmHOysoU496Rt1oAryXQBsPhW+gMKnDS
         Wa8rMUdsLuMZweoHh0yaG8nLjz/RtDQUPc1hZJoeEVEWaqOzvQZNIyYxnVwN1NN+Fykx
         aET2ksJVCaWI342XIoVHftG77CMOztjgVt5m+Q6O490CiQT2uRUNd1YtNH0WQ1FzHQCZ
         gNjv0XQVip4aRBp9TN8NDD8QRX9ynvXNqJi7q9X4epn4I7TP1K5SJzDgOUY1b1yoiI+o
         g8lBg2ckORwQi+hQsiBWx3cHxlqUImJMkSbMX3lCrfawrwKkWsX2UEGX7wfcuI2cPQZk
         /DPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Mon, 23 Apr 2018 21:11:43 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	Will Deacon <will.deacon@arm.com>,
	Andy Lutomirski <luto@kernel.org>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	David Howells <dhowells@redhat.com>,
	Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
	mfuzzey@parkeon.com, keescook@chromium.org,
	Kalle Valo <kvalo@codeaurora.org>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, nbroeking@me.com,
	bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
	x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] efi: Add embedded peripheral firmware support
Message-ID: <20180423211143.GZ14440@wotan.suse.de>
References: <20180408174014.21908-1-hdegoede@redhat.com>
 <20180408174014.21908-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408174014.21908-3-hdegoede@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597199782052351527?=
X-GMAIL-MSGID: =?utf-8?q?1598572889290627496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hans, please see use of READING_FIRMWARE_PREALLOC_BUFFER, we'll need a new ID
and security for this type of request so IMA can reject it if the policy is
configured for it.

Please Cc Kees in future patches.

  Luis
