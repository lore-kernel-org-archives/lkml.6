Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4064C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA68B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 03:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="nkaRdhFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfAWDmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 22:42:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46889 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfAWDmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 22:42:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so435662pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 19:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xybafmEsDXnt6PdFHkdWmXHf3WlFnZSPS+PNMKV4Wco=;
        b=nkaRdhFlbCQJY5bRzFjLTnxpH1OYyDRpxp6J1KpNx/GJ+O+xf1Y7mFluZJGFzb1+Y9
         FT+cfdSKFdqAenCdbLCkw9xTEpelu6+VBlLHOR7z5HpKQUUBsDC/pnawLvJ8qO0dHfIo
         knG15j0yGN+Tg4MZZ8odAYcSTYkl+m3BvMfbbqvugeZ6lj9xR7+4FNr6Zvq2hTylIid6
         8tf0GUrQ97OJ4FkDocZFPXdvgXYqVzwFkAYsEfLRM3+2haIox5lMmkyGj69TG5+nOgEm
         uRDHYq3nAY4LPPMnTek7pZinCxUGG3hlc/VzJMAUsfYyEc09XhEiON4E4U+UFGRQ9VzT
         L07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xybafmEsDXnt6PdFHkdWmXHf3WlFnZSPS+PNMKV4Wco=;
        b=W9TESHwC6oNTNhP0ts5X5IrfIg74lEnZ7g//73kmEzKZKCZO5JIYeSFMMqHSWjaoU9
         hnFPhvfE0kAx+KaBuW4dZHITpWxyytwee/m4yAOfRmAT2klIkn0ooS1+FeXnLwEmzjKM
         yH/dlgW9DrY0doc9B6dUT+DzfRuRirLQ/Oa+/T9YoTcUBtw00kbjKSzfaAz6gy31gz+i
         oRyI31e0em9K/pu7wnLENf+mSxF14MXriNj079Va1q4R+VmEtg+BBMaMYLHoDm5RjBS3
         GWrtS160Pvj3X05/GzbunUOMrZ5rJo0tvTUbecs6rk+gTlpxI9HQDGpBAuK0byPK/IB3
         qU8w==
X-Gm-Message-State: AJcUukd+ev1XYdSp6H3TRUjbYCp+1yMzo7JRvlIh9TfoAC6OvH4Wkufv
        SbZjpybY4hByIHoufMhxanjESA==
X-Google-Smtp-Source: ALg8bN7hwhdtojexm3Cqt7r21toP2jYgVe7YRa2EhdOFg5MMrE6vBisMTrAkhO02HhCGE9RzywcFjQ==
X-Received: by 2002:a63:1a0c:: with SMTP id a12mr561314pga.157.1548214957947;
        Tue, 22 Jan 2019 19:42:37 -0800 (PST)
Received: from [192.168.0.120] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id g185sm20678636pfc.174.2019.01.22.19.42.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 19:42:37 -0800 (PST)
Subject: Re: [PATCH v2 0/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James.Bottomley@HansenPartnership.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        hch@infradead.org, colin.king@canonical.com
In-Reply-To: <yq136pkm6x7.fsf@oracle.com>
References: <1547779645.4532.9.camel@Centos6.3-64>
         <yq136pkm6x7.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 23 Jan 2019 11:42:34 +0800
Message-ID: <1548214954.4412.16.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-22 at 21:41 -0500, Martin K. Petersen wrote:
> Ching,
> 
> > This patch series are against to mkp's 5.1/scsi-queue.
> 
> Applied to 5.1/scsi-queue. Thank you.
> 
> PS. Your file permissions are odd. I always have to change your diffs
> from 755 to 644 before applying.
> 
Thanks Martin and Dan's help.

The file permission problem also confused to me.
I used Evolution mail of CentOS 6.x to submit the patches.
The mail context format is Plain text, preformatted.
I inserted the diff text file to the mail, and diff file listing as below.

-rw-r--r--. 1 root root 1663 Jan 16 04:11 p1.txt

Don't know why and when it's permission changed from 644 to 755.

