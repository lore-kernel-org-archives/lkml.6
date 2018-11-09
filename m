Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FDC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143D920825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlgjF6ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143D920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeKIV6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:58:47 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:45411 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIV6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:58:47 -0500
Received: by mail-pg1-f170.google.com with SMTP id y4so776386pgc.12;
        Fri, 09 Nov 2018 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2j7PfuQgbZ58588hn2iU83YD9edHxteeT4rq6HCABZ0=;
        b=GlgjF6bahBXm81mDj2MdXYEU/6bv4x2or1tZ3gJkYgKUrcIr6AMwPu5Jbrmyo6PlPR
         kuw7MXX9n8XHSn2cv5wc3H0aYSRnMIlX2k1cE1gQkpKt8OHSN7AyllxxfZ3wWo2Eklr6
         jdPxJqQI2i/9xMESEvkY3Ws/1bSmS9Fctpd1MgiL6oXrjhNMmbC9nPT0SHbOz9CmrNsp
         vxkCuLAxCJR/0DNNQVHvmX9hClCR5LzQAH0ztzJgkfksR0zTsVVAeUym4Cz7ayUUgRTY
         V4E24IULms43sNr0+O+IvBSogJD1oZ4LLKsfNDhVGuCpEQRPca7P+X89snSoXJM6eqfS
         eiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2j7PfuQgbZ58588hn2iU83YD9edHxteeT4rq6HCABZ0=;
        b=mpdIx8CAT+HQ0laD4CNbZQM6NzXL5UZwAkEWbdtTrNDHJkRHLSZIsYPmnKI9eZ/4nl
         9lcq+Qg/CKmsfyOf5VYElhQAxjx3dP/h+irZDdeKUs0W1meg72BbsF7pshkkTNCGVp8Q
         Dqlb+bosb/tZCBFghw2w9Sj7vLsjJJd4eERzgIOnykp+WRp5eNltbsHUAQ4Dk7CyyTxh
         QknQsxcxCB7Z3KC0VvKtIV6AeobT907VFReoBT3Sgc05QDlTncLP82obh+ycV9HM72sY
         IFGk22XFWVyCPycCsxSGKYQ0nyHzwuh0xnNnTx//jlp8HIgXeJyaOuhVfQWwXKx/2geA
         onqQ==
X-Gm-Message-State: AGRZ1gKkilLjxL505NZ9wo4iaNysKHgSqklrtv6zWI7HI7hh8JLO7Sb1
        VWUaGGmQJG8nrE+i8n5VRKI=
X-Google-Smtp-Source: AJdET5eiPC559jKPulkrgJ74F9kMUZghAZ4/iY82arGbOnC6XWGvqLlr+khyiOVzqRLurKCRxuW6+g==
X-Received: by 2002:a63:f241:: with SMTP id d1mr7325520pgk.2.1541765904420;
        Fri, 09 Nov 2018 04:18:24 -0800 (PST)
Received: from suraj-Inspiron-5370.nitk.ac.in ([2409:4071:211d:4f4e:b056:9584:f527:78d6])
        by smtp.gmail.com with ESMTPSA id 18sm5490752pgl.50.2018.11.09.04.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Nov 2018 04:18:23 -0800 (PST)
From:   Suraj Singh <suraj1998@gmail.com>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        suraj1998@gmail.com, LinoSanfilippo@gmx.de
Subject: Re: net: ipv4: tcp_westwood
Date:   Fri,  9 Nov 2018 17:48:07 +0530
Message-Id: <1541765887-2923-1-git-send-email-suraj1998@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541670377-17483-1-git-send-email-suraj1998@gmail.com>
References: <1541670377-17483-1-git-send-email-suraj1998@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lino,

Thank you for clarifying the doubts I had and for the suggestion on where to
start contributing. Previously, and in this patch  I hadn't configured mutt 
and was manually using git send-mail to respond to each thread using the 
corresponding mail-id. That's why I wasn't sure why even in this patch, 
"staging: " had appeared even after editing the commit message. Now that I've 
got the email client setup, I'll fix that "staging: " issue and send a [v3] 
patch.
