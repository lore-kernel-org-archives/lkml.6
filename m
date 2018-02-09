Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518171969; cv=none;
        d=google.com; s=arc-20160816;
        b=GQ2N5bmR9LIE1ovqcOp7RGDiNwnuQIOqAS/N/AYNV+UX1eOHvFZp4mVD6EyhaBn64/
         aSpftv9+GxfJV5qk89SBhbOPSY+pW5/aWy9VS1Akyx1RTxHTXCYZDyibdyr56uUiRnXr
         tAMsFclcTD7NPVgdUupXTP7XJMlsx81p3f/NJCm3yvoVHtHNViTeCYf+YwB42DPvJCCD
         OR42gxdbZQj+Es1Vwej99HAvkUuDCY9LpTjYqT1Solj50K//s/PAaZq/h9zo7B24641o
         LF0aVKo7MscU3bhUWyJJ16L7ZQr2+58kfnWLk4ujkKx7/wH63xak8XmecEfnLwLJvTFJ
         bKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=EJ+o+HZ4E5BcWwtNsL+YsNoTdDnicQkd20W4yuZUlt8=;
        b=Mg5+wJr58BHGgCDHw/RUzYLg/FaG1LZ94z7tnKurvkxPlLfkB/deGfH+eAewNf+za4
         iTrWNZkKoeI1oW2hO+oahAJCng18XZhyjKF5W3nSEfq5bDfzwVZPcoc8aamPDzro8uoq
         2hNVuVTus40N20AUFaU0PkY60ucTZnglR3sLbqHqpsOtZJsPmGhZpXonLUUHxNPoCMtb
         AYe4OqjSl1Ie+k3EdJ68yrHk/kT9vZDz4oNQwSxdtXQ9jfHVrsm+qWqUt4vQgdj5HMkR
         Hwwz/Ndx+bvJcf2KonX7sZySHd0jUoVPAfUcm6qxSgHaVpii3eIyJbUwpI+zo3iuRJsF
         /MfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fbV41LWr;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fbV41LWr;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AH8x224sir/3EkPRWIRJAVlqwUbpfV3KcQ9UUF/cTyS06dDu+I4hxwhnnXIpX4WhHbHC/CODr9aTE8Q/++a7dw3VATQ=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <9dff9dee68daf82305de32c45604757eca93afaf.1518009225.git.aishpant@gmail.com>
References: <cover.1518009225.git.aishpant@gmail.com> <9dff9dee68daf82305de32c45604757eca93afaf.1518009225.git.aishpant@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 11:26:07 +0100
X-Google-Sender-Auth: ht4dRizl3NA-y_BCvhYah5ZaB5c
Message-ID: <CAJZ5v0iEp6XkOQtKN8pQBnoOShrinwkZ5wdFUutLFFtPQUT=vA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] acpi/dock: document sysfs interface
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591748334124741028?=
X-GMAIL-MSGID: =?utf-8?q?1591918690848896543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 2:18 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> Description has been collected from git commit history and reading
> through code.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
>  .../ABI/testing/sysfs-devices-platform-dock        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-dock
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-dock b/Documentation/ABI/testing/sysfs-devices-platform-dock
> new file mode 100644
> index 000000000000..0bb0d42e9126
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-dock
> @@ -0,0 +1,38 @@
> +sysfs interface for ACPI dock station driver
> +--------------------------------------------
> +
> +What:          /sys/devices/platform/dock.N/docked
> +What:          /sys/devices/platform/dock.N/undock
> +Date:          Dec, 2006
> +KernelVersion: 2.6.19
> +Contact:       linux-acpi@vger.kernel.org
> +Description:
> +               docked: (RO) Value 1 or 0 indicates whether the software
> +               believes the laptop is docked in a docking station.
> +
> +               undock: (WO) Writing to this file causes the software to
> +               initiate an undock request to the firmware.

Please split the above into two entries.

Apart from that it looks OK to me.
