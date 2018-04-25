Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48fgmMhN2lrWYoXfuCdM2ZSRPorxn8EUSWrjsaX0WekaXpgpv1sLNNfnPe5uA2Lqi5i3Me0
ARC-Seal: i=1; a=rsa-sha256; t=1524677116; cv=none;
        d=google.com; s=arc-20160816;
        b=tbsOtM7qtOVoSvAkTl7AyWZVQW6k//v1mLZoAjHIiOaUttHUSqUsOpi8EkgMXzLLYr
         gUid5uGGNMMkHCK4N0waG37dZxMuB6lG226NOvI4antrxyOInHTc3yIaZBmICmKD3guE
         Yt5eQuRS4q67fH+CCUihOawf7lBOp//w54Yq/xWhvy9bNcwDTWnzXQQ83/ijm0jxFTla
         rAoGx8AcfxRZ5G86JoqDYdSt8II5MY2nZadEJnfxQCdlwRimtRlfzD8tnbQdNcFVeyca
         0cH2mbL29c/ioItjeH2FLdjTVN6bQ6k0f9I6xMpBbTJBNZJSc7wXAGg2BcmBsaHa7+fm
         lZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=gcKLYnWR2a+GyI7hM8My71PzBx77ovoWWYVquI5fqlY=;
        b=AlE4I1Tp7cIhhVJ42Cj/cUMufxo6oal0ebnS9D/HxfR97BzH7nRNditdzZVDiAEo/7
         lexia3lFxL+mhv4XFKQKQKCxDLLEvqpJwdY9kmz7VMcaO9c+oxkGzZ7Tho4DyB7znjhA
         VzSyDnTWSbg6YfeOqo7Kk47XzkRiWxYJTs3O1j2j4pBHshdgnET2aNr5QWfKpgwx35zr
         XvkMHJdlW3qaVfejgWvbCj99n1GpFN/k/2YFquNm0zRP6xtff+yl3PrgD4g7dZ2D7s8B
         sH3fhPx8dOPNgyy6tSzO70sKxiV+PacuBEUS+GoyB8z85Tr2eMNf5QivQNnmABQatZTt
         uufw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755076AbeDYRZQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 25 Apr 2018 13:25:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754649AbeDYRZP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Apr 2018 13:25:15 -0400
Date: Wed, 25 Apr 2018 13:25:13 -0400 (EDT)
Message-Id: <20180425.132513.1786379382285267245.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180424221952.12081-1-anders.roxell@linaro.org>
References: <20180424221952.12081-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598667778719810638?=
X-GMAIL-MSGID: =?utf-8?q?1598739832392347351?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 25 Apr 2018 00:19:52 +0200

> Script in_netns.sh is a utility function and not its own test so it
> shouldn't be part of the TEST_PROGS. The in_netns.sh get used by
> run_afpackettests.
> To install in_netns.sh without being added to the main run_kselftest.sh
> script use the TEST_GEN_PROGS_EXTENDED variable.
> 
> Fixes: 5ff9c1a3dd92 ("selftests: net: add in_netns.sh to TEST_PROGS")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Please respin this against the 'net' tree as we want this bug fixed
there not just 'net-next'.

Thanks.
