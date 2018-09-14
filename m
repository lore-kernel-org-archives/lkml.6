Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC1FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D1420671
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BC+xgOZ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D1420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeINTdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:33:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37732 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:33:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so7662785ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gO/Fdj1Poy5biizlP8H270Gmsqf5QLgYQSWz2jw3OZo=;
        b=BC+xgOZ+gco/5FGJAtRrB3NzWis3CZQQ9+rCpyuzAGqQ1pRwhjEkz08mMfpq5x+PgG
         HslDvG9MRgsp4xtUVrpOygJOZjsQfPq4aDCgPEuVj+Z1yIlP9ykyQjf30EOIf9SuGLxX
         FGN+nH8SJZWSM+sRxZPLrLoHWzanr9B2dB/UcoC5smMogG47fthT0NQOxNApnergcp7s
         lJjBOTcGsXhSs0FLHIRXJgAwQPTX9vR2eHlRlBeVnIPs4evKRQZI5836o2uSLh66GyUj
         de8QinPsaiZJ24kO+s+bzBmIedi6dVm/aMSiUcMcp+rPKgBNVPEfLHmeRMbdbgVlZlQH
         dGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gO/Fdj1Poy5biizlP8H270Gmsqf5QLgYQSWz2jw3OZo=;
        b=TaBrSYELbhD2sjaV0xis3Vj0XeHZh/COAyJ9diWtDFlhPF+SjfsX7Twf+kEZYpjo/r
         4qkoEiJsoazAo4VcuChV/UyKtdf1wQE7h1TGQwbJKd439xWNnnHTJMA+HHiIyKsDsROE
         AL5VsXY1hwpjcaSV4Bfjm7BCUlmNR07wiF8bXi3fMQV6KryOkmn5TE/+sSnHFyur3jms
         FgidNM3mBRz/A5YW6akf582FJ/VVZJUOxvTEonQfTs0uO8rOwqYmuPnzD7Y6JVqfmkSd
         EJAGO5mvY+VZLfBJZS+G6ySg6bjh3DhFKjosFf8XziKCsM/8wIJOWRoyfevILzr3Wmzl
         WMLw==
X-Gm-Message-State: APzg51CoTqZMAPTXWR8i9F7skfVwEZ7br31QLfrdwMOW8eEcEK6gqmKI
        L1cWHK6U6qO6ZmtsU9rCUWtToaFu
X-Google-Smtp-Source: ANB0VdaBBx2vOAN+qWyUTJ0HjHJEBpF27HHDdGhrYVoE+PSmI54n2Ju3m2YEHfyjzQ2RADM5Vr/onQ==
X-Received: by 2002:a2e:6301:: with SMTP id x1-v6mr8532568ljb.9.1536934720635;
        Fri, 14 Sep 2018 07:18:40 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r73-v6sm1336390lfi.34.2018.09.14.07.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 07:18:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g0ovi-0005uj-Eu; Fri, 14 Sep 2018 16:18:42 +0200
Date:   Fri, 14 Sep 2018 16:18:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/50] usb_wwan: switch to ->[sg]et_serial()
Message-ID: <20180914141842.GU1362@localhost>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-33-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913024049.24567-33-viro@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 03:40:32AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Johan Hovold <johan@kernel.org>
