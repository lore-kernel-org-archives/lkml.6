Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx4+RmYFbTKPjtx6IlL4A4QPJ02kudX5pzfTF6U3zrMPrk4o2z17tSFXAXCP1al0RQzZlKNAu
ARC-Seal: i=1; a=rsa-sha256; t=1523806818; cv=none;
        d=google.com; s=arc-20160816;
        b=qPxK1mWDP3WYpXb42cGYkkxxudivuSj0uI5URYzc+EWE6jbeAHFkECz1YgFgCuN+zo
         VpQrOpN1XLBJ+yJ0BKaKgCFo7oDy2Ru/Lp27czXfUl9e8oZKxfd8IcPEx7nUl5/cMnoj
         eDjwCh0qlv4DxeR4aYLcANK5+cDYtixfFtdb9iVGfESIfHDYyzgRXMI4mLcPFe2XP0Qq
         7CopcGuJ3TG4vpjoorn05nrXN6m5sIqV/cBTzzqYOanXPPHwQzqZp/vC6X+BaWr+D7H8
         Bbcvxtwttw36+rYrtEXjVkMgRsTWvjRQfFgYdKg385oheoT6CNu8pUjqGyjnHKAZ4+jG
         b4VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=zlOw+hi13jPYbJFYhN/y+1z592T6+DCmtcPXowAoU28=;
        b=LPhWx7PpbBQTzZ3nEJcP7UwRhWjXU9zN/ozpNnU1ij46y4IBVK9FMy/vn6kyq0pnL6
         p5iJhRaqFPAE8BNtqpooTwR3OVDG6nXhxxVrYmfy+Gcs76tOrznAQvME58bwpm1VLogA
         Un06Ikzyafb+LircokhMFiWB+3h2p1sGOnd+7DCErVfb+PxNKSqzA08a+sm0ScCPjrvB
         PEFitF/P65kToymoHJBrQ3eETSTcAMbkIxgyyHzirPLSG76nHzAKEL7ItyY6U60jJvrd
         fmarXpf96Q7Tb+QnB4IjCbfDxNtB86CGtuVi4vLBxUJERF76Ms2Sqyx6n1vsok2bmCQB
         kSAA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960D72177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 15 Apr 2018 16:40:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] staging: iio: ad7746: Add ABI documentation
Message-ID: <20180415164012.3e848d51@archlinux>
In-Reply-To: <1523637411-8531-13-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
	<1523637411-8531-13-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649757521827236?=
X-GMAIL-MSGID: =?utf-8?q?1597827258913741513?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 13 Apr 2018 13:36:49 -0300
Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> The use cases for this driver don't comply with the current ABI. The
> ad7746 and ad7152 need an external capacitance or voltage reference to
> automatically calibrate themselves which is not the normal use case of
> the calibscale and calibbias ABIs, a new ABI was needed.

I agree with the general aim here.  Would appreciate input from Michael
in particular on these + ideally others!

One comment inline,

Thanks,

Jonathan

>=20
> Signed-off-by: Hern=C3=A1n Gonzalez <hernan@vanguardiasur.com.ar>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-ad7746 | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ad7746
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ad7746 b/Documentati=
on/ABI/testing/sysfs-bus-iio-ad7746
> new file mode 100644
> index 0000000..96a41b7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-ad7746
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibscale_calib=
ration
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltage0_calibscale_calibrati=
on

Hmm. I wonder if indicating that it causes calibration would be better done=
 by
in_voltage0_calibscale_calibrate

> +KernelVersion:	4.17.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enter gain calibration mode, in which a full-scale
> +		{capacitance, voltage reference} must be connected to the
> +		{capacitance, voltage} input beforehand to automatically
> +		calibrate the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceX_calibbias_calibr=
ation
> +KernelVersion:	4.17.0
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Enter offset calibration mode, in which a zero-scale
> +		capacitance must be connected to the capacitance input
> +		beforehand to automatically calibrate the device.
