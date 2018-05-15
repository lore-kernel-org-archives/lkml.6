Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526371608; cv=none;
        d=google.com; s=arc-20160816;
        b=uYkNzbkDKqEHnZBSIT7H+AjRxkjS9gBrdocHjx3GjobMXuvQhG1ttYOAJ8ZUQK0Z0s
         rLf+O8jLSUo8PnhqriB1o8baXfXG9vRr6W/EFwbd0bOFLrfK7SDNXOV+D7Gcfy/nDs6o
         6yn6tkM9ZLLvEhAbyZQwHxI4/saVl+qoPzHogvoknXwIjWL89Pf8g9fiihisMkJHTCT4
         yrEqDygrlCm9ea1UPx0mxkOVpdvRAyabTulaepjea4KcmTzU8k9bkVAmFSqGBlYAybJc
         /TvMP3xTAtDpCeNMKPGZgK3k+VEUhoXBbv9gRtoOwCDK8YUbakl+Ht+CLy/hkEASzUOY
         1jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=N7ejNrfaveEunnz7wDy1yT0fpXQKmGe1uCl70+eSFLA=;
        b=CEONKdwo2E+XIfTAwtRSBMz6iKED8qporhjm5sWU9bVfl0yIJtDWUeHghmO0/iSd3V
         8Xz+Xso21U6jjhZLAHcFQrOWXPsWPrkKZHXvAshhPYek8T3YF83XzUKW3+cW/xsOngDG
         jtT3IOY7F8azVgzF30wjUgzxM01v6ftqxMzxGaHzEm7hqIy9jcC1VKMYdXjhofviUlE/
         /A41dlEIGd9lc5FC1f8ULCUVEH0uLsVcR1wgESVqEbvUQnfH9Den9J9ycszA3D49bav2
         a5Cqm8GBpT7WH1+bbjimXb3xHZXm32WtPf6BIa0stQCoTvQxAA7001j/ApqVxDYsT3Ru
         Ha+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uY1UB9xE;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uY1UB9xE;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrIlKAIA43VdYljDUUP9g0wZqzaO+4w+z6tRw03dybPNuAMgG99SL0QVeDfMUyytzrYuL9rm4RDyADjst8w0uA=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180515005342.GM98604@atomide.com>
References: <1526309557-7995-1-git-send-email-ulf.hansson@linaro.org> <20180515005342.GM98604@atomide.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 15 May 2018 10:06:48 +0200
X-Google-Sender-Auth: gkhUzRo3LfozTRm2-SrjSxd_dhw
Message-ID: <CAJZ5v0iaF9NfajAUT_m8E_AKySnjV-A6xpiXXz=_8LGe8oD1qg@mail.gmail.com>
Subject: Re: [PATCH] PM / Domains: Don't return -EEXIST at attach when PM
 domain exists
To: Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	"linux-samsung-soc @ vger . kernel . org" <linux-samsung-soc@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600451586145722413?=
X-GMAIL-MSGID: =?utf-8?q?1600516635921433886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 2:53 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [180514 14:55]:
>> As dev_pm_domain_attach() isn't the only way to assign PM domain pointers
>> to devices, clearly we must allow a device to have the pointer already
>> being assigned. For this reason, return 0 instead of -EEXIST.
>>
>> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Tested-by: Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Fixes the issue for me too:
>
> Tested-by: Tony Lindgren <tony@atomide.com>

I've applied the patch with the tag above, thanks!
