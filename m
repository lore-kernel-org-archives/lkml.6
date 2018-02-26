Return-Path: <tcminyard@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519658245; cv=none;
        d=google.com; s=arc-20160816;
        b=e7j9AJVaifyAgQEq6yWjGotMU8la2xjYkoh5i2qtkhf+BR4Vel0aTR19dM29aUkmNk
         /pJYw0l23jhSaqDBmwSeBkZ4PsVDaBm9AUsU6/fX7gqLLelVVolnMf7ssuK207sHS4JL
         qDyIDBUTKo5EecAcYrlQbW5jSl4bZoWjclUGsqeMeaswZ8OqxdDmO9ObKN9yfNWa6vcM
         P99r2xdN6LDRrZITFPwnKkIwE3NUvonmOBuzsiDTLfEdc0nw66fwPEBK8twzuOvD3rRd
         rEGIzo1NkINFXaRFmOjhhi3BwG/4qi2wk3KdpRZ7UYOQXQ27S+P149ftsnm+7xfNnQCW
         cffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:reply-to
         :sender:dkim-signature:arc-authentication-results;
        bh=wnGyO6AZTjLMJ3BoN46jD7dalcFsom6F0bs9fTcI9aQ=;
        b=IO3dvpovLuFU+vYHrwY47E7u9NZj77Ws6jqNYHYEiaMwCM1z6p/lHpeZjbVAyD+FoC
         n9tViWVJgHzMgoneiQesGm/8EYqjkitkOgwCljMxRH7DRX4CAIEUJoxlWxBc6lv4Z4qJ
         MNmygBahEXc2pANpvSDycni1h68lhvkVaGUx3ajFxs34pTZu0SJSwtrIpJ4ojev9Yn1S
         Zxbf1nf77V3nNOwzkqHtc2tAnqDUW+WOMGI5Im9Kc6HQrr4p03rxwHddBdLPh8MN8guj
         jjKjRefFwNPs9ChEN79PneIdS7+YATR7IGosn4454EKreZ8gOQToR5DTOvKajJoqFaPW
         uqmg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sq4vYbPC;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Sq4vYbPC;
       spf=pass (google.com: domain of tcminyard@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=tcminyard@gmail.com
X-Google-Smtp-Source: AH8x226YNytP1qNj5HNnkU4h3M955Qei7n3XxCa4Q+o8vGFhyXS+1rIdhR+ZMaZSTddrP1Zb6LJDkQ==
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
Subject: Re: [PATCH] char/ipmi: add documentation for sysfs interface
To: Aishwarya Pant <aishpant@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
Cc: Julia Lawall <julia.lawall@lip6.fr>
References: <20180224090645.GA15344@mordor.localdomain>
From: Corey Minyard <minyard@acm.org>
Message-ID: <5df2a0a6-d99e-58c1-eb06-cac063b4024c@acm.org>
Date: Mon, 26 Feb 2018 09:17:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180224090645.GA15344@mordor.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593272656676320677?=
X-GMAIL-MSGID: =?utf-8?q?1593477164710084351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/24/2018 03:06 AM, Aishwarya Pant wrote:
> This is an attempt to document the sysfs interface for the IPMI drivers.
> Descriptions were collected from v2.0 of the IPMI specification and from
> code comments.
>
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Wow, you spent some time on this.  It all looks accurate, it's in my tree.

Thanks,

-corey

> ---
>   .../ABI/testing/sysfs-devices-platform-ipmi        | 238 +++++++++++++++++++++
>   1 file changed, 238 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-ipmi
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-platform-ipmi b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> new file mode 100644
> index 000000000000..2a781e7513b7
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-platform-ipmi
> @@ -0,0 +1,238 @@
> +What:		/sys/devices/platform/ipmi_bmc.*/firmware_revision
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) The major and minor revision of the firmware.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/aux_firmware_revision
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Holds additional information about the firmware revision,
> +		such as boot block or internal data structure version numbers.
> +		The meanings of the numbers are specific to the vendor
> +		identified by Manufacturer ID.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/revision
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Device revision. Useful for identifying if significant
> +		hardware changes have been made to the implementation of the
> +		management controller.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/provides_device_sdrs
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Indicates whether device provides device sensor data
> +		records (1) or not (0).
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/device_id
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Device id is specified by the manufacturer identified by
> +		the Manufacturer ID field. This field allows controller specific
> +		software to identify the unique application command, OEM
> +		fields, and functionality that are provided by the controller
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/additional_device_support
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Lists the IPMI ‘logical device’ commands and functions
> +		that the controller supports that are in addition to the
> +		mandatory IPM and Application commands.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/ipmi_version
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Displays the IPMI Command Specification Version.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/manufacturer_id
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Identifies the manufacturer responsible for the
> +		specification of functionality of the vendor (OEM)-specific
> +		commands, codes, and interfaces used in the controller.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/product_id
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Displays a number that identifies a particular system,
> +		module, add-in card, or board set. The number is specified
> +		according to the manufacturer given by Manufacturer ID.
> +
> +For detailed definitions of the above attributes, refer to section 20.1 'Get
> +Device ID Command' of the IPMI specification v2.0.
> +
> +
> +What:		/sys/devices/platform/ipmi_bmc.*/guid
> +Date:		Mar, 2006
> +KernelVersion:	v2.6.17
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) A GUID (Globally Unique ID), also referred to as a UUID
> +		(Universally Unique Identifier), for the management controller,
> +		as described in section 20.8 'Get Device GUID Command' of the
> +		IPMI specification v2.0.
> +
> +
> +What:		/sys/devices/platform/ipmi_si.*/type
> +Date:		Sep, 2017
> +KernelVersion:	v4.15
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) The device interface for IPMI "kcs", "smic", "bt" or
> +		"invalid"
> +
> +What:		/sys/devices/platform/ipmi_si.*/idles
> +What:		/sys/devices/platform/ipmi_si.*/watchdog_pretimeouts
> +What:		/sys/devices/platform/ipmi_si.*/complete_transactions
> +What:		/sys/devices/platform/ipmi_si.*/events
> +What:		/sys/devices/platform/ipmi_si.*/interrupts
> +What:		/sys/devices/platform/ipmi_si.*/hosed_count
> +What:		/sys/devices/platform/ipmi_si.*/long_timeouts
> +What:		/sys/devices/platform/ipmi_si.*/flag_fetches
> +What:		/sys/devices/platform/ipmi_si.*/attentions
> +What:		/sys/devices/platform/ipmi_si.*/incoming_messages
> +What:		/sys/devices/platform/ipmi_si.*/short_timeouts
> +Date:		Sep, 2017
> +KernelVersion:	v4.15
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +
> +		idles:			(RO) Number of times the interface was
> +					idle while being polled.
> +
> +		watchdog_pretimeouts:	(RO) Number of watchdog pretimeouts.
> +
> +		complete_transactions:	(RO) Number of completed messages.
> +
> +		events:			(RO) Number of IPMI events received from
> +					the hardware.
> +
> +		interrupts:		(RO) Number of interrupts the driver
> +					handled.
> +
> +		hosed_count:		(RO) Number of times the hardware didn't
> +					follow the state machine.
> +
> +		long_timeouts:		(RO) Number of times the driver
> +					requested a timer while nothing was in
> +					progress.
> +
> +		flag_fetches:		(RO) Number of times the driver
> +					requested flags from the hardware.
> +
> +		attentions:		(RO) Number of time the driver got an
> +					ATTN from the hardware.
> +
> +		incoming_messages:	(RO) Number of asynchronous messages
> +					received.
> +
> +		short_timeouts:		(RO) Number of times the driver
> +					requested a timer while an operation was
> +					in progress.
> +
> +
> +What:		/sys/devices/platform/ipmi_si.*/interrupts_enabled
> +Date:		Sep, 2017
> +KernelVersion:	v4.15
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Indicates whether interrupts are enabled or not. The driver
> +		disables interrupts when it gets into a situation where it
> +		cannot handle messages due to lack of memory. Once that
> +		situation clears up, it will re-enable interrupts.
> +
> +
> +What:		/sys/devices/platform/ipmi_si.*/params
> +Date:		Sep, 2017
> +KernelVersion:	v4.15
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		[to be documented]
> +
> +
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/type
> +Date:		Sep, 2017
> +KernelVersion:	v4.15
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		(RO) Shows the IMPI device interface type - "ssif" here.
> +
> +
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/hosed
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/alerts
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/sent_messages
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/sent_messages_parts
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/received_messages
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/received_message_parts
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/events
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/watchdog_pretimeouts
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/flag_fetches
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/send_retries
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/receive_retries
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/send_errors
> +What:		/sys/devices/platform/dmi-ipmi-ssif.*/receive_errors
> +Date:		Sep, 2017
> +KernelVersion:	v4.15
> +Contact:	openipmi-developer@lists.sourceforge.net
> +Description:
> +		hosed:			(RO) Number of times the hardware didn't
> +					follow the state machine.
> +
> +		alerts:			(RO) Number of alerts received.
> +
> +		sent_messages:		(RO) Number of total messages sent.
> +
> +		sent_message_parts:	(RO) Number of message parts sent.
> +					Messages may be broken into parts if
> +					they are long.
> +
> +		receieved_messages:	(RO) Number of message responses
> +					received.
> +
> +		received_message_parts: (RO) Number of message fragments
> +					received.
> +
> +		events:			(RO) Number of received events.
> +
> +		watchdog_pretimeouts:	(RO) Number of watchdog pretimeouts.
> +
> +		flag_fetches:		(RO) Number of times a flag fetch was
> +					requested.
> +
> +		send_retries:		(RO) Number of time a message was
> +					retried.
> +
> +		receive_retries:	(RO) Number of times the receive of a
> +					message was retried.
> +
> +		send_errors:		(RO) Number of times the send of a
> +					message failed.
> +
> +		receive_errors:		(RO) Number of errors in receiving
> +					messages.
