Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZoFK5fhcRjtrt5sxfUMT0EA12W1OFl4yjqYtgQLxow0+JuX9XVDTIi8UUCuQY9TtfV1CcjI
ARC-Seal: i=1; a=rsa-sha256; t=1525962398; cv=none;
        d=google.com; s=arc-20160816;
        b=W4k51WZZ6+ZR3MEVTDM20LlHocq64BrFRVhl0D/CRqT+tJXcMv8JE9h8r/hrjJWpHB
         vwDxImKd9Vlc0sLv5blUz3kXLmyIsgasvbgF++wN+EM8kc63lvRLdqKMGoDYkjRulVwO
         3lkyqj+lHYXPGbHPfrGjaWaocFDEHaz8TvUpwVt1kR/6wzqw2kDpVIyu1RNU+oX2VNOg
         wJJYd6TanJ6ldQLG45wizcR4Jpwdyrfa4XcT2DtDYTCOUoZCNz7LxvrXOTYWveGMSvn8
         jFMgoYBWIMBph0T4vceN4X5TK0L62r0gc9rpfJ81x3r5ovTxiP74ouXuSxpF7cDnSJiB
         8rwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=YPZu+Zi2+f4Tim+qM3rXfD6upAXMYQWriuytU14HQRw=;
        b=VZ0Qc+5inNP1wg0QfHHXzt26UOz8VfcvUwbczxAXSjGViuhcWDYoWKBfuMqqt4BRGt
         O9dWoDn4cP0OUjgjNoYEeYvoCU1iWcnHOsuifXFFd6Wy1jiJRi2yer2kGpYMh77ECq3B
         xMDffWjJ/Uh0nZcyYfusScnZZiNxyDLJWUjarOl7gSetqmJJ8eMhf2hXJdMgnH/9DAvM
         4CL5CnDwwmygEbynZU14IwMZtRV8SkdwTmUWrkBM1pJAPpXyadN6XW6g6jYepdI8Czut
         DzITBGO/osEQWFW2j6jMOQjIlt9tCEM2BM30nwzbBzbStPlBlY9vUqBqpqBDLKfDGV4G
         TkPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>, rajanv@xilinx.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jolly Shah <jollys@xilinx.com>
Subject: Re: [PATCH v6 06/11] firmware: xilinx: Add debugfs interface
To: Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
 mingo@kernel.org, gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
 hkallweit1@gmail.com, keescook@chromium.org, dmitry.torokhov@gmail.com,
 mturquette@baylibre.com, sboyd@codeaurora.org, michal.simek@xilinx.com,
 robh+dt@kernel.org, mark.rutland@arm.com, linux-clk@vger.kernel.org
References: <1523389127-14243-1-git-send-email-jollys@xilinx.com>
 <1523389127-14243-7-git-send-email-jollys@xilinx.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <b880a598-54cb-6428-e60d-232615e809c1@arm.com>
Date: Thu, 10 May 2018 15:26:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523389127-14243-7-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597389330105721764?=
X-GMAIL-MSGID: =?utf-8?q?1600087547495218998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 10/04/18 20:38, Jolly Shah wrote:
> From: Rajan Vaja <rajanv@xilinx.com>
> 
> Firmware-debug provides debugfs interface to all APIs.
> Debugfs can be used to call firmware APIs with required
> parameters.
> 
> Usage:
> * Calling firmware API through debugfs:
>   # echo "<api-name> <arg1> .. <argn>" > /sys/.../zynqmp-firmware/pm
> 
> * Read output of last called firmware API:
>   # cat /sys/.../zynqmp-firmware/pm
> 
> Refer ug1200 for more information on these APIs:
>   * https://www.xilinx.com/support/documentation/user_guides/ug1200-eemi-api.pdf
> 
> Add basic debugfs file to get API version.
Who are the users of this apart from debugging ? I am bit over sensitive
as this remote processor manages/controls the power and other shared
resources in the system. Giving such fine grained access to user space
is not a good idea. I assume you want this DEBUGFS off by default on
production images ?

-- 
Regards,
Sudeep
