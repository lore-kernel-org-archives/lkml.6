Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx4+crDk/Vf1jUPow9oQLOfsBgqtkBcCSBgCz+i2FG5ya6Qq10j1sMOMOxhN1lBDyyEEgaMI5
ARC-Seal: i=1; a=rsa-sha256; t=1524219551; cv=none;
        d=google.com; s=arc-20160816;
        b=FNvkI8/SYagc1NviAJjIRUT9I4urOSkxW8tEvwnUHgd7+d/c8eXxGMe0Qy2WTog7Og
         XDKLWHAZ2CxFno4eDtzb62uhsQAsBHulw9eEUUA5NBC09I85aCKSRj+2SM11DuIBLGvM
         B992oFp2VWlBTYMGOHl/QN7o7Ze5XmfoEwI5kUYisfrAfsP8qe4R/yhj8AaM2CruLjP8
         amN+fLlvDvjqh9sKOou7THSthaJHlh6irjox6Cg7NoTZnjN2U9prpbWqbMelhLtoLsCb
         0mvWuRjlAC3SRLuDgCwuNKnHyP82Q6BMsnRSvO3FWxGiJtTqeARP717wsV/lHzKulECj
         PZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=UrGejJHv+DKe4Rf3Mc07Po6M1C0G25wqOn510073kNI=;
        b=YBo/1StdpKwHvhJIXCJnd/u5ThxDglWEPYjSTUkp1bRIO5j3xGH+cAf5gk65jPvlOv
         uiCPEEy72EU+71EMkZfT1MUsUt/uEd4bc9Y+Qk+eQetYZ1DeLsO4lBknVcNWZFLLTcOj
         H09f9nGz7JQM5rNrn/KH1UVNB8CgQyMTfWgHJGMiUqkgsQ6Fr31HFCRzT84EUDs84MEQ
         Rhm01WN2oZ25hqIW6DlF/vLqQW1W1fF7WcYu13y4l/ojSOJnHrdTUz2ZUc9Ei88V9WGR
         /mn27MooRluFAwtmPLL+gkkwurn0TUb2SMpmhEhqZvraVvRciWTu3YLHUMFX2SPGIQhd
         Hhzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZfHnrRc3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dBC7qgLa;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZfHnrRc3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dBC7qgLa;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CC43260227
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  mcgrof@kernel.org,  alexdeucher@gmail.com,  ckoenig.leichtzumerken@gmail.com,  arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH 8/9] ath10k: use request_firmware_nowarn to load firmware
References: <20180417153307.3693-1-andresx7@gmail.com>
	<20180417153307.3693-9-andresx7@gmail.com>
Date: Fri, 20 Apr 2018 13:19:06 +0300
In-Reply-To: <20180417153307.3693-9-andresx7@gmail.com> (Andres Rodriguez's
	message of "Tue, 17 Apr 2018 11:33:06 -0400")
Message-ID: <87lgdii3j9.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008019864458634?=
X-GMAIL-MSGID: =?utf-8?q?1598260040218554999?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

(adding linux-wireless and ath10k lists)

Andres Rodriguez <andresx7@gmail.com> writes:

> This reduces the unnecessary spew when trying to load optional firmware:
> "Direct firmware load for ... failed with error -2"
>
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  drivers/net/wireless/ath/ath10k/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Kalle Valo <kvalo@codeaurora.org>

But I think it would be good to change also request_firmware_direct() in
ath10k/testmode.c to request_firmware_nowarn().

-- 
Kalle Valo
