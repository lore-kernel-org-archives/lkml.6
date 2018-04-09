Return-Path: <peterz@infradead.org>
X-Google-Smtp-Source: AIpwx49YSS5Qgu1ccZkwI7jHhkntG1LcIoOOJ0UBdYw1Rk80zbid4NVKClqkiCnEyr6aRnoRoVYh
ARC-Seal: i=1; a=rsa-sha256; t=1523274584; cv=none;
        d=google.com; s=arc-20160816;
        b=M5EkIxcTBYfVCY71wILK2LFL+rH5/CDdqIe43QV2oECuyGMnQ5b/H7Uf4BbjS7lqAp
         Sscxr4vj3w6X4Cx/f7A45Rw9zFZhQhG+Ob5h01jN+7eOtGrJiNOHnqK9OUYKeqvQgnut
         ghPnpt5Sa+wreIhggZU+HqZNHcEJA99X+MOcDQ0vTMrLOVQRKMW12X8k0RWeumSIyFLJ
         I7YW5PxZad0QcyhjbfNnZSwAsdLqbvJS6SMeYB/+nm4ukuI9MkOrfzSJlclip1ZEOnC+
         Grin16aMG8VKqPZWkBhA4csMBnC+8bavWu7JBqAnmDZeCFyjI850quHdK4Qbqm6tKwKT
         l9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=5lV3DU4C36WDb77uD/ytIb7zCAZDIFJSwY5LZ+wmq20=;
        b=0o8eRaei0bAeBosn48e8iqcDRfqPdkhxz4jfoik3AC3VHU7g1YEvbSXOTbHK6y9JQJ
         8MVMa1GpSZzv0xhs47ro8CsIYglxk0LnNXd63vOF91QVXDf4dY2AV9XAGbIf1FrC6Ojs
         eMC6UqbmtcZAL1wwLrakotT26+iJyMswhIth7QZnhyeZWQ67PWeAkHqsIIq0rLCr+yxj
         lchQS3nB9AlKPd2d03NZcNhlP3jGL3xIws6jCeJHH9KN8f6LBx6eZrjpxQyKPGdFmfP1
         x8wxhNokZv5qBHi8WLmN474IEIBfr1c7mZ2kacIVAgpquqTpl5zJecNuLBeq+cQ9Vru0
         ZUrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GpXyDjOc;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=GpXyDjOc;
       spf=pass (google.com: best guess record for domain of peterz@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=peterz@infradead.org
Date: Mon, 9 Apr 2018 13:49:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 3/6] sched: Add over-utilization/tipping point
 indicator
Message-ID: <20180409114932.GY4082@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-4-dietmar.eggemann@arm.com>
 <20180409094001.GZ4043@hirez.programming.kicks-ass.net>
 <093ba425-4f81-9f86-78a6-1cd1fd4651f9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <093ba425-4f81-9f86-78a6-1cd1fd4651f9@arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449336588138126?=
X-GMAIL-MSGID: =?utf-8?q?1597269170602808427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 11:53:00AM +0200, Dietmar Eggemann wrote:
> But the patch changes this part further down.

Yes.. let's call it Monday morning sickness :-)
