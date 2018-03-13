Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELvOxUvwKMF33CafhH1MZI9ROnLlWOy5J/JskhXOF2pVCS1F8LnKjKJcHPBQKxpE1hH3WvfA
ARC-Seal: i=1; a=rsa-sha256; t=1520948123; cv=none;
        d=google.com; s=arc-20160816;
        b=mDStPqVYYP/k9G096e1vNThm6vEK1TSneo/gBh+TY6AqUPOddmpRDLx5tnMczRIewU
         zO92n/aBJPRL3GmcR2w75YxRxAfaOihla+jMXtzFMtwIgZIPPmxSqVSRx7Ja6Z+v1V4G
         GwCTFAXUzBGI9UKie+k3D8t7H219j+W9KFlBurc4HK8sY44ejE7CimrhAreh+BbDbRPS
         jJ9/VN7Wk4bnFZar28seazxDffzFZLiymVmPOL0qKApJPmwCDGfWdka5SVwsjzM/HtkR
         EDesp3DbmyR9CFnHccdvAnRNQT0u7zjzdJWVd936PzkxUN5dkXaxtfiSVidK7eGuLM00
         XBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9w5AQ/8sj9amdEEbyukvEDTHZgxoWAGhbCOhAPfTVEQ=;
        b=rxxnr8mgsDqYm/Jfia8F99Ll45PH9E73UiASEFDbuLMTTPaRnDKiN3JbVLvSracyda
         QXY3xUdkwZZRTabMcChaXe3DeFPBSWv1mxhZymwNTXKw6vvh4EyXPMwNwAWCbbLg0R+w
         qm9GzR/epPmnkWFpb28xuIYFSYR7kexR45FrsnJS7+4jxZzeMbJzB6LRE3Hsxw675cAm
         gS5V51jyRieIwJ5BqtT7rvJGFZKnrm4H4GqodC2m1gDCIJxLbzwaHRPc+kCEtV/w/ixy
         7cL93aHoa5R7iAOnJEd7KYx/uufY4ypRdnriVgOIY7oYit6HhYJmT7YsJpkl75x264tg
         +V0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I4wODmsZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I4wODmsZ;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I4wODmsZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=I4wODmsZ;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 003D66070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Andres Rodriguez <andresx7@gmail.com>,  "Luis R. Rodriguez" <mcgrof@kernel.org>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-wireless <linux-wireless@vger.kernel.org>,  Ilia Mirkin <imirkin@alum.mit.edu>, luciano.coelho@intel.com
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
References: <20180309221243.15489-2-andresx7@gmail.com>
	<20180309230925.3573-1-andresx7@gmail.com>
	<CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
	<CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
	<bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
	<5AA5B777.5020106@broadcom.com>
Date: Tue, 13 Mar 2018 15:35:18 +0200
In-Reply-To: <5AA5B777.5020106@broadcom.com> (Arend van Spriel's message of
	"Mon, 12 Mar 2018 00:10:47 +0100")
Message-ID: <87vae09jzd.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594829700126069332?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
>>> Your patch series then should also have the driver callers who you
>>> want to modify to use this new API. Collect from the 802.11 folks the
>>> other drivers which I think they wanted changed as well.
>>
>> Arend, Kalle, would love to hear your feedback.
>
> I am not sure if it was ath10k, but Kalle will surely know. The other
> driver firing a whole batch of firmware requests is iwlwifi. These
> basically try to get latest firmware version and if not there try an
> older one.

Oh yeah, ath10k definitely needs this! It tries different firmware API
versions from latest to older (firmware-6.bin, firmware-5.bin,
firmware-4.bin and so on) to find a compatible firmware and the error
messages from request_firmware() are constantly confusing the users, I
think the latest query about these errors from last week on IRC. So
having request_firmware_nowarn() (or similar) would help users a lot.

We tried to workaround this by using request_firmware_direct() (which
oddly doesn't print anything) but that caused issues with OpenWRT/LEDE:

https://git.kernel.org/linus/c0cc00f250e1

And iwlwifi has a similar problem, adding Luca to the loop.

-- 
Kalle Valo
