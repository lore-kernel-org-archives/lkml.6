Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AG47ELsk9y9cZ4SpjR+dsCHNRsf3FohbunTDyc4klAMdJm03nguCck9RSd2W4Mr2UiMbzVy1MRS2
ARC-Seal: i=1; a=rsa-sha256; t=1521027464; cv=none;
        d=google.com; s=arc-20160816;
        b=LmO9C3bCismFuUYAHIybEfEloXwO+J6DtBoIoXuXx0Vq3XH+8ktwyMSKCPfnOYhumI
         AxeIqUQeBt5+zA6hUjH8QrfIEqlGI73vQhwdYy/nU1V6sUgeT8exxOiBbyIlLTMg8dNs
         /BHIZHzIBy3Fzm4qDRHz5r0tj2Mcov01e0omehd7PPtvN5XE7zdb2ZmE6OglL1K3t9Xz
         zSwyLIxJd/6eDTLlL3QDRNyOCdE/466nHLdWNO9Nc6O3O/TAgvyVrAljm8JE7DODmABZ
         jMI9upxEWcgDS8YYdVeePBqBlwUzZePqAbrEH1mpcHZMKe4A8q3RTChvm8gpZXaeGJc5
         9iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=+xdUd6eXbhzYn7HJ6Ilddd1ZCncRFmKFRC0UhSGo9MM=;
        b=aw/i7zJE+Bq2EhFyj1IZsQ0HD2U6Eiksf4CdKSX27iD4FwfJ9r72xgh6Wez7pkL2yu
         nW27pENYI8FT4CJHDkRAtEdXzgQgeLT3t4vDWCGLsXZDuw19Jd9P6/o0T++le+Z2/dBR
         JeFCGppNA4e+rTX2QI3RwypF/+SQgyLWpKM0XI5HuziHQZgpqiaL9AjdN7R6UPCiv00P
         5fwoIr5Iwa3b43HfUmR9oGVXs5FPc8DlCejvp9wK3Fx8fcYeTs/9Qi8ZOQIWU/m7fXIa
         jQBdEU42YZRlQg5Gpupyfl4gLIf0rTnkwTVqlzY805X5AxCJ0xkD4ODRWA5pd5iDToPA
         jgeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] acpi: device_sysfs: update sysfs documentation
Date: Wed, 14 Mar 2018 12:38:19 +0100
Message-ID: <2522965.OaQQetJcBo@aspire.rjw.lan>
In-Reply-To: <20180213185410.GA27234@mordor.localdomain>
References: <20180213185410.GA27234@mordor.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592313046574811248?=
X-GMAIL-MSGID: =?utf-8?q?1594912895102441890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tuesday, February 13, 2018 7:54:10 PM CET Aishwarya Pant wrote:
> Add documentation for two attributes - status and hrv in
> Documentation/ABI/testing/sysfs-bus-acpi. Compiled from git logs and the
> ACPI specification.
>=20
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-acpi | 36 ++++++++++++++++++++++++++=
++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-bus-acpi b/Documentation/ABI=
/testing/sysfs-bus-acpi
> index 7fa9cbc75344..89feb01d1d0d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-acpi
> +++ b/Documentation/ABI/testing/sysfs-bus-acpi
> @@ -56,3 +56,39 @@ Description:
>  		Writing 1 to this attribute will trigger hot removal of
>  		this device object.  This file exists for every device
>  		object that has _EJ0 method.
> +
> +What:		/sys/bus/acpi/devices/.../status
> +Date:		Jan, 2014
> +Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> +Description:
> +		(RO) Displays the ACPI device status - enabled, disabled or
> +		functioning or present, if the method _STA is present.
> +
> +		Return value is an integer containing a device status bitmap:
> +
> +		Bit [0] =E2=80=93  Set if the device is present.
> +		Bit [1] =E2=80=93  Set if the device is enabled and decoding its
> +		resources.
> +		Bit [2] =E2=80=93  Set if the device should be shown in the UI.
> +		Bit [3] =E2=80=93  Set if the device is functioning properly (cleared =
if
> +		device failed its diagnostics).
> +		Bit [4] =E2=80=93  Set if the battery is present.
> +		Bits [31:5] =E2=80=93  Reserved (must be cleared)
> +
> +		If bit [0] is cleared, then bit 1 must also be cleared (a device
> +		that is not present cannot be enabled).
> +
> +		Bit 0 can be clear (not present) with bit [3] set (device is
> +		functional). This case is used to indicate a valid device for
> +		which no device driver should be loaded.
> +
> +		More special cases are covered in the ACPI specification.
> +
> +What:		/sys/bus/acpi/devices/.../hrv
> +Date:		Apr, 2016
> +Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
> +Description:
> +		(RO) Allows users to read the hardware version of non-PCI
> +		hardware, if the _HRV control method is present. It is most
> +		useful for non-PCI devices because lspci can list the hardware
> +		version for PCI devices.
>=20

Applied, thanks!
