Return-Path: <kubakici@wp.pl>
X-Google-Smtp-Source: AG47ELu2lOBuXRsNQpf6XZ3FKT6zkWS6vnm4APbpPGqDO1yo7jDlgNi0XXbi8iKqlxAvSlATd0H0
ARC-Seal: i=1; a=rsa-sha256; t=1520916205; cv=none;
        d=google.com; s=arc-20160816;
        b=i2Zg4Yzn00gfswKxV5iA6y8DqnUM4W869yBDNyqDf0bUDG/gWeo1ubolJ8h7CiT4Wm
         4V2/VRSPWQJfiapZf86Q5KFPQ19bDQgLxfIS9jzaBdjFopeArMfJIm01sVBKtTLTAxQm
         Rr4gynDE9XG0CNinldhtTFjV1jTX08qJNBV3P2nNQJEZp2pBt+bsmCFZ7l8pUQXc+tkF
         qGQJqlWzGAohcYeFqSAe4uGSIb7swTEIROnr7WVi8+SimF1MnIMa/q1FpXShInEb/Hbb
         YrRIUKfQ2a23D6yxOckDIkZpOnigHWJRc0IBeumwOPfdH4LNqyxV/nFkvcdk3HbxtQ1i
         dzQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=f9ZBtsQD91eWOuDXt6DX6rDPnh0Cn/qE5eF3umnHhvU=;
        b=hmBu2UFXYN4V0vO2pyqAEiglwcdJNvNiENC4ZPHNjF94WaRQN4Kmj5mAA0WfUople2
         l06CiSoMQm/cBtnfJ5p/lygTbN4ZExde4ma3WfKvIFMVTALANuF/xSue1eGnT5cIbXM1
         R2sP3YWLIlEe9zEsMIV7BwJmdey+SydK/O8QliiJfk7WBv6VHraRg/n7Eq+v/iP1gRdb
         2jRZkvfLbqmi+OujMo8XcG+cv9Gw9WMeSPm3m2Az+NMVskfiwYARSbME4gDng3LMamcD
         YU+0/dEOx3J39Oz0Ocp+3twFY2hbENMG7nuYJH2LZUe+CARtyftqgD5ltjvgXtwH669W
         yqhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@wp.pl header.s=1024a header.b=h4rOb27O;
       spf=pass (google.com: domain of kubakici@wp.pl designates 212.77.101.12 as permitted sender) smtp.mailfrom=kubakici@wp.pl
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@wp.pl header.s=1024a header.b=h4rOb27O;
       spf=pass (google.com: domain of kubakici@wp.pl designates 212.77.101.12 as permitted sender) smtp.mailfrom=kubakici@wp.pl
Date: Mon, 12 Mar 2018 21:43:14 -0700
From: Jakub Kicinski <kubakici@wp.pl>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 cantabile.desu@gmail.com, linux-wireless@vger.kernel.org,
 keescook@chromium.org, shuah@kernel.org, mfuzzey@parkeon.com,
 zohar@linux.vnet.ibm.com, dhowells@redhat.com, pali.rohar@gmail.com,
 tiwai@suse.de, arend.vanspriel@broadcom.com, zajec5@gmail.com,
 nbroeking@me.com, markivx@codeaurora.org, broonie@kernel.org,
 dmitry.torokhov@gmail.com, dwmw2@infradead.org,
 torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
 bjorn.andersson@linaro.org, jewalt@lgsinnovations.com, oneukum@suse.com,
 ast@fb.com, andresx7@gmail.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 20/20] mt7601u: use request_firmware_cache() to
 address cache on reboot
Message-ID: <20180312214314.481b142a@cakuba.netronome.com>
In-Reply-To: <20180310141501.2214-21-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
	<20180310141501.2214-21-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-WP-MailID: 4dea43fb46a5b2b41a52dd67ecbfbf84
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [wTPU]                               
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560440032815779?=
X-GMAIL-MSGID: =?utf-8?q?1594796231269226207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 10 Mar 2018 06:15:01 -0800, Luis R. Rodriguez wrote:
> request_firmware_cache() will ensure the firmware is available on resume
> from suspend if on reboot the device retains the firmware.
> 
> This optimization is in place given otherwise on reboot we have to
> reload the firmware, the opmization saves us about max 1s, minimum 10ms.
> 
> Cantabile has reported back this fixes his woes with both suspend and
> hibernation.
> 
> Reported-by: Cantabile <cantabile.desu@gmail.com>
> Tested-by: Cantabile <cantabile.desu@gmail.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

FWIW:

Acked-by: Jakub Kicinski <kubakici@wp.pl>

Thanks Luis!!
