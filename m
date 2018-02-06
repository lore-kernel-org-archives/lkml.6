Return-Path: <tony.luck@intel.com>
X-Google-Smtp-Source: AH8x226+eeoJquvOnx0oPFHTbi/sPSjv4qIT1jJmhKhEzN64uwQenOJJnt24JHJYtf37AwiQNio9
ARC-Seal: i=1; a=rsa-sha256; t=1517936862; cv=none;
        d=google.com; s=arc-20160816;
        b=BEuiccoJtO+sYLizg+Aa7mOyk7JqtHgSZrYQSDbU8FxAqJqUSWB961OFfUG2UuDkY5
         Q71MhXn7dVw7TS+gyLWjp+h9qRryF91nzzfP24ji1i2qXg9HXo1nj1FcqVSoTC15Y/KK
         P/i+3/ZFD+iTSmo8Gja8x1LjeoeMKjuwW2GjfLieOWX2XQsLXI7xzPXCRIDDTBkGeYzm
         uJnMYUhuXXVCZ9+pVRAHVvxXKHwfQYJgBlKmFPI1dwTXQKVIYCYtmp2oHdQE7clWwYSW
         +YbYgS+EmFHjNSK7FNoQ63kt7k+mOsuRvLwkIA67GqUWumRzBVp0S5HUXSyBNdsp6tjO
         rzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:dlp-reaction:dlp-version
         :dlp-product:content-language:accept-language:in-reply-to:references
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :arc-authentication-results;
        bh=a0VNxKzdkgXnZlPi8D9H4tNGSObtcGyl1BJtgz8i9z4=;
        b=Rl1IUzyCJXL4hopW8FAkKiYRXVb/CK6P6pxJrbbKVOWNqnLYmL+lNiKwInpr2j+r0b
         eWd5Sn4X57c08EdlsAXYBw03zV0Evh0BkFMBlCiMJXtT00yf8LMDXcbKUu7JMHNpSocr
         QWXrfd7t2LlBjn3fYKVCilMkJ3rVe1OG4Jhq3KsyQ7rQa9hYjNBaLt9qr4wI3/NmB547
         CKTp688LP4nzbw/fTa0PxPbyrUDI+SO9xf/EseJWxSK3Ut4ZvKYH4sXO+KE2holJzxhl
         pqe1hpgqkEgCB+vf6X92jRzx/hhBoVwfL+Nj5JJlNrAVwVZwEIBnd8yEHNCzFYWK3Pow
         0Sqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tony.luck@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=tony.luck@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tony.luck@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=tony.luck@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,469,1511856000";
   d="scan'208";a="201671090"
From: "Luck, Tony" <tony.luck@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>
CC: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis
 R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, "Ulf
 Magnusson" <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, "Michal
 Marek" <michal.lkml@markovi.net>, Linus Torvalds
	<torvalds@linux-foundation.org>, "linux-ia64@vger.kernel.org"
	<linux-ia64@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, "Yu, Fenghua" <fenghua.yu@intel.com>
Subject: RE: [PATCH 06/14] kbuild: define PYTHON2 and PYTHON3 variables
 instead of PYTHON
Thread-Topic: [PATCH 06/14] kbuild: define PYTHON2 and PYTHON3 variables
 instead of PYTHON
Thread-Index: AQHTnuKvJY4VJBR5TEuLQy09uO1N/6OXo84AgAATbgCAACjFgP//u8Ug
Date: Tue, 6 Feb 2018 17:07:39 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B369E5D@ORSMSX110.amr.corp.intel.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-7-git-send-email-yamada.masahiro@socionext.com>
 <20180206093450.GB31558@kroah.com>
 <CAK7LNAS_29myncTw+6u7fH9BgjzZJfXSN1CJjOjK-qXjPRQ8hQ@mail.gmail.com>
 <20180206131017.GF31804@kroah.com>
In-Reply-To: <20180206131017.GF31804@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjY1NGIzZWMtZWUyNi00OTBmLTg3MjktZWU5NTBhMTdiY2E4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJRMlN1REp2RXZhQjBUbnRxQWdYbjlPbnI5NlwvQ2QxK0w5WEpuSVBwejNQV2JGc1wvb3BJU3Q3Q29DVlg2enlTVUIifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609779326365104?=
X-GMAIL-MSGID: =?utf-8?q?1591672162722875184?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> That's true, and who knows if python3 is running on ia64 :)

$ python3
-bash: python3: command not found

So I don't have it installed on my ia64 test/build machine.

-Tony
