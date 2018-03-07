Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELtpKBTbR/fhNer4aKCOq8wSWdf2RyMEvPgKmx1EekdGec5Z5x2tOORm9yyjDFpC1QLHHwK3
ARC-Seal: i=1; a=rsa-sha256; t=1520420184; cv=none;
        d=google.com; s=arc-20160816;
        b=XEHsurzpCW4QHn0zQ5mOfFNfIJhMhXDxPddMwqRPGzm89jjekvJ46wN88w+q98OuEf
         Nyt+XaTOROG9POx1kgq+DhlyD2JdAoaA+yJg5O3jRvtX4zXLfBgaNxc4ONjLRNZY0BC0
         84DOQG3nITDhxLI0iB4xEHkVLdfLFQ+XJkODkfH58UicxB7kkQ+Lz70nVIEBu6z3SNOy
         iZMmDg4E8iVZxti7QuRUnclON0Dfuf/9OYtzHYRqGALKScw285PBVyixFA/k7MdBkK0P
         Im2U41jhr9WPCKICuxXsfZIEhewt+CuDw2nnby44zEORa7CuPxGL8mrGTzvqyn3VtXyj
         tM6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=WNe+RP4ji2YmdB14fgBFKuFeXqHMsQyp32k5oXudsKI=;
        b=mIBMqF1cAu//XDKowYuYK6peS91oZiwHQvOHLvEs/k/vpQBHpwXpPUiprv13XDWtS3
         0u5PyR25js355B0fdX8HmUJq5JXDKuO62iLAxiTKpt+KbaXY22DwbZXzVJCMI1HYZx/Z
         cjMEhZaUsugMJiSp5NbSvanMHp/UE+BL03wCy9xv00ovYA+iKakcP0qWx80xLMQWTwx0
         qoY9sclYEZbd/V4QhkGNPKvHTcnLrw9bXhFe84KhUGr8gqSIOVYnqqp1Cgw6M85i8XRn
         OOf49ukV1Tjio5RntsTj+1gHxS0YMx3YvBe71uVDtSn6YBQffDPwpg47CJwHdl+lQYpg
         nczw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.27 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.27 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <a4f03df5b8ef8fc9192b6648bb17a11c>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5A9FC551.5090909@rock-chips.com>
Date: Wed, 07 Mar 2018 18:56:17 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
CC: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/3] regmap: debugfs: Fix kmemleak in regmap_debugfs_init
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com> <20180306110403.14438-2-jeffy.chen@rock-chips.com> <20180306125916.GA13586@sirena.org.uk>
In-Reply-To: <20180306125916.GA13586@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594186041905499825?=
X-GMAIL-MSGID: =?utf-8?q?1594276114971326502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Mark,

Thanks for your reply.

On 03/06/2018 08:59 PM, Mark Brown wrote:
> On Tue, Mar 06, 2018 at 07:04:02PM +0800, Jeffy Chen wrote:
>> Use map->debugfs_name to store allocated debugfs name, so it would be
>> freed in regmap_debugfs_exit().
>
> I'm missing patch 1 in this series and I think this collides with a fix
> I already have locally.
>
sorry for that, i should CC you the whole seires.

the patch 1 should be:
https://patchwork.kernel.org/patch/10261413
