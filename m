Return-Path: <klimov.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518653390; cv=none;
        d=google.com; s=arc-20160816;
        b=kLEPg6X21nNuZQZW6/ergodtedo+VaIXokYgj98rYkTvfCctq28VDS35tclhvBGD7v
         eLulp0FhNXdkyiBwAPPU1e+LvLPBewbyAWJT62vPNvmQ11L1wlARrpkB4gIDjATroS0T
         U9mtylqHuHJzA0hS1HZhWNa+FeIAc16J1dEQ8zYWcWxTB264jLPoroAHukZEDn3yQtEj
         9sntwVnuehOOgrOFQI583mhFOLylInN7AAKEmFAMEkj9ocEKksYbLbM4H/PIx/cyRYL0
         CZifNVSCik4HexH875WjswBjNz/McDsIL/WMH+AnSOANjrnh/nsvT6sn6+z1TIm6PWKz
         dnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2YCZ0yMMNa7grbBmHk4b5EpRssMXMwuethbtgzkoV8g=;
        b=f4osyz17GZjeGaqBkjoNY39Pys/xAmkm/WInL7E2FFxamSzLngcSuKIK9BMOyj5PuF
         9k8GtY9QCvQM/WVUYzsbqax3pJ5DnpXCFep4GdLfsU05R3xUUdKesFZcsuubuFaqzkp6
         T1FQf5yJljdakYnoMJ1qyBvP2VN6Sdg6F7SsD78uFUaoHIQn/vIlwcjw3Oug8bFh8Exw
         2+F4lIvg0N8kELZCDNQvJF10FBYRosshoVm7CJZZybNAw6DDlFSFTdIKjc+n2DW55bK3
         EfE1Qtu8oUKyKE2BMXaNik12OfVvDSUfrFsXohMCZkt2PoMp/uUiYjeWfLsGdbih7YL3
         NqgA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TBqhCr1v;
       spf=pass (google.com: domain of klimov.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=klimov.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TBqhCr1v;
       spf=pass (google.com: domain of klimov.linux@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=klimov.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2243/jJuPHqMfIJEZfUeUUrkKcbuXPXk0iPioBNDdbqYz+UcuHVbZlGWzjHs+Gibz+1gy00GnHld+X6gQvIUqrE=
MIME-Version: 1.0
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
From: Alexey Klimov <klimov.linux@gmail.com>
Date: Thu, 15 Feb 2018 00:09:49 +0000
Message-ID: <CALW4P+LPiYSOCKW4iS6OwK9S=M3aCP+X6QNnDkycY5TYQsCb5A@mail.gmail.com>
Subject: Re: [PATCH v5 00/20][RESEND] firmware: ARM System Control and
 Management Interface(SCMI) support
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221911183430118?=
X-GMAIL-MSGID: =?utf-8?q?1592423497453114685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 6:45 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi all,
>
> ARM System Control and Management Interface(SCMI) is more flexible and
> easily extensible than any of the existing interfaces. Many vendors were
> involved in the making of this formal specification and is now published[1].
>
> There is a strong trend in the industry to provide micro-controllers in
> systems to abstract various power, or other system management tasks.
> These controllers usually have similar interfaces, both in terms of the
> functions that are provided by them, and in terms of how requests are
> communicated to them.
>
> This specification is to standardise and avoid (any further)
> fragmentation in the design of such interface by various vendors.
>
> This patch set is intended to get feedback on the design and structure
> of the code. This is not complete and not fully tested due to
> non-availability of firmware with full feature set at this time.

If it's not fully tested and not complete (I read as this patch set is
not ready to be merged), then maybe it's better to mark it as RFC?


> It currently doesn't support notification, asynchronous/delayed response,
> perf/power statistics region and sensor register region to name a few.
> I have borrowed some of the ideas of message allocation/management from
> TI SCI.
>
> Changes:
>
> v4[6]->v5:
>         - Rebased to v4.16-rc1
>         - Updated all the gathered Ack/Reviewed-by tags(which includes
>           all the drivers using SCMI protocol)

You still didn't comment on all questions to previous patchset.

For example,
https://www.spinics.net/lists/arm-kernel/msg626719.html


Best regards,
Alexey
