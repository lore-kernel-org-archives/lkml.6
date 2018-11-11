Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F569C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3885621104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASZndUdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3885621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeKLC6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:58:13 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39591 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbeKLC6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:58:13 -0500
Received: by mail-pg1-f173.google.com with SMTP id r9-v6so2958558pgv.6;
        Sun, 11 Nov 2018 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PRf7z7k4H3u/80vGr+6Juj0XSbyDAgj1V+a41DJR3uc=;
        b=ASZndUdtITtui2UEp3e0mIjm9r/nmy6PRQPRrt2y+/gIG30Llzmx41IT2xJSOXMjAA
         tb+EBlbB0mrcm5Zn/chJ3fd0zELJ+Ydig5saneuof1gdP0b+Tk3rYDq2HXrKSLCsyIAX
         SnYQuQaNbfLnBcp/2PKbaqdlwT3LIYr2IrB63lYtxx/WG/3728pNE9xVnEBxET6sIL4d
         UtCeoz6LMZiidE74A7fJRxxoYL3ZzuCOltiJoTXWZyhhgG596I1tu1mGLnOOEf9V+jrG
         6Xk0bdBT35/CttrDahGRs0YvjOVsXGjWwbrwK6JbqpjXv/avQ/t1QabP/QhWpEgyfb5U
         RK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PRf7z7k4H3u/80vGr+6Juj0XSbyDAgj1V+a41DJR3uc=;
        b=ZP1Yj5ZgY9mUEUr0BK8ymNbCGOHRWoNapwFZiIccoq/yhsnimhjJ6MiUFQreIpabxu
         0f0c8E6Zn6ZzbAlhr0/7JmoaoSWnE/xKo1J5isgLjOyaC7YgAJgZCVVZMBrnWavqH4v1
         19NZ2bmqUFyFA8wpXc+q6VyfwAiPtGMdDz3B8XTfke6qTLwx3Y+/LQZ3GsNovp9KmGpO
         axuCaTeI0XVno/439Ln2clgeixYnzRoR1N1NnF8C0gcCwjOgYpamMchweaKVdeRIa4VZ
         P+mUxKMl4mjuSxRC0cDKO707oyb0rsKxYgr/VjLeLBGs2D+U+ERfNi8YtsRQckRe4OIC
         NC9Q==
X-Gm-Message-State: AGRZ1gJhwHif/bFGTOwX7ez7D2dnFLdMhhY4kOtfYlhK3oXxsDWPOviz
        MM9oF/i+IKigONCFO3sK9eA=
X-Google-Smtp-Source: AJdET5eONr85r8wx6N4/uBBh9ZsiSTPEt/5zNqDRlvxCWa5qqzzQ+FSnH8qZr4qRbYhDy4NC6+V6Vw==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr14390420pge.130.1541956148483;
        Sun, 11 Nov 2018 09:09:08 -0800 (PST)
Received: from suraj-Inspiron-5370.nitk.ac.in ([2409:4071:211d:4f4e:7113:63cc:bfdb:2c04])
        by smtp.gmail.com with ESMTPSA id p69-v6sm6792831pfi.85.2018.11.11.09.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 09:09:07 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        suraj1998@gmail.com
Subject: Re: net: ipv4: tcp_vegas
Date:   Sun, 11 Nov 2018 22:38:54 +0530
Message-Id: <1541956134-14029-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20181108.103428.494936194513918478.davem@davemloft.net>
References: <20181108.103428.494936194513918478.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think you've been getting my emails because I've been sending them
in response to the message-id of my patch. 
Here's my last one:

I'm sorry if I have seemed unresponsive to you but it took me a 
while to figure out how to respond to threads using the corresponding mail
-id. I think the first two comments that you wrote on my initial patch with 
message-id: 1541425985-31869-1-git-send-email-suraj1998@gmail.com were being
redirected to my spam folder and since I didn't have mutt configured
then, I didn't see them, 

The reason I've been prefixing all the subject of my mails with "staging: "
is because I was following Greg Kroah-Hartman's YouTube video on how to 
submit your first kernel patch. I didn't realise the significance
of usingit and didn't take the time out to understand what it really meant and that
is my bad. I've got clarifications for the same in comments to the patch with 
message-id: trinity-0d747914-3749-46c4-a5e8-fb7141a9b7c2-1541672570683@3c-app-gmx-bs57

Other than unwarranted "staging: " in the subject, are there any other changes
that need to be made before I submit [v3] of the second tcp_westwood patch
(1541670377-17483-1-git-send-email-suraj1998@gmail.com)? 


On Thu, Nov 08, 2018 at 10:34:28AM -0800, David Miller wrote:
> From: Suraj Singh <suraj1998@gmail.com>
> Date: Thu,  8 Nov 2018 13:59:52 +0530
>
> > Fixed checks and warnings in TCP Vegas
> >
> > Signed-off-by: Suraj Singh <suraj1998@gmail.com>
>
> Once again, please explain why you are putting "staging: " into the subject
> line of your TCP congestion control patches.
>
> If you do not answer this question and fix your Subject lines, I will
> really have no choice but to ignore your submissions as you are
> ignoring our feedback.
>
> Thank you.
