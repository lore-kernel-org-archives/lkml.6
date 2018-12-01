Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF58C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58B920673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEFY28lc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58B920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeLBDAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:00:47 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLBDAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:00:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so1729322wmh.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7VsEOr6WXo8MtKSe6YFHkh0W0DTd5dOlnHo+96RQq1c=;
        b=lEFY28lc8hxycIhp3OrDbCQuvpSF23vSZzbYVLs2G6G6jngyKztDY9lCIjvutZUffp
         8g3Dt3/H+dWYDgWrDApFjv+jcfqqZtWJOsb99uLMrzgaU7E1N+yoQ/fjdwxLut63ggrC
         XT5NCV8VA7Vh8NEYqrOjE4mY2Aci/9pVWL1BctIVNh3okmiMQMlLbXcEIaKvV26mbIRF
         3PuJlWosIT+Re5cqoqsDRRYZVbcIJLbfArjsopXM3HgEI3zupnad1SdFp5UqYxcsLBIZ
         oD1pmT7jljeyxXTX8qxw4TmmlWWj/nGS58+RI4TOu6b0WgWkHqkC50IRd5xwq1cAV+Wz
         ZCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7VsEOr6WXo8MtKSe6YFHkh0W0DTd5dOlnHo+96RQq1c=;
        b=KTnZ2XTd6fkbEjmWrh1omzPq14pXbAn99nez2ARMsItFi0QiysPszYpCvnO9Y1kbFE
         2e5FB4L3eTtXzlfOThlmLfI68G7R7/HXUAXq8N3QF63T5qdVCPsCiqZOA4CVzooCqXUI
         SEz7DykDFew/1DceBqH5iWKgEgqreFu9h/vGMfNe/KQtUEwCJ5zkKRNnMvKGJ/pTpyFg
         r16DbmXjh+mDxrvUbdiKb5OesupNXnwGus3SyivEQB+xcJ9qgBerqxp1Pgm8Y7/pUf4O
         dRqmqnzBaFXLlNFjUDmm9Y5QsXYa9gxqOI6kTCXZrsOMCDFJsd9bbh1YQfLRUEhYk0k6
         H1fA==
X-Gm-Message-State: AA+aEWb2IJ/GIqwjDvhFbWIQTJYIj3lYmVGEuXJGYPtbCCUOcH3X7N8O
        cObLMOPW+oJ8k7OsP8fJm9dYk5+x6JWELCU12vTjSgpI
X-Google-Smtp-Source: AFSGD/UzIokKM9+fZSpXAKN9LiMFjjiS9F2Qjl6f3T1t7WwzR9ugtrzQ2+8gEykjn9hxu5pFxY3o0b7Bki/BJ16c4+0=
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr2517745wma.57.1543679277683;
 Sat, 01 Dec 2018 07:47:57 -0800 (PST)
MIME-Version: 1.0
Reply-To: huangyan1987@gmail.com
From:   Huang Yan <huangyan1987@gmail.com>
Date:   Sat, 1 Dec 2018 16:47:20 +0100
Message-ID: <CAK7X-Hd1jX614Gc80j0mY6G-_JZdLBRbBAT3eMyOmfYc+GmAHQ@mail.gmail.com>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 23:15:55 -0500, Theodore Y. Ts'o wrote:
> I'm trying to figure out common factors from those people who are
> reporting problems.

Hello, I experienced the ext4-randomly-switching-to-read-only issue
with Linux kernel 4.19.5 (from
http://kernel.ubuntu.com/~kernel-ppa/mainline/ ; also with the
previous minor versions) on Ubuntu 18.04 - on two laptops (SATA HDD &
SATA SSD).

I noticed that the only thing I've changed from the default Ubuntu
configuration was enabling *write cache* for the disk with the ext4
root partition. Perhaps this information will help.

Best regards,
Yan Huang (Johnny)
