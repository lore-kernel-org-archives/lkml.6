Return-Path: <kernel-hardening-return-12487-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu33pADQHmx+/ZHmRLm+a/LfWzGQGz23ggJCqsUrOQZchb7FwgEUu5h1nEUyzmlt3mwy7Z/
ARC-Seal: i=1; a=rsa-sha256; t=1520903881; cv=none;
        d=google.com; s=arc-20160816;
        b=TuiGBRoXEdfFRx/1nNlT5jwl70Oc3EoorqTT7O8HR5UPKtNc5nIT12uumj/staneE9
         YSvZC7zzF9jqmx79Yfe/5oXsufjbo/FDy86oUCfKOlHYidGsRZke8iGvAfHvQzNY/0oh
         tMgroYCBp+WbPtK/2B1BTHZ0baj0uAl/HsPueCj+bTVY1O1SjeLOtZt1nWvGYPfMJpkv
         If4k9h2KFGe4U0iE7nQIrvCf2vnZJlL84bO8yT3WbFRCMVNfckZXi3loMrpCnUBzGAi/
         qiUDrNTQsmxEevISV9toEZvDcK2g74+X59gIPRE+aGLrfQLld03B99MfHqsznJsUEiYL
         hF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=FvlXP3gl9y/gR3RD5hil/2RNioIYiyqxupHljdE00mk=;
        b=w9BjglYx8RB3AmWZ/L71ythstWkJ/Zl9HXYGj32L9cA90AxqsDSIjyzM2g8W4qPvPl
         NI+hy4+JmX/ThzzHyJh5HmJWchQ7vEkoOlkHv3GK4tAeRB2bu9sIOTUwFsWdceo0/t4u
         VUd4b+S+JsuC6F3v3LQmU/0OdKoXX0cSnPoVLSRAJ1EOSNXJ0uHas08i7CB0K0xX8/kU
         o2Er8FjNcjYU8kRQx6p3HCEaMwaGPWh/BGLLc7bGkh+0rtMRDywyEt86XBcdAk97+YPG
         gsL36fFlMdRr0Kr4cM/8Dl8Bdohhmql/V4ak1w9XAvwtffbGWHNSBk1fEDcxKXF/NgzW
         xpNA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12487-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12487-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12487-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12487-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 0/2] Remove VLA usage in rtc-s5m
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Lee Jones <lee.jones@linaro.org>,
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <cover.1520660422.git.gustavo@embeddedor.com>
 <20180313003540.GF3795@piout.net>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <4323fb5d-0b26-441f-3d7b-3008108f20e0@embeddedor.com>
Date: Mon, 12 Mar 2018 20:17:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313003540.GF3795@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.openwall.com
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1evYZR-001Lq7-2Z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.66]) [189.175.117.58]:42214
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 20
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594530980012652646?=
X-GMAIL-MSGID: =?utf-8?q?1594783308560915055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/12/2018 07:35 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 10/03/2018 at 00:27:02 -0600, Gustavo A. R. Silva wrote:
>> This patchset aims to remove VLA usage from rtc-s5m.
>>
>> The first patch moves an enum from rtc.h to rtc-s5m.c, as this is the
>> only driver in which such enum is actually being used [1].
>>
>> The second patch adds the enum name RTC_MAX_NUM_TIME_REGS, which will
>> be used as a maximum length to the current VLAs, hence turning them
>> into fixed-length arrays instead.
>>
>> [1] https://marc.info/?l=linux-rtc&m=152060068925948&w=2
>>
>> Thanks
>>
>> Gustavo A. R. Silva (2):
>>    rtc: s5m: move enum from rtc.h to rtc-s5m.c
>>    rtc: s5m: Remove VLA usage
>>
> 
> Both applied, thanks.
> 

Awesome.

Thank you.
--
Gustavo
