Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE045C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81CDA20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 16:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BBG9qBv/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CDA20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJNXzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:55:55 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43275 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbeJNXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:55:55 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so8443341pff.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zRcH3T8yUdTcbDhY24LHGx3ONrET9UkNditmuRsltOE=;
        b=BBG9qBv/tcoQ26I0zl3H97IoGj/ctm+0ya7mdTaGgGH4YVDvw9oTc+vWf8B4+P5+e2
         VkGp0LKUsM/HsUM1hXvYjluM1xKdmQZIF1JctEtAVQEn4JDCPQ8XOCWrTandXToz5CYZ
         PWGJG7O+mLYq9u+313Hmg7iAtnGfEFMk/Jwc/5DCHiqU4SuzcX0q8ZbeOTIdQ3Y6rsBW
         LmwOa+q4RhZZ7dUaTxeJM/s9SPJCiTUpnqavspWMR5CvaHLgyQcq2gndSOuvMXE3T6sT
         KzdIVA0gCWT6CCMCmGiOn+usqBymf5nNojxzFjKHtKwQJUOjOmbYszHOgv+DhHlrwnVg
         89Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zRcH3T8yUdTcbDhY24LHGx3ONrET9UkNditmuRsltOE=;
        b=kCzpioGM3am7gNf8mxS9KTebr4FaeYoCNEtFLml9WLdi1kMlR7fGcD62z7skgn69iu
         SXZuEjeZRcaP4GSiyg5IdN5uTPG/sxiVp+FN3mzbURIO61jP1LQrUqqIQ4crp6BxC/1/
         /YexpYeEzIqQ+BW1wCfF5PLAC8LcTA+4A1VMa3aAza10p4prQbYh3S62hFIuFv8Pv1hN
         AY+LrV3PmzVH4KdatF0mZ9kKfvNoy9dUFWR70HoIby7ClQYGQFcmiwcwqyH3FgD4PV5q
         EdbUuNrFffJYGUG1EKgQH4IWc4iIUIdZqubq6y2G421YN0SEJRg29LtNyQA77SJBFTB9
         r5rQ==
X-Gm-Message-State: ABuFfoho9NynwJqs8FZqUQq79uTEE1JqhwTSTD5uJP+SgzwPqBo5YBNV
        dLW9MSOh5v48VT7XjtQSAa+wEQ==
X-Google-Smtp-Source: ACcGV62apI7MsQ/rH8gHFhcPoboplgyeF8f+KJSc3ABzrk5x0d73PzXHYzdI16sO5Kgo5yMkf1V8JQ==
X-Received: by 2002:a63:d805:: with SMTP id b5-v6mr12660987pgh.174.1539533663792;
        Sun, 14 Oct 2018 09:14:23 -0700 (PDT)
Received: from ?IPv6:2600:1010:b023:6e7d:b96b:7246:35a9:32? ([2600:1010:b023:6e7d:b96b:7246:35a9:32])
        by smtp.gmail.com with ESMTPSA id j19-v6sm8834081pfi.137.2018.10.14.09.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 09:14:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [tip:x86/urgent] x86/entry: Add some paranoid entry/exit CR3 handling comments
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <tip-16561f27f94e6193ee8f5b9b74801e1668c86efc@git.kernel.org>
Date:   Sun, 14 Oct 2018 09:14:20 -0700
Cc:     linux-tip-commits@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6985DE9A-63DB-4348-B46F-92BE1240C9D6@amacapital.net>
References: <20181012232118.3EAAE77B@viggo.jf.intel.com> <tip-16561f27f94e6193ee8f5b9b74801e1668c86efc@git.kernel.org>
To:     hpa@zytor.com, dave.hansen@linux.intel.com, mingo@kernel.org,
        luto@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 14, 2018, at 2:17 AM, tip-bot for Dave Hansen <tipbot@zytor.com> wr=
ote:
>=20
> Commit-ID:  16561f27f94e6193ee8f5b9b74801e1668c86efc
> Gitweb:     https://git.kernel.org/tip/16561f27f94e6193ee8f5b9b74801e1668c=
86efc
> Author:     Dave Hansen <dave.hansen@linux.intel.com>
> AuthorDate: Fri, 12 Oct 2018 16:21:18 -0700
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Sun, 14 Oct 2018 11:11:22 +0200
>=20
> x86/entry: Add some paranoid entry/exit CR3 handling comments

Phooey. I *typed* some comments but didn=E2=80=99t hit send.  I=E2=80=99ll s=
end a follow up patch.

