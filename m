Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AH8x225q7VcrBdFYp/EJftQxQrWf06igUQbPLJauhAedsWoWm+Yjm/0sOu/8U06yAik6jE5ZM7Fn
ARC-Seal: i=1; a=rsa-sha256; t=1518605569; cv=none;
        d=google.com; s=arc-20160816;
        b=hgIIBnmuQtxDBTDTpBmI8kDgGG6IomIXZANQpWSqFs5G8qg8V6BndJ63DkiG6H9CwO
         AcXPksvLaEROH7fEitB+8KS3RdHUARmIoX1QdA2iSJp/zL8rQVJ8UEwZEIRfnI5ywm1m
         W97YxvB5A91E5Rc00AGTvQSveCFL7MvkpGtjB5l9c+m3Bdb6XfUq62F4XZRGuDElqNiM
         4ZdmP7hdUXAB17Lm3mOkB3P9a0myaxeP82+KWJBI0Y5pV0YGsIaVHjm6kixZb9gRYXij
         Oo3xPHTceHVhz3Zfsw0aSqQsNVPE5KFmrkGuxiM5KIFp4JFfD4lWQN/ZdKtraywOY+W5
         dMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=NYd8SLje3r3LRClJAnAY7uBO1MdMjfEimxfaMU5w1yY=;
        b=nF7pLTU405EdLfCDnltxbDZcv77nKCjJXxxPtsm+rZ/JqJ01JQzLe8hcNLVcD9Yto/
         LpywfvybQ6DVoZo2pYfhR4G53Spmy0z1CjEWekdYNBzcOxQ+1YBdxVNH9TC1JQG2cPbv
         1n3hz2lrwhlLcR2SS0v2bQ5bc08/QKVIh5qJ9FRu8Yw2YRmB5JcNieYgrjTyHuhc5eCy
         QkIlHOzg6gEvf9EWA5ZYik3ovdiBjKRn1lfBR4wkuohItliTIA6gf2bWxLY6ewcLakGq
         Q6kX476B08RXAXhVIefw9TinYXyF/pXMq3PqQl4FOTKCrTyL/VLqXQzxV9qZD1VMu81p
         fxQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v5] Documentation/ABI: update cpuidle sysfs documentation
Date: Wed, 14 Feb 2018 11:51:00 +0100
Message-ID: <6470168.Bc58CWhkOs@aspire.rjw.lan>
In-Reply-To: <20180207133436.GA7440@mordor.localdomain>
References: <20180207133436.GA7440@mordor.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591749365818887442?=
X-GMAIL-MSGID: =?utf-8?q?1592373353717312581?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, February 7, 2018 2:34:36 PM CET Aishwarya Pant wrote:
> Update cpuidle documentation using git logs and existing documentation
> in Documentation/cpuidle/sysfs.txt. This might be useful for scripting
> and tracking changes in the ABI.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v5:
> - Update contact information- LKML -> power management mailing list
> v4:
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
> index bfd29bc8d37a..4ed63b6cfb15 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -108,6 +108,8 @@ Description:	CPU topology files that describe a logical CPU's relationship
>  
>  What:		/sys/devices/system/cpu/cpuidle/current_driver
>  		/sys/devices/system/cpu/cpuidle/current_governer_ro
> +		/sys/devices/system/cpu/cpuidle/available_governors
> +		/sys/devices/system/cpu/cpuidle/current_governor
>  Date:		September 2007
>  Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>  Description:	Discover cpuidle policy and mechanism
> @@ -119,13 +121,84 @@ Description:	Discover cpuidle policy and mechanism
>  		Idle policy (governor) is differentiated from idle mechanism
>  		(driver)
>  
> -		current_driver: displays current idle mechanism
> +		current_driver: (RO) displays current idle mechanism
>  
> -		current_governor_ro: displays current idle policy
> +		current_governor_ro: (RO) displays current idle policy
> +
> +		With the cpuidle_sysfs_switch boot option enabled (meant for
> +		developer testing), the following three attributes are visible
> +		instead:
> +
> +		current_driver: same as described above
> +
> +		available_governors: (RO) displays a space separated list of
> +		available governors
> +
> +		current_governor: (RW) displays current idle policy. Users can
> +		switch the governor at runtime by writing to this file.
>  
>  		See files in Documentation/cpuidle/ for more information.
>  
>  
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/name
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/latency
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
> +		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
> +Date:		September 2007
> +KernelVersion:	v2.6.24
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		The directory /sys/devices/system/cpu/cpuX/cpuidle contains per
> +		logical CPU specific cpuidle information for each online cpu X.
> +		The processor idle states which are available for use have the
> +		following attributes:
> +
> +		name: (RO) Name of the idle state (string).
> +
> +		latency: (RO) The latency to exit out of this idle state (in
> +		microseconds).
> +
> +		power: (RO) The power consumed while in this idle state (in
> +		milliwatts).
> +
> +		time: (RO) The total time spent in this idle state (in microseconds).
> +
> +		usage: (RO) Number of times this state was entered (a count).
> +
> +
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
> +Date:		February 2008
> +KernelVersion:	v2.6.25
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		(RO) A small description about the idle state (string).
> +
> +
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/disable
> +Date:		March 2012
> +KernelVersion:	v3.10
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		(RW) Option to disable this idle state (bool). The behavior and
> +		the effect of the disable variable depends on the implementation
> +		of a particular governor. In the ladder governor, for example,
> +		it is not coherent, i.e. if one is disabling a light state, then
> +		all deeper states are disabled as well, but the disable variable
> +		does not reflect it. Likewise, if one enables a deep state but a
> +		lighter state still is disabled, then this has no effect.
> +
> +
> +What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/residency
> +Date:		March 2014
> +KernelVersion:	v3.15
> +Contact:	Linux power management list <linux-pm@vger.kernel.org>
> +Description:
> +		(RO) Display the target residency i.e. the minimum amount of
> +		time (in microseconds) this cpu should spend in this idle state
> +		to make the transition worth the effort.
> +
> +
>  What:		/sys/devices/system/cpu/cpu#/cpufreq/*
>  Date:		pre-git history
>  Contact:	linux-pm@vger.kernel.org
> 

Applied, thanks!
