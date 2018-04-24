Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx483cykRuTfP1IKC6lwkDHxAXB4IfiAHRilXmBbr0PqQwSIS7mrHdSCiGP455Y8VHb2C5ZMH
ARC-Seal: i=1; a=rsa-sha256; t=1524547784; cv=none;
        d=google.com; s=arc-20160816;
        b=Dj/DfZTESMX9esw2f4Ip+KImWSjYDnP8qF3QHid1NUNatKblzaE9i7fM1KxxTMsFZc
         urog9tE0GO7ZEP2O5QsoBZlIh13PohDTRYnTlKTlwtboI6eZb7dCIoxE+qCZTbyzl9Ir
         Sf9NJcWVov6UX/91eLJjvkzP317GIkaiJLkI5uXIjzeUqC1t1MTVXY6lu6tJ0f1dZ1Ca
         aosUrC+7Td+WxfNexoXUHPppuYRrlwA868TkQUPVjgBUEAspQzmpOy+19cnYKYQ3IWrz
         a7Ip8lqdVkOwRmWJ65LwHda6wuDUr1NNUT8Up7b4Kmr0Ss0x3G0fQ8IXvm3+gO8cqigp
         FA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9XIVnovJSmILi+97ey1AyoK8DkjMUD/7EYyjm9yem+0=;
        b=wESX/b5x++SEwnObECrf3USPPe/nGwDkBF+29R3IclwU2X+1qr2pXEnnOOH2RhXPTT
         fjDN8dL73SBXytQmI+r0doA+A+szfiUL0Vlc2s6d4UicmMMy7U3S+pK1av7coFG025u2
         psVF9FNG4X/d3kIvumBvxAUdHsCVJLfG0kfJlaDUnPRc/m8XpYdP2YpU1xS2Zday1kEs
         QaOprQ3RM8UDbnGZOKo3CVYRpUC+TazqwHNcaY7oOTP4/D63/oeeGrRU4V1+JOfi28/U
         6zD4o+fZvhUXpr6vcsyNIp3KbC5GH34ZrhXP8U/489y8mjSEvpTh6m43gVw5k9IN+5EO
         jb7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dq/DW6OC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dq/DW6OC;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dq/DW6OC;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dq/DW6OC;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC8A16071A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  mcgrof@kernel.org,  alexdeucher@gmail.com,  christian.koenig@amd.com,  arend.vanspriel@broadcom.com,  linux-wireless@vger.kernel.org,  ath10k@lists.infradead.org,  hdegoede@redhat.com
Subject: Re: [PATCH 9/9] ath10k: re-enable the firmware fallback mechanism for testmode
References: <20180423201205.20533-1-andresx7@gmail.com>
	<20180423201205.20533-10-andresx7@gmail.com>
Date: Tue, 24 Apr 2018 08:29:38 +0300
In-Reply-To: <20180423201205.20533-10-andresx7@gmail.com> (Andres Rodriguez's
	message of "Mon, 23 Apr 2018 16:12:05 -0400")
Message-ID: <87fu3lcgu5.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569155393692911?=
X-GMAIL-MSGID: =?utf-8?q?1598604217429372348?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andres Rodriguez <andresx7@gmail.com> writes:

> The ath10k testmode uses request_firmware_direct() in order to avoid
> producing firmware load warnings. Disabling the fallback mechanism was a
> side effect of disabling warnings.
>
> We now have a new API that allows us to avoid warnings while keeping the
> fallback mechanism enabled. So use that instead.
>
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>

Thanks!

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
