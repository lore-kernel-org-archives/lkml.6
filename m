Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4+T09rWNhl00BOEET1KC6qSQe0EiMm6xNR/8KbJsQrb13fH0ydJPMQgRdAmO9DbVzzlPPCX
ARC-Seal: i=1; a=rsa-sha256; t=1523552143; cv=none;
        d=google.com; s=arc-20160816;
        b=EVO/+Vg8llplJV/Om8gi98G68NzpLGbuFwMpjQkabwyvgmocdHdAUAjdbkeu5TLZVO
         a3li8b3jaaDyL1vKOxn/P1bh/N39vJ5QsfUhZ2IMtZEKhLSEaOE465f2XfdMFg0S6wg6
         aGcleHK1gQcMLhfIpSLK3r7FuXoPYXfgmi1uFK1i8R1Aj5M2C5+6VJHBNHkwjMWLfbir
         QVWlCf6uje1VFQr+8NVqWt0sl/CGliCmBmG7GUwEoMiLTfDlpfnLHZz2Tau2Z8PxLHS2
         So1Bq58Gl7X748ZJOotuplqyzkTmYUNATcONX3Iy1cFa6LKKnceuX2UgZJTsRKK90UJL
         NG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:arc-authentication-results;
        bh=4VIxPSQ/fI9WPK/MPd5OkQArJHBL1kBT064MTG9k2W8=;
        b=k63MIVKeAJKtF1g1eqs1+c1UpZdjCVAAqe21pzeIdKxVK1EilFa/+mqq3570QOt7r2
         C6vK6k7c/t8g6PDy6PE7nPreYlF5Bi6KPRZgMasl49/nDpiD6ZGwelXcZPAxcTcRWDE7
         cFWaLqKdNo7c/EzJa3LGA9l0D3D1eCOhNYb/pRpgigCtqk+ovBJmeTwXwXk0rl+hRT1H
         fQdJT08n2V5q9tV1JIBXxb1Y6n6i91RAGu2wUMZPYy/YCF4SMOUjG4uWRx6FP6r+L/r8
         QAF5iwF2YqHCNeTNyWFXHdk4kCfcrY9JlctZG+jYwTK5FacIFisginp0jYtkRTT/20Eo
         KJ9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.129 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.129 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 12 Apr 2018 18:55:43 +0200
X-ME-IP: 90.55.212.125
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,  Haojian Zhuang <haojian.zhuang@gmail.com>,  Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,  Tejun Heo <tj@kernel.org>,  Vinod Koul <vinod.koul@intel.com>,  Mauro Carvalho Chehab <mchehab@kernel.org>,  Ulf Hansson <ulf.hansson@linaro.org>,  Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,  Boris Brezillon <boris.brezillon@free-electrons.com>,  David Woodhouse <dwmw2@infradead.org>,  Brian Norris <computersforpeace@gmail.com>,  Marek Vasut <marek.vasut@gmail.com>,  Richard Weinberger <richard@nod.at>,  Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,  Nicolas Pitre <nico@fluxnic.net>,  Samuel Ortiz <samuel@sortiz.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai <tiwai@suse.com>,  Liam Girdwood <lgirdwood@gmail.com>,  Arnd Bergmann <arnd@arndb.de>,  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,  linux-ide@vger.kernel.org,  dmaengine@vger.kernel.org,  linux-media@vger.kernel.org,  linux-mmc@vger.kernel.org,  linux-mtd@lists.infradead.org,  netdev@vger.kernel.org,  devel@driverdev.osuosl.org,  alsa-devel@alsa-project.org
Subject: Re: [PATCH 08/15] ASoC: pxa: remove the dmaengine compat need
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
	<20180402142656.26815-9-robert.jarzmik@free.fr>
	<20180412152632.GG9929@sirena.org.uk>
X-URL: http://belgarath.falguerolles.org/
Date: Thu, 12 Apr 2018 18:55:28 +0200
In-Reply-To: <20180412152632.GG9929@sirena.org.uk> (Mark Brown's message of
	"Thu, 12 Apr 2018 16:26:32 +0100")
Message-ID: <87a7u82wlb.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644957830623862?=
X-GMAIL-MSGID: =?utf-8?q?1597560212469944339?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mark Brown <broonie@kernel.org> writes:

> On Mon, Apr 02, 2018 at 04:26:49PM +0200, Robert Jarzmik wrote:
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> If there's no dependency I'm happy to take this for 4.18.
Thanks for the ack.

The patches 1 and 2 are the dependency here, so I'd rather push it through my
tree once the review is complete.

Cheers.

-- 
Robert
