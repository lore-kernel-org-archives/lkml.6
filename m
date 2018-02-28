Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3438899-1519799124-2-11741985948338973645
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519799123; b=bZvJFTBp6jEfCFlxalcJNkwcKfo5mYiURosqMHuLLWxNmgI
    1+2gEnKuGMu7iOjn5PnSBXhxH7nzhykRvSm+xf0hge5crpv1Kb7+KbQoBakkCQGH
    dR8Mbo+6IrGD+Tww5LuOE1EydPYEppHunw4Wc1Vb10buB2n4+8gNGm6/z+DThr2q
    f/KpL3273tVLBUUwjV9u0k+tz85Dtimt2f5Yi1tSrEqXyBOF7ZAk0uZ5SBWUpMzY
    DeEsJ1rDmYWuMlbn1fe7A6HixmLnLGR0S7rg+/19sx7ipVDEa6gT6Pr1C6y6Mweu
    Eqn1M6RSESP+BWJCFSraAii0hyR+qd1q9teHVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1519799123; bh=1WRJe
    mWwDbLuLEFb05xYHuh7qACtDyci4vE9Wm8j4Uc=; b=Zk9NUtTaU95uiDSIS22g0
    xOeJL5ire7Wb0hWwm19FBe2uAQ/kIJj7iuh32yXkNEJ5Aswn9Crav36+0g8V6aT0
    kn3iQ3TE4wcuvRQt9j/FEK81C4uWa/w/QeX77JbyhIqrJ8M/bzaON7R2drGu6atQ
    9v8hoQkOtubGZg5Hcb7nZPkRlitFDYYWPvj0JOxuOEWqaj+rCEn0eRoevTO/hOI2
    /tP7N3oPfCXNmLljrnKN143UQUp8aTN1buhqxVticCfMLClWtX9lt6M8PsEu+LZY
    UumeY3RGh0GKK3lamnBckBfC5Yl1JGpWIQbDY49CdNjq+aC47I9XA18lI4pAE2A8
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeB1GZV convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Feb 2018 01:25:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:55964 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeB1GZU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 01:25:20 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix channel open check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180228001738.11131-1-bjorn.andersson@linaro.org>
Date: Wed, 28 Feb 2018 07:25:18 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        stable@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <1498F44F-02AE-4384-9227-0BABE3F4764E@holtmann.org>
References: <20180228001738.11131-1-bjorn.andersson@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn,

> rpmsg_create_ept() returns NULL on error and as such
> qcom_wcnss_open_channel() does the same. Clarify this in the
> kernel-doc and correct the error checks in btqcomsmd.
> 
> Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> drivers/bluetooth/btqcomsmd.c | 8 ++++----
> drivers/soc/qcom/wcnss_ctrl.c | 2 ++
> 2 files changed, 6 insertions(+), 4 deletions(-)

I think you better split this into two separate patches so they can go via its subsystems independently.

> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index 2c9a5fc9137d..24f702927875 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -151,13 +151,13 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 
> 	btq->acl_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_ACL",
> 						   btqcomsmd_acl_callback, btq);
> -	if (IS_ERR(btq->acl_channel))
> -		return PTR_ERR(btq->acl_channel);
> +	if (!btq->acl_channel)
> +		return -ENOENT;
> 
> 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
> 						   btqcomsmd_cmd_callback, btq);
> -	if (IS_ERR(btq->cmd_channel))
> -		return PTR_ERR(btq->cmd_channel);
> +	if (!btq->cmd_channel)
> +		return -ENOENT;

Any reason not to fix qcom_wcnss_open_channel to use PTR_ERR?

Regards

Marcel
