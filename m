Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517999775; cv=none;
        d=google.com; s=arc-20160816;
        b=djMmdMaw45A7eSW0ReZ6uQm/LtY2X1XUp0Hjx6qyHoD8tzRxWotZY/PArZAVlSjbIs
         w34gp8MBaKr8o9g1OaUI5OCTXI3oMB6vnJGA5W+u3wjgr72ndm4tYhjwy1F8jC0jUGMa
         ehYAq+puEy+kLiZ46RyWe7iwM0OosZGVvAw9MvbcWT2oK04agJS7n1c1NF3tvviLPrpj
         7nxPruOw9Ud9rthWnpz8r6abMrHjWlwqNlzJQxnvyG7nDnRyqSwgMfUXCVliDjSRlIaC
         ygxriz1bUXHegnvr7Kv8bG+4AZ85bPDOz8TP1P9eSIL2mOzpvsgd7euEqtI8Z/5n5JgM
         6gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=I2WpRb1oP7REZunZljEnkIcWKc3bheNFUWvHnwkfLL4=;
        b=RaUsLy1h9XQIqaPyQpQR+UjSaG9fi3nAPiYcRhWHNu4ahs5DnYh3E9UnCrEcMZA0b2
         9dWcWTbIBDBnF70mxQu3RH4XMuNWZmU0ItTzeg2A1936/ymu3u1HEWZvn7nCywNHqmTU
         V3XsYln32MQWDtC58KTI37LeXI0MQMZdnscD657AFAO+J3DUL1dBPIuBkr25JyGE0Tf7
         b5Uy2RRqzoRVE6DxrLr8zHqs8chPNqro4zR9n5eFaNts0Ycu5aRVGhnWYr299A1Oe78g
         UaXiT5wiqieTUeZz3HNTJtroLkJzyeKZnMvGsGrfgwESTMwjpk6R9rV8zLIFTMHBxJcu
         GdTg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sb+IWXW+;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sb+IWXW+;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AH8x227PjEfrH3FQbxQaqpRZ8gGrV1qCHtPPxta2ooSP3TpyJRsRRfhnfguyOI1z83IitO1qoeCIZTQn+fica5hBEmI=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180206191955.GA19222@mordor.localdomain>
References: <20180206191955.GA19222@mordor.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Feb 2018 11:36:15 +0100
X-Google-Sender-Auth: RSf6947RWYnu0PIcCvJQzrsIUPE
Message-ID: <CAJZ5v0gNZSoLgpKy60NEF=RhPLOFwwoKTRA4uDbgBhrGEvxkMA@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation/ABI: update cpuidle sysfs documentation
To: Aishwarya Pant <aishpant@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591680488853193567?=
X-GMAIL-MSGID: =?utf-8?q?1591738133244714594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 8:19 PM, Aishwarya Pant <aishpant@gmail.com> wrote:
> Update cpuidle documentation using git logs and existing documentation
> in Documentation/cpuidle/sysfs.txt. This might be useful for scripting
> and tracking changes in the ABI.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v4:
> - Fix patch formatting
> v3:
> - Fix subject line
> v2:
> - Merge cpuidle_sysfs_switch attributes' description with the previous
>   entry.
>
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 77 +++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index bfd29bc8d37a..e9ee67f80933 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -108,6 +108,8 @@ Description:        CPU topology files that describe a logical CPU's relationship
>
>  What:          /sys/devices/system/cpu/cpuidle/current_driver
>                 /sys/devices/system/cpu/cpuidle/current_governer_ro
> +               /sys/devices/system/cpu/cpuidle/available_governors
> +               /sys/devices/system/cpu/cpuidle/current_governor
>  Date:          September 2007
>  Contact:       Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:   Discover cpuidle policy and mechanism
> @@ -119,13 +121,84 @@ Description:      Discover cpuidle policy and mechanism
>                 Idle policy (governor) is differentiated from idle mechanism
>                 (driver)
>
> -               current_driver: displays current idle mechanism
> +               current_driver: (RO) displays current idle mechanism
>
> -               current_governor_ro: displays current idle policy
> +               current_governor_ro: (RO) displays current idle policy
> +
> +               With the cpuidle_sysfs_switch boot option enabled (meant for
> +               developer testing), the following three attributes are visible
> +               instead:
> +
> +               current_driver: same as described above
> +
> +               available_governors: (RO) displays a space separated list of
> +               available governors
> +
> +               current_governor: (RW) displays current idle policy. Users can
> +               switch the governor at runtime by writing to this file.
>
>                 See files in Documentation/cpuidle/ for more information.
>
>
> +What:          /sys/devices/system/cpu/cpuX/cpuidle/stateN/name
> +               /sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
> +               /sys/devices/system/cpu/cpuX/cpuidle/stateN/power
> +               /sys/devices/system/cpu/cpuX/cpuidle/stateN/time
> +               /sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
> +Date:          September 2007
> +KernelVersion: v2.6.24
> +Contact:       Linux kernel mailing list <linux-kernel@vger.kernel.org>

Please replace "Linux kernel mailing list
<linux-kernel@vger.kernel.org>" with "Linux power management list
<linux-pm@vger.kernel.org>" here and below.

> +Description:
> +               The directory /sys/devices/system/cpu/cpuX/cpuidle contains per
> +               logical CPU specific cpuidle information for each online cpu X.
> +               The processor idle states which are available for use have the
> +               following attributes:
> +
> +               name: (RO) Name of the idle state (string).
> +
> +               latency: (RO) The latency to exit out of this idle state (in
> +               microseconds).
> +
> +               power: (RO) The power consumed while in this idle state (in
> +               milliwatts).
> +
> +               time: (RO) The total time spent in this idle state (in microseconds).
> +
> +               usage: (RO) Number of times this state was entered (a count).
> +
> +
> +What:          /sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
> +Date:          February 2008
> +KernelVersion: v2.6.25
> +Contact:       Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:
> +               (RO) A small description about the idle state (string).
> +
> +
> +What:          /sys/devices/system/cpu/cpuX/cpuidle/stateN/disable
> +Date:          March 2012
> +KernelVersion: v3.10
> +Contact:       Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:
> +               (RW) Option to disable this idle state (bool). The behavior and
> +               the effect of the disable variable depends on the implementation
> +               of a particular governor. In the ladder governor, for example,
> +               it is not coherent, i.e. if one is disabling a light state, then
> +               all deeper states are disabled as well, but the disable variable
> +               does not reflect it. Likewise, if one enables a deep state but a
> +               lighter state still is disabled, then this has no effect.
> +
> +
> +What:          /sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
> +Date:          March 2014
> +KernelVersion: v3.15
> +Contact:       Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:
> +               (RO) Display the target residency i.e. the minimum amount of
> +               time (in microseconds) this cpu should spend in this idle state
> +               to make the transition worth the effort.
> +
> +
>  What:          /sys/devices/system/cpu/cpu#/cpufreq/*
>  Date:          pre-git history
>  Contact:       linux-pm@vger.kernel.org
> --
> 2.16.1
>
