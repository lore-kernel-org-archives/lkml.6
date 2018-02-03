Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3739313-1517617595-2-3161158013144422648
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517617594; b=rimQBl+BfvQRlQrDv1cYEs8ljhfnZRor2Ro7svUSLQJnwtE
    Fu/fGSJWkXe2xn0c6HjjH9plwDKs+tWYWX6MiDMkT7QUxa95vV1WoKgBrHi5BVii
    GJPUTpBDyBxTNgbcP1xGWQNLjDiz9i2FgQTZGUMIcJf/dCrDty0K/GNExYFI5L2C
    CahdO2Lu0KY994SezsvE89Kdm924UJUT9Zzq6N83fVnCyu8cjmgoZlm3SxDweApE
    z9R4b5IzoK0u3W18OJbScD8/dpzp0KNvuD3GgFWXLhfdqncKL/Z3ZCidXfUQM6yg
    M8Ga1Ud+Z8BmT2sYnS9C1nX2Mr+MFoVpuhG3CDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517617594; bh=ml2K3fVgcpmDEcSQPfGSc+1rxf1W4KHXYPqnHjPawDQ=; b=T
    EFmFNjIGtITwe4tKWfmOh4YobJ6vVyVCLAq44Edf1w1H3TV/hdzlledILlt2afgg
    oBFXDyHI2BMs4t50iAtt6QclACUQGeCKn1daEaeH8atmrDxZNr67qcLTn9vTUQum
    5Qmqplw7BZJBkK0/jOOX0JtFByxnYYsklKe8F26GQ3p6W5oQ5X44Qe8kfJYWYdCl
    D4nA2ZKzpL001W2WBGfTilsbtBpAjQuEYvXCAM8jIBxqw0L8ZtmnAOMQRQucrtpN
    7QMEkMklMeont/WUzBbqpR/PtIAvqPOUfn451Lo/iqEKmCfwmm+A3hvs/RgXDG9g
    CHvLIbD1WQK8IZplTDkrQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeBCA0T (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 19:26:19 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:44904 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbeBCA0R (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Feb 2018 19:26:17 -0500
Date: Fri, 02 Feb 2018 19:26:09 -0500 (EST)
Message-Id: <20180202.192609.993922533119695762.davem@davemloft.net>
To: hayeswang@realtek.com
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH net 0/2] r8152: fix rx issues
From: David Miller <davem@davemloft.net>
In-Reply-To: <1394712342-15778-283-albertk@realtek.com>
References: <1394712342-15778-283-albertk@realtek.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hayes Wang <hayeswang@realtek.com>
Date: Fri, 2 Feb 2018 16:43:34 +0800

> The two patched are used to fix rx issues.

Series applied.
