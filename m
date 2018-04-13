Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523600865; cv=none;
        d=google.com; s=arc-20160816;
        b=Wb7F1R3uhP67z3ZUO68VkLvQqNFIwv7GnfeDF2sxyyPwMwnp+m3s3o/FDDpk+zdI44
         A0+/daf8FIPzH+Rx0Ca2YbpFjtocyDU8lMDmdmdRcE1nYT5KpFGfBDWy0RbEhMEZrB1v
         wneqy6ZOmQxYyoU+tEIsAflTMWiX9AhUeIombUwkgyRVRJDFUxNrH0fEvJI+aMZI3YVv
         1mMvQ/L7Ps8tc8oyucHUGoqf2ZvGN9lYAdcX0fGo8GDnxDJp+UqOvCxANgIwWW6xvmLl
         b3HhUccbqhUajfplkh4E79sAoaV8arr0+oXZwgYa5Fn+cNTB+BZXvWmQiLRp8dOsdxUV
         D4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=+eGhczVEAox5X8YuNvV0+YCfhdAxzyY4DOPZ5nfMU8I=;
        b=R9Hja9XE6/p1r7b7Jm7b54Ftqn7Gr+opdrZpVsC9G+3dWDvTRQWs5i7Sh/abb7iCHC
         o/sKdjGbThw7DXsXzjSNpNMjbFzmFqELvfVDmWkG3fzFvkEIsYptv8gb0RRyUKT0hf3a
         vl+Npadpj1B5UbIcU/8g7H58H/VOn8gU8J/CCy3tC0Cpz35403c8xIeYa3ZmDlL+KBg8
         cWp1ApNpwTdMPCaXT3T8vDVjI6w8p5xMW+i/oi0InlYUbQ2gPzn2nApZdjuScj2fVz6j
         xAcNZ+YqnP8vVfvgQfLWij183e2Ygg2lShOSsF/fcv8Ys5YYTP3QzU4gI2JgmSePgDZL
         fndg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GUT2QmT/;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GUT2QmT/;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+U6hv7xcX3WNTHZOaGfI0t4v9fMm9yKNE6873X9ywo2ePtDKdqxQTyF5HXjw1qiHWsb/RGLA==
Date: Fri, 13 Apr 2018 11:57:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steve Muckle <smuckle@google.com>,
	Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] sched/fair: Introduce an energy estimation
 helper function
Message-ID: <20180413062741.GA17616@vireshk-i7>
References: <20180406153607.17815-1-dietmar.eggemann@arm.com>
 <20180406153607.17815-5-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406153607.17815-5-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597011688129622279?=
X-GMAIL-MSGID: =?utf-8?q?1597611301597387530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 06-04-18, 16:36, Dietmar Eggemann wrote:
> +static inline struct capacity_state
> +*find_cap_state(int cpu, unsigned long util) { return NULL; }

I saw this somewhere else as well in this series. I believe the line break
should happen after "*" as "struct capacity_state *" should be read together as
one entity.

-- 
viresh
