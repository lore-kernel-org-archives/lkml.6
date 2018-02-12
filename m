Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518419438; cv=none;
        d=google.com; s=arc-20160816;
        b=ugmPg9iazYSgwk106xQyW+MutReV8V5OzxV5F0cSu+fZtHIGjNs7G69+U4zhkBBlpu
         Yxi49yi90C5auZgr9m8tHiy1EYe6hNeRKHczkOrFCofYPfiLHw9lf0ZUbmf37qB94drr
         VQz4KX1+7lwC09bsySvLHjQK7okIVPhTM5/eokWxbbFE1RH/SjwPJY7xufuOlgShPR7T
         fbwbRFedFFBaRoXQMrX8sWBZSJp1KVVJG6gaAR2YHbPn0yZmo/MNFQ/DyOCJuOfbSlnE
         OqUJCB34WygQnITiuHMVvBTF1du9Ohd7V5LQW4Uf4nRX4a/Y31L3lbc8yUHmK/zKj1I0
         S1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=q8ItJMFFpjjCY+0rzeKRGMmb1BKWoeWb2BU362hgUP8=;
        b=HQ7EkGSVGskjjT9BP9ztpv1EemghyVxpsguejPugvZZNlvxQ0LLuHPFYiMIW0dQORb
         o1i2sZK8H8AMJFRUcpvITZBUB4xGYOxa9S4Qs7b02ngmOx02zwQ+Vg/CGZJDTmHgqpcA
         jCQNBa4EMXumMz++fxKYJTbcbGDfRY4KVcxGiwp9jlY90JI/hkUu7EJPPb6troxhPQI3
         HXuMfXQL//9wfodQuh6Ic9q1fXMeq/yWSyMzKVpN9jAj1ZLKstsjqXl9aoXiLzeky3IB
         nVgHZvzdRdmnX0Aj8QbtUEc/R5EYQdce8MCuDiI1YL4AQ1md9VZ6u+uLYtwhYGR69lBp
         f1Zw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hpp8gKY/;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hpp8gKY/;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224csTDZZqgEgagxmIkOLmIm50Tff0grsidHVMWPzarxhf8BKkM5wgMGM4h88Wd6VJ3h9WfNkA==
Date: Mon, 12 Feb 2018 12:40:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Rajendra Nayak <rnayak@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	Rob Clark <robdclark@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>, Nishanth Menon <nm@ti.com>,
	Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH V6 Resend 00/13] drivers: Boot Constraint core
Message-ID: <20180212071034.GP28462@vireshk-i7>
References: <cover.1515554879.git.viresh.kumar@linaro.org>
 <CAL_Jsq+CtWCKENTQmiveoubxU4cDi9QBcpgvYZVfxPNsT-VX+g@mail.gmail.com>
 <20180125110125.GA3307@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180125110125.GA3307@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1586774022832035063?=
X-GMAIL-MSGID: =?utf-8?q?1592178180923757394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 25-01-18, 16:31, Viresh Kumar wrote:
> So AFAICT the basic problem I was trying to solve still exists with simple-fb
> as well. And the problem is that nothing prevents another driver to get probed
> before the display driver (or simple-fb) and reconfigure the resources. Even if
> we let simple-fb come up really early, the resources like clk/regulator may not
> be available. And so the ordering thing is still unsolved for me.

Ping !!

I understand your concerns Rob, they are surely genuine and I can't
deny that. But I don't see a cleaner "way" (Or "Hack", if you want to
call it that way), to solve these ugly problems.

-- 
viresh
