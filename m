Return-Path: <tony@atomide.com>
X-Google-Smtp-Source: AB8JxZqpnUZ5J2OicPolxGhDKJsAXGw4CptMQ3CAvz4wEysiCykoFHcZUD98zJhanfouHILJ49j0
ARC-Seal: i=1; a=rsa-sha256; t=1526345626; cv=none;
        d=google.com; s=arc-20160816;
        b=V4viFwFOWxQgLxAu7xGDTKALDszu7mQa582ZKbbwXxb5N7amMmWrYHa9DR/NrGQOdD
         0ev9Bq+4rpEsRe4UarSDeMmijaf6brzauYMU2lpIxgh0phOPItW+VZTzUtuMKCaf/mRY
         NLf2jq5ia+AQA8N5869Q483WTKiNhojFAT8iOK0aZfvGrIMv9QQKwQ9h2iIFAiOH3O8p
         v2et5/aVyRJ4dYJ9JlNutC+XYonoed3ROg6Oy8fn/kESd4OsjI6uHXwyWUjlgz1f0b/Z
         s3BNyPOwznaxoGkqgpfj6lVaVx4jiF1ppDIb89i21+xBmkbvG8NdKCoQDmoqC3d6MBFk
         k90g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Q3BJj0e8+vEX3zQITAPm3l/SKpKrAzG9V1e/lMo5xWo=;
        b=jwJjgJIiXeNynwH3qoeOEoKaHf6VNdBKc/NUL1tYpGjEbPMWQ28JYLuGJ1Z3YhNZbF
         kuzDVSzKdQG11h3JVWFflvgca1O8Vql2lfDLhMwDs5CSSpFb6v1tJTQgn6+tuS6rS3j2
         IQm+Jjd+NudvoTk8Ld4LbLK3WDI9k9cD4n6vyrzGuBlr2C+mYbCvYqR29QC21cbhI9EE
         062sD56svkw366TCLvx2ktlVGfPBjl/9NNBYth2Slw44YM9EByDI6eOiHYczKCcnw/Ij
         ihbb/5secxN5HPka2khU2VthoJ56EYvjgfDNN5G1viKehnVqXt65gzK9nD8Jsqal/xHQ
         50UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 72.249.23.125 is neither permitted nor denied by best guess record for domain of tony@atomide.com) smtp.mailfrom=tony@atomide.com
Date: Mon, 14 May 2018 17:53:42 -0700
From: Tony Lindgren <tony@atomide.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
	"linux-samsung-soc @ vger . kernel . org" <linux-samsung-soc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM
 domain exists
Message-ID: <20180515005342.GM98604@atomide.com>
References: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600451586145722413?=
X-GMAIL-MSGID: =?utf-8?q?1600489391705188417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Ulf Hansson <ulf.hansson@linaro.org> [180514 14:55]:
> As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
> to devices, clearly we must allow a device to have the pointer already
> being assigned. For this reason, return 0 instead of -EEXIST.
> 
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Fixes the issue for me too:

Tested-by: Tony Lindgren <tony@atomide.com>
