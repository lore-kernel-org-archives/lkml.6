Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZrK92U/Od1ZwjluTuMZcZU6sUpTX3Gwc+i3/mUpWfKQp1534Hp5zl9G3TElQ7GNjuYvKvd2
ARC-Seal: i=1; a=rsa-sha256; t=1524783303; cv=none;
        d=google.com; s=arc-20160816;
        b=yJWuE9J2uzi+dz0xwRnBOEVpBOVZgsFFMEnB8CF4U60KRIMUnTK/jVgOX3bn3S0TEl
         wVlq+QRMyiIocsjEv2trXlqeo+G2E0xY9iFoduCuivc0bE16eQXdH0ZIwcxzo3JjcDly
         G/HLiUOu4as5cjNCTyAcdKPCtD6+/3RmAxC6PFfm6EYg/FnXP1by0IXXMC9JrPONaX3Z
         rFauTEWqSiGA+Rqh/iehHOP0En0ItIXOBUTpbcO1M2TPwCzmcyHgI6S9ndkveBSqTVDx
         t0uAqZ6xNr3Kv1jFFnMzzdsfajlK+UOB4ntwyK19jybGzxmMMSqHQpEwEj6q/z9hSihh
         j+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=lzMN//5qwHk6lYt/LtBSJ4XYxaamE/CSSGDWhCgg6jw=;
        b=jPddmUvErOojbWppgYrJ3E2X5l/Kxx4QnVeEZ93VEVt42IosL7u5/TGfDpvax5JJxt
         jpHN8kE6en75u0GaNMt78KbFAmc9+cKfR+NWGc2wfcF0kRjQT4bwDp8Zafk0UND3nmM1
         u/hv6cimgSBi8Pks21ZBCWuDF+T2MvFZhxoTZZbWHBBCFTHXu8ZRgQTm7Hjrn8MxbjZm
         o7SeHjCg3epJ2hbLJ59vugcYXubkAH6B3rAg7s3KHAKMLTH1ddp+WDfs5Ml6GevI/6ZH
         zZI8pzD8CJwlq12T+VZRzLN4w5plMvczYO6BjNKTdcT8d7DmtOU8VMAr5Z1/0Cq+U4yC
         lpDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Fri, 27 Apr 2018 00:55:00 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
cc: KY Srinivasan <kys@microsoft.com>, "x86@kernel.org" <x86@kernel.org>,
    "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
    "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>,
    "jasowang@redhat.com" <jasowang@redhat.com>,
    "hpa@zytor.com" <hpa@zytor.com>,
    Stephen Hemminger <sthemmin@microsoft.com>,
    "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access
In-Reply-To: <DM5PR2101MB1030CCA0F5568CDED2695C58DC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1804270052400.1596@nanos.tec.linutronix.de>
References: <20180425181110.8683-1-kys@linuxonhyperv.com> <20180425181250.8740-1-kys@linuxonhyperv.com> <DM5PR2101MB1030CCA0F5568CDED2695C58DC8E0@DM5PR2101MB1030.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598742890625252345?=
X-GMAIL-MSGID: =?utf-8?q?1598851176972709026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Michael,

On Thu, 26 Apr 2018, Michael Kelley (EOSG) wrote:

> > -----Original Message-----
> > From: kys@linuxonhyperv.com <kys@linuxonhyperv.com>
> > Sent: Wednesday, April 25, 2018 11:13 AM
> > To: x86@kernel.org; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
> > devel@linuxdriverproject.org; olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com;
> > tglx@linutronix.de; hpa@zytor.com; Stephen Hemminger <sthemmin@microsoft.com>;
> > Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
> > Cc: KY Srinivasan <kys@microsoft.com>
> > Subject: [PATCH 1/5] X86: Hyper-V: Enlighten APIC access

Please fix your MUA not to pointlessly copy the whole mail header.

> > +void __init hv_apic_init(void)
> > +{
> > +	if (ms_hyperv.hints & HV_X64_APIC_ACCESS_RECOMMENDED) {
> > +		pr_info("Hyper-V: Using MSR ased APIC access\n");
> 
> Typo here.  "ased" should be "based".

And please trim the reply to the relevant point. It's annoying to find that
single line of review comment in the useless pile of quoted patch.

Thanks,

	tglx
