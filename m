Return-Path: <fengguang.wu@intel.com>
X-Google-Smtp-Source: AIpwx4/laD8CU7WmoSN6OHwpJjYKnt24tP0m4ccJ1QvlnlsB/lJilX2NoGN/crN5XMvh3aVJNAtf
ARC-Seal: i=1; a=rsa-sha256; t=1522541541; cv=none;
        d=google.com; s=arc-20160816;
        b=GrFqlBA0VfLMzoGqxTG2QIWEon2DUVQPcu6EAPvbHV78MKqgqthlW2imGSZhSsKN/3
         RbA6lGQsus/OuIqHv/a8rRy1gCAKBB5mNe/N3/fCi848kEuLMdZRN6I5j/YYx3H/IAGI
         CEqPz0KTyOslwn8df7ydE3NvgjM+dIaRw6gOU/fjVPgLnnegcs5wXYh+p9SmgyNgsSaB
         Vck9TD7bad2ig5FSLRUc7nzuOyK26QSEv7HUxRHiyQfCQSOjzIJHZo1AjXiFBvLvNNxq
         jC0/qFy2EDlEQ0+tb5pLvQdW6YxrvCEUbZdYEyn3W86xF81lM0pgTg3zS5y/J9cOpwWP
         x7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=kPjy+79N1B8eUyu6QCwsZRTjtFKtss+r/JeJUsZSfyw=;
        b=LwJJ2p70isxDJs9MYPK7ZsuyxZyHAKW139nh9RTe6jcHPknVa2NP3MZr1jKadWiTy6
         ZFXyKkhB2aXYiEoCHFyDnExlGEF4dTGOxdg3wExzpym2V5FMZ93DcBTh+a6ovoR7ptte
         vI4HNDWPzBNX0e2Ku1irfWNe2Hv3fH27GPaXVJ2xNTXPrki8rb9AxCGhQrK6MEK7Kr+Z
         iIv0LUB7aB0H4+Hm4kipZlUscuvrMdjMD3LKxLZkP+g6kStXlIjVvMzYadVIpuyHcwhG
         RyMWXzzD/Kj+1V/y9Uihge1apxDpNBK5b5su6I3KjEcT24TXrc1khC1GqjgHLgNhg8Z8
         cpvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of fengguang.wu@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=fengguang.wu@intel.com
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,389,1517904000";
   d="scan'208";a="29691171"
Date: Sun, 1 Apr 2018 08:12:05 +0800
From: kbuild test robot <lkp@intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: kbuild-all@01.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
	x86@kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 1/2] efi: Export boot-services code and data as
 debugfs-blobs
Message-ID: <201804010732.6JjZvmsF%fengguang.wu@intel.com>
References: <20180331121944.8618-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331121944.8618-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596455689779545050?=
X-GMAIL-MSGID: =?utf-8?q?1596500519049093408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Hans,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc7 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/efi-Export-boot-services-code-and-data-as-debugfs-blobs/20180401-062627
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/firmware/efi/efi.c:324:29: sparse: symbol 'debugfs_blob' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
