Return-Path: <kernel-hardening-return-12758-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+cwHy1YnxvuhQMUgEqbhSFI7e39fO4Dc2QAJu+GG4XPDpS+FLm6MFXz+LbxkQpgWJfhcPN
ARC-Seal: i=1; a=rsa-sha256; t=1522137916; cv=none;
        d=google.com; s=arc-20160816;
        b=f0DJQlJwU0TOvJYapa617I7hH0ZDdZz4HPkhBauXyWCRts224Ff21t+W05iDW/78iU
         3r5EVX/GJdDlLJzMes57NTCIQ6xiFcVuWwRgn6EC7UAIbpCUMkzQrR2znwsL0KETW4ge
         ctHANpzoTnY/gpecpZECPIjIPzWiKQSwEdupO0hepSwP0L+IZ/9fMlUl/Hx5j2KvgLUt
         On4WUxdtCnZLFarGXADjFr+ijma89YyEz8iMTV1ON3u6OPZpf1yyl/vUkt9Sg87RL1Lq
         EpDnKFI+LsuSaoe268LBtXPdXcHvGrBRU0gR6uvxBAPA9hUYyuRP3MlJ0RXkzjBCIvmz
         0s/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:user-agent:cc:to:references:in-reply-to:from
         :subject:content-transfer-encoding:mime-version:dmarc-filter
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ZWTNbZFyAXaRpZTZUPsFDlRzWg6DYZy5uF1ZfWIAnIM=;
        b=PzTbMBfPMHVxx5FuSie0vKk6H/x6SZZwaKPMnyC5okDjzytUmMQQTFPsg6l6dd0KAb
         B/iO+6u7gALDOd2SQSso9WJDmLmpFgDyToAdj6o3g+hYXNRNQWLAOB/P6wQVzY4/HWNR
         RLk2Z62guUts3oKfrE8XdMpW8x9Ry7myLZXsFYrUF36JOSJEIqaU/+i3ua4Uw/dqWV4u
         ilDzxTYCZ2uqp68Vl1uTIWMyug6yM0Uh7YGYXx39g2RC05qhrmPHlvvwtCwTPs6LdXfx
         mS9FsbNZmQCkswGBMnWkL0KYT9CFk1p34bfPe9XPo7F06mp0E/+afhzNFgbgbdY0O4tG
         oYuA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DmgCIQpS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QzQnCaXk;
       spf=pass (google.com: domain of kernel-hardening-return-12758-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12758-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=DmgCIQpS;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=QzQnCaXk;
       spf=pass (google.com: domain of kernel-hardening-return-12758-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12758-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C382602BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] rsi: Remove stack VLA usage
From: Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1521081085-16404-1-git-send-email-me@tobin.cc>
References: <1521081085-16404-1-git-send-email-me@tobin.cc>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: "Tobin C. Harding" <me@tobin.cc>, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
 Kees Cook <keescook@chromium.org>, Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20180327080453.5F80E60588@smtp.codeaurora.org>
Date: Tue, 27 Mar 2018 08:04:53 +0000 (UTC)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594441103492436943?=
X-GMAIL-MSGID: =?utf-8?q?1596077287394328223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Tobin C. Harding" <me@tobin.cc> wrote:

> The use of stack Variable Length Arrays needs to be avoided, as they
> can be a vector for stack exhaustion, which can be both a runtime bug
> (kernel Oops) or a security flaw (overwriting memory beyond the
> stack). Also, in general, as code evolves it is easy to lose track of
> how big a VLA can get. Thus, we can end up having runtime failures
> that are hard to debug. As part of the directive[1] to remove all VLAs
> from the kernel, and build with -Wvla.
> 
> Currently rsi code uses a VLA based on a function argument to
> `rsi_sdio_load_data_master_write()`.  The function call chain is
> 
> Both these functions
> 
> 	rsi_sdio_reinit_device()
> 	rsi_probe()
> 
> start the call chain:
> 
> 	rsi_hal_device_init()
> 	rsi_load_fw()
> 	auto_fw_upgrade()
> 	ping_pong_write()
> 	rsi_sdio_load_data_master_write()
> 
> [Without familiarity with the code] it appears that none of the 4 locks
> 
> 	mutex
> 	rx_mutex
> 	tx_mutex
> 	tx_bus_mutex
> 
> are held when `rsi_sdio_load_data_master_write()` is called.  It is therefore
> safe to use kmalloc with GFP_KERNEL.
> 
> We can avoid using the VLA by using `kmalloc()` and free'ing the memory on all
> exit paths.
> 
> Change buffer from 'u8 array' to 'u8 *'.  Call `kmalloc()` to allocate memory for
> the buffer.  Using goto statement to call `kfree()` on all return paths.
> 
> It can be expected that this patch will result in a small increase in overhead
> due to the use of `kmalloc()` however this code is only called on initialization
> (and re-initialization) so this overhead should not degrade performance.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Patch applied to wireless-drivers-next.git, thanks.

44f98a9332e4 rsi: Remove stack VLA usage

-- 
https://patchwork.kernel.org/patch/10283841/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
