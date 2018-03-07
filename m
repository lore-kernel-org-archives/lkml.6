Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvE1kzLwqsReFFp1bSRdfEEG215ZPSh4oT3EeDvKfyYSekBYarUgPSPLz+Tiz6+ijFKVXdw
ARC-Seal: i=1; a=rsa-sha256; t=1520447113; cv=none;
        d=google.com; s=arc-20160816;
        b=yI+CbuRD/jHCyCwSQeuQthiC7O7oXfcYesRK37xUP6Q/85WbzG3WmqTlSrHUNThvK4
         ZtyAB01GjK1p8252wKSqXyD+moTBclXu7C2fM2XKhRhcJORyhzR7SP/X3D15d+hSD5O+
         GN2jlnGYN4jM1tVoKkX6qUyWEPCM9dwhFUPOH6r8Zhh4pLc5I89aJRQOAqgx7Jq+NzdJ
         ZGX0cs5Di7xGYQeeabo7BfB51vASRzegtsK6p6cU6ihRtoqk6Ss35tJnXJiawcSaaPGr
         QDMid3EaCXYDu3SWsueLKstWqntMNIZ1hRgKYIeTZeoO+lq67zGzhCYT0r071c37pjDR
         WVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=+gVag2KEcIJRcmasNa+e6CjyytLFmmPEx5hVX/YBPJ0=;
        b=mLOPVYsaAEXkozPKpH0y3q13nzIzv92qOdbmkVINkVshpPUbVHSbFLp4y7JIUYUTUR
         NxtvyDge+dt1MuM3RscLTFQIq5CF6RA+FMOqOD+7ttABuJs/1uPXjEThNCclLMTfWyaP
         qEY4mT8Baq+26j1gZg1ksQqIELcEX1UWHksKybuz4GeCE3EN20VDz7QPa653sMwM1E3W
         khncH2NuqYGG13FjFVulUVuNpYf+z5laFJ7nMt8tL2esjzZlHXlorInRyuz4qUlyjr7a
         XoF8ozmiB7eJ6T7LGD/j6BY0jPGX45oDd75PtwvUqADYbhUnBh1odZ2ThtgR7clmDJja
         je/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933827AbeCGSZD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 7 Mar 2018 13:25:03 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55276 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933655AbeCGSZC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Mar 2018 13:25:02 -0500
Date: Wed, 07 Mar 2018 13:25:00 -0500 (EST)
Message-Id: <20180307.132500.40232199631094354.davem@davemloft.net>
To: anders.roxell@linaro.org
Cc: shuah@kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: reuseport_bpf_numa: don't fail if no
 numa support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306151004.31336-1-anders.roxell@linaro.org>
References: <20180306151004.31336-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594201505777703046?=
X-GMAIL-MSGID: =?utf-8?q?1594304352462937730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue,  6 Mar 2018 16:10:04 +0100

> The reuseport_bpf_numa test case fails there's no numa support.  The
> test shouldn't fail if there's no support it should be skipped with a
> pass.
> 
> Fixes: 3c2c3c16aaf6 ("reuseport, bpf: add test case for bpf_get_numa_node_id")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I don't know about this.

The test did not pass.  So it should not be "skipped with a pass".

We were unable to run it at all, which means we don't know if it
would pass or fail.  This means there is a third state besides
pass or fail which we must acknowledge and implement.


