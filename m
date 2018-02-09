Return-Path: <ulf.hansson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518184862; cv=none;
        d=google.com; s=arc-20160816;
        b=Bt62mZtG4fZjKUwYFNfDd5+KiP/IhpuqwbOLFtsnJ8DSA67fV68bcIzVh02P+24R42
         S4sWZ8pnWlGQUNcs8y8JFrCNdjM29IjMvfumjEHYDZ2fXFQCB5JMuBik6cgiiTpvUAs9
         1sSRKQnHQn0nQWfSebn2wfoHeZwRHy88TGv56okYxblQCRZugp6dmWwlSHpfL/OCauOc
         pjsoXzpevzS2N5OHhW5szTA3q7hwm02sD8uGC8TFrrMDsYU6pVB30qNdJ3gRPgNveqEO
         3KjorDlLcaH2na1V4SVJT5C2jvh3Ripq/aTv4JiwJI1yZ3igUz5+VweV6G5i6tGQaecI
         NSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=S6qCzJ3ld3D+a+oSdLLsCJ4uW7NqvzqvzebpLnIZnTU=;
        b=OeB5FY6CjYeUlIHe4HRFmdvr4UKmVnf26nB85IoJTBTwdeRW1sMejxFkVnlEBWLAXS
         72lA4cEQDG21UFG2W97a6SKRRywdnZ5Wc/rkTfbjy7QXrKO97JwtDLo4uPAm/flQ5i/e
         VGZIrcRE644ajH5Mcy2fbh+JmIB2+WvpKMnCSUR7bro2ZuVZ8G0fsKNxDyd76HfUGb6V
         YQG589czWMUsl2TNtPbcGR2uU7to8H4W2fdGSDsCwlZMNNdX5MHHQu/zmWPdtM1itsf7
         VZgxA+R90CWQ5iGh4guJy9l6Mf20h0GU5hLHeyBHyS7qQn8h1dPvj9kUMN4+kDDbpe2H
         wpFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lgd9fI6T;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lgd9fI6T;
       spf=pass (google.com: domain of ulf.hansson@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=ulf.hansson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226IledUs9ncbrW98bINUXKLloByP+usmK/CMZ88+uWQy2dZiJICwFm0Wkd5yMz1G5fSznWasouHoXFtfERBTec=
MIME-Version: 1.0
In-Reply-To: <20180209080541.edgjbhjo542vq3h6@qschulz>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-3-quentin.schulz@free-electrons.com> <4015f7df-36ca-c762-5b9a-94a270f65475@redhat.com>
 <CAPDyKFpePxfAc20NCO7xvbGca8m=Bymc=5KBYFF570rnACViQA@mail.gmail.com>
 <20180208145952.qlq4sxohqd3s7m7o@qschulz> <CAPDyKFrbRVgOFRKpO5TdwHO-XQ035exrUt_bgM=BaxnEPmCvrw@mail.gmail.com>
 <20180209080541.edgjbhjo542vq3h6@qschulz>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 9 Feb 2018 15:01:00 +0100
Message-ID: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end functions
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Quentin Schulz <quentin.schulz@free-electrons.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Baolin Wang <baolin.wang@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>,
	Icenowy Zheng <icenowy@aosc.xyz>, Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1573543183974033537?=
X-GMAIL-MSGID: =?utf-8?q?1591932210025227696?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[...]

>> > I'd like to know if any progress has been made on that problem (I may
>> > have missed patches).
>> > Had you had the time to look at the issue?
>>
>> I have looked at the issue, but not manage to cook some patches for it.
>>
>> However, it's on my top of my TODO list for mmc. No promises, but
>> perhaps and hopefully I manage to get something posted during the
>> coming release cycle.
>>
>
> Cool! If you ever need some testing, I'd be glad to test your patches
> (even if they are in a draft/RFC state).
>
> Also, when you send patches, I'd appreciate being Cc'ed so that I can
> put my Tested-by :) Thanks!

Absolutely! I appreciate it.

Br
Uffe
