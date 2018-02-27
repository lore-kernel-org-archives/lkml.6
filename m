Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeB0CxR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:53:17 -0500
Received: from regular1.263xmail.com ([211.150.99.131]:39007 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbeB0CxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:53:15 -0500
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: jeffy.chen@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <2707ec944044f6c1f7a46e577ff78947>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A94C80E.8020203@rock-chips.com>
Date: Tue, 27 Feb 2018 10:53:02 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org
CC: zyw@rock-chips.com, briannorris@google.com, dianders@google.com,
        jwerner@chromium.org, linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v3] rtc: cros-ec: return -ETIME when refused to set alarms
 in the past
References: <20180227024734.7591-1-jeffy.chen@rock-chips.com>
In-Reply-To: <20180227024734.7591-1-jeffy.chen@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 02/27/2018 10:47 AM, Jeffy Chen wrote:
>   		/* Don't set an alarm in the past. */
>   		if ((u32)alarm_time < current_time)
Oops, i'm a idiot, forgot to use '<='... will resend it.
> -			alarm_offset = EC_RTC_ALARM_CLEAR;
> -		else
> -			alarm_offset = (u32)alarm_time - current_time;
> +			return -ETIME;
> +
> +		alarm_offset = (u32)alarm_time - current_time;
>   	}
