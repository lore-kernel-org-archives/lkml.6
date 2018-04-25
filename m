Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-488755-1524652284-2-599030136487602581
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524652284; b=uBlUAZ+kHsjOP51A7TV97O93/6QLjOKwugjT9zDWq81xfgJMgl
    P3mBg1zRLfh2ApcGs4E1kjzGKRDeKwWGiDWpd7gFQIr9k2kkNRg7+JKtUT0taii+
    /s1np/C53JrAwAfr4NEovuFMYk4zg0/JvZT28Vn+FI3tyUXFnsnODjmIM3P7cWKQ
    VeP3EukghJBVewp+GwKnlmlSEXxldpqywQEU0FcMJwPVCxSdy0wMN7uPetj/s387
    rIAv65hY4yp/X8r1CMtjZduoaOx9D58/kkq2lKLxCPxIyxgirN0StnFDVQhlVKsv
    tEXDZ/cyGV7FkS3byXivMKcztFrPe5Zpk6OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524652284; bh=dygrnlDPTltdN5jAekQym8gJqdHAym
    qMyFktBpZeOLc=; b=AGmtXmgIX3Szm5juJGxW1OLn3tnWqMuS6ctT++dauTJM6F
    fvJtbd7xAJM/SzyIOHpCTFN0N9RY8mp9gti0Omjb0fqXHPmUUEl/bkHTY787zGDN
    eW7qEIkXhmE0mMy+24bUoyY0fexRO7yNGuz/vI5VAvX0DOKds4cs1LjmgZTUFpAC
    T265ndo1cUObIN5bkrxv7aakcICQsGUzEcxL9VAyVVPPbKInOEpvcCjujAoQwiSS
    JM2nOA+bGiy8D0E1OcEV1Ki8tHMkMbT7Vz31tsgWTMM73MktCqpAwo8UA6LmstNb
    AfhQ0PNEzJ2S3mJuNi+q1seJO35IP+Idh8E7OmPg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIx5lju77QY9UI0HOt3mnBgV4yPhC+yksAGoSFOViacd6XA/pGVHdS4QPOUZcRthO0zkADPu/erx/g116PCV6Zjype3b28WiP3nc/Hq2rZNXOWx3qz5k
    hx1gdrxMV9ZxDDSYH0MTM6MF3lLc83eqO2oyYh/x+nAnqFvR5XR7GnqbFtCgBysCrGUv5eC3Vp36carNfFjARty2Aa8TSj0gDq1KmfmQ5YDT+m7I5ouVBADV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=J1Y8HTJGAAAA:8 a=VwQbUJbxAAAA:8 a=ARBc8C1tHcqBI90FgfAA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeDYKaa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:30:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751525AbeDYKa3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 06:30:29 -0400
Date: Wed, 25 Apr 2018 12:30:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Oliver Neukum <oliver@neukum.org>,
        "David S. Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH stable v4.4+] r8152: add Linksys USB3GIGV1 id
Message-ID: <20180425103022.GB5806@kroah.com>
References: <1524650077-13270-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524650077-13270-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 11:54:37AM +0200, Krzysztof Kozlowski wrote:
> commit 90841047a01b452cc8c3f9b990698b264143334a upstream
> 
> This linksys dongle by default comes up in cdc_ether mode.
> This patch allows r8152 to claim the device:
>    Bus 002 Device 002: ID 13b1:0041 Linksys
> 
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> [krzk: Rebase on v4.4]

Also added to 4.9.y, thanks.

greg k-h
