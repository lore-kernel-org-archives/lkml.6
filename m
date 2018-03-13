Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AG47ELuzUe1/3ezhYuqXYtltZIBoGgR9x2HmGoXk2UnE5ETRXZ4H9rkGzIwGKy+EL6AaQAAEYjKu
ARC-Seal: i=1; a=rsa-sha256; t=1520948367; cv=none;
        d=google.com; s=arc-20160816;
        b=PktFiSsLhfg6mBn+3EBkccxVBBo3QrDggbhCzExTm82br1cBn41W0PI7UcZ/YHjcSa
         y5MveQL5nMSA8m46lbNM0mC5KF28C2My8ChphZn/Z1XJytBWixKi2pNf8vJB/F+E3Z13
         3URBZRjntZYKx6nWKNMlrasPBmQ1WJJKbzVPFX+6oHePVSo/pEFHPPdeP6fjRu9roQu7
         bOWAoXrDysbyOFcsIUzbajviA3VQtCMM2kajdeemjuuj0HSFQn/4Q2urLUEhbk4mYNXH
         ofLDdkCQY8xABOpCYPnnT4pveN1eVrvG8fTaJt6ZcHpv5hqBTKQrp+eQOXjw0CF7P9JN
         Rz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=XAAgRju2j0m6FKV+FlV1z+MIh8rgbyF8hda8YbWIq7E=;
        b=gzdSP9UOnkTj3lbZeUj0uR/x+jdqRim2LJ4AVAIE2Mw3pMPByyDxtR1yGNGBRopOZd
         J076smQDnjSFPCZafVptLixARLYANS8tGB7/VoVdh5doyqd+Ai0e7/i/qh2G+tWBz7TB
         FjuYlrqbIz/xanGGPGjKX85tP2R5aJFafJVvNjVCJzmaKM/+n0Ge3+o5NTY5GmpMDNcA
         GfI9k8IHOoOPBHpdZkNmQfUnRikFz7QnhehAzcyqkNwPTRBzgIb6iEHGfPFdnTqDgUDJ
         pXzND6sOiHZS4SkOs5G7IZ2lp2EuiEkmwtBn+aG255IdvcR4mu581uL16NObLqb9X7x3
         LrJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IniOdF7E;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IniOdF7E;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IniOdF7E;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=IniOdF7E;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AB01600C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,  Andres Rodriguez <andresx7@gmail.com>,  "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-wireless <linux-wireless@vger.kernel.org>,  Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
References: <20180309221243.15489-2-andresx7@gmail.com>
	<20180309230925.3573-1-andresx7@gmail.com>
	<CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
	<CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
	<bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
	<5AA5B777.5020106@broadcom.com> <20180312192704.GX4449@wotan.suse.de>
Date: Tue, 13 Mar 2018 15:39:23 +0200
In-Reply-To: <20180312192704.GX4449@wotan.suse.de> (Luis R. Rodriguez's
	message of "Mon, 12 Mar 2018 19:27:04 +0000")
Message-ID: <87r2oo9jsk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1594829955281302618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

> On Mon, Mar 12, 2018 at 12:10:47AM +0100, Arend van Spriel wrote:
>> On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
>> > > Your patch series then should also have the driver callers who you
>> > > want to modify to use this new API. Collect from the 802.11 folks the
>> > > other drivers which I think they wanted changed as well.
>> > 
>> > Arend, Kalle, would love to hear your feedback.
>> 
>> I am not sure if it was ath10k, but Kalle will surely know. The other driver
>> firing a whole batch of firmware requests is iwlwifi. These basically try to
>> get latest firmware version and if not there try an older one.
>
> Ah I recall now. At least for iwlwifi its that it requests firmware with a
> range of api files, and we don't need information about files in the middle
> not found, given all we need to know if is if at lest one file was found
> or not.
>
> I have future code to also enable use of a range request which would replace
> the recursive nature of iwlwifi's firmware API request, so it simplifies it
> considerably.
>
> Once we get this flag to be silent in, this can be used later. Ie, the new
> API I'd add would replace the complex api revision thing for an internal set.

TBH I doubt we would use this kind of "range" request in ath10k, the
current code works just fine only if we can get rid of the annoying
warning from request_firmware(). Unless if it's significantly faster or
something.

-- 
Kalle Valo
