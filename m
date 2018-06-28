Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC040C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACFB26816
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ACFB26816
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeF1ELb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:11:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45455 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbeF1EL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:11:28 -0400
Received: by mail-qk0-f195.google.com with SMTP id c198-v6so2275500qkg.12;
        Wed, 27 Jun 2018 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pwmu5VbTU7r9MRIb5co9ELs3eI4XSGhnCbOvZl/zLIU=;
        b=HNM/7cHC5j6iGDR+p7p2o1FL7FCN+ZaCCeF5BY/5SjwO7xw1nBi9cZrvGnZMT0zel/
         IMw2APtQGEtC1Nbh8VM+TZsTXEWz9JK9cRX7CpVAzUY2fhMSm9/+adyJJRnueTsemm36
         DIlTAgrbPs9n5YIUDhtedktuPNr05eeC8s+lvA7He3aNcPF0A3kS0e7UGKzmlXUbLWYg
         x6kP8smAGxMfvLqtKgNDjPv2dF3BLOkgXz/+7oRTvspMxcvLdfrUNCarQzSH80unwCfp
         HpaKcheLBao3hwg+w5D6RT8i1I00KjWGOjiRVZJXAK6ot/h+Do2oLKisDHl6wNnuyAL5
         Pf6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pwmu5VbTU7r9MRIb5co9ELs3eI4XSGhnCbOvZl/zLIU=;
        b=Pzyx58dr+ZowZBBWSNCuuvHzFM0TtgOTOBNywkG2hmwTwB1wvk4wjjPNSo5lVEUkPi
         mJRQ+yRiH9dBkvd4jaRN3ZaOKaKYUi8U/gK8xF4FgYNSGgMhYe2xY5gQxNWUaZRaLJxo
         zJl75ZDvQVyQ7UCSoFNs1NxctLjsDpPgYN0VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pwmu5VbTU7r9MRIb5co9ELs3eI4XSGhnCbOvZl/zLIU=;
        b=FmD3PlMhc2LNPxDIUC0oZkPuFaL1d++3IpjVGg2uZr7akDkRIFzV2uy3cCQWGZCckY
         w7qWG9Y1XB59k4tAkOyyFDxLHXJcFkcFJ9lCy378kxhT4Ac49VjDIZ/kRdjMe9GNOOui
         R/ivPHFe6VkcN8VSaR1hiXRyjNeKFSITeUHSirwPNXQgjRO58DqZwKpYyFqoOTxuQaSD
         saRrt7+MyhdVrIpKUp5V7yo7C2pUPTR2mB6R6pGga8d8q6IP9/gyVCrBvN1g2et5UUIP
         5iwbBgkMJQQxxH51iUmjRW9ZlyDs8XAd08zgpv4cTz8OSuWIRZhuxsvvB0UpVE7s1Bvs
         RgPA==
X-Gm-Message-State: APt69E3hFuZG/ahCyfNHaEn5UP7lnPYva1CyLo7IdmKMoApTs/PLFUTA
        XqzLwwFT1KZOekjGCTmS1FFOoj7W0fYb37p+ge0=
X-Google-Smtp-Source: AAOMgpca7EzNjrGe7cRgmQeqGGzu2KfHWlzUay/a8/68TiVbHK2G/+f+/Aawp/o5sv+AcDUg9CtoogYeqlnw7NjMko0=
X-Received: by 2002:a37:6983:: with SMTP id e125-v6mr7367376qkc.352.1530159088126;
 Wed, 27 Jun 2018 21:11:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:11:07
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-6-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-6-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:41:07 +0930
X-Google-Sender-Auth: jbj58KcwQ1MLeR3iuI8AzeHK0T8
Message-ID: <CACPK8Xdm4QGq4eRR9RMhYLFeD9yGUbDkB-3=J_tOcsfOj=TiZg@mail.gmail.com>
Subject: Re: [PATCH 05/14] fsi: master-gpio: Add support for link_config
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> To configure the send and echo delays
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
