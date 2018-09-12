Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372BC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC9D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 23:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RzfNcAQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC9D2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbeIMERN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 00:17:13 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37889 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeIMERM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 00:17:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id e18-v6so2506248ybq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VBpOXpCINY2YeLFfXYjVRFqff0/PcTakTrlP2W3g5fI=;
        b=RzfNcAQ1ZCDn8oGFMHHI8PQJpvatFpgB5RF8JkT/HruzKLHIpOmIwqSa4ZKDOHGvbq
         liMEwOHa3+zslDJCOXfJYnaxwlxqhs6kLlhnkT+faRHMlGZmFp+hWZzGjf52hP07+0vH
         KOzzrn3EKAKyVSX1VfvNjkZRMhBAWvQi5Rz44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VBpOXpCINY2YeLFfXYjVRFqff0/PcTakTrlP2W3g5fI=;
        b=lQ3wG90aQvjjlWpklcbXuOJ/aFLu1+2s1AJ2HQbWMi1niAw1MMhmEA31W8WIt+Y8w6
         qNq13UK/95D/IYIxdbLBmWbKkaUk1x1V9rghtQD7GM+LAeFmWhp4RKTvbpYC5g0ZSxUn
         jnri/OAEvKRsBwI2xqMWLF1eOOj2pyDi/52h/nPpgtjknRcKGgoIxG1rC2C9Tp8KIRgL
         YTAbJXINS0JHPY5v+WU8L0UFd6etYsQyiSfUuQqxOhSQskl1KeSdecIZ63UUEDzbgm0/
         cLf0j5rTQpu5b81M5pvCArx4eQZ+EVNbrP5q0bRmJACFP74EFqpVfpJlDoMwXN9RxkIJ
         EYhQ==
X-Gm-Message-State: APzg51CXUlo+BkVIY0oAqslh5PM4pBL67hbp3mUx74gCV2qnPmugTKoq
        fZiR/+oEOwrydbQP/4qeNvTdd38B3fA=
X-Google-Smtp-Source: ANB0VdbBwB8GgYnDSQjqUbYETgah2Oll9zW1r2lUbvoP+Wk1P86LJ1OdSDMqrCBGCHV/zsFBrqBbVA==
X-Received: by 2002:a25:2183:: with SMTP id h125-v6mr2166019ybh.339.1536793828499;
        Wed, 12 Sep 2018 16:10:28 -0700 (PDT)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id l3-v6sm588711ywd.98.2018.09.12.16.10.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 16:10:27 -0700 (PDT)
Received: by mail-yw1-f42.google.com with SMTP id y134-v6so410747ywg.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 16:10:26 -0700 (PDT)
X-Received: by 2002:a81:4e01:: with SMTP id c1-v6mr2229904ywb.237.1536793826425;
 Wed, 12 Sep 2018 16:10:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 16:10:25
 -0700 (PDT)
In-Reply-To: <39bcaa18-4c53-f386-5e89-8903a49a3256@schaufler-ca.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com> <39bcaa18-4c53-f386-5e89-8903a49a3256@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 12 Sep 2018 16:10:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLBwipu9WD41rQvdTjoM=+3gigrA3sp1s1gFv8C_U0nRg@mail.gmail.com>
Message-ID: <CAGXu5jLBwipu9WD41rQvdTjoM=+3gigrA3sp1s1gFv8C_U0nRg@mail.gmail.com>
Subject: Re: [PATCH 03/10] SELinux: Abstract use of cred security blob
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 9:41 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> Don't use the cred->security pointer directly.
> Provide a helper function that provides the security blob pointer.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Like smack, this seems to be largely:

s/$identifier->security/selinux_cred($identifier)/
s/current_security()/selinux_cred(current_cred())/

Is that right? The one __task_cred() use seemed to be fully contained
under rcu read lock.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
