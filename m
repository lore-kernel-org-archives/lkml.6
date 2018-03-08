Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELubFePJM1//+4EnNHqrEcSh4fgNicS4B7h1oUYUewV/UI9BYN5SFePwXKE9PM/sEyFPMWpO
ARC-Seal: i=1; a=rsa-sha256; t=1520525675; cv=none;
        d=google.com; s=arc-20160816;
        b=yeW4sR07d8nytlZIFNYVfASqU9iI74m/Mp5lQR984kieXHViVqt9EVlYapIH9j0+1f
         Br5xPrIEp2JA107ijpR/Gs9L54bbpUyzy2XSfpsOSU97hy0ADazSl98/4q7zN8VgtvbJ
         afAzoN2JU9nruBJc8uSFRclJGuGVyvFjOEmxb7nD44w9JZ7hoB4zEx+m6UgUkfHCsqEZ
         6kQuMP1ydN1e0Wb7I/cGcIxuGzboZXX0J4lJjV6Eq+2pDreTf4tjQSRDkRgFbWyyBTBI
         ngt7pV6TpNBscCgQfuf0o0+CEaB7ufy34ccDushbZYSEMLoI1cPb+EJbYZkxchW6FpJj
         RRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=hjSUrHx8YopXkP6NVlMkKxZ9axirRetcDJMwevLkrLM=;
        b=f/pIfBijilaU+KOk31qsP9qUtB+Qhy2zOXCfeI/yI6kdDJCPOd+oiduq7WKSGs4PMj
         PArwhGc/js6xUdb+KNEEi3d4fmJx5CDcE3QjDNOBkIf9d83viW+u1vcWQ2Jyp5BWbAhZ
         axe75nBuHhrhiBnNr/kNuhP0MZKoD/Tz8d3SQCjkkcdlbru84KnkBZpeRhmXYxwJv3iX
         aNi8IdPPYEBveHdWP/MMnXJBl7j08rnC8cVWLrj/+xdKzBUUtE77HeGxynhr4CkynJ49
         IaapxvjIdPQbEnMQ6aR5XTW4zyvdI+fYnd69wePdXaUrDCfkonRiaJVGC7DvjZLqY2lh
         GDXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755030AbeCHQOR (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Mar 2018 11:14:17 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39506 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCHQOR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Mar 2018 11:14:17 -0500
Date: Thu, 08 Mar 2018 11:14:15 -0500 (EST)
Message-Id: <20180308.111415.514057888108219546.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: enable fragments for fib-onlink-tests
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180308101723.19721-1-anders.roxell@linaro.org>
References: <20180308101723.19721-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594364269879247386?=
X-GMAIL-MSGID: =?utf-8?q?1594386731008162920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu,  8 Mar 2018 11:17:23 +0100

> We miss CONFIG_* fragments so test fib-onlink-tests.sh can do:
> ip li add lisa type vrf table 1101
> ip li add veth1 type veth peer name veth2
> 
> And the follow message occurs if it isn't enabled:
> Configuring interfaces
> RTNETLINK answers: Operation not supported
> 
> This enables for NET_NRF (and friends) and VETH so we can create a vrf
> table and veth.
> 
> Fixes: 153e1b84f477 ("selftests: Add FIB onlink tests")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thank you.
