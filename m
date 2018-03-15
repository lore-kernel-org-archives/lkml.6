Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4136612-1521110022-2-1092268570039175166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521110021; b=rJgbakqkItS0Pyc331UCInan2fHQZS3mtTsHAQBYilW45IV
    CjPC5zqwGdAWghoBfx0erZnb5HBLEVIgG2prgHLKxb1DkxMtp3BtcTI3CQk1LiwE
    I2MyrworK5ycYCoBcFAMMlC/in4Jf97y/2Fc5crJf0JiHCeJI2ZG+zLjPcITBsis
    u5wtSr1N2U4gFEa85PGUv8FKf7NdS69ItuD8hMpHPZ5YvBWDS0HE3H4QpI/dveJR
    qYzTin3juzPT2ZQ48FxsIoio7nxdqFzng2+6PMc+6uUYXd5yN7cTiBgDx7E12Qku
    cwDZfp/RnDLvl93tlWas2rst1T1kU5ZFEMTg9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521110021; bh=dS6V5zy3R7KE2+3Wh0cjrTMEHtJf2GKXbKw9CNB/SJ4=; b=r
    c78S5s9x/jP1S46A6GD7V1TY4Up7JWsznlxhGfaGVIii6IyeKjWSlesZElfFEq9X
    ha4zJ9YzbZQQIff+jOmDKcViA0XgG7MBmT2xqGSLdYFU9EDYpi16is2uXva2iJL0
    Ud71n/d63O7TeBLyi5PBSwirf1neRKNsx36zFJw3FWL+rze1Opz49q2URhflWK4E
    /ZoxxuvDoYL8K8CTb9UPPtGO8B57UtwuCssLTVGwYf2UeBMyopwZc3dQuNaSUawS
    eMP+GQsQLx+qfGUJP5CxCS6aHvg+lFmwMUdlkgH1tBO3HyAmobVF8B3zUl/NbibQ
    JSuoePHbppXd1XweL1Fqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751482AbeCOKdj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 06:33:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53895 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751467AbeCOKdi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Mar 2018 06:33:38 -0400
Subject: Re: [PATCH v2 1/3] xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END
 handling
To: Simon Gaiser <simon@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org
Cc: stable@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
References: <20180315024322.27429-1-simon@invisiblethingslab.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <3e626882-eac6-12db-9f5e-a75994bbdf2d@suse.com>
Date: Thu, 15 Mar 2018 11:33:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315024322.27429-1-simon@invisiblethingslab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/03/18 03:43, Simon Gaiser wrote:
> Commit fd8aa9095a95 ("xen: optimize xenbus driver for multiple
> concurrent xenstore accesses") made a subtle change to the semantic of
> xenbus_dev_request_and_reply() and xenbus_transaction_end().
> 
> Before on an error response to XS_TRANSACTION_END
> xenbus_dev_request_and_reply() would not decrement the active
> transaction counter. But xenbus_transaction_end() has always counted the
> transaction as finished regardless of the response.
> 
> The new behavior is that xenbus_dev_request_and_reply() and
> xenbus_transaction_end() will always count the transaction as finished
> regardless the response code (handled in xs_request_exit()).
> 
> But xenbus_dev_frontend tries to end a transaction on closing of the
> device if the XS_TRANSACTION_END failed before. Trying to close the
> transaction twice corrupts the reference count. So fix this by also
> considering a transaction closed if we have sent XS_TRANSACTION_END once
> regardless of the return code.
> 
> Cc: <stable@vger.kernel.org> # 4.11
> Fixes: fd8aa9095a95 ("xen: optimize xenbus driver for multiple concurrent xenstore accesses")
> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
